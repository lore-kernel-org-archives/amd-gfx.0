Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456FDC76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 08:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC72A10F12E;
	Fri, 31 Mar 2023 08:30:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23BA210F12B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 08:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFkkmU+V6LAsiPPlGlYzW7FJYOzOm5q/ZGVxIQJJm0vW6a8f0I/qb1oXHx8tI1hwP+jTElXM4tfeD+mW+G45SS3DYz6+4g0bvwIA003rWr3d0FIl9hN5NMb1NFWckcAQBQdZDMJjM/i/7Xt/AjDsKCUZn1Ha/c5zbdPU0onmIq5chbTXv9JTQmaLo3bT/6Dt4Af2tUrLWjQ7cNQJulkvg64grnCs6+vW1gSXZcOtpyhG1SU6PPwXuObJSyFc+akJkNQ63yub2v4mcA5o4SJX6g9aZed1SCNoCf5194HMh3apjLJ5RIkwMY2cFFYDhSeQL6xJP5nUSnQyOHKijnpLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjYO2ZPCjDHPkbjBIXMqaMoXJrgMNm19VF6QI0KnE7o=;
 b=AiF53O7aKC+y1H45EMJTjAAEkNkFXpnLQe62s2hpnm6SE/TMywca3nTBSSnFxlPP4k1URVbw5zcxZzkmrFDDIz8gskJnvNHJIs84RmJNDQV8Flr7bhXpymdLE4Mh0puzIajs7/jqQgJTY58Pv+O2qaa91ZeURjJr0rtZzOr5z/0edyIY6klkMr0ut3OPMV2MJYnXOxGlX4C0hyUBCawqzLGUIl892LyQEsWKjonAsjnd3XCKzjf1dPaVTzXys4NMVmUqe8RGs7YZ3CkEisAci4Qa+u0FCEMm1ImTulX+yE1PggS7DiDwUyq0iCU7Hou6FZ6byTZSci1pIGhXgH+Ojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjYO2ZPCjDHPkbjBIXMqaMoXJrgMNm19VF6QI0KnE7o=;
 b=F1PdPhl+FvvGNnDfL5F8SDvRMMIBgPjuSXEwsnCVx5j0mRWMAnRuyUnx9tQcqgiJkaMME3lz+RuOUP0jfLB3fZ3Tf6jwyW2W3UzIYfex9azKzSXySgwQGKV+4IyB6NlgGznJw0+Z0XkAheBOwOeRssUh/W1UpmYF9HXTIMZtA/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 08:30:00 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:30:00 +0000
