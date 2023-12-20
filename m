Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1457AC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A2C10E597;
	Wed, 20 Dec 2023 16:04:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB2610E0E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhwDotazlapiVFtgXaDLHPuswZbdMdwWSXIZGm1QuC67Pqp8yk3uCdww8zat1V2GldAkKCToMoPQXxuZBn2ye6VqsQ1jJ6XkszC69rZyEpNTeEcuz3CPbIaDLTL+ROK4dO6WkP3r2xOy4k7bO6Ma/AvhyG8YiZgzK/A+u+klt1YMlfuqagAnOYebddet+9gBGA1W0uDp+p7zuLv2jbqHa5soPl/tH6a4gCi1cjpdHV4P5WLgvHgGykQae9uVymqOBrAHLpbmOjM81M6jG4kGidm4+4fZuZqRjVGV4mXpWe0vSMp4fMEC771SbYAsBK8i0LzvlZ1MF9/ULXwepKtq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nB32Gckv59UqOafEw3DPNkCoMzHfd4E325MimIwmtY=;
 b=gNORVwT4DTERXzJa2bZwCxVLt3KWpoa4borOZ5BlfGIgnrX3LRXGlBx6RnDGfjIVgeuDIz10tXIvGGIq4u4DQkpdEBGxyjponOO1Cf5aQ2176zzipVv+hqujTeOXLFc6z28NesatiSeVYczJnsEZmnaLqpL9HCppxvajaJY/6mFqdqWSV5LZweEsyylYfjNfYpMOS0N4cjvoGMku9yJT5Wwa0yMXy/U3+bS7w7P410lyPrNgE4O+0R+6AIM2ehP4zBVIeHyWv0rVN5Osj1h36Yq2flbj43/bGM1IIGYCZ7UMDpOxd3jvWYmsp5jslRbgOjCoX5snnj4kjitczwQTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nB32Gckv59UqOafEw3DPNkCoMzHfd4E325MimIwmtY=;
 b=eVmDqL1OJyeXmEFUjtZcTVY4tHCPRpdaAcOt/hL27EkgRewi+TqXkzvyANk1GVorJ7p9rpLVG4Rje8SXhSpzkJi7lUWszFD2klWO1+hCsELFhblPVBn1yaD6w46SGzrN3eZkmDbkDnlDnESWDPHpVhyhhxZ5iqC7Y5h14Iyf4/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Wed, 20 Dec
 2023 16:04:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 16:04:47 +0000
Content-Type: multipart/alternative;
 boundary="------------CQ05OTQ0tOCZDaQ6xzMJ0EJX"
Message-ID: <2651d9c4-edb2-4cef-a004-6e7ce77a5a85@amd.com>
Date: Wed, 20 Dec 2023 11:04:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Auto-validate DMABuf imports in
 compute VMs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231214223001.218746-1-Felix.Kuehling@amd.com>
 <fe14d738-ab23-460f-ac44-2090ef9ab4c5@gmail.com>
 <3bce0db8-9da0-4f6e-a941-e5531518c908@amd.com>
 <346c1009-2930-4424-9cd4-589e5872877e@amd.com>
 <f37e19fe-4fc9-4580-9961-ccdcf7f9b35a@amd.com>
 <db8e0eee-1f43-472f-b1dc-138240fbf4af@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <db8e0eee-1f43-472f-b1dc-138240fbf4af@gmail.com>
