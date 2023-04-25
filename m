Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951B7C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 13:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2950510E2A8;
	Tue, 25 Apr 2023 13:28:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E05610E2A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 13:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDUfEjR1FM5fTDQTnU7hhVln38nf2Kh/se6YLZRgN5nY+tm7g7zCzClQXHDCSPobnJNWk+lR3KCz9/I8PhJ4I3KPT5y8Q3ifOBFIHtOf+Yk9/qc8ATjmaLM2QJDw0lZlGYHVl6CodgwNBgUG/q0ec9M+q+zW6RLGvav8o096i0rEBGLl6ojYvnm1P1XvT42t9IsIm91+x64ueFk3Af31NDCBUlJLd3YSmrOXW40YrYGcpDly9CM9dN2SzsxjWbwzlZARvY/m7G5uLkX+H9RWYdLCIybq4PzBKzj4HaXNm8HPIIcHqX5Vp2oLxha4HM+Dc9LjYD+m/NJdeD4Kbs/0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hA7XJUztvi5257pqCJAjsmK8vdek5LxrILLV26ieDIs=;
 b=fHDfECnND8th7b775F0V1glAe4xjjPIN5E1Q7LZangOcank63q1I5LudOueftHGD8m5UOfMjhId37kfRELCl3f/3kMH73hCB9/QtDwnwf8/TMR6F+jKK7aztt44A592akiC221obw3HkWMMBJR/Dus5bjfi284UuEMQPwWQIVY6wmdJsdiVGRgpE2J5bLuyzmQr/Kr2Q+CNCkypyclaNr4vCNlhd68vx/YztcrM9Gg2qRq/JM5CI9KM6wnzyrM3am5cn6YzJCAphfkDNWbVM2jYV5ONGhkdvseZKgTqeXuM7M+GJ6t9XB9GaDk2PGNZjfLVQF1H9ivL5TZ4Qnq3sww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA7XJUztvi5257pqCJAjsmK8vdek5LxrILLV26ieDIs=;
 b=XflgZVfLTgVV3g2S2ekDPWRV/h7sqobyVvaXfAwzaSRRwTMu4wgJB81bnNTt4mYkYqiV/TkaQlz5Nx5adtvBKV0i0WvA73E+GkgioLF4Pl1e2h/k0YKLyU7gW2Nifn45Zl7Nm8kK5M4SV64s36u4oHPqWeppPHL3ZYFfqy+aFko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 13:28:04 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 13:28:04 +0000
