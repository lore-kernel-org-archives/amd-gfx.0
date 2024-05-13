Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8684AC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 15:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFF410E426;
	Mon, 13 May 2024 15:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u5dYg60P";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E6B10E426
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 15:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXJfvmNy2i251Sk7gjyHEdNZhIMlS4nWFHJIaYv2kyuk20rS5kcGJz720LzSHxUnP12PiPaWURq1eU85DMxpbNg0kkAN4pomS/eZcOkWt4rAnPPxsTfvZsvlawFSc5ZKFlllzL6Kt2+v9yopTYits5OWwznukWenhZONWvhAVaQGVp/6cr3VMrYKLQpt1mWzCxxr1IlvVc1++E9nIIc7slOKDtyF/ymQmsZG9w8VQhr/ciFjD5O+m6NqtPOKUKpOH6D/M7+Dl4aBuJWeb1+KoQa6DPfM+FWjFIa3oRi7/jYkL+PyB1hlV6rS7OdHX5W7iTim97iYA66f1UU83Dl8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL8ZPtsg4xDuJ4Oh3OuDceo7gh1QSvGJR5aM0jAIsDE=;
 b=aEdcI4yoO0LvPdkdHtkeS6tdWdERmcA1epTVDh4KrBQjPrOtPzA4oNp4SW8oJ+nNyTnzHt/gKD3iG2977IB7twuGXr4Mvfdehd1EFiKBNYcypnwrAe3SrfTshNiZPt0d8hnblhixw+ufumub3dTDdkcTHqmctcb+vq9PUBzWjSoEXN4MoknRUxCVh8hk+f6qnDyXXMnjxcmZdeASNdlOOgkzS5Qi9NI655rtGNuCUnxJIoK3AXqf3oBQgEhUez6Fuwn+EHEI2236xZETxX/Tmj/tOu8o+K7eT82rLeGQEY0+QQ+1q3SXcI+Qg05Tv+RzzG/O0l1JGU802g8xMRlD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL8ZPtsg4xDuJ4Oh3OuDceo7gh1QSvGJR5aM0jAIsDE=;
 b=u5dYg60PAktaiYb6IeV05Usxk46KF508s5C/6nljs6hDB5msLcbQDEOuraOdiEHefUvoJDW5T8/3ewzEbCBAruPG/zAzE8uVvts0OMvVTFOQVLW4vTj/jXgfrUDGSkrlG3Ux6v04FiIVp54I+E48nFxcH6iBJ0U+zHv7acojWvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 15:53:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 15:53:05 +0000
