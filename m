Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3882C46467
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 09:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D43210E3C4;
	Tue,  3 Jan 2023 09:39:02 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C6A10E3C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 09:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYfK2uSvKhd4nLC1zyvInSWC8qSe+yiiUScshhVRaufVrHqRw3LM5YhQE9kTTkZV1pRPPnUqyIBRbwSAFmxDm5zAiOALf6La4nFIYNEX9hTa3W4aZXNILlfHn3PXrSzVBilD8dlhXDD3AgliS70F5LrpypAT7yz4MRuU6SkLvNS2RzPji7s5EKIRUv2T1hk/7Yj7bJmROO6Y7MLqQrvcAisNxEdlKwHwkpKYKXDgh2MajiUnKZlMdqQkrwyDaMTghAjGwO3DALwa37Q7Pir/rjrGNvoBFDU53pOQNgts8dkeZI23Kajq5Qd4jhrQT6m3cNgeWnRBwbc1aLBbFlDA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8vgCyHkk8PtlaRKU3JnKL1nfzIabdg6fUwrQdB7Fwo=;
 b=dYYVeOLUW5j/BwvLRfktpjO3/ggIfd3kCDwCmMjXn4zEbGSS+AM+CvkkP2rKgDUOGwa/c2WhCvSwYUITxTjTyNRMoSmhZHvRNx6hI+Wr+BnUnqwxRucQMKlRO0QwfBd90dWxR5Ew7bW+ZQGMQQJNFGsm0k6gOnroIvRNaRJY3XW3xvlhXLp9UHZVkm3kpcnAXII58OCXE7l7powHiZ6w+HQpbuCXejNDJb1XaoXFKnfFEzNRrr4oeS1vKzsevrNYA3bajQwwBVpf6w1bZlSW4v3jccTU09BkNIDSYMG/RcLvDsgw5e4Uzqjd/qrYmDOVJihnc4+RdoiI3dl4WmiNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8vgCyHkk8PtlaRKU3JnKL1nfzIabdg6fUwrQdB7Fwo=;
 b=3Wdk7GIa8Hq3RSdIqwKZYAjEqGgkl/gaBPRJRldZr92yoCt8r25qw+GiXYxFrxbolZ8lOpGMIM4ig03UFc53uPTzub7m5pVrJYjb+Bg0S5H1buuLAeEcr/7g65NZbmoWhiOn9zBdlQVtufBF6D6Z6AHWZvwCZkGfQsHecOIi/1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 09:38:54 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 09:38:54 +0000
