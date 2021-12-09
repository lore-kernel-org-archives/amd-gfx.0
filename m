Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C885C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3031010EFA9;
	Thu,  9 Dec 2021 16:55:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C1910E117
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 15:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPrnIbrdm83cUybiaqpSt312Og0Sshni2Kft4aLPyN4SBYzKHrIExFJrox9Mt27/Wz1eS6gDS3cQeT+lqNheAfhMMmCZ34/NUxkyEVinIBTcg25qEPMbYVFNdte8WFBcxURlUBbXRNIlIEiAmLx8O9RBrsvBbJtkalZuWyyH1thbLTpOnW7BFOb2pDKu/GEwkOjaBAn1AFgVoJmVJnziJxCpSu1Xd6iEfQLAdFN7kM2YjP40bWnrao5KCV1NkKU/71/TfsXo76ysxRhBjcPE+oUbfD2CsLomLQyT+Qa9jcmTayEClMEdCvapVoI1AMJprUVOZBIJduNXcYmflBacGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B69eEq2Gqnfy8LXMIFUv7t+PjInP5DRo4E5DT2n60PY=;
 b=PyhBX2jxRPrYtqbYbktsAfrn3w7bsqGGjvyu3QMBt+wxslAF6nz0HlXmzPYd4qQGaa/hccckxcYG1nb+25QfvLlDQMqSFGqSh/LoWA9WroKlspZfgkzliBCNwnLGHFqMsmx2YoWH/p2atrqKCzPyGxTmNa3pF7fJj6rl2y67DmsElKxPDDx4MAs/GzNbBXfPCVVlNXuwtNKgFrL0OLDx3XmXbuGtSPwort/EA0B4JdUvMQXL/Y7WxlUeAgG1B8kYVcv9vgSqti2ZY/fVqBzZgBLrA2qnRz3/66dz7OwypKBjKiZ+TK1G1grB6OC07kw9pq7nEjDZvNh/4iMjO6povQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B69eEq2Gqnfy8LXMIFUv7t+PjInP5DRo4E5DT2n60PY=;
 b=taWTPCaNKpK9f1jFQ+8mHtBF7Qc8vFIPazGhf+SVk2L9yht/e4khOgpqTY/ZgE/aK0PvO+jsCfKbwCDGTPXTRLQjz+UNMMMe+GbJl1DankBEdg0ZWDUiwLaJpMsPFm5O3Jnso6PUAR/BuYf6zQduVHERd+DiG9yxER3LqWxYchU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB2478.namprd12.prod.outlook.com
 (2603:10b6:300:e5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 15:42:59 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 15:42:59 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: introduce a kind of halt state for amdgpu
 device
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Lang Yu <lang.yu@amd.com>, 
 amd-gfx@lists.freedesktop.org
References: <20211209084914.261889-1-lang.yu@amd.com>
 <af6c19e6-fcf4-ac19-637e-1fb47f15f9e6@amd.com>
 <432a38b5-2c56-2b54-4e05-b0a3862ddb2f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <983b6cd3-57ac-a797-170c-2c43b86b67fc@amd.com>
Date: Thu, 9 Dec 2021 16:42:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <432a38b5-2c56-2b54-4e05-b0a3862ddb2f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR1001CA0063.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::40) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:76cf:54fe:ebe4:b83c]
 (2a02:908:1252:fb60:76cf:54fe:ebe4:b83c) by
 AM5PR1001CA0063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:15::40) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Thu, 9 Dec 2021 15:42:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1d1c120-a32d-417b-7cb6-08d9bb2a93b2
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2478:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB247896F758C1EB9F7F510BAA83709@MWHPR1201MB2478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysBpZgODDe78LynvXfzF5V3GjPFgckuhUOHZUMBDiUP5KB9/q4E0N3qy4KKAwz6QwDiKMbNHfpbdQc4cbhE+E+QfAFS15f8RvBM89pleDCNbvejRAzmTNkGI/efnKFNd5sPS/fVnt7dM+3/NbQ0704f17ZHaRIG4vOZub/by0TbLG6Hvgfkjjz2uXvaPQ+bRU46v7Jfyz5xeQV/C63cu6WLdqjJ8Ke9FnlFOliLd3aOXGeMkpcPH182btavm4Gr4ByyFuG9FU7mw5R+vag34XLXyJv4wjEyncoVMoPv/FcZvtIkXKOJXLl1WCDPkzDCY+u6JtdOx+IKxWC1PIlFANB6hp9CX/s9t+B0lAC5YX0Pz6u9+ctlkHdwYVuRbyB9DgMhrwbI9BrHxTQZZX9WPJGfjj6UXrL/tNqg0Iefsp3ysAZbCMim2R/1zrdpOBCR/BSgvcOLVzlTZwYuVR9mc3fhhz8AVvNmHb2euG00x1gAE8wwemrUp/982jzGOWGQtTSAsoGCxZidTEXJwXeI7ei13D1VHYsa469BrkrCk9fcqxtTVeLycQru50vBGW/xJegjCJwgcgaPhm4PP7LrnVBEIZOaf/u7mdOCa2QK+pKja7b0wdbS8PCQGPvJ2IVXneVr/pk+i3nAwXU2tqN91rxKtlnc+yL8YNeDKg++mqz1KaLoqIWVTxUdHTxYz38cxDuBbJxdegWv/Qa4DNZY7tNRmyzH8NKgBB4jJMEeH3vE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(508600001)(316002)(110136005)(66476007)(66556008)(38100700002)(31696002)(8936002)(66946007)(54906003)(36756003)(2906002)(4326008)(66574015)(8676002)(6666004)(83380400001)(31686004)(2616005)(6486002)(186003)(86362001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZhMEQvM1J5WEhYM3hpY2tHYnF2K05RTlFHWDFGc0F2QVFFNDhLTG8rSTZJ?=
 =?utf-8?B?dUQ3Wms5TmVlSDVacjQ1RkNWZkhhUGF6c2h0NC8vZzRWeXBmdkpOTXVVL2ta?=
 =?utf-8?B?dTBzN1ZkeVVhNWM3cDZseXU2azNSNHZqM1BhYWliemJGUkZaUCtyems0cUpE?=
 =?utf-8?B?bkV2YjdDSEFac0VBSjJ0aWFHMU9nS1ZXSmJsdEdYaWl3UWNEWVJXWnN1N0Va?=
 =?utf-8?B?UGI5cGduSTBKL1c0WGcybmJHcUtWMXRTSGU4L2t4ZTZTWWhzY0Fab3Z2K1BX?=
 =?utf-8?B?dWVHTGMraWV0QmxoQjh6eVIya0VCKzdGSk41RUNLeEIzY0ZwODhmcHQ1QTRP?=
 =?utf-8?B?SHBLODMxdk9WRFk0bDN5aDd6VXJJQ0JYbVJ3QXQ2TGNyWVB1S29udXNUVTBm?=
 =?utf-8?B?U2hRK0pUS1pyUTA5NHQ2ZEhzQlUvRDdyRkMwVlRtWTFCK0ZsK0R4OU1kTndJ?=
 =?utf-8?B?MEdJSEVVK3NnRHRVaHMreW9uV0RZc2RUS1YrNjZvbDVncVVIWE5Hdy9qOHVP?=
 =?utf-8?B?NlRoRUcvcHoxZFJhaytqRkEveFRaUGdJNkNyeEFMUS9YSmQ1dW1ybmp2Mmxw?=
 =?utf-8?B?STcrdkFvOXJENVVzZEUvbk1MbFB4cUVMc0RncGsyNS84TEhSbHlrd1Q4YTlj?=
 =?utf-8?B?YklPZnptakYxQVAxSm1PMGk3bXZXOGQyUENxaDJKWWdERUUzOEVwUkhUck5E?=
 =?utf-8?B?WVpPbVBQbTdDdDhha0tpNTA1dWYvUWRWQlpFa1JwU1d3VlF1cWRXbHliMlRV?=
 =?utf-8?B?bTEvY2hvTXhrL1VaajBOekE2ektLR2w3Q3pjRjZ3RngzSzhXcVhGR3pZQ2d5?=
 =?utf-8?B?bk1XM256c2RFVllmWkxCcUYvdWwzNmxiVVBEeEg2YUNVSGo1THMzZTJROUdJ?=
 =?utf-8?B?VVM1TGJNVkRJTklUUVdQSzJQZVRVbnFqaTVncFJlNGNUcHlPTjBZWER3b3Bm?=
 =?utf-8?B?c3I4bzREODlwbng2OUlsQkk0aDA0WmIyejR4eFFaZTIrVTUwMFFVTU43VkJT?=
 =?utf-8?B?STZrMG1JdDJSelI3RXFrY0kvTFBINXd3ZThqOHBmMVdvenZ3VUh4Y1BCaDVI?=
 =?utf-8?B?VGx0cG01ZEZxYWFRSGZIcW1DRDFSNzVObFRQRW9NZGJtc2N3azJIbG96dmYy?=
 =?utf-8?B?UTJNcTFER0JiczJFZlJyckdJZm1RYjdWeFdKM2c1dkt1MjA5VHZPREhpZFZi?=
 =?utf-8?B?TTllOElkT0c2WmhmOTJtQUtidXN3QjJQV1hua1lrTVVjSS9wOENZbDFubEtW?=
 =?utf-8?B?WFJwTit1Z0xVT21qT1BBWHBMNmswQUROR2I1aFFVUmUzcVJralJHSzhiZnZJ?=
 =?utf-8?B?LzVsSWpGOGw5MDAxck9JdEJYSU9wQ0MyaE1NanFBSk16cXYvcTV1ZFVTRlQ0?=
 =?utf-8?B?bXpaWmxhNG5CUEJEY2lLU3I3ZEJWeUtWQWhjdUNJVUE4OFBleDhJSVVMSFh2?=
 =?utf-8?B?alpQbnhSOHl4MHFJUjRDMmFOTm9OSnJSN2Y1SWZvN3JhMWpzVDEyT3VQNk1R?=
 =?utf-8?B?SUF0T01uOWFBbWNGc2RkQWYxRUI2ck5mRnREUDJjSmtUbkVDWmE0WGpLRWpJ?=
 =?utf-8?B?N3ZDcmxpTzIyMkttTkNNV2Z2YTR6Y3RGaDhhMmpEamRHUHBITUFmM3JEQ0FB?=
 =?utf-8?B?RkFwN3RvcGJrTGdhWkRMcDNqVnp0Y1NnMENqNlRTK2pZV0RpNDEyMmlFNTY3?=
 =?utf-8?B?V3BrMHlmRThrTHhFQVlsTENFVnRJUktpSDRtSllMRXEwbFBjRVV6Vk9UMndV?=
 =?utf-8?B?NzN0TlF3MmtHVUNrOUQ5VE1saGJMbkJwY0R1U3FzK1dTc0NTY3VORTMyMjFv?=
 =?utf-8?B?NjJqU254bmZTT0tzb0JwUFFONE8zQ05ObG51MFdkdVdhc3YxT3lwMVpOZ2ZQ?=
 =?utf-8?B?S1ltbExza2RkSUpLWE5IWnJFQWlLeDZmYWY3Q3Bwa1JFWXhCYVlBUERGbWp0?=
 =?utf-8?B?OHp3Zis5WlpKR2FmT29IemVFT1lhbFhEVHV4dk0wcE9wK3AvRnJod3Jrenps?=
 =?utf-8?B?cUROUlFKRWhZcklESDJ1eWhCTmxRWXZseFlvYjdqNlhPR2tEQzJLLzNGNFhW?=
 =?utf-8?B?bWV4bStJd2F6YTQ1ejkvNGp0MDJVTkF2UWpCYjBDZ29MUDhJWmZmcGNHYlRS?=
 =?utf-8?B?bk5QUnJTRkF1dStlM3FuMHJycnZtRlRRRkhwOVByQjFpb1dIRDN2NFI3aldp?=
 =?utf-8?Q?uuMSDB8icpKVm12ra0dOxpM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d1c120-a32d-417b-7cb6-08d9bb2a93b2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 15:42:59.2923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h14L5nOqLCSx7HoQOehJHzjLFEFSEFLA4gGNMvk+ztg1UumCKy72gSKGgVNTPihx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2478
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.12.21 um 16:38 schrieb Andrey Grodzovsky:
>
> On 2021-12-09 4:00 a.m., Christian König wrote:
>>
>>
>> Am 09.12.21 um 09:49 schrieb Lang Yu:
>>> It is useful to maintain error context when debugging
>>> SW/FW issues. We introduce amdgpu_device_halt() for this
>>> purpose. It will bring hardware to a kind of halt state,
>>> so that no one can touch it any more.
>>>
>>> Compare to a simple hang, the system will keep stable
>>> at least for SSH access. Then it should be trivial to
>>> inspect the hardware state and see what's going on.
>>>
>>> Suggested-by: Christian Koenig <christian.koenig@amd.com>
>>> Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 
>>> ++++++++++++++++++++++
>>>   2 files changed, 41 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index c5cfe2926ca1..3f5f8f62aa5c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1317,6 +1317,8 @@ void amdgpu_device_flush_hdp(struct 
>>> amdgpu_device *adev,
>>>   void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>>>           struct amdgpu_ring *ring);
>>>   +void amdgpu_device_halt(struct amdgpu_device *adev);
>>> +
>>>   /* atpx handler */
>>>   #if defined(CONFIG_VGA_SWITCHEROO)
>>>   void amdgpu_register_atpx_handler(void);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index a1c14466f23d..62216627cc83 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5634,3 +5634,42 @@ void amdgpu_device_invalidate_hdp(struct 
>>> amdgpu_device *adev,
>>>         amdgpu_asic_invalidate_hdp(adev, ring);
>>>   }
>>> +
>>> +/**
>>> + * amdgpu_device_halt() - bring hardware to some kind of halt state
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * Bring hardware to some kind of halt state so that no one can 
>>> touch it
>>> + * any more. It will help to maintain error context when error 
>>> occurred.
>>> + * Compare to a simple hang, the system will keep stable at least 
>>> for SSH
>>> + * access. Then it should be trivial to inspect the hardware state and
>>> + * see what's going on. Implemented as following:
>>> + *
>>> + * 1. drm_dev_unplug() makes device inaccessible to user 
>>> space(IOCTLs, etc),
>>> + *    clears all CPU mappings to device, disallows remappings 
>>> through page faults
>>> + * 2. amdgpu_irq_disable_all() disables all interrupts
>>> + * 3. amdgpu_fence_driver_hw_fini() signals all HW fences
>>> + * 4. amdgpu_device_unmap_mmio() clears all MMIO mappings
>>> + * 5. pci_disable_device() and pci_wait_for_pending_transaction()
>>> + *    flush any in flight DMA operations
>>> + * 6. set adev->no_hw_access to true
>>> + */
>>> +void amdgpu_device_halt(struct amdgpu_device *adev)
>>> +{
>>> +    struct pci_dev *pdev = adev->pdev;
>>> +    struct drm_device *ddev = &adev->ddev;
>>> +
>>> +    drm_dev_unplug(ddev);
>>> +
>>> +    amdgpu_irq_disable_all(adev);
>>> +
>>> +    amdgpu_fence_driver_hw_fini(adev);
>>> +
>>> +    amdgpu_device_unmap_mmio(adev);
>
>
> Note that this one will cause page fault on any subsequent MMIO access 
> (trough registers or by direct VRAM access)
>
>
>>>
>>> +
>>> +    pci_disable_device(pdev);
>>> +    pci_wait_for_pending_transaction(pdev);
>>> +
>>> +    adev->no_hw_access = true;
>>
>> I think we need to reorder this, e.g. set adev->no_hw_access much 
>> earlier for example. Andrey what do you think?
>
>
> Earlier can be ok but at least after the last HW configuration we 
> actaully want to do like disabling IRQs.

My thinking was to at least do this before we unmap the MMIO to avoid 
the crash.

Additionally to that we maybe don't even want to do this for this case.

Christian.

>
>
> Andrey
>
>>
>> Apart from that sounds like the right idea to me.
>>
>> Regards,
>> Christian.
>>
>>> +}
>>

