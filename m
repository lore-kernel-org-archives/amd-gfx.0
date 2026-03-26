Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143E510AB823
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 20:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1C310E2A1;
	Thu, 26 Mar 2026 20:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iCx5fuAl";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D734210E2A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 20:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKOjYU0rCEAKMEh1RLt7r5djKTYz6boKb9rjD8uEo6Ijd7SRB7TD8ZgU5dJXy8lS/ifS77EiRxPLOHS2bVxX1fKjtS2LC9J+EG489UvKZfOBf1hJzLJ5Mzj7VV8I41cncSqqLBv8kpXfHhovQQNYvNnuzWoPvK1iDI4zaw30DUEhdCmrGN0zjuF3T9HrFw+qkprtfqP+IsEXgH4Z/anZpQeC+3clArk5ZuVfLWyHwHWSfqAhF94XboYQTpMxuOOA6ojJsWcMS8Ne9q1re5bvh9QfIBRNczqktEJ0SRdUnwgFyRzgHpEb+HEaq0feDTlHB2eS7bXpobmqHFmyRhR+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PQp+mrdhmG7tRhddtHJ0FL+TE2hlFwAWQB2xsNReL4=;
 b=q1P93sEjY+rIeuZ77Kjbh4hSzapvxiZes/wh+DFr8fYcGS7OZmTUyG9G9lTgXIJO5rEl0wYpP7QiEPaD8NQ5FHWjk+9afi95lLHsbDcobnmkubVu8LQfGOI9vJBTPMx+TU0/rwjZZYRy9cmL4ef+yy38NyUNvRRHGfRkuDgNchMBuhd3Gu+0BY9vRFBTJHpueJWO03+q1pMFpvLVKMR059XHhalTMbv9iEQHt4XdbGvxcPLgpy2QV3ZGoPXaT8bdKAiAEfmAVHn6/mc+IFSf/8fxcDraPqKV/ohRLGDnulHy1yJCW/E0gDFhZR4rxOCaYFppU4CPnnPyQ4J75QJoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PQp+mrdhmG7tRhddtHJ0FL+TE2hlFwAWQB2xsNReL4=;
 b=iCx5fuAlw+UmD0DjO0C7A8ZmAknWsVNY7Xl5H+GJBgVEChPY9OPEnLbMFxBV4kzqpWXJ35ADRURXaOFi+suzV/oBNvRDKEVm4Wycwj5Rdu+228Xi/XSE0ZwxSjK/O1WtTNuHIX1pQOBajHLd2XNxHszvwxviOLcYr8BNq/7wb8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 20:34:43 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 20:34:43 +0000
