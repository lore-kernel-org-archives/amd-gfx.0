Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E683DEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 15:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7812A10E583;
	Wed, 12 Jul 2023 15:55:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3144210E583
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 15:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTwfXeomS3rqLcrlBl6tDKWsiJpQr9ovZtANKMoazFYaKjGW+V0cuYpnSCDopAUsyCeBHTH5j1bspizoc/lXfsHHnV1HYXJL00DDBNAsKPNVM5TM+C1E5zwI9YGFuDrerMM7zhg/u2zFRaYJ++f5SggFEQgOlGpC6ivt4GQPnF2MRiw/FI842lxFdtftAhtMnrBLufb4WyJkTc348T8yxXsGi+O0DL0VnT9VugYkhi/AHDN55rMy6Stvxt5ym666RkbslbwB/Q8UDfJl+3mEgF7nDWBawc8EICPwA/V5uLElfoEPA0UJHUEOLHor0ThgDsj//rYqe/GfaSqXluCQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoF6ot8hGj6IXOzT2KmKLX9t/uk38z+oVvAorJn16KQ=;
 b=hq7kEIcsYlTo1Ng5uJucbJDdPuQkrsqElR+GxdDdGvXNvqQqpVnS/miaTaJD/D09kkDq4/jGrtMa/f/HZbLXiTiCasQhHWxs5LF7rMsmCJNhDACJXXDEqY2A8OjRBq1Ygr500gzdKqEU0UZifdP8uyOioHCH21zkr57CmWrmICzJ4dB5TW6QCHGBp4W9Y7gW8UfDEKE9qYJYy+BfuKZy7+qFaAEWsyUaa2+rar5Xgp2yt2qHZzX+zgGnk2a3DgLFiEsZ2JbA0FxQMozioj84hLWqnrUFKTLjf2cZxhG/EAOqIj+PuvQmRqW1f6lkUNF6mr6JZiRkMlXJk8TSWnYkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoF6ot8hGj6IXOzT2KmKLX9t/uk38z+oVvAorJn16KQ=;
 b=sAkoXyS21Q5xuDqGvuKTSdou4oBTeY8Gs40D8Z/nL+jGHKQBTYewTuy3uNn+9QGzTLEL9UNsbi9qeI07Z1KvHT/NV1GSZDw0UybNxKy24ootPo8z6LB7cV03CRjUdlnO+JHjF0035K/AMU0SC6hHtkvxLld4BMsBD0tBbPQunLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 15:55:21 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::178f:15ce:51b7:8a45]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::178f:15ce:51b7:8a45%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 15:55:20 +0000