Message-ID: <f4e34956-a143-46f3-b01f-98accd0e74a4@amd.com>
Date: Mon, 13 May 2024 17:53:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/6] drm/amdgpu: Remove the MES self test
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
 <20240510085046.2718-5-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240510085046.2718-5-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 529b63a7-91a9-40a5-732a-08dc7364c73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVR4b3FacFF4enZvdndYMXcyMGpvbGxlN3JhUSs1dGNZM0NMazlLajdDdmVT?=
 =?utf-8?B?aWpXUWpQYzZlMlZ6R1RvVHZWd0QrR0ZxTVJpQmZxaW9NZWZwZ0FrRTFSMjRD?=
 =?utf-8?B?djdOTHBCQXRaOFQrZjNmVThjUk5ZUjdFMnNqVlhYUmNxd2R6MlcyZlp5dVdw?=
 =?utf-8?B?dnVJMFU1VC9nSUZjenRTd2dobFpCVHc4ZU8raElSdkUrUGU2WkdnU21lMjRO?=
 =?utf-8?B?VGFaMWV5dnNsWjFnd2Njbjd3Q3cxdy9vZTFHSXl0b2w5c055T0lNb0l3YVNa?=
 =?utf-8?B?blpjSjFHd1RVVjdGaElORWxCKzJzZy81MWVBYlcrRXphcDRibTlIanA4YkhI?=
 =?utf-8?B?MzI2eXA3RENqbmJoTGo5ME14YmN4U21xaWo5cDQrUEE2TkgvbTZ4bnI1SkNk?=
 =?utf-8?B?OFU1c0V6clpOV0R4UlMxVHFMUk84b1VXZ0xCNWFhLzREQTI1K0g4azl2d0Zr?=
 =?utf-8?B?N29HcGRMM0pRZFUzQXY5ZUxnMHB2M0J3eEgvZHRGOEs5MGZvNGxINXh2Y0ha?=
 =?utf-8?B?Ui81OG5ERTQyT2dXL1d2cTZYTS9MZjZacDQvU3ExRXVpRVgxbktEd2JabzB0?=
 =?utf-8?B?M0ZMM096cnpwUFVnVldlTDI5am4rTnhEY2JCSFA2S3J1OXJjVTlyRjNpZ0pM?=
 =?utf-8?B?VFMwTFhVKzRobzFzTVJqY2ZnTnFvb2FFKzVveTZsd0pob3NIbGdmRVRJY1J4?=
 =?utf-8?B?WnlkRkpTbGIyeGRLUm9IQ0xNbDhGS1JjZ0x3dUhIejd0d0FJRHZOanpWcU5Y?=
 =?utf-8?B?YXZheWdVajA0RllmZ0JMbkJEMEhUMkRaTk1LUGtGeVhjUG5zdjlETlZKeE91?=
 =?utf-8?B?M2dlOGVjbWZUQlhaZ0VYcURFZHJwVEZaMXVGbnEzZ05PSDRNSEREL3JLT1Jw?=
 =?utf-8?B?a2YxaitpeTZxNG4zbHdhSnI4cFl3QUVkbTFJMFZqNG43S1hGb3RFSndXckNa?=
 =?utf-8?B?Qmw0emdOcThwRFFXb2EvMWtTTlNYbWZiWVYwMDA4OW9HUVlKWldnUHVBL2Q0?=
 =?utf-8?B?SmlDajRBZmxyaUppclFaV1NvRUxDRlBsSmkySmdCV2Z5QXUxemllZlcyQWpZ?=
 =?utf-8?B?K2NLRUYvNFZ5QWJwWklldC8wLzhFTmZQYXpSNTVrVEdsM0htaVh1Z3ZGMDVY?=
 =?utf-8?B?MmRMSTBFdVhSL29GdEswY1liQW9BNDkzK0NsdTNEMnBsRllQM2JCcWZnYjlu?=
 =?utf-8?B?YVlDWDR2MkFSTTJIbkV1YUVKT3ZBeEpzWHU5NWZhdFYzWHdCOUZGRnJoejZy?=
 =?utf-8?B?N1hiaGxaN1puTlVacmhjMmFzYnF1bFB6dFZvdUpVNlNxU2R4ZS8rdzdteXNq?=
 =?utf-8?B?ZXZUUTU4M2FaTjNLVG8yd3hMK281ZDMwTXF2Q21hSDNXRXJiK2FBcUlOL0hI?=
 =?utf-8?B?SDl3dmtpcks3aFNlUGI2Y1ZnSHd2YVNLeUhTL3ZOcGtaWFZUeFV1U3ZLK0JK?=
 =?utf-8?B?SEtPeThFRU5aQVVWYnJvMThsY3Q2T0pvcTg2Qnh5ZGdlQWxjdmsrNXJVOVN5?=
 =?utf-8?B?bHR6QjJST2pyVVU5SjdHaVdQR2VuVWx6MjFOSWRiV2xUbUlTVTBOZ2tCM1FT?=
 =?utf-8?B?VkF0dkh6a1dIOCs2NXByUDlRMFR6VjViVXNXRWMwRHRCcnl3dXhuMmlIZDFm?=
 =?utf-8?B?cVp6NnlUT0JzRnRpN01xMFNZM1dXWkJyYjB0RTF5bmFCQkRMZER4VFoxOFd5?=
 =?utf-8?B?NldVRWNaTVpNM1RyRlVUUjVQV2RpVU9vdXA3eDJKOFI1UDdLdkZFcCtnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bERuelFmQWVaK1dUaExlVW9vTWRBWUdwWHZvcTdLMUMrOEhOeTI2UjFxQUxI?=
 =?utf-8?B?NnA1YWs3ZXg2T2VkOUZYYXZYcm9kQzZ1ZXdqTHRBSXNYSXRsU3llTy91ZERB?=
 =?utf-8?B?cTZIQTI2NXRlRUsvTnpqR0RGckhaMC91amdaWHpIZHN5ZXVmN0l3am0zVzNH?=
 =?utf-8?B?R2ppVSt4OHhXZURHNzI0SC9uKzNDMklUaDIyMjdaMVBPMHhkY2FnQm1FUFgv?=
 =?utf-8?B?UVl1SWtDekZuNWg1eERVN2N5TFFCZlRndjRKUitGRFpiQXh5WTNQWDZKc2Y4?=
 =?utf-8?B?cTFwT1RsL29rU1AvMGNQRE1WV01WdjBMUG9hV0x1V2xHMmNyVGdNZDlQVVQ2?=
 =?utf-8?B?YmsyRWswM1o5QWJFVDFLRmpHdHBheUpQcHp0UmtpS1dJMGVhc2ZqR3pEWlAr?=
 =?utf-8?B?MmVoc1k5OGw0OU9Sa1JxNkN0WUtrMGtqVDU4ZHhaZ0s4MjdGNEVrelZVMWZQ?=
 =?utf-8?B?ejZkR1BKVjNMcXcvTWttbkpsb1gzR25YS0UzNUdVcFk5TmRoTHRiYU5HQ2hh?=
 =?utf-8?B?V2p1LytMcHFRQ1FSTzJkaDNFQ2lGLzVaQTgxV2c5aGtTWXRCazY0ckFtMUVU?=
 =?utf-8?B?R25UWG91TnUwOThVLzRiRmhWeUhOdkE4SkhtcFNrUkpHbk54N0xzdmgwQlpi?=
 =?utf-8?B?djRPWnJEdHBwSDc4NWdDRTIxeWUrUHlmeXBPMTJTc01DbysyanFEZkxISEk5?=
 =?utf-8?B?VENucFB4RURBR1ZPeUNOVTRKREF6dldUbkg0c0JUd04yOURGQmh3SWdkNzRM?=
 =?utf-8?B?bFhGcGY1Q1VDY2doajF4aWsrbktKVFpXMmNqbHVHa1gwbDZFNEh0anoyRzgz?=
 =?utf-8?B?WW8wbm51VHd1ejllLzhDM3J0UDRmS2tjZFZiWEtYYnhVR3VxcFdnTlg3OE9n?=
 =?utf-8?B?YUJqTWRJbTNjNFVBZTJ0S0xBNXVxZ0tLLzIvRUo0TlFUaFdFb1IxT2Vjbk12?=
 =?utf-8?B?enVFYlRtZWpuOERBYWs0cS94UGlSMityb2hyMVBObTRybTJTRDZpM1l6UnhB?=
 =?utf-8?B?M2YyMmVVdnhKM0hyWUxsbmdNTjc1STVMTDdHZ1k1Rm5LV0VvR0xGU1B5eW9l?=
 =?utf-8?B?ZzdtaUZuMy8rcXA5cHFjWCtCUWdqSnJ6aTFRa2hqWHpjMk5pR0ZhaG1UQnZs?=
 =?utf-8?B?RHhBMFI5eDMvajZPNHJ5UG5RZmJHQnFsRUQzMmtaWjFsaWJ6OHVHOWxGZ1d1?=
 =?utf-8?B?M0JZcWVoRis1OCtxdHNsYjZFZTBuVjdXQlRPbUdWbkIwczhpSjQ0YXFvRjNS?=
 =?utf-8?B?dDJtV2FKUDZzRlc3MGpzaVRpck1YNVcyTUdQSXB3U3ZEVjNSOVdOMTkzWEtS?=
 =?utf-8?B?TlhpdUdUdmNidW0zMHkrVi9kUE9jWTRBRjR0ejR2L2doOEEzRW53Umg5c1l0?=
 =?utf-8?B?YzBzMFpHcklIMkpqZXdnUzRYdTFxckNZUm5ZYlAxSm04SENwaTFMV05oY3lW?=
 =?utf-8?B?Z1lmSklZdHYrYWhsa21JWTFEQVdQS3F3T3c4cm9lUldBaTJKQnlaT1ZZSVVv?=
 =?utf-8?B?aWpBQXI1T2k2WGZPKzA0VmlQdFo3QUVvWFlONlgwRjJrL2diMzc2MnI5aHRT?=
 =?utf-8?B?MUlJanNCdUhVRGc2WXlkaGdIMXFUZ0tNZjFLZkpEVmkzaUZ5Q09vNXpFZ3Vn?=
 =?utf-8?B?TEpUcTBqdk1RSmM5QUFKSUJqQ3k2eFFnUWtJQzdmZlhVWTQ1YS9aeFM3bzMx?=
 =?utf-8?B?YmxKVTY5NnhocnVoSlhwVE43dU81dkZ3eHlqWEhIU0VTek43QWxjVDFkb1pM?=
 =?utf-8?B?ZURBQ2xSSHdRcGdZenFWcU5QUzJYNElNZXQ4VHh2WVJZSi9GbnpLL3Z4Qmkr?=
 =?utf-8?B?aXo5QXJOZVpzM1k2d0YvMHpFV0d5RUV0SkptN3ZJd3IrZzhldlBNWUVLbENV?=
 =?utf-8?B?Z2lvcWs1cTE4RVhKS0RROWx2Um9JK1pSZEZ6MFdWbkY5TXY4TWJ0RVozR2ZD?=
 =?utf-8?B?ck9hbFdxbDE5WnU4bEtBMjlOTHNMd1FKQ2poMENuTzYwSTR5ZHlmM08xWUhD?=
 =?utf-8?B?NlpmdVpaR3o3YU9CSjZGcnVHRC9hcFBYMVlYeFcrNTJucU1yQWRDdkt2SkVU?=
 =?utf-8?B?OXZsZS9BZ0t5OWxRV3dBa1pJYk5FVnlVSzhBcjAzeUFGU29qdTNCQmdoMklt?=
 =?utf-8?Q?IVMwE/hmvQPEVVO6GdmSlRl7N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529b63a7-91a9-40a5-732a-08dc7364c73d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 15:53:05.8320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRJNiSDIAFkg4GSwHdmodmzxnsWR1ha7t/yaOxTlXVeXw2DPhTk8PMDJCUb9F3jP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
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

