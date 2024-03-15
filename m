Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4775C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 05:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4834010F6A5;
	Fri, 15 Mar 2024 05:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pJ4h+bDM";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B8B10F6A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 05:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMSOTgJuZKbjO5yM+LOlL+jigcHV46WhHEu4zdV7fFylqHY+127QJEghbujUh1OzmMPXygpbGcRVnwBe4SGRRbHr1ynIdOuwTlGB/rAODDkZR1m+uEgg3XL7Hgi0fLSG1d+vAHPXsEgC+9u6H+w+mjQhm9NjRbI1QyNwNcEH88qcsla8DX9GD6t7yB4BdWZ3ayrKw0V4762fenf/iid/k5/Q6KjZVLL7psv7WP8AKtGfOTFv+p9AnCyQTX0EdOidG1a/FCGig95QsZfBoeRWgPbsnIGjW684lv7J5eDfoRkQhQzyLRHi5H6P/AmPgfCMI2KfJSHgZWh42MbdPjwxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERNuUrPiQo3JFBFcXcVatF6m1K9H/+cYc+IKytNZu5A=;
 b=MzZyKHm82zSmseXh16C0Nkd6GJTbwdhWilTJoLtcW/mFKKQx7KDUYcpv/2dTMQPR+ZPPMtTsU0Gh1mbpk1JbKAW++JM/484S9CkuPRgIyiFNIXfCqhaw1Ol3/Sf9Vs2zdX3xUZ8rOG1Pddj/4lU951dE9iG0zNOPa2D2cY5JgbgzqliD1LbLG228xcneTBAFBT13JNOEonehsHLRHIgBxoYUuE4tsJYwTyhM+iYFSBbFf08vV2vrpq+EjFxzMvBfSy6EHCKv7O7uHsS7tVwl1rh188vpyZOFkARr/m+gHZOdof05jNJ/f9kNIMYvGWw2521oiTOoecCFzfm0NlDQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERNuUrPiQo3JFBFcXcVatF6m1K9H/+cYc+IKytNZu5A=;
 b=pJ4h+bDM23u3qiT+gErCDYXrtFok9LL+vdzPkkDmc/eSrKxhOqahpj4EuwzMrB6osR8hbXqxajwPhWueDxOjLc8DJqPS01Tbmt9dTpmG5i+bz1TzHNAXCrsd+LSaTQSK5NiV3Nia4PzT2rH5HAgkm5c+zd5OftHvSfSy/UD9cPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Fri, 15 Mar 2024 05:48:45 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::86b2:e267:3bf7:682e]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::86b2:e267:3bf7:682e%4]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 05:48:45 +0000