Message-ID: <9cac0523-8596-c64b-93be-9d3425ca3c25@amd.com>
Date: Wed, 12 Jul 2023 17:55:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
 <56fbaa22-285f-1030-1822-36d542de4ecd@amd.com>
 <c87cd5f9-b940-0bad-6cfe-c8640693b426@amd.com>
 <e669c8cd-9fc2-73c6-c8f0-140695f17156@amd.com>
 <435820e9-1680-3687-4930-bf7ea5967568@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <435820e9-1680-3687-4930-bf7ea5967568@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0418.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::21) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: db3c7d62-527a-43ab-c707-08db82f064c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYJY1E2Qv/eDKUq28Jjdg9eSiRsc+dDDxe+fN3PpWH9B8x4Kec2c1vTHZNoPb3gujsBxGENqJxp8AWLGBOwRrgyvcL54tS+WyurG4YJuxVPFEItt9l2WFkv6EnQEzDS4Ps/pvVa33o9cJEwV8UbtZRozxK0AEbZe4uZVTCwAkQu5FY+9fkZsD7t4OKw6LnazY2me2pcBF/ElNZFSVk9ParUPfLlnJKkzwipE8qtOPa2QLF97DzxZAHVOz7PWIDQ3RTI0MJMFIgmMNLmn/MYCrVAr2WxEdaY/cHQe6ob1yvgc/k3XOZuqrV4NLURAku+Qx2UyQtoS1dAlIlh/pAvuZs++yZ2YH5wJ10MU1ZHlAwjT69vNTN9vpOZn6wzFvurKwXgT2/dVnQ2tEuponKk0Gh3YL3fh7UGkTX6DYHZFtqjlRPyb7j3TnzdaBwvuRi3nNAy6jcp88WmibE5bVjKkS5+qX9Vz7XQ3viIy/Zhljqxmvdk5C38tmkFICUc6E6Cbx265PXBHZgjOlal0OTlMROzcxpNFcrtJdo9VQ3M/iHE4vedj4F5vsvGBSX5J4a+Vf5LoP2Z523RyNSDZ98xZmXNbkft4zblxwNIyWPdetq4ONPGasZR9V1KTOfpxTtBKrExx0vSzR1F4BSFXSR0PCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(5660300002)(44832011)(31686004)(26005)(41300700001)(66476007)(66946007)(8676002)(2906002)(8936002)(66556008)(6512007)(6486002)(6666004)(186003)(6506007)(53546011)(316002)(4326008)(38100700002)(83380400001)(66574015)(2616005)(110136005)(478600001)(36756003)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enVFem8xWFNoZC9VeXZaR005ZVZOVnpyRVIvUG9zNWVyTlMyanplNWk0Rmgv?=
 =?utf-8?B?QmRpS0NVWmgwZHZRMEhtaDl4KzJwNS85WUFZRkNvTXBsUlRJN2oxTjU1b09H?=
 =?utf-8?B?aUppQ0hsQkM1eHJVQkpQVCtrT2hWUm1rbjRZeTVxQVNaZ2h2dEd0K1FzT0Q2?=
 =?utf-8?B?RTg5aThPRXp1cTNIdlRvUWRKZDFTT0xCaVFTdDQrUTlvRHN2OTFyQ3hrNVNq?=
 =?utf-8?B?dGlFWndnNWkrVzhCTEI1ekg3RTAxY1QwSFZ4bDhPYkpDb2VmUGV6UnBvR3E5?=
 =?utf-8?B?MTFaUHRWc2hoVE1TVzRDY2Z0WUJobDY5RkhUSHpZZjJMZ3JlM1BqczVUNk1l?=
 =?utf-8?B?WGp5dGFqRDNUMk5WcVloemwwVmhKa0l0YnpLclYrSm90b094TlFhQU5JalZj?=
 =?utf-8?B?NHVxSy8wVjQ3YktIUjRPR2FXSklvWjdyNXJQMXVMcExMVjdWS3VSbEF1R0RI?=
 =?utf-8?B?UUNJVHJZZXJQaFFXRHlmT0dDK1U4YnFmbEhjOW5PS1YxdHEzNG9GanBBLy94?=
 =?utf-8?B?TEpGUWcxZmlBTEZ2dHYvY051a1UxSndGdzZPODRKUmtuTXVmeTY0N2pqcDJQ?=
 =?utf-8?B?VHBXVTJWdWtZM3RoTUh3S1BrL2l0eTJYazErRDJNd2hmY0taYnBCK25iVkFq?=
 =?utf-8?B?dWx2YUhkb1VoYmZJOFh6K1FCRUcrMlkwcHJIQXhPdU0xMGl3WkRCUVozVE1o?=
 =?utf-8?B?Z2FHdVl3eVoxVzNEREI2dHVSTzRnQ0tJMEQ0R0VHTGo2MmpTL0ViTE5Bcjky?=
 =?utf-8?B?NFJnRWxaQXpOa3lRZktuOUtGM29wZG9CSk1rSmdJVExsYjJGbDgwMm5oaFpl?=
 =?utf-8?B?NXk4TUdlbEZYb3NmL2doY3NGZmQ4UTF0WE9QNEo3ajQ4Z2dIRXRHcTdYNkxV?=
 =?utf-8?B?cW03VThYcUlWU2ZYZUhQL0JVaTUwYW4xdGdOYWd6L2lIb3VOSERvVDdpQy9v?=
 =?utf-8?B?amdkMnhTNE5GS1RHcVorWEhjbzhEUTk3UlA2cEdMYnZIaWlBdkEzQ1pRRXlp?=
 =?utf-8?B?Q2R6bVpRMUhBa245Ullob00wT2QvTGNBd0lwLy9mcC9GVXBJVU5KQTlLcVRn?=
 =?utf-8?B?Nm0zbjArZnIwTG1PWTl3VWlmUGJ0KzFvVWFzVlBmVGxjLzQvWVMwTlNXUzhv?=
 =?utf-8?B?Z285WndYMWJ3ZGRBaHZpTitOdHVDOUE0dWIvSUFpb2owWDA2OU1UclFlMU5N?=
 =?utf-8?B?dXg1bjduYzQ3d1BhbTRLVStVM1RGdlZSRkNFZG5SUkJTUHNqZldBczlIa3Rh?=
 =?utf-8?B?TVRDUC8zam1PZHkwdVB0M0VET0tPMmQ0ZjlpRXJEekw2T3Yxc1hrRS9ZLzdp?=
 =?utf-8?B?cXQrc1R3OHlzbVlmalRtdDB6NjREdmtZV2xFUy9pMnBsRll3VHF5SFRKRFVL?=
 =?utf-8?B?WmhEQ2xQV1NLRUd4enBNajV3ZGwvdFdvNk5KZ2p3TEFMN0VFcGxQM3hUTk9Y?=
 =?utf-8?B?bE40QTVFblZnQitLd0VHTE1scEM4a000RjlSbzdwSHNsNmNDZE1yT2FGdHdD?=
 =?utf-8?B?OHZRcm9YVFBwVDZreGV1UTJQWjhpWmxTRVovVnczWjBLaFFNRHptZTFhS0RR?=
 =?utf-8?B?aVpXM1NRNEZmSHJXWGNqMGgzZkhFR1B3Qmo5dkI5SWhhZVVyd1NVZGIvNlVm?=
 =?utf-8?B?bkRLRU5ReFl3NlQxZ29KczA3THdqdEJZaEhoVi9WZDBKZWVHVm1VN3NrM1F6?=
 =?utf-8?B?L2ttcWNNOU13dFpOQUFQZUpaYjg4NWYyd1JiNkRTeitwSW9aMlo5aTFvUWEr?=
 =?utf-8?B?RjFtajNLZkV4aGNNWkZRa0RWbmNGOS9JYlcrTlRUUnc4cmF1MGxBaGZmSVZr?=
 =?utf-8?B?RlMvUDg5MnlaTGpqdU53K0ZPTXVocTR5RURob0dESjJ6Zk9rR2IxRlVkWVZz?=
 =?utf-8?B?VzFiWHlFQlR4bnBKWjd1MUJGbXJ3T043d2plYlRNbHVxNHVwNXJFSCtxbTZ0?=
 =?utf-8?B?eFd0clpyTGxPMG9pRHU2MnIrTFljU00wTllSZi84ZE1IdlJsZXF4YjN0NTF3?=
 =?utf-8?B?dW9YVldDeXlUYUoyYmtlR0pQU0NQSjhsMGJlZy8xK2g5WTlPZHFUdURCayts?=
 =?utf-8?B?WTBWRFh5bUVFUEpxUkFYN1lhZFBmVk5hdTVjeXNsc3Ixc1g5dEErdEh6aTBW?=
 =?utf-8?Q?1qK14K3BXP6ziTzj/l01kgd7J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3c7d62-527a-43ab-c707-08db82f064c0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 15:55:20.8646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCazGjodPsQCi8TyGlx36j1wess9Br00PLWOec1wc2CaaFEnQvRdSG1mid5w26MkdyCi7MgrIUik55bTgUnUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 11/07/2023 21:51, Felix Kuehling wrote:
