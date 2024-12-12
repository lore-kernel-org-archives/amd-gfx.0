Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DE5E77180
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 16:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9933C10E0F7;
	Thu, 12 Dec 2024 16:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HWLjRdYp";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73BFF10E0F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 16:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL2PSII+hA462gcOmMgUExNl53BsyEr9YWaVxpR8TgAf3G1z8Cje+k67PD7yZGEEhxtCe6xTbWb+1f9YlqFHnXdbp4cQpXXSV34SI5FYjWqG4irVriA70IKl3JQumY+hMO0kFzn3AceP/HTT9gDcAdXQ1EhQVcUbcLopX2ogRQDwtNxg2NoWFTVtkS9W/HKsrjsoY9zJhO6JX7Lc85lMc4mlvaO7AodH16vUsVwf7LDNozwlkozMxhtii4DGKBR4sWZOOwWs9lAQmzKy43+YUap4p4viTf15Ft2tjE+PCqwC+KDf2TQJI69hor+DAd4Yb6jZNBZ3pfQVhHvg8G6OPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mF8cqpLMX0SxaVfDjgOiPNId2kgZfwOSGlWJH2+JRE=;
 b=VE1ehGqHJMoMEQiz7MNGzffZBCbDxXwrk4xFwoTOHwkidBNdk1w1kddIIt255EocTcW+ctCngXSW+jdiJlqpBiGrVyL8o0hJsOsMI+623REqi21dXlWGUeQeK2i9fpLd7k6SvSjKo1fcDI2XPG3u0pepf4TKXhZhVugm4LmTALVQYFRJGffYvKiCuBBcl44MfMgQZ+qF7nLPlU/YovCjg5CAv4T3lq3MoRcmq62eOKHCBX45LSzPn6r6YSyTX6YgFTiErvt+aSZGevKWWMIOHV/eyRT+v2eW+gggm0YTo1R7WYcIJA1gqtwDhaxsJChzpeejf6NE+o1jFONFhkMZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mF8cqpLMX0SxaVfDjgOiPNId2kgZfwOSGlWJH2+JRE=;
 b=HWLjRdYpbKX9PWmDKgKXcSlCKPIOu+SsrM9fC6OgnnEZ8cG/2rKLwhaY3U73bG3kalZxl0tusdHceXPPoUPVHAf81Vu3UoLOHo/ZxSds551VD+cqLv9r9STOyL2xTOuLYGjmR2IPcp/AfRIlriu7DUt6WMsT+I8o7rQrGRrT+xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 16:56:18 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 16:56:18 +0000
