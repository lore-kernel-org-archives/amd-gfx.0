Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E082C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 20:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D57510E5C2;
	Thu,  1 Jun 2023 20:34:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBE510E5C2
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 20:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOArIcPAVeTx9x0Ulul2UhgzUgzgft1NM/0TF4BRIA8wF4E55yDKZvvFH0F4iqcK4kF/vRp2xntjn3quc/822LzJ3Jh/49LUoMv9JAGXQwqd/pr1Nx0ZO01LW1QKHgq9rPHiiqR0TJHXOZhesmsguJId0u487zZEKdOiuEcrU3lrVcLe8noW5mS0tHEEj1LDLJEoXjw+7eXdOfUs0C/s377F7sBuPc/LL/yhTwr3gHZXlDje/OqAHvGRmUpm5SBlv0r8CsslLgwMd98EuMJGyuaRZZ6DjOqd1mFwErUbiowtkusd2+HyAeGfvW4lCV/uJOFO+W6TWXamoVjBQuKAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEM4nSOtFB3po0t+rGq1keh2gwI+AIuU10oJeghxTGs=;
 b=DX3WFyJORsLewDE7NHSoZ6K79bPxLekHdt0JBPixMfOvqApJRFtViICXYZUVDwIPCA/8tqXITQ1bx4pAl3b4f8uXk/FO19unZzZps71m2FsIVczUWeYVOD0errmksSf6l4cD4ie1mPXlGZMIc4SJ4HM0htUI5YlhAK7CNjmjl5c+JNjjkQzJd9yztuSi9duqKSlx/XCn7sDJ0JxRC5BHeLBRQ3H8V0KQpBH2Ui9QzQc+JX95p/LTx0fheIjeaWmoHwdy612ZW4RWVRI2j5y5Z2JeVPHA8Z8bdPa3LAqI/ybFHmx10zVdQvdmRq083UVnFnEoQm0yndPBW5ccUxiG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEM4nSOtFB3po0t+rGq1keh2gwI+AIuU10oJeghxTGs=;
 b=hLQTEHwrvnHXvme787QWU+YTkDARPR3YYypVfIShELPXzf6DiUQ94f9xOh8W6hPnHSlWk4ZFQaywPtQkgObAplRjXM33NE4+XCvONP7TJ69uLA5uUuteYc7nF5vo1tp/y2dDZY2xKOuYeESHIXmq6p3gcgSswkEytoWUsPDU7ZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 20:34:32 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 20:34:32 +0000