X-ClientProxiedBy: YQZPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: f84da805-edde-4f13-ca48-08dc01756363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52LDxcuQ2PxoDzbBsF2oh9dXzifcO7MHDw0NqOYJhX82HlUqtzj6jGw/5kDnEW5Zu7lmHSNK2J6lF98b1EHHJQVIWyWn0e81pwZAWqMZMQ5uRl4CBg/4jKF7taxVQmc9PPLTnQzOObZAbartC8uysfrJDmjHu7uhjQCZvrfcL6oyi3iOq0cRdUi2Zx2vQUuFy3k5L9t+PO4UEZgaYgqKX/GHXLNxNUJtMm+MTQe0EheS+1EJtvAIzQdJjt4T1Hws6wPXKUWr4MMnOtYfrx7qs7OGUNDVKU58r3PdZpNGlo+t1FuVdj6AC7wJUvuLZxROJLyavdfNma50xseso+rQYS/o3Cp34xkDT6TdhZdSdaGBh4jVRmyXO3UqNqjRufDTcXwfTxiqdlq5Ithn33TqmGPEW5MQxIdtWXLeVm1lvy3Bvdp69jMfzRsttqgjWXtbf90wTjMT3hxWa5ihAbTJPikwcPjFRiOM+/Waf00mO7Mt62GOGVPTSedRfCj07qYJvESzICSiFd2ISYuALf7pbeb9drBvgl2l8qQZwsnVhhadXzgdGvUF74/T9nZTjxScbw3ktq79ZFEiccB3aGMVDN2JUnfV3PUxU7cY1ld6vHeUXbt/rxQaJpIG51E71ZT7sUfTRf5FYpYMxxPrN3RZSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(36756003)(83380400001)(316002)(31696002)(66946007)(110136005)(66574015)(66556008)(66476007)(15650500001)(4326008)(6666004)(44832011)(6512007)(8936002)(4001150100001)(8676002)(5660300002)(53546011)(2906002)(33964004)(38100700002)(6486002)(26005)(2616005)(478600001)(31686004)(86362001)(41300700001)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXprbnlIVHBNV0NSVGNZZXRqclFaelhIYmI3alVqMFQ4VHdIRjN3V3lPMmhk?=
 =?utf-8?B?QzQ4L0Jwb1poNU5VZDVNSTBUMUdndlp3ZUxicXZSb2E2TXpsWTVDSWhMY0NU?=
 =?utf-8?B?Q1FBRktJZ3NqcHVIWm4yZjZjd1BLVjhnTVB4MDZTRTBkNk96VUpPOHVQYWNa?=
 =?utf-8?B?RE9HVGZERExuZVJ4dml4MVEzVkdaL2VCUmM3d2tqNFlhempaRThkS0Z1dU5u?=
 =?utf-8?B?L2d0Tis4T0tFL0dRZFhzT1V6ZlN0OFJ0dUtsRllnQ0lST25KOTc1aDBYbkVG?=
 =?utf-8?B?MW9aS0oxMnc1NmtaakZNd2h1NVdUUW43Nzg1U1BnZGd6eW5lUFZMaTRHOGlN?=
 =?utf-8?B?T08yTGllUWVSaTRsRy9mYVFPR2c3cEY5dzhhUW5HanRxa0lIQjF2bzNyMjJ4?=
 =?utf-8?B?S0I4WmsxWTNhNmlyVy9kaUZ3VlE1MjE0OXdLemVtNXVGR1BTdXFWTzNiS2o5?=
 =?utf-8?B?M3cvbkNnK0R6REx5N2NuTG1zVkZNdEh5b0t6M3VSMlRuMlpVb2wvMzAzY3dR?=
 =?utf-8?B?MWdhS2hjMWFFZ0tHTDRSY2lQSFhaTEYxeXNGbW1veVczTTVMYjdydmRpcnVr?=
 =?utf-8?B?UHZrbHVHbXdmbTZoUStMLzNQbnZhcGgxRVo2b3lvb2U2QUxva2xoRmM0SDVN?=
 =?utf-8?B?S0NGc3lhSWRxQWk0THV3RE5ZUXB1ZkJXN3FLbEtnMDM0TDFTcmZCN3BBUW5y?=
 =?utf-8?B?elFLVTkvOW5JTHNTejd4dnFBR3hhR1h5c3M2RTBCSWlENmJiZXdWQW0rOVlj?=
 =?utf-8?B?cy9qVTBta0lsb3huMTZZcGJIczQweWNiTXA5R1RZNkdxZUdnMGpSajBaWWFT?=
 =?utf-8?B?SmRVdHBMS1VOeVpnUURTeUYxSnVYNlY3QkVyWlV2R1NTVHJjeTl5Z0NDZGZv?=
 =?utf-8?B?TW5JOXJUZFZWUVRwR3BHSHFTdVBPQTlNT1JRNWQvNGxQeU5INm4rTjBKUzZ5?=
 =?utf-8?B?OVE3ekJpYXE3VHM1U2NqejFPTUFDRHZkbFRRdVkwK0ZObFk0cm9QdDc1OVhO?=
 =?utf-8?B?ak1LVVJvWUJsNElHcHhRVlI5YUdtcDd6WEZubjhaKytLR0pWVjUxWmxOb2k2?=
 =?utf-8?B?T1E5cVovVkFzR3ovT0liZGJRc2dNeTZicWx0cWFKMjNrZHduZTlMYWdOMzcy?=
 =?utf-8?B?T2hidmpRSnFhaFpnU21ock41MHdxODFTdFpSSUZUK1lvMDdnMUpqNDh3MHly?=
 =?utf-8?B?R2tjVFdVNXBrSUk5US9aZks1VVl0ZjBUaW50VmxtR2IvSTRxYzliL09lQm93?=
 =?utf-8?B?QVZxRDcxOW9VWGJNczgvcS9JQ0FQclBlTlNGSmNHTlJ2Um1DdjRaT3BZck5F?=
 =?utf-8?B?VFE5NFZkRDNraExmczE4RkplR3A0LzNRM3JzRTZBdDFoZXVHTHhmMkVLZkhF?=
 =?utf-8?B?SVh3L3ExQW9ZWm55WXZHWDJHcG9zZ2NGd1dXY1lHanlIU3ZUTFdLTEJNcWlk?=
 =?utf-8?B?QkZ6ZEhMdG1GdEU4NUxtK0JtUGhmSDZ1ODUyWVJlZmtOdG84OXBBUGhMRFlk?=
 =?utf-8?B?emNUeWMzNVlXMGVBTmVLMG1GSXpQOHhuUTlMbkNJcTBlWGY4R2w0UXBKZjVn?=
 =?utf-8?B?WFBOVS84NFNOV2NkS3JqY2QvRUFzREJwajUybjlVTXB1UG5GZ1RVU1d3cndz?=
 =?utf-8?B?SVVRVEFUNTZ2UEllN1ZKTHNDTVRZZHM3MGtBaEdCdUtSNExjWnRReUZhd3Fw?=
 =?utf-8?B?c1czL29pRXgxU2kxUWNwZ3pHdy9DUU9NTXhiMldzN1l4SUVLQnF0K0piOEcv?=
 =?utf-8?B?R2VXcGZpSllNT011ZzVtN0J1OTFac0IzR3BFVUpHQm9VWkNvaCtBakFvNlEv?=
 =?utf-8?B?SXltUUF4RVJpZXAydnVIYUdQb2xRSU03VFo2Wkp0dng5THV5S2tNa3lHWmRQ?=
 =?utf-8?B?dHc1VHZ4Qm1EeU5xV1JCbTZHbFVsbHU4UU5PQ0tncVdUcEdTNVlzTjdQdjlo?=
 =?utf-8?B?V1dkR3YydDYydnlsQ20vWDFHd1N2V2dESzlWMVlWU0hGOFJ2cFNKdlIrVVhU?=
 =?utf-8?B?cDV0V0R6WDZobGtmNDZnRmd1RjVueFhIRlRWdGJKRHdUVHZOTVB1ZFRCZFpS?=
 =?utf-8?B?OG1SWkRKWkoxUzBSL2NHSHNRWGJlY3cxUEluY2dmKzY3WjBwTUNXUlBGclNE?=
 =?utf-8?Q?MPe5lmXgxW095HU5k0GUoEPgv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84da805-edde-4f13-ca48-08dc01756363
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:04:47.1799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJl82aDPnjGfLzMNVSa/65fUF1PMMffshv0Lw7SJCconhi6NtvjhfIY3HtY+1yZvmPw1O8TcX5OkEHfnFB0HCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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

