Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA53C636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FE710E45E;
	Tue,  7 Feb 2023 07:55:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F368710E45E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE3sd6vAq7sBGDCsQS7KnYnoUeSXNe+oKl2fCwUscGYPHIcgDdhfGE+gY1myBOdZc0awYvJo6KqCWL94IbwspuZgYC/WaiqDtlGeG2syvfglMz9jssfo48IQHx9+lxmsuJ+MyHosuHNP6VP5hWSHVm3e3y9cY3G9ghSj1BwOM9iru2l0pdX4K2fXyyrKcjOIFf8ZYQsX1jx278E1E8o44KCzonH8JPgCfWC3OpSuiQMsHeDc0TJ0atOfi8Y8Qx2QYcnW0OScMCzzHAfWLmCjAm9fb/qLeT4tMYTo/3ly5erjaAdyRYd9sZMCZlVmYpTa4/iGfZ7m2FcLIoTcan0QTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4KczKujgo1RY1v9sVJGfrLMeFXDyHvWCUzjNmajrFk=;
 b=SpmdFlXrkUwCoYVtLrB3C82UJAiiT8g8pEyUAyOjAzknXNkHGwQufZpMYeKZRPTFQjWULQ714+8kqGQ/aYPOcBTC4zx4AoLhOFtJUis0A33X15MN7sO3zjaRkB0oXvd++eckl4T8IUEgmzA7l6QUzCbO1y7QC83//2zPPoG8ig8tjI8tODosa5tEOlXdziUbEO/bacX/lWdErKgI3Zu3/sxXM5E7DH+SGKQBWXsOgYc0iHA4gtNW6LHB3SFPcDR/Ay+hUVlICbm7J+hL0zhJmHgEURwejeHP/+Da+f1WZOy/i6ct68ux25i8TJmS3feEoI3grf98fqIPsMrUKR1EAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4KczKujgo1RY1v9sVJGfrLMeFXDyHvWCUzjNmajrFk=;
 b=NLg6f8qrGvl6dTtGkCGR3xG1zmgtXI8Jx1LK6HsobocV94advrcW/PQhwJJ8Y8cPxfBmS0M5kmXAxfs2wUG63rGRHsY2ZNoRAV+4MrjKWWCnNT6AdJTneYYvOck/M1QfgoW7FruqqTilFVtIPBU01iVQNv98fDASJYH99EHChCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Tue, 7 Feb
 2023 07:55:15 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 07:55:14 +0000
