Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8901BD3C907
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 14:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1064A10E72D;
	Wed, 10 Dec 2025 14:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rthdGw1p";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013071.outbound.protection.outlook.com
 [40.107.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9092B10E735
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 14:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/eLBI1Oc6Nb1LLndeCQuQ/1XK8UxQmrAV9FEBhhPMA9CBymScgVq6oOL79pAbMQdbM4+hErv5yL1YoLxq1BQvVoOod/AST3a5/Q9EH4n3jLSRkufwpQQ4eHF3rD6FrksexMoX8dJ/NAqphRxjos1At0EBKFhjKzNEGAQIxApsEZAtvbeaMIw5GR3Vgsa7QLB4Uj3n+8s3z4RW3gLhXUOWH1CdaRV45QNM/nnnV7LypRKctDJd3MYsOz1uKt6G7Xwpiq2pekFDoo4g9rmsmM3uwljKPFVidRDPG47QfROolhKxSTw3k1qohha0X3LtvsXZzDm9j9fB9ldXjwT0QRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iAEOYEhhVtUAbbnCfYUhjXmSAk3PhGmZ4aLBV2dV+o=;
 b=FKiwB7OrqcJfpuAWTiNUPliVkLY53ybuVF3CEfVZRZR/eXaX+vz9idDUjXgsMPfSDd3mGkgEYGE1lJpvc4WSzegtX/ATlo8LFGnZ5kU3i0JijpgmXpSWRUaw6ys0MafnET4ZH4l9ztKycQ0pGY3WnQ0ca8AT0nOef367TpnykYFJ+m5Z6U0ldnroylEyUXHgmDcvWq4A+uAmbjr/WPluQsFRDnDe52I/az9gwFPe/yr12TuVgZghKihRGB5lei1WOR/fuO1+40F7HBp+EI6ibJUsOXe7PqbFQE3lYNm4Hy8C5oFGFccMgp1ETgFHz7SlT71BRwLBHoLhFAMrk+PREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iAEOYEhhVtUAbbnCfYUhjXmSAk3PhGmZ4aLBV2dV+o=;
 b=rthdGw1pB8R5ccgd+lh/qi8L2Lb96Pln2fL1HVITnEnT1CYXb1EocTPuuUF+lNNmMq8n+19xWx+iPk9RowrdniVG8cPfHdLINNCif6+UmKNBsvg75wqsZHH0cDh8u2gsOyv98vr7RFEhZCXA5hHaZoCjrDMDFjDEykKd2y85lW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 14:05:32 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 14:05:32 +0000
Message-ID: <20ae4aa3-0f72-439b-a7c3-99b3330066e7@amd.com>
Date: Wed, 10 Dec 2025 09:05:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/amdgpu: Add helper to alloc GART entries
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251209234328.625670-1-Philip.Yang@amd.com>
 <20251209234328.625670-6-Philip.Yang@amd.com>
 <f64a5319-35e1-49dc-8cf1-5f609eea42b0@damsy.net>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <f64a5319-35e1-49dc-8cf1-5f609eea42b0@damsy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0176.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::25) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cfabdc-f7a9-4c6f-61ce-08de37f52ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXI2WGxHc1pEdU5pcmpmamd5ZmtPUTl3R1JBN2J3Yit6SW5NOUFjc0pTeFdD?=
 =?utf-8?B?V2l4SHlOTGl2OWYyMklmdHJtYTZRUk1WbzdralBpM3BZUzZsRldTbk9GeGts?=
 =?utf-8?B?bU8xTG05R3p3N3BQQjdzbVJGVTBlWjYveC9RNjVjUG82cC90YVZMaGd4dVBK?=
 =?utf-8?B?SEh4WFFnU2dpSzBTems5R0tXRVhpNnd4TE5TbDF1ai9RY2EyVE1tbjdhNVZv?=
 =?utf-8?B?Y0lGbGFmVjJuVllpcyt3NHhKSDZGUER6bnA0TmI1QkhRQTJVRzJqUGpzQTdl?=
 =?utf-8?B?M1k4NkMrNndJOWc1d3FXcmlsaTNISWdxWlVUU3RLb0lyc2UzM0ZjWnFHZkpC?=
 =?utf-8?B?S3lRVnloeThPMURtNUFSY0xhbnllMzVlYkpEU2xTazBKbkVWekxYSjErOVdE?=
 =?utf-8?B?MDF1NWRXU0MzZGJEWlU0eURqOUdlWUpOMDRUVm8rVHlLQlVrUFZEZFEwdmhu?=
 =?utf-8?B?U2V5cVZXQkRpRzdCVmYwcWx2TGdYUDlwaE14NjhNSU5YNndZVFRuUm9ud0kx?=
 =?utf-8?B?SytjenAvU3htcFZONGg0MUtTU1FxWmprcE5IU0ZBWUhCUm4yazRhVElYQURr?=
 =?utf-8?B?T09wQXo5UUY0UTgvTUJoZzlrcnVVK3EySGlYVTdPTmJXWXZCWFVDMmh3Q01k?=
 =?utf-8?B?eCtlU1gyZEN6MVlEY01Ebkp6UWhYa2ZoaWJBK1VqUDZMbEZIN2U4L2l3b0pB?=
 =?utf-8?B?SjJWRC9POUZXSldLcmVEdExaUlJpSXJqSi84a295dXMrajRCdmpxWDd0WkJx?=
 =?utf-8?B?dHY5NXhoZkhRR3ZpVElydzd6Z00ra1J0M0dyTVFiQ04vaHMvbTRnWEF1R3No?=
 =?utf-8?B?cVlSUkNveVJGcnFKZWtlT2dhN2NKZllMeEdNMWVNbVByOWdnbjluRkdBdTVC?=
 =?utf-8?B?elZld1pjVjNoNlI0Qy9PVkFxOWwyQWZjTDV5TEtQWFVwRTFvTHVOV3RoeUNL?=
 =?utf-8?B?N0lyOXlpYWxwMm9lbFQvSkZldmVxTUEzdDhySTFrSkpzelhmUDlQTEdUVXR1?=
 =?utf-8?B?ai9mUnF1TE5LV0syY2tkSmtseElMSkVlRUk3dzQ4aEtPS0pFVG5TRWFGaHky?=
 =?utf-8?B?VS9qR0pYcVRJZFozanFzZlBVNEpGaDdYcTJmMU9tby8rZVZQT3hCaFlTSzZq?=
 =?utf-8?B?MU5pejRVQmtYT055RkdLMDhsNC9IQTVqZ0UwTjRRSGs0UWF2U0puaE0yQURO?=
 =?utf-8?B?QXpDU2haYkRhV3I1RWV4YnQyZms1SVVmRWUrelEzUEliTHhvbytaSDZhdCtQ?=
 =?utf-8?B?aFdpS09PMmR1N25JUXRyMmIyWUpsQ3dwTWMxWnp4clkvNXhZUElVKzYrU3JS?=
 =?utf-8?B?UkZuWjBHT3pxTXV4RXo0dmhmeW5PcjNwczRXK040MHk2MlF6bEFUSWF1Vnho?=
 =?utf-8?B?RUdzbWcwVEtRSjgxNEpvTk4xZUpVeG53VjRzcEZGeXloa1NlZ2ticHJFZ3hS?=
 =?utf-8?B?VFlhOFJ6Y0d5akJsTTRyaVMrTm0yRnV2QTVwRTEvQTlxUnk4SHNlNzZFbTFZ?=
 =?utf-8?B?TDhpRmZ4b0xiMk5SN0pCa1hrVnF1UTlSSm9QY0Zucmo2WkpLVTI3aUVNajBk?=
 =?utf-8?B?RldyWXd6VkxmcUlobXFzVHo5Rm1kdVBrUHVjM1U0THlSWGdydS9XR1NhblNE?=
 =?utf-8?B?VHZBYjBOQ3BFNUM5Um43RkdaMVBVa1ZQSnMrTDl6TUJXbTBhMk1KcEJiSC9s?=
 =?utf-8?B?VWdNWS9NQkhSMUpkcGlISDVocGc5ZnRiMmhCdnU0UWphWVhianNmNzZiWERM?=
 =?utf-8?B?Z0NlRDlERzUyeXNGMDR4b21peHhrQmdqWWhvZnBzZ0w5dmlrWDYyTHZ3K1Zj?=
 =?utf-8?B?V2tpVkREYXhQRjdIaHJOalRwYS9Nd1Mva3V4Mjh4cFBYd1hGZ3hxbnB0bHpI?=
 =?utf-8?B?WDcvQzV5dzg0ZllGZHlNZFI4QzAwR25UWDZ2NlZHdHlBZ0huOHUvRlFiL1dh?=
 =?utf-8?Q?4sKvD8H1CPUR617AW3wHoh5e1lQVdcua?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEsxd0J6TUtacGJ4QWw0UE91M3JVUm5sVGg4c3NXZkJ2UStXd3RLbmhYTE94?=
 =?utf-8?B?TFJ4TnZDK1BkTDBTV2ZUalI4ZVo1NStpQ0dyS3VOTkx5YTZtZzhxMzZaSzVt?=
 =?utf-8?B?K1NmaTZoeXg5cHBUSTkwdHlKS0IxdXJtaXk0OEdWOWV2YWRxSFVvT1dzZkg0?=
 =?utf-8?B?cHB5eTdwdTM1TVdRQ0t2WFhzTGxGZHZQQXVMMEplSXdhdEJ1OVJtemYxY1lo?=
 =?utf-8?B?MVhSU3MxZTZ5S0tML3dCeUVqdkRJbmNKaTRYK1dkZ210S0ZlSzA3NkplNlVB?=
 =?utf-8?B?cG93LzFkUUhscTZiNGJCVGx1Qmx4WmxwSVQ4ODRGQTZ5WnNuNW5JUzloSDNx?=
 =?utf-8?B?UHhpNzd4TVhKa2RYZm9zVjhqUTBkd2oxdHFIZlFoczlXTmdCNGlnNkU2SGRG?=
 =?utf-8?B?U0FvdmtneTF0SkFKYVlZZk5wRi9HSlBmUDU2Y0xxaCtwWEhxZVdBcmFzc1Na?=
 =?utf-8?B?R09RaGZkTTdXZFVnVlZ2QkdsL2U4RDFWVUZXU0Iyb1M0cVpCa2pCUzhPM0Y3?=
 =?utf-8?B?VGRhUXBpY3lmd0xwc002TnJkRXpab21UeUJKOHdPdUpJenRlbWxJR1BBZTQr?=
 =?utf-8?B?NmpnYW4yMEZaNUFoa0UvWmJMR2pXZmNITndlQnF3UHlLRzQ3ZkRVTG4rWHpG?=
 =?utf-8?B?ZzRnb0ZoWTA4T1JLNk9qMUt6aGllN1dIcUwrWUVoUk9tREw4UUtIRmhnT1NK?=
 =?utf-8?B?c1BueC9WakIxWVMxTFpqYTVIMFJ1dmdobEpYbWpRamEzZTMzOUZaRWE2RmVz?=
 =?utf-8?B?OXVZRGhHZi9yTGVWeHRKdkwzOG1GYUJ3dlRZR3V4WVA5LzlURXQ0YTNSbUhV?=
 =?utf-8?B?cXFpZ2xGU3BHT2c0RVhqM1RDVTFmeHJEenRIcC9GTEhkYmFyYkNtU2dwL016?=
 =?utf-8?B?QmwyL1hZcW8ycXgySFZCNk9PTGNyYVRmb2doWU0rSGZPTmtYSk1ya2s1U3Ez?=
 =?utf-8?B?bmFuVVowZW9CMUxkMy91c1MvK3d1b2FXWFRrcXlVWi9HUjEwdjVtWFpiSFEx?=
 =?utf-8?B?SmpoOGtxTTVacHZhbkF6aTQ0TTRUYnZjdFA5eFdlTE9Na2F5REZUVXVUN3U5?=
 =?utf-8?B?RlZUTG1hRkVsMVhQL1JwNDBzaHY4WnhUVUs0d2c4SVI5bFh6WVE1UURoejBZ?=
 =?utf-8?B?VzRzZTZTZGVUeFY5OHlQbFdxc2I0NklKcXNsV2t3VGZGdEtXUGdoRUFjMFhE?=
 =?utf-8?B?N1B4dXc3cGNXVWR1allBV0pqQXN6M2tEaVpoZUZWdzE4cFRzUUprWjgwUjdO?=
 =?utf-8?B?ak1FNXdKVThvYUd5aVhlU1NhdW5iNW4zZzdhVGdkdk9OWGVMcHpGQUdmS2lj?=
 =?utf-8?B?cGxWY0FBeGQxZzh1clN2cXhDbGZjRkZjVDROQytSaTFLL2I0Ukp3a2xITEhO?=
 =?utf-8?B?ZGR3TUtUUUprRlZxOTB1WFhTQXJFZnZFalV3VXNWbTM0WXIyS1k2eFN5ekpR?=
 =?utf-8?B?MUN6TGJ0NFhKQkdqK1lUcjJqaU8wbnhlVW1NLzZ2NW5Ra1VSSG9SSnFqK29k?=
 =?utf-8?B?V1NmeDlOTmd0eUxucjRVdkQyRTFaOXhjUmRTU0tuZUlyVU82Vkl0elV6MGdL?=
 =?utf-8?B?cU95b1JMZGpuMVFoVkR0cVN3T1ZVcnJpaUJXeEY1cDhxMWhBbG9YVHBjVlRt?=
 =?utf-8?B?ZCs4elZxcjZGaERkQW1VZ2xiVU1aenQ2eXd1SGJ6L0RHRTUxZEo4dGRwOStD?=
 =?utf-8?B?dXVkSm5XWTNBejZSRWR3anhMcVI3MVZQaUF0eWxhNHVJK3FvcjkybytmbDI4?=
 =?utf-8?B?b3I1Um9UeExEZFczVlRCTEkyczZHbGxMWnZCT0I4L0N1MWZjaCs2c3VuZUhz?=
 =?utf-8?B?MzlwbksxT0FpVW1Pak9MRUEzc2QzMk5mUmJpVnN6YlI4VytkWUV3Sy8yWllX?=
 =?utf-8?B?WTN2OXZqUjlQY3ZXTnY1RVJ0ODJKT3hyc1ZQSXd4TDFaSEt6bzRmWjRsakJr?=
 =?utf-8?B?MEdVYXgyendPSmdXVEkzeE1ReTNYVzg0eWs4OGZFZXZZYW8zTGpOaTFSL3Zj?=
 =?utf-8?B?ZnNHMDNLdFZlZ3labWcvZ1pNUXJMd1Mwc2MzR3lDbVZRRUhMT1RTVE1qQy8r?=
 =?utf-8?B?SjRyL21iTzRQMlNBdklzOUdnUDE3UHhFcmNGUTRHeVQyVjRuMkR2SmFRMmlV?=
 =?utf-8?Q?0fNA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cfabdc-f7a9-4c6f-61ce-08de37f52ec1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 14:05:32.6295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGeehOMHB54eYkWus8MfHghW0QxNfkAY5L2D98AoPyq7CRdFA17AFbmxkQEHdxnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
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