Message-ID: <601d5e1d-fbee-4e43-b668-3ab729ea4716@amd.com>
Date: Thu, 26 Mar 2026 16:34:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] drm/amdgpu: Create hqd info structure
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-5-Amber.Lin@amd.com>
 <CADnq5_M_Gi8wCxpbHecpfnJRTWK-ibskpT_oTYR1Zizk1d2tkg@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_M_Gi8wCxpbHecpfnJRTWK-ibskpT_oTYR1Zizk1d2tkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::10) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: d609fd26-6c8c-4377-dfbf-08de8b771c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 80IcEEYm9s4iKnVRrBOiJUDR/FA7vZLHxj4goBXsKmNRL7mGePjmaNZEvy5wubYg6UPzfirPWFohaPUZc8zhPWpRuxiOUzYLBwyxs0Q4qN+3aBECH3omb46QntctUvncl+GCc1XsnMDL0I1dJDg2IPz899GeSCRsdepOJp7058iYl+s/g/V/11jg6NRYzcsuy5ZVk+W+nYnA2KMguuKdI81HBv8CD/JBkC8Hfjhr5NUeedvWah1YXZILbTbWKvi5TkxyBLxTyejY25nJX+Q22Ibb/8wJqJWFwKR4L2O7rNMey1HCW8FIZAtJuts4KXBF4vBWak2AVfspvbqpR18RfI751sS6LZfuVdQtNT8rsqm6VAi1VoKjz1f5lJTZXBPWHuSVEoOqPrtmdfEit9v9zOq29NqTXc2EvP4ZuCN3vjbq7R/0R3S7QZpupo0Go8jdM0zcJ7jZZhwTPZ+DG9vP4ayzjJoCCI6C4fgSgk6gnQUVp9JZ+YzMIDWDcFMzJDijW0sAXVcGFgk/0grY76XPIuk8RK5E21JOQThtDATuP6BkUFFsJ9FYdn377IYeMExFfmxftmIpvU8rCZ2mPOZjiWtX10t8LApst9xobVtAdTyX54DlVIOqEqNWfFfJ/xAQLvfjMgy0dxRkpbT3IpEKm7tlNWsy2NOpZyfzJCyr48vSeRC3f9yPyCzSuhrdfOLAoNbWbj8/y48OdBfV3jNRJsnoZ367smT7Pcd9MM2pXqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eksrRW8zQlZpaE1hL3VFakh4bmtIOVR0RlVtNW9tTG95UGV3dU1TWGY2bmh3?=
 =?utf-8?B?WHhkK3RzQzh3Y1gxNXJBQ3d4bHZ0dUdNRHpQYkRCby9JSWJ6VjA4Ym9NNjlU?=
 =?utf-8?B?NTQ3bmRDRVlScFFKY1daeHlUZ0FLZEUySG1palNvNSsrVWZvdWZEODZuZlFP?=
 =?utf-8?B?c3lRNEpvYmUxZFNjSjdQbWI3OGxXS0I4UVJQSGMyRVluei9wZEFFcmtKcjEv?=
 =?utf-8?B?V0c2ZDVuVnhxanlxYmNEZmFoMDV2ZCtJZlZ0UnNpeWZtcS9pT0g0Nm9ES3du?=
 =?utf-8?B?UDM0Z2VUUmNHUGdlU2J1TGljNWl1NENKTjFqTUNqZldQS2QzNTVqSmpFcHNz?=
 =?utf-8?B?U3Z6VDhRRjhkU3lISzdaRGVwRWVhb1VFaVFwNDRPVkwxRkpwRWFPeEVhMitW?=
 =?utf-8?B?c1Z1Ung3QmZPbHRoOTBnSmRzT2pVM0pmZTZXY1VON0Q5bFBBMmswMFVjYmIr?=
 =?utf-8?B?MU53UHNLZW0wNGppdTloeFJ2MndzSUlFRVpWL3IzT1hxdlkvOFNLTFF1SFZQ?=
 =?utf-8?B?amtPZVlvRW9BQzdsRnRNNEpIMnk3OFRoMnQvVHgyUWdlNHBxdmFEcXB5SWFt?=
 =?utf-8?B?ZjRNb1JvY1FZWDhxaEY5SHpPc3FmMFNlbkduUXVpS3VpWFRzV295WktGSFNp?=
 =?utf-8?B?UU45cEpHczhZRGlLTUlYRGNvSXAyWnprbiszT0dMNWVwdjVMV3RVM0Y3ekEx?=
 =?utf-8?B?RXZYWG9vWWtQSmdrcThoR29GYk1NTnNybGJ3ZklKQ1I5UCsrdlVOUmkyeHBB?=
 =?utf-8?B?UnZlUW8xZVNmN3dPVU9vbk1YR3B0MnZKdWNKeTdqK0ZkRmtoTGFFbnVRZkoy?=
 =?utf-8?B?bFgyZmhwRzBzVi93SEFMNlpSekozY1VEUUE0ejJDR29vTi9STHRNS0ZUYk1u?=
 =?utf-8?B?Qk94dGxQVkZFM0FFK1RnenB3bkV5djhkMnZuVDQrOFRCazQwK2UxMkZCZnRP?=
 =?utf-8?B?SDhhYTVHWlNIeWV0RXhVSUV1cElYdWx3UEFiOVl4Q0dtUGNPb1RqdmxRVjVW?=
 =?utf-8?B?ZjdOYld5bTlkTkNsME1DVi9tNkxzRW43aVVrNGVzT1cxUjZmd0VkNENaMVdk?=
 =?utf-8?B?aElLd0RuTmNuNm5XenRYaWFuYVI3ZXY1Yy9DN1lXRlVoN0Jmd2VtUEhzR0xK?=
 =?utf-8?B?ZHNndGR1Zms5dTZ5cWM3UFN4SXBkMHczcUNZSWJZK20yRVRMc0diS3pWQWkv?=
 =?utf-8?B?Rmk1UExhcUwvOVpHRk0xUzFhRnAwWjlrRk9CZTJpeEsxeHVybnV3aVlBTVRp?=
 =?utf-8?B?Y0xxS3ozZHBqMEpvY0FuMDZ2UnkyZzJJUW5Kc3MxWWt0czZZSVd3YzRYV2tn?=
 =?utf-8?B?SVQza3Mya1lvQ2dteVBWTjhjWlJtV2RNL3A1b2Y5MFNvejNPZDNNeGtRUS9w?=
 =?utf-8?B?bU8vaXdCSjNBc1lTQTZ4dGpvNTNNUC9OWGxOSEZGMDhXU0NZUE44bjRpQVpR?=
 =?utf-8?B?NXczTHVLVU93SmFvTDlLVlNjbDh2QU1Cb1FQUEM1dnh2UlloUFF1UTducG9O?=
 =?utf-8?B?YkNDTnQ1c2pjMVRnalJaUjAyZkJFVUUvQWhwN0Nzek42YUlBTnRrYmZBclVq?=
 =?utf-8?B?U293UjRXRk0zZUwreW5CZEtBTVJUL0ZMWmdTN0UzOFZhbnhGc3RCUTdXUExG?=
 =?utf-8?B?eUg0RHBoWi9XZmFGOEUxdGhXQWpma3RFV2ZTdTdRRDRmT3hJd2VQd2xrZUJs?=
 =?utf-8?B?SFFBN2t1aW5NZlcwMzZtdmswZjJqUmxkNkwrZVd5amVYTW01aVFUU3RneVhk?=
 =?utf-8?B?SlBXQ1Z1MzlyZ2pJdmdnbHVsSGNpOTlDUU8xS2oybm5nY0psY0QzOGZpUDNX?=
 =?utf-8?B?OFIzT1pHZFlBVWd3Y212UU1jQjZRSlZqM0pmZTlMOXl0NS83am1LZk1LZXh1?=
 =?utf-8?B?am01ZWY2YmJ1UmExdldUSmx4ZUtleS9TTml4YklHaFJYeVMxTGVPNVAzdGJk?=
 =?utf-8?B?L3RKNjhyeVpRTGVFNERFOExsT3lCNzQyRFpHVDV1T1BrVnpWb3huTWs3cUpW?=
 =?utf-8?B?RjJMWnB1STVQRlY5SHpMWE0wRDFYZllJa2V0Z2NVVW5pOVhHNGszNFg3allx?=
 =?utf-8?B?dllTSXAySVRldWpKQUFqd1FqV3d6OEhiMTF0TkFGRTYrQXVMTzdCWTdsTWRH?=
 =?utf-8?B?MEJVUHpjZ3Q2ejFFSG0vOERCL0VXUW1GUU83R01uMzUxdFV0SXVDUzl5M1c1?=
 =?utf-8?B?T2luRzBBU0xwQXE3WXRYaGw1SlFaYVdOaVh3U0RuTVZjRjNhN0lZVWtpR2hq?=
 =?utf-8?B?YmdSRkNNeEdoMnF3SzBOaS9qSzdkbURlYm9zbVZobFFuQituakdSampLSG1G?=
 =?utf-8?Q?Jxiqv1B1Tp1xiNOcxy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d609fd26-6c8c-4377-dfbf-08de8b771c7b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 20:34:43.0413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu/VA2HsBgnIxzJnAGzA7iY/Mj4VpYF+cwjstvC3qcCT/HNYoPpUJc/EOCX6L2BQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Regards,
Amber


On 3/26/26 13:56, Alex Deucher wrote:
> On Tue, Mar 24, 2026 at 1:57 PM Amber Lin <Amber.Lin@amd.com> wrote:
>> Create hung_queue_hqd_info structure and fill in hung queses information
>> passed by MES, including queue type, pipe id, and queue id.
>>
>> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
>> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
>>   2 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index f1f8bbfc31e0..d778c3da8203 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>   {
>>          struct mes_detect_and_reset_queue_input input;
>>          u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
>> -       int r, i;
>> +       int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
>>
>>          if (!hung_db_num || !hung_db_array)
>>                  return -EINVAL;
>> @@ -486,10 +486,11 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>                  return r;
>>          }
>>
>> -       /*
>> -        * TODO: return HQD info for MES scheduled user compute queue reset cases
>> -        * stored in hung_db_array hqd info offset to full array size
>> -        */
>> +       if (queue_type != AMDGPU_RING_TYPE_COMPUTE)
>> +               return r;
>> +
>> +       for (i = hqd_info_offset; i < hqd_info_offset + *hung_db_num; i++)
>> +               hung_db_array[i] = db_array[i];
>>
>>          if (r)
>>                  dev_err(adev->dev, "failed to reset\n");
> I think the new hunk of code should come after this error message
> otherwise it won't get printed for non-compute queues.
>
> Alex
Thank you for catching it. I'll move it up in v3
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index f80e3aca9c78..2e6ae9f84db0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -170,6 +170,19 @@ struct amdgpu_mes {
>>          uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
>>   };
>>
>> +struct amdgpu_mes_hung_queue_hqd_info {
>> +       union {
>> +               struct {
>> +                       uint32_t queue_type: 3; // queue type
>> +                       uint32_t pipe_index: 4; // pipe index
>> +                       uint32_t queue_index: 8; // queue index
>> +                       uint32_t reserved: 17;
>> +               };
>> +
>> +               uint32_t bit0_31;
>> +       };
>> +};
>> +
>>   struct amdgpu_mes_gang {
>>          int                             gang_id;
>>          int                             priority;
>> --
>> 2.43.0
>>