Am 10.05.24 um 10:50 schrieb Arunpravin Paneer Selvam:
> Remove MES self test as this conflicts the userqueue fence
> interrupts.

Please also completely remove the amdgpu_mes_self_test() function and 
any now unused code.

Regards,
Christian.

>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 ---
>   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c     | 12 +-----------
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 14 +-------------
>   3 files changed, 2 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7753a2e64d41..2d9fa3d0d4a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4719,9 +4719,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	}
>   	adev->in_suspend = false;
>   
> -	if (adev->enable_mes)
> -		amdgpu_mes_self_test(adev);
> -
>   	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
>   		DRM_WARN("smart shift update failed\n");
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 4d1121d1a1e7..b7bfb3185a30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -1161,20 +1161,10 @@ static int mes_v10_0_early_init(void *handle)
>   	return 0;
>   }
>   
> -static int mes_v10_0_late_init(void *handle)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	if (!amdgpu_in_reset(adev))
> -		amdgpu_mes_self_test(adev);
> -
> -	return 0;
> -}
> -
>   static const struct amd_ip_funcs mes_v10_1_ip_funcs = {
>   	.name = "mes_v10_1",
>   	.early_init = mes_v10_0_early_init,
> -	.late_init = mes_v10_0_late_init,
> +	.late_init = NULL,
>   	.sw_init = mes_v10_1_sw_init,
>   	.sw_fini = mes_v10_1_sw_fini,
>   	.hw_init = mes_v10_1_hw_init,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index feb7fa2c304c..5923b7b0bd95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1274,22 +1274,10 @@ static int mes_v11_0_early_init(void *handle)
>   	return 0;
>   }
>   
> -static int mes_v11_0_late_init(void *handle)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
> -	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
> -	    (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(11, 0, 3)))
> -		amdgpu_mes_self_test(adev);
> -
> -	return 0;
> -}
> -
>   static const struct amd_ip_funcs mes_v11_0_ip_funcs = {
>   	.name = "mes_v11_0",
>   	.early_init = mes_v11_0_early_init,
> -	.late_init = mes_v11_0_late_init,
> +	.late_init = NULL,
>   	.sw_init = mes_v11_0_sw_init,
>   	.sw_fini = mes_v11_0_sw_fini,
>   	.hw_init = mes_v11_0_hw_init,

