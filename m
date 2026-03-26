Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9AC10AB807
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 19:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1964410E1FF;
	Thu, 26 Mar 2026 19:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L+mNxopQ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB37C10E1FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 19:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omHk0BkByppylVJU9ynppJClV2r0X/eLj00u+n+tfkfoXJFmC5d/jK7llqJwS5qjjRmTQFqPiz2DWBrKxUK6FgRKpfL+cpbz3TPp6WxTsKP830VnTzKyHOQoZb2Vzd8wEe5F4gy8s/feRp4NBaNCvmQuR7/v34KaTGSZlZ/tLrUHg1wKQcDCXd8ZM4Dht+DxFhA+toyiomjW0kLIARZSU7hLpDTwaWrqxxRcu9JfXOuZRJnmboGldm24GvEWuKYEVlN6L8f+b5dvec2MBCIwqwlw80k9xJDfoh/GbD67R7hrxVOPX0FZJM2rOwHfUrzcsKwzfZrF76cXdmCPoScUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRzVMLH70HlbgcM6v8/KqY1HxgDKEDFdZLqEAaAPCAw=;
 b=luZCa6KNl3oD606wlkvPXeXNOtnDvqSR/i7+hLO0S1VaWBwqvIA1U6RyhfD6Dot5pSAKa4oVXpWKodca7U9Ix+fKRSWpV6ZF/F4n/ff6QEQWNarEOnQfaQ86KN704QEjaOFd5H66CRlMNBpns2DZGs7/JbgTDApZXfQoXqyLZL2Ix0RTcelhCshmIlV2r4E/v3oRtKmxE/dHl8TIGhPuwKjdCThOggycH0JVo1lIL1JnfxLmzTaLch8QaEVb515TFaW1JFxcR/TrlIZYlwhVym+kMPJYMhugKBD5b1eG7dVDJA6CPrkWl7LEqQDZIS/M5o8va/Pe+RHrKDA79rjz9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRzVMLH70HlbgcM6v8/KqY1HxgDKEDFdZLqEAaAPCAw=;
 b=L+mNxopQqkAPgBbDrmwsewWtwuLunZg21zwoE/S7h/eAfIcqt1Shqhiid/7iNuGi4zyKLI8Sva7o+8vfiFCBK7KW4DDxajzrM8GmP/lp0QYCMpGi7fYGIgswIE/pwL+HY8WMA4OMBcjh/71/icGOHgyrM4vDFaHYaUlh9I/v2Xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 19:40:30 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 19:40:30 +0000
Content-Type: multipart/alternative;
 boundary="------------0l4evLRsTw27ZW8xCHCNzZzs"
Message-ID: <8aa62deb-df7e-4a3e-8303-67d050495998@amd.com>
Date: Thu, 26 Mar 2026 15:40:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-10-Amber.Lin@amd.com>
 <CADnq5_N87OnPXugvJJhnKuG4O6NZN5PdxBBYJVYA9nRP_msDyg@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_N87OnPXugvJJhnKuG4O6NZN5PdxBBYJVYA9nRP_msDyg@mail.gmail.com>
