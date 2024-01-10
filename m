Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B135BC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 10:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA9610E737;
	Wed, 10 Jan 2024 10:20:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7AAA10E737
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 10:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeP7hZHFqF2ZmiV28gptSMNeGHXVXtBnPuYGgBjihs8x/FKvleI7wH971dkimZ6y9jElZ+UIsNhbqSUbAF0uZTYJDKnE0CHjuXkXwu4u+02d0GcVWAAIEAINqZPm7Sv23LqaaJ5mOUCGazPrkB3EQD6xMgJU4/Q42ENRvjzRE5GNEzeahz7MLdlpUivIIifTQhcnLycPIi8owHoJ0Z/ghqcUy7cYc3W5i5FeWKpuAIcRVmbtc94NVLXxHSSA7of6qoYXA/mdwHcagCzmRMLe8Ck7TW4PvUJj6wBEMI9+fQlSDkUklKBPV2jMIkUK6uYFnqsa7ijfgGbf2vd2dkOxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHjUEao3woEv3iGXLHddobJOJvu/kKt3gn85Rtcqaa8=;
 b=WwG37LzNJCsjryL5ab9w6OOMLR+Lg+zJu17rdlQw1H/wzigMHd/WCA9y0kRJgo0ulN9MjOCUQnie3xOX2Cdqb/w3cQ7zIDXyPo6BDpd3F/nRIc9tBH0+KFI14Ep76rYIMKhm4a/ihwlm+QArSW1ygTZj7oAGvfgyB13qptVbiFc74g8a40bdk1uCx9hnHshISQiVZar1A217CWK3BKICFMtFayK3s0Sht4IFVYnR+J6r/fT5Yfxju5b4+NGIOx7XhpRF58HlgK6FOygluidqA745PgOjFWYSaarkE4Jq8C5OiVRc2VD0iNTCBCronK0bxMqRPJlAJ6xrXoMuWaOYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHjUEao3woEv3iGXLHddobJOJvu/kKt3gn85Rtcqaa8=;
 b=1WkAefAHOpDBVR88YwGYcUJ9lP34B+Ezp5JytOpiYBL9uU+h3GlyeqWpoEB0BmqxLAlq9mDGNqHfRMnvC+CjHneoSHUliZuDGe4t18bpUDNDKy1rf3FKC+3bY4wZKH7bEquvV+NT5Q1rZ3xe4AF7dUQmHZlqgEEtzv/7ogmFBhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 10:20:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 10:20:30 +0000
