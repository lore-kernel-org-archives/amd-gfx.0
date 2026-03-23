Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EFBF483E7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7EFB10E34B;
	Mon, 23 Mar 2026 19:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZHYQ60SY";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC3410E34B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogkYeixHBOlOecc5YkW0fnvD60T4fb7nwYmGMPY3zUIcBjZBhsQU7JDUM/8lOZbPjJyWFaKJEqCW99QUjFYuAOH++CL+VcFq+iQFNtho/iB/EjjhmFWcBkqN5zUfsIW/l0iKhiWjPjjKtmgs3bBNi5hz+SOM88STgXSbNjW27J8plTQHSowAc/R8SX1JPIV1x1xip3YygJWoRnpZU/Nt+b619j6dN8OaJrN6SD34IqF2OVTM1jRYJi8qN0PMVGCUn3nDfDLmjgYivN4Nxt/fmgw+Wm76+4Akn9tr/5TypnrPf/xGfNZRjbTmlMIB+MPUxENCt7gYmz8Msj6zhUusoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xB5Xp8vpYLDXxTL6aVSKSe1utX2nU+sgBV/knRj85s=;
 b=GAa4gUMMYHfY2wJS2TPx4lNy8Zv6q8RRlrZZbwC6kPtx+BViX4Ig9fy7biLqn4ZEz4Oj1k5c/3mO7cI/N8H1Tjs4FZt/h+gqkP2I0+X2aytw1zdHRgcgPvwUDlOasz+YxEdcPgrV9lDurUrHsC3lQcpHdGto0h7s5C0/OWvGhElCw9Tk1lkcy47PV/9rpB4hHZW/Ij/bjW+Oscy6KsVLrFlZxgRRdUYbzXYvDViL3HuCOpEIVCXsPND/d9+unDhJteXi/IDT4nTLAIjmMC47tVaWRvDPbBfN8OXXDKHXY8t5SiL5DZJ+KN+aXtpMHbdTQGCUEgdurtemFhKd/iVWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xB5Xp8vpYLDXxTL6aVSKSe1utX2nU+sgBV/knRj85s=;
 b=ZHYQ60SYdOCxFtZxpJBXCZEaJbo6A0wB8pVWeyjqn859sX91L7bPZws2qCkWHSrrKZCjWpMdpcqRHKudu5V67mHpca+8Wnmv57bFY5icveGg4otOgvcxRdb5KL4LuqW6ZIRvA2xZ8Oea3hx3hBUcjIjD0R5QdzhlBFl4YSbB44s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 19:42:17 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 19:42:17 +0000
Content-Type: multipart/alternative;
 boundary="------------U5TqvOhQ0Kr7DDidptNJIWHU"