X-ClientProxiedBy: YT4P288CA0092.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::27) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 8321efca-1b48-45e2-560e-08de8b6f89a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: 926LBH+SzHcguIc6YBpRYPr1nEVE+XBvkoAGKAIylecBIWuffUmLYve0FJ4WYPlCxx2eyy65iOH0kC8k1vhCLZRAZ5fqKSzo0gJtlm4/HDa4RNAyzM8HKOXiWQP3H9IWDLqTymrFNFa5aE5J/etv4aRJIIbwTb1JnN4kX/C8JyUrrTndPTCfPuLwDCRooizPZ2OgUAbMQNOffPXBJfpo9Kvw4QQsw2rGT1DSngDjumGOwQzyS+u95nIf+RySYP1q42ZpGfRRZwxHLnOVIgBsY2s4BDa6U0RM0pLbIyb3gstzLp0vDllHy6TfIdsF2EWedZCJYWP/KZ8iCfhCGRkeCz0w8DbjbMrlVJG9gd4jRGMxBOjtw/PTA+K4ocu0VbCS19OVrS2Kx4CEKmtoCaSgbuoX00tsB69Vk3+U9+SbsraJG1Z+5/SyDtJ9VgIGkQN4Qsx5kT8fGgpN5jijnAo1d0m4cSJ6rUGHLGTGHyx2HBxrn1rv3poB38T8B1RDUjuR/AO4uN2mpicjTRxMtcbya2UPH3EYvHRUzhkk5LVGFrwoBWfF73lcJrdh1czOEU9DkSdgOBx6LB6fHUozlNPvNRoW4NNiAkx5zjl1wTKZImLkWyQkB5w/INJ5tiEniAUcinzKhhDvgklLT2a2aqObQi+wYtTZKZ1rcHdZBNRDZVCAgv3y9cr8uneHaIKOKCHb3/4XRfCeKxn/KdAoOA+xD6J5FWn2hE4p+1erIeyvCpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXJiOUhNMUp5aURvSFc5V1RwVU5RMHorUUVOMmNITUJCcW02cTV1RGNraFdi?=
 =?utf-8?B?a2U5dFNkcTZYU1ZPaFFOc3NuWitmRTd2LzRkQnpzcWRKeHVKWEFuak5nZTFv?=
 =?utf-8?B?N3FkcHhuQWRVQTNHR1N6eFZNWXZZUFZNMWc0TmljS2NPeEo1Zmc3bzBvekJD?=
 =?utf-8?B?QnlsbFQwOENkMW11Mjg5Y1NCSkZ5aDJOMW1JZlA1ZzUzWW9GcThqT085KzBr?=
 =?utf-8?B?cW8ybjg3VUsxZFVQY2s0WHYwQXl5WXllc0lFREpubjdFS1NFemFTZDVwZ0tT?=
 =?utf-8?B?citPYVhoWUswN29OTnYvV2gwdlBVQWFjMUIrUmJ6NFNCWDBGQVUzbjBCMndh?=
 =?utf-8?B?VWhlQnFrK1AyQmhHeEFER0tkcWt0VWo1SGFEUWVnWndKcEdlaFZFRzUyNlE1?=
 =?utf-8?B?VWFuNVZ3a2pSWDdNWXZIK2puM004aW5YeGFGakdyUDVNMmZKdllFbnVBRm1l?=
 =?utf-8?B?c2NwMFV2ak1ZcnJJT2JmQ20zR2d3d0xIQXhxYjJJRWVDWjM2aHRKMTZvSlVM?=
 =?utf-8?B?dUo2dHRzcHdBQXdzTG1Fd3ZFbzQ1MG5FdmxiOGg3MnhLY3dWUnVzaFMxNDF0?=
 =?utf-8?B?SlhDUEhLdGRFQzJkN3ErT1BmTnRhQkNhOTdxV3FXQTg0djJrRldqcXlFSEZr?=
 =?utf-8?B?bkRIRmt2UnJ3aE1DTzZMRmN5d09YYzA4a3Nmc3kyRlZSZGxLN0tia283eGVl?=
 =?utf-8?B?bVRxVE0wMFZiaFRUZTVzZU1yeDRzSjdGUzgvV2xtMzJpNEVQZjNRN2RqQTdE?=
 =?utf-8?B?Rm4zek8yR2U2bGRnWGlFMDM4M0VDcDlHRTBMV0IwVlNPRDRFbUsrOGVIcGxr?=
 =?utf-8?B?S0ZMa253NEZqTk9IZ1lmUjF1ZGdPcWlOTXMweXQvWHRKT1hLTWRFK3QvT2h0?=
 =?utf-8?B?NURPaytlbnBXSlpMRExmR0llSEVBL2JPSHdWMUErdEFwNXNlUmJxOS9qV2Fm?=
 =?utf-8?B?ODdlVElJMkU3UXprdEpFaGYzTzJFYWsyQkN1TWZrSll4SkZtMVY3clZOT0Z2?=
 =?utf-8?B?M3ZFbC9zWEtVbFVsSWFIZkt0MU01djN6OEgxVW1WY29oUUoySWppWXpDSFRn?=
 =?utf-8?B?b0s4MXYyM0hzUURKQ2t5MDlteVlLb0RTQzFCZmFWNXRtcHByc1MxK0NTQkRK?=
 =?utf-8?B?a09SM0FaZzUwdkFNWEcyeEovVkI0VDdFUzB5WTVqWTlvamFJZXg2SXpBRCtt?=
 =?utf-8?B?dWM1T2RjOVdBNTNvZ3ZEU2I2MWczaG5pNmRTbitkQXdwejQvMEFLVjM1eTFs?=
 =?utf-8?B?c0RiOEtHUTEwdXJjVHE0R2ZsQ1BEZGh2OGd5V1Z1eGRySFpIbDZFNWlkQ2o4?=
 =?utf-8?B?cjFld09VZVlDVlpSR2hIdEZEWEdHMzlkVTNzOE54VmZXaFdnZXpVcCs4VVp6?=
 =?utf-8?B?Q2lhcjRMN2xhVzBSZjFIMTk2ckozYUR5U2hES0JiZEtoNkRCeityeU1oN2Nu?=
 =?utf-8?B?dk9UOHVaZGROMk93RGRjZ1o3U3lJSkQ4OFVEaXhPQm9PZDVrc1h6ZzZhcUJ6?=
 =?utf-8?B?Z0djU2dWdkRSU2hyYmdvajFrOUZobklhU25rZTZ5R1M5QzR5UFBvSmsxZWxP?=
 =?utf-8?B?M3R0dkFMT0RJL0c2NlcrSHNFd1BOa09CSmFLaVVFa2crbWJrS001ZGJHZnFa?=
 =?utf-8?B?Y2pOZkp1dWJyTjNBNzgxZFkydFFKcVZjd2p0ZU45aFU3OFZnS3p2STRlTWlU?=
 =?utf-8?B?a2RxcWZDNEZHUWZidGxsMnJvaU5JMWdnSmhjV2l5MWQ0NUhxNVovOWg3dDd5?=
 =?utf-8?B?ejh2cnhqVnZiN1JoM1RYeHV6MkpJaXdsdFdVWm51ZUVhMm5uR25nWSt2L3hK?=
 =?utf-8?B?NS9CMnl6Z1ZIUXhLZU43bUNmR2YxeVNiQmtTTlZlMDZKZ011TjBPaktRZW5h?=
 =?utf-8?B?WnhxeVRvT20zM2l2d1dHZkl0K0ZqWFZEUFVmaE9EN1MvUVErYzBQaFRGb3h6?=
 =?utf-8?B?ZzhXdmp1WkU4V05WRGU2OUV4QlZzb25nMGVmcmNlL1dCdEZ4K3pqN25sd3Rj?=
 =?utf-8?B?OENZMng5ZWRGeTF6S0Y3MkFpSGtNbERnNURla24yeEtnVVdDR1JYaEwvdkVV?=
 =?utf-8?B?dkVrdWtXRkNUOGcxSjNGUHMrMEQ5MGVPcEtBNGUyVGdDcG50dDR3dldkOTZx?=
 =?utf-8?B?NU5VOHRQYnJ1OE1TNUQzVVA0VkNPVEgySFoyYThCQzJvRFdkYm9Ja3BGU0F6?=
 =?utf-8?B?OW1FT1UvcjR2L2tGN0k3NTk4d1F1SlRxYzlJYjJaOWovbkMrL2RqdDY1S2NY?=
 =?utf-8?B?RTdkL0NvVVE1cVlkMHdpdG1PYjBqNU50ZFJUMjU0OFFEU2ovZTBwVHZUaStt?=
 =?utf-8?Q?NCv2xyvSN3rq3QK+Z9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8321efca-1b48-45e2-560e-08de8b6f89a2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:40:30.1413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+u1TyuxTJCwT1++4WrqeHXS7yXbA6zTIYjlH34mUMm7YZLUykzEg8NLYoT5lxvG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
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