>
> On 2023-07-06 09:39, Christian König wrote:
>> Am 06.07.23 um 15:37 schrieb Shashank Sharma:
>>>
>>> On 06/07/2023 15:22, Christian König wrote:
>>>> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
>>>>> the hw's context. As MQD format can vary between different
>>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>>>>
>>>>> This patch:
>>>>> - Introduces MQD handler functions for the usermode queues.
>>>>> - Adds new functions to create and destroy userqueue MQD for
>>>>>    GFX-GEN-11 IP
>>>>>
>>>>> V1: Worked on review comments from Alex:
>>>>>      - Make MQD functions GEN and IP specific
>>>>>
>>>>> V2: Worked on review comments from Alex:
>>>>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>>>>      - Formatting and arrangement of code
>>>>>
>>>>> V3:
>>>>>      - Integration with doorbell manager
>>>>>
>>>>> V4: Review comments addressed:
>>>>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>>>>      - Align name of structure members (Luben)
>>>>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>>>>        message (Luben)
>>>>> V5:
>>>>>     - No need to reserve the bo for MQD (Christian).
>>>>>     - Some more changes to support IP specific MQD creation.
>>>>>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 
>>>>> +++++++++++++++++++
>>>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>>>>   3 files changed, 96 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>> index e37b5da5a0d0..bb774144c372 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>>> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device 
>>>>> *dev, void *data,
>>>>>       return r;
>>>>>   }
>>>>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>>>>> +
>>>>> +static void
>>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
>>>>> +{
>>>>> +    int maj;
>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>>>>> +
>>>>> +    /* We support usermode queue only for GFX V11 as of now */
>>>>> +    maj = IP_VERSION_MAJ(version);
>>>>> +    if (maj == 11)
>>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = 
>>>>> &userq_gfx_v11_funcs;
>>>>> +}
>>>>> +
>>>>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>>>>> struct amdgpu_device *adev)
>>>>>   {
>>>>>       mutex_init(&userq_mgr->userq_mutex);
>>>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>>>       userq_mgr->adev = adev;
>>>>>   +    amdgpu_userqueue_setup_gfx(userq_mgr);
>>>>>       return 0;
>>>>>   }
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> index c4940b6ea1c4..e76e1b86b434 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> @@ -30,6 +30,7 @@
>>>>>   #include "amdgpu_psp.h"
>>>>>   #include "amdgpu_smu.h"
>>>>>   #include "amdgpu_atomfirmware.h"
>>>>> +#include "amdgpu_userqueue.h"
>>>>>   #include "imu_v11_0.h"
>>>>>   #include "soc21.h"
>>>>>   #include "nvd.h"
>>>>> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version 
>>>>> gfx_v11_0_ip_block =
>>>>>       .rev = 0,
>>>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>>>   };
>>>>> +
>>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr 
>>>>> *uq_mgr,
>>>>> +                      struct drm_amdgpu_userq_in *args_in,
>>>>> +                      struct amdgpu_usermode_queue *queue)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>> +    struct amdgpu_mqd *mqd_gfx_generic = 
>>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
>>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
>>>>> +    struct amdgpu_mqd_prop userq_props;
>>>>> +    int r;
>>>>> +
>>>>> +    /* Incoming MQD parameters from userspace to be saved here */
>>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>>>>> +
>>>>> +    /* Structure to initialize MQD for userqueue using generic 
>>>>> MQD init function */
>>>>> +    memset(&userq_props, 0, sizeof(userq_props));
>>>>> +
>>>>> +    if (args_in->mqd_size != sizeof(struct 
>>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
>>>>> +        DRM_ERROR("MQD size mismatch\n");
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), 
>>>>> args_in->mqd_size)) {
>>>>> +        DRM_ERROR("Failed to get user MQD\n");
>>>>> +        return -EFAULT;
>>>>> +    }
>>>>> +
>>>>> +    /* Create BO for actual Userqueue MQD now */
>>>>> +    r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, 
>>>>> PAGE_SIZE,
>>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>>>> +                    &queue->mqd.obj,
>>>>> +                    &queue->mqd.gpu_addr,
>>>>> +                    &queue->mqd.cpu_ptr);
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>>>> +        return -ENOMEM;
>>>>> +    }
>>>>
>>>> Using amdgpu_bo_create_kernel() for the MQD is most likely not a 
>>>> good idea in the long term, but should work for now.
>>>>
>>> I was a bit curious about this, the scope of this MQD object is 
>>> kernel internal and used for queue mapping only, userspace doesn't 
>>> know much about it. Do you still think we should not create a kernel 
>>> object for it ?
>>
>>
>> Well we should use a kernel BO. But amdgpu_bo_create_kernel() not 
>> only creates a kernel BO but also pins it! And that is problematic 
>> because it allows userspace to do a deny of service attach on the 
>> kernel module.
>>
>> What we need is an eviction fence, e.g. what KFD is already using. 
>> Then the BO is created similar to how VM page tables are created, 
>> maybe even using the same reservation object.
>
> KFD doesn't currently use eviction fences on MQDs. Those are pinned. I 
> guess you could treat the MQDs more like we treat page tables. They 
> are allocated in kernel mode but protected with fences rather than 
> pinning.
>
> I'm not sure if MES needs to be able to access MQDs while queues are 
> not mapped. If that's the case, pinning can't be avoided.
>
I was planning to do something like this keep userqueue objects from 
eviction:

