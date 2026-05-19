Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DBFCD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644A710E50B;
	Tue, 19 May 2026 13:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDDSBuzi";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2FA10E50B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq3u3nQq0Es5S2EDSOmAfY0rwVqUfjOondRohpuxP0ejobmwxcscO/wtNmFAltkbxhWVooFffWRBTreqA4IQzm1Nsdyuiz3hFTX7dAbf45GCLCBVmT0Dll26Y1sBS+9eAubKlybwVzFj3iwn/SWuDGrM6CKymYzcalPDMrgdt9bOieUHNI0JNuVRye2NWj8hxoGWsWse0VoiApXKhhkVQkaP2jWJLxz6+d0JCEghgjIlD1H6VWbomgFTE2LWQkpTlZ5WAawzUsdn2mi/xI+N5FS+ipK4EOL7v7C92apSOE2KSVq6wnNI4jnEHYFMuiQtWblpgm5XmvAxKmyUZkdM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdoElBG5TxgJuspW86G7/Q68NkderqMXNZ/Metp8c34=;
 b=VRIkPp6ly1LHVTqXXL4P4adaggd4T89a/gXHjC/lBWXvloJNxT1zXayBqdSPBMogn6ZVTicWduOXkWrZ4JQ7FDc68bEHOhS642CfCCCabZqNuIwkceT1peRIcoOI10wyAwo7yHABoxg7ouVqFpaxedikJUGquQ0KNbO/4zKX/5tAQ1VlD8KD0QhNxWGwEAs+kFQGgtXxdgp9uQjRyaqcpPUmD0vTzCcUlfrOIqX7/ScC5+EVonQeZj+myXNYxPGgyjyF+sdcdwDTjSCjJ/dPJaGQHnB3nrsrUpOM82nG7z00GzAvBuDeZcgn9z5iSkqZVlxIniSfUqrnzvF7+0D0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdoElBG5TxgJuspW86G7/Q68NkderqMXNZ/Metp8c34=;
 b=kDDSBuzi5UG5Z9ujvkK79E3JxYy6+CX5e8FxqYO36U1fjpAa3+sj1WL3r2WpPvkg1O9uWI8RGJHOLT7bToZmi4/KFfxUuOjfMC6L0R5U0Oo24FRTtBECuuyoh4PRk0LO4e5nbnpz/cLx5r66eiMlzNIxyeRZj7JH9Lp+hS2wddU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::992) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 19 May
 2026 13:53:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 13:53:10 +0000