--------------0l4evLRsTw27ZW8xCHCNzZzs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Regards,
Amber


On 3/26/26 14:51, Alex Deucher wrote:
> On Tue, Mar 24, 2026 at 1:57 PM Amber Lin<Amber.Lin@amd.com> wrote:
>> When removing queues fails, KFD calls amdgpu_mes to detect and reset
>> hung queues, then cleans up those hung queues in KFD.
>>
>> Suggested-by: Jonathan Kim<jonathan.kim@amd.com>
>> Signed-off-by: Amber Lin<Amber.Lin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   6 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
>>   4 files changed, 153 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index f3a4ae1fd521..7cf4b3d6fc93 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -793,6 +793,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
>>                  amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0));
>>   }
>>
>> +bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
>> +{
>> +       return (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &&
>> +               (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x73);
>> +}
>> +
>>   /* Fix me -- node_id is used to identify the correct MES instances in the future */
>>   static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
>>                                              uint32_t node_id, bool enable)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 643b4f8d757a..44fa4d73bce8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -548,6 +548,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
>>   }
>>
>>   bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
>> +bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev);
>>
>>   int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index ec8d7f4be840..1c9c350bfffe 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -71,6 +71,12 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>>                                  struct queue *q, const uint32_t *restore_sdma_id);
>>
>>   static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
>> +static int resume_all_queues_mes(struct device_queue_manager *dqm);
>> +static int suspend_all_queues_mes(struct device_queue_manager *dqm);
>> +static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
>> +                                                  uint32_t doorbell_offset);
>> +static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
>> +                              struct qcm_process_device *qpd);
>>
>>   static inline
>>   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
>> @@ -273,13 +279,19 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>>          return r;
>>   }
>>
>> -static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>> -                       struct qcm_process_device *qpd)
>> +static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, struct queue *q,
>> +                                           struct qcm_process_device *qpd,
>> +                                           bool is_for_reset,
>> +                                           bool flush_mes_queue)
>>   {
>>          struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>>          int r;
>>          struct mes_remove_queue_input queue_input;
>>
>> +       /* queue was already removed during reset */
>> +       if (q->properties.is_reset)
>> +               return 0;
>> +
>>          if (!dqm->sched_running || dqm->sched_halt)
>>                  return 0;
>>          if (!down_read_trylock(&adev->reset_domain->sem))
>> @@ -288,6 +300,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>>          memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>          queue_input.doorbell_offset = q->properties.doorbell_off;
>>          queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
>> +       queue_input.remove_queue_after_reset = flush_mes_queue;
>>          queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
>>
>>          amdgpu_mes_lock(&adev->mes);
>> @@ -295,7 +308,13 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>>          amdgpu_mes_unlock(&adev->mes);
>>          up_read(&adev->reset_domain->sem);
>>
>> +       if (is_for_reset)
>> +               return r;
>> +
>>          if (r) {
>> +               if (!suspend_all_queues_mes(dqm))
>> +                       return resume_all_queues_mes(dqm);
>> +
>>                  dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
>>                          q->properties.doorbell_off);
>>                  dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>> @@ -305,6 +324,12 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>>          return r;
>>   }
>>
>> +static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>> +                           struct qcm_process_device *qpd)
>> +{
>> +       return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
>> +}
>> +
>>   static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
>>   {
>>          struct device_process_node *cur;
>> @@ -359,6 +384,103 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
>>          return retval;
>>   }
>>
>> +static int reset_queues_mes(struct device_queue_manager *dqm)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>> +       struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
>> +       int hqd_info_size = adev->mes.hung_queue_hqd_info_offset;
>> +       int num_hung = 0, r = 0, i, pipe, queue, queue_type;
>> +       uint32_t *hung_array;
>> +       struct kfd_process_device *pdd;
>> +       struct queue *q;
>> +
>> +       if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
>> +               r = -ENOTRECOVERABLE;
>> +               goto fail;
>> +       }
>> +
>> +       /* reset should be used only in dqm locked queue reset */
>> +       if (WARN_ON(dqm->detect_hang_count > 0))
>> +               return 0;
>> +
>> +       if (!amdgpu_gpu_recovery) {
>> +               r = -ENOTRECOVERABLE;
>> +               goto fail;
>> +       }
>> +
>> +       hung_array = kzalloc(adev->mes.hung_queue_db_array_size * sizeof(uint32_t), GFP_KERNEL);
>> +       if (!hung_array) {
>> +               r = -ENOMEM;
>> +               goto fail;
>> +       }
>> +
>> +       hqd_info = kzalloc(hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info), GFP_KERNEL);
> We should avoid allocating memory in the reset paths as they can
> deadlock if the kernel is waiting on the reset to get the memory
> needed for the allocation.  Can you preallocate this somehow?
>
> Alex
I probably misunderstood the concern here... When we allocate the needed 
memory here, reset process hasn't happened until we call 
amdgpu_mes_detect_and_reset_hung_queues below. 
amdgpu_mes_detect_and_reset_hung_queues is where driver prepares the 
detect_and_reset input and then submits the RESET packet to MES.
>> +       if (!hqd_info) {
>> +               r = -ENOMEM;
>> +               goto free_hung_array;
>> +       }
>> +
>> +       memset(hqd_info, 0, hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info));
>> +
>> +       /*
>> +        * AMDGPU_RING_TYPE_COMPUTE parameter does not matter if called
>> +        * post suspend_all as reset & detect will return all hung queue types.
>> +        *
>> +        * Passed parameter is for targeting queues not scheduled by MES add_queue.
>> +        */
>> +       r =  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
>> +               false, &num_hung, hung_array, ffs(dqm->dev->xcc_mask) - 1);
Here is the amdgpu_mes_detect_and_reset_hung_queues
>> +
>> +       if (!num_hung || r) {
>> +               r = -ENOTRECOVERABLE;
>> +               goto free_hqd_info;
>> +       }
>> +
>> +       /* MES reset resets queue/pipe and cleans up internally  */
>> +       for (i = 0; i < num_hung; i++) {
>> +               hqd_info[i].bit0_31 = hung_array[i + hqd_info_size];
>> +               pipe = hqd_info[i].pipe_index;
>> +               queue = hqd_info[i].queue_index;
>> +               queue_type = hqd_info[i].queue_type;
>> +
>> +               if (queue_type != MES_QUEUE_TYPE_COMPUTE &&
>> +                   queue_type != MES_QUEUE_TYPE_SDMA) {
>> +                       pr_warn("Unsupported hung queue reset type: %d\n", queue_type);
>> +                       hung_array[i] = AMDGPU_MES_INVALID_DB_OFFSET;
>> +                       continue;
>> +               }
>> +
>> +               q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
>> +               if (!q) {
>> +                       r = -ENOTRECOVERABLE;
>> +                       goto free_hqd_info;
>> +               }
>> +
>> +               pdd = kfd_get_process_device_data(q->device, q->process);
>> +               if (!pdd) {
>> +                       r = -ENODEV;
>> +                       goto free_hqd_info;
>> +               }
>> +
>> +               pr_warn("Hang detected doorbell %x pipe %d queue %d type %d\n",
>> +                               hung_array[i], pipe, queue, queue_type);
>> +               /* Proceed remove_queue with reset=true */
>> +               remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
>> +               set_queue_as_reset(dqm, q, &pdd->qpd);
>> +       }
>> +
>> +       dqm->detect_hang_count = num_hung;
>> +       kfd_signal_reset_event(dqm->dev);
>> +
>> +free_hqd_info:
>> +       kfree(hqd_info);
>> +free_hung_array:
>> +       kfree(hung_array);
>> +fail:
>> +       dqm->detect_hang_count = 0;
>> +       return r;
>> +}
>> +
>>   static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>>   {
>>          struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>> @@ -371,6 +493,9 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>>          up_read(&adev->reset_domain->sem);
>>
>>          if (r) {
>> +               if (!reset_queues_mes(dqm))
>> +                       return 0;
>> +
>>                  dev_err(adev->dev, "failed to suspend gangs from MES\n");
>>                  dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>>                  kfd_hws_hang(dqm);
>> @@ -2137,6 +2262,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>>                  q->properties.queue_id, pdd->process->lead_thread->pid);
>>
>>          pdd->has_reset_queue = true;
>> +       q->properties.is_reset = true;
>>          if (q->properties.is_active) {
>>                  q->properties.is_active = false;
>>                  decrement_queue_count(dqm, qpd, q);
>> @@ -2203,6 +2329,23 @@ static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uin
>>          return NULL;
>>   }
>>
>> +static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm, uint32_t doorbell_offset)
>> +{
>> +       struct device_process_node *cur;
>> +       struct qcm_process_device *qpd;
>> +       struct queue *q;
>> +
>> +       list_for_each_entry(cur, &dqm->queues, list) {
>> +               qpd = cur->qpd;
>> +               list_for_each_entry(q, &qpd->queues_list, list) {
>> +                       if (doorbell_offset == q->properties.doorbell_off)
>> +                               return q;
>> +               }
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>>   static int reset_hung_queues(struct device_queue_manager *dqm)
>>   {
>>          int r = 0, reset_count = 0, i;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 27e4859e4ad7..6cb33f6d71e2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -523,6 +523,7 @@ struct queue_properties {
>>          uint32_t pm4_target_xcc;
>>          bool is_dbg_wa;
>>          bool is_user_cu_masked;
>> +       bool is_reset;
>>          /* Not relevant for user mode queues in cp scheduling */
>>          unsigned int vmid;
>>          /* Relevant only for sdma queues*/
>> --
>> 2.43.0
>>

--------------0l4evLRsTw27ZW8xCHCNzZzs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <pre class="moz-signature" cols="72">Regards,
Amber</pre>
    <br>
    <div class="moz-cite-prefix">On 3/26/26 14:51, Alex Deucher wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_N87OnPXugvJJhnKuG4O6NZN5PdxBBYJVYA9nRP_msDyg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Tue, Mar 24, 2026 at 1:57 PM Amber Lin <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
When removing queues fails, KFD calls amdgpu_mes to detect and reset
hung queues, then cleans up those hung queues in KFD.

Suggested-by: Jonathan Kim <a class="moz-txt-link-rfc2396E" href="mailto:jonathan.kim@amd.com">&lt;jonathan.kim@amd.com&gt;</a>
Signed-off-by: Amber Lin <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 4 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f3a4ae1fd521..7cf4b3d6fc93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -793,6 +793,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
                amdgpu_ip_version(adev, GC_HWIP, 0) &gt;= IP_VERSION(12, 0, 0));
 }

+bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
+{
+       return (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &amp;&amp;
+               (adev-&gt;mes.sched_version &amp; AMDGPU_MES_VERSION_MASK) &gt;= 0x73);
+}
+
 /* Fix me -- node_id is used to identify the correct MES instances in the future */
 static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
                                            uint32_t node_id, bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 643b4f8d757a..44fa4d73bce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -548,6 +548,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
 }

 bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
+bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev);

 int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ec8d7f4be840..1c9c350bfffe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -71,6 +71,12 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
                                struct queue *q, const uint32_t *restore_sdma_id);

 static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
