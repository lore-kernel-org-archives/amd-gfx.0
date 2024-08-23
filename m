Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08900C52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 14:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D49510E049;
	Fri, 23 Aug 2024 14:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nvwyTF/4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7587810E049
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 14:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHneHehFJL4qJ16P6lecNk5j7UJhQXa4Ly2nM/h2ToMr9FGiVA/9irY4wJF/vqVRF12lgOBWU1DBugoVRVGxEVdKGnjEBO00K1L2Kxs96Wwn55seqJOSBnjEIUADyq07o/Zc19zqydk3Jcfr03WPzy0tOFpzbLYaHyXgzsH/PuWKPOO3dQOoG7vvxwKCt8xAGgm9c3ueTcaUZACEOvEDYs7C3uvJMwC/Ep5i4N54aKHAJstdvOpuy0EvDAeY41ScukVDZ8YV0JEgyV8Xlprsn29XE4gBjRqSmVMo7wfs/nw4wpKpruN+TNqPsAKI8cjH1C90COyGbwpwcPqPn2jBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENnpLWcpfRZRgoOl1dSwuzCeMArr9OTwumQRCcd/1Rw=;
 b=ew39k/ncnZ7RpmjYe06KlAca5CU13yldSPR7Dpmw/zE8ngKztdJdodbHcIq3pfrnz2AfHmBIQuo5UqV3RYZni6ki9NBqjSxb2g1iQJlOzDAY2747P+6zARCvvYBuMr/eeCxSHQyyipiJ6di0trKEYi41PBh/+PW5Ux/JYUXLptmOdrG73SCTdxbr5tP5JyvERQbFYsdpSVuJQ1YuoTuP5zyEE4lhhrk+ryoe7drlZQCZSpl3de4boXFIYo+8rEUkZoefeTwol8/0YDJDND8z/jmVrxE0CV6Lg5o3ZBSEdDhWktx6TqGUiflLHyVqeBddMB6Awm8kGNiwR4ose56Dww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENnpLWcpfRZRgoOl1dSwuzCeMArr9OTwumQRCcd/1Rw=;
 b=nvwyTF/4dcbkHtg+5yZbKDi3QslnsZ10gIQp1n5QqLdQdLvBV6z1txCioqNITyXmXXjmjT05hvqlGgXUwoEijZc51Q4591xtkZfFNT8YIFHM5dyUpPXCJLFMCM8/BwE2QLpDUYWOPl8ZCcrYZNi8CrZXjLAhYdxa9i0VWJeYl+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 23 Aug
 2024 14:01:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 14:01:19 +0000