Message-ID: <71936624-a505-4cc4-be7b-385bad5a2f5b@amd.com>
Date: Mon, 23 Mar 2026 15:42:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amdkfd: Reset queue/pipe in MES
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-9-Amber.Lin@amd.com>
 <CADnq5_OmEwONb2pc3g90zr4BwicYhqdj2O--ACWux3gGgtoG3A@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_OmEwONb2pc3g90zr4BwicYhqdj2O--ACWux3gGgtoG3A@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::13) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f03d62c-d29f-468e-ed05-08de89144a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6eBxFB7gtLY244OcVRU3RDbzdxYe4qAshn3V/mPFCJMQULHkvgS2op4aiu0pFJnrcKZ87Ae/EaObE+pizIgu1X1xAnUxxoW7FTgPtamXUbVWnqTHvcB7X97kOaMtRiX4hTgxZIMqyQYl29sWup8jizywHn6U9o2mifoFa92Iu/52bbg1QfjW4x/hi/yCAlNiWuUfOddNV3z/qW59DhTOsSHsQG8qSBy9rQX9pKPqZU5QYhYSCUf8cUu5gdwZIorocjRtoaVQvT85amrPVSWr9a2pMRSL5na+W8dbEDU3b8UGoTL22uG5IwBIFkDfIzO/H4gfg4M095v1tjF++KH1UbutPCkEoSV/Be0K4cJZtkmJH0V3GL6mcYvhX983V4Pt3ta3Ep/XnjaKHBp0POHOYewy0BG0mMK2yEUhwn5MYK3QPmQqYikYRV7vHMdGsCyhNe/Wyi9VvH5pheIHew4uWGvOdB+p8CjKL+wA/2b5b/kd1HsYQ+CAenFGhoNNrYKdwUkFZ4ufFJbI6diGtHA85/jzievGPWa7mvlsC4VMY81mErYzLKQRIA23OonrFFFeqB88/nYHuPsztfi1+HjubdLUKHV3cw5S4ixfsTqKQUR46PefBzWkItyBsyN+UQJTGYxsV97HH7MP1m45zkcjK3eDPmrOSylZdIQQehmmaAPpa0bJs4+mFK7tuI9p5YwoQ6O2en/zJ4C2KYkO7KWcY4GURLuOpcjeppggXZUiFFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEwvQUc2ZFN3QzhsVncvdVR3NlYxMHZYTkVoWXVNQ251YVlKMkNNd0tLaVh5?=
 =?utf-8?B?RmNDT1ZHQi9ZSVNGY1p4RnVWQ0ZtN3d5OFl6YldreE9vRm1RMDFJcjlmTCty?=
 =?utf-8?B?ZTl2R0YyT05YY21obzhlczNQV04rYVRrdWJ5TEZHNGJwR0xQSnpNUkpJeG9D?=
 =?utf-8?B?dS9RVThZTDc1VlJFOXRBOEpYdWFZYzFPOVQrOTlVT0h5U1ZQa1JEbGNPcVBl?=
 =?utf-8?B?eEV3UDlKUzdBZHlVcURkaUI2NzZQbnMzbjYwa1Z1T2JQcjA1cXY2S2hIY1pI?=
 =?utf-8?B?NnpwRUVQNmJWaDhJaHRZQ0F6cW90VEoxS1hWVml4bzJzc1lHK2RMTmk3OExT?=
 =?utf-8?B?WXZwREJYa2UzMGluc1JoeEpURGZZZm5rdTJYNDVFbGRoQ1lCZTczd0ovajJp?=
 =?utf-8?B?TTI3ekY2NTdsRTRLTnFXeGw4V0NiZEV1YjYrNWNOSm1abmhTbi9UZHZmSUtJ?=
 =?utf-8?B?WlBFVnZIM2s2c3FOV1NzdW8rY2thcDlwb3FKKzBSSVRqN2FxUW4xak1NMWNO?=
 =?utf-8?B?OE9uY3Y3SGxnVVJHWHNMVFdYS3YvcWk4UDRGWGZLQ3UwRXlGaUd6bzBRUmRL?=
 =?utf-8?B?eTRyNllKYjY0ZlNSRGl0K2lZT3M5U1ZwbXlDL1duNVYyVWdXSFY0TkZQUVAx?=
 =?utf-8?B?Q0FoSWVEWlFQbllNWERVaFYybVBDZVJUZklORzBqaXR0SXRTQ2VPY2I3OWkw?=
 =?utf-8?B?czRud0lFdUlqZzk2NDV1WUdaek8xY2g3T3Bzd043QjVjZkFKczg2WWFmaVlN?=
 =?utf-8?B?MTh2OUhLYWJFREhETFFjQThKaDNYbWNEaVZMUEw4am5aTFZ3ZmJzWmczdHFS?=
 =?utf-8?B?WXVxOXR6cTdtQm5lWDU0MUg0TEpkRHJxM2lDbmRZVWFZR2toV0R2dXcySmh6?=
 =?utf-8?B?cUJnZDNYRmExbk1mVERHZWFla1BObUxtMXhaSXJRS1VzcGZiQitrREVVMVQx?=
 =?utf-8?B?QlRYdFVKRWlLZDFZc2NRdk82ZS9xSlBjb25rcnlLSzhtd1BodE41dmZuQ3VI?=
 =?utf-8?B?cWdxcE9abnZhcXkyQ3B6NVBiZkFnYzBlWlJDdlF5QlpEYy9MSWh3a2xudVYy?=
 =?utf-8?B?VFJyWklLVkorcXQrNmp4RVhlSkVGQXJINHJFejNNZ0tPSVVTY0hsc0c2Vm5n?=
 =?utf-8?B?WjNaZEVXZHNpbFE1NmdFd1Rtd1MwV09mRHBpSmh1RTJSWWgwMjhFMHhIemhh?=
 =?utf-8?B?S29Idmd0bGlZK2p5Y2dzUC9zUVQzWFpPcWJ4YXhQUTFkTTY3Rkk3MDZhQ0VF?=
 =?utf-8?B?dFhZR081RFU2OVFGS3l5QnNUWjFRM1BWWXF4NDU1M2ZuZ1EzblBhN0dTMStq?=
 =?utf-8?B?TWhIU0ZZUHExUDQ0bzhDS2M2ZXpFUXZiZHNrQ3hFUzZMWC9pSmllZnQzN3R6?=
 =?utf-8?B?S01qTkNRb0M4alduVkVvLzUrZ2U5OVhkQ2NkUDlRY3I2L2NNVjhoSE16OUhO?=
 =?utf-8?B?ejlvYVRDeWFJbEVvWS9TS1prMHN6VmlKNXIwd2x3ZjBtMDNaYWNHazdzOHlN?=
 =?utf-8?B?QVZydjNoV1hVdENNMXhyTUVSai9HbkZQVUwrN1liakowazQ5dlEwVWNDdHZz?=
 =?utf-8?B?TzJjekxQMUVremYrOFJTc0l5Z2JMb241Qm41VFNJYmFVcE80WllTM2tTYXBQ?=
 =?utf-8?B?eHp6SmtqTmZzUEVmbEE0QXlVRWFkVWt1c1RTWTJHMStDZWV6VHcvVG1GTzVj?=
 =?utf-8?B?UnJwZUJUaVcxYkswdG0zSzhtUlpjdGpFbmU1RUdlUzNWOXUwYjBCU05xNnlV?=
 =?utf-8?B?ZkxiUUJpUjhKclVabGI2TjZNNDVXTlVvTXFqbFJUa3QwN0RzOWQzWXJqazJ1?=
 =?utf-8?B?T2xMeDV5Ulp5bFphNXJ1TTM4S1NKT2VkR2RobVhFNVJaOVZTb3dMcWZXdWNQ?=
 =?utf-8?B?dlpvbmxPbjNmaEZkSWhuOGROaVdEY1lYK2RrSTFETUFtVkJRMStKdElENW1q?=
 =?utf-8?B?S2xvc1piaVhJdlltanRSby9LVWxpTVRPSTZGNHFVcG9aUXlPOWF4YkUwRU9l?=
 =?utf-8?B?dGVwWXVoekpsU08xdGxsK1RabFQrYnYyRTZTQ2FEQnVDdm9XU0k0YnhLeGpW?=
 =?utf-8?B?TTZza2xSODQ3LzZiOVpZQnFzc2tmMDFnT1Mva0s2LzVlNXROK1B0VHY1aVJP?=
 =?utf-8?B?QzRLZUZHVnNRSUVGbno1UUVPRm40YVpTc3lVeVlXNFZrd1gxamNFeXlkMFJQ?=
 =?utf-8?B?N0JGRHNMZklFL0FvOFd1UHFhenh2NjhxZ0VjWVJURm0raDMwbTA4VkVXaThT?=
 =?utf-8?B?TmRwVXlabCtqWjF4UFBSOEhMNUtGa21xaWlrOXJzYmFvejllQ29SK1FTMVlz?=
 =?utf-8?Q?Ogm0lwTm3g/XiTqN0t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f03d62c-d29f-468e-ed05-08de89144a11
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 19:42:17.0390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N206snZ5UrOybmoKnrYmoy7QPhh0v7SmUxYtGrHCOde9FPjXNwlEyT09lI6Yi00j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079
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

