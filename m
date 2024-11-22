Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B5DE6916C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 15:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51DAE10EBBF;
	Fri, 22 Nov 2024 15:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YQg8CMHZ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A3B10EBBF
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 15:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFxVzAO9fxEOW9wtDcXwWloLaOM/KjkXeT4g5Mz9mX1lONtBaqjjnsOj/XtfZsJKUiSf0Ec0pIPT8LIKn+iGQ0K9GniONepE8vTb/dLIaAOiEpf/MNXaELud3tDCXXf2Tw9vADEvsRMOhA0eBrz/YscQ7dt9NmuRApk1fK6IInVbE3kWU73NXPTK6FpxTucTVkgnTr4MqR5Q3DJrbGuUAN6KWudSBhbuHR5NE37AVfEyDlhITZoeEu0qx8x1FqSUsnijRrh94X/3RFgcoqA/c4OUVXZSuVZA4S6amporhIqrtqMJ8Ou6Imr3yYKCHn3rHfiasX42Tz0eF6wogkx51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbTwnTwCnmc8iN3Kezw31tiAi2Y8sqsVSMyPHPh15yY=;
 b=R0ZVFuQBrEIsXyA9tenNoI9pNpmHzwI+hLRdXZ6dgQ/0afYDU5X2xpKfDD/mGYXdKxgCSEWKQiqGxkEyv3SIMA69IpxWzmStc9TkGWhdWa91OY04Z+buojw21t9AU5gN+3kKB/wEIolUsxtu6IpTZx746p9TzUNYBe0UVW40qvInoeRQ0lqTFPQLfKgXiUSOYnfJFXQrL3Qy9jILTMWeVPJHE//9YqViaRVxsLU520Jg4VGUAnpICRSoDAPvkGrsWlABIqWwjtCOeHJICIYlRuqrm2i2eYjqDAsPBguxTyzRp68b3AgAdmc/hXG2yRDntfhTA5zS8N6Zpo9dXEYtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbTwnTwCnmc8iN3Kezw31tiAi2Y8sqsVSMyPHPh15yY=;
 b=YQg8CMHZwwNshjXZ8FotuQJISRbiIPBZgVxhRCKNBCPiakYRlQ0zRmV+5Wir60DBkGu9Yc1ZlxjGAlPUorcoXhlS1RJFfFy8rcXPoq6sOTNnSVAm25kNDaUcM75mkdjhslrQqC3r2BMtx/nOx08BqWfxOpKTLN/79cw4EsWbNQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Fri, 22 Nov
 2024 15:38:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 15:38:01 +0000