Message-ID: <2ca4c71c-04fd-45e7-86c3-5fd91a42a00f@amd.com>
Date: Wed, 10 Jan 2024 11:20:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Check extended configuration space
 register when system uses large bar
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240110101319.695169-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240110101319.695169-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed4337f-0bb9-4cf5-db8d-08dc11c5c598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZdQK9XxU57KxsDbA0NhMSuAGQBo2e8DJJs7/5vb+38WQi98ViA3KhyZhH+3Ddp/jmgsI/pt3cxubDyQSZ/Re3Sh7nDygkT2N++F+fmSAcPaLIzE5oY22FTRsmwe69C3ezeFWwcvyOjW+LycvTQ8AQQ89n0f7wU69J7cCb3QrUFKpRS5hEw3j+XifecK3fWZS1ZNjURz6FqkT9BQUOfafVt0kdlEWp+zCedGUO08WAuyI6B5Qy+O0cB1pc0nYatR5JvhX6WAh4A9g6awPK4Rcd1Gvos8hGSMceI0MLxmhWV5dC+w2dfRer14PxCpKt2MjFCt5l3y2FymAtBAiVuSLz8MVyLGGTjVF1MnXpZUX3pRzPQqJA1VlAJHEvjNJNvayJnpUD3E6qyH2gfCC214yCBma5VanWvHJHxl8B3EnVpuWMpTG0UlEw5VVpUDnXqIT04EpU7jLeJ2Z5yWqYl8J4qOCerSSfqy7sw8vtHQDeyAH5ADvwT5EMbeF0WlR9TZa1n1ws07IuczeukzAHTVI+nsGH/k5QIWwHm+Hs2GrLmwdDoyB0M7N0PjSQerPIQ7jCSrcbDguLMj3lKoQcoMRfJgXPt8srrTuiiC+ufk9m38ZOXQReXvYl5hnt1pgrRjtmiruLMSxuAlZVSnKrAXbGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(86362001)(8676002)(6486002)(31686004)(8936002)(31696002)(6506007)(5660300002)(2906002)(66574015)(2616005)(26005)(66476007)(66556008)(36756003)(66946007)(6636002)(6512007)(478600001)(83380400001)(316002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5PSzMvTlA3K3A5cnNDVXVFTkZUUEU5RmwxSjFaSlRqTUd5R0UwRWpVSTNY?=
 =?utf-8?B?dFoxUlN1MnhyZndXT1lZd1VPanNLeWNyODVMdjgvcXVXNzMxdFFhZnd1SE1Q?=
 =?utf-8?B?WWUvZnpqTE12YmdJTjZtWDl3WTJQLytpVlJvTFZaZnNCbGUzeEt5TDhFYnlM?=
 =?utf-8?B?N0FkSzBzNzUyNlUyR2VkUGttd0s1ajVDdFZKWTE3TWc2V0tNMFB2NWdER1Uw?=
 =?utf-8?B?dStTcExKeVNXbnRHNjE1ajZ3S2w4dURtVm9iQnhVNFZHTWpLdWtKQzEvUjZp?=
 =?utf-8?B?ZEx2d3VCVUZWdTFydjNYZFdUcTVWSTBRVCtFOVRKMmRWcE50eHlOU0toc3JY?=
 =?utf-8?B?WDAzN3FkdTRHRUJ5M2lKV2VjNG5aSVI1WDZhbnhrdzY0RGxsRDJFSUZpRzVG?=
 =?utf-8?B?dmJFSW9Jek4vZWwweUNmRS9TZEdmUmxGc01tNTYzSmFrNjZBenliZ2J0SVNh?=
 =?utf-8?B?WHVBWTY2ZCtKdGZiT3hpQk0xZzQzUGQzRFJBOTlqeWVIVE53bFNrdTdPaW1p?=
 =?utf-8?B?QVlQWmZMRFlsRlBMRG1VNENQZnF5bUlJTkVaVldrS2o3azNHcStmNDA3YmNy?=
 =?utf-8?B?QU1DeFNrcjI1cE1yRTB6K2xOY3BEMHkvSWRMK0NSTmsyM2xkUzVoUTBRR25s?=
 =?utf-8?B?ZmtwZk9VdW54L3libFhCcCtFemI4NjMzQWlCckJrRFRXTUI0c29DY1U2NlNX?=
 =?utf-8?B?R2I1NFY1MGRHZU50ODNSNGwrUnV4NFV3ZDZLZGQ5NHI4OGZtZUpzanhvbUZ5?=
 =?utf-8?B?L2pSWjI4NXljTjUrUUFsZ0cwZmhObnFsWEJxMHdSUHc2dDdiK2dabFgrMU4w?=
 =?utf-8?B?WnFueEtuZjF6SkNPam1FR3RKaGNZcWp1VDhiWG52bGgyKzB5TmhKSmY1MDlD?=
 =?utf-8?B?eXNsNWdQTCs2eU0vQkIvcCtzNFdBeC9pYUI4cy82aFRDWlM3b0EzOG4wSXBM?=
 =?utf-8?B?MGFIMElRbHMzN09nQTU0c1p1WjZNczhZNjJBRzVKZlFoMEVsY0k4Y1lMUDBB?=
 =?utf-8?B?R3JpYmZEc0hhWStSRmpzRzRVbUFUSUtaandlRWZqVnVpd1BUNEZSNGp1eUha?=
 =?utf-8?B?cWJIWDZ2K0IyMGtKSFVZeHhrRit4ajIyQ1czc01ISnBEeE9rK0RCNTFhWGlF?=
 =?utf-8?B?b3VaNWZDeU8yMHdsOWNXQXNObzBVNjNrakRJSDRFcGY0RjN2LzBSaDhTYmJP?=
 =?utf-8?B?b3RxS3FDL056M0NzdmJiQ3U3a1dHYlAwWmlrN2szZTFkMnZwMzNUdG9MS2Ji?=
 =?utf-8?B?OVBDajZDWDFTcFNjc0RROVNFbDdVaWVVTm93Y042aGVmSnZpQ2Yvbnlqenhj?=
 =?utf-8?B?dFhhaW5IemNRc2dZNFNJUnFqS05YU1BEZStQRmNYL1pmcTQzYy9xRE1vSXpC?=
 =?utf-8?B?aXgrMWtIRktWTWdZRVU2SUhqN3ZhU0tHMlA2a2FzYjE0d0tNZG14RVNEM29u?=
 =?utf-8?B?YzlCanpmeGlNQS9JYmlRU25KVlNZN3JoWFBCSEJLbWsreU1UdnFmT2s5dXJy?=
 =?utf-8?B?RFhvai9kSzJ5ejhKWENYb3RmMW15c1Q2WXAvZHVSOCtiTnNLZ01jMGtYL0VZ?=
 =?utf-8?B?R24ycEhNU0xNNGVVdWdjRmtydDNKVUV1Q2lsUU1pNjVaVW5HL2YycDF3UTFO?=
 =?utf-8?B?VU9KQ1lNaHJaSGdaTHl0WHRXd3ZQWDFlbHlBWFErTGlsbGI4WjBEdEVWcGN3?=
 =?utf-8?B?RlFBaDNLWGFMaUhadjVaTWQrWWJwdWxoeWZvUThkeTNOLzIrNDE4MjhRYVQw?=
 =?utf-8?B?RjUxdVBRT2t2bW01RDBFRUtxL2dnOE5taXV6R3BiVFBudUs4djluRW40Mlhz?=
 =?utf-8?B?ZHJuVUlsdDZicU4vTTBaNDZWNUFMbllzaFpMc1hCaEtEUTlCY2tvelpTeHBX?=
 =?utf-8?B?a3d4a1pHU1hwWmJUL1NKRjRkd0wzTHdSYmptbkozYjgwWitTUjNuNWdOSy9T?=
 =?utf-8?B?bmoxU0NBL3MvWGFYbzU0M05TY1RrQmRyWlNTZTV2bnQrRnRLTHQySlBMOTk1?=
 =?utf-8?B?NjYzS3ord0NGRUtSQm1OZ1JUZ3pTYTBLU2RtL3JUODVMUDFuandadlpleXA5?=
 =?utf-8?B?OVI4MlM1L3c2dGJ1bWUvYWloS0VHZzNxYXcrbTJaQXV5TkpzWGFZOW9iaWRl?=
 =?utf-8?Q?pt8Mf53QTS04vq0e4vJ2djuGR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed4337f-0bb9-4cf5-db8d-08dc11c5c598
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 10:20:30.3520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTft02ywaAx98ZIxT47LrHION8g5/WAa5hiLZ/FU9Fta8uRjFGH8ZOAepB698T0J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263
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

Am 10.01.24 um 11:13 schrieb Ma Jun:
> Some customer platforms do not enable mmconfig for various reasons,
> such as bios bug, and therefore cannot access the GPU extend configuration
> space through mmio.
>
> When the system enters the d3cold state and resumes, the amdgpu driver
> fails to resume because the extend configuration space registers of
> GPU can't be restored. At this point, Usually we only see some failure
> dmesg log printed by amdgpu driver, it is difficult to find the root
> cause.
>
> Therefor print a warnning message if the system can't access the
> extended configuration space register when using large bar.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2:
> - Check the register at 0x100 but not resize bar register
> - Modify the commit message
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4b694696930e..629de7f2908c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1442,6 +1442,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> +	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
> +	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
> +		DRM_WARN("System can't access extended configuration space,please check!!\n");
> +
>   	/* skip if the bios has already enabled large BAR */
>   	if (adev->gmc.real_vram_size &&
>   	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))