Message-ID: <c3d4af85-20ce-a6f2-d4fd-525693d51bd3@amd.com>
Date: Tue, 25 Apr 2023 15:27:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 06/10] drm/amdgpu: set FW parameters in v11_struct
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-7-shashank.sharma@amd.com>
 <3ce3210e-bc0a-bcf5-a83f-629c1792ad43@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <3ce3210e-bc0a-bcf5-a83f-629c1792ad43@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: aea28e59-fc33-45ad-7cbc-08db4590e5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQGWgDmMYxDWiL0e3RpEkrv80hXWS2OxByfY156RzNMU1LcUfF937M7g6gBeprQk7IJiWXx5JLxh/YiqJHSGtM+ed6l/L8yMQbQhaDppNfww20o0BOycK0ZB+xh76K48IStG4TKdWYKV+IdXVun88LRGlOKoJvDPUF/jOvdeWVOR8Xi/XjounMcuIMAsdzTaujTw2EWEIHsEuQl72ulBP+/ab331DYWFoAy9a7/+EhVKgpEv7jqpVug7hQE7O3f74hRrgioFMm5edC1gHZho9Z0ojJqxytUIPJUDqzo9jDPX94rSR0nyzA0UBTjZ5z4f/lxPTC7pnJwvQBT+Tg8bhiuuLNk0FsXEjWAcfvhm73Si2xaIw+fuzSmqavD7By1IgojNJxAIDAYHcAFOi70xYoyEqZkxiCkYK45NPutimVBQd81Lomi3lsywEH5xJHatbiXYudFNiwlXiELhMXBfjDZt4penM04Z5S7dgYpMlIjqr4YY2D5GG9yYdRIPXbBCzMgIWOA1OAzw0VKFMjVgjMYpuYdEx1MOIhssStV5GnkyNJ9PECwHVBpXCP80XEV3GkHUdxZjMDXJv0wmvOAiP1wm0QTz5WaLYXBbNPy8RA/IpQhhAReu/MN+aRY6+FRsTQQ762yOFCwJ92BTJ7TVIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(478600001)(2616005)(83380400001)(53546011)(6512007)(26005)(6506007)(66556008)(6666004)(6486002)(66946007)(186003)(66574015)(31686004)(41300700001)(38100700002)(5660300002)(44832011)(316002)(4326008)(86362001)(31696002)(66476007)(2906002)(8676002)(8936002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FTL1J5OUZHVDVPZUFsWlFnSUJWbitmRExRcWEwYzl2T0thcVAvdWJxUTUw?=
 =?utf-8?B?YlVBdGNCQ3dNSGRYRUhCR1N4TFB1by9IZG0vSk1RcW9IVWNYWDN5THhZZHZD?=
 =?utf-8?B?VCtrZHRrTUVuUnRiTWNURkV1OWp0c0VIa3g0dDJZaFV3YXkvekFpZDVXVUJU?=
 =?utf-8?B?UVBDaDJUT2QzUzJRY2xYZXY0K1pMOGxoSFdjQ1g4ajZSNi9RZS9jWDFQcDNN?=
 =?utf-8?B?QnM1NTV3U0c2dDBlSk9YYzZWNFdDWURpeTdyb211ZnB2eDRjRU40Z3k0aUZt?=
 =?utf-8?B?cGw1cXBnZVdCam5uM3JuM3FZMmNDZHJFNjVNcDRhMncxYlU1aTdTK3pYZlZj?=
 =?utf-8?B?TWVueWVWcGM3M25BWDl6cW5zeE9GcFdOa2xNdjRUTWRBdzY1Rm1aZVVzQUZ4?=
 =?utf-8?B?cUR6Z1Z5blcrU282dG12NDR5MGZtOENVSFQ5clViOE5kZFdxYmpRb2dGSDhN?=
 =?utf-8?B?Q043WjlGTUJmMkh5eE9pVVhHVXNaeERHUy9YTG93V0lRUGtoTE9aMlZ0WU9V?=
 =?utf-8?B?OG5PK0hBMU02V1FOL2Fkc2J1M3RjaGI3ZEpYUHM2YVFuYU9kSVlmKzZsQ1dF?=
 =?utf-8?B?RVlHSjFBT1lDN0FENmxNVzZBZSt2VU01UEI0dm8raHhUcUd5TzVmd05YRUxj?=
 =?utf-8?B?SmVJYnEwVHFMZGpVajB5dmY1WXVRdHE4S0hDYVkwWWI5dU1na3pLd0J4SlhL?=
 =?utf-8?B?eDNRdXdlbytiTmJNY01TOHpRQXVBZ3BtKzRGN1VOVzVDcVFCQ0hMMDFNVE5V?=
 =?utf-8?B?SUV2YzUybHlUTEJVL3lPYVdsUndJeHhGK0ZkVFBYejBxc3o5cjl2YURQUVNr?=
 =?utf-8?B?UGtIM0hJLzdaMW43S0JOL2ZtdjdQMi9wSXh1WkhKQ3J2NkxCSjNCUzhMSmRH?=
 =?utf-8?B?dk9CNEtzNFNCZXdMRlRDWTk1Tk0xQ3RUaG5Wdm9hWXNXQnBrZzA0Q1VBZFBN?=
 =?utf-8?B?MDNOcXRVY0FrSnRUYzlTbUxJWnBTVGduTC82djhWS3BsZXVFZWxsUDFtQVo4?=
 =?utf-8?B?NmFOVUNyR0cyekR6bnZ0TFBlZ3MyUXNqeFdpdVpPK3JhNHE5WDJQbzFpSTNv?=
 =?utf-8?B?aFVxQndTQ25peXNLbXNsSE40eFV1b1hZaXdoQUp1TnBldjExckJpc2RpcWlo?=
 =?utf-8?B?c0k3VHRzYXJuaUM3Mmp0enpYUHE2U080TktMdDBaYWJCWXRqTXlXQkQwdk9y?=
 =?utf-8?B?RkkzRHBDQytMbE5lWmF0THUzOC9YTzFWVXljNnZ4eCtUYzU3M0ZzdnBXR2RY?=
 =?utf-8?B?T0dtclVENDE4WjdaSDhPclRHT1pEUnpQekZOT3lzY2J0QVZMQjhhcnNzZXJZ?=
 =?utf-8?B?R3pubUhBZzg1dC9MQVNkcUU2S0JkSkZ0K0diN29Ndmg1RkRmY0M3dUhUMSsv?=
 =?utf-8?B?NU5jVWtDNjZ2dEFmUHh3dGtGNzJydXZIZkVVV0I4R1JtU2F3bERnYW9LOEtV?=
 =?utf-8?B?VDl6Wnc0SGZWWWxuRERLejAvdXBDZTY3ekxiVXF2blN3ZHdET0NteVUzZ1BZ?=
 =?utf-8?B?U25kRk8wVU1PTUZVOUt4K0kzOE9UeTk4MlFnYTJPQ2orc3oyY3k3aHdINk9t?=
 =?utf-8?B?NDdlRkJIMUthRWZnalJJUk95dlFqWGV0dVY3djhsNkxUbTBVaDRNREkxaHEv?=
 =?utf-8?B?NW9xTjlrekVXM0Rtc20yNnpibmJ1aU1RZFhMRGxzTGg4VUVjRnR1S0haSTZn?=
 =?utf-8?B?bUphajdPN01pS3M5MmdXNFFUaUM1cThJWi81N1liblpuSjFtV2l5OW9McWY5?=
 =?utf-8?B?UHFscHM1VFo1dnV3SW01OENnMWtDZ1JXdHBzbXUxL1kyUjB3bkJlM29rU3Ux?=
 =?utf-8?B?YTNSbXl1cVRNY1FaRWN5S2lUckV6cUlCalpjcE1sbU9xL2dSUURKYVBFYVl2?=
 =?utf-8?B?bUxUMG9qd2tseHRCZUR6TkN1dkd2ZHprQVhzR3paWUREL2VxZUN1UUNIM2F1?=
 =?utf-8?B?cUdhUllZOXh2amlYdyswdFpBZ0NkQklicG1ieVBHTEZzaTNPRDBwYUY2RGlC?=
 =?utf-8?B?VkMvS04vNllURExtRXNsSlE1QWwxdWR3U3U1eitCeHMwQnBIWDYxOCtTczZn?=
 =?utf-8?B?aCtJeWFVV2NoQXlFdzV6YjIzQ01yVUFGYTdjR2hTSVFESFFuUkpjSzFPNytk?=
 =?utf-8?Q?Ki428MdZkI50ADPHlkhcV/7hV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea28e59-fc33-45ad-7cbc-08db4590e5d6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 13:28:03.9867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GG7Hw86mPGvqtPPChQkAwQG1MrUbdaNb/LooSpothYI/dqducOpwHICTzwGraYJw9E/Vk0WqpvH7IVJdW1ijVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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


On 25/04/2023 14:32, Christian König wrote:
> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>> From: Arvind Yadav <arvind.yadav@amd.com>
>>
>> This patch sets new parameters defined in v11_struct for
>> usermode queue with the respective allocated gpu context
>> space addresses.
>>
>> V4: Split the patch into two parts, keep only the set parameter
>>      part in this series (Alex).
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index f6b33faea86f..86de35292f69 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -6411,6 +6411,21 @@ const struct amdgpu_ip_block_version 
>> gfx_v11_0_ip_block =
>>       .funcs = &gfx_v11_0_ip_funcs,
>>   };
>>   +static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr 
>> *uq_mgr,
>> +                    struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
>> +
>> +    mqd->shadow_base_lo = queue->shadow_ctx_gpu_addr & 0xfffffffc;
>> +    mqd->shadow_base_hi = upper_32_bits(queue->shadow_ctx_gpu_addr);
>> +
>> +    mqd->gds_bkup_base_lo = queue->gds_ctx_gpu_addr & 0xfffffffc;
>> +    mqd->gds_bkup_base_hi = upper_32_bits(queue->gds_ctx_gpu_addr);
>> +
>> +    mqd->fw_work_area_base_lo = queue->fw_ctx_gpu_addr & 0xfffffffc;
>> +    mqd->fw_work_area_base_lo = upper_32_bits(queue->fw_ctx_gpu_addr);
>
> Mhm, first of all please use lower_32_bits() here instead of the mask.
>
Noted,
> Then are you sure that is correct? The shadow, csa, gds are supposed 
> to be VAs as far as I know, but you use MC addresses here.

In my understanding, only the shadow area needs to be VA, which is true 
here as its being allocated by the user. We have tested the code and we 
did not see any problem yet, but I can cross check this and come back.

- Shashank

>
>
> Christian.
>
>> +}
>> +
>>   static int gfx_v11_userq_create_ctx_space(struct amdgpu_userq_mgr 
>> *uq_mgr,
>>                         struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -6484,12 +6499,14 @@ gfx_v11_userq_mqd_create(struct 
>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>>       queue->userq_prop.use_doorbell = true;
>>       queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
>>       r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, 
>> &queue->userq_prop);
>> -    amdgpu_bo_unreserve(mqd->obj);
>>       if (r) {
>> +        amdgpu_bo_unreserve(mqd->obj);
>>           DRM_ERROR("Failed to init MQD for queue\n");
>>           goto free_ctx;
>>       }
>>   +    gfx_v11_userq_set_ctx_space(uq_mgr, queue);
>> +    amdgpu_bo_unreserve(mqd->obj);
>>       DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>       return 0;
>
