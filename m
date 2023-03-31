Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761BEC76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 08:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0821210F140;
	Fri, 31 Mar 2023 08:49:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AEC710F140
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 08:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjzR12QYevCatsdkmLK+P9urtQtTn1pMFBTVVL9ytCHFaK1n0c5nhoMdip52gyfqsGJIJKLFjoGXBMQOatKtx0AkwoDVfRoY7bNvm/0XVWMcgXBhLiDaGv0If81C2akvn4TVDacaKvpM324Rn/cluqWzjKUdrWMfaeVeZ4RaQPWrL4IDNDM3Z4IIY+K+q0wRXELCexDgTufpFOmTGtclUmsmbyxQ+knTCwm1rIwYKN1Yj9SvhJvUf7npXJ+EpTlJMYjccjVhXEeehtCNfQWn+m6EHa25Ww14jAKyo+7UmkSD3kg6zs6Vk+Z7+ro9T1udr4V+kXdR+xgaRNsCerYUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35enR5GspV/E4UBO2AKmjmJ3gfZI13FyQZWehwHAds4=;
 b=HgItMYs/smPjfWPPmNX6jbCBSVYmk8EaVjWzvgUpJWWxNlDmD+/WIfD3MUGjbo3x6fJnF9s8mY+dR7wsS6Tn9PxB40/SzxS3X3VPfwEXcQs8M8XAuE+ffmFiTBmKnXjWTJVlhnuun9T5TJE9Tr6xjx423qP+h749qrKQxBLUEAEzL2TaAfB9skh/KlNYUruI+ASIBZtJ+CLtMcCsq2V3+Rdq5IkgmtI/OGCdPZeF0rTpO+AQZkB3eOj0DxMDMJncnlUP8SYAusL8M0MKj3BdcVqPleEMpOEd/3GiLKr+lkm2l8xOWbOKWkdSfVfTxpqvDtpLr7TuBSkhqU9xaSrq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35enR5GspV/E4UBO2AKmjmJ3gfZI13FyQZWehwHAds4=;
 b=l9k8aETmQqLtGYt+SrxhJXybhU4qaCNiDPM3OReN41Oq+mRS5bKLCaDIZehYh1wWc2DnO8Kp7ocw7bWh7R0C+DmWF9nsQtdOrC5xuJUCoEtevSw86wvV6IVKMgDY8OFvEQ5eITWI+eokFBaj9WkLQhIZxv3zK2PyqqrUU3TCj6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 08:49:10 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:49:10 +0000