+static int resume_all_queues_mes(struct device_queue_manager *dqm);
+static int suspend_all_queues_mes(struct device_queue_manager *dqm);
+static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
+                                                  uint32_t doorbell_offset);
+static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
+                              struct qcm_process_device *qpd);

 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
@@ -273,13 +279,19 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
        return r;
 }

-static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
-                       struct qcm_process_device *qpd)
+static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, struct queue *q,
+                                           struct qcm_process_device *qpd,
+                                           bool is_for_reset,
+                                           bool flush_mes_queue)
 {
        struct amdgpu_device *adev = (struct amdgpu_device *)dqm-&gt;dev-&gt;adev;
        int r;
        struct mes_remove_queue_input queue_input;

+       /* queue was already removed during reset */
+       if (q-&gt;properties.is_reset)
+               return 0;
+
        if (!dqm-&gt;sched_running || dqm-&gt;sched_halt)
                return 0;
        if (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))
@@ -288,6 +300,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
        memset(&amp;queue_input, 0x0, sizeof(struct mes_remove_queue_input));
        queue_input.doorbell_offset = q-&gt;properties.doorbell_off;
        queue_input.gang_context_addr = q-&gt;gang_ctx_gpu_addr;
+       queue_input.remove_queue_after_reset = flush_mes_queue;
        queue_input.xcc_id = ffs(dqm-&gt;dev-&gt;xcc_mask) - 1;

        amdgpu_mes_lock(&amp;adev-&gt;mes);