Message-ID: <8c110bee-ad61-4e3c-9f59-94fb1e7ee586@amd.com>
Date: Fri, 23 Aug 2024 16:01:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
References: <20240823133612.719681-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240823133612.719681-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc7769b-2151-4554-23f4-08dcc37c0fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTRwREtESVhkaGFCK09kejhHdXQ1WWwrMVY4VFZROW5RcStFUzAwaUcyd3hM?=
 =?utf-8?B?cUFFaDVTd2FqOHFrQUpvSGc2NWZSQXI0aE5zVVhNbkFneEMwb1pGL1ppODlW?=
 =?utf-8?B?bjhFNlVlOWs5QWxTT045UGRyUmFrL1VIcHhtRitSdENJR1JySU5SZ0M4SGV4?=
 =?utf-8?B?UzMxbjRoOVhIOG55UVNYcERKc2xUUHdlelRqd2ZxZEl2eU9JNUtkTjZnRU1u?=
 =?utf-8?B?ZzV2aGhDYVdSeE9xYy9uekNVT0JvUXd0YmdqRnk4bno0NnF0aHpIZ1BsaEh0?=
 =?utf-8?B?VlRGd2lDY28wK1lrS3MwR2lXOHZNVGxRMlhIN0dqcWNFMUpYb3V3SEdGV1kw?=
 =?utf-8?B?QWNZSG9oS2FXVWlmcHBYK0lORWpGZDVraWUwcHd4WUlPc2ZEQWdxTmtTMU52?=
 =?utf-8?B?bFZzbmlxYVpPWHRBM09JeTZmYnBxaEp2ZWdBUnpSY1QvRE5oVU9URjh1eHp4?=
 =?utf-8?B?aEZvcFcwamY2WFZ4MGRYaTdDVDhxWkFGdVpRSzJOS2hsRDZLaUpHMkNRRFh5?=
 =?utf-8?B?VytxSHkzTFQvZ0pTeStEMm1VMUZIZXZ2Y1RPWVZCZzY2SlRocTZ2V21xcnZx?=
 =?utf-8?B?dG4xSzQyZ1F0YWlhb2srNDNqMEo2NFlONGtvajU2cXQ1OVdKUUhxd09HVkhX?=
 =?utf-8?B?cXh3bmExSVBXbXNlNmZTZm5Gam9ZbCtnaFdRclRxK0lydlhKblRDYXZ6UVZX?=
 =?utf-8?B?clh6Ly84Yk4xOGhXcDlNRENrZU5KUzk3Um5BaUNWSTBhTmw5RUVWckI5L2NC?=
 =?utf-8?B?dFk5UFZQNlBUMUtXdFRkSlpmb1c1QW5mczVKWnllalM0a0w4RzdVNU91NXl6?=
 =?utf-8?B?WkgwSy8vS2F1MEhDaElMTmdFMGRCakE0QXVTWVhUYnVwODNJL3NlaEI2YjRF?=
 =?utf-8?B?ZFdOTVRzUFRsampmK1hBcUVIcFhDTHR0eitSZlJVL3l0VG1STVBsbGZuaW1F?=
 =?utf-8?B?cW54TFZzSHpZa1Y1c3VXb3MvZ3krV29kczcxeTJlR01IRi9GbDBZNWJDbGFy?=
 =?utf-8?B?U09MY0Qxam12b0JrN2tXOWhyUUdSRVBIOUtKd2tkZFF6SzZ2dTgxaUFuY2ta?=
 =?utf-8?B?S3krK3Y4enljbTZzY3ZDMlIwbmxFWGU0NzlMRGdDMWFPZ284VGlxL1FoWndJ?=
 =?utf-8?B?bk55R1BJaUovSmRpS2x0SERYMTFta2RyOVpxcVA0NnRFWXJqYkhBV2VhcnQ3?=
 =?utf-8?B?dnlYMVBnMmh0Z255Z09iRVdNeWgrZ1JSejQrVVlCQW9mODNKZ2UxUjgyc2hw?=
 =?utf-8?B?eE50aXJlWkVpUmV2ZEtxelk0S3piS2pTRWY3aXBFcVZXb1NUbWNQVmdlazlr?=
 =?utf-8?B?dVRMa3FCQnUveWs0UitxeExYemFuNDZXQ0loNlgwQUpHUEtCQWdDdzEycFdr?=
 =?utf-8?B?blJxTVc0dC9rTVcrNkhvT2tQSTdxK3JRWHRSVHQ5N1ZnYW9hS2ZCTi85b0pJ?=
 =?utf-8?B?QzY3SXVzRGJuVGtKWVhLaGhhOUNneTE4ZEU2d0JQTjg0bHZQcEdXZ1YrRENM?=
 =?utf-8?B?a3JsNm4zekJ4L2w4K280SGh4bHd4c1RraWRDd0RONmZTNjhhUjdBL3BEbndK?=
 =?utf-8?B?eVROWFZiQkI3RFZIV0c3OEdGeGF5S2MzNGtBUWN4bDJja2dVaHUzS0krcTB6?=
 =?utf-8?B?VlVXRFRDdm5OelI0cDJHUnVuSVNrNTNNb1c4WER0SExqQTNXNmZuOTdvTFFX?=
 =?utf-8?B?SUt5WGZXdTB3QllhOXBxZlhTUXIvOEZ3UERkWDhVRTU2dVo2UjJjV2g5QkFK?=
 =?utf-8?Q?7jzrU8DFqTUFc2yY3M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmR4MExBYTVxb0QwVytuZkdndmhINHVmNjRVY3pFRXMxYm5VQmtyN25hbk9X?=
 =?utf-8?B?M2tpTGRzVHA5ZWNsT1FUOXFtN2FtR0d1Rmh6QStZcXcyTWNxN1VzYTVtVHFx?=
 =?utf-8?B?N1NsMmNHSTl4N1RFU3FoNlZ4Y0ZyWUg3djl6bkViVXlxdXIrQ0VKc2ZDRTFU?=
 =?utf-8?B?RG8vUElxS0lmeEgvYkVrTGFYRUdYTjQ0cDA1bUVkUk9MUHl0bmx6eEpBak5p?=
 =?utf-8?B?S1FKdm9GcjN1TVhVdVdVSVZwUEJkR21XYXV4b3dKZUl6TjNxcURzNUlSSGZ5?=
 =?utf-8?B?UVl5S3N2SFA1MUtGWWJtU2ExTFY3cHlsSWFHb1NXNEpSeFk5THdIb1ZVVlBO?=
 =?utf-8?B?UVRzUFFVYmVmblJOSXMrQlVkaENaWHpQTGtXYy9QZ3NnSC9ZUnY4TDF3a051?=
 =?utf-8?B?VURjOWJGNVhxVEU1QVhWTkJveHlGYjJSM3Q4YWlEZVZ2UEYzRmxGWW1rNWZQ?=
 =?utf-8?B?RHZVRnNPTjhaVUxUSXM2NG9OckJCTFJKZk15VGFWN2lrMzZTRTZUR2tTQWp3?=
 =?utf-8?B?S2txVjRjaWhFcG5UYzA0SUdGMk1GdG9vM1V0R3ExYzJSY1c4OGtGQTRtbTl4?=
 =?utf-8?B?cHJBd1FMd3V1QXhIdGpJOFBaek93dVl0ejVXZTVyYlljTmhtVlBMVVVwWFZW?=
 =?utf-8?B?ZE9QYUd1ZDRtZUlDVE81Mng2Ymo1YlowYU8zaFFiWXhhWkpVWDgrc1gzbmNX?=
 =?utf-8?B?eXByY3QzY0RZeHRoZ1dmS3BETTV0SFZqdFBsZGlHSnB2YTU4VjZXRG5GODJE?=
 =?utf-8?B?ZmlRelh1eXhJVFNFWHZrNEdzSUYrTnJCUHlSR29NN2ZiL1pUamV4RnBjMWJD?=
 =?utf-8?B?VXdBZy9jVjBWNGNKejFoaTZXUlJ5VERNdFNsL1gycVhyRTZHQzdIaTg4RXZw?=
 =?utf-8?B?bkRSOTZLWVhSUHZvQUF4SS82c1ZJa1N1endCd3VYdGVkVUd5Z2ZOb211Zmth?=
 =?utf-8?B?Sk5kd3FoTmkxSzF0ZldOU2tRSDRvR3JXR01vRVVRdXpOSndvc2hzVC9xMUl0?=
 =?utf-8?B?RnQ2ZkNidk1zN25kZHNSYzhnRm5ER09YRGo0Q1lycHI2RXhKMDF3TUFtaVIz?=
 =?utf-8?B?aXFxVExtbzdkNzJtSHJBcElKN2N2RkVvYTdxZVFLWDlmVHJaWlRUazl5eHZP?=
 =?utf-8?B?ZStwMXdRMzdDdDlZOUdYNG9kVDJVSlpUR2NrT3dkV0JITHdXN1lFaWJqd0JW?=
 =?utf-8?B?S1d6MTgxVGNlcjFsSWpLaUVPSUxWMjJXcFBiOWN4ZjFqK2FUYTN1VUJxMmJs?=
 =?utf-8?B?amJjSzduWlQ5RWpEYXFoU3QvNldOZitHbUFpUjRlQmYreTRDbC9jc2lFOWNl?=
 =?utf-8?B?TFJzVTc3NWFHQUYrblN6eC9vZFNXQmR0ci9Ba0FmWDZYR29pNThWaWNQMG5Q?=
 =?utf-8?B?Y1plS2liNXBTM1BQNXJvVE1LMnNxM0I0R3pRc1hOcUl6WU1lUGZMeXFDa0dO?=
 =?utf-8?B?TWhUcFVYVnR0TFRUUSt3bkZXdzBKQ0lOSHdmaEJ4Rmt5Wm4yRTVrMFFRcDYv?=
 =?utf-8?B?RS9DeVhsL0ZnL083dXFrc2x6UkhTcmdJa0dvV0dFUkw4TXhKT0hPVTkybnAz?=
 =?utf-8?B?eHhxMndvbVl1ZXg5cDJjWWQ2UVhLMEhJeU9BRi92ekl2NGZlbFpIZWlaWi85?=
 =?utf-8?B?RFY3aGdQT3lNdGo5djR6U2ZuWGVaUlNpNkY1U3k5dXpVMTViZGJ2RFVBbmZT?=
 =?utf-8?B?ckRkeXZvdFYwVUdyUmZrTDUzQ2wvOTZWa0lOUm9GcFZrNHFyZTlwQ3V2U0pj?=
 =?utf-8?B?TTRTQjFwQ2NYSnJVQWp6T1hJd21yZTlQK2Zwd1lLU0xPL05YQk82dDJPZTQ1?=
 =?utf-8?B?T2lwWVgydThCaHhvZFFNbGR6Z0lpdzkxbld6djFFZkRROEFGeDhZbU94UHpC?=
 =?utf-8?B?MHhyOXFGUDc1WnkydTJzU2I2VG5DcjNPbVZYTGhETHkyaDdiZnhjRUU2b0dL?=
 =?utf-8?B?YVoyUkNTVVFLeWZTNGZwdHZvUEFaVHJqZ2l5T3pkMXVBNko3d0wwSVlkc1hW?=
 =?utf-8?B?YUMwak51OGFOaTZiNVUxcVp2KzlwN28rbDNFcTZra0o3djYraElSczRQZ2o5?=
 =?utf-8?B?a2MrMG5lNDkxTkxTTnlSVDUyYmZSaEtMNGNtRzZoajdGQ2FsTHJ3Y2dXdHRk?=
 =?utf-8?Q?+m5U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc7769b-2151-4554-23f4-08dcc37c0fc9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:01:19.0797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8paCEM87soAqqga1/S5jimwkbzoa9ZkEkSwIqipXy/eoy2ndeauW2dd8QIpfNCO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
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

Am 23.08.24 um 15:36 schrieb Alex Deucher:
> This adds allocation latency, but aligns better with user
> expectations.  The latency should improve with the drm buddy
> clearing patches that Arun has been working on.

The problem is still that we can't most likely will run into issues with 
some of the bootup time constrains we have.

>
> In addition this fixes the high CPU spikes seen when doing
> wipe on release.

Mhm, interesting.

>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3528
> Reviewed-by: Michel Dänzer <mdaenzer@redhat.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 1f149c9e2177..16af465f1c01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -349,6 +349,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   		return -EINVAL;
>   	}
>   
> +	/* always clear VRAM */
> +	if (args->in.domains & AMDGPU_GEM_DOMAIN_VRAM)

I think we should drop that if. When only GTT is allocated the flag is 
ignored and it can be the we switch the domain later on.

Christian.

> +		flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
> +
>   	/* create a gem object to contain this object in */
>   	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>   	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {

