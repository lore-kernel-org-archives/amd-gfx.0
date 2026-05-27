Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF1ACD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 07:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0993E10E73B;
	Wed, 27 May 2026 07:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bUgLzCeE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011055.outbound.protection.outlook.com
 [40.93.194.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5923310E73B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 07:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YztSWjDZow8WulDVEr29WK1S2CEv2xSpJAghLYVbRVvQ+smB5nIZZEdTRCf4FnVi9xr66RE4e1TsjNVlPmr5xbwFidh6md4yvFBFyb4zB2zjz/dQBbwU7XYTDKNR35xNpSxkkBPfpcUTJUcZ5gsEkfnmZGJORZ/SV8CQd5uNQEGrRAGYF++QGXezpk4i/hwpH7mM56sYy5Iee9oCWYK1RaYvR2fO4Gci7VZVWVNsHDsF/sthRZKZOGesWW9fCYlSs4fzuenTvyWmo1dLyKDu9ug4xhfk6tTTuUKfqGu71x8njUpXbfQahi84UGFHRmYRAldDXfMkH/bG4s4EP/nhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHrfsxiEAftVPgfdbu5FxgfH6N8HPUn85K2cy4D9fhk=;
 b=PpMoPY4lMWCzqqs/RVyBePNtcn8cjZMjYZqlSKGPIqwF9Ql9VWK1aABVJNC91qNiuKLoT4R0Z/7vSarh8Cd/snsMH3xebFmQHbZGvNL9RDiTeDd+R/AHB/IBj41/hWYgUuzHUh6BoJaWtgaZncV8cijnayOhDBW67qSlakUaNJSFVh1BpcTgqPpJ6RlJynKdCu4UzG0jd07LjelCf7E3K6CpZl0Z5QciktTQ2IlOxxACLO68OCxOKg52shKR2F6oXiU6EYCeTk5XKiIyOC6aP6wqzMo6KVpPB7vYOoUZzJdVSia9XYLOeOTdc2nRHcdjiGw3/gNUvw3yWZcC2r71YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHrfsxiEAftVPgfdbu5FxgfH6N8HPUn85K2cy4D9fhk=;
 b=bUgLzCeEX49pYHksDgULgUuIeolRTC3xifDdR6vikGtz2OVuSCM+VuietJwtFAbD2hYdgbyoNS8ftORMUOME9K0Ca50PanVMS0tpgQ70i/5coVFDNme2gCZAQd8wxg7I84felgSEPx+h1YGXLryC5RSN7pmICian3HK8kVC9XS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF2CD49510F.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 07:58:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 07:58:43 +0000
Message-ID: <ca870fb4-1a61-4108-8e4a-94cdcf67efe0@amd.com>
Date: Wed, 27 May 2026 09:58:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: avoid extracting fence_drv_array for
 empty wait fences
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260526093210.55565-1-Prike.Liang@amd.com>
 <78e1b3d4-5e68-43f6-b82a-353fdcf22876@amd.com>
 <MN0PR12MB6004CE174D0E58CC6C3BC03DFB082@MN0PR12MB6004.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MN0PR12MB6004CE174D0E58CC6C3BC03DFB082@MN0PR12MB6004.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF2CD49510F:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d68d2b-d2b9-4ad3-35dd-08debbc5c5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: QULEZADRxfv1/4sLMdAXaZoGlb/CtqhI75ahWKHBsBKbXAoWioIgUiObK0DVoHIFgTOjJmGHcXDOB8QORNH+UhixH62IEXjOFoE3HBfvWSZlB1kadrnaiIiLREHmi0C02rxS8+gp+9mzB/1cXeJBYz4kW9vqMtXO6NZEynHYzGLjWGJRLQlvUZg9xw5+l4pMxqnpyl3fApDqVpP3w7hkktNnwTP7cgjJKegIimPkyOwaZgmWINeiDkEC1EL5kxGN8PpgYUX3cExNRoE+/DjHJQoTZIWY/CGEVGENGrmK5AIBhuJWD2ubcXm5TpkmYJ9l749eetyPthiFvvpzV9HchIQ9bGNU57LpsTgjnN7cE83MBJEvcCebDpLw7uTgLRhNCWXFNZm7WumF9czhiELkTb7qYlFU3sM5YN/+BSrAqsVSXikfp7AauRH5A6TiV6yp0Jzxdg4dfTWojCi34W3+C4JxNDBOXShT+Gph9WkXdAGpL2pSiE/0tGDFbLl6PfgfosBhC1vZqJK/jteMyxXF8Bh7eNV0xF4tUzRosSweMl1dCfki6vLwAtB93/HVc7UkQvItk1L+Yr5JVmNf8einDVp/WnzY5pSdNUT6iz96bW9Iy91bsy3JxFyCUp9HqAuxUDpsUiThCBn6pH9o0ZbqB/TwSsGDdvdKU0ulu7hVq+TqtrY/3A952oY0BwzFUrwJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJsYW9SOWhUOHNhNDlnWmEyM0VIMUd2bWhrL3NsUWVWL0xWUVhwd1lua3pM?=
 =?utf-8?B?U1hoaHd5T0ZrbEhuek9oVGZ3aGFnblpiYitZa1JETzlkZ1c5MDJTdHBZbi9I?=
 =?utf-8?B?SnZJOS9wTDdnOW1UV1d4WHB2VjNZeFdSZ2ZYTEhiSlgvVUVBTkRzYXlHRTZD?=
 =?utf-8?B?dTByYUloLzgwdnFpTWhpMnEzdXhSL2ZUZ0dhNXNhQTRKcFIzWmMrUFc1Ky9C?=
 =?utf-8?B?UFVyMTAxVWN0N1lVODNRT0tGa25UQ0dNdS8xMFoyM3JzSk5BMWkySVBCeDJV?=
 =?utf-8?B?ZXhKcHZLVEJTb2FwazZHVU5VK01qM1FVclZMMDBzbDg5QSsxUEFsYzFEblVn?=
 =?utf-8?B?OVdYWkpyTzl6LzBWTGM3TDF0UmZoUzhZWU90QlRYYi9YTThDbUlud1VvT1VT?=
 =?utf-8?B?MkNsRjhMZHZaM3VJQS9BRE5hMXVxTjIxdGs0ejNQczY4T3lKVnpoSGNYN3pF?=
 =?utf-8?B?OC9GdjhEaERFeE1Kb0ZNY0hod0J3Z0dmWEl2RnJvRW1pMDdhYnlLNGlkeS84?=
 =?utf-8?B?TUdaTXBvS1VkWGR3ZEVLTFNnZXRHSWU2dlIzd0Z5dXE2ZytLeVF2b2VacjVz?=
 =?utf-8?B?K0tDNzF4cHMxdURvQkhCcFgzS0tYcXIxc1ZJTElwRDgzSGMzdU12OWlraDRL?=
 =?utf-8?B?S3Brb1hKZ1lRZGJEZmdyeldteDA3TFR6T1dsb045aTZZZXlWUHNJRmM4OFpO?=
 =?utf-8?B?UjA2YjdTSUhqbWF5S0w5enYvSEpvUHYrOVNPc05VRXVDcHV0emFCNXpGNTBy?=
 =?utf-8?B?UjMxbjdvRmZnb3VaU05sOGI1Rk1kSzJpaVVTeVRqYkFVbHNKR2JLTEJpbHh4?=
 =?utf-8?B?b0FCS21SQmR1KzRST0UwcjBLblJTRmlhVVdlei9oY1NEQkhMd0RHc0ptYm5T?=
 =?utf-8?B?Tkdpbk9vRUZjb2lpRG1SWm9YZzdTaE9XUzBzTWJMSCtLLzRONjVIY0l1Wk5t?=
 =?utf-8?B?dmQ2d04zM3RRNWxzMzlqUEh5K3hXeU1qamtPcUJNVHgrMVVBZjZXUS9vcWdF?=
 =?utf-8?B?MVoySWdnZHZneVZ5WG91blpYZERpYWtvUVBlYWVlcGFhUUhYQ1hDT2tTTXNz?=
 =?utf-8?B?Ukl3Y0lwYVVRUEVmVWFTQzFPdSszVEsvdVYwZ1NQaGlVR0tYZUh4T3E4QkJG?=
 =?utf-8?B?Y2xNSTdobVh5bEFpcnhaTk5lTVBrdmtVcXRKd1ZFRVZNQlFRUEVRUHZncllz?=
 =?utf-8?B?OW10dDlJdEUwSHdkdGF2NERxOFcyRTUxV24rRVRTMzZiKzdrZ1hKRnJ5QmM2?=
 =?utf-8?B?S09mKzk5QkRDQzRJd0UzN044dU9EcUZLRmdVMHhlNWlqRTVRK1VGVitSUkJF?=
 =?utf-8?B?UHlHRUw2a2hkSzM5UjV5bmxUYTdMMWhqbHlJRTg2V0twc0Ixd1VxbzcyTytQ?=
 =?utf-8?B?Ny92MnRvUHNrUWZraFVDM3Mwcmllb0tRRHJVMWM5emVOMEsyQkFKdVg0Q2pR?=
 =?utf-8?B?NnJnemp2bDNZQVY2bFI1Nm96SjloMmI3eEpoVS8vZklNWHlZVEZudVZzVWQ3?=
 =?utf-8?B?cUlnWjMxK1Nhcnl0aXhjYmcxUWltUi91VHp1aVhWaWFCQmlZRWZMOVVjNGlV?=
 =?utf-8?B?YnZqRzY1MVVqcG9xaFdjVnJmVUkvcmV6S0lIeEFJcVFjYmFpN05qNzJkMGdT?=
 =?utf-8?B?WTRMOWpOQWlrbG9oeFZaOUhmdUsvUXE0aE1DcVNnT0RDVUE0Mklid1U2bDJZ?=
 =?utf-8?B?S0N2TCsyLzJlZVJOdWVqYklCNWxNUll3djllTDJLYk04MjRQd3ExRkM3dElP?=
 =?utf-8?B?RU1hdVFOWnBqRVZGbUE0d2ZhaDZ4eTJrK0JmNUsyQ2VZWnBNbHAvTlF6S0Zp?=
 =?utf-8?B?ZnYwSzczVDJGeHdXTDZ3UGJ4TDV3MWlPeVYwRXhlRjJqN1kvTVZlZ25DZWhD?=
 =?utf-8?B?cGtrREZnNWJrcFR0WFBqZFdEQ3JoUFJqcmpDazM4T0xKQWlDOWprcmhLS3VS?=
 =?utf-8?B?THNhd1Q4bWYveDVTMXdRTGRSS1hoVGliQ0ZRa0VNeForcDlEL0Y2MkJBTVdR?=
 =?utf-8?B?UGwxUHFrc2drazl4djBBZ1NlSXNnV01KNmFVaXZSQWhPaUpJbm9BMzgyL0lC?=
 =?utf-8?B?ejhNaFgyRTlWMnFDVXI2eGJ6OUx5d1RWKzBzdUttN1pMdFNqSVlMb0ZuTU9x?=
 =?utf-8?B?NlJWdEV4ZmJacHdYWHY3MVppMStKTjc1SnZZZDJuS3dWV0NGcHNkbzExOXEr?=
 =?utf-8?B?a21ERTFTTmRhcGFiYU1wN1Z1bzM5Z1NBbjF3QmRzaWMrOFdMdWJuK3Z5RFlU?=
 =?utf-8?B?K1p3S0hsd0s3N3BiNGFXdGdPcVdMNlQ4eHR0QlByWDhKOGdHaUx0SnN1cDBl?=
 =?utf-8?Q?+gvnBH4+MVXhSlrSzL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d68d2b-d2b9-4ad3-35dd-08debbc5c5be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:58:43.5416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2jvN3HlfLzFyjL4TGvvOxWC4+JceguXRtzobP1hhJerQNCYTjH/7ujv2g9jOKxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F
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



On 5/27/26 09:55, Liang, Prike wrote:
> AMD General
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, May 26, 2026 6:48 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 1/3] drm/amdgpu: avoid extracting fence_drv_array for empty
>> wait fences
>>
>>
>>
>> On 5/26/26 11:32, Prike Liang wrote:
>>> Avoid xarray extraction and temporary array allocation in
>>> amdgpu_userq_fence_alloc() when there are no pending wait-side fence
>>> driver references. This keeps the common fence emit path cheaper and
>>> efficient.
>>
>> That's an absolute corner case we clearly don't need to optimize for.
>>
>> In almost all cases we should have at least one remote fence driver here.
> 
> When only the desktop compositor is running, there're many no-wait fences are generated while emitting userq fences.

That sounds like a bug to me. In almost all cases we should have always at least one wait fence in here.

Otherwise the synchronization between X/Wayland and rendering client isn't working properly.

Can you investigate why we don't have a fence dependency here?

What could be is that we filter out that dependency in the wait IOCTL because it is already signaled.

Regards,
Christian.

> Repeatedly attempting to extract the wait fence array takes more than 10µs (with a maximum cost of around 30µs). Additionally, zero-initializing the userq fence allocation can help reduce overhead in the userq fence put routine.
> 
> This patch can return a userq fence driver even when falling back from an empty fence_drv_xa, benefiting on reducing the latency of userq fence driver extraction and free operations when there is no pending wait-side fence.
> 
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 008330a0d852..2a2bf13a513d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -226,7 +226,7 @@ static int amdgpu_userq_fence_alloc(struct
>> amdgpu_usermode_queue *userq,
>>>     struct amdgpu_userq_fence *userq_fence;
>>>     void *entry;
>>>
>>> -   userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
>>> +   userq_fence = kzalloc(sizeof(*userq_fence), GFP_KERNEL);
>>>     if (!userq_fence)
>>>             return -ENOMEM;
>>>
>>> @@ -235,6 +235,8 @@ static int amdgpu_userq_fence_alloc(struct
>> amdgpu_usermode_queue *userq,
>>>      * used as size to allocate the array.
>>>      */
>>>     mutex_lock(&userq->fence_drv_lock);
>>> +   if (xa_empty(&userq->fence_drv_xa))
>>> +           goto unlock;
>>>     XA_STATE(xas, &userq->fence_drv_xa, 0);
>>>
>>>     rcu_read_lock();
>>> @@ -256,7 +258,7 @@ static int amdgpu_userq_fence_alloc(struct
>> amdgpu_usermode_queue *userq,
>>>     xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
>>>                0, ULONG_MAX, xas.xa_index, XA_PRESENT);
>>>     xa_destroy(&userq->fence_drv_xa);
>>> -
>>> +unlock:
>>>     mutex_unlock(&userq->fence_drv_lock);
>>>
>>>     amdgpu_userq_fence_driver_get(fence_drv);
> 