@@ -295,7 +308,13 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
        amdgpu_mes_unlock(&amp;adev-&gt;mes);
        up_read(&amp;adev-&gt;reset_domain-&gt;sem);

+       if (is_for_reset)
+               return r;
+
        if (r) {
+               if (!suspend_all_queues_mes(dqm))
+                       return resume_all_queues_mes(dqm);
+
                dev_err(adev-&gt;dev, &quot;failed to remove hardware queue from MES, doorbell=0x%x\n&quot;,
                        q-&gt;properties.doorbell_off);
                dev_err(adev-&gt;dev, &quot;MES might be in unrecoverable state, issue a GPU reset\n&quot;);
@@ -305,6 +324,12 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
        return r;
 }

+static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
+                           struct qcm_process_device *qpd)
+{
+       return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
+}
+
 static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
 {
        struct device_process_node *cur;
@@ -359,6 +384,103 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
        return retval;
 }

+static int reset_queues_mes(struct device_queue_manager *dqm)
+{
+       struct amdgpu_device *adev = (struct amdgpu_device *)dqm-&gt;dev-&gt;adev;
+       struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
+       int hqd_info_size = adev-&gt;mes.hung_queue_hqd_info_offset;
+       int num_hung = 0, r = 0, i, pipe, queue, queue_type;
+       uint32_t *hung_array;
+       struct kfd_process_device *pdd;
+       struct queue *q;
+
+       if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
+               r = -ENOTRECOVERABLE;
+               goto fail;
+       }
+
+       /* reset should be used only in dqm locked queue reset */
+       if (WARN_ON(dqm-&gt;detect_hang_count &gt; 0))
+               return 0;
+
+       if (!amdgpu_gpu_recovery) {
+               r = -ENOTRECOVERABLE;
+               goto fail;
+       }
+
+       hung_array = kzalloc(adev-&gt;mes.hung_queue_db_array_size * sizeof(uint32_t), GFP_KERNEL);
+       if (!hung_array) {
+               r = -ENOMEM;
+               goto fail;
+       }
+
+       hqd_info = kzalloc(hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info), GFP_KERNEL);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
We should avoid allocating memory in the reset paths as they can
deadlock if the kernel is waiting on the reset to get the memory
needed for the allocation.  Can you preallocate this somehow?

