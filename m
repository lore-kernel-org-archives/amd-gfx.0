Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98619C7EE26
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 09:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F45F10E28B;
	Mon, 22 May 2023 09:07:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7226B10E28B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 09:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nsme3Dnfl/su7NI5uJIP7iyRB3/DK9vnwNS5bwwQJJR2qBCw5+EziWkyrEMFXYNilxtBlKhxVGdrceZ/6BME3sPRCTwLUBgzrCwXcZLQkxyc42WNu/5zt/wHZs1uaCFTsIpLBVbtFX9t4/tuN8fZp7KPcW1uhULDQuy0a7SZkm4uGbx5WcPuhB7ecP9qRY0MxKrPokPIkMBRnMforTk6zlD9agG8iYGyYx6QRUP2kt+o5pW9ddHqVdlP9QpViIZWFLTnFVLSfG5YJkw0gSI5+tKoEJJKYNa3FApmtsdkos0TdZsXNjkI3DQktTalpQxv53iCv1SYy0Pp53UKJpwhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rojw67VgAq0WY2YR8q6crrk0Vl1l0mgvapRkM/nEglw=;
 b=HccOO+QjcJJfruUxzllvR5kOFOMo9TPZwTOP0Yn4ILMyUtLJTy+KkWuhyCmu2Oitgzf9iftgI4Vmqyeq4apXF9Qe2AckghXqyO2un1ExttK/4C+S8L3DvOyRwPjYvJVJqE4XqvhgIRgc16OhDCSxxTcVwiZ4ELpU5F9sQMeuFns1EMrnOqiD77vxFo5lNsYzyGg05D3mARiS/CYjoTx6S0o1CiEuPNWtYGWbDpDRfSyn31sSh1PuCS2OvHMvPPeRtPOVRFvUtzKbm68pFEsauu851nghm9/+6GpULccQnuH3ZJhIswQIgUXOwTJ+be31OM6+TCLiKvWWfZ9L3R6YNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rojw67VgAq0WY2YR8q6crrk0Vl1l0mgvapRkM/nEglw=;
 b=0s9194lDwF9aQsueGrGlKNuV325Nha+uHnZYBGdtEpJtBZkBdpFoeJU4pJyHa9IWkV8nArEsO9wAZ9rbL24kttlm2+if+Fs6DRF2rwVJbueOGPG2Yi9HaMskny5bpgxD10JFwTzX0rRI4nzbd5NLNe98L/wIe4z+QKNo+38EzxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:07:10 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:07:10 +0000