- Add a new mutex in queue struct (say userq_eviction_fence)

- lock this while mapping the queue, and unlock it while unmapping of 
the queue

- add checks in amdgpu_vm_evictable() to add a 
mutex_trylock(userq_eviction_fence)

Does it sound like what we want to do here or should I need something else ?

> Regards,
>   Felix
>
>
>>
>> But for a test this here is probably ok.
>>
>> Christian.
>>
>>>
>>> - Shashank
>>>
>>>> Probably best to add a comment here that this needs to be improved.
>>>>
>>>> Apart from that looks good to me,
>>>> Christian.
>>>>
>>>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
>>>>> +
>>>>> +    /* Initialize the MQD BO with user given values */
>>>>> +    userq_props.wptr_gpu_addr = mqd_user.wptr_va;
>>>>> +    userq_props.rptr_gpu_addr = mqd_user.rptr_va;
>>>>> +    userq_props.queue_size = mqd_user.queue_size;
>>>>> +    userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
>>>>> +    userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
>>>>> +    userq_props.use_doorbell = true;
>>>>> +
>>>>> +    r = mqd_gfx_generic->init_mqd(adev, (void 
>>>>> *)queue->mqd.cpu_ptr, &userq_props);
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>>>>> +        goto free_mqd;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +
>>>>> +free_mqd:
>>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, 
>>>>> &queue->mqd.cpu_ptr);
>>>>> +    return r;
>>>>> +}
>>>>> +
>>>>> +static void
>>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, 
>>>>> struct amdgpu_usermode_queue *queue)
>>>>> +{
>>>>> +    struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>>> +
>>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>>> +}
>>>>> +
>>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>>>>> +    .mqd_create = gfx_v11_0_userq_mqd_create,
>>>>> +    .mqd_destroy = gfx_v11_0_userq_mqd_destroy,
>>>>> +};
>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>> index 55ed6512a565..240f92796f00 100644
>>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>>>> @@ -29,6 +29,12 @@
>>>>>     struct amdgpu_mqd_prop;
>>>>>   +struct amdgpu_userq_obj {
>>>>> +    void         *cpu_ptr;
>>>>> +    uint64_t     gpu_addr;
>>>>> +    struct amdgpu_bo *obj;
>>>>> +};
>>>>> +
>>>>>   struct amdgpu_usermode_queue {
>>>>>       int            queue_type;
>>>>>       uint64_t        doorbell_handle;
>>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>>>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>>>       struct amdgpu_vm    *vm;
>>>>> +    struct amdgpu_userq_obj mqd;
>>>>>   };
>>>>>     struct amdgpu_userq_funcs {
>>>>
>>