Alex
</pre>
    </blockquote>
    I probably misunderstood the concern here... When we allocate the
    needed memory here, reset process hasn't happened until we call&nbsp;<span style="white-space: pre-wrap">amdgpu_mes_detect_and_reset_hung_queues below. </span><span style="white-space: pre-wrap">amdgpu_mes_detect_and_reset_hung_queues is where driver prepares the detect_and_reset input and then submits the RESET packet to MES.</span>
    <blockquote type="cite" cite="mid:CADnq5_N87OnPXugvJJhnKuG4O6NZN5PdxBBYJVYA9nRP_msDyg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+       if (!hqd_info) {
+               r = -ENOMEM;
+               goto free_hung_array;
+       }
+
+       memset(hqd_info, 0, hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info));
+
+       /*
+        * AMDGPU_RING_TYPE_COMPUTE parameter does not matter if called
+        * post suspend_all as reset &amp; detect will return all hung queue types.
+        *
+        * Passed parameter is for targeting queues not scheduled by MES add_queue.
+        */
+       r =  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
+               false, &amp;num_hung, hung_array, ffs(dqm-&gt;dev-&gt;xcc_mask) - 1);</pre>
      </blockquote>
    </blockquote>
    Here is the&nbsp;<span style="white-space: pre-wrap">amdgpu_mes_detect_and_reset_hung_queues</span>
    <blockquote type="cite" cite="mid:CADnq5_N87OnPXugvJJhnKuG4O6NZN5PdxBBYJVYA9nRP_msDyg@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
