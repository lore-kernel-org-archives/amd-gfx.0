Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85F6C77B71
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 13:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F12EE10E27C;
	Tue, 25 Apr 2023 13:10:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B22810E27C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 13:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLfAWEyEHpblwNFT2emEBSg0cw/qCSQKvwqM7Ttt/VIg5pdLcl1VXasigbMbmrk7abfqyzGiX3jyl+3oc1iBO3PKoocbYPMi3De1ApB+njIMT9MW9vEh2/CDiXGCwIys9ue+rchuxLQJGtYnePPX+Xjc7Z54UHcxsst/LbO8Avxq1chCzbiuLt/xK3UPm1PpbQyJU5diZsDJyXUlQNuv9X0yJI536e2jAYQMRnfyEHpz2Y2XWFPTcVXdbEPyQMoNgj5PGrpqBXkJenVzOYkxbuGICZORHlQVyJxArQHmDdQLqhZeFCPRu9azK/+dM08E8sjVcTIaDRf1c8l5Wdcafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW/N+icYFzfbfrBi2Mq8anGYnMxzklMdAsufbZfWalE=;
 b=OH6W43hOgvUdAeGN8mdFurvCa4ZeERLi7CSEYVn7do00+yBg/RKqJEK30SLpxHcptpkhzcmYmc/M9k6vjDCHt3VK8Zl6HXQc/UnER4vCeQEAWr81V7H6DATCJIcC0YH2lgE2dGMylL1RLfn46c2ZcXXT0HtZqNGrs0y/0sR8sOFxyvNp8zlREQr8d2peq7dPYdGyP+pnHDZPlpDSqs3dKiYJhOVI4SpKxS5tdQTlVjQsvfl5MKl5FvHRJoObcnw66/VmWjSUi4PThugwUHf6FZkgz0srEFVOL3ATs+BGbbITD/0U8EVBCxsujX9N2nVB32fTDpMGpGjdAqYxEeKWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW/N+icYFzfbfrBi2Mq8anGYnMxzklMdAsufbZfWalE=;
 b=dLjyRRQhwdS1S+7ZcHcvP0OSJxK19pcNM64ewkQJmUSxUFZ4r8Shgo7aI4/8IWkKONdDkWr3cSBC/+SfV7AHHqsdcDKM/xa9fCldn4tQH9rXXiPZz+tRO3oubh5U1ITooT9IDsXy84AdUvaeQ7BYjup+Eyfa67CunHrp7x9fEC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Tue, 25 Apr
 2023 13:10:12 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 13:10:12 +0000
