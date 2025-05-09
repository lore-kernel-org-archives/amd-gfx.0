Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDE1C3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 11:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BACD10EA16;
	Fri,  9 May 2025 11:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L23S62yq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA8A10EA16
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 11:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNGhMmvwJ1+AIIxy+fjHq3MZY075ZQqY0Ryq6tbAKvnau6RD0wZJAFfMRlLSUG/DooCE4Yx5p3BYIp1LJdHHRE6vcuwHG8w3Bjq3FZrNRqyqmeoTZjS79jqTU7hJ0sIOJLyG21zPuHmQqjVRnKlE6pGD7tmkEMqJZDIwaBzRsqxOhskR21ZxVh2etVcbGkVEGp2kc6QbgRN6H+WHD827fwizWOW9i+LL9wXbRmF7uwX9ZOBFoKgXW7OJCHtnY4DbFZTUz8XnVEKvCNvHctq7lQwNB+7gCfd8ba7d4gAY7vG82JjfWSlrS1cAvsSp5gxSqB53rFrK0y+P6f+VI6XBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8dbn6R/srxLyUGCFh8DkSCt7TU6JGD8hkA4lphIXHQ=;
 b=FetIn7AjzvDfbQVtyV8hxN3jkItZ3Dl0p87l+1clRUh3d13E5t+KfNzlCoQt/S4Y4ZQehhb8iGY8zibGRltXkTD0lhcDE+oQpeNwSHclFa6sgMaO8OzTR/pvyxC04/uVixNiY/s41+a1PieJaAmrkVvQ6ZL/XxYEtFa66V2/oRE0mqFifP2KxME52vTIDvS/UO+V0L5OBdsbTOfnV9J61ULWMPQHlI2csa+2s/WWr56iRcd4WNMwwo8VjAJAxI2E2Nt341jGA6oFEoN/Ow6pOS7wAHUonsJZwzuhhXz7yCmwUOi95ddKJIFaNk2xNTBHxh4Mfk3Z2OZXL4nnb6q32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8dbn6R/srxLyUGCFh8DkSCt7TU6JGD8hkA4lphIXHQ=;
 b=L23S62yqFx1beD1xfxP2AYgX2m52fjTy/MFG5IXohPM3jdeOR2mWEWuOv58pLJsjcECGrqtYg8sJbzLoktd9ErXYvSGputdczZ+iPh6/KuwIHFZQoiHFbPWcAGL58EuoQftHMjzIZoP6FHeD7ZufKj0WETJMHcZkuLmlOnwoZ80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 11:10:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 11:10:15 +0000