Message-ID: <a77f9f42-79c1-c283-dbc9-2155c332ae9e@amd.com>
Date: Mon, 22 May 2023 11:06:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 07/10] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-8-shashank.sharma@amd.com>
 <CADnq5_OEBcYbks-fTq88+1CKxpfLwWG8gkjHSHO1DE3PLcV3jA@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_OEBcYbks-fTq88+1CKxpfLwWG8gkjHSHO1DE3PLcV3jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 783cbe2b-6563-4b58-e044-08db5aa3ec9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46yfaEp83HcmCKdwk5v0+5w+1JOlTdVnstaXhlLNTl25kXtbh8deG5WKkJXWgkdlMhJWi+AUl98A9rF86mYWRTVNE1ONCspyzCotsNRwFC9iA348aMEXCnK7pkAakLCPgdKsoajwiVSeLxdcfxab6bl2BpR8EniWtZOiQ211En3b8SZDkg9u+QVeL2m1sZ9WK7ETwoDXafx+nbNY3epibygC3bjDgz50f7UQqgqH3hofRFUs8dysnlvVVm5mUF26KWXgL4w+vum7d7Sdm9kUJ5cNQyGFzcfZykBXY7mAX/C7mDxshfMjR6UxV9MV3H7fR+QfhiX3VEu++ngidSJ3GkyfjGj3vbPf3uto2RbHCe1nrAc7dU+Z3UKjSm3VzOjhkB+mLd7HKhIbmr84QfafPu0lu0hopOIqFEdWMCK1Hi3r/8VxsxvVVhtbFocSRYZc6ttTbgeW8oTh86DDtiGiU9rue/iuqE4kRwLTvcWNsJM/vq/Dm9bIAKl0laLoa685/tk2AmlqQ4jRecgg/CewVnlRUIVI7CgdFk/B0QWOWKjcpZ5bPd2byWMS3cEML5PtrAKw+Y6byVBpNn6wLIGTnsXuvKc8zJVqQrRIrFDBF6nfNCGO5c7zWsXScyosfwmgu1Ns1Llu97iZkY3epTV0VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(2616005)(83380400001)(186003)(2906002)(6916009)(4326008)(66476007)(66946007)(66556008)(41300700001)(6486002)(316002)(6666004)(54906003)(478600001)(53546011)(5660300002)(44832011)(26005)(6506007)(6512007)(8676002)(8936002)(31696002)(38100700002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlE4aTR0aHpKRGljbmY4ZThQcnJwbVd1dSsyYTAzUnloWmtMSTJDRDNjS2tu?=
 =?utf-8?B?Y09aQ2hmbjlMaVJ5R2pMNVZxaWFuSndhQStvY3NhT3Z5RFk1YzQyeGtJNS9J?=
 =?utf-8?B?SDVpRW5iY3REOVQrTFZ5T0ZBd01pL25iK3FONTQwaER2YUo1NDRFQTlKODhr?=
 =?utf-8?B?Y0VPVTFxSEZhYi9qc2pjcWdINytjZ0ppUmhBb01zVEFEVjRwWlNBUG1veGVF?=
 =?utf-8?B?dTN0VGNIUWlSSUlneFJtUkJnV1NrMlBvRXlnSk4yUHpWL1VyS0puOW93bnh3?=
 =?utf-8?B?VWd2SSsvc0MzTmVKSHRBMTI5L3h5VnZWTWF1TVYwWkRKM080QXhMdTNVeGlS?=
 =?utf-8?B?S3ZjTEtRMG54ZFNiYS9aYTA0YTNERWN1QUt0TGkySTYzQ25DbC9RS2RFL2NF?=
 =?utf-8?B?ck96KzJMMWNKbkZPOXdTRVlmNi9PWlMvOGN4T0s1VDdTOWRmME5VZ20xM1pr?=
 =?utf-8?B?ZkxqMTNqRElETzNsNk9rcTBoZEdjM3lwRGY1UlZKY0RYRDl6QUxhcnBxc2tJ?=
 =?utf-8?B?RVhDRGhGVGRkdXUva2ludWFFbk9OL0hCZ1hSbmVPUjhJRDQ1cFFKWTU1aTVN?=
 =?utf-8?B?cG5qZ2ZSbUhIZW0wUkxiOWwvaytTREtBelVDb0ZVT1JWQUx3blpYL3IvVWJW?=
 =?utf-8?B?MnlFckkrRVVlaGNkL20rSUNjd1FJYUlubWhOeHRUSjBENjBwU1d2am5QbTNp?=
 =?utf-8?B?STBEc1dVenYyeEJHdWt6RE1VK2lrNEhzU1pZQmdla0s2UHhUZmw2Ny8rckF3?=
 =?utf-8?B?Vi9JTHJTSDEvUGVpS0JnMmF3ZUVRellueW5WbVpjK2t4Q3AycDRCN3Irek1J?=
 =?utf-8?B?Q3ZhRnVPcHZFanBWQXVUTWdGOFBJbFpDYjhWeVRRMnR4ZjMyS2k4ZWdZWEhP?=
 =?utf-8?B?enFlS3hOaEV1SUNlR01WV29hbVhlelluZ2Y2eFo5Q1BwYm0wckV1NStSV0Fu?=
 =?utf-8?B?RGJ0VE1Xd0pzZ3UvYXpNSGZqa0U5dmdkOUdoNDhrMmlxdDdwOWtMa3IyTUpS?=
 =?utf-8?B?WEdIVldoZU91TXUrSE9NZDl6eTN1U0RjS2VlZWppT1hNYTRCNjlVOENtM3hQ?=
 =?utf-8?B?dEFOdXk2SFBiM1J2N29VLzdmTUJnZnpSZWdKMjRUempMemhDWUZ3aVpQM21v?=
 =?utf-8?B?MHNqd3dyRlg0T3dIUWxjRXNVZG5WaVAzUklxdFF1MkdYUXBQL3U0Y1dkOFU1?=
 =?utf-8?B?aUsyTDc3dnFtQ2l4d2w0bHp0bU5Ybml4SHRLVm5IT0FYeGFDYnEraGVuRE50?=
 =?utf-8?B?ZytmcXVSUUZLZm56NzNtQTd1ZnByT2FhUFVJRXJFc283Zk9BZDVBQWZwQ09P?=
 =?utf-8?B?TUFjQTR4YXB1UWcxelNlS2ZxdWNBemtBNGgrRG5SUGd5Ui9IWC9Xem1ZYzJs?=
 =?utf-8?B?LzFEZ1gveG0wTU4wZGh0OXBCSnZWRGsxNW1lOTlaN0V3enkzK1VFZFRaT0E1?=
 =?utf-8?B?Y2ZCclZIZDFaclZLaTR5bTEySVJDbXAwQkhsYXNmcm9icEx0YkVuOUhieU41?=
 =?utf-8?B?bEI5ampuY0d5MzNtY2YyUnIzbHptUjRHTHNrV3BPZzI3ZFV5NUVzV1lMZWRa?=
 =?utf-8?B?N1c1Zis1THNlY2hHMmluV1NudC9nU3NyblRWQkNJWktlQzZKWTNQUlFaeWxt?=
 =?utf-8?B?RnNZUVV2dlllcGY0VFVqdEp2Q0VRMG1mRjBybjdtNCtFaDRlUEs3b3ErREg4?=
 =?utf-8?B?NjZSLzFVNUJ6RDRJSElyUUpYRFlPQVJmcWo0bG1TVkcybkgwRWJZangzcWR6?=
 =?utf-8?B?bjVPMXdxdS9EUy93bW5ZbEZVMWg5ZHlkUHRMRlVHbDc3cTdZQXR6WTF6S1Ns?=
 =?utf-8?B?U2dKWCtWWFlQdFZQWUdBdG8vanRkK1cvUWZLWitwN1pvTkdKNE00aGlDZGpT?=
 =?utf-8?B?dU9zeEluUUVGVGk2cG94TUdjV0VDakRPZFNLdlRxeVN2U0Vad0lrR2VvU1I4?=
 =?utf-8?B?VHYzNzcvMzBtZG4yM0xqLzVaYi9nVi9iOUh5UXhEVmhYbkxad2t5a050Y2tt?=
 =?utf-8?B?VHRWZUgvNitGSkQ5b25aZEszZHJ3Tzh0Tm9MV1NoNzZjOGZGTXFZRk5jWE9z?=
 =?utf-8?B?Q1RMQmNBbTJ0dm13SHFEYXlNT3ZaTmxvZHk0L3Y5dFBreW51WG9jRk5CU2Uw?=
 =?utf-8?Q?QVYBq1pZB3wsfub5OCANeOsIy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783cbe2b-6563-4b58-e044-08db5aa3ec9f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 09:07:10.2200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjGyKo9edZJ+QK7ysfLqnl6cw7kpZqIX77aaLAQnQ2xRlLNAVbkxWu159QiEyFLOV8Qc+2F0U9sIDcqlKEG2uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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
Cc: pierre-eric.pelloux-prayer@amd.com, arvind.yadav@amd.com,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 19/05/2023 23:22, Alex Deucher wrote:
> On Mon, Apr 24, 2023 at 1:39 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This patch adds new functions to map/unmap a usermode queue into
>> the FW, using the MES ring. As soon as this mapping is done, the
>> queue would  be considered ready to accept the workload.
>>
>> V1: Addressed review comments from Alex on the RFC patch series
>>      - Map/Unmap should be IP specific.
>> V2:
>>      Addressed review comments from Christian:
>>      - Fix the wptr_mc_addr calculation (moved into another patch)
>>      Addressed review comments from Alex:
>>      - Do not add fptrs for map/unmap
>>
>> V3: Integration with doorbell manager
>> V4: Rebase
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 67 ++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 86de35292f69..7a45d68091ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -31,6 +31,7 @@
>>   #include "amdgpu_smu.h"
>>   #include "amdgpu_atomfirmware.h"
>>   #include "amdgpu_userqueue.h"
>> +#include "amdgpu_mes.h"
>>   #include "imu_v11_0.h"
>>   #include "soc21.h"
>>   #include "nvd.h"
>> @@ -6411,6 +6412,64 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>>          .funcs = &gfx_v11_0_ip_funcs,
>>   };
>>
>> +static int gfx_v11_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>> +                            struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       struct mes_add_queue_input queue_input;
>> +       int r;
>> +
>> +       memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>> +
>> +       queue_input.process_va_start = 0;
>> +       queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
>> +       queue_input.process_quantum = 100000; /* 10ms */
>> +       queue_input.gang_quantum = 10000; /* 1ms */
>> +       queue_input.paging = false;
>> +
>> +       queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>> +       queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>> +       queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +       queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +
>> +       queue_input.process_id = queue->vm->pasid;
>> +       queue_input.queue_type = queue->queue_type;
>> +       queue_input.mqd_addr = queue->mqd.gpu_addr;
>> +       queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>> +       queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>> +       queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>> +       queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>> +
>> +       amdgpu_mes_lock(&adev->mes);
>> +       r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>> +       amdgpu_mes_unlock(&adev->mes);
>> +       if (r) {
>> +               DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>> +               return r;
>> +       }
>> +
>> +       DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
>> +       return 0;
>> +}
>> +
>> +static void gfx_v11_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>> +                               struct amdgpu_usermode_queue *queue)
>> +{
>> +       struct amdgpu_device *adev = uq_mgr->adev;
>> +       struct mes_remove_queue_input queue_input;
>> +       int r;
>> +
>> +       memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>> +       queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>> +       queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>> +
>> +       amdgpu_mes_lock(&adev->mes);
>> +       r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>> +       amdgpu_mes_unlock(&adev->mes);
>> +       if (r)
>> +               DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>> +}
> gfx_v11_0_ for consistency.
>
> Alex

Noted,

Shashank

>> +
>>   static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>                                          struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -6507,6 +6566,13 @@ gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>>
>>          gfx_v11_userq_set_ctx_space(uq_mgr, queue);
>>          amdgpu_bo_unreserve(mqd->obj);
>> +
>> +       /* Map the queue in HW using MES ring */
>> +       r = gfx_v11_userq_map(uq_mgr, queue);
>> +       if (r) {
>> +               DRM_ERROR("Failed to map userqueue (%d)\n", r);
>> +               goto free_ctx;
>> +       }
>>          DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>          return 0;
>>
>> @@ -6523,6 +6589,7 @@ gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermod
>>   {
>>          struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>
>> +       gfx_v11_userq_unmap(uq_mgr, queue);
>>          gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>>          amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>   }
>> --
>> 2.40.0
>>
