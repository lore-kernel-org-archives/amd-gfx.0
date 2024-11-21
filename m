Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD74AD75BBA
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 04:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C4110E037;
	Thu, 21 Nov 2024 04:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Keyr5XWJ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5075F10E037
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 04:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM4KNHjoIAgwUdZrOjgFxhVFBeflV5EEb9EQnBjSUVXKx5d3rofxXDUWy9hx40iEPtlIyiqPqCbtikOh2oD+88VHcMTqI0603hmpwL7mtFV92TecL81EwQmgc3ZLYtmIIIHnhXcguXQg0QzUXv6d9+D5rCz/Nj+SX0bn5YTLPhyLAk/jntwK6YtZKwMmTGmO9BxA4Cpn7cSQZqsxfuuL9SzecivLZwjvk73lOGpaqymfxMLq36MREzshs5PtDELM6bU+/mIgILYA7ja9+32DnlJOwZ9AWdTxip59X1f21H/9g3Rne4jkfSggJ1CgOsSynVWqo/QVu3a3yXRl/YwWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQP+eOUUAQ85bYGram8yxso58ZhZHNT8qJWwEqfi1F8=;
 b=jCiSI+dX8lLJYYGl4+DayBiruec8Hv9Zfk+Hr5wYtvSDnizeFY9VMoqDO8oQhZgpN+140SR8KE6tmn/lTdD0i48f34Guifki1mQzb1RXdcdV30moHt0Lq0S7hCM6QwpEpU1qAmwhclGBLcG//T38triYG6H9vTXxpHlD9YZbdU1tfMezvF/qiePbC/NuOg3SsFcdgcNu8PhSMY8TER8eWtwq8SznBKcD7aDkZ2ZtWPgXeOoR+vcqwU66bZ18PXGndOi2W9ytox/G24CTrC3XsKp4ey6WIN8HPy1W0HScusAug6Jju8sY7M0O9KRX67Bbto3jYgTu5v7/s+pCLIUkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQP+eOUUAQ85bYGram8yxso58ZhZHNT8qJWwEqfi1F8=;
 b=Keyr5XWJHgCi0QWFl7UfJNI2VX02R3WFJNpG7j9zEchyeQmy6D7K3NmMV5sUjDrtmlM6fvc7Hy67cLdWVdrGAqBG16CkB9G77lZxs/GLS8g8Kxh+WituQ0IxhWvJb87VAsEbBw7G+k8p5I5XEuW6dBEhKujaZjMxBaaEJETh4s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Thu, 21 Nov 2024 04:58:56 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 04:58:55 +0000
Message-ID: <d8884052-8b31-4928-adfe-1f5dd5b09cde@amd.com>
Date: Wed, 20 Nov 2024 22:58:53 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Have kfd driver use same PASID values from
 graphic driver
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, jonathan.kim@amd.com
References: <20241111193323.278768-1-xiaogang.chen@amd.com>
 <6013a2b2-7e49-49e4-af90-8ea156a9722e@amd.com>