Message-ID: <c21fc4a9-744f-4e3d-a9f4-8eadbcb4a549@amd.com>
Date: Fri, 9 May 2025 16:40:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add GFX 9.5.0 support for per-queue/pipe reset
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Asad Kamal <asad.kamal@amd.com>
References: <20250509093813.3669072-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250509093813.3669072-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdb382d-1dea-4b71-3ac3-08dd8eea12cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGZWY3hqL0FhdG9VTnE1VmswQk5ReS9PQ1RtZlVheDIzemtrQkxTWmdZWDZv?=
 =?utf-8?B?ck14Mngyb3RwYTRwalFrclZGSTY2Wit4aGdYNEp1OTI2OVZnK3hhS21aU1ly?=
 =?utf-8?B?Q1BCbjJFSHVyUXo2V1ZhdmJvOWtiWkJGWG1kamhVSmJpc0tQNGRsMzFKci93?=
 =?utf-8?B?R0pyRURYUHNBRC9lSGRrYWpCelU2VTZhN1R0ekRrZUplUWJRdHl5Z2VxSVQ5?=
 =?utf-8?B?R2dVVWF6VTJZTTUzbHFBbDdXaGJXNm5JSFVyd3cxVC9iNHhYUUdTTk8rZFI1?=
 =?utf-8?B?UUMwV2c0anRqNFNPemJMZEdUaGpGNTRkZi9BVjFvczJ1QXpIZUM4WFE5OG0z?=
 =?utf-8?B?MVNvNVFPQjJmMmZYRFkrUm5JdEFFZW0zZGZrSmgrRFZNem43by9heVY4VmNI?=
 =?utf-8?B?YWJqRG9aU0d5VjA5WlhxbllpUUdrYng4OWtWQVpiWDNDRFpOMFNLMWdSS0VD?=
 =?utf-8?B?Wml5ZmlmRFR6ZWlTdXFwU1JkbnFBaEhzVDZqb3NSVFhRQlZpSHV2SjU5MzZ0?=
 =?utf-8?B?L2ZYcFdKdkpKMENVSjB3VTdNZHptWlozem12MDFIclJobmZRMVRObW9BQngy?=
 =?utf-8?B?a21oQVVqamVPcWtFTTUrWTY5N1dQSy9odXdVYXBHT3pKMituUHplVUYwdzRk?=
 =?utf-8?B?eFU3VnlEdS9NRm0zbnl5YzRXVXlkOXdXSGthbXo3Wlo4cSt5eEx3ZlFvbGdB?=
 =?utf-8?B?WUp1dllDSU1MTW1QZ202N0p6a282aHNRTkRyZE5ibE54V1dtOVZoNkd6WUd1?=
 =?utf-8?B?VTA5NlBTRDcrczlTdnRKSGpON1luNjNLV2pFUlpTRHFqUlpkc0owdGxNNGR3?=
 =?utf-8?B?aHJkaVJpNXpMK2YydC8rOUEzK3Vld0lVbExkcVFvOXBtNDJBK2Q0VndkZEJo?=
 =?utf-8?B?TmtEdUN1bE91MytKWXFBWldlejhSUjNHWFU0NTVYNFljMC9YL28xNFdkakRU?=
 =?utf-8?B?dmdhY0JZVjN2cHB3Szc0R1JHY3hBYjN5VnUvQkMrYXExV3pnVEVBeEUwUm1a?=
 =?utf-8?B?MmVueWNjWlorNURZYUxhNHN6eXpoSTFvNW4xMm5Ec3NHT1cyQUlkNjRkQ2hV?=
 =?utf-8?B?YTJHRUF2UFhBVGJVSTU3QXdrL2tBYVNOekZsbytSci9BcmtzbjRKYkV5SHUw?=
 =?utf-8?B?TmZjdlZ5VEoyOElnb1QwVFcvUWlIcVhjM284eDJxVmdjSlE5SEJRL1ZhY2F2?=
 =?utf-8?B?QThRV010OTFZc2FrUzErMjdnTFFBYVZYanpRRDJYMk5NY2VSbEVDd09LTFMv?=
 =?utf-8?B?c2VCajF5dkpzOURZSnpNclg2cEtVRzRYMmJCSy9MS0NYN0tEaEJ1dDZJWWY3?=
 =?utf-8?B?cVFVQ1V2YUdNUHRINTE3YjlUeHJLVGZQRVVLZ3J1SnY4NGhPZ1dtOSsvN05v?=
 =?utf-8?B?cWhWcE5vZkFJcmVPV3ptTCsyNTRmWFpRM3MwNUxrQ0k4VWpCNDVwZi9zRXlY?=
 =?utf-8?B?eTBKYitjK1paOUgzTk1FWEtsWWF2T3JFaHRzWldha3lEVWQrMmlBWlpzSytm?=
 =?utf-8?B?UXArV2ZTZ1NaekQ4aG5LSkNOYjVXanhqVUtSaEt5UlVQZGpXSWcrYXROQS8r?=
 =?utf-8?B?MHpCUXBudFEzcnRVU3BQS0t6REVCYjJFY2g1dnB5V0FOMHErSE5rZzdaQlVh?=
 =?utf-8?B?YTltamZxUzl6YW9JU3BQbE9ISlBUVmpCUVdNenRaamNWeHlLZnh5YkhrRXo3?=
 =?utf-8?B?dUR3VHVsbGZLSUpubWZXN05TdHZ1bDBEU0NBYnJXNlE1QjhBYlNLUmJweStv?=
 =?utf-8?B?blJzQjRRK0NsMWxKNklwTndQemFEM00xRmZlZDU2WkFIVEhSSTJNUFVyQVg5?=
 =?utf-8?B?N2tTV0pGUmVlWUs4bkJPQmVwZTlwOFloQjU2Tzd1UElpVmpXbEpiMjBmdXpJ?=
 =?utf-8?B?dGFWWEhiazRqdWxEZVJKcjZvMEw4U1ZQSTVZckJNTFZyQXF5L0cxYnhFQ25m?=
 =?utf-8?Q?2rsGbx57ENQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkIwM3UySi9kTkZEMlI3dnEzT2FYdXpqbHdPQkc5S1QyS2RKMm9naUdqc2p3?=
 =?utf-8?B?V3k2NHNlSjZreXhPZjYzQjU5MytkeTF5WGlxbDEvYy9paDczL24zV1VxL0pO?=
 =?utf-8?B?ZmFkSG9XZTNYaXl0NGVrV0lRQitITm10bzFwR3pIZFRJd0JwQm4rNDQxT0dr?=
 =?utf-8?B?VzI2ajJkd1paR25ZRUVweHNXRnJDSjIvTDFDRU1waHIyZERaODFDakUwcFgr?=
 =?utf-8?B?b2V3ZWlPZGtVWnpFeVprQlRyOWtpOGFXTzYwYWowRXlFM0d1ZnNSMHlMakV4?=
 =?utf-8?B?VzE0RXVLWmJyZjRQdWVZcEs3bmkzT0lLOU9GSHlqMnFuaVJYbXB3T0UvR21a?=
 =?utf-8?B?dWFqemxxVU4vWmFrdVlzekdVd3N2MUFqZFhjL0puYnZjSTBxR25mbzhkTTBz?=
 =?utf-8?B?eXVpZ1IrcmluRlljRVNXeUIyb3V5ejFMWDdvdGNZVlZUSTlLTmZsL1J2RTdF?=
 =?utf-8?B?V0ZWYVR6WEZBUkhrRU4xRmZkeENCdzRYNkVsYjJOYXBrZFpINUNMRktnZE1m?=
 =?utf-8?B?N2xNS0hLRDhIQnJQUWNSZ3k4TjJzTVM4NDhrNTVYQmowNVdtd2luSWxMd1A1?=
 =?utf-8?B?MnNkNjVBVmlwUkc0YXNtYVFYeHN2OC9TRGEzdlk5Smk5VC9GQ2h6SnRyODBL?=
 =?utf-8?B?Qyt1dW1UUFpxUHp2aWVHbGUraGp1RXl2SmJETFowMkpUUFQ4WksrYVFXYXZp?=
 =?utf-8?B?QW5ncUk3UXIvTE5NTGM3NFFmVlBPcTZVeWQxWWpHTnZzOHVKTDNKTkt5NTg2?=
 =?utf-8?B?RDNWVVVGREFLMXpsRW1WVEg1M0tPS0VoOWE2K21BeVFDMjdPU2ZuckZSQzh0?=
 =?utf-8?B?VE85Sk16RXJndmRJc1lXSXB4L01HMWpTR0tYdU41YzErMTh3RGd4UzZmZ0M0?=
 =?utf-8?B?S0tCNEF6dXl0eWd0QTF1bDBKWnZZdHlhbTUrZXlwaDhaWXdwS1pjZWk3b2I0?=
 =?utf-8?B?N1hWWXFndlJXWnJxalVQNFhjSjBzWmJONzFoR0RPQ2EweEEzcHl5cWpIZW9u?=
 =?utf-8?B?WHdaSnl3bHFzaTZMUExjTjlVT0MvemxzR1NDU2YzaGdIam55Tk8rVHhkc2kx?=
 =?utf-8?B?QXNZb2wvNkQrR05acFJjcW9IeG9MWDZsRjZpUHNCdGtPL0RMSmhJT2FGb2NO?=
 =?utf-8?B?cVg1alRweVBtK0NVa05VUFcwRjRPVFJCMzVwYTVWRjR0SndmQWt2NFRpVXpS?=
 =?utf-8?B?UzZFbGhhS0dzcG9FaksxNk9qaUhHNFdYM2ZLUlpsVTZwL0NzUTdzc0NFbm1q?=
 =?utf-8?B?RThkVm5BSGhFbGwyTHRWUFVld1h4TEZFY0V3OGxlaG8yY21TdHBPVDU5RmVH?=
 =?utf-8?B?V0F3akc3cmk4ZWw4bi9zeGd2bUNTK1RNaEJDR3V5RXd1aEVOeTAramp1Q2dO?=
 =?utf-8?B?NTVLS3NtTnZjMHFqL2ZFK1lHQzNkQ21lc2JSSElPYTdDYnRNZzhsZFc5d0tq?=
 =?utf-8?B?M2VmaElvMEVmVEFZVGN3MHkxWUI4cW9qamZwTkNnMFZya1dSclovcCs3aE1q?=
 =?utf-8?B?OW9qZThQVWNJbm9mN1dROW13TGFwcUVDc2ZHU1luY2JWVmFMdlJoSXVpNmhG?=
 =?utf-8?B?SEJjVnc4dEM4MkJBVW5rV3NNd1ZGNzFURXZyL0pqMTRwNy93S1VrY2tRY2dU?=
 =?utf-8?B?UDlPZkJTSVlobWxOdmpESTNZdmNFdXVjMXRyZFM0dFFJRitCeHFEMG5ZK0lt?=
 =?utf-8?B?RUdTdi9XMnpXMlYxanFrYWsycmdVdjcyRkdtTTZWKzZDUFRYUW5YOFZnd0x2?=
 =?utf-8?B?bTJTMTRKZTNNL2F2N3R0V1pqS0NJbnZ3RWpDOUFpNHpleDkrZE1vWkhKZmtJ?=
 =?utf-8?B?bXR3MzY1eE1BczM3c1NtOWVkVG1VTXJsUkI0cS9COUlFRElNL0s1WExDUUE4?=
 =?utf-8?B?RmhKOXViTjlhayt4TER3V0czb3ozZWFwYlJIQU9UWFlkcEVLTkpyYzcxdzFh?=
 =?utf-8?B?dmY3bDAxSks4bUNZSlJicjM4ejBmM1BvREZVcFJLQUtRLzRVajlWbmtwY2gw?=
 =?utf-8?B?VzNlYWtzZWhhcG82Nll5aEgwNGZsV2NyS2RmL3NZcWlGM25OVlVnQnlqT2lj?=
 =?utf-8?B?blU4YUp4TE9leEpDbnE5ZDJ0YjMvRVNQUU51YlpxYkdZR2k0Q2tnYS9iNVF0?=
 =?utf-8?Q?Uws6GbJCqZaWJ5qskLoE5/V2P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdb382d-1dea-4b71-3ac3-08dd8eea12cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:10:14.9252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wp2Stfr9AxXfQcpZzWbarv0Y+QcsdzN+7WK5NPppG+z9wgbOh4mgffWfKYtpYYR6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
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