Message-ID: <fa473cdd-df44-3cf8-fee2-eb8d0d9b612d@amd.com>
Date: Fri, 31 Mar 2023 10:29:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 15/16] drm/amdgpu: use doorbell mgr for MES kernel
 doorbells
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-16-shashank.sharma@amd.com>
 <CADnq5_M7xn3kkKhBv4xVRQjteuaHufXOYSEpf=rY7DybyEpojw@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_M7xn3kkKhBv4xVRQjteuaHufXOYSEpf=rY7DybyEpojw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 967510a9-3e07-4019-6586-08db31c21dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXhUnh5QI3cNvkCLs3DgS0YpYUJiK5CHydYx6t5gEEVbLB69LAIYNMBOTJJt2t8xRoQLmN1xjzLRxr77JdQaCYsBpXLczBlzMQJHxZdojTsSdxLBUaOjPPaESkNUG/2wx/VT95g3DWNNWyKCoKRxRq9SrHbJV0rO5GWaunmsc/oSVtrYFK53QtCLxitI9uRann4TGIFpDF+zNRJCAQleWYSYyOi3EJP0wIyJDE5TBQcTKcOlpn6zGKotEP+gpU8oCfda5rU0kMat4sprXgGh2c1xLBiXjaI4BWID7v+TfMMhvZXvdxxGLxXmZy3pdKKS5BymO3H7WcrFP1J7ZllpT6uQpbNi71MiXP8zOKgSC3PpiK79o5XW3c0o8H2fZGPG2TjvBDNQYxgCOvK/RoLFyijmJnm9lDQvHAgid8GCc3967pYqtx3wGjshmpoV1ZWpxLI1W+DZ+HVVpdl0Gsse5P5XGdbaP593Thy1xUeFhsoMScBb1dlp63cmzfjpCQPopJMp0894h/qwsZyphimp+dSkHmrcZVLhZjPgIjMtaDQ5Hmrjgjx94PJB2bMqTlPox9f11umQgw3OnN/z9ViG89WlFIuxUfhuOMGedLAXdrBMq3UZv5LErgtFY/mbbK4sO95cpaHYiDuaL1P0l9jrYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(6512007)(26005)(6506007)(86362001)(8936002)(53546011)(31686004)(6666004)(83380400001)(186003)(31696002)(2616005)(6486002)(316002)(38100700002)(2906002)(41300700001)(44832011)(5660300002)(478600001)(36756003)(66946007)(66556008)(66476007)(8676002)(6916009)(4326008)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXE2dDZ0U29RdUFyb3QzM0ExZXNkc1grSXlmamFDM3RZQXdhTVlnaVhSMU9w?=
 =?utf-8?B?RHJleDQwMzJVTTFTcXRKZExEUDJ0YlBta3JBbGN2eXdydTFNZEN5Rk94K3Rx?=
 =?utf-8?B?ZyszSkhtbWNoYmtid0tqd2FKWlMxN21GS0xiTHBDUTJ4dC9zNUo0REdJTWxm?=
 =?utf-8?B?Uld6V0N4dlJHTjdJRlpGU2VzNWl5TlZQZXBkQ08zQzdKQ0p3dm9BU0tXTm43?=
 =?utf-8?B?YlMyWnZpeGsrQnd4andDQ3ppOE51N3A4SjNsWjB3bEdEdWlaL2ltMUtNZGZp?=
 =?utf-8?B?UysveEpPb3d5c0pvK2xvVlZJaU1CQU9WcUFPVGdFdGJGNUo1b2ppcHJhTlFo?=
 =?utf-8?B?c1VURkhTSFFzODE4MzV3YWxkUEY3ZHBNdUFVMFNoWWF4M056cmh4azhSTUpw?=
 =?utf-8?B?ZCtTdkd1V2R2NlZVRy9wOERZOXdYRGNRUlR6Y1FnNkh3TEFENFQ3WnlYVk12?=
 =?utf-8?B?ZE92YTBsSGppeTZRWnVwaFlUZG0vMDBEOTZVdHM4UTF6aXlJRWh6WDRzd0Q5?=
 =?utf-8?B?S1BnOXQ1a2h4MXVlV1hmdTQvK2FhQ1NYbUlVb1RxUTdiTTRYcUJJbXYyU282?=
 =?utf-8?B?MHJFOW5vMmJRRjBSZG1kT3ZuZXJzNVhPL0w0UCs4dHk0TkNtL24yWUZKRGJD?=
 =?utf-8?B?ZzUrVVBMZ2d3amRGMFlqalNRMU9aZVN3QWlhL2luVDZtM3pkT3FBZHYzaTA3?=
 =?utf-8?B?UmpJYmZPdXg5QStFay9GRE16MEhQTk1RbncxMm5KS2tyT2M0NG42d3Zha3lv?=
 =?utf-8?B?Sm91UnRQUllaUFZ5QmdpNTU1OXZuQ1hqNDBYanRiS0kwdGdFY1Nqa2R3eW1n?=
 =?utf-8?B?VHd1TGhvNjcvcmNGWWVLL1duZW5zUDZFbi9KMWdmL0pTbmtDbTVVeTBiWDl5?=
 =?utf-8?B?UHZHMTVyQVQveVY3L3lrc2hLQ3VNTnZSS1A2MWIvMllxUWQ2MUd6cWV5aFo0?=
 =?utf-8?B?dXBZb2NHOUNBTG1ReHRKLy9vWHlqN0p1L1VqZDhlWkg0ZGEwVU5kTHU5RDFV?=
 =?utf-8?B?RlZFZ3VrQlB2eFUwVnZsWUxDSEVrckZGVVhheWtnWW9BYjBNMTZKYmE1eWtw?=
 =?utf-8?B?MnV1UHBpdlBwVDFzaW5NTHlvTVpITHhVRm1Fd21wZm4weXVCOS9VK0dLVGhj?=
 =?utf-8?B?SWxjaythRGNiOXZHdUpjcmVyTmY0RHRBYTM3SHl3MUpPcjB5NUFJUXFrN0k2?=
 =?utf-8?B?bDZnOVluYjIzRUU1a25naHI0VkVTNTdDOU9iUkM1Y21ZeW1GcERJYUNnTG9C?=
 =?utf-8?B?Tk9yWks1c1lRODBLbnAzYWpIdmFqWmJBZzk3UmMzVlZQN2VnRWJ4K1pBSHNk?=
 =?utf-8?B?cTd6aUQxcU05MDNTdWYwQkhxaldNbFM0dDBvVitmRlkzdVorS3ZOUG9RN0NX?=
 =?utf-8?B?azRnclVINWpGTXNGdjlRRUFhMXZ3ZC9qQVUrQUR1a1BwTjBrZVRTTE9kamk2?=
 =?utf-8?B?UFZhaW14QnRKcDVNUHlKZEpDb0JDdS9PbTdDdkQ5eVhsdjZhYWtZUnd1Kzcr?=
 =?utf-8?B?Yk9rRTNJamxtYnZPeUVwb2dkTGYydEI3NURDdiszUUlwMERhYmhGL3FUSU9i?=
 =?utf-8?B?VjZDdnlVbXNDRWlvU1dEeVF0RW8yVk5DbnNrVVpVdU5VYzJsUytNNGplMkJp?=
 =?utf-8?B?eExLSWdsamdWbWpORXRNNXd4dStUVTdtdUY0aDlSelZEeEpGWmpvSzA2V2xQ?=
 =?utf-8?B?bFJoWFlQY0NNdmJxdHorWlY2cVNkNWpwRnpJcFI2MUU5cFFTUDgyTHBqVEEr?=
 =?utf-8?B?WSt1YzJEK3dBUWlyQisyZnQyLytkVERLTEdxdFdvTDR6dzA5VFNYcWJHREcw?=
 =?utf-8?B?MTlTVXhnbTkyd3hwTGJ0MlJpcTl1VnlzVUpiV2oyL2VndG9SajlmbVNTYXhL?=
 =?utf-8?B?U2lXSmNNNmRVQzBoSGFtNjNhNE83TGdBRHlhVG9yUkNVSCs1dElnU1pHWE9W?=
 =?utf-8?B?elZVY3Rmd2VsZjJjKzMxVjRKVkZCN0pVdGNlOXhmZ1JnczJyY3Y3OVVLeEtQ?=
 =?utf-8?B?QmNSVlA2dklpMG5qbEFpSmlra2FiOTFaZU5jZ0pRcHUxNVVoMk9HVmIzWlVp?=
 =?utf-8?B?K3IzUW92WC9mS1dtM2tRMXd6aVQvSTZPRmRKZFdxQXVuNDNqSVZheWF1OEh4?=
 =?utf-8?Q?gVvEPM5lj/jnvz9yMCWRenegg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967510a9-3e07-4019-6586-08db31c21dcb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:29:59.8932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQ9gNxrSBvBhsNYLgeuupKpOuB4uxAecnIWoc7c5084smjviE5wt7UEtHKlASK1sxPcBCntSSINjEX6Hg4ie0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 22:58, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 11:48 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> This patch:
