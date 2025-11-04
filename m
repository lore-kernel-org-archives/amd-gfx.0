Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143A2CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A722E10E54E;
	Tue,  4 Nov 2025 08:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y2/2wLGb";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA38310E54D
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKz14+6CERM8VOtmMQN7eZtjXPJHRFJHDnV7gk5v11BYi6FJqo+Q39/rKun/shXdVDq0DbnaIQLPPLuZx5m37FE+c4XTueC/u6NSNA9etSgEAyFUj+KwcDSM6tT9LMEPl34kbEok6Yi4rySqo2afEOGbm/NEZpaIdqSU2dStMuLmZt11g4K9Mi+U22F2Kxjn3kkHIXGt3bfBtdVHuPgWzNi79w1gMHEexoS2wMwxFwVlDsyhj1GUcmhD0N0F7Dab0dpCkY45UYKQEgnoZGmxUZKos/1imMIqcxFW9XK8MqMUsEHTTW53t2F4BuJJbe8GcD/1wmXj01Tnl4wzXXfZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW88rTClbPsmKadXcbeqd10xtoeACnN67Om4jf5FCmQ=;
 b=cC7ELObu+MsrI6X5tIIKFWG3PT7C1aP9DAYpi89zMXxpNUP8XgkguOmt9GM5AGHQJ+WbwvMYhJN3z6lNIaZIRcCXYmO9NP5CkCAwCr3J9qF7ZRCzoNimofsPQjwy36jJIn87X9Qua4xPcqU+WAFSuNSUzCAWfRm4qFMiVwwit9EuoPvf8bcapJSgjBBE0AIXx5adG4KBgc5xWnRhS6gzb/e+hlSUOjo64FifdY7qhFleWb0aamV0Izao9Fwu4195OAfanGseDfVVk2Dfja6bpT+xgA+jw7x06kRfqts8CDkSLK3VUwVuOHvrE08jcArGpNXJIoFF6UNrCKtiObrEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW88rTClbPsmKadXcbeqd10xtoeACnN67Om4jf5FCmQ=;
 b=Y2/2wLGbM+/sYgiUiXKXDhtHF2WxOR/ehwTRSEesxS8TS6L1wV+FLDcca7verE5CmMGBdhPp13TjxfCAQBAiSrBYWDkVa5z8a+EQJ6noq7j44PRtb7DcIKSujzErKuHtU2dJFyyk5iO2MAjJzhbsWbp/gbxovFKVeSkgPtaOFic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:30:50 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 08:30:50 +0000
Message-ID: <80cc29e4-76bf-4256-857c-e912e61f8900@amd.com>
Date: Tue, 4 Nov 2025 14:00:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] drm/amdgpu: suspend ras module before gpu reset
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: yipechai@amd.com, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com,
 Stanley.Yang@amd.com