Content-Language: en-CA
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <6013a2b2-7e49-49e4-af90-8ea156a9722e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:806:d3::32) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: c497fe56-9559-491a-569f-08dd09e9337d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDJqOGdJZDBSb1pYcEFUSS9PREx3UWlGeFJXRGNJdkZWK0dPTDVhdEttRXl0?=
 =?utf-8?B?NVhkN3JjYnJnVy9TSnpIbTY4c2tHeWkxQVB3bncvV0VDN2RwNTRuOGNqbllo?=
 =?utf-8?B?YThwVFh5cG5XaGxlUmQ2cGUvZ0x5VVc3ZWlGcWhsTlRuR3Q5b3RxQzFUOEZ3?=
 =?utf-8?B?K2Y4Qmk5NDVuN1RxcFo0dHBaM0dmNnJlWFdaOGt1UVBkSlpPN2FPSGJ0cG0r?=
 =?utf-8?B?UytrZ0ZvaWxwc1RyM3AxaTlPMFhpWGhYYkhjTkFrU2dJdkZtdEUvb0ZHa1lm?=
 =?utf-8?B?SnZrMUJyQnNCRHpFd1lrL2xneVRqakloVFViMmxLUHFwVGFDa1NqY2xRL3k2?=
 =?utf-8?B?ejEyVXB3VmJldUtyVWJoRElkOVZtTlo2OHVCMTNxQ1B5TjFCL244MEYvYmJO?=
 =?utf-8?B?eTNRaGlCWk9nZE01eHdBOHowaGNock1yYU9mbjRieXJNNnAzVTl1RlUvZmxJ?=
 =?utf-8?B?VVdONlM4eXVpZWFUMDJMQUdCeXo5SlJrOFlWTTc5bHlRbXdETGxjendnVUhK?=
 =?utf-8?B?dklhLzJ1WVdxcExpeDh4Q2ZCOXJMc2w1ZUFGZ3NlLzNBVXh4aysyanRGbTdF?=
 =?utf-8?B?NURFeHFPVmh6MDZTb2lGbEtGVDdENElWY25MQ0s1VEpybWE0L1Yzc3R0dC9m?=
 =?utf-8?B?RTQ2TTNpakR4T2NtaDVabWI5MGpZQ1FWK1NPUHhmRGR0OHVNYVJsZ2pNQ0Y1?=
 =?utf-8?B?NE9RL1VNeitteFRPWFZnTVVoWjg2YXczVjgxUGsyblRIaTVGenRtTnhHS3dL?=
 =?utf-8?B?ZXU5Z09SRkxmL0NCQkc0SzJMeEJyZFEwNTJkM0lvUjhySlRIZUJkTzltVWZV?=
 =?utf-8?B?S2ZDMFNMNDFkaHFWZTVHWU45UGpKYjNFNGQxcHFJR3J1QitaQml5RzlXaE5Z?=
 =?utf-8?B?K2hPcFA2L2pUN0lMdE5tdEJKcndYUzFCRFNKNTNkSkVmUU9aVll5cFc5Vjhw?=
 =?utf-8?B?WFowT1BHU2U1QzV6QUpPTE1xbjFRemRndkYySXVEMXdWbEp1LytkQkNjdHh6?=
 =?utf-8?B?YlpFYkd3S2FrY3VXOWlnRW1iZWNNSUVoS1VnOFBHWWtvMXRKbmY2K254S1Qr?=
 =?utf-8?B?Nk12RzlIb0Y1eVNwaWkrQTR3OHVRaEN6VWhSM2NuWitidVRmQU8zSXY4VFNW?=
 =?utf-8?B?YWg2YjFEY2ZkRHpGWC9JcjNKaVBlRTVTNHBianc0djlxMkZzVzcxazNldFF0?=
 =?utf-8?B?YWNsV2VrWm04Yis4eHVVVzlrYVBCN3ZyOXdUZE5rbXhOWnFKSkRrREkvODBN?=
 =?utf-8?B?UHdNZDNWU2Y2aGhsMWRReGhOZjZhTW1wbjdoSHcwRHVnWTVvdzgvS1E3Q25O?=
 =?utf-8?B?NU0xNlZsNjNqR215NGNrMTM3U0ppNEE4YVhsSWFhVUJnVlBEMlJLMWhoSXJP?=
 =?utf-8?B?N2ltOHhzWUlNU1lyVHZ1WHh3M09Ba3FteWdDTVBRTXd3b2xNVXVkZWxybTNX?=
 =?utf-8?B?YUk2K2NuenZjRFhMekIrc0xwQmM0RHM2L3czQ0xtYUV0TFVhblNqbHBtaTJY?=
 =?utf-8?B?d3VSVDRaa3hkQ1N2akpUNGtUZEpET0Zhd25jcGtBZnFjR3NVMTNIdGRNOVBH?=
 =?utf-8?B?ZGNqSWpqSFRsRkxWS0I1ZmlOQldmbXI4aHdBZkpvMWJXVVJIWm4zQWZoOE44?=
 =?utf-8?B?ME1KZko2RlptMHNJS3hTLzBOd0tON1JBdTFHS3J0SmdzMmVjV1dDbVprcDRs?=
 =?utf-8?B?d0M5YVZCZWF6TUROdEZBQTNXQ2FGS3UzQ1FQaW1yQnN0YlpOdUFpdTI3UlF1?=
 =?utf-8?Q?2GcFKzWyrWTnKsmrwZRFanFkeVL3oBejKUKHqvO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnQvTjdGeUFZTlRBRXA0VkJYTjlIa2pYL21aRGlESFNMNXVyYkUyaitTdjJn?=
 =?utf-8?B?cVVFZ3U5TytXL3REQVhPdm9qSXRHN2dOMDNEM202aWs4UHQ3M3NoR1pYemhs?=
 =?utf-8?B?aXRoZGY0ZkRqaTVMT3FqWXZ4bUpRSmFRMWF2dmFReHFHeGpMZzhNTkFKUW5B?=
 =?utf-8?B?RTZTK0RLL2hSalNZVU9YbkdrK3NrMjA3b1VnbEJoWlZhYjJjSFRNVmdzQ3Ey?=
 =?utf-8?B?VVg1aFVtWGdYbDR0ZGdXNFdkNmR0MCt3NlhYbWJGRnk1U0J4TDh5ZW1iVGF2?=
 =?utf-8?B?cG51WWdud0VnS3R3Uy9HOVJwKzJlSVB2NHhUSVJGeVZaRnB2MFF5UTFpazJn?=
 =?utf-8?B?cEUwbGdLT2R3UUNhUEVjNnV1UU9TRXV0YmdqZHh1NHh4eWJ5Qi9tU0ZSWmJT?=
 =?utf-8?B?VVZWVHJyc1V6cDE1bXhTZFA2SFlBRzY3MlNPcWRVeWZFbnkzL1FrSGF4NDA5?=
 =?utf-8?B?UnBTc011ZFZldW54SUNqMDIwVkZ4UVErL0lwenBoSWVuaGpWTGJMZjduZWt5?=
 =?utf-8?B?UEkxRWFvZWs0WHQrSUNUeVhxb29renk4Zi90SWQyS0ZvYkJSZkpOSFBGdmoz?=
 =?utf-8?B?N2ttdUVJc0RzTlZGZ2ltWUdXMmJ4M0tKaWVPV2NBNngyTXhwMlZmNTNZZndt?=
 =?utf-8?B?N04wNTZMUXhMQ3lCcEZ2aG1SYXF0eEFmTldSRm9XZ29jdzVjdWtVM3Z2Z0po?=
 =?utf-8?B?c29JRzV4QmY1eUg2d045VmFVWU1GRDRxUnEzemJ2cDdYM1JVS0xPSkh1dnJS?=
 =?utf-8?B?THI2MjRqN1FpbWlWc29YNDhPdDdUR3ZRSXpVdTRybWxqT21kVVVMajBBaEIx?=
 =?utf-8?B?ZVl4akJqRURCT2JVbC9CNU9jK1czWi9JcW04MGJiYklJd2d1NkY0bUF4YjNK?=
 =?utf-8?B?bEJYSDg0cDE4OG5TMmVaakxuNENWbzMvOERIS1FKUUpVZkR4L3VHZVlEWkJZ?=
 =?utf-8?B?dTVHeXd3TFQ1bnFaUk1nNy9SQW96d0drZHN4dGozZnovMkk2bU1qTFpmWjJt?=
 =?utf-8?B?anVCdjBpWXcvdjlkTDNUTGZnMFAwNmZ3UXRPY21hV21GRGZzOGJISjYzd3dR?=
 =?utf-8?B?MlNVVitRTUFpT1VJRnBkNHVxWkwwcDR0TlZzY2hZZTU5V243KzBwOEJwZ2xS?=
 =?utf-8?B?VzJMR3Y0MUtoMGVFb3Ywb3l4RExjY3M4WUFlQW9LOXdKK3pIYzFWMGdZQnUy?=
 =?utf-8?B?TGJQWDhycHJXK1ZZNnB6QkszMFJwMnVuSU8vYUJtUmxKazFURXNISnJ5enR4?=
 =?utf-8?B?ZUtxcDBCZk9WN2dCUk1pMVllMkdNWnNLRTJSM3JWbUFnYjVscVdkZU5IWVE5?=
 =?utf-8?B?R2E3SGtRTHdzQlR5Zm0reFgvZldXZmJEV1VFbS8xL0p4bE0rQkdrUHhSTWV1?=
 =?utf-8?B?aEdoRE9BL01sN1hMMmNBOWZ4S3F5Skh5a2p1eHZWU2haUHdvTGxJeHI5S05o?=
 =?utf-8?B?OE1UeUFSSGlqWnoveFN3ci9VS21YUjhudTJkRlpsZmsxM3c2UUFRZkM0Nllr?=
 =?utf-8?B?QkduYWxOd3o1NTA0WEJoYzhyaGY1VlFab2lXWHF0L3pNbDdVYklXRmpxUzB2?=
 =?utf-8?B?cjh3dnNnRzRwdCt6dElVNWFObWRXYWtkVEpjbi9NNFRxd2VRZi90TGlPc2Jl?=
 =?utf-8?B?SUdKRkliSmlwV0VjL1F4T1A3cG5QVy9zclhlbHJEUW5MTnRIZENqWStKYjlP?=
 =?utf-8?B?ZDg1L1hpSEgxT0NienNmVFB3M3Q1eEVSSjhVWFZWVGw3eDRuWVlUUWRTVW1x?=
 =?utf-8?B?VUVMMUEvWXo4YXhxQnZNZjh6MDhMd0N5VjM4bkJsWWU5b2E5TGxsZVhSMDZT?=
 =?utf-8?B?ZlZqSXhqdlZSZmZyVUdrTVB0SFFubGVEV0pvNFFxdFZjNlJYS3ZjVzNJQ0xr?=
 =?utf-8?B?Unpqb0ZNb25QTnZzcVVuQjZETWI2dXR3WmRuUGZsYXZoeU1MS0ZIa091Zytq?=
 =?utf-8?B?UHZNWU54eXMwNksrK2gxMkpMdXc3UFRtakdYcHk2enFoNWFvQTVmdWxNVmYr?=
 =?utf-8?B?TG1NSkdFbGlBOWxQS0krbU1JU1lqYzY5aEM0SHREa1hrQ2F6TXVlOXV1ZlE3?=
 =?utf-8?B?MzcrTHpBRG5QRm85Mncxc0pUYVJaOEcxRjRYWUNIWHBvQktaUndybks5WkxO?=
 =?utf-8?Q?OyCw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c497fe56-9559-491a-569f-08dd09e9337d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 04:58:55.4106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M4ETrLxV7K4qWOjhcR2li6+iP2dXZFtpsonrmK+DbO6I6nq+/fNh9oubmUI1Tnb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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