Message-ID: <cfda030a-51e0-4cf0-b668-61d8fad60163@amd.com>
Date: Thu, 12 Dec 2024 11:56:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: wq_release signals dma_fence only when available
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241212030611.8513-1-lingshan.zhu@amd.com>
 <0a02fdfd-7771-4a8d-be15-1e8eaa6d631a@amd.com>
 <40a93b94-dbb4-4d30-9ba8-0b0185e1fc1b@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <40a93b94-dbb4-4d30-9ba8-0b0185e1fc1b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::45) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 7350e6f7-af93-44ef-1f7e-08dd1acde5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzYzOTFmS0MreFJCbXRwdGo2UWQ0b1NXTDdPRHR5SlpjMStKZVhMcW1XT2E3?=
 =?utf-8?B?anhqSzFjZEpLdTcwMmltMHdLRUJSWWI4WGx3L3BTSk9FOWszMXExcmZaQ0Ri?=
 =?utf-8?B?TUMvb0N1bFBFYzdjaXFML3hpV1hiWjR0TUsxWlpiMmZVb1R1ek1wT1BhbjQy?=
 =?utf-8?B?cEE1d2dpWWNteTB6eFNTUmJHYWZ5R0p2bUxsMW82RkJmNHJvUFpXai94SDU2?=
 =?utf-8?B?NGhyVXAxcksvZVoyWkpYZFlhSkZJclI1R2pEVGVDa3RUYmtEa1EzanV5ZDkz?=
 =?utf-8?B?NkpySUZnWWlTZE40WE5mYkVGZWlnTy9ycTZTSUtXKy9acTRPUitBOE5sNkNr?=
 =?utf-8?B?dHpXRUMrOVV1Z21YSGZEektFRGJHRXAzbCtUdk5oaWFhL3J4c1VXUFJ1MlJw?=
 =?utf-8?B?cGgwWmdMeVlncG1FL1RpQ0hkcEh1OEo5MkNlWnk5VUY1ZitjazdnR096QUtv?=
 =?utf-8?B?UDF4TVJFRkpjUWkyNmQwbEN6OFdQZFBKRnZxTmlwN0lrcThlTDFOaHh3WDN1?=
 =?utf-8?B?eE9tS0dlMU5qWUtTL2xkYU9wZHZ5ZTZNVFkxYzhVWVVCV1lWOXdLdjZiM3J3?=
 =?utf-8?B?THdsR0JjbUFBTHk3SkdhRzZyY0p1L3ZpcjFRdHMxQzNobmsyTCtEWUhYUDhj?=
 =?utf-8?B?UnRRNWdta0dPS2Nlam16NldyZzgvTFhDcHVzZDZXd25JNEEwZlB5UUNjVE5K?=
 =?utf-8?B?UitFWHYrV3AveDhlUS9RejFYazhGOFozQ2RJdkFPV0RpU05NS3JUT1RQOXhN?=
 =?utf-8?B?ZFZqd2ZvdW1keHFsRXhrQThtc2J0LzQ2VHArWXNTMmFrbktTUzYwMFZRL1Vk?=
 =?utf-8?B?L0RldXZxRXRmbCtOU0Y4b29Mam1jNGxxUEpFcDE4QzVLTUJzZTZpMGg4eXc3?=
 =?utf-8?B?WjFVRk1JbG01U3lVeVk0Z3FsaHVLa1Fmc0dGUzhMWXkvK0lJdGlXYlZZUlpV?=
 =?utf-8?B?Z2E0R1hqczBmU1dnRHZiUHo3cUxOQTJkYVBxaHRQMUFKQUd0MW5MQm5VNU9U?=
 =?utf-8?B?YS9TRjFRMVl4bHNObDBzMHI3clI4c0syNUJuMzNvWE0yZmZZcXdhamNnUnkv?=
 =?utf-8?B?elRDRFdoenZucXBtdkRkWVVFSFB3dFRQS2U3Q21pbndYVktkMVFLQ3lNa0F3?=
 =?utf-8?B?SXdkd3BxSWxUd2VISWJUdlNoaEprbm81aWZWbGZEY2NvK3ZRUnNHcnJrYXBN?=
 =?utf-8?B?VGtJdnk0alFJaCtpdFRSdGhuSlAvd09Lb3lhTEthUHd2ekhtdVoyWEU1VFkx?=
 =?utf-8?B?KzdsVktKZ0gxY2htMXJNNXpnbnMyNWlmbWxNSHJXbFF6UGxaRlRmMVhPRnZK?=
 =?utf-8?B?UGVIdmtCSFA2QXlpbnVNdHhmSG9SQ0dXQ0RWMlUrQ0Zkc01PdHg1eFl6RjBx?=
 =?utf-8?B?YUU0MlFqL2JsQmlJNFUwdTdCa25MZ01qSjZiS3VFL3FvL1g4ZmI5M0hqRGlJ?=
 =?utf-8?B?VDZpbDJRWktzWGxtU2RtWnpHeGRKSElKVzQwN2ZISkxTWlQ4Q3RVYk4xK293?=
 =?utf-8?B?Z1AxVXk0UE5JclZJcXFoTVBWZ3NRbldKVnNTSTQzdmJieTU2T2UveklZT2VH?=
 =?utf-8?B?eW5xSDFuWHp4SWx2WEdiN01uMUdTNkxNelJGa3I1cER1akk3SmxiNEk0TlRU?=
 =?utf-8?B?TlhXWHVXaXZ0UXF0Y0F1RU1kMGxGWHo4QVV1Wm1hOXovdkk4K2dSMWRmY1VV?=
 =?utf-8?B?SmlFcWRjSEM3SU1BUDJpK3pNUHN5WVlCWlpSZjlNV2Y3UEp4WEFuUlVrcUxE?=
 =?utf-8?Q?uYu20Nc0sIfL92iFoY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZzaUdzVThLZURLRVNLOTZKUVdiR3FjNmRzZEE0MDlpZFNPd1lHT1Z6b3BG?=
 =?utf-8?B?UlVmTVM4NnVic1J3Mk14RldRVllPc3dEMnVlUVNuOGlwMWcraXBMb0g0b0hT?=
 =?utf-8?B?YklDQkpaMm1DdlRvRkQ1Yy83aXVsK2ZPQUc4aUV3bFA0WlpBNFB4dEZwMnIv?=
 =?utf-8?B?THp0VnVGLzE5UDRSQ2JVSGE5RTdRMmtTeHVQWi9Yb1pHZ0h2RGs0L21GT0c4?=
 =?utf-8?B?Y2NwK1NEbWFzYzA4ek5XQVhoL2tzc1Jpc2ZjdmYxSk5FZVJGUGdKTWp1VUdt?=
 =?utf-8?B?MHpUYTVTR2cxQVU2TEIyZ1R5SnhCTmRPYzdsOUNQc0Rnb3Jja2ZuQmQxYWxH?=
 =?utf-8?B?RUZiTi94ZWdnT29jOHo5SjloWGFwYkx6eStMN244bWkyclZLMVg4cXNMeWhW?=
 =?utf-8?B?NWcxTjlaSnpkaEpHaW1MVHZJSUpaZ3lRTkg4cExmNGk3b0FDeDVoNU5lREVh?=
 =?utf-8?B?Um1VYUdjVHh4eUxLR0UzQ2VadE5wTEVNWlV6OWo2ck5QZWlLTlBjdFpwemdQ?=
 =?utf-8?B?MndzbUFhSkR4KzB0aXlDZ0F1Mk5RcUZ6ZWxkd0dpeGJBT2hBakdtc3hSYjMx?=
 =?utf-8?B?Y0JSN05BVDROaGpFbUJYYkhGVVNRVi83OUJ1YTdUckZzZ3dhQnU1K2JFRHMv?=
 =?utf-8?B?aXE0bUhNM2E1NWlPbGQvd0E5R0doWnorUW9tbGF0ZU9jS2RJVFoxU2l4THRH?=
 =?utf-8?B?b1AwWVZ2bmVkYUZoSEY4UDVvSjZnb3kxZDFQNmlONEtTWkJpU3hhaVk3ZVU3?=
 =?utf-8?B?K0o0ZUU1cmVqeERtK2xtbWIzZkhsalpoUEJDYVFzbTcveGdGM2dmUVlTMUdz?=
 =?utf-8?B?QVliVGJCSmNYZm93bjEyMkpjaFRrS2xCVEgvRkFkRjVwUW52Qjc4OHo0eHJV?=
 =?utf-8?B?VDN1VnFUbGR1eEk2ZXhPWmg4QU1WUFlwbUY5eE5ISHNDczgwY21ia2ZYVlZR?=
 =?utf-8?B?ajZKeFVLTlZOWjBrdmdnZUlvdkpZaEhDQ2o4eTZlK2w4dkJJZ09OUFMrbXBK?=
 =?utf-8?B?QVJrbDBxUmh6b3Q2dTJvclhvWTlqT2ZZRlpNYlNYYVB6K0s1TUFaU1l3ZEtR?=
 =?utf-8?B?Y1NxWlNXQ2Z2L0VBUDkrbEgrcG1nTEwvT2JuQ1BIa0pCeG52UjdQOW8xRmlU?=
 =?utf-8?B?Q3dJY3A0U0xhQkFvb3htaGs2NGx1NzMyZHh6aVR2dHUzVjhsWWZHSHNRVEUr?=
 =?utf-8?B?eVJ6dVd6TlE0d1JMaEJaR3lDMytlb0hhSVJ6aTJPK3NUeXJVSGVUVCtYM242?=
 =?utf-8?B?cTRHa0kwSjMwdUNqS3pCZWNjWGgyQlhLcytuYVZHamVvcnRGNGJLdmxxSHZV?=
 =?utf-8?B?cm14WmF5WjJEWk5LK01KaVV4YmxYMU5wMldFMStCSjJGc1g3MzBNckg4N3Rp?=
 =?utf-8?B?L3l4REM2MEhKUGxjTW5yVXVWdytaVmFCZTVPbEl5eXRINXJKY3NuQ2MweFZB?=
 =?utf-8?B?czNzc2FrMFhDQVFTbGx0cXVZVXZHdndvK2xyRTBNYjdzdkd2Si9xUlpyU1Zx?=
 =?utf-8?B?VlBBUVBRWUIrUWFxTFRBallBV2VQWXFuNUFWeHNvUkxoSjA5UXhWSmhXQ2s0?=
 =?utf-8?B?OTdMcEorbkM4Q0dQSWMybWhBVC9Tb2ttOVhyTndQeVlRcUsyYXBxdWJ0ZkxX?=
 =?utf-8?B?N1AweXQxR3dob2MwTUg1SEZ3VFlzR3NOa1pqQlVEcjVlZHJrZlBwbDlWSGpa?=
 =?utf-8?B?eUNUQXZvSFdZbVh5OHdRSXhQRjI1VjBhVjF1MENmYldYeGZsV1FwYkljRWxJ?=
 =?utf-8?B?ZTlUZ0NnM0ZlZ0lyVmZwWDdKNUR3dnZlWit0dzQ4UGV1QjhrQVpadEVHQ1Qr?=
 =?utf-8?B?aG51eFVwdWx5WjY2RjVVSjhZSDkxcUJxS3hIaTVOU0dZb0NtY0dvaVgzOTZU?=
 =?utf-8?B?bkVpZHczSFZYdEpHTzZaSDByS0hubmZxRTNTY09KaWlLR3ZlUGpTMEQrWTN3?=
 =?utf-8?B?MitSSTBQRGk5MTB3L1Nzb09Yak1JZFNHd2R4NmFKNnBHcGpabXN1QSs5UUtt?=
 =?utf-8?B?eTFwOUsrejl4NDNUVkM2dnBaRTJXN3ZDTjlXc0dKVEFORHJ5KzRqR1pacUc3?=
 =?utf-8?B?UUV3M0NKVi9xZFQyYjVDMWsyaFJpemtzRENVUEJuTVErVDNUM3FtOGxESXBa?=
 =?utf-8?Q?Xagy9D6n/Z6nM19CvVZbAHfrX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7350e6f7-af93-44ef-1f7e-08dd1acde5ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 16:56:18.7123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4gGaxnJZn6IcO6450hL8eOfaQfzaEfJ46aX6v5qf+u7rr3i0JTkXWhMSJkZVxa/asYp/s1Map/VL65vLgzHSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570
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