+
+       if (!num_hung || r) {
+               r = -ENOTRECOVERABLE;
+               goto free_hqd_info;
+       }
+
+       /* MES reset resets queue/pipe and cleans up internally  */
+       for (i = 0; i &lt; num_hung; i++) {
+               hqd_info[i].bit0_31 = hung_array[i + hqd_info_size];
+               pipe = hqd_info[i].pipe_index;
+               queue = hqd_info[i].queue_index;
+               queue_type = hqd_info[i].queue_type;
+
+               if (queue_type != MES_QUEUE_TYPE_COMPUTE &amp;&amp;
+                   queue_type != MES_QUEUE_TYPE_SDMA) {
+                       pr_warn(&quot;Unsupported hung queue reset type: %d\n&quot;, queue_type);
+                       hung_array[i] = AMDGPU_MES_INVALID_DB_OFFSET;
+                       continue;
+               }
+
+               q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
+               if (!q) {
+                       r = -ENOTRECOVERABLE;
+                       goto free_hqd_info;
+               }
+
+               pdd = kfd_get_process_device_data(q-&gt;device, q-&gt;process);
+               if (!pdd) {
+                       r = -ENODEV;
+                       goto free_hqd_info;
+               }
+
+               pr_warn(&quot;Hang detected doorbell %x pipe %d queue %d type %d\n&quot;,
+                               hung_array[i], pipe, queue, queue_type);
+               /* Proceed remove_queue with reset=true */
+               remove_queue_mes_on_reset_option(dqm, q, &amp;pdd-&gt;qpd, true, false);
+               set_queue_as_reset(dqm, q, &amp;pdd-&gt;qpd);
+       }
+
+       dqm-&gt;detect_hang_count = num_hung;
+       kfd_signal_reset_event(dqm-&gt;dev);
+
+free_hqd_info:
+       kfree(hqd_info);
+free_hung_array:
+       kfree(hung_array);
+fail:
+       dqm-&gt;detect_hang_count = 0;
+       return r;
+}
+
 static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 {
        struct amdgpu_device *adev = (struct amdgpu_device *)dqm-&gt;dev-&gt;adev;
@@ -371,6 +493,9 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
        up_read(&amp;adev-&gt;reset_domain-&gt;sem);

        if (r) {
+               if (!reset_queues_mes(dqm))
+                       return 0;
+
                dev_err(adev-&gt;dev, &quot;failed to suspend gangs from MES\n&quot;);
                dev_err(adev-&gt;dev, &quot;MES might be in unrecoverable state, issue a GPU reset\n&quot;);
                kfd_hws_hang(dqm);
@@ -2137,6 +2262,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
                q-&gt;properties.queue_id, pdd-&gt;process-&gt;lead_thread-&gt;pid);

        pdd-&gt;has_reset_queue = true;
+       q-&gt;properties.is_reset = true;
        if (q-&gt;properties.is_active) {
                q-&gt;properties.is_active = false;
                decrement_queue_count(dqm, qpd, q);
@@ -2203,6 +2329,23 @@ static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uin
        return NULL;
 }

+static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm, uint32_t doorbell_offset)
+{
+       struct device_process_node *cur;
+       struct qcm_process_device *qpd;
+       struct queue *q;
+
+       list_for_each_entry(cur, &amp;dqm-&gt;queues, list) {
+               qpd = cur-&gt;qpd;
+               list_for_each_entry(q, &amp;qpd-&gt;queues_list, list) {
+                       if (doorbell_offset == q-&gt;properties.doorbell_off)
+                               return q;
+               }
+       }
+
+       return NULL;
+}
+
 static int reset_hung_queues(struct device_queue_manager *dqm)
 {
        int r = 0, reset_count = 0, i;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 27e4859e4ad7..6cb33f6d71e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -523,6 +523,7 @@ struct queue_properties {
        uint32_t pm4_target_xcc;
        bool is_dbg_wa;
        bool is_user_cu_masked;
+       bool is_reset;
        /* Not relevant for user mode queues in cp scheduling */
        unsigned int vmid;
        /* Relevant only for sdma queues*/
--
2.43.0

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------0l4evLRsTw27ZW8xCHCNzZzs--