On 5/9/2025 3:04 PM, Jesse.Zhang wrote:
> From: Asad Kamal <asad.kamal@amd.com>
> 
> This patch enables per-queue and per-pipe reset functionality for
> GFX IP v9.5.0 when using MEC firmware version 21 (0x15) or later.
> 
> Changes include:
> 1. Added IP_VERSION(9,5,0) case in gfx_v9_4_3_sw_init() to enable
>    per-queue and per-pipe reset flags when MEC FW >= 21
> 2. Extended pipe reset support check in gfx_v9_4_3_pipe_reset_support()
>    to include GFX 9.5.0 with MEC FW >= 0x15 requirement
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 9db2bde5c59d..a832639c07b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1153,6 +1153,12 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>  			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
>  		}
>  		break;
> +	case IP_VERSION(9, 5, 0):
> +		if (adev->gfx.mec_fw_version >= 21) {
> +			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
> +		}
> +		break;
>  	default:
>  		break;
>  	}
> @@ -3453,8 +3459,10 @@ static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
>  static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
>  {
>  	/*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as well.*/
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> -			adev->gfx.mec_fw_version >= 0x0000009b)
> +	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +			adev->gfx.mec_fw_version >= 0x0000009b) ||
> +			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) &&
> +			adev->gfx.mec_fw_version >= 0x15))

I think this can be replaced with !!(adev->gfx.compute_supported_reset &
AMDGPU_RESET_TYPE_PER_PIPE).

Thanks,
Lijo

>  		return true;
>  	else
>  		dev_warn_once(adev->dev, "Please use the latest MEC version to see whether support pipe reset\n");