On 2025-12-10 07:57, Pierre-Eric Pelloux-Prayer wrote:
> Hi,
>
> Le 10/12/2025 à 00:43, Philip Yang a écrit :
>> Add helper amdgpu_gtt_mgr_alloc/free_entries, export the configurable 
>> drm_mm
>> allocator parameters to caller.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 27 +++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  7 ++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> index 895c1e4c6747..d21c7187e4aa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> @@ -321,3 +321,30 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device 
>> *adev)
>>       ttm_resource_manager_cleanup(man);
>>       ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, NULL);
>>   }
>> +
>> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>> +                 struct drm_mm_node *node,
>> +                 u64 num_pages, u64 alignment,
>
> I would drop the alignment argument since all users are going to pass 
> 0 for now.
ok, we only need page align for GART address
>
>> +                 unsigned long color,
>
> As discussed offline, my version of these helpers also exposed the 
> color arg to be able to distinguish between node's with a BO (color = 
> 0) and the ones without a BO (color = 1). This is useful in 
> amdgpu_gtt_mgr_recover() because for the latter we can't do:
>
>    struct drm_range_mgr_node *node = container_of(mm_node, ...);
>
> To avoid modifying again the same code, I'd suggest to:
> 1) add a define ("#define GART_ENTRY_WITOUT_BO_COLOR 1" ?) and use it 
> as the color inside your helper
> 2) remove the color argument
> 3) update amdgpu_gtt_mgr_recover() to skip nodes with this color
I will make the changes in next version.