Message-ID: <37f7cb2f-4ddf-45da-9c51-9100c9155302@amd.com>
Date: Tue, 19 May 2026 15:52:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] drm/amdgpu/userq: Fix the mutex_init cleanup for
 fence_drv_lock
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
 <20260519111801.1435954-2-sunil.khatri@amd.com>
 <316ff7e5-b665-4a40-9a8e-f1f5ea07f794@amd.com>
 <db639edc-0b5e-4165-9363-43c265a75839@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <db639edc-0b5e-4165-9363-43c265a75839@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5a88a7-fcf7-4788-7347-08deb5adf69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: X1zlP4SK3Z9cEV2yJgl01M+rns0cykoOLBhqWNWuy6QAwir4/x/YsHMfnZl55UrkSA7fhwxqB7WQJOnbn+N3I2aXkxV65vGK9asQ/I5WaF0W+zhjHprcFUbOTtCTo+CGR3lT64O8wOFAG3MiLTdFdljVwVeCvkXdAxJ1a7UXPkckkEqm2kxedIsHJF44BmATQ5T17XUE/Z7U6Axe+19AO4hokjLU/yEC1UP6xx3uhTtppO+AFdqqW/pMsU7LTIpSbNvobdAfvwiyQnhNYn69ogaTDxlg6XABrTV+8qBYXPXTBRKzeA+NtHbuns0A8MC/7OkSCJaP8eEcnWkxQjPI3TbSv7lhSSUVIGd8P681uPudCy4NrjI0Dn9mWC7pnpSDyRdaNpCef+TrKbXnUiayuZG+N8qrAWYC0ekKo3al9dTZPCqNuMPV54soP/1qv5NTdAQULc+z/khodGFpsEFqdJYrm96+N71hGUWoYg1diUxV1NFiXzVPnE2HP95GnIeshcyhIcjuArCsIq913R5mH92O1Pe7SNUrEGQXby40f5Mpl614bwmWtIEvg59rfRN8PIDo1wWpZ5/DQRo9mpHa9og9Oxxikrb/kUzG9RFh1DhMwItoaCwBRrZOiz079R259gGzmqlfwckhEXv4P8ahxA9j72JTauwy3BLaH6dWg7sg1hSVFP/3Fk1mmlShksyn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVVuQ015cTdvYWl1UGg5QW1UQjgwbUV1bnozR0VlYytVNE1xR2YrYndZdzls?=
 =?utf-8?B?cnBmYkVMYjBwMmp5YXBla3BLTFdEZmlFYnIrSTVpWGhXMXNJcEJLOTMxMWdh?=
 =?utf-8?B?VitYUDFvanVqdVh6VHg3TXd0VDR3MEREQ2pJUHRBQjVjRVZWUkJzbUF0a1cw?=
 =?utf-8?B?eFNnaVFzU2NNVkNGZU55ZC9iNFlkNmJCaFFKeEhWQzhIQUZnbFdPTnUzanhQ?=
 =?utf-8?B?ZFU1VmVabVErK0UrT2RjS3Q3alNNczNwYzFUWS8weWxVVDc2ZCtCR2hHM09F?=
 =?utf-8?B?M0V3RFNydzB6WTlXTmhOV1RnaThjZjBMY296SVdyZy9TSndYcDFVd3Z0RGh2?=
 =?utf-8?B?d1kvSGNCYUI5UE9WVGFLS3o2aVNBZWpEbE5KSGxhL2pXS0tiVjRDdWhCSDN5?=
 =?utf-8?B?cSszUm02VGpETmdHVnczTjRsQmtJMzU4VzBsUnliVjNsZFBCSDdGWU92RUhm?=
 =?utf-8?B?cDIyejV6ejg5MGx1TVZxNVRta09SVk1jbyt0Q0tnemt3aVoxOXdTaTNONmdQ?=
 =?utf-8?B?akltWXNTTWtKMEFkWlk3MHZMNDJQRzdMSWljNTFnWGJwT2xtNFBuWUlRSXlN?=
 =?utf-8?B?VGliNGtFQzhtWElqTDFRTjJiTEVzZHUxYnBCNC9SQ2hPTU9DWEhpeGV6dlN5?=
 =?utf-8?B?TnhkQ3VEZjUvZ28rb2tUSXVteUdRT1RwTkN3RW5yLy9pOFl4ODhxeG1nSVlK?=
 =?utf-8?B?MTZhWjNOdUY4NFFRaXlJaWFFZG9VTkVtOUhPRE9xTGY1dXd3YmRMeGRVeWFp?=
 =?utf-8?B?UGMveXQ3ek9LZUVaVDNYTG5KWEJ6b1dzVWpKd2ZPTHhBUWdlRkd3OFVZNE9x?=
 =?utf-8?B?a1VTSEhtYmxxcGtpWTJGYjU3YTIvek5ZdDlmME9PMVkxVUhkOW5ZS3hrM280?=
 =?utf-8?B?MXZkRUtvV201Slh6OWNMalRFZ2ZLb3ZKWDB0Q200UWlKL0hFWnBxOW85RzNn?=
 =?utf-8?B?VGc2WEhkSVVpYWZDd2w2UExDdXBRTGEzbVYyYkdDUGZBeVNCbnFLREhBZDha?=
 =?utf-8?B?bTQ2eldTSlVOaVRSTCtIR3pBVG8wWkQ4VFFmdWt2WkdUMEdtaEVkRWhGazMv?=
 =?utf-8?B?Z2NzY1Z0cGNiUEcwWGVJbVFUdWRnTFB0OWNaTU1YdlhZc0NXU08xKzVJdjR4?=
 =?utf-8?B?Q3BUR1llQkY4MHYrU29xWSszR0JEdThUREQyc0lndFNnWEZlOVE0TFdqT21J?=
 =?utf-8?B?T1JYOHlYZXM1cHU4LzY1N0VnRjVPWHJoSjk4bWltckpGVDBlNU9DSU5OQW1M?=
 =?utf-8?B?cFM3OWs3SHBFSFZDSWJIL1BwUjNlTkNTTStVSjRncGxNbG5YRHNVSkNkWmhw?=
 =?utf-8?B?VEt3NFhMem1manZQMHNxTFIwTFczWUl2dENBdFA1NEVBWXByTVBIekhxZzJk?=
 =?utf-8?B?ejh6Vm1wMmhYb0RSK3hJZ0hTZXpGWDZSSnhpYnZNQThjQVJwc0Y2Qy9xenJ2?=
 =?utf-8?B?bklCdUpLRThMV25yempGNy9DMmE1MUJGdFpOTzc5WXhXQlUvZ0tDWjdYYXUx?=
 =?utf-8?B?c2E4N0U2MXpDWlkva2xjSWNCaFJEMEpvaHJiaUdvT29CN21xdjdpVStlcTlH?=
 =?utf-8?B?ME1hU0ZRNk55bmVoaXVTWktVODh3L2VPMnZFR1FtU2Z4dFpvc1B0REFUL0Yz?=
 =?utf-8?B?NnNaUE11TVFTVG1icy80akJGWUZFQ3IvSXo1NXdzOXlCT0UvYyt5UWVnQ2lk?=
 =?utf-8?B?QWRCT0ZmUlhDQys1elhBUDJQN0cwNmNwU21yZ29EOEs1aXNnWXB2YVV5QWdx?=
 =?utf-8?B?MU56bkEyVFpoWWc4U0lrT2M0b0x6RUFkVDlmR0tZRmw2Q2gzcnl6UjIyQyt2?=
 =?utf-8?B?WCt5NEZGV1VidEZYQm1pRDM0TUp3MTFWcG1ISTFxLzFBMUplWjRkZmVQRlAz?=
 =?utf-8?B?U3A2UWhyNDU2L2ZlOW9Oc2lzOU1PdTd4NVNsMVZ5RW5WZ1ZNY3d6Z0ppTXhy?=
 =?utf-8?B?UXZRaWR0R041VURVNTNzRlVaYnFIUitBT3l4S2wyVkhwYzJHaWVWaHZzRGlR?=
 =?utf-8?B?REdpSkkyZlQ5YXhEd1g5dWxBcWE3aE4yWFgzNis2Q2poQ24ydzFjbmIweThv?=
 =?utf-8?B?WFRzUnpRcW1RZkVVMVRldzJkR2Y5cWppNGFyeExtTDJIRldPQVZNc1o0VWJv?=
 =?utf-8?B?UnpFZTNoMXNKRVRwOUFmR0p1VEVWSWljWGJMSmdSbXRRRk5EdTczZDgyNTJK?=
 =?utf-8?B?Q1c1bFRRTUEweUxoMGlqeDRFNlNKVi9LNVZmQkZVZjBSSVVDdzdLOWhDbHNR?=
 =?utf-8?B?K2oxK0RzTnpFZHpXQzlvcCt5V3FtdzEvclNUS0o0alNXU01vdEhQTnJwYTcx?=
 =?utf-8?Q?vvatmo2gQd9m3vR//g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5a88a7-fcf7-4788-7347-08deb5adf69f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:53:10.7172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sspS79kPh/j6r6nAj6HbD557S/OYiSUzUfiN8rSj2Q19a35o+ac3gKNYIoOcBLBr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9
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