Message-ID: <39f00c1f-7384-4510-a2fd-2f2b0a1de19e@amd.com>
Date: Fri, 15 Mar 2024 11:18:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the iounmap error of rmmio
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240315051725.2450734-1-Jun.Ma2@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20240315051725.2450734-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f4e9af-7e7c-4b2d-3ae2-08dc44b393e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WA83c3neASMdcHU+MlQG9I9FYR7gfKT2AWJITWtRkl1XGZC2MmhYgEKU2Ry58YjfXt0N1MJlDUsKeYh1lpe1iTPLD14fCoT+cjouXlb3zblSpzYRHB6HJ/I0FOqiVGa53lymhJ9WXcPhK7U2yfFcQUTPAxAaggXGa+Abo6DyzEJPJJaIXruW77qaKx5zR0VHC7WzPm7Xw3CVnqrVaYmtfZMdDPidV4PazwmYizGno+frpf95M0xdcGNTTEsrWzH1zPJ501lKpNapPjT5uuboTasBmTJ8rcqIyFivQ543TWGwxmI8sEps1QoQbuYVCqau8/CjLIIzPQEgDyFDnRHHo+yoof0RQI1w/vc8gOJPD4Ndk06lgRgyekXKmWGJckkJPZ9sSMtwlZ/HbuNx6U8yKekw+rqRoLe2K5+PyEIEyCg9NnNn2v3hGmyY9aSADMGzIzPuu0bs4Ppt+PlJZxOHH7Jqof4BvguTyb84ZNpT5eFiDrkLFdDEpCA/TPfyC0/Oi8S2yrPscj/EI9nbS5tgt8m66CCvVmkJJYzk+BBrCDPfG67x2ow5V1d0HHhKsnhMeVcsIoi1tM1ZR724K186FC4U9edcWA4kvKw6skm7/M25YcaeMBTzGM8jd2gWwiVRVAqcTBtZFMr4SzJSZrGmbT+pV6pbsKt3DNirz/JPIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2hHYURHNEpsS3lXam9LOG4yRitOR1VsS2JnOWFQZ3AxZUs1U0cxRHpsVkpy?=
 =?utf-8?B?anBGWlhmZDBrNEMyeTE3aXY0dzJhT0g4c2ZxT2VObis4cXIzREFsWTQ5c1BZ?=
 =?utf-8?B?dER4Q1hBUWh3ajVjUWkwYWNmYUNhdzNxdUJaMnovbHdPVDJmYVdML0ZFN1BD?=
 =?utf-8?B?NjFUT29zZU1xaFk5QlQwSGJYVXdlRzFYWlVYc0k0Wk5TejJ5Vlo1dy9jTTN1?=
 =?utf-8?B?dlJQbE1NN2hIQ2JTc2U1amM5SCtrSXZVd0NBS0QrL01SK3R0ODlGTU9VOW9v?=
 =?utf-8?B?alZHYlNNcUFBY3ZhK0wyTzNlNFlLbUFEZXl0TUo4bHB4UTNNN3h5RDdxU1Zm?=
 =?utf-8?B?MVFQNU53empEWHhkblJKZmM1cDg1ZTJFSDNNTlBNK3ZLZnlHdGQ2eUNsanFU?=
 =?utf-8?B?MGxyV1ZLT20zNVFvOUdqeWRraktaNi9jMDIvNlUzT3d5UU9UdWxGVzR4T1Ja?=
 =?utf-8?B?aXpZQVF5MW5YQWczTnAxcFpYWGZKeGozWmdyb0tCaVY5MjdrZnNYQktxdmhy?=
 =?utf-8?B?WFVsSCswZTYwQTR3KzVlc2ppMndiVnlaM0pmVEF1dUJKZWFZYklZWTRiNXFL?=
 =?utf-8?B?QkZMcW1lS3IvaVhONEg3aFdOQnRKU2pLV1dmVDhIOWlZNUlvRDV1VW1XUHNL?=
 =?utf-8?B?c2JNOGFwYjNoQkx3Zmc5aC9FSnVzZlhhVDgvSklhWnhvTkFQclZLZ0V4c1Nr?=
 =?utf-8?B?U1piMDhWY3ZacHFOUHZHbm1KWXlsVU52TnY3cEZ0M3JIRHFkWlNZNDlTOUw3?=
 =?utf-8?B?ckc1NWFLWmJXNG0yQk5qYnBNSlp0UE9SMzVoeGNNZGtFR05Fdk4vd25UVVVQ?=
 =?utf-8?B?WExoN2JHZ2JTSkd2dytHUkpPclFFUVRaem9ucVkrSlp4cUJiZi8xaWNHcnVD?=
 =?utf-8?B?WlF0SkRqWXM2eDQ4M3pRN2tqQzRlclljR1NpQm1CK1ZzaGxMVjZiUHBzbVB6?=
 =?utf-8?B?NkFpSFM2aXlPak11ckhSZzVNaVdTRkpSc2tiQUg2SXYrbkw3N3VKcm5yQnJR?=
 =?utf-8?B?cmFZUmNiOEpobllIa0pyTG0zM2N1aisxNTVZRk1KVUtsYXQ1eXc4VHhrcWR6?=
 =?utf-8?B?N1R0WFRIMXpuT3Q5QllJTWUxaDFFamNWaTVqdlN4SzlmaDBIN09sVjRpaFFx?=
 =?utf-8?B?QllmYkFKaVk4TUg5dDhmVUxnaEN1WFhwa3d4Q2FGVnJ6VkhiY25TZzlQWmd1?=
 =?utf-8?B?blFPcnlOYUlaOXp4dU10K2xTOEdGWVV5OTBBNEZxczk3dTRYRzJBUGNjN0NP?=
 =?utf-8?B?L214dmdwTWoxNUQyZ0RSSTRzVUt2S0JVY2txVDdhWGx0bnRpZGw4czhIVEs1?=
 =?utf-8?B?WlVYSEV6cEFOT3dFRHFIb1hFTlZ2QnhUQThCeEpkcW8yWjVEUmR2NW80NVdO?=
 =?utf-8?B?NThVbFBtaTcrZi9wREpNTHNrMVlXMzlJRDRpME9KU3VqaE4zdDJTZlg4Nm80?=
 =?utf-8?B?NERiSEVKQWlFL0xldWlCeEFxN1MxRUtZbUdjUmNZcGJpRHpEUlQraXRhUkQx?=
 =?utf-8?B?ZCtNNlFrMjFOTkJJMFkzNlVFZHJsdHdaQmRUeXl1UHR0MUU0UlhEV0d0OWh1?=
 =?utf-8?B?ZGgxOEE3eVNCQlprdzJUamRZTzdodFA1KzhGclpnSkRubmZoa1czejAxd3lM?=
 =?utf-8?B?dUl0SGplSG5TdEpYOFlxaTgzRkdCWXJRV2Nhd3RDaFRiZGd2Y3BSVHlCVzd5?=
 =?utf-8?B?YVc3MFh1c1NtNTV4WWpnTWl6b2RlS2NFZzZJRElzR1grVXJTanZBZ1l0ZWxs?=
 =?utf-8?B?UTdEbnM5Zncya3hkOStrSmtRaU5TVVRvcjJ5eUkxWDNQTllUaHVlckpvOWJr?=
 =?utf-8?B?aktFcU1FNG96dHUzZ2ZNbTBqbVVBc1FXVHlxOGJBTi9YNnNrZS96MS9KZmt5?=
 =?utf-8?B?M3VGZlc0VUg0Vm1Id3JnMEZXNnQzU3NYVTMrNFZZaHlSenFKcTRMQlcwZ2la?=
 =?utf-8?B?Q3gwbmtzcWZRTlBBT1RkSGduc3Y0bEU1SWQ0MThhMytUaXZPaGxWVnF3S2hW?=
 =?utf-8?B?RE0yN1BtRVNUUGp4em9pMytTTWRJQUpGb0FjSWxqSkJzZElxSjlBalo3VkRr?=
 =?utf-8?B?cmJTajRWSnVUOGJicnFZczF5eEZTZHZscHRTR21HRXFFQUxuYUZMYXVpQmFv?=
 =?utf-8?Q?Iw95nf0u2ZmWqughPvBj5TREo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f4e9af-7e7c-4b2d-3ae2-08dc44b393e7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 05:48:45.4250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmEcA0w07XxRAz71YCQNU4egHPqLGMZskkPg/zCnd3gY6utE1PxaB5DuO0s8YHiGriKo88U+jPLalrlxt8edmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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


On 3/15/2024 10:47 AM, Ma Jun wrote:
> Setting the rmmio pointer to NULL to fix the following
> iounmap error and calltrace.
> iounmap: bad address 00000000d0b3631f
>
> Fixes: 923f7a82d2e1 ("drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()")
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 39dd76e57154..d65a6aabefbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4383,6 +4383,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   unmap_memory:
>   	iounmap(adev->rmmio);
> +	adev->rmmio = NULL;
>   	return r;
>   }
>   
> @@ -4514,9 +4515,11 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   #endif
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		if (adev->rmmio) {
> +			iounmap(adev->rmmio);
> +			adev->rmmio = NULL;
> +		}
>   
> -		iounmap(adev->rmmio);
> -		adev->rmmio = NULL;
>   		amdgpu_doorbell_fini(adev);
>   		drm_dev_exit(idx);
>   	}