Message-ID: <eed1b460-27f2-00a7-8016-fb866628db49@amd.com>
Date: Tue, 25 Apr 2023 15:10:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 04/10] drm/amdgpu: create GFX-gen11 MQD for userqueue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-5-shashank.sharma@amd.com>
 <8670d699-dcf9-f8e9-a11d-e87bb40643d4@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <8670d699-dcf9-f8e9-a11d-e87bb40643d4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d35d92d-3f7b-4894-4491-08db458e66d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rj0j0121GFvo0xSilU8bZAfxUsKNdXHhc97wQiMTE+uHDDEpYJX0Fxx8YoiYEgkc54WSZImxqYHjSJaqLe/dGi9tpMrStLiCYdjafS8rSHILkbUAkm4VKBiF8HddDJhiSzkhychqiVbowtN84DvZaVxVqMjqVWBAACdTLmXgMwyRkAhAx/N8ZdRz++NrxzXwtO+bXoy596n8oeJLWrQT3WSjmthgzl/CIIM5QyEY+La2uNO/x0DIxmJCuTKaedYopfkwhzL7ZjSfWo/mfQfm55/e/XQ7GLuzYzSnJu3m1utkfV36OPfuu9AuEGBmwOa3yOcqMCN+ZjNf7VA3ufchPMH6FozcqKGCuFSBO+fmfO+OSQB8B+RAddThCrx3bwAdAR1s9F2ePZEKtm90ZUsSHUvdUcRR9TDjcaWZLbjDTA5t/JF8pHAmbj2t5jY/nVbapobb0HJT2bKKnZ7icFGP68YSuM23724uuzEvNuPJEU1sfZDN3wuPPRjCSGZtgKO8vrIZNn4g/QGvtO8hOMVkaz3h2Hb0XJKpMSIrp+XFDhNLZT6pcDRmFggq1FlGK6RitVDcXrRS6wCkhmEamCXr5njd3/x1focGHiLrqPfLVHs5IewcmnVQe0ANCJIQ1ovcVIYVPGVuU7I74mu8u8pl+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(36756003)(4326008)(316002)(66946007)(66556008)(66476007)(2906002)(8936002)(6666004)(8676002)(6486002)(478600001)(5660300002)(41300700001)(44832011)(31696002)(86362001)(2616005)(6512007)(6506007)(53546011)(26005)(83380400001)(66574015)(38100700002)(186003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFFjU0dJUWVPRlMxNGNlTytCOWt0TXc1L0gweUJ2R3hGMjUzQ2xER1grcHpk?=
 =?utf-8?B?WWZXelZLVk9xM040eFZsMnJUZVZ2NGR6eWh4M0NXSDVzRExBaXYxLzdBanBG?=
 =?utf-8?B?cmZza0FZWVZHRkVLRzhnQWp4Vk1GMUtpdmxnb0syWll3cnRIRGZyV2Y5Q1I5?=
 =?utf-8?B?a0I2NXV2RkRQRWIzOC9kUjBuUjNlOEFCM2l5bHVuMkRlY0p4di9JWlI1c0Zi?=
 =?utf-8?B?L0dmUkV5bHZkWmx1NTZLSHFLaHZzbCt3TGRYVVBlWHZLTE5ud2c0czk4Zms0?=
 =?utf-8?B?NlNpRGpieWNqU2Q5UWVuWllsaVY3elVvOEVBYThUN0p6YjlTeVVRVE1za1A5?=
 =?utf-8?B?UVBjWHFDUm9Kc0Y5TmVtaDN4dU1qZXIzZnBsWi9JOHJTLzVxYUFWYnJpQ1F6?=
 =?utf-8?B?UTFzMUFnRE5nQnR2b2pDL3dtRHMrUVFBZnJtT0VpcVdubXVvMUlRRk1CRmtB?=
 =?utf-8?B?aWNReXljKzI0Y0VhbG8wSUNjeWpwbXNKb1ByTHdYSzBwTjJRVDF2OUNQbGI2?=
 =?utf-8?B?T002RHVVOWVXYXgzOUppR3ZJL0tIL1ZmczRqenh5L2JVc0lYbTZ3VWMrNkRE?=
 =?utf-8?B?T0I2bGFWRkNuTmd4WUVoQVlYdjhUSGtWeVRhZmR1NHNQUDBVc1N3Mk42aDFC?=
 =?utf-8?B?SEI1ZzIzZWYvV2dLdmVYZlR4SHVUaXpVQmlQdjBvRTh6TTBydUdEVUZkZG5F?=
 =?utf-8?B?TjlyRzJ0dmEvYTZna3BpTVlPTEdydWFvT0VOVm5QcVhrKzJBeWNhVnE4U0Jh?=
 =?utf-8?B?MmpqSkhTU1lPcUEzTGpFaDJEVlhnYmlZdW1NQmtOWiswOElrQlFuTFVlNUVJ?=
 =?utf-8?B?bHRJWVQ5MlhheG1sQjRjUE9Jek5DNTJUODM2cEJuMjJGTi8zaDlFdGs2bkRw?=
 =?utf-8?B?cTFHNTlxMDZma05aTDNBOG5SL254QTFyakhUdVpxWXZHQTUrSGh1eHI2Tmxv?=
 =?utf-8?B?SnFlVmtTZFZITXB1T2VTYTU5QkxDdEVoY1NNNjlEczVrTTU2QVRUL3VBMFRP?=
 =?utf-8?B?aUpqVS9sMW83RzJRRHNlMXZrcUJGekNSWEZPWEd1cTNjemt4WnZmbzRzQ2p5?=
 =?utf-8?B?elZPTGxoMnNsNzlFQVl2MTlnU0x0MmVRWUJZNnFncS9PSUlHRjl4TkpRL2pj?=
 =?utf-8?B?ajNoTFJMMjg3Z29sbk1GTkpUbDlCK2FzbEl1TlFacWs0VFdmVjBDQWxmZmJu?=
 =?utf-8?B?WmJocXNmLzVqa21hWnk4aGhzYkNOVEhhK3o0YzNjU0ZueThNTFMvemZGdnhl?=
 =?utf-8?B?OEYxdno3YnlPcUpZRUtmRU11TnB6cklvV1lLc0liSmo2QXhzUmVrUmYvUElW?=
 =?utf-8?B?QnZDM3RITEdzWmcvVjB1WWZrUkpMZFVNSFp1QVFtTTBZbC9KaFh1dDNzK3ZF?=
 =?utf-8?B?MzFNeFR1QllkUW9PTGlWQkY1aFRsRnduZWZvaG1WWXh2b0dkZXRKdHY5NXl0?=
 =?utf-8?B?a01yR0lGU2VJMjF6RURTUGtEaG9EMFVxL2YvWHFsZGp3UFZtRS9USXp6Z0RM?=
 =?utf-8?B?eVJNSy9BcjlxZytlUFZHanJ6OGJNbDNTSlF0TEdVZnFrc29WK2lXYmJoMVhl?=
 =?utf-8?B?TXVwejdQN0Z2RFlyNncxTGlqcENnVklMMEx6R1A2ckxHY2VqSnlQVkYxdTli?=
 =?utf-8?B?cmtUWkU5SWRwMkhXSkdPWVBjMGVyMVBuUXhVNzYwR0dTY3IzOXhpRTBzbVVL?=
 =?utf-8?B?U1IzbWhVa2dTTkV0bUVsNjhRNHlHNy9uQ1NtQzF0VXM4Uko0TTNFaVpSNEhN?=
 =?utf-8?B?N0k4ZElBd0pmUmQ4cmdBNXdLUFFpZnlRMWpJMHlPZWxuY3VSdU0xdmtva2RU?=
 =?utf-8?B?WlZFbFZRZEJZZVdFSXJoZTZTNm94Y1NlUnZxRlorc1V1MnY1ZE9IOGJ1Vmk0?=
 =?utf-8?B?UEhiTy9zL21JRFpaSU1wQlJmakJlTkFEa0kyekxyVVBmMTJCMGtQelViY0hJ?=
 =?utf-8?B?bFBoSEN6dXl1eVh2QkVtenphQng4VXhMRnQxaXZhYnBiVEg1dmtia2JYUU9P?=
 =?utf-8?B?S1I0a2NsUnFPOUt4SmU5WGhWQmJJc3ljTCtpQTZ2K3MyOGtzcW5OQ1IzNC9U?=
 =?utf-8?B?eDc3dGtLeVdpSnA2WnBEN05MTU0zaStJdHJyaGlTRUlpbDNodFFjdEQxbXZD?=
 =?utf-8?Q?1mZjn73nt/ugmmKMHw4Y8rC+w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d35d92d-3f7b-4894-4491-08db458e66d4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 13:10:12.1593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxAjNw1vL+vHPZJR1Z0bY5OG71xYwelcZOoRSCM3+zUO/W7OSdajobzKljvlNiS/P2sqmgs2E1x98dUDk6H55Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 25/04/2023 14:27, Christian König wrote:
> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>> A Memory queue descriptor (MQD) of a userqueue defines it in
>> the hw's context. As MQD format can vary between different
>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>
>> This patch:
>> - Introduces MQD handler functions for the usermode queues.
>> - Adds new functions to create and destroy userqueue MQD for
>>    GFX-GEN-11 IP
>>
>> V1: Worked on review comments from Alex:
>>      - Make MQD functions GEN and IP specific
>>
>> V2: Worked on review comments from Alex:
>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>      - Formatting and arrangement of code
>>
>> V3:
>>      - Integration with doorbell manager
>>
>> V4: Review comments addressed:
>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>      - Align name of structure members (Luben)
>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>        message (Luben)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 25 ++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 57 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
>>   3 files changed, 89 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 333f31efbe7b..e95fb35b0cb5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -81,6 +81,14 @@ static int amdgpu_userqueue_create_gfx(struct 
>> drm_file *filp, union drm_amdgpu_u
>>           goto free_queue;
>>       }
>>   +    if (uq_mgr->userq_funcs[queue->queue_type]->mqd_create) {
>> +        r = 
>> uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
>> +        if (r) {
>> +            DRM_ERROR("Failed to create/map userqueue MQD\n");
>> +            goto free_queue;
>> +        }
>> +    }
>> +
>>       args->out.queue_id = queue->queue_id;
>>       args->out.flags = 0;
>>       mutex_unlock(&uq_mgr->userq_mutex);
>> @@ -119,6 +127,8 @@ static void amdgpu_userqueue_destroy(struct 
>> drm_file *filp, int queue_id)
>>       }
>>         mutex_lock(&uq_mgr->userq_mutex);
>> +    if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
>> + uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       kfree(queue);
>> @@ -149,6 +159,20 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>> void *data,
>>       return r;
>>   }
>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>> +
>> +static void
>> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    int maj;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>> +
>> +    /* We support usermode queue only for GFX IP as of now */
>> +    maj = IP_VERSION_MAJ(version);
>> +    if (maj == 11)
>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>> +}
>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev)
>>   {
>> @@ -156,6 +180,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr 
>> *userq_mgr, struct amdgpu_devi
>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>       userq_mgr->adev = adev;
>>   +    amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index a56c6e106d00..9f7b14966ac8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -30,6 +30,7 @@
>>   #include "amdgpu_psp.h"
>>   #include "amdgpu_smu.h"
>>   #include "amdgpu_atomfirmware.h"
>> +#include "amdgpu_userqueue.h"
>>   #include "imu_v11_0.h"
>>   #include "soc21.h"
>>   #include "nvd.h"
>> @@ -6404,3 +6405,59 @@ const struct amdgpu_ip_block_version 
>> gfx_v11_0_ip_block =
>>       .rev = 0,
>>       .funcs = &gfx_v11_0_ip_funcs,
>>   };
>> +
>> +static int
>> +gfx_v11_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>> +    struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
>> +    int size = gfx_v11_mqd->mqd_size;
>> +    int r;
>> +
>> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_GTT,
>> +                    &mqd->obj,
>> +                    &mqd->gpu_addr,
>> +                    &mqd->cpu_ptr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
>> +        return r;
>> +    }
>> +
>> +    memset(mqd->cpu_ptr, 0, size);
>> +    r = amdgpu_bo_reserve(mqd->obj, false);
>> +    if (unlikely(r != 0)) {
>> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
>> +        goto free_mqd;
>> +    }
>
> This reserve/unreserve dance here doesn't seem to make much sense. Why 
> do you do that?
We wanted to make sure that the MQD buffer is reserved until we fill it. 
Does it sound incorrect ?
>
> Christian.
>
>> +
>> +    queue->userq_prop.use_doorbell = true;
>> +    queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
>
> Are those the only two parameters needed? If yes we should probably 
> drop the userq_prop structure and give them directly.
In patch set 1 and 2, everything was getting stored directly in the 
queue, but then we decided to re-use the existing init_mqd() functions 
from each of the IP engines.