Message-ID: <d18595d0-6a12-4466-1bde-b1ff4e4e834b@amd.com>
Date: Fri, 31 Mar 2023 10:49:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 4/9] drm/amdgpu: create GFX-gen11 MQD for userqueue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-5-shashank.sharma@amd.com>
 <CADnq5_MpcdLZVqaFbAAg+4yEwAtYzU7Sf46z7xy0jXKRCm9drg@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_MpcdLZVqaFbAAg+4yEwAtYzU7Sf46z7xy0jXKRCm9drg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a3a103-5f9d-43f6-2058-08db31c4cb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2d0pQiy8GqLpENt9srciRZsjdjAeXhT+1cC3Hscu6Nj+1oUG33XXZqwll/iG8sfNKF6ftD9riNnKYcZoJURmGeer/OP66TLJqTwicfTuvwv6aEV/h1Coa+H8knEZGr4X5y+U2/TvrcYPQdP1rMCzAzRTwhNP+oINOHHJ5Bx2PSqTvaLTZ8ofDyF1BlIv044Hslo7MKDItxN9y79Fl4dE3QjRtwaIgliloxE7Au93Hbz7VH+auiIyCwMDe6YV8aMMq8pNjNgSdeKPmu69Xeq6fnpJyQCzuqXBunolQp3aQif5X/V9R9+a42g/6qIaAOTG5Gsyu/5ILVqRW1ahxuzBYuNZ7bVqA35FFp5OFwBu6kVlkYUT0b3xV/GWb5RD6q57zq1vZohyKzcUnpxPkBz+YCrY/I8bB+MyR0lnmsu2rirJZJZH0AzLCXQ6QxDE/HDyLhLlIUn+/xL8W1FHX3Zv74XRhocvB6KjhU05nUe84Sq1EMdNW+xZlz9lS0VdwUvestKStx5plKqwQy9T/PkiUd+F6nzlkfymaDuNXBh2WGZFdfyaYAAKHzI4VTvP5k01BlPIeWy1xZVCd5Ur9t7haoVLutg6vUFKyw5ucU3gXrf/I6K8wa8vUuGbu1UqsGS6hrKRjWM0xyANczdnPiIBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(53546011)(186003)(6666004)(6506007)(83380400001)(26005)(41300700001)(2616005)(54906003)(66476007)(66556008)(478600001)(66946007)(316002)(6486002)(6916009)(8676002)(38100700002)(2906002)(36756003)(4326008)(86362001)(31696002)(5660300002)(8936002)(6512007)(44832011)(31686004)(66899021)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1lLclhuWjMwVTNETSsyaFVsbmc1UFRpdmdwUzc3Z2lOc2JybmV0REZZM1Fj?=
 =?utf-8?B?QTE2TUt1SC9iN3pWK2o4bVdNZHJGQWVCamk5TXhNYU5aRVl6YVVGbmlRR1lW?=
 =?utf-8?B?WS9Sanc1d1dIbmpLN25WVkRvVnljLzdQRzZ6WVFpcXp3dFR6SVYrRHFsZ1JQ?=
 =?utf-8?B?aEVWV3kwRDM1Q3NqN01WUmJwQlllZkErZ0NGZmJaVUwxRGN3ZUZOODRNN2Ja?=
 =?utf-8?B?Q1dKTXdPRW5XbEdEeERVeFE1T0hlcWVRaFVkZk80bFVSa3lCbSt3VGpPRFV1?=
 =?utf-8?B?cHFxYWhUTStxNjEzYytiUUROTFl3S3g5cWVaVWt6b0g3N1hiUUNBemJUL1BH?=
 =?utf-8?B?R3RxSjF5WkIwY2hqQ0p5Q0pONGFaOVNnZzdhOENlK0NVMFhRSnV3TnYvaHRh?=
 =?utf-8?B?ZlR3b0F2THFkUmEzKzdscFR1NExjT0VySERtR2NBMSt6UWw3Wk83ZTNUUWhs?=
 =?utf-8?B?S0NSRVVDcklCZ2x4UnluVk1TVlNVT05hT2FvQXY3Y1BLVXlheDZ6dWxEV2p5?=
 =?utf-8?B?V21RNFlLcE4rZ1QvVkc3N043RGtvQ3VtSVE2b2pKc1ZsV3FpeHdiWUk2akJr?=
 =?utf-8?B?aFV4MnZ2Nk15S0dCeEJjcWEwQTFRUnVSYXkzc3AydXRGanZCdmFoc01heENL?=
 =?utf-8?B?N3kwUmJqUCsxQ3BLTWFmTEJxZ2YzcFNFNlNKM2Zzdy8rTXRIYXUvNHdWNkh2?=
 =?utf-8?B?aUxaTkJYVlZLRFNnV3J1ekcrVm1kWk1qL1ZEVW5yNktnZ0E3SVVBOFhEY1ZN?=
 =?utf-8?B?MDNYbnhyaVRRZnJGSEYzazBlbHNGMXpLMWZDdERZQUNnbUYySm5sb0xDa3h3?=
 =?utf-8?B?WEo2amlHd1Qrb3ppNitvMGZ2QzZEQ2JhS3FtVXpWRVlWRTZXa2cwRjlvWWNa?=
 =?utf-8?B?UDNZZ3d6SEgwZHlEcW92aWNHL2RTRGtxcUVzRUtwMWZRMG1JQXltcDBzQktu?=
 =?utf-8?B?Q1ZTVFcyQWkwVnJpUGUyb3pZR3NCQ1Vkd3dGelVGTFlHYTZBQnJiNEszRGU1?=
 =?utf-8?B?TjBodjhXc2srUDEvQytVUS9tZWNjQXFOTU1OUkZXQWl5eDJHTE5STlJiV2Fs?=
 =?utf-8?B?alp3ZGtUK3R2dFBiNVhlL1RqTys3S3V5NHFaZVJXZFJDeEY0a1VvS09KZ2c0?=
 =?utf-8?B?cmlJcmNLRjNCM2xDWUJ2R2VkM0M3WmlDa0twbjloVEpmQlZQRTJOUVdJczFF?=
 =?utf-8?B?amZaejBLVEMzTE4vTlZ4UXFGR2R4TWdvMVBxZEFaNkR1dk5XODVkVkhDMEVL?=
 =?utf-8?B?R0hFLzhXQ0FBU1ZsQUdvMWhoM3h0cExXNUF1U3h4cGk4R09lMWdjV3ZaS3hM?=
 =?utf-8?B?RTAzZHZKVU5pVkk0WDhETUhqZ1E2OTlTK0thSEtZZmVaN2hoNmxtMDA0MlJu?=
 =?utf-8?B?bnBob1BzSmh1bFUzTDVTUWNHR2J4aGhpVlRRMjkxUzJaRlA1aHlNUEw3YUp2?=
 =?utf-8?B?MGlZcW1haS9QOEs3UGlVNmpPN3VIdCtoTnAvdktYaEt4bzdvaVBrYzFlWEV0?=
 =?utf-8?B?MzVxcDBGZjE3ZHRQakc0dkhZaVBQSHNXSGNoVjRGbUJGdm5CVnFwZ0JaVkdp?=
 =?utf-8?B?cFJVSW11NjBhbmtLK0twZm1na3ZtZVRIS1puMkROallwSklHMGRhTFRPQ2NI?=
 =?utf-8?B?eVRPVVNvbWlENU00M0hrdnhvd3dOQzVlQjZ6MnY2U2RsWlFHeEplbDZaKzky?=
 =?utf-8?B?aTRoNldKWHRsYlNpUWhqNWwya1pxVXBZSTZVR0h0U2RzOG1neHMwYjBYVDNu?=
 =?utf-8?B?Y24xTmIvL1FmNFFzSGdwQVp1Q1VmSm5xd0t5anN0alVkaGpqNFZ5cW92bU1B?=
 =?utf-8?B?U2h1cVFEVm9vSG1LWmF4L1ZlRzEyVkQrSGJLbGpvT0tnZEZwbDhpY3RmU1oz?=
 =?utf-8?B?dVY2N2RPSFhuTjRCYWNJZ0VuMFYxM3MzT3M1TXNNdXUwazV6ZXZvdmVzRXMz?=
 =?utf-8?B?TWtsd0tuUy9BYzlIVkNJVldQemFOcVBQYWZVbDB6KzljNlFGUnVKeVRvbmND?=
 =?utf-8?B?V1FqRDR5WWQyYm9TQ0RNK2MwSTFKQ3VORVZJRWlvc3lVR0tFSFZWaFdhVEk4?=
 =?utf-8?B?NHhQd1AvRHRHdDRUNW9jSDQ0MXJNdDhhRDNHSFpNTmlscmx1Q1FXQy9qSm85?=
 =?utf-8?Q?9k13Tq9qPSPG89UZMyldu6dCU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a3a103-5f9d-43f6-2058-08db31c4cb45
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:49:10.0040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KT92jgZh5Rm+P/4LSIPA2mRV/yLk2z2LItuqCaNFUuU8mzlyrUSEfywFOdqjaLp9MBMAfWUXyR3pcatpXHmk9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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
Cc: Felix Kuehling <felix.kuehling@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 23:18, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 12:05 PM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> A Memory queue descriptor (MQD) of a userqueue defines it in the harware's
>> context. As MQD format can vary between different graphics IPs, we need gfx
>> GEN specific handlers to create MQDs.
>>
>> This patch:
>> - Introduces MQD hander functions for the usermode queues.
>> - Adds new functions to create and destroy MQD for GFX-GEN-11-IP
>>
>> V1: Worked on review comments from Alex:
>>      - Make MQD functions GEN and IP specific
>>
>> V2: Worked on review comments from Alex:
>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>      - Formatting and arrangement of code
>>
>> V3:
>>      - Integration with doorbell manager
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>>
>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 21 +++++
>>   .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 84 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>   4 files changed, 113 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 2d90ba618e5d..2cc7897de7e6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
>>
>>   # add usermode queue
>>   amdgpu-y += amdgpu_userqueue.o
>> +amdgpu-y += amdgpu_userqueue_gfx_v11.o
>>
>>   ifneq ($(CONFIG_HSA_AMD),)
>>   AMDKFD_PATH := ../amdkfd
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 353f57c5a772..052c2c1e8aed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -81,6 +81,12 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>>           goto free_queue;
>>       }
>>
>> +    r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create/map userqueue MQD\n");
>> +        goto free_queue;
>> +    }
>> +
>>       args->out.queue_id = queue->queue_id;
>>       args->out.flags = 0;
>>       mutex_unlock(&uq_mgr->userq_mutex);
>> @@ -105,6 +111,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>>       }
>>
>>       mutex_lock(&uq_mgr->userq_mutex);
>> +    uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       kfree(queue);
>> @@ -135,6 +142,19 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>       return r;
>>   }
>>
>> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>> +
>> +static void
>> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    int maj;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>> +
>> +    maj = IP_VERSION_MAJ(version);
>> +    if (maj == 11)
>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>> +}
> These can be per device and done in each IP's init code.

