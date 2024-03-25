Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCB6C54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 18:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B088110EA9F;
	Mon, 25 Mar 2024 18:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t7nTxry/";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2138.outbound.protection.outlook.com [40.107.212.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C164C10EAB3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 18:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9nDGWkmA6qliij89gCTHR92fOKaYpelLnjpF5Z78ccYltwiiu0M1JWRxgeFzDOU4v4sQhbQZTSUIwn6OrFdpOsYrSfaKHyCaA3ixvHmaEVGSBh45HiooIJuivF0fzF6BJZrVPftq7Vr9fFejVJ8fgcGEXRVc4lHS15cYnIYNa/85J9FIkQaru4VF2USJJ8hlHvGO/8ai4IOnbEJyVWjxM6zIp2q5L5DKDfvlbHHSvYn5gmMOcvVJDKZxYmo5HMORd8u3ry0Y+jXGzqM8/BFxKufE/5l/s1rLif0Sg1gh7EW3y0WtNX8NdPEixBhS/tlqNEaL9BKrBJP/oCM7t5lJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PZ5TvFkgCXmfdp9s8Hh3c2KO6wkp0q39MTXuTIzGP4=;
 b=epobMEpDSycQmy3IYcFDArKcCCU+9vFaohz6O12pMifOorL5iY2mQ727lmkVG8MSXDLtyAT7BVBJAkpki27qBR0gLk0DekaxiomJGSUzD8EAWjA31mt3ex3G/WUNzlS1FJAQU0cs22hr+LlWLToOhxKdX45XWydG5NzXnF7NNogLCxgLINeP7lIawTY4meu4cXPjKhX2YNE4egM9ahNwxshg0g/v4m+/DiVII/efHcspJ8oVF9TIvi31TH/8x7Dno57vyn8K48aS0+ZAeNvs3ZL52E4ELpbpGcH+IVUFbrNqTeplhq2cjeVQEkZHmFnFV3uIIh6Cj98mYfarw6EFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PZ5TvFkgCXmfdp9s8Hh3c2KO6wkp0q39MTXuTIzGP4=;
 b=t7nTxry/EYiyVjrouaZkINXrQzLX6mOmPRil9GwYQq01RA/3MXJh+OvntDzNiXBxYRgbQU3Ra2bN02SuN/ArRERdRiP6FaaY1cz205L5mRLo4y3NXeuNJfXaDivVrQ8/SSQGa7G6hb8L6EnaEI7cOSU/B7098fs7v2dtWtHXDto=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Mon, 25 Mar
 2024 18:58:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 18:58:04 +0000
Message-ID: <1d3c4b3a-733e-4820-ba8f-0466cb26a45c@amd.com>
Date: Mon, 25 Mar 2024 14:58:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
Content-Language: en-US
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240322164956.167498-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240322164956.167498-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB8405:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DR9fzP8MMtsZZKAVx/jFbxVUXkVXfk/lyX8MGakWHRFerMl9cLHKBxE5xeqyRBhBfb2tUsAnnHjDCJbPV8OVrY+M/59RLRrw8KyMocXE+KW36hrTmDy7lRv4hGPF58GAmrwCizgcGhJ9zbHD9SideYG9tY57aimJm7mU3PAg4iYXuTQNiUhTPoCybkcaECW2WtnCktr1lKDIBKYeN2hUyE0MqdKgqAbGFu/Mr+G2NpSfEEeRl0SIZZYyP4KG60ubo7bW0CxQRGkr5ri6DhCZ7Bndl1pD0BcGzhsTMwcVKvTGSlWnrXd5YWvEzPeHs79kgD541PLyNmqmi69OTrNM6djl/Kj8URM3seQv6jR80IhraaHEc8juZvu5xMHN3a6hiK87Lq62vvV24eLHMocC/CCzIL0wQHtekuEIhOLT+TScQ5pKrc5DxEcRbs68zSXaItLoZ49VxZYXy8rsBBf4wzotmlLb3Kt1s3Zg47cRUyKtu/5CYOGB/Qc5QHQj4Lzcvl5gZxH21E5oV8+xe8XIS4bR8o9F2VEzlLotXFSnkcDGnHP6haz3RJuaRvZ+Y35RLCH2wihQamiBkvRefAlkrYG1gv0VkGHM4VtgXMI2JwalKaz1wv8/V0HNDkWXRpt+ecTYYRIf5im7yQ7vmaHUyxHCENUkFrPd0qEJb2Tcv/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3VDQk42bTFoZVYyQmpVSUZIRVhWem9GOE43NWYwWVFOWThPNFNubUF2aUNQ?=
 =?utf-8?B?Q041WExNRWg2N0k2U3FDby9IUUpjUlM3KzVQVkR6NG52OThNM2VSRmkySEpt?=
 =?utf-8?B?RHR2VXN4R3MwM2hZeG1KK2ZEWmxZTWZFUllWY1FzbnRSVkpBWjBjU2loYzZB?=
 =?utf-8?B?TldaK0h6TVREVzJ1bGcyTVpYTmNLNW5SRVBlSU00N0VDbmZlSXRha0xEMHly?=
 =?utf-8?B?RjJ5SThFRk5rK0VLalRVd25VVVhNS3FFbHhVb1pxaVJ3MnVrWCs2Mnh1aHl1?=
 =?utf-8?B?S25RTmRVSlVOUEJMSmozRFYzTDdaR0hnZFV5NGJHRTcwZlFpSjFWbkYwQmVT?=
 =?utf-8?B?d2dLRkRIZXRpbStIZHlmVHpENTlQM1Q0Y2F5d3RLa0xqNEtIRlhjQ2llQkpF?=
 =?utf-8?B?d1cvN1pwQ1NVME4yWWdXbmUzTUsxZWIza2hMdFE4bU1QdWhxc0VpbGJXSFNh?=
 =?utf-8?B?czFMTk1nRzIwWUM4WjhOeHFvN0oyRWZmdHZQN01sYVFGTEhPUUFoUXc2anRq?=
 =?utf-8?B?aWwzejZaK0JMckRaUEN2QzJqYTB6UHVpZ0JUTXdMK2hMNmQwL1BaYzRDTUt2?=
 =?utf-8?B?aUZuQ0Z5TWc5aXNVYUFoTnJaOGYvM0VCZ0JqOEFPaE1pV01BLzI3R3ZHWnRR?=
 =?utf-8?B?NWp6eXlGbXpmT2dqSTkxMlRFaS9hMzRNaTFWVFZ5QWNvK2JpblFXdkJkL1Mx?=
 =?utf-8?B?djdmUEJxZDRSOTZBN25zVE83YnFBOXg0OTk4RjRaT0h2NTRCSjRuK2VjcWxE?=
 =?utf-8?B?Mm1KSHF2RnQ2ZnVDNWVlVXpmMkJuWmI2QTR3MFpvdUdweFA3UUtjN1FGMDZQ?=
 =?utf-8?B?RGdod25LRXg3bFVJS3daNFVFQ3R3Y2dnYml4N2VGTkpMUEt6UjhraC9KdFNm?=
 =?utf-8?B?dzNsMnNMRWFzaVk1blVZelU3a2JEQzFwaVRGSDNVNHhkSUZvUUZnOGdDV3Zu?=
 =?utf-8?B?OTgrQ0JPbjNKK2crS2gwWGVXMUZlWVhvOFRJMms1N2Y5NWlMSHVodEVWd1Nm?=
 =?utf-8?B?MTJWMk9zU2s3bmRHWVZWREtFQjdFNUx6bU15S3VFRFhVWGZLWDB6Mk1valFl?=
 =?utf-8?B?dTRjSTg2TEgyVnlMRUI0NDlTNGQyWjhJQ0ZtTmg2Wnp1eDlab2t6eTVuQzB6?=
 =?utf-8?B?U0lpZHptNTR1QS9CM0FmRE9iWXBVVUw3anpEZDN4YXNGQXgxQzdJQU85WTNT?=
 =?utf-8?B?Q0E3SVl6WS9hcWtCcXV4UVM5UXNXdlJqNUQvd3BrL2l1MzZVWEorKzZKTmFB?=
 =?utf-8?B?Q00rQWlFUVRjaEdmQkltdTRWbnJFa1hwdHVqQ2VEVEJRaFBiQ1k2Ly8yMXBH?=
 =?utf-8?B?Q2xZWHRPSkZhK0NkNUVsVkJtcnh3UU9pVytxNldLRGhicXc4c0VzNVlyYnE2?=
 =?utf-8?B?QVdFL3hxNG9XN2liWi9FWHhOaEtGelpoN1lxTDgrK2dJdEVMVTFqS3FUc0Zz?=
 =?utf-8?B?OEJ3a0owbWF3c0pWQTNvYU1mUzU0a25BdUJTclVHYngzQzNjS1Z1bVpZRE52?=
 =?utf-8?B?S0dWVTBvWGRZRjY0RnFxYUJJK3BIdGdlZlpGYkFwNHAyYVZ4TkRNL0IxTVdZ?=
 =?utf-8?B?OW8wK05XRUh2VTRFbkRrQmRqVzlST3lzZjluSTlwSTl4ZzZFNG1laVo1SGor?=
 =?utf-8?B?UFdLYURTdUxZQ2VrbmJBeTdoNXhGY3c0WVlSa1g0Q3h4MVNSRnMyaldIaUFl?=
 =?utf-8?B?K0E4bENEeG8xenRzNmJTOVA2ZURYVFM4ZUtNd1RSVmRsdjQxelBxblA5dmJ3?=
 =?utf-8?B?aDVzTWNGZ2JEVGNmVTdxTVZ2VVBKM0FBOGFZamR4blY0NXNXVmRQSStQV2Ur?=
 =?utf-8?B?M2oweTJmQVlBem5XbnRhN3JPTnY2Sjl2WUZXNHozK042dzhtcnhDNTZCME1X?=
 =?utf-8?B?eldQTUJTMkdYMFZMVHlQcnMwNXZXYXhSOWQ0V2tOZFI1OHRZTVYvNDBMcHFa?=
 =?utf-8?B?Q0k0bzBZU09ObW15OG5lSG0xNU5ETVZNQy9YemRVZXZsdE03SUI5WWZYZUJy?=
 =?utf-8?B?Z3RKakRzMTBYZGoxQ0FWM1JyWXBkclVLUitSZzdSY3loTSt3L09VeG1uTnlN?=
 =?utf-8?B?YnJEV3VoYUhLK2VBbzY4eFZrWmhyeDQ0bUZ2WFJ1SUNyRnFkSVhCd2h2RTM1?=
 =?utf-8?Q?6fikWyO5DM0vUY4cqFpNerVB4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac975f1-ff1f-4305-fe7a-08dc4cfd8044
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 18:58:04.3383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ukqc8n/rFrQAm9zeo4Cs3jVLulkBGU6fWZvdWRF0YjGKDQixOHoWwSsG6z+9VGmTD4CVDrXUoa7M3jXBJJzoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
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