--------------CQ05OTQ0tOCZDaQ6xzMJ0EJX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-12-20 8:58, Christian König wrote:
> Am 19.12.23 um 23:43 schrieb Felix Kuehling:
>> On 2023-12-19 3:10, Christian König wrote:
>>> Am 15.12.23 um 16:19 schrieb Felix Kuehling:
>>>>
>>>> On 2023-12-15 07:30, Christian König wrote:
>>>>>> @@ -1425,11 +1451,21 @@ int amdgpu_vm_handle_moved(struct 
>>>>>> amdgpu_device *adev,
>>>>>>           }
>>>>>>             r = amdgpu_vm_bo_update(adev, bo_va, clear);
>>>>>> -        if (r)
>>>>>> -            return r;
>>>>>>             if (unlock)
>>>>>>               dma_resv_unlock(resv);
>>>>>> +        if (r)
>>>>>> +            return r;
>>>>>> +
>>>>>> +        /* Remember evicted DMABuf imports in compute VMs for later
>>>>>> +         * validation
>>>>>> +         */
>>>>>> +        if (vm->is_compute_context && bo_va->base.bo &&
>>>>>> + bo_va->base.bo->tbo.base.import_attach &&
>>>>>> +            (!bo_va->base.bo->tbo.resource ||
>>>>>> + bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>>>>>> +            amdgpu_vm_bo_evicted(&bo_va->base);
>>>>>> +
>>>>>
>>>>> The change looks mostly good now. Just one thing which worries me 
>>>>> is that when GFX and compute is mixed in the same VM this here 
>>>>> might cause problems when we run into an error during command 
>>>>> submission.
>>>>>
>>>>> E.g. GFX validates the VM BOs, but then the IOCTL fails before 
>>>>> calling amdgpu_vm_handle_moved().
>>>>>
>>>>> In this case the DMA-buf wouldn't be validated any more.
>>>>
>>>> This code path shouldn't be relevant for command submission, but 
>>>> for the amdgpu_vm_handle_moved call in amdgpu_dma_buf_move_notify. 
>>>> That's where the BO is first found to be evicted and its PTEs 
>>>> invalidated. That's where we need to remember it so it can be 
>>>> validated in the next call to amdgpu_vm_validate.
>>>>
>>>> Currently the amdgpu_cs code path calls amdgpu_vm_validate with 
>>>> ticket=NULL, so it won't validate these imports. The only place 
>>>> that auto-validates evicted imports is 
>>>> amdgpu_amdkfd_restore_process_bos. So none of this should affect 
>>>> amdgpu_cs command submission.
>>>
>>> Yeah, but ticket=NULL will result in removing those imports from the 
>>> validation list.
>>
>> I have a comment for that in amdgpu_vm_validate:
>>
>>                          if (!ticket) {
>>                                  /* We need to move the BO out of the evicted
>>                                   * list to avoid an infinite loop. It will be
>>                                   * moved back to evicted in the next
>>                                   * amdgpu_vm_handle_moved.
>>                                   */
>>                                  amdgpu_vm_bo_invalidated(bo_base);
>>                                  spin_lock(&vm->status_lock);
>>                                  continue;
>>                          }
>>
>> The net result is that the BO is still tracked as evicted.
>>
>
> Yeah, that's exactly what I mean:
>
> What happens if amdgpu_vm_validate() is called, removes the BOs from 
> the evicted list, but then an error happens (or just an interrupted 
> system call) and amdgpu_vm_handle_moved is never called?
>
> In this case the DMA-bufs would be on the moved list and 
> amdgpu_vm_handle moved would have to be called once before we can 
> validate them again.

And that would be a good argument for tracking evicted user BOs with a 
separate state after all. That way we could just leave that list alone 
if ticket==NULL in amdgpu_vm_validate.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>>> This could potentially result in not validating them should we ever 
>>> mix GFX and Compute submissions in the same VM.
>>
>> My eviction test does exactly this, and it's working just fine.
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> For now that works, but we need to clean that up more thoughtfully I 
>>> think.
>>>
>>> Christian.
>>>
>>>>
>>>>
>>>> The flow for amdgpu_amdkfd_restore_process_bos is:
>>>>
>>>>  * amdgpu_vm_validate validates the evicted dmabuf imports (moves the
>>>>    bo_vas from "evicted" to "invalidated")
>>>>  * amdgpu_vm_handle_moved iterates over invalidated bo_vas and updates
>>>>    the PTEs with valid entries (moves the bo_vas to "done")
>>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian. 
>>>
>
--------------CQ05OTQ0tOCZDaQ6xzMJ0EJX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-12-20 8:58, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:db8e0eee-1f43-472f-b1dc-138240fbf4af@gmail.com">
      
      Am 19.12.23 um 23:43 schrieb Felix Kuehling:<br>
      <blockquote type="cite" cite="mid:f37e19fe-4fc9-4580-9961-ccdcf7f9b35a@amd.com"> On
        2023-12-19 3:10, Christian König wrote:
        <blockquote type="cite" cite="mid:346c1009-2930-4424-9cd4-589e5872877e@amd.com">Am
          15.12.23 um 16:19 schrieb Felix Kuehling: <br>
          <blockquote type="cite"> <br>
            On 2023-12-15 07:30, Christian König wrote: <br>
            <blockquote type="cite">
              <blockquote type="cite">@@ -1425,11 +1451,21 @@ int
                amdgpu_vm_handle_moved(struct amdgpu_device *adev, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update(adev, bo_va, clear);
                <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
                &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlock) <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_unlock(resv); <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
                + <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Remember evicted DMABuf imports in compute
                VMs for later <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * validation <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;is_compute_context &amp;&amp;
                bo_va-&gt;base.bo &amp;&amp; <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                bo_va-&gt;base.bo-&gt;tbo.base.import_attach &amp;&amp;
                <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!bo_va-&gt;base.bo-&gt;tbo.resource || <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                bo_va-&gt;base.bo-&gt;tbo.resource-&gt;mem_type ==
                TTM_PL_SYSTEM)) <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_evicted(&amp;bo_va-&gt;base);
                <br>
                + <br>
              </blockquote>
              <br>
              The change looks mostly good now. Just one thing which
              worries me is that when GFX and compute is mixed in the
              same VM this here might cause problems when we run into an
              error during command submission. <br>
              <br>
              E.g. GFX validates the VM BOs, but then the IOCTL fails
              before calling amdgpu_vm_handle_moved(). <br>
              <br>
              In this case the DMA-buf wouldn't be validated any more. <br>
            </blockquote>
            <br>
            This code path shouldn't be relevant for command submission,
            but for the amdgpu_vm_handle_moved call in
            amdgpu_dma_buf_move_notify. That's where the BO is first
            found to be evicted and its PTEs invalidated. That's where
            we need to remember it so it can be validated in the next
            call to amdgpu_vm_validate. <br>
            <br>
            Currently the amdgpu_cs code path calls amdgpu_vm_validate
            with ticket=NULL, so it won't validate these imports. The
            only place that auto-validates evicted imports is
            amdgpu_amdkfd_restore_process_bos. So none of this should
            affect amdgpu_cs command submission. <br>
          </blockquote>
          <br>
          Yeah, but ticket=NULL will result in removing those imports
          from the validation list.</blockquote>
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
      </blockquote>
      <br>
      Yeah, that's exactly what I mean:<br>
      <br>
      What happens if amdgpu_vm_validate() is called, removes the BOs
      from the evicted list, but then an error happens (or just an
      interrupted system call) and amdgpu_vm_handle_moved is never
      called?<br>
      <br>
      In this case the DMA-bufs would be on the moved list and
      amdgpu_vm_handle moved would have to be called once before we can
      validate them again.<br>
    </blockquote>
    <p>And that would be a good argument for tracking evicted user BOs
      with a separate state after all. That way we could just leave that
      list alone if ticket==NULL in amdgpu_vm_validate.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:db8e0eee-1f43-472f-b1dc-138240fbf4af@gmail.com"> <br>
      Regards,<br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:f37e19fe-4fc9-4580-9961-ccdcf7f9b35a@amd.com">
        <p> </p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:346c1009-2930-4424-9cd4-589e5872877e@amd.com"> This
          could potentially result in not validating them should we ever
          mix GFX and Compute submissions in the same VM. <br>
        </blockquote>
        <p>My eviction test does exactly this, and it's working just
          fine.</p>
        <p>Regards,<br>
          &nbsp; Felix<br>
        </p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:346c1009-2930-4424-9cd4-589e5872877e@amd.com"> <br>
          For now that works, but we need to clean that up more
          thoughtfully I think. <br>
          <br>
          Christian. <br>
          <br>
          <blockquote type="cite"> <br>
            <br>
            The flow for amdgpu_amdkfd_restore_process_bos is: <br>
            <br>
            &nbsp;* amdgpu_vm_validate validates the evicted dmabuf imports
            (moves the <br>
            &nbsp;&nbsp; bo_vas from &quot;evicted&quot; to &quot;invalidated&quot;) <br>
            &nbsp;* amdgpu_vm_handle_moved iterates over invalidated bo_vas
            and updates <br>
            &nbsp;&nbsp; the PTEs with valid entries (moves the bo_vas to &quot;done&quot;)
            <br>
            <br>
            <br>
            Regards, <br>
            &nbsp; Felix <br>
            <br>
            <br>
            <blockquote type="cite"> <br>
              Regards, <br>
              Christian. </blockquote>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------CQ05OTQ0tOCZDaQ6xzMJ0EJX--