--------------U5TqvOhQ0Kr7DDidptNJIWHU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/23/26 15:21, Alex Deucher wrote:
> On Fri, Mar 20, 2026 at 4:19 PM Amber Lin<Amber.Lin@amd.com> wrote:
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
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   1 +
>>   5 files changed, 154 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 4f44b933e373..fd6b40d9da58 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -795,6 +795,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
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
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 1ccd4514d3ee..4c52819aef9e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -2027,6 +2027,7 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>>                  if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0)) {
>>                          dev->node_props.capability |=
>>                                  HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
>> +                       dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
> Should this hunk be a separate patch?  Isn't this already supported on
> existing parts using MES?
>
> Alex
For compute queue/pipe reset, it's only supported in gfx 9, which is in
         if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
         .....
                    if (!amdgpu_sriov_vf(dev->gpu->adev))
                          dev->node_props.capability |= 
HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
         } else {
         .....
                        ==> and this is where I added the enablement for
if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0)) {
        .....
        }

But yes, I should take this part of KFD enablement into a separate 
patch. I'll do that in v2

Amber
>>                          dev->node_props.capability2 |=
>>                                  HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED;
>>                  }
>> --
>> 2.43.0
>>

--------------U5TqvOhQ0Kr7DDidptNJIWHU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <div class="moz-cite-prefix">On 3/23/26 15:21, Alex Deucher wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_OmEwONb2pc3g90zr4BwicYhqdj2O--ACWux3gGgtoG3A@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Fri, Mar 20, 2026 at 4:19 PM Amber Lin <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a> wrote:
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
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   1 +
 5 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 4f44b933e373..fd6b40d9da58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -795,6 +795,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
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
+       if (!hqd_info) {
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
+               false, &amp;num_hung, hung_array, ffs(dqm-&gt;dev-&gt;xcc_mask) - 1);
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 1ccd4514d3ee..4c52819aef9e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2027,6 +2027,7 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
                if (KFD_GC_VERSION(dev-&gt;gpu) &gt;= IP_VERSION(12, 1, 0)) {
                        dev-&gt;node_props.capability |=
                                HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
+                       dev-&gt;node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Should this hunk be a separate patch?  Isn't this already supported on
existing parts using MES?

Alex
</pre>
    </blockquote>
    For compute queue/pipe reset, it's only supported in gfx 9, which is
    in<br>
    &nbsp; &nbsp; &nbsp; &nbsp; if (KFD_GC_VERSION(dev-&gt;gpu) &lt; IP_VERSION(10, 0, 0)) {<br>
    &nbsp; &nbsp; &nbsp; &nbsp; .....<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!amdgpu_sriov_vf(dev-&gt;gpu-&gt;adev))<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dev-&gt;node_props.capability |=
    HSA_CAP_PER_QUEUE_RESET_SUPPORTED;<br>
    &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
    &nbsp; &nbsp; &nbsp; &nbsp; .....<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;==&gt; and this is where I added the
    enablement for&nbsp;<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<span style="white-space: pre-wrap">if (KFD_GC_VERSION(dev-&gt;gpu) &gt;= IP_VERSION(12, 1, 0)) {</span><br>
    &nbsp; &nbsp; &nbsp; &nbsp;.....<br>
    &nbsp; &nbsp; &nbsp; &nbsp;}<br>
    <br>
    But yes, I should take this part of KFD enablement into a separate
    patch. I'll do that in v2<br>
    <br>
    Amber&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
    <blockquote type="cite" cite="mid:CADnq5_OmEwONb2pc3g90zr4BwicYhqdj2O--ACWux3gGgtoG3A@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">                        dev-&gt;node_props.capability2 |=
                                HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED;
                }
--
2.43.0

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------U5TqvOhQ0Kr7DDidptNJIWHU--