On 2024-03-22 12:49, shaoyunl wrote:
>  From MES version 0x54, the log entry increased and require the log buffer
> size to be increased. The 16k is maximum size agreed

What happens when you run the new firmware on an old kernel that only 
allocates 4KB?

Regards,
   Felix


>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 9ace848e174c..78e4f88f5134 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -103,7 +103,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
>   	if (!amdgpu_mes_log_enable)
>   		return 0;
>   
> -	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_LOG_BUFFER_SIZE, PAGE_SIZE,
>   				    AMDGPU_GEM_DOMAIN_GTT,
>   				    &adev->mes.event_log_gpu_obj,
>   				    &adev->mes.event_log_gpu_addr,
> @@ -1548,12 +1548,11 @@ static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
>   	uint32_t *mem = (uint32_t *)(adev->mes.event_log_cpu_addr);
>   
>   	seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
> -		     mem, PAGE_SIZE, false);
> +		     mem, AMDGPU_MES_LOG_BUFFER_SIZE, false);
>   
>   	return 0;
>   }
>   
> -
>   DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 7d4f93fea937..4c8fc3117ef8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -52,6 +52,7 @@ enum amdgpu_mes_priority_level {
>   
>   #define AMDGPU_MES_PROC_CTX_SIZE 0x1000 /* one page area */
>   #define AMDGPU_MES_GANG_CTX_SIZE 0x1000 /* one page area */
> +#define AMDGPU_MES_LOG_BUFFER_SIZE 0x4000 /* Maximu log buffer size for MES */
>   
>   struct amdgpu_mes_funcs;
>   