Thanks,
Philip
>
> Thanks,
> Pierre-Eric
>
>> +                 enum drm_mm_insert_mode mode)
>> +{
>> +    struct amdgpu_device *adev = container_of(mgr, typeof(*adev), 
>> mman.gtt_mgr);
>> +    int r;
>> +
>> +    spin_lock(&mgr->lock);
>> +    r = drm_mm_insert_node_in_range(&mgr->mm, node, num_pages,
>> +                    alignment, color, 0,
>> +                    adev->gmc.gart_size >> PAGE_SHIFT,
>> +                    mode);
>> +    spin_unlock(&mgr->lock);
>> +    return r;
>> +}
>> +
>> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
>> +                 struct drm_mm_node *mm_node)
>> +{
>> +    spin_lock(&mgr->lock);
>> +    if (drm_mm_node_allocated(mm_node))
>> +        drm_mm_remove_node(mm_node);
>> +    spin_unlock(&mgr->lock);
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 72488124aa59..28511e66d364 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -141,6 +141,13 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device 
>> *adev);
>>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>   +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>> +                 struct drm_mm_node *node,
>> +                 u64 num_pages, u64 alignment,
>> +                 unsigned long color,
>> +                 enum drm_mm_insert_mode mode);
>> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
>> +                 struct drm_mm_node *mm_node);
>>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>>     u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);

