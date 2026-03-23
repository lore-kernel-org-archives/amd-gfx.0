Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B81F483D7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7774910E0C3;
	Mon, 23 Mar 2026 19:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T3G+iHsV";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4274710E0C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdCgzFEQKl5oQO6/+Tk9mGAcUwn7Y2GqPeG9S52s1s/SPsBsf48OiX5Q+ZtMt0+17EOwOCsfOLKpTyGJ2YRW7Xi1+jyZKrQaD1kaxgcTUnMevu3HwBUF1tgodkXERUVPMXNvG43oN1OujVV2dHDrLjBt5OUzxI9vBSS6oZoycfBFBAZ6AQtz2KZn0hwFq/47voNwtpYR32GW0AEk/dhrLQqMUzM2LQJEJSNUEILMsgTUZNtKU1Uwso9d0vo73+aycpWGYkcMPotjH4pKV8YfMFs06O5Qs7k7+4+/1Ma1t5mB9cbF3LSIYol9w8w12tKSFnkXaFReW1Pv29jrpBY2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5KMPMgywuIiCIu+1SrpybjACC24AskJ1ydGV7iS7YA=;
 b=WJoyWpvD/5jXn5K8uiVkGy3Px44HhxXct0MyhYCxNAYC1/boNPt+WXQNscahBKqm70u/4ZsWOo+2eu6oCMGK2bINTOmz3fhCl731yVB/94U4RE1qOoXZ8pgsah/xGUGv1gFKZe1qOQMY7iu3x0hTT41kcEAN2T9Vqyb3d314l4TaeLQfe/2GIsT3BQ5H0GxM5wHwZUoNY/c+mRb6AV0uWVfzVdvWPm5xsJ90xB+XU0c/FtoXPGtPn3kfiWq4IVAqYq94cBo6vyi6gcAh3C2J0jBxPcdQE3M5Yh51MgLc59Qn0A6BS+uAAVMvyUCbQFzDLk1Nhmp38n0kSII7QdZ0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5KMPMgywuIiCIu+1SrpybjACC24AskJ1ydGV7iS7YA=;
 b=T3G+iHsVk0s4EoVF+iH06A/nBYVOHAi1i8A2Az4S2w+Gdsi0de2+jDOJzuhYNFoaEbqPl0Gr8zsN7Oxp+7yrzb/rexwLgm9NpMuqF2xiNkQerj8MO4/A3+i7zy7R8a41JLyX7pXdkQEzYekn6IUdX9ujIYFSGwHKdkt0K7OFZ40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 19:48:32 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 19:48:31 +0000