Message-ID: <26796617-25ff-3f68-6723-d92726153943@amd.com>
Date: Tue, 7 Feb 2023 08:55:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/8] drm/amdgpu: Map userqueue into HW
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-7-shashank.sharma@amd.com>
 <c7a30142-cd29-ada1-6173-df85748d589f@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <c7a30142-cd29-ada1-6173-df85748d589f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9bc7e0-b6b5-4121-61fc-08db08e0a564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ee0c79iDMWAb8biX/WcVsmjeUlCItHISi3M8V/8GkFJ0UsQoP+cOEhpS0P3R+gdTZqcB+nh4OzeGodFhgmKhVaZP2Wc0DbgboZIxcbJXfm7X0o5iH4pEM7e9n0wn2hP9eEGiiCgv/ShmgLoMbJWx03b3BC/gmwej1/hEAJvRBhHnDUkNgcWSTMJThGAOzKjHReIRILXPP5JS+hWupmQQ/3DIKtFKQcIv4N8p5NJjI4mSwHQW7CdCVJpp6YhT+SB+CO1h2CKXwyIz+78RrAU9N3Ed0TyJmQfdcAGT61cr4BAHgZdgtIWZ6GZadefKHj00k4sttHHqhMx1fH/xClgkia9eKRUHRss9ExLO7q4kxg/IIG4JO4tNiu3kBKhR1ff6mtZtsEJJq+0TxfSQ6CBXF3F4UzXnal/Rwo7x1ePdoLHDifoid6UIft25YKoRX1DMKC5+FYTbWagKWpJGoz0EzlRlonRuu5m7/8Wwc4X00oJUEJsm2EzTkvNawwmu+/286tK/nJIdF6t4R03+WjEXJbC7duPYUv1SSNkJbUKZq1wGtNkuqKkliWWiBRHGYDJ8OubmWwd5ZKd7SVkhPSabNlWfmcGMaHVye0niUDYOzYKEB11hPPHrjuHn1dPN1dlWmV7JmjrM9TVgIXP8ZgM+KrPKRXTkJIDNhIqD2MPh4D9zzRn38n0LseZgBiI0zZ8YD5MSIKB7WItsrHPb9ffLb5k0DgN+i2QVLjkl0N3Zs64=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199018)(83380400001)(66946007)(66556008)(66476007)(41300700001)(31686004)(66574015)(36756003)(2616005)(38100700002)(8676002)(4326008)(53546011)(316002)(186003)(6512007)(2906002)(8936002)(26005)(44832011)(6666004)(6506007)(31696002)(478600001)(6486002)(5660300002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExEY0JMM3NDbVlXM3F5aVVadXoyc3ZVVGNsdlJvMGM1cHdia2JTQ1hYN1Vo?=
 =?utf-8?B?a2d2OGJwWmZjZUpOS3pxWm9Qb0w2WlRmQzlwNWR6MVVtblNqZHdkR3IwSXRB?=
 =?utf-8?B?ajF2REpIemxXTC94RHdIdFl0WjJzNWYvRnhiaUdic01rRlFWekJPQ0dxbjZK?=
 =?utf-8?B?VkRwMG9KM0VqYmRkWncxbm1scHRMN2FNbnU2OFlXVStxNlljNWt1YXg1VW0w?=
 =?utf-8?B?QSt0dTRqbHhTRUJESXNvMkpSM3NPZ0Jqamc4SFUvdkxOV3g2Sm9VZkFNdHpn?=
 =?utf-8?B?M0I2N085TGhaYXRsd09pU0tEbXFSR3dRcGZMUmw4Q3N0ZjNzMmlJQU43N1Fz?=
 =?utf-8?B?Y0lhcUxRYmJlVVVUMUc1ZytZb3JZQVUxVCtxV2NLVGlCRFVKZDRENEFPUGhh?=
 =?utf-8?B?eUo5L2YwR1BrUDFKcG95KzRQblNzblhKWGcwVm1kU054SGY1RjIwZ0VVVjV0?=
 =?utf-8?B?dXBFWFN5SU1aVW9lZE41N3BBdW9jOTVSdklpZC8yc0szUzhKOEhDdVVzOEZp?=
 =?utf-8?B?N2hoemUzSUZlMWZPUHBMbFVISWc4S0M4RW4zUzhzUTlvaC9HU2RyczFkQXIw?=
 =?utf-8?B?ZC9SSFkxaGV5dXN6NUFhWmpJZ2NxTEd1M29UV09yNkZ3WnFLK2dCRTFaNnVX?=
 =?utf-8?B?ckZFelorS1lNVndkcHRZQ2NtdFdkaDI4eFBtZkQzVXVEd2ZpUHVvSWRzajZ6?=
 =?utf-8?B?TUdhWFJRWVZzZ1loMlE2NUNEMzEvWjgySk1nRXFwVURPNjBCQUYwTkZFVWZt?=
 =?utf-8?B?Nmd6VlZ2M0lIcmZjeDNFRXFJYjRqUDZJMUErYUFnSlQ5S1JMT2VVMDBGVGdW?=
 =?utf-8?B?ZEFEeHRkMWN5RXhaeUpJR0VKdXE2QzhqMTZyL2o3bVpLdUVIckNWVmp1ait5?=
 =?utf-8?B?SGVNdkwxTFZvVGd6Y3Q0SjA1OWN3akJDMzF3ZVdnc3ZuaS8vWC9PNEY2MVlK?=
 =?utf-8?B?ZjZoOGZ6WDhyZEhZUk5HdCsrU1o3VTlreEcxMkgxaVBiMFpZNkl2WktlaUNa?=
 =?utf-8?B?VDc4OU1Hc0k1bzNhbmRBc3p4ZHA2UUxjc1Q5ZWpBcU80Z2ZjNFlUdlo3QTlB?=
 =?utf-8?B?dHNNbWxvbmlCVWdyM2YrQ1o0YnR2M0kvNGp6eEdRZGhJVlNOd3BvNW1uU2hj?=
 =?utf-8?B?ZlNSTHgzQzRJYlJuWWo3TysvbEtMczVBZzdEaTR2MG9sUlpYQWxiR3orNDh5?=
 =?utf-8?B?VCtCZVQ4d1paWUhYOTdUcFJXWHZPN01QUVJiYlRHd2RzckRMaFhDeW8zRFlC?=
 =?utf-8?B?SEJSMkJYVEZaOUtLV1NoUENqL0l3a3pCaU1oSVBXeE0xbE54NlJzSmp5OHov?=
 =?utf-8?B?Qnh1NUcxNVpUV0h2ZzRXbGN3UkRvL0p6NkFZa1FLS0l4elp3QWVFOXEwN20w?=
 =?utf-8?B?TXVHSDBHUk1ZQk5LOVg5dkRGZFlla0tOV1ZtZ0xIaEZWdXpGUVhLKzZiT2g5?=
 =?utf-8?B?M3dsOVN6ak1LUExITVVoQ0JpSm1qdTZ3aDFSRzVmb0phQ0VXRTRoTWN2SWky?=
 =?utf-8?B?UE1CeEE3SEpxMFMwN0ZpSFBvYUxSMnliazMyd240K0RlcnBKUXB2bnViQkNQ?=
 =?utf-8?B?UmZudG1BQnNML1JjSmRQNEZUS0t5SVUra3Fia2ZUUytOeHdETTQrRDBLYldZ?=
 =?utf-8?B?RVdldVRTOUlKYmt2YmNQRlg1ZU12MWhHRzJMbVNYU3Zwc2hOOTljZ0FsZVV5?=
 =?utf-8?B?SkxnVFBDdVp6aHNablZWQUcvZUVHR0FPVEp1VjV3QXdLdWwzU1lwZmVZL2FU?=
 =?utf-8?B?dytkTUVmVG1PNmlMMldmNHZ5a3ptbVExUkNqN2NJVUVNSEZtSFh0TGdXSkNY?=
 =?utf-8?B?S2tkMFpSQ2kvTmdreDRaTlM4UXhYeFhFMlFvZDRQRllhdDB5aDdBclRSTGZB?=
 =?utf-8?B?bWtlRmlsRHRMQ0FFRHVwYlRQK1FhSDMvRWNTUmVKc3JmOVo4STdPaWpFRkFJ?=
 =?utf-8?B?ZWpJWmh3ZlpnSWlQV3JRRjZ4RXRSemtGYmhzOG1Pa1ovMFloWUdrS3NDdjlN?=
 =?utf-8?B?QXh3Q0RpM1lkdDdoeENyTEc2VWJ4ZFk3MXkyWUJNSFF0ZjlXMDM5ZytRMUJ1?=
 =?utf-8?B?cDduYzhidThqekhLWnQ5cHlvQlhXNFByRDlYRFBzOG1VUk9YTW4rMVZ6ZE1z?=
 =?utf-8?Q?HeUx5uhV9wRVe57h8sUf0r3VJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9bc7e0-b6b5-4121-61fc-08db08e0a564
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:55:14.6541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEvArzvXx+9Il/HMk66j4cBOEBuJmb0Lr6qTnMl83JcS+kAAKZdayBOkgQJNZ43rRLwU+MvSTxcU4rYpxnAq+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/02/2023 08:20, Christian König wrote:
>
>
> Am 03.02.23 um 22:54 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch adds new fptrs to prepare the usermode queue to be
>> mapped or unmapped into the HW. After this mapping, the queue
>> will be ready to accept the workload.
>>
>> V1: Addressed review comments from Alex on the RFC patch series
>>      - Map/Unmap should be IP specific.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 57 +++++++++++++++++++
>>   .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 47 +++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  2 +
>>   3 files changed, 106 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 18281b3a51f1..cbfe2608c040 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -42,6 +42,53 @@ static struct amdgpu_usermode_queue
>>       return idr_find(&uq_mgr->userq_idr, qid);
>>   }
>>   +static void
>> +amdgpu_userqueue_unmap(struct amdgpu_userq_mgr *uq_mgr,
>> +                     struct amdgpu_usermode_queue *queue)
>> +{
>> +    int r;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct mes_remove_queue_input remove_request;
>> +
>> +    uq_mgr->userq_mqd_funcs->prepare_unmap(uq_mgr, queue, (void 
>> *)&remove_request);
>> +
>> +    amdgpu_mes_lock(&adev->mes);
>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &remove_request);
>> +    amdgpu_mes_unlock(&adev->mes);
>> +    if (r) {
>> +        DRM_ERROR("Failed to unmap usermode queue %d\n", 
>> queue->queue_id);
>> +        return;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("Usermode queue %d unmapped\n", queue->queue_id);
>> +}
>> +
>> +static int
>> +amdgpu_userqueue_map(struct amdgpu_userq_mgr *uq_mgr,
>> +                     struct amdgpu_usermode_queue *queue)
>> +{
>> +    int r;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct mes_add_queue_input add_request;
>> +
>> +    r = uq_mgr->userq_mqd_funcs->prepare_map(uq_mgr, queue, (void 
>> *)&add_request);
>> +    if (r) {
>> +        DRM_ERROR("Failed to map userqueue\n");
>> +        return r;
>> +    }
>> +
>> +    amdgpu_mes_lock(&adev->mes);
>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &add_request);
>> +    amdgpu_mes_unlock(&adev->mes);
>> +    if (r) {
>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>> +        return r;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", 
>> queue->queue_id);
>> +    return 0;
>> +}
>> +
>>   static void
>>   amdgpu_userqueue_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>                                      struct amdgpu_usermode_queue 
>> *queue)
>> @@ -170,12 +217,21 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>           goto free_mqd;
>>       }
>>   +    r = amdgpu_userqueue_map(uq_mgr, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to map userqueue\n");
>> +        goto free_ctx;
>> +    }
>> +
>>       list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>>       args->out.q_id = queue->queue_id;
>>       args->out.flags = 0;
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       return 0;
>>   +free_ctx:
>> +    amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
>> +
>>   free_mqd:
>>       amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>>   @@ -201,6 +257,7 @@ static void amdgpu_userqueue_destroy(struct 
>> drm_file *filp, int queue_id)
>>       }
>>         mutex_lock(&uq_mgr->userq_mutex);
>> +    amdgpu_userqueue_unmap(uq_mgr, queue);
>>       amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
>>       amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>> diff --git 
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>> index 687f90a587e3..d317bb600fd9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>> @@ -24,6 +24,7 @@
>>   #include "amdgpu_userqueue.h"
>>   #include "v11_structs.h"
>>   #include "amdgpu_mes.h"
>> +#include "mes_api_def.h"
>>   #include "gc/gc_11_0_0_offset.h"
>>   #include "gc/gc_11_0_0_sh_mask.h"
>>   @@ -239,6 +240,50 @@ static void 
>> amdgpu_userq_gfx_v11_ctx_destroy(struct amdgpu_userq_mgr *uq_mgr,
>>                             &pctx->cpu_ptr);
>>   }
>>   +static int
>> +amdgpu_userq_gfx_v11_prepare_map(struct amdgpu_userq_mgr *uq_mgr,
>> +                                 struct amdgpu_usermode_queue *queue,
>> +                                 void *q_input)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct mes_add_queue_input *queue_input = q_input;
>> +
>> +    memset(queue_input, 0x0, sizeof(struct mes_add_queue_input));
>> +
>> +    queue_input->process_va_start = 0;
>> +    queue_input->process_va_end = (adev->vm_manager.max_pfn - 1) << 
>> AMDGPU_GPU_PAGE_SHIFT;
>> +    queue_input->process_quantum = 100000; /* 10ms */
>> +    queue_input->gang_quantum = 10000; /* 1ms */
>> +    queue_input->paging = false;
>> +
>> +    queue_input->gang_context_addr = queue->gang_ctx.gpu_addr;
>> +    queue_input->process_context_addr = queue->proc_ctx.gpu_addr;
>> +    queue_input->inprocess_gang_priority = 
>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +    queue_input->gang_global_priority_level = 
>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +
>> +    queue_input->process_id = queue->pasid;
>> +    queue_input->queue_type = queue->queue_type;
>> +    queue_input->mqd_addr = queue->mqd_gpu_addr;
>
>> +    queue_input->wptr_addr = queue->wptr_gpu_addr;
>> +    queue_input->wptr_mc_addr = queue->wptr_gpu_addr << 
>> AMDGPU_GPU_PAGE_SHIFT;
>
> Well that here doesn't make sense at all.