Message-ID: <274ff212-ba13-47bd-dc4a-8ac52e131315@amd.com>
Date: Thu, 1 Jun 2023 16:34:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] drm/amdkfd: Signal page table fence after KFD flush
 tlb
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-3-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230601193117.13143-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::9) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a6f3b5-8593-4440-f8de-08db62df9b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oafJDmgeppG5icehl9EJ0mxGrua32IVCB6Ii/1BuTp6cnpwu/Te9BG0pd0lYyN3+ph06WhS6yVVgSJUQmDPMqv+iCISypDS2hmA7NpME9uLQOpT4dBE2SHH+XhtpYznu+zU888f9YxMrDRngPTqBt+dFVTIWCb8tCXSChRYsGn994HVkeyLOqGktLxZ2Eht7395OO/TTSkCVGk/zyDY53ThyobOLeTYcPU3sOsJ1a1SBBcynB8RynmKQYleaG3SiUMoeRiWbGbEk72tk4CiViiBQPpGKyatXmdMscvofVEjjBBoduGKynuv0eQdRLl3ZHRVuMDsOu3YlAbd1aSACmibC61n9OdUSkLewPkkwShYy3dnxQKs4l8UXydNhr2zbi9hQnWBKpD0ALrtNItZ34jH7xGz0kAEr9+rFrNZIIXt2c8fWnpg5I00i1l1qqyyIdmArrFOxmd8M3xDer/xnadjrKjgkjSwbb1M4GOhVSHiR/E7BQEj8xBmAn9wEbViKpXf4rWiDMxkPIrKSzR0r0u8Mi8tyJHA/5l/arS5DUCNf960xjAGApNLETDgfDyEWSsdAS6y4PlY7mu+uCVbC9qQX8lm4aT5ZzGrmV5Gf8AWuBq9quMDQGQdSfjzeoarQDhMsE1zbwgnvRN5IE3cJJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(41300700001)(5660300002)(8936002)(8676002)(6486002)(38100700002)(478600001)(36916002)(316002)(66946007)(66556008)(66476007)(4326008)(36756003)(186003)(86362001)(83380400001)(31686004)(2616005)(31696002)(2906002)(6512007)(53546011)(26005)(6506007)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlVub3E3Vi9YM2M4bmVtSXFHd0Z0Uk9SMzRqMFg3UFNRczdFZHdJRW1tZUVw?=
 =?utf-8?B?ejc4Z1Y0ZTdmMnFJMG9GUmJCLzhMejdIVEg5WnJkTG14K0ZyZVpGd01SU2Nk?=
 =?utf-8?B?Y0ZjZUVtanpDMVNGNXlQSTZUNmY0aktUYWJSTW04TlNDNllKYnZHWlAyQWxD?=
 =?utf-8?B?RHVaVHVOekYwK0lzenBiYjlNS095TXAwelBhRGtIeFQ1dXRTY3hPcjk4UUhq?=
 =?utf-8?B?V2dnM1NGNDBZcXcxQXkvV1BPSlQzbGttaWxEdkYvNVZlVDNPUEN5UHh6TVdZ?=
 =?utf-8?B?NlZTYUhkZHFsU3JTNGIwV2VsT1VLUHF5c0RScnhZVk1qU0trRHZ4cm16K3J3?=
 =?utf-8?B?Szd5T3U3WU1ZQjJzcDRDUFBqZWRtSEI0azVpeEFxS2NZNHhPb0c3YlVBSnVK?=
 =?utf-8?B?WXRFY09EMGJqK2pkVDA2TW9HN0p0d1pITTIzSFk0WkRDcER5eXZOZ0x4SHNx?=
 =?utf-8?B?VElobUxoZ2p0VUFFL2V4QndjOGNVSlN4Uzh3ZmtwR1hFTUFRSkM0YVozU245?=
 =?utf-8?B?dWxHdnN4R0lKaXBaYSs4V2F2WGhHbEgrTkVDVDJaMW5LM1dPZHhQNUhBWnp3?=
 =?utf-8?B?SkRFMTFOYUx4NHZoeEVkMDVmQnZpQnBpWmw3WG1YNWNVMGs3amc3NlJHaWxO?=
 =?utf-8?B?NWp6bk5hbGVxbzNva0puY1JIUmZKUmZiRWJZNDJBWHFhc2puR1VvVUZOc0Z0?=
 =?utf-8?B?bDFQdWVib1VKeTZvWFRjS1VoVEphald0eU9GOSsyRFR5R3hiYzRhWHdmcmxJ?=
 =?utf-8?B?UFhZMjRtaVJVNlV2aGtOa1czQlc1MUlOaFd3dlljaXhxZ0F0Z0lxRmE0dzRD?=
 =?utf-8?B?SlhCRU5NRTNheHNrOStoTjA4YzA5RmU5cE9iUkhSTFVGd05hc1ZWc3hFeEhH?=
 =?utf-8?B?bDZkcjNpdFpRMm1zMWFnenYxNDlZZ2tCVnZKRjk4Y2MwU1NTckFjTEFSMDM4?=
 =?utf-8?B?SDN0ODRzSlBKOWd3RGMxUS9zUHZHeVlFQmRrcEVsU0NnM1JHd0tJemRoZXRs?=
 =?utf-8?B?czZ1QlhXa201TTJUWVlGVDIrOVU5clB0MXNkam5TVUFWOUw2bkRPSzhrYnZS?=
 =?utf-8?B?ZW0wUjFFUG5sYlBtVVNqZldZSE1YeFl1dVJmTnRURjBVZHlQSzlPaFJ4TTVn?=
 =?utf-8?B?YVBXK0RpNnEzWWxFTzU0ZVI0TVZCL1BWeU90YXF2dGd4S2FndEs3YjhxaldY?=
 =?utf-8?B?NEZpUlNKamxmMDF3NSttQ1RTLzBVVDZHMm9hY1RWem1VT216dnJndEZod1FV?=
 =?utf-8?B?MEJhcXZKYm5SdHFhYTBNR2QvaW5kWnlIaW5HNlMwaVRjbU9ReDIwR0dWaWI3?=
 =?utf-8?B?eTRUSS9xMCt0TWY1czNodVBsaWFidXFrVGwxeUhEaHNGb2NnMFUranFjNmNF?=
 =?utf-8?B?bFNmVUNQdnVwM2ZXNTdERDliS2d1Y0Q0TW9TaXpQZXFrbFpzZHB3UWlabExZ?=
 =?utf-8?B?cyt4dFRhNFhiRzdGSWxTTU1kZWNLRDd3WmdIU05PS3JtaHBqcnYrVENmcXUw?=
 =?utf-8?B?UVRDK0JnQTc5dFdTL2o2TGxieHN0aE9lY1ZJeGpBaHVubnVpa3VDb09WVEZR?=
 =?utf-8?B?QlhjcUdBSlVDOFNVV2ZpdXhWbStpV1ZNRWhqZWVaS3pld0xUUXhSSGthVjk5?=
 =?utf-8?B?UGVIOXU4RkptRTVYbGZRdUhVcWZIS2t1ZFNZdm9SSytsVDFBbnpyOVN2Wjd0?=
 =?utf-8?B?Rm1MWHhGK3NUZ1YxUHBYK1RCUytua3RJeUVxdVlVUVZzMDJjRERWMS8rNGww?=
 =?utf-8?B?TVhFamdhN1ppSDZNOUQzZDFNZWZscXZ3alpSSXNxU0o0NnI3VG5kaXhkcC8y?=
 =?utf-8?B?R1Nicm9EaEtsalhZRUZ2WVV0U3FrVjBISkR1ZmVKRVVMRU9lalVXWUZNZHlJ?=
 =?utf-8?B?SjlLSjRCMDFicGpwTUJvYis5aTFEbDRnNHhpeE5rZGEyYTJhZjNTTjdYR09B?=
 =?utf-8?B?ZVpNSXJNeHdDb0syQ3RoSk5WUHlkeDl6SkNqbEZrdkpJdU9XZ0lDVEo4YlpF?=
 =?utf-8?B?dUVXUEEwbVJoVTZLZVVrc3JHbkx3aEo1cnJEdXArYmNRaHFsWHR2alFKYktJ?=
 =?utf-8?B?SGtDWmVSWEFRR29ySS9URGxPNEpLc0tFdGNiYU9OVlcra0IydmpZRXFwV0Ir?=
 =?utf-8?Q?A2Hb3wTeX6d/8gP2SHtjY+n4U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a6f3b5-8593-4440-f8de-08db62df9b1e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 20:34:32.4680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Op29qpsITxiamHK+JnE9IuhR92ylQk0jylqDLkDfb8MkexqN/F7IgTxScfKYeAQy4o5OB52cBe4v8IcJNw21LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-06-01 15:31, Philip Yang wrote:
> To free page table BOs which are freed when updating page table, for
> example PTE BOs when PDE0 used as PTE.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index af0a4b5257cc..0ff007a74d03 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2101,6 +2101,11 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
>   			amdgpu_amdkfd_flush_gpu_tlb_pasid(
>   				dev->adev, pdd->process->pasid, type, xcc);
>   	}
> +
> +	/* Signal page table fence to free page table BOs */
> +	dma_fence_signal(vm->pt_fence);
> +	dma_fence_put(vm->pt_fence);
> +	vm->pt_fence = amdgpu_pt_fence_create();

This is a bit weird to create a fence here when we have no idea when it 
will be signaled or whether it will be signaled at all. But I think it's 
OK in this case. You add this fence to PT BOs before they get freed, and 
at that point those BOs must wait for the next TLB flush before the BO 
can be freed.

The only important thing is that fences in the same context get signaled 
in the same order they are created. I think if you allocate a fence 
context per VM, that should be guaranteed by the VM root reservation 
lock that serializes all page table operations in the same VM.

You may need some locking here to prevent concurrent access to the fence 
while you're signaling and replacing it.

Regards,
   Felix


>   }
>   
>   struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t gpu_id)