Message-ID: <fa229131-d8d4-48fe-9772-fc5fbb04c815@amd.com>
Date: Mon, 23 Mar 2026 15:48:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Enable SDMA queue reset on gfx v12.1
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Michael.Chen@amd.com, Shaoyun.Liu@amd.com
References: <20260323184457.1244422-1-Amber.Lin@amd.com>
 <20260323184457.1244422-3-Amber.Lin@amd.com>
 <CADnq5_M-ik5E1pRsbi6B-J-J-eqExrFJZw=XjMHx00M-5uWkgg@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_M-ik5E1pRsbi6B-J-J-eqExrFJZw=XjMHx00M-5uWkgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::23) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd849a0-4d61-40c4-cf17-08de89152982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: JJA6mCczYh1Xm3GYzNc6MlKYbpL9TFH7yUvg7CIpkFTt0eib4SSR1HG6sHcSXzNo0l8r6/cZaKn4COMwUh6IDhkp1FdlGzL9RYeSC1LTwF0IZABL3a415erkJ+3aVA1+sQTeQpPuPvBBWkTwmxQuT7wFyO7MTmAh6lQo+L604wDhKt3WrWwmfio1XYss07bB+EpkA9XDpfFJPr1tqLlttPLDHAF4I+5MSNLmKv8gx8TVLfXZwXQj9wikAV76fPILKBwCU2tF2Ctg7KAZmLKEjI37i136q2BFY0txbfOZI9czzupjYkrJR0kxSTxPTH4TPbMStjb2F5C1Q1ACEWo5BfqAIp1S0kd9gdNa+XGt8NV9fX+8bWsKEpl5a5UszPRzGCrMR+/YnJQxMiJPEA7RUIzFra537v1NFTXPbFy0XUqRuawf4WBZFUjBrUsg9vOYVSDsEWMErEfIdC/WyzZBk0Ra33fVGcA5vHuK6r4rw2YvruxrpDPfUVfkm+00a4VuS4jM6r/M5AUBdxZvk0vV2OELUzICSR36RWmjJE6Iy1HBctXy3ZXt3xOITbw3DZTYacWHVcwEnG++5JO7yzaSrFeYXKI75c1Gfp4NWXy92isKXKEQujhlNugx8lqxxIzyUproMZ6NPV+WhEZgQWvuIVhZtl2rzfi/YN7cfeLJRM+3nFFuj1lVvfi+1WyoswZYvezrjbTC0fZrJGQY2ALGeFbE9b1hYfljW9lkt/qwRUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmt3bU9BY1BmY3dXSjR2WGoxUGRrZ2NpNmQycGJQaERPRGFYdGU2eHdaR2VI?=
 =?utf-8?B?ZUlVWC9Ea05IOGhEYzFMSTIxeitBRmpwQTl0WjRKdTB1amROekdXZ21veW80?=
 =?utf-8?B?eFY3U1ZpZ3RmVlk3LzhLK0ZKVStwQnlTWFBjbUd5NCszUTVzTzBZMWlzQnpv?=
 =?utf-8?B?SVU2WklicG14cXVHWVJuT2pQc1pKc1JuTUljRzNEeGMrcUdYallGQVptejdj?=
 =?utf-8?B?RFlROGRVUys0VnlvcCs3TWowbmQzLzNIQ0gzUVg5K3Y1RUNzSkZpeHRYSTNs?=
 =?utf-8?B?MVE5TjNaZy8vQ1A5WVRyTjlrWHlkcG9IRlc0NFlWcEpXK2pzdkw3MzFzVjNk?=
 =?utf-8?B?cDdhZUZXMTdEVnpjckhIZkljZXRMc0o0RXQvMFpCR2J3bmpYdVF6WVJTbitk?=
 =?utf-8?B?czJCc0VvMVAxdlNyM0RnUzdHeVUxQlh0dmhnRG0zcFpHYmVIUlFOd0x2WFFz?=
 =?utf-8?B?d3BRTHJGcEZmSjM3YXBEVWlRUVVPbitOUHl0ODd5SE51S2V3bjh4Q2VYbVFw?=
 =?utf-8?B?akRzOXFSbVMveG5XVmFyQWQyNXc4Sm1SK21DWElJQVdMY3VvYjRySTkzbU9w?=
 =?utf-8?B?UDV3YU9jdGQ0ckY0elN0RGpZdGdacHJ4T3ZXdXgrcXJXcmhKNlVxekcyUyt6?=
 =?utf-8?B?RmRQK2ZMSUo3Q1Y4Y0tPYTJyYW1xWnQyS1NjSzFNaE4vWHpzTnNwSVV4R0JK?=
 =?utf-8?B?ZHYzY1FnY0FpaGVwY1Q2Unljb0o2eDgxekYyM1VZY0hwWEdZT1hSL0lWV3dl?=
 =?utf-8?B?SGFKVzFrSnFUYiswQ2FKN2JnWlZiU0ppdVJZYkhiM1ZuWEZmZm05dnlJUzlZ?=
 =?utf-8?B?c3RWY2xKL1VjWHpGR1RrZ3pteXoycnVTSCt5OWpnZWVkNVNmVGQ1dUNxcnMz?=
 =?utf-8?B?dmRuMDYrckZQRHNWMkRBN1dSV20zVGNKY3pKaVdWbFpSQ05wVDQ5UDNZMlNn?=
 =?utf-8?B?Sk5sQ2prQWgweVZVT2RURFJRTExiTFRNOWF6SXI2NGdsbU9XbG9KU0h4ZnFt?=
 =?utf-8?B?Z0NxdDBmODliT0pjNWJsOHo2aHJjZ0dxeSttMWJucUdEeENOVi9mcjBkemh0?=
 =?utf-8?B?Tld6VSsyYVJQS3NyUWoxZTF1UEVlVUtoTE9zdWNGTktValo1Z09kTTYwc2Vl?=
 =?utf-8?B?N2ZPUENKSTgyTEhmL3ZJSUpUSW0rZlREUitOdzFVbE8xNkxVa25YSDJxY0Fh?=
 =?utf-8?B?VWg5MFBkRk8yOG1qcnZaZnpSemlrdlBWZlpaaEFqQ3lRN3VBZ2ZiZDZucGVG?=
 =?utf-8?B?NnJCOUlhbmszd0RxOHBCcjVYenpkaElYVkd5YjNCRE9mYkFqK1k0V3lISFRs?=
 =?utf-8?B?NTNKaWFFTWY5OFprbGJ5c2lTN3U3TFZFaGlQMVFobFZkdkdGdlpPSXVUS1po?=
 =?utf-8?B?aEhzZS94b0xhMmZ6dUptV1A5cm55a0wwZXUyNFNFSXRRTTJsNGVvdk9SeXV2?=
 =?utf-8?B?TTBHdk1ieXBKM3NGSURoUGlEcGZRZHFwNmxyaWJhY20xQ0xCWDVSeVlrZTA5?=
 =?utf-8?B?dkYycjFpS0VwVTB6emtLOTV1RzhGOW1LZ1RnN21BSzFYYzFTRHI5VWlER3hZ?=
 =?utf-8?B?Y09HRWJBbFlTRlJSaHR0OEJ1MWl1bll3TFFhK3BNZkNhcEI0UzdOWC8xQ2N1?=
 =?utf-8?B?aDlncGgrbXRCUDJUVkp2U1VvVE5XY09keEtHbzhZdWorMEdwbFJ0QSt3aDQ3?=
 =?utf-8?B?SStvSjhVY0NDb0g3c3lZR1ZQWjgrUVVqUEhKVFdjY29xdDZlNjYzVXR0dlFm?=
 =?utf-8?B?VmgvQjR0a0Q5TFBibmZnWjlUYlBFM0FjODZTRkt1UTlGaG9yT0k0UTFwcnZX?=
 =?utf-8?B?SU1uZUVscDNaU1F4UUVkdjM2K3ZkQ2Fxcm1vKzc4azBzWXlMYXRGcXdlSFY5?=
 =?utf-8?B?bE16b2h5RG4zRzdvZlNQZW4wbUlNYzJQbHhrbzhpdEJHUkVZdGJvTFM5ekk1?=
 =?utf-8?B?KzlkeEFCb3cyRmNyME94RkdPajRXaEVDdGR3NEJVS2lEeEhHZFdpWXdzUHo4?=
 =?utf-8?B?aUVRdnBLWDY0R1k3TmlEVnlyODVlVU0xS1pjNHltR0xlNTFNR0MvNnkwOEkw?=
 =?utf-8?B?dTcrMHhxNS9qUStYallYQll3YktVQzQ5Z0xtb0RMWXY1V0UxOWdOajV4MC80?=
 =?utf-8?B?MFN6bklPV2lYL2s3cWJ3RndDTk1VUVI2K05XaUcyL3N5YWZyTHE0U0liTEZL?=
 =?utf-8?B?cUFkMkFkM0R5T2pKUmIrTFFvMzJyZzJ0MVB2bW1rMFdOVkFudnNqUlMyT3lt?=
 =?utf-8?B?U3p2cXp0YytUYkVaM2laTmNoQjRoNHZrVGxjeEhYQUVPQVJVZ3ZxcEk4bVpB?=
 =?utf-8?Q?mqHOrLj9Hg09l/HMd4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd849a0-4d61-40c4-cf17-08de89152982
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 19:48:31.8326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oce/vlqvqqNE1zZWOTx8Ee1pGPMGN+9qCHmudktdORJhnwHQoy2GU7SwPxzGZCy0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
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


On 3/23/26 15:25, Alex Deucher wrote:
> On Mon, Mar 23, 2026 at 3:04 PM Amber Lin <Amber.Lin@amd.com> wrote:
>> After suspend/resume sdma_gang is supported on MES 12.1, SDMA queue reset
>> is supported too.
>>
>> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 4c52819aef9e..42d52c1f5109 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -514,7 +514,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>>                          dev->node_props.capability |=
>>                                          HSA_CAP_AQL_QUEUE_DOUBLE_MAP;
>>
>> -               if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0) &&
>> +               if ((KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0) ||
>> +                       KFD_GC_VERSION(dev->gpu) == IP_VERSION(12, 1, 0)) &&
> I thought this already worked on other MES-enabled chips.
>
> Alex
My understanding is user mode compute(and sdma) queue/pipe reset only 
works on gfx 9 HWS. gfx 12.1 is the first MES-enabled chip on user mode 
compute side while they are already supported on gfx or kernel mode 
compute side. My next task is to extend this support to gfx 12 and other 
existing MES chips.
>
>>                          (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
>>                                  dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
>>
>> --
>> 2.43.0
>>