On 5/19/26 15:09, Khatri, Sunil wrote:
> 
> On 19-05-2026 06:08 pm, Christian König wrote:
>> On 5/19/26 13:17, Sunil Khatri wrote:
>>> mutex fence_drv_lock is destroyed in amdgpu_userq_fence_driver_free
>>> also in one of the jump condition mutex_destroy is also called leading
>>> to double mutex_destroy.
>>>
>>> So rearranging the code so amdgpu_userq_fence_driver_free takes care
>>> of the clean up along with mutex_destroy.
>> Please also move amdgpu_userq_fence_driver_free() into amdgpu_userq.c or eventually completely drop it.
>>
>> The cleanup done in there is actually on the queue and not the fence driver
> 
> There is no clear demarcation here, we are doing amdgpu_userq_walk_and_drop_fence_drv and amdgpu_userq_fence_driver_put in the clean up function.  If it's ok we could pick that up later for code
> 
> organization as its mixed use case right now and all the function called from clean up also needs to be pulled in.

Yeah all of that looks pretty mixed up. Maybe we should move the handling more into amdgpu_userq_fence.c, I don't really know what would be cleaner.

Anyway Reviewed-by: Christian König <christian.koenig@amd.com> for this patch at the moment since it is clearly fixing a bug.

Thanks,
Christian.

> 
> Regards
> Sunil Khatri
> 
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index eedea84c5e0f..3bfb9ae2cb3a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -748,12 +748,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>       INIT_DELAYED_WORK(&queue->hang_detect_work,
>>>                 amdgpu_userq_hang_detect_work);
>>>   -    mutex_init(&queue->fence_drv_lock);
>>> -    xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>>>       r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>>>       if (r)
>>>           goto free_queue;
>>>   +    xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>>> +    mutex_init(&queue->fence_drv_lock);
>>>       /* Make sure the queue can actually run with those virtual addresses. */
>>>       r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
>>>       if (r)
>>> @@ -844,7 +844,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>       amdgpu_bo_reserve(fpriv->vm.root.bo, true);
>>>       amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>>>       amdgpu_bo_unreserve(fpriv->vm.root.bo);
>>> -    mutex_destroy(&queue->fence_drv_lock);
>>>   free_fence_drv:
>>>       amdgpu_userq_fence_driver_free(queue);
>>>   free_queue:

