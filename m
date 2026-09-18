Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7487CC982D2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 08:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1071B10E85B;
	Fri, 18 Sep 2026 08:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iJrdjGzv";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013036.outbound.protection.outlook.com
 [40.107.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B044010E85B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 08:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VK0a4uFPLNKj+WAu3qBv1CdKguMR2Qn1jQNSA8hr52jWpcfWpSmnXglzsgqekhcWRfcSzT1RVbW6OMmO3KbYkImJDmqJItzQ93bf6WElZ9Y77xNV0jYYe7YnyMh6RjJTfOTEBuJAEpEpMp6dcbkI1lzSXH6O7Kk3laEn8ZzpKdLnExloQI54xgsg6LULCBdkZq71gVVdO/hry7pushVUtXebaaWyMA54dYADVcCLyY8EdmdCINCjlkpzJHA9k2kKZ24dts490PC/eQtTPqQADRFIQ+jnsNk79j0pmodAvKpch71TzSqtyNgv6ufNVKbWOYXpDibsnyWzrwgwXjBGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFFEWuRqZQz4ru8jGfEfxDQrAJSjwo1DycqZoIbL8iQ=;
 b=HKzdjgtsYImUIkrwhGkDXQTAu92Os6b8f9L9BjSzuhhB3RfYV8/E43lWJhKW8iQkuGhY4M1OkN114q7rjsD5usVDLgpGP0oFsPoXBDvZ1HXP5XD5edYSSoGxpT3XtG8Jpz3KWrTw0nyKDfA6MVeIfNvGLTUVN6uMcAdEemQNAeiAAEg9zd/w2ZrckmZbzcov4GkxDIpVJ4f5eaxjKV3lW2lUINzBlhlWBZsgP+65+ISj1HoNYshP4+3MasyXAN1KaxtEU7gyjRZv+bW+TZ42HrWhGNlA7X1s+KXhkiJGtrdn79nW+bXB1Ic4EVeqpvdBWR8pHuFOAHHZA3ovdy0mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFFEWuRqZQz4ru8jGfEfxDQrAJSjwo1DycqZoIbL8iQ=;
 b=iJrdjGzvs7jbypF1TQvR9y4+KHBV/+ve/nRKjepWid0aLanTswH4+G5KGUeSBL2U7+n1Hhgt3yQrPba1QOGSB/PyQqzt9Q/Ge7NBT7A1qDHeDnv1a5VwPAha/RntL1vMC8sgqbny65fIgD/zdXQDjPFt1L1fTjFbJZD82fmV/kQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:01:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 08:01:26 +0000
Message-ID: <6fe6bfb4-d274-4a19-a960-9d9dfe0e1a9e@amd.com>
Date: Fri, 18 Sep 2026 10:01:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] drm/amdgpu: handle runtime pm in
 amdgpu_gem_userptr_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
 <20260917195812.72917-6-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917195812.72917-6-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf679a2-b0a0-4415-45bf-08df155b0a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PT5tVho+XQ+hYq7xc99MozMV4bUD7Fe34IWcW6PK/6tgbJ+HLVbBDgtD9rQNdbUQkrTXXWG7B23dPnIv+V38FkdqROJTFNPSpf+sgsxkqMaHY/cWn8r4vVXIyDcVi+FT9x+7yFh+uQLXlYDYvS+iqKxOM1qnaQakA/MhKci08WHkhExC3WrQVdTHtH06foES2TMD3tQ9F1WaHEZZAfuHM8GSAlnFWB45Z/nid8OXD9LJDoBljzHfJlm+kmYCNjZfW1pypkffGYgmDASljOw53muc7bmlROHI90AG4y/gimofl0FwJoqGcJKcxeISHnSBxX1930loafTGvv/cGXZsDcqqgf16RFXm5wSmIK3FbwkS7DjR7GHlWlHRVFjU5+N4NRBVdEsyYzBOG4imCS6hzH774kA7OzlSELw3oszSF1EGa1lGqQHWk1U7OaHDi4J2WF+nzVgDm5BMOr5wlor3LsOBjoPi9GK9xp23UUQzTCUIa4kRzvMUbD/oBZapPCRNWhTiggU//xN9XwWWqAW6BdXCAc1kaFExDKDrI5MSGA/ifGwJfd98Rwl+ZFt2dbCKK0Q04YUF2Dss7+Uiqoc5FNwOx9y4gkzYOubO+lgNk3cvFkvivfST9D3MF1DS3zbJhxgEEEJk0zvTiFPlngHAvr3mgOr8Ngylb0yCKGM5SEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGM4SXEwSG1mZmgvbVR2TXZZUmNRckJ5eURmR3VscXdhU1IvclRnQjhEeDNJ?=
 =?utf-8?B?QVVXaVlVbE43bklJQXRzQmRGcEpNM2VGODMrL04zd24yMFFHMUFGZnpQY3NV?=
 =?utf-8?B?SWtFWGlKVktxYTZvSGYyVHhhUlc1aFkvVFZkM21QTFBlMDk1dFF4YXVWQ3pL?=
 =?utf-8?B?NGFXQzg2Nko5RU9iMjBXMkdIMk0xcEJNTFUrbkhnVG45RUNkRWFucEVVRm9Z?=
 =?utf-8?B?SGQzWFBKVk42WElVNnF1a2VPYlZTdWVydURDY0dFVi80OW1UY3pIaTNySVN3?=
 =?utf-8?B?VzdCcnVTUTVpSUZlUDlrT0JzR2VsamovVHdXbUk3UWNvRURQKzk4Y0h3THFj?=
 =?utf-8?B?QTYwMlpIYVJtSi96dXN6ckp1bEQrWkxEbGhaRGtrbDRiNGNkR01UMENLenJS?=
 =?utf-8?B?RXVEemI3bWxNNk1LRzV5cStoaitFT3dHSHhacS9UK0p5cC9pdmM5R1U5dXlm?=
 =?utf-8?B?WWVlWmNabFFwd2drU1pTN3l6ZFZ3K2ZXcE9lNUUzTFlpc0FQSlNXY0k3V3NL?=
 =?utf-8?B?bnhUQTlNemVrZXJkNGFlZ2tCVjJsY2FJN01YQmFxSXdTWWUzU1ZEWDZvL3hq?=
 =?utf-8?B?Y084MGRpWDJOeElYT05iNEhxWU9RUTM5ODBuYWJmMURRaGVGamZQaXU5MEdt?=
 =?utf-8?B?QnJGU2Y2dnNDUHBObkZJWXdsR1gvTjE1ZWJSOW0wSXd4aHpxRm9kckJmS2E2?=
 =?utf-8?B?WUZNQUFydTU4QVk1dTVuRFlLV21CRmdrK1F2QzJpL2Y1eTc1ZFRmN1NNcy9Q?=
 =?utf-8?B?UzNYcjlvWTZMOTllWHRBZExSQm5yZVlIVXJVSXZQT29YazRYYmlwZmgrREpL?=
 =?utf-8?B?SHN5cjFvSFMvbU9sb0dENHpyTnpvMkxYRVJ5YjJxTFhFaWFDU1oycnNtQUZi?=
 =?utf-8?B?djZwVlZ5a0JkRnpSSlpQZDhtbmFwdjlhRVdvL0p1RlVtaHVEdFB4UlZRV1NQ?=
 =?utf-8?B?MzIrS0NWdkpVR3FubTljRENtOXZWVmd3QXBxZVdOOXVYWXlHcjdVK1ZTU2R6?=
 =?utf-8?B?cDhSOTU2N2o1M0pkc3oxSEpoeVZsZTRuNHRBR25KME5mQXdJVzVhaUpBMHRN?=
 =?utf-8?B?Q3pIU0RsTGtneHkvcEswQ2pteWZwWVdZTGtXR3hIN0FUdUxUM0oxYVIyRThE?=
 =?utf-8?B?d1hjQmxEWnR4bmtvVkVEVStjaXBuRUJPN3djcld3YmRReEdqZ0JvNHRrOXNz?=
 =?utf-8?B?WHc5QmZkaFYrdjFuS0RmY2hpTXljbUszbUJpL1BWQlYrMSsxQ1YvSFNZanhJ?=
 =?utf-8?B?ajhFcy96d0c4UllEVThoZmN2cW1jS2xYYVJUTkUxaldaejV2RExtWnlxajFN?=
 =?utf-8?B?S2Q2Rll6WUVleloyMWtLMjJQZjltc25Uck5UbzBNemJ4VDViTjM3NjJuZnFt?=
 =?utf-8?B?bzlOY2dFam1ZcHRibCtQQ2NpRFdQV0pEMlR5dlpIM1VmUVdHVFFyV285TnRi?=
 =?utf-8?B?NTZFL0FsK3F4c2lPekovR2NtMjA3TUpVTGRTS051TndiTHljcWtTQTBaa1Zj?=
 =?utf-8?B?WFJDbFN2VExFYmhDaFJEaVVwM3lZdERBS3F1cmIzcndaSjk0cFJXYXhJSWs2?=
 =?utf-8?B?dERuYkZCbE9ReTFaWTF4NjE2THgzZUh2NWJvck8rYUFNSzdBRThBQTlWeWQv?=
 =?utf-8?B?c1BKM1BkT09TdG1Vcmk4R2N4YTg2L0NZNHlGRjc0bVZoZ3I0VVZWLzFHVkxy?=
 =?utf-8?B?RkZFN2oxNWpBUHJNWHdjYkRFNHVaZWMyNndjbDdDbUJ2QS95dTVqekJsOENq?=
 =?utf-8?B?ajFDQlpwSmx3RFRFNGtnU1hSUHBxZzBwYjkrOHdPbXhKSDZZdFdlNHVQdGFT?=
 =?utf-8?B?WE1vYzJmcnhjckQxV0VhbWtDdTVZRG5DL3ZiMElXSkIyRU1QNTQwMnlTSGY1?=
 =?utf-8?B?eWo4S2Z5TTJGb1F6VWlOcUpLbTRCaitUOWQ4T2QrUk42aGlndFBXYXpFZ3Ey?=
 =?utf-8?B?VXpwcytaeHdVRWhicGhUOTFUYU1aSWJDNDZ3c29OSWZPL3hyQmpuNEZualNh?=
 =?utf-8?B?ZHB0dVlzc2ltZEc1MHdveFR2UHpwblloSEI2d0xROGlOcXJvQURqMFNKb0F6?=
 =?utf-8?B?RXdJbEdHR2FTNDA1TFl3V1ZJUGg0UUZrWWpqSDJiNUpMVDhkRjZLZ1MrdTU1?=
 =?utf-8?B?MUhoNFVZd3B3RXR5Ukp3MTJiUUtOUnNseUFiNGFkMUswN2ppeGZ3ZG5XazNR?=
 =?utf-8?B?SjMxVGZHcVh3NDJiREcrcE1xZkhCYTdRQVZHN1d2NzJTVDRFdUVBMGNxeDlm?=
 =?utf-8?B?VmdIallwN2FZK05WUURpWmRqR21mL2h3VEtRbzZDL0FJbGNkeDJvZVZsd2dj?=
 =?utf-8?Q?5oHykNQkC8ZeTLZJQ+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf679a2-b0a0-4415-45bf-08df155b0a34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:01:26.9005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ize+3s+MgatVqbh1Ejl8Fh5vp5EGusB/67jF6iZwk7Jn69hjPZylnd9UKyi0VVEm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683
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

On 9/17/26 21:58, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Wake up the GPU while setting up user pages and validating the buffer.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> v2 (Shahyan): Added commit description
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6edd03647c2d..e54d30f75b2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -594,11 +594,18 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  		if (r)
>  			goto user_pages_done;
>  
> +		r = pm_runtime_resume_and_get(adev->dev);

That needs to come before the BO is reserved otherwise we can deadlock.

Apart from that looks good to me,
Christian.

> +		if (r < 0)
> +			goto user_pages_done;
> +
>  		amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
>  
>  		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>  		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>  		amdgpu_bo_unreserve(bo);
> +
> +		pm_runtime_put_autosuspend(adev->dev);
> +
>  		if (r)
>  			goto user_pages_done;
>  	}