Yes, please ignore this, it was based on old interpretation of 
wptr_mc_addr. We just prepared a separate patch to map WPTR in GART,

and then calculate the wptr_mc_addr from it, so this line will be 
removed and that calculation will replace it.

- Shashank

>
> Christian.
>
>> +    queue_input->queue_size = queue->queue_size >> 2;
>> +    queue_input->doorbell_offset = queue->doorbell_index;
>> +    queue_input->page_table_base_addr = 
>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>> +    return 0;
>> +}
>> +
>> +static void
>> +amdgpu_userq_gfx_v11_prepare_unmap(struct amdgpu_userq_mgr *uq_mgr,
>> +                                   struct amdgpu_usermode_queue *queue,
>> +                                   void *q_input)
>> +{
>> +    struct mes_remove_queue_input *queue_input = q_input;
>> +
>> +    memset(queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>> +    queue_input->doorbell_offset = queue->doorbell_index;
>> +    queue_input->gang_context_addr = queue->gang_ctx.gpu_addr;
>> +}
>> +
>>   static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr 
>> *uq_mgr)
>>   {
>>       return sizeof(struct v11_gfx_mqd);
>> @@ -250,4 +295,6 @@ const struct amdgpu_userq_mqd_funcs 
>> userq_gfx_v11_mqd_funcs = {
>>       .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>>       .ctx_create = amdgpu_userq_gfx_v11_ctx_create,
>>       .ctx_destroy = amdgpu_userq_gfx_v11_ctx_destroy,
>> +    .prepare_map = amdgpu_userq_gfx_v11_prepare_map,
>> +    .prepare_unmap = amdgpu_userq_gfx_v11_prepare_unmap,
>>   };
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 3adcd31618f7..202fac237501 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -82,6 +82,8 @@ struct amdgpu_userq_mqd_funcs {
>>       void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *);
>>       int (*ctx_create)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *);
>>       void (*ctx_destroy)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *);
>> +    int (*prepare_map)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *, void *);
>> +    void (*prepare_unmap)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *, void *);
>>   };
>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev);
>