On 11/20/2024 4:39 PM, Felix Kuehling wrote:
>
> On 2024-11-11 13:33, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> Current kfd driver has its own PASID value for a kfd process and uses it to
>> locate vm at interrupt handler or mapping between kfd process and vm. That
>> design is not working when a physical gpu device has multiple spatial
>> partitions, ex: adev in CPX mode. This patch has kfd driver use same pasid
>> values that graphic driver generated which is per vm per pasid.
>>
>> These pasid values are passed to fw/hardware. We do not need change interrupt
>> handler though more pasid values are used. Also, pasid values at log are
>> replaced by user process pid, or pasid values are not exposed to user, user
>> will see their process pids that have meaning in user space.
>>
>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 34 +++++----
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 25 +++----
>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  8 +--
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 52 +++++++-------
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 17 ++---
>>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 +-
>>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  3 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 71 ++++++++-----------
>>   .../amd/amdkfd/kfd_process_queue_manager.c    | 10 +--
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 17 +++--
>>   12 files changed, 127 insertions(+), 123 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 4b80ad860639..e576f65979a2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
>>   };
>>   
>>   struct amdgpu_device;
>> +struct kfd_process_device;
>>   struct amdgpu_reset_context;
>>   
>>   enum kfd_mem_attachment_type {
>> @@ -300,7 +301,8 @@ bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
>>   		((struct drm_file *)(drm_priv))->driver_priv)->vm)
>>   
>>   int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>> -				     struct amdgpu_vm *avm, u32 pasid);
>> +				     struct kfd_process_device *pdd,
>> +				     struct amdgpu_vm *avm);
>>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>>   					struct amdgpu_vm *avm,
>>   					void **process_info,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index f30548f4c3b3..f63c6b185bbb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1530,24 +1530,30 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
>>   }
>>   
>>   int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>> -				     struct amdgpu_vm *avm, u32 pasid)
>> +				     struct kfd_process_device *pdd,
>> +				     struct amdgpu_vm *avm)
> I'd prefer if this function got renamed to amdgpu_amdkfd_gpuvm_get_pasid and it returns the pasid.
ok.
>>   
>>   {
>> -	int ret;
>> -
>> -	/* Free the original amdgpu allocated pasid,
>> -	 * will be replaced with kfd allocated pasid.
>> -	 */
>> -	if (avm->pasid) {
>> -		amdgpu_pasid_free(avm->pasid);
>> -		amdgpu_vm_set_pasid(adev, avm, 0);
>> +	int ret = 0;
>> +	int pasid;
>> +
>> +	/* if avm has pasid assigned use it */
>> +	if (avm->pasid)
>> +		pdd->pasid = avm->pasid;
>> +	else {
>> +		/* otherwise generate a new pasid and assign to avm */
> Does this ever happen? I think any avm that was acquired properly should already have a PASID. If it doesn't, maybe we can just return an error.
Right, this case should not happen as app should open render node first, 
then acquire vm through kfd node. I handled the case here just in case, 
but we can return an error here.
>
>> +		pasid = amdgpu_pasid_alloc(16);
>> +		if (pasid < 0) {
>> +			dev_warn(adev->dev, "No more PASIDs available!");
>> +			ret = -ENOMEM;
>> +		} else
>> +			ret = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, avm,
>> +						  GFP_KERNEL));
>> +		if (ret >= 0)
>> +			avm->pasid = pasid;
>>   	}
>>   
>> -	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
>> -	if (ret)
>> -		return ret;
>> -
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 065d87841459..8b1fd8e7452b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -155,8 +155,8 @@ static int kfd_open(struct inode *inode, struct file *filep)
>>   	/* filep now owns the reference returned by kfd_create_process */
>>   	filep->private_data = process;
>>   
>> -	dev_dbg(kfd_device, "process %d opened, compat mode (32 bit) - %d\n",
>> -		process->pasid, process->is_32bit_user_mode);
>> +	dev_dbg(kfd_device, "process pid %d opened kfd node, compat mode (32 bit) - %d\n",
>> +		(int)process->lead_thread->pid, process->is_32bit_user_mode);
>>   
>>   	return 0;
>>   }
>> @@ -361,8 +361,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>   		goto err_acquire_queue_buf;
>>   	}
>>   
>> -	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>> -			p->pasid,
>> +	pr_debug("Creating queue for process pid 0x%x on gpu 0x%x\n",
>> +			(int)p->lead_thread->pid,
>>   			dev->id);
>>   
>>   	err = pqm_create_queue(&p->pqm, dev, &q_properties, &queue_id,
>> @@ -415,9 +415,9 @@ static int kfd_ioctl_destroy_queue(struct file *filp, struct kfd_process *p,
>>   	int retval;
>>   	struct kfd_ioctl_destroy_queue_args *args = data;
>>   
>> -	pr_debug("Destroying queue id %d for pasid 0x%x\n",
>> +	pr_debug("Destroying queue id %d for process pid 0x%x\n",
>>   				args->queue_id,
>> -				p->pasid);
>> +				(int)p->lead_thread->pid);
>>   
>>   	mutex_lock(&p->mutex);
>>   
>> @@ -468,8 +468,8 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
>>   	properties.pm4_target_xcc = (args->queue_percentage >> 8) & 0xFF;
>>   	properties.priority = args->queue_priority;
>>   
>> -	pr_debug("Updating queue id %d for pasid 0x%x\n",
>> -			args->queue_id, p->pasid);
>> +	pr_debug("Updating queue id %d for process pid 0x%x\n",
>> +			args->queue_id, (int)p->lead_thread->pid);
>>   
>>   	mutex_lock(&p->mutex);
>>   
>> @@ -695,7 +695,7 @@ static int kfd_ioctl_get_process_apertures(struct file *filp,
>>   	struct kfd_process_device_apertures *pAperture;
>>   	int i;
>>   
>> -	dev_dbg(kfd_device, "get apertures for PASID 0x%x", p->pasid);
>> +	dev_dbg(kfd_device, "get apertures for process pid 0x%x", (int)p->lead_thread->pid);
>>   
>>   	args->num_of_nodes = 0;
>>   
>> @@ -747,7 +747,8 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
>>   	int ret;
>>   	int i;
>>   
>> -	dev_dbg(kfd_device, "get apertures for PASID 0x%x", p->pasid);
>> +	dev_dbg(kfd_device, "get apertures for process pid 0x%x",
>> +			(int)p->lead_thread->pid);
>>   
>>   	if (args->num_of_nodes == 0) {
>>   		/* Return number of nodes, so that user space can alloacate
>> @@ -3365,12 +3366,12 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
>>   
>>   	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>   
>> -	pr_debug("pasid 0x%x mapping mmio page\n"
>> +	pr_debug("process pid 0x%x mapping mmio page\n"
>>   		 "     target user address == 0x%08llX\n"
>>   		 "     physical address    == 0x%08llX\n"
>>   		 "     vm_flags            == 0x%04lX\n"
>>   		 "     size                == 0x%04lX\n",
>> -		 process->pasid, (unsigned long long) vma->vm_start,
>> +		 (int)process->lead_thread->pid, (unsigned long long) vma->vm_start,
>>   		 address, vma->vm_flags, PAGE_SIZE);
>>   
>>   	return io_remap_pfn_range(vma,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> index 312dfa84f29f..93ba497042b2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> @@ -238,8 +238,8 @@ bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
>>   
>>   			mutex_unlock(&p->mutex);
>>   		} else if (trap_mask & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
>> -			kfd_dqm_evict_pasid(dev->dqm, p->pasid);
>> -			kfd_signal_vm_fault_event(dev, p->pasid, NULL,
>> +			kfd_dqm_evict_pasid(dev->dqm, pasid);
>> +			kfd_signal_vm_fault_event(dev, pasid, NULL,
>>   							exception_data);
>>   
>>   			signaled_to_debugger_or_runtime = true;
>> @@ -276,8 +276,8 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>>   		data = (struct kfd_hsa_memory_exception_data *)
>>   						pdd->vm_fault_exc_data;
>>   
>> -		kfd_dqm_evict_pasid(pdd->dev->dqm, p->pasid);
>> -		kfd_signal_vm_fault_event(pdd->dev, p->pasid, NULL, data);
>> +		kfd_dqm_evict_pasid(pdd->dev->dqm, pdd->pasid);
> kfd_dqm_evict_pasid just goes and looks up the pdd from the pasid again. Maybe this could be streamlined with a kfd_dqm_evict_pdd that avoids the unnecessary lookup. Could be a follow-up patch.

This is a different thing that we loop up kfd process or pdd more than 
one time(redundant). This issue happened at several places. I will 
remove some redundant  loop up in next version.

>
>> +		kfd_signal_vm_fault_event(pdd->dev, pdd->pasid, NULL, data);
> Similarly, this function looks up the process from the PASID. Maybe this could be refactored to avoid the redundant lookup.
Same as above.
>
>>   		error_reason &= ~KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION);
>>   	}
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 38c19dc8311d..ca8db5e3a7b7 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -206,7 +206,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>>   		return -EIO;
>>   
>>   	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>> -	queue_input.process_id = qpd->pqm->process->pasid;
>> +	queue_input.process_id = pdd->pasid;
>>   	queue_input.page_table_base_addr =  qpd->page_table_base;
>>   	queue_input.process_va_start = 0;
>>   	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
>> @@ -496,6 +496,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>>   			struct qcm_process_device *qpd,
>>   			struct queue *q)
>>   {
>> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>>   	struct device *dev = dqm->dev->adev->dev;
>>   	int allocated_vmid = -1, i;
>>   
>> @@ -514,9 +515,9 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>>   
>>   	pr_debug("vmid allocated: %d\n", allocated_vmid);
>>   
>> -	dqm->vmid_pasid[allocated_vmid] = q->process->pasid;
>> +	dqm->vmid_pasid[allocated_vmid] = pdd->pasid;
>>   
>> -	set_pasid_vmid_mapping(dqm, q->process->pasid, allocated_vmid);
>> +	set_pasid_vmid_mapping(dqm, pdd->pasid, allocated_vmid);
>>   
>>   	qpd->vmid = allocated_vmid;
>>   	q->properties.vmid = allocated_vmid;
>> @@ -768,6 +769,11 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
>>   		return -EOPNOTSUPP;
>>   	}
>>   
>> +	/* taking the VMID for that process on the safe way using PDD */
>> +	pdd = kfd_get_process_device_data(dev, p);
>> +	if (!pdd)
>> +		return -EFAULT;
>> +
>>   	/* Scan all registers in the range ATC_VMID8_PASID_MAPPING ..
>>   	 * ATC_VMID15_PASID_MAPPING
>>   	 * to check which VMID the current process is mapped to.
>> @@ -777,23 +783,19 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
>>   		status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
>>   				(dev->adev, vmid, &queried_pasid);
>>   
>> -		if (status && queried_pasid == p->pasid) {
>> -			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
>> -					vmid, p->pasid);
>> +		if (status && queried_pasid == pdd->pasid) {
>> +			pr_debug("Killing wave fronts of vmid %d and process pid 0x%x\n",
>> +				 vmid, p->lead_thread->pid);
>>   			break;
>>   		}
>>   	}
>>   
>>   	if (vmid > last_vmid_to_scan) {
>> -		dev_err(dev->adev->dev, "Didn't find vmid for pasid 0x%x\n", p->pasid);
>> +		dev_err(dev->adev->dev, "Didn't find vmid for process pid 0x%x\n",
>> +			p->lead_thread->pid);
>>   		return -EFAULT;
>>   	}
>>   
>> -	/* taking the VMID for that process on the safe way using PDD */
>> -	pdd = kfd_get_process_device_data(dev, p);
>> -	if (!pdd)
>> -		return -EFAULT;
>> -
>>   	reg_gfx_index.bits.sh_broadcast_writes = 1;
>>   	reg_gfx_index.bits.se_broadcast_writes = 1;
>>   	reg_gfx_index.bits.instance_broadcast_writes = 1;
>> @@ -1029,8 +1031,8 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
>>   	if (q->properties.is_suspended)
>>   		return 0;
>>   
>> -	pr_debug("Suspending PASID %u queue [%i]\n",
>> -			pdd->process->pasid,
>> +	pr_debug("Suspending process pid %u queue [%i]\n",
>> +			pdd->process->lead_thread->pid,
>>   			q->properties.queue_id);
>>   
>>   	is_new = q->properties.exception_status & KFD_EC_MASK(EC_QUEUE_NEW);
>> @@ -1077,8 +1079,8 @@ static int resume_single_queue(struct device_queue_manager *dqm,
>>   
>>   	pdd = qpd_to_pdd(qpd);
>>   
>> -	pr_debug("Restoring from suspend PASID %u queue [%i]\n",
>> -			    pdd->process->pasid,
>> +	pr_debug("Restoring from suspend process pid %u queue [%i]\n",
>> +			    pdd->process->lead_thread->pid,
>>   			    q->properties.queue_id);
>>   
>>   	q->properties.is_suspended = false;
>> @@ -1111,8 +1113,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>>   		goto out;
>>   
>>   	pdd = qpd_to_pdd(qpd);
>> -	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
>> -			    pdd->process->pasid);
>> +	pr_debug_ratelimited("Evicting process pid 0x%x queues\n",
>> +			    pdd->process->lead_thread->pid);
>>   
>>   	pdd->last_evict_timestamp = get_jiffies_64();
>>   	/* Mark all queues as evicted. Deactivate all active queues on
>> @@ -1169,8 +1171,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>>   	if (!pdd->drm_priv)
>>   		goto out;
>>   
>> -	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
>> -			    pdd->process->pasid);
>> +	pr_debug_ratelimited("Evicting process pid 0x%x queues\n",
>> +			    pdd->process->lead_thread->pid);
>>   
>>   	/* Mark all queues as evicted. Deactivate all active queues on
>>   	 * the qpd.
>> @@ -1228,8 +1230,8 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>>   		goto out;
>>   	}
>>   
>> -	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
>> -			    pdd->process->pasid);
>> +	pr_debug_ratelimited("Restoring process pid 0x%x queues\n",
>> +			    pdd->process->lead_thread->pid);
>>   
>>   	/* Update PD Base in QPD */
>>   	qpd->page_table_base = pd_base;
>> @@ -1312,8 +1314,8 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>>   	if (!pdd->drm_priv)
>>   		goto vm_not_acquired;
>>   
>> -	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
>> -			    pdd->process->pasid);
>> +	pr_debug_ratelimited("Restoring process pid 0x%x queues\n",
>> +			     pdd->process->lead_thread->pid);
>>   
>>   	/* Update PD Base in QPD */
>>   	qpd->page_table_base = amdgpu_amdkfd_gpuvm_get_process_page_dir(pdd->drm_priv);
>> @@ -2102,7 +2104,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>>   
>>   	dev_err(dqm->dev->adev->dev, "queue id 0x%0x at pasid 0x%0x is reset\n",
>> -		q->properties.queue_id, q->process->pasid);
>> +		q->properties.queue_id, pdd->process->lead_thread->pid);
>>   
>>   	pdd->has_reset_queue = true;
>>   	if (q->properties.is_active) {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index ea3792249209..a38c0b3b88fc 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -1128,8 +1128,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>>   
>>   	if (type == KFD_EVENT_TYPE_MEMORY) {
>>   		dev_warn(kfd_device,
>> -			"Sending SIGSEGV to process %d (pasid 0x%x)",
>> -				p->lead_thread->pid, p->pasid);
>> +			"Sending SIGSEGV to process pid %d",
>> +				p->lead_thread->pid);
>>   		send_sig(SIGSEGV, p->lead_thread, 0);
>>   	}
>>   
>> @@ -1137,13 +1137,13 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>>   	if (send_signal) {
>>   		if (send_sigterm) {
>>   			dev_warn(kfd_device,
>> -				"Sending SIGTERM to process %d (pasid 0x%x)",
>> -					p->lead_thread->pid, p->pasid);
>> +				"Sending SIGTERM to process pid %d",
>> +					p->lead_thread->pid);
>>   			send_sig(SIGTERM, p->lead_thread, 0);
>>   		} else {
>>   			dev_err(kfd_device,
>> -				"Process %d (pasid 0x%x) got unhandled exception",
>> -				p->lead_thread->pid, p->pasid);
>> +				"Process pid %d got unhandled exception",
>> +				p->lead_thread->pid);
>>   		}
>>   	}
>>   
>> @@ -1253,7 +1253,8 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>>   		}
>>   
>>   		if (unlikely(!pdd)) {
>> -			WARN_ONCE(1, "Could not get device data from pasid:0x%x\n", p->pasid);
>> +			WARN_ONCE(1, "Could not get device data from process pid:0x%x\n",
>> +				  p->lead_thread->pid);
>>   			continue;
>>   		}
>>   
>> @@ -1263,7 +1264,7 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>>   		if (dev->dqm->detect_hang_count) {
>>   			struct amdgpu_task_info *ti;
>>   
>> -			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
>> +			ti = amdgpu_vm_get_task_info_pasid(dev->adev, pdd->pasid);
> Can we use amdgpu_vm_get_task_info_vm here to avoid a redundant lookup of the VM from the pasid? You'd need a helper to get the vm from pdd->drm_priv (drm_priv_to_vm in amdgpu_amdkfd.h).
Same as above, redundant loop up at original code. Will change that in 
next version.
>
>>   			if (ti) {
>>   				dev_err(dev->adev->dev,
>>   					"Queues reset on process %s tid %d thread %s pid %d\n",
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> index 1f9f5bfeaf86..d56525201155 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> @@ -47,7 +47,7 @@ static int pm_map_process_v9(struct packet_manager *pm,
>>   		packet->bitfields2.exec_cleaner_shader = 1;
>>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>>   	packet->bitfields2.process_quantum = 10;
>> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
>> +	packet->bitfields2.pasid = pdd->pasid;
>>   	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
>>   	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
>>   	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
>> @@ -106,7 +106,7 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
>>   		packet->bitfields2.exec_cleaner_shader = 1;
>>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>>   	packet->bitfields2.process_quantum = 10;
>> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
>> +	packet->bitfields2.pasid = pdd->pasid;
>>   	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
>>   	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
>>   	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>> index c1199d06d131..347c86e1c378 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>> @@ -42,6 +42,7 @@ unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size)
>>   static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
>>   				struct qcm_process_device *qpd)
>>   {
>> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>>   	struct pm4_mes_map_process *packet;
>>   
>>   	packet = (struct pm4_mes_map_process *)buffer;
>> @@ -52,7 +53,7 @@ static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
>>   					sizeof(struct pm4_mes_map_process));
>>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>>   	packet->bitfields2.process_quantum = 10;
>> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
>> +	packet->bitfields2.pasid = pdd->pasid;
>>   	packet->bitfields3.page_table_base = qpd->page_table_base;
>>   	packet->bitfields10.gds_size = qpd->gds_size;
>>   	packet->bitfields10.num_gws = qpd->num_gws;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 9e5ca0b93b2a..08bcbc45197c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -849,6 +849,8 @@ struct kfd_process_device {
>>   
>>   	/* Tracks queue reset status */
>>   	bool has_reset_queue;
>> +
>> +	u32 pasid;
>>   };
>>   
>>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
>> @@ -908,8 +910,6 @@ struct kfd_process {
>>   	/* We want to receive a notification when the mm_struct is destroyed */
>>   	struct mmu_notifier mmu_notifier;
>>   
>> -	u32 pasid;
>> -
>>   	/*
>>   	 * Array of kfd_process_device pointers,
>>   	 * one for each device the process is using.
>> @@ -970,7 +970,6 @@ struct kfd_process {
>>   	/* Kobj for our procfs */
>>   	struct kobject *kobj;
>>   	struct kobject *kobj_queues;
>> -	struct attribute attr_pasid;
>>   
>>   	/* Keep track cwsr init */
>>   	bool has_cwsr;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 6bab6fc6a35d..edc4f47061f5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -282,8 +282,8 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>>   	cu_cnt = 0;
>>   	proc = pdd->process;
>>   	if (pdd->qpd.queue_count == 0) {
>> -		pr_debug("Gpu-Id: %d has no active queues for process %d\n",
>> -			 dev->id, proc->pasid);
>> +		pr_debug("Gpu-Id: %d has no active queues for process pid %d\n",
>> +			 dev->id, (int)proc->lead_thread->pid);
>>   		return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
>>   	}
>>   
>> @@ -327,12 +327,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>>   			       char *buffer)
>>   {
>> -	if (strcmp(attr->name, "pasid") == 0) {
>> -		struct kfd_process *p = container_of(attr, struct kfd_process,
>> -						     attr_pasid);
>> -
>> -		return snprintf(buffer, PAGE_SIZE, "%d\n", p->pasid);
>> -	} else if (strncmp(attr->name, "vram_", 5) == 0) {
>> +	if (strncmp(attr->name, "vram_", 5) == 0) {
>>   		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>>   							      attr_vram);
>>   		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
>> @@ -887,9 +882,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>   			goto out;
>>   		}
>>   
>> -		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
>> -				      "pasid");
>> -
>>   		process->kobj_queues = kobject_create_and_add("queues",
>>   							process->kobj);
>>   		if (!process->kobj_queues)
>> @@ -1055,8 +1047,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>>   	for (i = 0; i < p->n_pdds; i++) {
>>   		struct kfd_process_device *pdd = p->pdds[i];
>>   
>> -		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
>> -				pdd->dev->id, p->pasid);
>> +		pr_debug("Releasing pdd (topology id %d, for pid 0x%0x)\n",
>> +			 pdd->dev->id, (int)p->lead_thread->pid);
>>   
>>   		kfd_process_device_destroy_cwsr_dgpu(pdd);
>>   		kfd_process_device_destroy_ib_mem(pdd);
>> @@ -1102,7 +1094,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>>   	if (!p->kobj)
>>   		return;
>>   
>> -	sysfs_remove_file(p->kobj, &p->attr_pasid);
>>   	kobject_del(p->kobj_queues);
>>   	kobject_put(p->kobj_queues);
>>   	p->kobj_queues = NULL;
>> @@ -1171,7 +1162,6 @@ static void kfd_process_wq_release(struct work_struct *work)
>>   
>>   	kfd_event_free_process(p);
>>   
>> -	kfd_pasid_free(p->pasid);
>>   	mutex_destroy(&p->mutex);
>>   
>>   	put_task_struct(p->lead_thread);
>> @@ -1524,12 +1514,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>>   	atomic_set(&process->debugged_process_count, 0);
>>   	sema_init(&process->runtime_enable_sema, 0);
>>   
>> -	process->pasid = kfd_pasid_alloc();
>> -	if (process->pasid == 0) {
>> -		err = -ENOSPC;
>> -		goto err_alloc_pasid;
>> -	}
>> -
>>   	err = pqm_init(&process->pqm, process);
>>   	if (err != 0)
>>   		goto err_process_pqm_init;
>> @@ -1583,8 +1567,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>>   err_init_apertures:
>>   	pqm_uninit(&process->pqm);
>>   err_process_pqm_init:
>> -	kfd_pasid_free(process->pasid);
>> -err_alloc_pasid:
>>   	kfd_event_free_process(process);
>>   err_event_init:
>>   	mutex_destroy(&process->mutex);
>> @@ -1723,7 +1705,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>>   	if (ret)
>>   		goto err_init_cwsr;
>>   
>> -	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, avm, p->pasid);
>> +	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, pdd, avm);
>>   	if (ret)
>>   		goto err_set_pasid;
>>   
>> @@ -1822,15 +1804,20 @@ struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
>>   {
>>   	struct kfd_process *p, *ret_p = NULL;
>>   	unsigned int temp;
>> +	int i;
>>   
>>   	int idx = srcu_read_lock(&kfd_processes_srcu);
>>   
>>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>> -		if (p->pasid == pasid) {
>> -			kref_get(&p->ref);
>> -			ret_p = p;
>> -			break;
>> +		for (i = 0; i < p->n_pdds; i++) {
>> +			if (p->pdds[i]->pasid == pasid) {
>> +				kref_get(&p->ref);
>> +				ret_p = p;
>> +				break;
>> +			}
> I think this won't work correctly. The same PASID can be used for different processes on different GPUs because each adev manages its own PASID->amdgpu_vm lookup table. So kfd_lookup_process_by_pasid needs a new parameter that identifies the GPU adev, and you should only compare pasids, if the adev matches.

I think it is the main concern here: the pasid used here is global in 
driver by amdgpu_pasid_alloc(16) at amdgpu_driver_open_kms.  Each time a 
render node(partition) got opened, a new pasid value is generated. Its 
lifetime is until render node got closed. A pdd just uses this pasid.  
And each adev has its own xarray which saves pasids for this adev.

Regards

Xiaogang

>
> Regards,
>    Felix
>
>>   		}
>> +		if (ret_p)
>> +			break;
>>   	}
>>   
>>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>> @@ -1991,7 +1978,7 @@ static void evict_process_worker(struct work_struct *work)
>>   	 */
>>   	p = container_of(dwork, struct kfd_process, eviction_work);
>>   
>> -	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
>> +	pr_debug("Started evicting process pid 0x%x\n", (int)p->lead_thread->pid);
>>   	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
>>   	if (!ret) {
>>   		/* If another thread already signaled the eviction fence,
>> @@ -2003,9 +1990,9 @@ static void evict_process_worker(struct work_struct *work)
>>   				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>>   			kfd_process_restore_queues(p);
>>   
>> -		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
>> +		pr_debug("Finished evicting process pid 0x%x\n", (int)p->lead_thread->pid);
>>   	} else
>> -		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
>> +		pr_err("Failed to evict queues of process pid 0x%x\n", (int)p->lead_thread->pid);
>>   }
>>   
>>   static int restore_process_helper(struct kfd_process *p)
>> @@ -2022,9 +2009,11 @@ static int restore_process_helper(struct kfd_process *p)
>>   
>>   	ret = kfd_process_restore_queues(p);
>>   	if (!ret)
>> -		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
>> +		pr_debug("Finished restoring process pid 0x%x\n",
>> +			 (int)p->lead_thread->pid);
>>   	else
>> -		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
>> +		pr_err("Failed to restore queues of process pid 0x%x\n",
>> +			(int)p->lead_thread->pid);
>>   
>>   	return ret;
>>   }
>> @@ -2041,7 +2030,7 @@ static void restore_process_worker(struct work_struct *work)
>>   	 * lifetime of this thread, kfd_process p will be valid
>>   	 */
>>   	p = container_of(dwork, struct kfd_process, restore_work);
>> -	pr_debug("Started restoring pasid 0x%x\n", p->pasid);
>> +	pr_debug("Started restoring process pasid 0x%x\n", (int)p->lead_thread->pid);
>>   
>>   	/* Setting last_restore_timestamp before successful restoration.
>>   	 * Otherwise this would have to be set by KGD (restore_process_bos)
>> @@ -2057,8 +2046,8 @@ static void restore_process_worker(struct work_struct *work)
>>   
>>   	ret = restore_process_helper(p);
>>   	if (ret) {
>> -		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
>> -			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
>> +		pr_debug("Failed to restore BOs of process pid 0x%x, retry after %d ms\n",
>> +			 (int)p->lead_thread->pid, PROCESS_BACK_OFF_TIME_MS);
>>   		if (mod_delayed_work(kfd_restore_wq, &p->restore_work,
>>   				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>>   			kfd_process_restore_queues(p);
>> @@ -2074,7 +2063,7 @@ void kfd_suspend_all_processes(void)
>>   	WARN(debug_evictions, "Evicting all processes");
>>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>   		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
>> -			pr_err("Failed to suspend process 0x%x\n", p->pasid);
>> +			pr_err("Failed to suspend process pid 0x%x\n", (int)p->lead_thread->pid);
>>   		signal_eviction_fence(p);
>>   	}
>>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>> @@ -2088,8 +2077,8 @@ int kfd_resume_all_processes(void)
>>   
>>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>   		if (restore_process_helper(p)) {
>> -			pr_err("Restore process %d failed during resume\n",
>> -			       p->pasid);
>> +			pr_err("Restore process pid %d failed during resume\n",
>> +			       (int)p->lead_thread->pid);
>>   			ret = -EFAULT;
>>   		}
>>   	}
>> @@ -2144,7 +2133,7 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
>>   	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
>>   	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
>>   							KFD_IRQ_FENCE_CLIENTID;
>> -	irq_drain_fence[3] = pdd->process->pasid;
>> +	irq_drain_fence[3] = pdd->pasid;
>>   
>>   	/*
>>   	 * For GFX 9.4.3, send the NodeId also in IH cookie DW[3]
>> @@ -2296,7 +2285,7 @@ int kfd_debugfs_mqds_by_process(struct seq_file *m, void *data)
>>   
>>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>   		seq_printf(m, "Process %d PASID 0x%x:\n",
>> -			   p->lead_thread->tgid, p->pasid);
>> +			   p->lead_thread->tgid, (int)p->lead_thread->pid);
>>   
>>   		mutex_lock(&p->mutex);
>>   		r = pqm_debugfs_mqds(m, &p->pqm);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index c76db22a1000..1f98c16e0fe9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -69,8 +69,8 @@ static int find_available_queue_slot(struct process_queue_manager *pqm,
>>   	pr_debug("The new slot id %lu\n", found);
>>   
>>   	if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
>> -		pr_info("Cannot open more queues for process with pasid 0x%x\n",
>> -				pqm->process->pasid);
>> +		pr_info("Cannot open more queues for process with pid 0x%x\n",
>> +			pqm->process->lead_thread->pid);
>>   		return -ENOMEM;
>>   	}
>>   
>> @@ -425,8 +425,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>   	}
>>   
>>   	if (retval != 0) {
>> -		pr_err("Pasid 0x%x DQM create queue type %d failed. ret %d\n",
>> -			pqm->process->pasid, type, retval);
>> +		pr_err("process pid 0x%x DQM create queue type %d failed. ret %d\n",
>> +			pqm->process->lead_thread->pid, type, retval);
>>   		goto err_create_queue;
>>   	}
>>   
>> @@ -520,7 +520,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>>   		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
>>   		if (retval) {
>>   			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
>> -				pqm->process->pasid,
>> +				pdd->pasid,
>>   				pqn->q->properties.queue_id, retval);
>>   			if (retval != -ETIME)
>>   				goto err_destroy_queue;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 3e2911895c74..4910cfcaff36 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -563,7 +563,8 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>>   	int r;
>>   
>>   	p = container_of(prange->svms, struct kfd_process, svms);
>> -	pr_debug("pasid: %x svms 0x%p [0x%lx 0x%lx]\n", p->pasid, prange->svms,
>> +	pr_debug("process pid: %x svms 0x%p [0x%lx 0x%lx]\n",
>> +		 (int)p->lead_thread->pid, prange->svms,
>>   		 prange->start, prange->last);
>>   
>>   	if (svm_range_validate_svm_bo(node, prange))
>> @@ -3232,7 +3233,8 @@ void svm_range_list_fini(struct kfd_process *p)
>>   	struct svm_range *prange;
>>   	struct svm_range *next;
>>   
>> -	pr_debug("pasid 0x%x svms 0x%p\n", p->pasid, &p->svms);
>> +	pr_debug("process pid 0x%x svms 0x%p\n", (int)p->lead_thread->pid,
>> +		 &p->svms);
>>   
>>   	cancel_delayed_work_sync(&p->svms.restore_work);
>>   
>> @@ -3255,7 +3257,8 @@ void svm_range_list_fini(struct kfd_process *p)
>>   
>>   	mutex_destroy(&p->svms.lock);
>>   
>> -	pr_debug("pasid 0x%x svms 0x%p done\n", p->pasid, &p->svms);
>> +	pr_debug("process pid 0x%x svms 0x%p done\n",
>> +		(int)p->lead_thread->pid, &p->svms);
>>   }
>>   
>>   int svm_range_list_init(struct kfd_process *p)
>> @@ -3618,8 +3621,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   	bool flush_tlb;
>>   	int r, ret = 0;
>>   
>> -	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
>> -		 p->pasid, &p->svms, start, start + size - 1, size);
>> +	pr_debug("process pid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
>> +		 (int)p->lead_thread->pid, &p->svms, start, start + size - 1, size);
>>   
>>   	r = svm_range_check_attr(p, nattr, attrs);
>>   	if (r)
>> @@ -3727,8 +3730,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   out:
>>   	mutex_unlock(&process_info->lock);
>>   
>> -	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
>> -		 &p->svms, start, start + size - 1, r);
>> +	pr_debug("process pid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n",
>> +		 (int)p->lead_thread->pid, &p->svms, start, start + size - 1, r);
>>   
>>   	return ret ? ret : r;
>>   }