References: <20251104080212.3641072-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251104080212.3641072-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0071.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::17) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b377ab-baed-4ba8-06d1-08de1b7c75f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEtjVkQwZHdhb1JWU1B4bm9yTllwSkNlNmdXLyswMmZJRXp1QUxQZ1ZNdlkz?=
 =?utf-8?B?NG1mY3hENEFUK1pjNENZdFR6R1JiNHdnTFlITnhKNGdmSDhOWnlZMGFDV2hp?=
 =?utf-8?B?YzFoMEZKZ1QwNzg5WlQwVlI5aW53bEloc1V0VjFwemYxS1pQbStzbXQxZWV0?=
 =?utf-8?B?TjVVYlNLL2JhRDkyRVREdUxkVEhYMjhTK2NmL1Z5RkNhWmx3VnYzbDVGNE1O?=
 =?utf-8?B?K0dTdHM1UXdsUXlTUWlVQUtSQVh4UDFqcUVFejZ3OWxMeDFXcGNwMjJvQ3F0?=
 =?utf-8?B?VlcwcFNuSWdaMHdxaDkwcHh2T1c1TzdTT1N2QWp6ZEpmdXN2Q0lIMmcvVjA3?=
 =?utf-8?B?d2RmZSt0Zld5dFlvK2lKSzFzZFo5NnY2VWVOUTgwaWdWRnhNMHJDMWc3T2Zm?=
 =?utf-8?B?VkFaNVVnZm5ETm9qK2pScXJ6OE5zUE1hTllQWlIveVhkd2U5ckR6Z3JsL1BI?=
 =?utf-8?B?d2lBYXNYOWtCRzR5cVNvZ013d3R2WTFnakVUM1BWUEEvWG8xd2RBREcyNDhI?=
 =?utf-8?B?WWx6ajZXdEN1anlHdFBQU05DM2tLeXR2eU1zOGdKVUh4V2xGVDVrMlVjM1A0?=
 =?utf-8?B?c2Joc00wOEZIV0dpNTJFZUJGNUhKaE9tVFZTcGk1SE5qdVc3bHdmdnRSQnlE?=
 =?utf-8?B?d2g4YnluZWlsVDdTak5DcUIydlBCYlFxUk1QcEsvQnJTZmFMRFpqOHlJVG9R?=
 =?utf-8?B?ZUIzZVNXQVBldnQyZk15b25rb0tGam80U2UzWFBIaXhPTnJlWDkrcWJUbVk1?=
 =?utf-8?B?UDQvRzFBdklHaklEaU1hdjdTY0JneHFvVTRkTWJXZlFQL3doczdXQjQwUEc3?=
 =?utf-8?B?MTRVcGEza1Fackt1MFdBb3hNRGNxNmlEV3RjYUJFWDFmamlkTU5WSnJZWmdq?=
 =?utf-8?B?ckNYaXp0RHVlS21rYm1PSDlkeGM1TWtoa2FMbFkxa1VrM29kbm1EK05laXdG?=
 =?utf-8?B?TDFQT3NvSUFsd0twb1RLOTZxUXdJWUl0YXZCVGZqSUE1bmcvdGRoVGF3cC9P?=
 =?utf-8?B?YVBLZk4rcXJsOUtLVjdSbnFDTW1VWVROcC91WEt0UE1XK1FaT1NrK1FBazR6?=
 =?utf-8?B?N1drSW5aNEJiQ3pnY0V1SHlCWFhxZCtZNituT2pFSGRWOFdqcVVlOFBYRUZq?=
 =?utf-8?B?SVFFTGNXY2dXKzRVUTNkenN5ejNjbkRpb1UvWk96MnV6MDYraW42cStzNHhw?=
 =?utf-8?B?aUk0VUVBd05MUzhRczJMbmNzTUJ5UWRkT3h5OVA2SGlWT3VRQ3ppaTZ3SVdl?=
 =?utf-8?B?cmFPWlB0VVE2Z1JFMDhpMjI2ZmlwYVpsb095ampGbkNEanVHYXdOc2d2MzZu?=
 =?utf-8?B?TzUvakd3NWM5Z3E4djltb1NCWlUyRkw0ZGtpbGJvNTZacm5ta2lFdk1WaHFK?=
 =?utf-8?B?SE9qQmc0MGZmeThRSm4wc0lpdFFBWVRiMG5vVmppK0R0MWZncUVVK3VnNHFF?=
 =?utf-8?B?MDd3Z0YzWDZITFZjQWovd2Y5SkFMQWxCd3JLR3JqZXFqcHpMRVNmbWtRL2l0?=
 =?utf-8?B?NGJKTFZ6VGxmeCtpZGl1ZWVzaG8xb1BtenJ1L1JpZlFsaU1vdE8xQVdONTRW?=
 =?utf-8?B?NnZyNTRHNDFOKy9xY25SdnBMWTRXMnlDSWRXSHZPREh2cENVaTQ3L0p6bDcr?=
 =?utf-8?B?d2dNdi8xdVJKVklOTGxTTElMS1lsV1dsRGljNTNoR09SdHkrdmdYT0crWnVU?=
 =?utf-8?B?V2NtMG9TSktVdmtBbVJRQU1YNVVGVlpNZkplRFNhWHBnQ0Y1TUFlZ0JEOUdn?=
 =?utf-8?B?WUhLd243ZGVMeENOb3o5MkhvRG5CcERDWGhxM04vVU1nYyt2RzErOTFQZUdM?=
 =?utf-8?B?VUowZzRUMmV0MDNLcmJQY3I3RUlGaHRUNWx2bnpoMFJBSWtTeHR1MExNUkxX?=
 =?utf-8?B?MXZZRnRwekpWSkpoMEpnSEdJalVXbnQ5eE1TWE9SdzNKTVk3YnZYUmtJOE94?=
 =?utf-8?Q?xlctZHrAVqwlQ804SDH7UvDZOEwtb0CH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBJbHgycC9GdWdTb2xhaGllaDdLdk9PclF1Y1A1SEtpY2ZpMk1mOWs5eVhG?=
 =?utf-8?B?NWdmaE16azFFS3c3M09MZXJDTzN4OUlFb3VWcUlmMzdQQXowYytPQ3drQTlC?=
 =?utf-8?B?R2RqU3ZCQ1FlVnlNQzg0WE95cU1LeTFRWWZmOER2OUFLc21aeDZuR2sxTnJk?=
 =?utf-8?B?d0hublhZN0pibEk5SlFobWs4aUUyMDdBQXNUS2QzVytnZnIwMVA5V203ci9w?=
 =?utf-8?B?citab0t4aWdvNGxPdHpVYzBDajlWeFhPMG53V21JNThvZnBPeVJzMzZFNGgx?=
 =?utf-8?B?ZXJKTm5KVEY4dmI1NzRDU3dVbnI0ZFZzY3dFYnEyK3pVeFN0dzd2T01EQ0sz?=
 =?utf-8?B?U3Ewa3I4VmZSVGVaWnkvQWd4S21jTld4d3FXek1TdklRMnlOY09XVWU3NVMv?=
 =?utf-8?B?c2dCanA0WGhuaWQxSiszMVpSMEZOZmIwVDBhNW9waHRlSVdCQlJrV240dzA4?=
 =?utf-8?B?akk0RWpOSmY2NGhZZGJxeW9QeWdPMkxBZWxzKzY2RHRoMFNVWEhaYlpDVDNk?=
 =?utf-8?B?ajkvaE5ROW1BYnhoTk9KYnhjQ2cwY2JuczgyTEFoNzRrRnp1TU9EYmNGeEFw?=
 =?utf-8?B?ZVlIN2VlM203L0NqUk04TEtrdnRxWGk5RVRreUFHc1QvN1d3TmpMTjBXaU9o?=
 =?utf-8?B?dnhBL1ZGYmxNZUpPbFFxVSsweEJoZzVaVkUyMUVZOERObnQ5aVpYWktJelQ4?=
 =?utf-8?B?UUlVeWU0emVRenAwd3JhZFlZSEN1NElTYkdxTktWK2ZqbVdqaVpyWCs5VGhm?=
 =?utf-8?B?V1hqTitBeFUxeWVGT0kvZENtVjJjbGR1YTNpV3JvWXU2dWNuYkNlWm9jYi8v?=
 =?utf-8?B?ZzdoVEdxeVdFbGt2TmdFcjgrRUUySk5PMVBMWlhIWVpjTEZuOEM5cjhRR3Uv?=
 =?utf-8?B?MVhncU1tZU1KNC9jZUduWUUzQ091Z3NDTkJEZlJ0V09VemhqajJGdTZvWGxB?=
 =?utf-8?B?M1RjN1htU1pzVngzd3MrRnFnbmxaS0M4bUIwQ3Q1S1N0NlBSa2lIT0xCZGhy?=
 =?utf-8?B?dDBzK2JtQ3RWYzZVTmY5WllPSFFqcUxNL1JOQUQ3MmNnZ1FiUnBXaUlpdWZs?=
 =?utf-8?B?V0h6d2hSWVhIRmM4Z240NDBZcnpsa1luUFZOV0VoNmpqUXpuNlNwdTZqUnhL?=
 =?utf-8?B?OTJQS24wT2NhTVY0WGRVMm91TWFMQldLRmdxMGI5ME1yL2xINTlpYlVzQ3lo?=
 =?utf-8?B?NWNmbE4vM2VMblRNajFRL2Z4ZnBOdlBjSFN3eFlMTWpXTU5PUDR3dFBGcDB0?=
 =?utf-8?B?OG92KytFTTRZeTJzWEYzZjQyeVVpVU1rVCtSZFdjc2IxRlljMVd1TFNlVmdY?=
 =?utf-8?B?N0NlcUN2WTZkMVlVaWdPeWNWTDhSV3hJbmgrc0FNTDZrNDM2VUUreFYwSWlm?=
 =?utf-8?B?MGc5RmxYajAvUkpTM0xvTWIzWkhiY1FlZVFBd3J0UlBRMXBJZ0NsY1dtK1cw?=
 =?utf-8?B?b3FwekJoK1NpMzRwek45M1lRdTE0NEVpVlhEUDhRaDQ0RHYxZnVMb1NyVlhK?=
 =?utf-8?B?QmlEQ1ZTQ2FmVUFDNWQ4Qjc1UStvSGg3OTlXeURYNUtPNmFDbjVOcGFTUWFv?=
 =?utf-8?B?RjNiNUkwV1pORmFVSmpjcEQxRklrSnFDWE9aYnVZNnFWUkxJdkkwbTVYY3Rw?=
 =?utf-8?B?NWxsbkdjUmRlYUJSZGR0ckhtd2pDZ0xCVlcwaS9JK1BMeDVNL3lXUGlqNXFK?=
 =?utf-8?B?RHhlTG5aV1phSGFFd3pqY1pJZXVhYW94WFpwaGMybjBYcUIvQUxEM3BncmJ1?=
 =?utf-8?B?a3preDJ0RmxnYzF3YjdVdTF4VlRkamQyYXlWeUVjQTRocFhxbTBVc1QvZWJQ?=
 =?utf-8?B?R2RmWHU2eXdPazJPbHFHSEs2b29wSHp1d0JBQ0dEc1pCQ3huVGw1M1ZLayti?=
 =?utf-8?B?VXFPMXlnR2hkZlh6MXN6VGYvQjZjL2M1ZXp4bGhvQXlIbEZFM2hCWkZ0enBJ?=
 =?utf-8?B?d0tRbTlXRGxwM3JmR1lPek13M1NndERPemdYOEpkN0lBbG51YU1FWmlQK1hD?=
 =?utf-8?B?UDcrNkgrakZJT21CN3Fzck9OT3U2ZVRuWitIZm44YlFtQVZHMC9uaEJCVUJJ?=
 =?utf-8?B?Yk92aWJkQXJ4djIrVEZlcGwrTWQ0NjBQTUtlOEp4UXVEd0VRbW1iQmlodm1u?=
 =?utf-8?Q?yv3cebfBWJnQN5J8zYoUGOq26?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b377ab-baed-4ba8-06d1-08de1b7c75f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:30:50.6151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDCiEHxzqZl5CQ27CtofGNiYU+wfgFRuBtr1YnfOQ/8D49MUm5PQQnbAIlSP1JVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
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