Message-ID: <86a5e0fc-16c8-2c30-6849-67e6ae46b8f9@amd.com>
Date: Tue, 3 Jan 2023 10:38:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 6/7] drm/amdgpu: Map userqueue into HW
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-7-shashank.sharma@amd.com>
 <CADnq5_MSrURbaNCN9+cjPAqoFoOPtLBXZPcP7hM_UFWJKKDyFw@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_MSrURbaNCN9+cjPAqoFoOPtLBXZPcP7hM_UFWJKKDyFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::10) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3cfcc1-189e-479a-8079-08daed6e5443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g31y7ROtFn8UhbxqgymJXTlAbu0ugBfHK70K+pCdAQMFAo20u3uQ4mT0oTbqfa7mBZwisJuMgU0mp7NWeDxx5C1vutEnqKaLCbkfDfVoxTwhOw5kEok4Xt6kWz06fRwTbCV0kwGxyc6UjeFl/hnweCHvQuPz3lAb1ZM/VgHV+FcwXSgEQbZNrOXmUvYVbAPtO6TkKAsXROPqAoCHR5XY9c7sBTvt6XSnr3SKwKG2GhBHd6e4eDQEUfs5dlINr6mda/yVMoMoOSotESRe/CgQ4FDB5NGoLyrD37veAx70ie9yFwXBP0BJy28x13xum5FVujcS8nFqMRtz1ZVwJoC/q65WfKatmqFVcdfURjRV4CEutNGlkZMTESyQZE+ZE2mMM406jutPeBHFnxv1cvsbwv2ltvslrNee01gSBoUtPhDYXrL+F0xy8YC8nzmSjcWD/AdeQWLQVoK542KG0OUPi2ocOpKflLjHO5s9OnMJ/+IRkRJvI+GolY8Olr7XYaWax9XuopI6wTHbDHFbFtT2CMPMxnJNKPjnEr3M+3AeEaAUDPU8wGbDvIeaDCMTcKueCsTc7/h6jRle6wPFCesdDigYgr28SwswLInFF7ugJ+qN5/fay890G8mXZF6pVQ3HNID4upFhT20mkY91dlBishIKIDZFSQxpPOn5fCQCs+t/kK19iY0nvekomU20NDb17nptWDF9dlHfS7jNHXEFyGPveiMIZY/BTSGnLS2BIaGchNK19t2FsDnYIKvT8i/BOyaBXKwckfl1Z/PO9lAXcPESJw3tWOdIoz7VvcOJgtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(6512007)(186003)(53546011)(26005)(6486002)(6916009)(54906003)(31686004)(478600001)(316002)(6506007)(4326008)(66946007)(6666004)(8676002)(66556008)(2616005)(66476007)(8936002)(5660300002)(44832011)(83380400001)(41300700001)(2906002)(38100700002)(36756003)(31696002)(86362001)(22166006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dll2RG02a3RTUitqNktSMms1SmszODVON0VGWk0wYUVUZGJOWk5qLzZweGM1?=
 =?utf-8?B?UzFZMFQvNjQyay9tYUhIME5vRkZ0NTZnTnVMaVpXQituZVY3SVVieTRhZUk2?=
 =?utf-8?B?UjVYRVhmb3VjVDM1WmhIb0pBQTdwQUxpQ1RJL1pmM29pZUVITWZ2VDdkV091?=
 =?utf-8?B?aWVXZWRpS012dVZmVHBKb2hVQ1ZucEFhckRyWkRXcFRxakdkS0wvd3NYNkFC?=
 =?utf-8?B?NmI1NXdiUHlKM2kyejFqZEFpTXJJUlpkbDNyUjVCS2dvSHlrNEtiK1ZRM2Yy?=
 =?utf-8?B?aVprV3ppME4xSXRCdXd5cHJsZDlRTWRTVmlJa3lDMXlEN0R2Y1Q4QUNTZ1FY?=
 =?utf-8?B?MUQ4UWJIajFBdW8yeVl0ZmFwUzhLQTVtSTBtS2c3RHNvT2ppclE0NnhUVG0w?=
 =?utf-8?B?U3hWVTFmZUpISU1jMkpRYW1YdVZZTDB5dkV6TkdrZXI5OWVtWlpjOFJXMkEx?=
 =?utf-8?B?SVJzY3orMWlqQmt5M0t3U21hR28xSDhmMmQ4eGZWTU12RkRXYzBHOW5FSlE4?=
 =?utf-8?B?cnZ4SEJ3elF6RWNwRUduV3ZhK3luV2h4eGN4akU1YkxxUitZZG1kNzc5WFNF?=
 =?utf-8?B?OVhWc2VtclJJcTUvQ0V1c2UybkpTS3dSWXQwQjY3VXM1cXVpaVBHTVplWHpR?=
 =?utf-8?B?LzkrclptY2hEUTd4SGoxSTBjdThnaHpWR29GUXBsSnlEb2JmRjhnWDNlMFpZ?=
 =?utf-8?B?TVVNaVRpempicXM0U2NBaFVOUlFyU2ZLOEJOTGttQnZmN2wyejJWeVp3Y1pm?=
 =?utf-8?B?ZmZMekNYbjcxY2Z3MWZFdHYvZU1Edk5tVlRsY2t5aisydnZHQm0rbU0veTBN?=
 =?utf-8?B?MU1CL3hKZUlNell2QkxSYjM1R0N2SmNNbzBwQnkxTmhBMGc3RkE1NEY0Q1Fu?=
 =?utf-8?B?ME8rdVRaRlhjWlVTd1JKWndWeWdrMlBPRXFGU0JXbmRUTEkzQU0yWUR6Z1pZ?=
 =?utf-8?B?MktMZmFWK1NDbGNsa1hLYUxmMkN5UDVGRGRqcDkxRHI1ZXp3TjVpbmR6QTlO?=
 =?utf-8?B?dUFxanRzQ0ZhRTNCNnNTajV6UXpxWmtPcXM5SktaaTFSVGpxTU1IL1FVdkFX?=
 =?utf-8?B?WVdnSmFscE9VMTNvbjM4TE90YTZ3SWIyaXVGTFhUYkJOdjA4T2JsK2tHVDRJ?=
 =?utf-8?B?TUhRa3J5QUNvcC9RVkpuREhWaDhBWmJXQmcvMTVSOXRzUGxvOWRwaGRkVDZw?=
 =?utf-8?B?VmhoTFNWWlVjTElHa2V0c216Ryt3cHN0QURjK2xFd0VaTytieDlBRHJ5OTdX?=
 =?utf-8?B?WSszN25wUVFSa2tjTzBXNGlwRzQxVEVZamwvNllGaE9CaU5MUi9vSHF5Ukxi?=
 =?utf-8?B?MDVLTi91MzRUYTZNWkgxRWN0RVhVZXJQSXpXRkpxWEtvdm9ybTZUMXlUZUpm?=
 =?utf-8?B?MUJaVUZLaENoWWRzZ0xySEJQZmpCaFY3cm9ZTko5Vis4TUdYYWVjRHFvN1c1?=
 =?utf-8?B?ZzJ3M0p4K2daK1BXQThyaUFRZEhYREFJVFhPL3Z2Tmx1Ym5TMVhwdU90QjNX?=
 =?utf-8?B?TE1JaDZZTndvWHN5cnFubGpuVHN4SUF4SW5qblQwcklucDJ1Wi9remNIYzF6?=
 =?utf-8?B?L2psdmZjKzhrcHRtTUxnWkVDUkxZdmliQUZwdk1zK2ZvUVN3cWxkNHo1akZq?=
 =?utf-8?B?aFNFMk96VlliS29Iek84bkhxS3N0K3FPWCt2U3BybUk0dUM3L0R2dk1nQktF?=
 =?utf-8?B?WFRKaHNJdVo1R0J5QUF0MUpUQTB5K2xEK2M3ZkFyWXZZcjVvL1BJVXZwMjhm?=
 =?utf-8?B?aWVySDVub3QvRTdKNlY2cUhQYWR5T1JrYWJvaE9BSUU2elRRa3BYeFJJUUMw?=
 =?utf-8?B?WU1qVDlzWjk4WFljRlBxdHUzN2JhdjF2ZHVtQVpOVXBTNDkyMUZaVnJqZXZH?=
 =?utf-8?B?ZDlBNUVLclFnRnlXUmkxbzFWa2VGalpmN3l6OUpzWDlvalpnVEZXNmVRVU0r?=
 =?utf-8?B?NlF2SmtEditTWXNnclRaa3dGOTFHQzRHdFhDc0tNckFRbWdQVEZYdGJTdmx6?=
 =?utf-8?B?OEpQSEUrbk45Mmd5djRQMXZGb3EzNjlOMGdPMVFWaEdKYlRnMEYwc0w2bUdC?=
 =?utf-8?B?NUU1L0xhZTZxOU1ORUZTbXlHNFNmOHAzK2ZsMi9wemRRbGgxR3RLUkNFeFhq?=
 =?utf-8?Q?jii9XV25JRX20zBnkPpxQ04aS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3cfcc1-189e-479a-8079-08daed6e5443
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 09:38:54.5065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L102+Wi4KvHoAt3OR8yW6vGabUJt/R5F/yml97V6KLa4WRfILPgH5xhjf3cuFtanQNa7vYpJ+ABoaVt4uUEK1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 29/12/2022 18:51, Alex Deucher wrote:
> On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This patch add the function to map/unmap the usermode queue into the HW,
>> using the prepared MQD and other objects. After this mapping, the queue
>> will be ready to accept the workload.
> This should also be a callback into IP specific code.  It will be
> different for each IP type and version.
>
> Alex

Noted, so far we have two IP specific functions, .init_mqd() and .map()

- Shashank

>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 71 +++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 2a854a5e2f70..b164e24247ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -50,6 +50,67 @@ amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct amdgpu_usermode
>>       ida_simple_remove(&uqg->ida, queue->queue_id);
>>   }
>>
>> +static int amdgpu_userqueue_map(struct amdgpu_device *adev,
>> +                    struct amdgpu_usermode_queue *queue)
>> +{
>> +    int r;
>> +    struct mes_add_queue_input queue_input;
>> +
>> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>> +
>> +    queue_input.process_va_start = 0;
>> +    queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
>> +    queue_input.process_quantum = 100000; /* 10ms */
>> +    queue_input.gang_quantum = 10000; /* 1ms */
>> +    queue_input.paging = false;
>> +
>> +    queue_input.gang_context_addr = queue->gang_ctx.gpu_addr;
>> +    queue_input.process_context_addr = queue->proc_ctx.gpu_addr;
>> +    queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +    queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +
>> +    queue_input.process_id = queue->pasid;
>> +    queue_input.queue_type = queue->queue_type;
>> +    queue_input.mqd_addr = queue->mqd_gpu_addr;
>> +    queue_input.wptr_addr = queue->wptr_gpu_addr;
>> +    queue_input.queue_size = queue->queue_size >> 2;
>> +    queue_input.doorbell_offset = queue->doorbell_index;
>> +    queue_input.page_table_base_addr =  queue->vm->pd_phys_addr;
>> +
>> +    amdgpu_mes_lock(&adev->mes);
>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>> +    amdgpu_mes_unlock(&adev->mes);
>> +    if (r) {
>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>> +        return r;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
>> +    return 0;
>> +}
>> +
>> +static void amdgpu_userqueue_unmap(struct amdgpu_device *adev,
>> +                    struct amdgpu_usermode_queue *queue)
>> +{
>> +    int r;
>> +    struct mes_remove_queue_input queue_input;
>> +
>> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>> +    queue_input.doorbell_offset = queue->doorbell_index;
>> +    queue_input.gang_context_addr = queue->gang_ctx.gpu_addr;
>> +
>> +    amdgpu_mes_lock(&adev->mes);
>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>> +    amdgpu_mes_unlock(&adev->mes);
>> +
>> +    if (r) {
>> +        DRM_ERROR("Failed to unmap usermode queue %d\n", queue->queue_id);
>> +        return;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("Usermode queue %d unmapped\n", queue->queue_id);
>> +}
>> +
>>   static int
>>   amdgpu_userqueue_get_doorbell(struct amdgpu_device *adev,
>>                       struct amdgpu_usermode_queue *queue)
>> @@ -338,12 +399,21 @@ int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
>>           goto free_mqd;
>>       }
>>
>> +    r = amdgpu_userqueue_map(adev, queue);
>> +    if (r < 0) {
>> +        DRM_ERROR("Failed to map queue\n");
>> +        goto free_ctx;
>> +    }
>> +
>>       ctx->userq = queue;
>>       args->out.q_id = queue->queue_id;
>>       args->out.flags = 0;
>>       mutex_unlock(&adev->userq.userq_mutex);
>>       return 0;
>>
>> +free_ctx:
>> +    amdgpu_userqueue_free_context(adev, queue);
>> +
>>   free_mqd:
>>       amdgpu_userqueue_destroy_mqd(queue);
>>
>> @@ -362,6 +432,7 @@ void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
>>       struct amdgpu_usermode_queue *queue = ctx->userq;
>>
>>       mutex_lock(&adev->userq.userq_mutex);
>> +    amdgpu_userqueue_unmap(adev, queue);
>>       amdgpu_userqueue_free_context(adev, queue);
>>       amdgpu_userqueue_destroy_mqd(queue);
>>       amdgpu_userqueue_remove_index(adev, queue);
>> --
>> 2.34.1
>>