>> - adds a doorbell object in MES structure, to manage the MES
>>    doorbell requirements in kernel.
>> - Removes the doorbell management code, and its variables from
>>    the doorbell_init function, it will be done in doorbell manager
>>    now.
>> - creates doorbell pages for MES kernel level needs (doorbells
>>    for MES self tests)
>> - current MES code was allocating MES doorbells in MES process context,
>>    but those were rung using kernel doorbell calls. This patch allocates
>>    MES kernel doorbells instead for this in add_hw_queue.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 105 ++++++++++++------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |   5 +-
>>   2 files changed, 56 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 0c546245793b..423cd642647c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -65,91 +65,89 @@ unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
>>                  doorbell_id * 2);
>>   }
>>
>> -static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
>> +static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
>>                                           struct amdgpu_mes_process *process,
>>                                           int ip_type, uint64_t *doorbell_index)
>>   {
>>          unsigned int offset, found;
>> +       struct amdgpu_doorbell_obj *doorbells = &adev->mes.kernel_doorbells;
>>
>> -       if (ip_type == AMDGPU_RING_TYPE_SDMA) {
>> +       if (ip_type == AMDGPU_RING_TYPE_SDMA)
>>                  offset = adev->doorbell_index.sdma_engine[0];
>> -               found = find_next_zero_bit(process->doorbell_bitmap,
>> -                                          AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
>> -                                          offset);
>> -       } else {
>> -               found = find_first_zero_bit(process->doorbell_bitmap,
>> -                                           AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS);
>> -       }
>> +       else
>> +               offset = 0;
>>
>> +       found = find_next_zero_bit(doorbells->doorbell_bitmap,
>> +                                  AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
>> +                                  offset);
>>          if (found >= AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS) {
>>                  DRM_WARN("No doorbell available\n");
>>                  return -ENOSPC;
>>          }
>>
>> -       set_bit(found, process->doorbell_bitmap);
>> +       set_bit(found, doorbells->doorbell_bitmap);
>>
>> -       *doorbell_index = amdgpu_mes_get_doorbell_dw_offset_in_bar(adev,
>> -                               process->doorbell_index, found);
>> +       *doorbell_index = amdgpu_doorbell_index_on_bar(adev, doorbells->bo, found);
>>
>>          return 0;
>>   }
>>
>> -static void amdgpu_mes_queue_doorbell_free(struct amdgpu_device *adev,
>> +static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
>>                                             struct amdgpu_mes_process *process,
>>                                             uint32_t doorbell_index)
>>   {
>>          unsigned int old, doorbell_id;
>> +       struct amdgpu_doorbell_obj *doorbells = &adev->mes.kernel_doorbells;
>>
>> -       doorbell_id = doorbell_index -
>> -               (process->doorbell_index *
>> -                amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32);
>> +       /* Find the relative index of the doorbell in this object */
>> +       doorbell_id = doorbell_index - doorbells->start;
>>          doorbell_id /= 2;
>>
>> -       old = test_and_clear_bit(doorbell_id, process->doorbell_bitmap);
>> +       old = test_and_clear_bit(doorbell_id, doorbells->doorbell_bitmap);
>>          WARN_ON(!old);
>>   }
>>
>>   static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
>>   {
>> -       size_t doorbell_start_offset;
>> -       size_t doorbell_aperture_size;
>> -       size_t doorbell_process_limit;
>> -       size_t aggregated_doorbell_start;
>> -       int i;
>> -
>> -       aggregated_doorbell_start = (adev->doorbell_index.max_assignment + 1) * sizeof(u32);
>> -       aggregated_doorbell_start =
>> -               roundup(aggregated_doorbell_start, PAGE_SIZE);
>> -
>> -       doorbell_start_offset = aggregated_doorbell_start + PAGE_SIZE;
>> -       doorbell_start_offset =
>> -               roundup(doorbell_start_offset,
>> -                       amdgpu_mes_doorbell_process_slice(adev));
>> -
>> -       doorbell_aperture_size = adev->doorbell.size;
>> -       doorbell_aperture_size =
>> -                       rounddown(doorbell_aperture_size,
>> -                                 amdgpu_mes_doorbell_process_slice(adev));
>> -
>> -       if (doorbell_aperture_size > doorbell_start_offset)
>> -               doorbell_process_limit =
>> -                       (doorbell_aperture_size - doorbell_start_offset) /
>> -                       amdgpu_mes_doorbell_process_slice(adev);
>> -       else
>> -               return -ENOSPC;
>> +       int i, r;
>> +       u32 agg_db_start_index, nbits;
>> +       struct amdgpu_doorbell_obj *mes_doorbells = &adev->mes.kernel_doorbells;
>>
>> -       adev->mes.doorbell_id_offset = doorbell_start_offset / sizeof(u32);
>> -       adev->mes.max_doorbell_slices = doorbell_process_limit;
>> +               /* Allocated one page doorbells for MES kernel usages */
>> +       mes_doorbells->size = PAGE_SIZE;
>>
>> -       /* allocate Qword range for aggregated doorbell */
>> -       for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++)
>> -               adev->mes.aggregated_doorbells[i] =
>> -                       aggregated_doorbell_start / sizeof(u32) + i * 2;
>> +       nbits = DIV_ROUND_UP(mes_doorbells->size, sizeof(u32));
>> +       mes_doorbells->doorbell_bitmap = bitmap_zalloc(nbits, GFP_KERNEL);
>> +       if (!mes_doorbells->doorbell_bitmap) {
>> +               DRM_ERROR("Failed to allocate MES doorbell bitmap\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       r = amdgpu_doorbell_alloc_page(adev, mes_doorbells);
> Rather than allocating a separate page here, just allocate two pages
> in the earlier patch where you allocate the KGD doorbell and then just
> use the second page here.

got it,

- Shashank

> Alex
>
>> +       if (r) {
>> +               DRM_ERROR("Failed to create MES doorbell object\n, err=%d", r);
>> +               bitmap_free(mes_doorbells->doorbell_bitmap);
>> +               return r;
>> +       }
>> +
>> +       /* Get the absolute doorbell index for aggregated doobells */
>> +       agg_db_start_index = mes_doorbells->start;
>> +       for (i = 0; i < AMDGPU_MES_PRIORITY_NUM_LEVELS; i++) {
>> +               adev->mes.aggregated_doorbells[i] = agg_db_start_index + i;
>> +               set_bit(agg_db_start_index + i, mes_doorbells->doorbell_bitmap);
>> +       }
>>
>> -       DRM_INFO("max_doorbell_slices=%zu\n", doorbell_process_limit);
>>          return 0;
>>   }
>>
>> +static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
>> +{
>> +       struct amdgpu_doorbell_obj *mes_doorbells = &adev->mes.kernel_doorbells;
>> +
>> +       bitmap_free(mes_doorbells->doorbell_bitmap);
>> +       amdgpu_doorbell_free_page(adev, mes_doorbells);
>> +}
>> +
>>   int amdgpu_mes_init(struct amdgpu_device *adev)
>>   {
>>          int i, r;
>> @@ -248,6 +246,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>>          amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
>>          amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
>>          amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>> +       amdgpu_mes_doorbell_free(adev);
>>
>>          idr_destroy(&adev->mes.pasid_idr);
>>          idr_destroy(&adev->mes.gang_id_idr);
>> @@ -677,7 +676,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>>          *queue_id = queue->queue_id = r;
>>
>>          /* allocate a doorbell index for the queue */
>> -       r = amdgpu_mes_queue_doorbell_get(adev, gang->process,
>> +       r = amdgpu_mes_kernel_doorbell_get(adev, gang->process,
>>                                            qprops->queue_type,
>>                                            &qprops->doorbell_off);
>>          if (r)
>> @@ -735,7 +734,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>>          return 0;
>>
>>   clean_up_doorbell:
>> -       amdgpu_mes_queue_doorbell_free(adev, gang->process,
>> +       amdgpu_mes_kernel_doorbell_free(adev, gang->process,
>>                                         qprops->doorbell_off);
>>   clean_up_queue_id:
>>          spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
>> @@ -790,7 +789,7 @@ int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
>>                            queue_id);
>>
>>          list_del(&queue->list);
>> -       amdgpu_mes_queue_doorbell_free(adev, gang->process,
>> +       amdgpu_mes_kernel_doorbell_free(adev, gang->process,
>>                                         queue->doorbell_off);
>>          amdgpu_mes_unlock(&adev->mes);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 97c05d08a551..e7e9dfe44c99 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -27,6 +27,7 @@
>>   #include "amdgpu_irq.h"
>>   #include "kgd_kfd_interface.h"
>>   #include "amdgpu_gfx.h"
>> +#include "amdgpu_doorbell.h"
>>   #include <linux/sched/mm.h>
>>
>>   #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
>> @@ -76,7 +77,6 @@ struct amdgpu_mes {
>>          uint32_t                        kiq_version;
>>
>>          uint32_t                        total_max_queue;
>> -       uint32_t                        doorbell_id_offset;
>>          uint32_t                        max_doorbell_slices;
>>
>>          uint64_t                        default_process_quantum;
>> @@ -128,6 +128,9 @@ struct amdgpu_mes {
>>          int                             (*kiq_hw_init)(struct amdgpu_device *adev);
>>          int                             (*kiq_hw_fini)(struct amdgpu_device *adev);
>>
>> +       /* MES Kernel doorbells */
>> +       struct amdgpu_doorbell_obj      kernel_doorbells;
>> +
>>          /* ip specific functions */
>>          const struct amdgpu_mes_funcs   *funcs;
>>   };
>> --
>> 2.40.0
>>