On 11/4/2025 1:32 PM, YiPeng Chai wrote:
> During gpu reset, all GPU-related resources are
> inaccessible. To avoid affecting ras functionality,
> suspend ras module before gpu reset and resume
> it after gpu reset is complete.
> 
> V2:
>    Rename functions to avoid misunderstanding.
> 
> V3:
>    Move flush_delayed_work to amdgpu_ras_process_pause,
>    Move schedule_delayed_work to amdgpu_ras_process_unpause.
> 
> V4:
>    Rename functions.
> 
> V5:
>    Move the function to amdgpu_ras.c.
> 
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 30 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  5 ++
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 22 +++++++
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  5 ++
>   .../drm/amd/ras/ras_mgr/amdgpu_ras_process.c  | 64 +++++++++++++++++++
>   .../drm/amd/ras/ras_mgr/amdgpu_ras_process.h  |  4 ++
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  6 ++
>   drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 +
>   drivers/gpu/drm/amd/ras/rascore/ras_process.c |  7 ++
>   10 files changed, 148 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cc6e59208cac..04e6a0c85065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -71,6 +71,7 @@
>   
>   #include "amdgpu_xgmi.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_ras_mgr.h"
>   #include "amdgpu_pmu.h"
>   #include "amdgpu_fru_eeprom.h"
>   #include "amdgpu_reset.h"
> @@ -6660,6 +6661,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			goto end_reset;
>   	}
>   
> +	/* Cannot be called after locking reset domain */
> +	amdgpu_ras_pre_reset(adev, &device_list);
> +
>   	/* We need to lock reset domain only once both for XGMI and single device */
>   	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>   
> @@ -6691,6 +6695,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   reset_unlock:
>   	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
>   end_reset:
> +	amdgpu_ras_post_reset(adev, &device_list);
>   	if (hive) {
>   		mutex_unlock(&hive->hive_lock);
>   		amdgpu_put_xgmi_hive(hive);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5377cde0c55d..75d61a7653c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2921,8 +2921,12 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   		type = amdgpu_ras_get_fatal_error_event(adev);
>   		list_for_each_entry(remote_adev,
>   				device_list_handle, gmc.xgmi.head) {
> -			amdgpu_ras_query_err_status(remote_adev);
> -			amdgpu_ras_log_on_err_counter(remote_adev, type);
> +			if (amdgpu_uniras_enabled(remote_adev)) {
> +				amdgpu_ras_mgr_update_ras_ecc(remote_adev);
> +			} else {
> +				amdgpu_ras_query_err_status(remote_adev);
> +				amdgpu_ras_log_on_err_counter(remote_adev, type);
> +			}
>   		}
>   
>   	}
> @@ -5672,3 +5676,25 @@ bool amdgpu_ras_check_critical_address(struct amdgpu_device *adev, uint64_t addr
>   
>   	return ret;
>   }
> +
> +void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
> +					  struct list_head *device_list)
> +{
> +	struct amdgpu_device *tmp_adev = NULL;
> +
> +	list_for_each_entry(tmp_adev, device_list, reset_list) {
> +		if (amdgpu_uniras_enabled(tmp_adev))
> +			amdgpu_ras_mgr_pre_reset(tmp_adev);
> +	}
> +}
> +
> +void amdgpu_ras_post_reset(struct amdgpu_device *adev,
> +					  struct list_head *device_list)
> +{
> +	struct amdgpu_device *tmp_adev = NULL;
> +
> +	list_for_each_entry(tmp_adev, device_list, reset_list) {
> +		if (amdgpu_uniras_enabled(tmp_adev))
> +			amdgpu_ras_mgr_post_reset(tmp_adev);
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 40c0bf85f1d3..0bcf73f8c840 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -1012,4 +1012,9 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
>   				const char *fmt, ...);
>   
>   bool amdgpu_ras_is_rma(struct amdgpu_device *adev);
> +
> +void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
> +					  struct list_head *device_list);
> +void amdgpu_ras_post_reset(struct amdgpu_device *adev,
> +					  struct list_head *device_list);
>   #endif
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index adb01bdee003..afe8135b6258 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -624,3 +624,25 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
>   
>   	return ret;
>   }
> +
> +int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_ras_mgr_is_ready(adev)) {
> +		RAS_DEV_ERR(adev, "Invalid ras suspend!\n");
> +		return -EPERM;
> +	}
> +
> +	amdgpu_ras_process_pre_reset(adev);
> +	return 0;
> +}
> +
> +int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_ras_mgr_is_ready(adev)) {
> +		RAS_DEV_ERR(adev, "Invalid ras resume!\n");
> +		return -EPERM;
> +	}
> +
> +	amdgpu_ras_process_post_reset(adev);
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> index 42f190a8feb9..8fb7eb4b8f13 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> @@ -52,6 +52,9 @@ struct amdgpu_ras_mgr {
>   	struct ras_event_manager ras_event_mgr;
>   	uint64_t last_poison_consumption_seqno;
>   	bool ras_is_ready;
> +
> +	bool is_paused;
> +	struct completion ras_event_done;
>   };
>   
>   extern const struct amdgpu_ip_block_version ras_v1_0_ip_block;
> @@ -75,4 +78,6 @@ bool amdgpu_ras_mgr_is_rma(struct amdgpu_device *adev);
>   int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
>   		uint32_t cmd_id, void *input, uint32_t input_size,
>   		void *output, uint32_t out_size);
> +int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
> index 6727fc9a2b9b..5782c007de71 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu_ras_process.h"
>   
>   #define RAS_MGR_RETIRE_PAGE_INTERVAL  100
> +#define RAS_EVENT_PROCESS_TIMEOUT  1200
>   
>   static void ras_process_retire_page_dwork(struct work_struct *work)
>   {
> @@ -57,6 +58,9 @@ int amdgpu_ras_process_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
>   
> +	ras_mgr->is_paused = false;
> +	init_completion(&ras_mgr->ras_event_done);
> +
>   	INIT_DELAYED_WORK(&ras_mgr->retire_page_dwork, ras_process_retire_page_dwork);
>   
>   	return 0;
> @@ -66,6 +70,7 @@ int amdgpu_ras_process_fini(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
>   
> +	ras_mgr->is_paused = false;
>   	/* Save all cached bad pages to eeprom */
>   	flush_delayed_work(&ras_mgr->retire_page_dwork);
>   	cancel_delayed_work_sync(&ras_mgr->retire_page_dwork);
> @@ -124,3 +129,62 @@ int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *adev,
>   
>   	return ras_process_add_interrupt_req(ras_mgr->ras_core, &req, false);
>   }
> +
> +int amdgpu_ras_process_begin(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
> +
> +	if (ras_mgr->is_paused)
> +		return -EAGAIN;
> +
> +	reinit_completion(&ras_mgr->ras_event_done);
> +	return 0;
> +}
> +
> +int amdgpu_ras_process_end(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
> +
> +	complete(&ras_mgr->ras_event_done);
> +	return 0;
> +}
> +
> +int amdgpu_ras_process_pre_reset(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
> +	long rc;
> +
> +	if (!ras_mgr || !ras_mgr->ras_core)
> +		return -EINVAL;
> +
> +	if (!ras_mgr->ras_core->is_initialized)
> +		return -EPERM;
> +
> +	ras_mgr->is_paused = true;
> +
> +	/* Wait for RAS event processing to complete */
> +	rc = wait_for_completion_interruptible_timeout(&ras_mgr->ras_event_done,
> +			msecs_to_jiffies(RAS_EVENT_PROCESS_TIMEOUT));
> +	if (rc <= 0)
> +		RAS_DEV_WARN(adev, "Waiting for ras process to complete %s\n",
> +			 rc ? "interrupted" : "timeout");
> +
> +	flush_delayed_work(&ras_mgr->retire_page_dwork);
> +	return 0;
> +}
> +
> +int amdgpu_ras_process_post_reset(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
> +
> +	if (!ras_mgr || !ras_mgr->ras_core)
> +		return -EINVAL;
> +
> +	if (!ras_mgr->ras_core->is_initialized)
> +		return -EPERM;
> +
> +	ras_mgr->is_paused = false;
> +
> +	schedule_delayed_work(&ras_mgr->retire_page_dwork, 0);
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
> index b9502bd21beb..d55cdaeac441 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_process.h
> @@ -34,4 +34,8 @@ int amdgpu_ras_process_handle_unexpected_interrupt(struct amdgpu_device *adev,
>   		void *data);
>   int amdgpu_ras_process_handle_consumption_interrupt(struct amdgpu_device *adev,
>   		void *data);
> +int amdgpu_ras_process_begin(struct amdgpu_device *adev);
> +int amdgpu_ras_process_end(struct amdgpu_device *adev);
> +int amdgpu_ras_process_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_ras_process_post_reset(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> index f21cd55a25be..45ed8c3b5563 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> @@ -142,6 +142,12 @@ static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
>   	case RAS_EVENT_ID__RESET_GPU:
>   		ret = amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_t *)data);
>   		break;
> +	case RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN:
> +		ret = amdgpu_ras_process_begin(ras_core->dev);
> +		break;
> +	case RAS_EVENT_ID__RAS_EVENT_PROC_END:
> +		ret = amdgpu_ras_process_end(ras_core->dev);
> +		break;
>   	default:
>   		RAS_DEV_WARN(ras_core->dev, "Invalid ras notify event:%d\n", event_id);
>   		break;
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index fa224b36e3f2..3396b2e0949d 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -115,6 +115,8 @@ enum ras_notify_event {
>   	RAS_EVENT_ID__FATAL_ERROR_DETECTED,
>   	RAS_EVENT_ID__RESET_GPU,
>   	RAS_EVENT_ID__RESET_VF,
> +	RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN,
> +	RAS_EVENT_ID__RAS_EVENT_PROC_END,
>   };
>   
>   enum ras_gpu_status {
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
> index 02f0657f78a3..3267dcdb169c 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_process.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
> @@ -162,6 +162,11 @@ int ras_process_handle_ras_event(struct ras_core_context *ras_core)
>   	uint32_t umc_event_count;
>   	int ret;
>   
> +	ret = ras_core_event_notify(ras_core,
> +			RAS_EVENT_ID__RAS_EVENT_PROC_BEGIN, NULL);
> +	if (ret)
> +		return ret;
> +
>   	ras_aca_clear_fatal_flag(ras_core);
>   	ras_umc_log_pending_bad_bank(ras_core);
>   
> @@ -185,6 +190,8 @@ int ras_process_handle_ras_event(struct ras_core_context *ras_core)
>   		atomic_set(&ras_proc->umc_interrupt_count, 0);
>   	}
>   
> +	ras_core_event_notify(ras_core,
> +			RAS_EVENT_ID__RAS_EVENT_PROC_END, NULL);
>   	return ret;
>   }
>   