Agree, but as we have validated usermode queues only the gfx IP (gen 11) 
so far, we deliberately enabled only for this IP.

Once this code gets stable, we can gradually validate and add more 
engines and IPs, and then

we could also move this whole initialization code in IP->sw_init() as 
you suggested.

>
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>>   {
>> @@ -142,6 +162,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>       userq_mgr->adev = adev;
>>
>> +    amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>>       return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> new file mode 100644
>> index 000000000000..12e1a785b65a
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> @@ -0,0 +1,84 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#include "amdgpu.h"
>> +#include "amdgpu_userqueue.h"
>> +
>> +static int
>> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>> +    struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
>> +    int size = gfx_v11_mqd->mqd_size;
>> +    int r;
>> +
>> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>> +                                AMDGPU_GEM_DOMAIN_GTT,
>> +                                &mqd->obj,
>> +                                &mqd->gpu_addr,
>> +                                &mqd->cpu_ptr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
>> +        return r;
>> +    }
>> +
>> +    memset(mqd->cpu_ptr, 0, size);
>> +    r = amdgpu_bo_reserve(mqd->obj, false);
>> +    if (unlikely(r != 0)) {
>> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
>> +        goto free_mqd;
>> +    }
>> +
>> +    queue->userq_prop.use_doorbell = true;
>> +    queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
>> +    r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
>> +    amdgpu_bo_unreserve(mqd->obj);
>> +    if (r) {
>> +        DRM_ERROR("Failed to init MQD for queue\n");
>> +        goto free_mqd;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>> +    return 0;
>> +
>> +free_mqd:
>> +    amdgpu_bo_free_kernel(&mqd->obj,
>> +                          &mqd->gpu_addr,
>> +                          &mqd->cpu_ptr);
>> +   return r;
>> +}
>> +
>> +static void
>> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>> +
>> +    amdgpu_bo_free_kernel(&mqd->obj,
>> +                          &mqd->gpu_addr,
>> +                          &mqd->cpu_ptr);
>> +}
>> +
>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>> +    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
>> +    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>> +};
> We can just stick these in gfx_v11_0.c.  No need for a new file.

Noted,

- Shashank

>
> Alex
>
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 7625a862b1fc..2911c88d0fed 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -27,6 +27,12 @@
>>   #include "amdgpu.h"
>>   #define AMDGPU_MAX_USERQ 512
>>
>> +struct amdgpu_userq_ctx_space {
>> +       struct amdgpu_bo *obj;
>> +       uint64_t gpu_addr;
>> +       void *cpu_ptr;
>> +};
>> +
>>   struct amdgpu_usermode_queue {
>>          int queue_id;
>>          int queue_type;
>> @@ -35,6 +41,7 @@ struct amdgpu_usermode_queue {
>>          struct amdgpu_vm *vm;
>>          struct amdgpu_userq_mgr *userq_mgr;
>>          struct amdgpu_mqd_prop userq_prop;
>> +       struct amdgpu_userq_ctx_space mqd;
>>   };
>>
>>   struct amdgpu_userq_funcs {
>> --
>> 2.40.0
>>