If you see the prototype of mqd->init_mqd(), it expects userq_prop 
structure as input parameters, so we encapsulated a subset of queue to 
this structure.

- Shashank

>
> Christian.
>
>> +    r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, 
>> &queue->userq_prop);
>> +    amdgpu_bo_unreserve(mqd->obj);
>> +    if (r) {
>> +        DRM_ERROR("Failed to init MQD for queue\n");
>> +        goto free_mqd;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>> +    return 0;
>> +
>> +free_mqd:
>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>> +    return r;
>> +}
>> +
>> +static void
>> +gfx_v11_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>> +
>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>> +}
>> +
>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>> +    .mqd_create = gfx_v11_userq_mqd_create,
>> +    .mqd_destroy = gfx_v11_userq_mqd_destroy,
>> +};
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 8d8f6b3bcda5..e7da27918bd2 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -28,6 +28,12 @@
>>   #include "amdgpu.h"
>>   #define AMDGPU_MAX_USERQ 512
>>   +struct amdgpu_userq_ctx_space {
>> +    uint64_t     gpu_addr;
>> +    void         *cpu_ptr;
>> +    struct amdgpu_bo *obj;
>> +};
>> +
>>   struct amdgpu_usermode_queue {
>>       int            queue_id;
>>       int            queue_type;
>> @@ -36,6 +42,7 @@ struct amdgpu_usermode_queue {
>>       struct amdgpu_mqd_prop    userq_prop;
>>       struct amdgpu_userq_mgr *userq_mgr;
>>       struct amdgpu_vm    *vm;
>> +    struct amdgpu_userq_ctx_space mqd;
>>   };
>>     struct amdgpu_userq_funcs {
>