On 2024-12-12 0:30, Zhu Lingshan wrote:
> On 12/12/2024 12:19 PM, Felix Kuehling wrote:
>>
>> On 2024-12-11 22:06, Zhu Lingshan wrote:
>>> kfd_process_wq_release() signals eviction fence by
>>> dma_fence_signal() which wanrs if dma_fence
>>> is NULL.
>> That's news to me. Looking at the dma_fence_signal implementation on amd-staging-drm-next, it just silently returns -EINVAL if the fence pointer is NULL. I see the same in Linux 6.12.4: https://elixir.bootlin.com/linux/v6.12.4/source/drivers/dma-buf/dma-fence.c#L467
>>
>> Which branch are you on?
> Linus tree, latest master branch, tag v6.13-rc2
> https://github.com/torvalds/linux/blob/master/drivers/dma-buf/dma-fence.c#L467
> 
> which is introduced by
> https://github.com/torvalds/linux/commit/967d226eaae8e40636d257bf8ae55d2c5a912f58

Thank you for that pointer. Please add a Fixes tag to point to that upstream commit. With that, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

> 
> Thanks
> Lingshan
> 
>>
>> Regards,
>>   Felix
>>
>>> kfd_process->ef is initialized by kfd_process_device_init_vm()
>>> through ioctl. That means the fence is NULL for a new
>>> created kfd_process, and close a kfd_process right
>>> after open it will trigger the warning.
>>>
>>> This commit conditionally signals the eviction fence
>>> in kfd_process_wq_release() only when it is available.
>>>
>>> [  503.660882] WARNING: CPU: 0 PID: 9 at drivers/dma-buf/dma-fence.c:467 dma_fence_signal+0x74/0xa0
>>> [  503.782940] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
>>> [  503.789640] RIP: 0010:dma_fence_signal+0x74/0xa0
>>> [  503.877620] Call Trace:
>>> [  503.880066]  <TASK>
>>> [  503.882168]  ? __warn+0xcd/0x260
>>> [  503.885407]  ? dma_fence_signal+0x74/0xa0
>>> [  503.889416]  ? report_bug+0x288/0x2d0
>>> [  503.893089]  ? handle_bug+0x53/0xa0
>>> [  503.896587]  ? exc_invalid_op+0x14/0x50
>>> [  503.900424]  ? asm_exc_invalid_op+0x16/0x20
>>> [  503.904616]  ? dma_fence_signal+0x74/0xa0
>>> [  503.908626]  kfd_process_wq_release+0x6b/0x370 [amdgpu]
>>> [  503.914081]  process_one_work+0x654/0x10a0
>>> [  503.918186]  worker_thread+0x6c3/0xe70
>>> [  503.921943]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  503.926735]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  503.931527]  ? __kthread_parkme+0x82/0x140
>>> [  503.935631]  ? __pfx_worker_thread+0x10/0x10
>>> [  503.939904]  kthread+0x2a8/0x380
>>> [  503.943132]  ? __pfx_kthread+0x10/0x10
>>> [  503.946882]  ret_from_fork+0x2d/0x70
>>> [  503.950458]  ? __pfx_kthread+0x10/0x10
>>> [  503.954210]  ret_from_fork_asm+0x1a/0x30
>>> [  503.958142]  </TASK>
>>> [  503.960328] ---[ end trace 0000000000000000 ]---
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 87cd52cf4ee9..47d36f43ee8c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1159,7 +1159,8 @@ static void kfd_process_wq_release(struct work_struct *work)
>>>  	 */
>>>  	synchronize_rcu();
>>>  	ef = rcu_access_pointer(p->ef);
>>> -	dma_fence_signal(ef);
>>> +	if (ef)
>>> +		dma_fence_signal(ef);
>>>  
>>>  	kfd_process_remove_sysfs(p);
>>>  
> 