Message-ID: <01b16cb3-71e0-4f8d-b9ce-1c6b261475ce@amd.com>
Date: Fri, 22 Nov 2024 09:38:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add Suspend/Hibernate notification callback
 support
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241118200323.16541-1-mario.limonciello@amd.com>
 <10227541-3d1b-4e48-9a17-b9c0dc25a541@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <10227541-3d1b-4e48-9a17-b9c0dc25a541@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0069.namprd12.prod.outlook.com
 (2603:10b6:802:20::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: b25ecb1b-7c5c-4f11-65f1-08dd0b0ba61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXNObUVuelRkK3dtbDdMNDJVSTBhaUo1cFdYKzFscGU4ekU3RkQrckZnZCth?=
 =?utf-8?B?YW04MGIzQXh6eHgyaTlsZk9Kd1RRU0ZjQXNqYlNydDF0TFhURkI0UEw0Ujh3?=
 =?utf-8?B?c0grSkdmcmtzbEtQb2xrMDJYOGZHMTNIR0c4OUlxYzFBYitDZ3dmVDUzSTNt?=
 =?utf-8?B?U1VtcXdrVGkxak12MENwQnh2UzdtTmtQZEdpViswMGN3SllFYmR5L01vWnZL?=
 =?utf-8?B?RWlhWGZTSXcvaXVtbm0wSkJ2RDFoMHp2K3dvQ1kwUjhhdVF0MDVQZ2thY290?=
 =?utf-8?B?KzVqWndBNW04V3EyNGR0T2hYM2RYTTNCVVlFSHNneTZTRVQ2OERxdlBCdDg5?=
 =?utf-8?B?UHZvcGJlK1pIL005blJiNmZPZEZVYzFmNFBtMyt2STFERWNmL0ZhckU4M05V?=
 =?utf-8?B?emE0V3gwY0VvN3h4WVdrSUgza3ZyZmxzOHhQNlRQS0krdjdDWWJnZ3JMOFA5?=
 =?utf-8?B?eG1Jdm9TRTlrUEtRd3BiQ0hNcGtxU1BjbjBLaFIzWm43b3h5MVQxd2xXekpO?=
 =?utf-8?B?UkpOcVFLM2tIa1JzZno5VitvQ2t4ODd4dmVxZG9iVEpZaVVVdEx0Y3ZicWsx?=
 =?utf-8?B?blpXWk1BYmU0YjhXSGM4ZlRuQWRsbnBCWnZFdVBXS05CU2luQTRNeERJK0Js?=
 =?utf-8?B?Q1hTL2crZzRSVGhjbzFPMk5Kd3dJRG5OOU5nRnhqaDdSaHVHU291T2RVYVdE?=
 =?utf-8?B?TUdFL0NNdXFoR0t2UVVpYXNvanRJOGRIQ0owTy9uMC9XaEdsNUFSL1k1OFRZ?=
 =?utf-8?B?ekszeDhYMS9IQVAzcVMyOHR5S0Yzb28zQkxjYlJMVEEyQ2NVRnpxcVZKVkp0?=
 =?utf-8?B?OHF1ZEViQzVqM3JtSEJucko4UGJBcXFiQ2IrY2JPUkhVQVdCR2s3TlpLVE5L?=
 =?utf-8?B?MzRQM3E0Ky9zVnZpeFJ5MXJMTzNpY04yUFhyNEdGNlh1VmhSUWljMTNhcGpZ?=
 =?utf-8?B?YnU4MTFEbEE2RnRQQU9PSXphaHA5Q280ZEp3alJNMklKLzZja21nOUtaZ1hi?=
 =?utf-8?B?VS9kdXNZVUV3OEo0L1dMYmpqMjVCbU5aSlArRGl6eWViNTRPRzVnc3NaVEVv?=
 =?utf-8?B?N2wwK1ExdlNERDBzclJtTlBsVDQwMlRrSDZwbkl0d1NPcTh2SDBWYTkvRHdO?=
 =?utf-8?B?dWdKUGIvZUN6OXlPcU13NnVGZk4vWmJaN05MNGwyS1JNMWhmd0ZpVDYwN0Zm?=
 =?utf-8?B?YU5vOURJRjBkWVhIUmhBYnFDU0VjNXlhSXFKdEkrTTFObXI3T2xkWCtQbGtH?=
 =?utf-8?B?bGdjMVhGVEJleVJMWFZyWEdUKzdPUVJ1bzhoQlhqMEIzSExmQURHVHhFR2h6?=
 =?utf-8?B?RVhpWDBnMjhVQko3VUE1NklwU3JjcmVVeFFOditDYTRNOTZEYmxoQmtHMnZJ?=
 =?utf-8?B?SDMvZU1JRGJFL2R5M1dyaHhNdmJOMHpKZVZsdFI3Y2lWaVg3TkF0SHY2aWcr?=
 =?utf-8?B?Vkk1bWVTZDZtZ0h6TEtwQmRWK09qK1hLV2NZaTFmTEZMOVlteGUyZUtoeE5v?=
 =?utf-8?B?VmlmcytqV3F1NlJITW9Wdzh5MHFHOEF2QTN5WXBLeGRlb3h4Y1Q0QlJkeGFJ?=
 =?utf-8?B?T2ZDNlJqcDZueHZ6N2t1cFl2QkRJM1h0VXl4SUVHbzV0QTZjRkgwOERkenV6?=
 =?utf-8?B?OHhiRlVqd2dYS1lNSzJGaFRFWmdvZWswdkhNYjZrdnhwaUczc0JjYWNCbHVa?=
 =?utf-8?B?RDlneC9SK1RDYUQxYTN6RDJRN0puVkU4ek1tSjJrL3NXRVdocXpINWFESldY?=
 =?utf-8?Q?s9UF4JjbfyUkQ/AHVE8K0wsHM8H1H/gQaLrMqXZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDMvUkQ5ckpRemtJcVJOZXZqSEh1N0VTTFVGckxMMXpESDliU2tuOG9aV2ZY?=
 =?utf-8?B?RkM3K1hNUjBxTmM3NEVjTDFnUU9GWDBvMWpNMU00d01kRjBINDEwZUk3c1Zp?=
 =?utf-8?B?RUZiN25aZU5NU0FxRUhZeG44NDNHdHNmMG1DU1JOeC9pZjZ5RDlHTUJEZjBp?=
 =?utf-8?B?WnBPbGZvLzNXTDV1QWNmYXpkakw2MXpHN1B5aHpLdEVKVUgzbWtVYVkybDlr?=
 =?utf-8?B?UW1GSUd2Q0YwVUJWK2JqaDZjeUdPb3RNbGgvUXBIb2RVMTFITm9DTHZqMW5a?=
 =?utf-8?B?VlRUNTc4T1dmVDVQUDZOZFg5MzI0SFNmZVVlMzJTTjMweFJsQ2ROUExlTHc0?=
 =?utf-8?B?NkUxVWtLaE1sYmpSdGxHS0ZocWxBaDl5TjBYNHoyakEza1JPYml1cXRVcitk?=
 =?utf-8?B?dk1MQitrWi9hRjlCU29TNjFkZlBFUTdCaHNHbkVqb3N6WjFUTXVYUzZndnMw?=
 =?utf-8?B?UjdaUkc3RCtGWlNvbFJGeUZRSmRVOFlwQ3lleFA4WmhlWTRHRE9lTk1va1pZ?=
 =?utf-8?B?b1ZWcmJ4ODZOQVRRUlVuK3h4K0tKdWpXdnNWanRobnk2K1lMc3doSVJ3TjFG?=
 =?utf-8?B?K1g2ellNS2JFVWpNTzU0bUh2U0xMVDdPMFNHR2JMVjQ2ZkVmTTkwYlZZOEFx?=
 =?utf-8?B?cHF4Mzk4M2w2QnJ6blZncWJ4bHhidktOQkdJUHhoa3ZGQTlJeDVpWXd3OW5y?=
 =?utf-8?B?NjJjWTI2TmRJdHROajVMWGR5T1JMU1NrWldtbmhkV3BBTnJFcndtN1FMaXgw?=
 =?utf-8?B?THNQTXZvSTYrd3FxUzBraWsrdS8vQ2FQL1BTb0JIVFIwYWFjTCtrN1ZoVlJG?=
 =?utf-8?B?eDc3YlJLdCtFd3V5NXZYRVBCTTdta0VxSCt0a3ZZcXdFODFNSnV2QUxEK3c2?=
 =?utf-8?B?TklidmU2c3lVYnhUaGs3MCt6WmxzNElVbEZlTngwRFZ0MmcwMWZHRHlheDBR?=
 =?utf-8?B?OUV5Zk05djdiUHd1ZmEwOFlrVUh5MkxBbVNNSGtHQTdSdVkrK2dvWDhJUktE?=
 =?utf-8?B?OWw5RmlVcEdCSW0wdWRRRXduS3VSTVpvbVhOYlM2SE1xOEY3d0hSWDBKTXZp?=
 =?utf-8?B?T1MrZm11YTJOcDJzTzlrQ1BVK1BhNkUrWnk5V2dnNXNNQlprcVZCWmdGOEU3?=
 =?utf-8?B?b2tLNHFUc0VxVEp4RmtUTDg1TWNDS1hiaGNRWWl1cGRnZTI4Nk1Lc2pGNWVi?=
 =?utf-8?B?Z2ttYUUyRXZmVk5jYk9wdUNVV3lsREhJYVNZTmhWRzAweGJ4VllETEdFbnRH?=
 =?utf-8?B?OVZmN3VCbFB6WDh6OEw0cGNDUE9BVlJMZkJIYmQwQjNPaGFjWUc4YzNUVmxq?=
 =?utf-8?B?RGdNdy9mMEpNYXZ3QWIra0FRb2xCYysraVpseG1rQ0lXWkNQekwzbmtKcm1W?=
 =?utf-8?B?dHlESHZVTUk4Uk1TZW1pQUtoZTRlUFptdjJjR2tlVDlCaXp5dHBiQ1RRMWZ4?=
 =?utf-8?B?ZG1sK2Jld2c4R2ZCWFFEcXhmQW1lRGdVTWV5Z3c0U0M5RFJ6OTlkNDgreHBR?=
 =?utf-8?B?ZkRwVXFwQzhXb3RhSUlGUmVVaUkrV0NtRXVoWFFLVWZNUHRSVWg1VEwwc3dq?=
 =?utf-8?B?RXluUkppNTVnbGg3UnRLaUd0YVd2ZnJISEdnb2JYUFEzVU1VMGQ1bGlmbEJh?=
 =?utf-8?B?TFRGSzI1TEVBR3ZTVU9INVBTY2tudUk2R2JOQTNCMlkzMU5RMldUR091UGc0?=
 =?utf-8?B?ZThHSFk1aE81c1JLd2ZnZ2d0QnE2bGhpWjM0MXVPb04vVHhWWTlJSjM3QXRS?=
 =?utf-8?B?bDgvdHNudzhzN2l6d20wQjI2Vjkxc2FEdEFVKzI1c0txd045SUNTemRnbHVK?=
 =?utf-8?B?Mmc3WkQxRnFIWkZ3SkNaSnFydXpZYWpSSUpxNzEyQjBwL3lYSDlmbmhobVZm?=
 =?utf-8?B?NW80dG1XcDNlT1VIdUVQRFZ6VjVwa1AyMEw2L095WnBickNjNTBNcUlkNjRr?=
 =?utf-8?B?ZTY3WWdOdnZqV3c1dnZDVUc5QmZHTEFsZUQ0Ui96VzlMdG53YVFwb3NCS1JI?=
 =?utf-8?B?UnU0cEVybkNXamlZL1IyS0QxU1JwMlBZaDNYNU9xZ29COEordHFSMVFiaXRv?=
 =?utf-8?B?Q1AvVVR2M3p4dnYrZzBsTkxZUDhYVVRBamo3MzNtR2tKbW0reVlyT2dGRU0v?=
 =?utf-8?Q?asuqcbrYMspvv8aDMf9N/hgwn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25ecb1b-7c5c-4f11-65f1-08dd0b0ba61c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 15:38:01.8187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybp3/7FVxts33UE01zpMbXHSM4buIYUU6MdJBzqCLFMqAF1mxKtdClvRnbmiYcFk4cAD9wHkqYuQE+VNX+svWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
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

On 11/22/2024 08:28, Lazar, Lijo wrote:
> 
> 
> On 11/19/2024 1:33 AM, Mario Limonciello wrote:
>> As part of the suspend sequence VRAM needs to be evicted on dGPUs.
>> In order to make suspend/resume more reliable we moved this into
>> the pmops prepare() callback so that the suspend sequence would fail
>> but the system could remain operational under high memory usage suspend.
>>
>> Another class of issues exist though where due to memory fragementation
>> there isn't a large enough contiguous space and swap isn't accessible.
>>
>> Add support for a suspend/hibernate notification callback that could
>> evict VRAM before tasks are frozen. This should allow paging out to swap
>> if necessary.
>>
>> Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index a37e687acbbc5..e70ca85151046 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -885,6 +885,7 @@ struct amdgpu_device {
>>   	bool				need_swiotlb;
>>   	bool				accel_working;
>>   	struct notifier_block		acpi_nb;
>> +	struct notifier_block		pm_nb;
>>   	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>>   	struct debugfs_blob_wrapper     debugfs_vbios_blob;
>>   	struct debugfs_blob_wrapper     debugfs_discovery_blob;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b3ca911e55d61..5a4e9c7daf895 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -190,6 +190,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
>>   }
>>   
>>   static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
>> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>> +				     void *data);
>>   
>>   /**
>>    * DOC: pcie_replay_count
>> @@ -4582,6 +4584,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   
>>   	amdgpu_device_check_iommu_direct_map(adev);
>>   
>> +	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
>> +	r = register_pm_notifier(&adev->pm_nb);
>> +	if (r)
>> +		goto failed;
>> +
>>   	return 0;
>>   
>>   release_ras_con:
>> @@ -4646,6 +4653,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>>   		drain_workqueue(adev->mman.bdev.wq);
>>   	adev->shutdown = true;
>>   
>> +	unregister_pm_notifier(&adev->pm_nb);
>> +
>>   	/* make sure IB test finished before entering exclusive mode
>>   	 * to avoid preemption on IB test
>>   	 */
>> @@ -4777,6 +4786,33 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>>   /*
>>    * Suspend & resume.
>>    */
>> +/**
>> + * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
>> + * @nb: notifier block
>> + * @mode: suspend mode
>> + * @data: data
>> + *
>> + * This function is called when the system is about to suspend or hibernate.
>> + * It is used to evict resources from the device before the system goes to
>> + * sleep while there is still access to swap.
>> + *
>> + */
>> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>> +				     void *data)
>> +{
>> +	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
>> +
>> +	switch (mode) {
>> +	case PM_HIBERNATION_PREPARE:
>> +	case PM_SUSPEND_PREPARE:
>> +		if (amdgpu_device_evict_resources(adev))
> 
> This will result in an eviction call on APUs since the flags won't be
> set by this time. Is that intended?

Very good catch!  I will bump it and modify 
amdgpu_device_evict_resources() to just skip APUs entirely.

> 
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4739
> 
> Thanks,
> Lijo
> 
>> +			return NOTIFY_BAD;
>> +		break;
>> +	}
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>>   /**
>>    * amdgpu_device_prepare - prepare for device suspend
>>    *
> 

