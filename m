Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4380D5B87F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 06:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBCA10E147;
	Tue, 29 Oct 2024 06:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fxXMiqHb";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379E510E147
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXOxQOeqqel4nr8Aq+wtU9lZlSuMU/4uTajR9p1hgzPlG0LiP1Uw8Z/OZ4EMva0kt5ywhnaw3unvC5OncOOuH6kSWGuCbsVsf0H/hyJpkBspU3gN6Hy+QB6C8OpAd+6PZmRuvNtEzVFGlbDKpOHCLYsMlI0DNXCTp7qwnPG4cCqKlS328zVX8dQx4ayPgfpA4t9PG6Z3XHy82EiSl+NDFNMXeqcGnQwBRW2GUdGhTWQ/1ei+2kJIbmf8rQ5UGRIv7fu0BN7KelIhJ3DfgMCMWzkamdajpU7q4rbF/+8sXqdNypi3cTwTFT8dLHpKEH/KTXEVMaMI38dSlQ1bxlDafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcWP8KntcIQY/2CYihvvUhRdllWQmo63NINyhyu7ulw=;
 b=LQbTZHghIS5xwBllhajyBQg7FEmvmE9GyEWExbD5maHE4KBbh79mvXGkOw/kopdVP6hly7hT2glCVNFcKxfXvFlmUq7y6BFwiN6FjsvkGKBK+ZYoDXNR+udFC3CyuS1MlKJbGizMJdpQ7U+h8h2tPTMfqCMtHM3m4Spoze0MSds1zs+pP3RP0Mc/aOixPNj/nESw3jg+GjJTWvpw6KjEtHs1FZNIsYHicJ0WKmIQyhv7VUBAEbxp8C4fFG6VXnf4qO4mbzBlU+r4/ywlvq03mubNr+Zn736ilbVmxcfKQgihJRk/6xkbnP98tiTIhu/FqOJhj7HmgsAAU84H0zKr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcWP8KntcIQY/2CYihvvUhRdllWQmo63NINyhyu7ulw=;
 b=fxXMiqHb42nErCf9M4MpnbFTxi5kst8JpBInTTaIDVLlgkuuWH4xUiMHWm33DQwwEdtsUBENHrrHaO25iE9oU3Ih9h4CJsf5pBy+ICGQ6ABQ0UOKXu8E7kHnnt/zXtNGROwku/j5DdAdWxxLnx1vdtmrNXs6JJA/bk/OAo0ea/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 06:37:20 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 06:37:20 +0000
Content-Type: multipart/alternative;
 boundary="------------mV2B0dKDwrCpLJVFPZPIwjLo"
Message-ID: <93ad9f9b-9803-4ba3-b29a-06b5c53b5ccd@amd.com>
Date: Tue, 29 Oct 2024 12:07:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Group gfx sysfs functions
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20241029052700.3164571-1-lijo.lazar@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20241029052700.3164571-1-lijo.lazar@amd.com>
X-ClientProxiedBy: PN2PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::12) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: fe63b266-f116-4a4d-0c20-08dcf7e4238a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkRRb0RWdG5wSDlHT1BBQ3YzaG5XMXpaUzFna1dxa2hKZnNjV2FRK28rRHNI?=
 =?utf-8?B?c0s0Rm85NGQ2RjB1Vkl0TDd5NUpJUkZRRmx0S0djTVRoSi93ZXBoR0pPOUlm?=
 =?utf-8?B?OUUralZSQTd3SUpYZ3B5dlAxa0RBb3lTcnVkS0VVc0E2MnpvS090S2ZCSmF5?=
 =?utf-8?B?NzU4alEzbDloekhQb2JPZHptQU5ZbTB4UEpRTkpRNWZRMUg1cWw3SmNQMFNL?=
 =?utf-8?B?S21KU1hGZkpuMDVFUFVLQUdWQVU5VzUzOTJDdDFyRHQ2S3ZoNGtWZlU5RGd6?=
 =?utf-8?B?TThrVHZHd1R2c0dzMUtUckdJdDVvL3h5VjBvMTh0SFdNckU3dy9SYUJIZUhp?=
 =?utf-8?B?UlFBZzdRNnYwd0lVcmZQbE5Zcm9SQ3FnMUJFa3ZjRHQwMVZMSE5DczZ4QytQ?=
 =?utf-8?B?L1dOUk05THlBTjVrc3dVMkJkcXpWMENQN21zRjdwRUQzbjNsTTJ2UDVoQ1Ra?=
 =?utf-8?B?T0FrZS92VXJ2Ly9HOGRiekQ5L213NG53N0Z2N1pwemFpSnQ3WVNkNkc5ZTgv?=
 =?utf-8?B?WVE2SkIxUTBqVWlGNHFFNk9Mam9oRTdHRk5lVndhek5kS2ZpaW9oU0QwWFZy?=
 =?utf-8?B?RmMvcGlJQmUvVC95OWhXNXFtZk52SVcrYXVEbG9ZRFVLampLZlVuSHk3UjZN?=
 =?utf-8?B?THY5RzlGQnJDNnZlZU5sYWZCZUc3MmFieWFLcjhpcFFvSVR5elUxelRmVFVu?=
 =?utf-8?B?aHV4d0YyVUdta3MyQ2hWbSt2Ty9odFU5czNvd21MeUdOMTdIcm04cGhxeVF0?=
 =?utf-8?B?cTlBTDZJdTJ6RkVOOWo0QzIyekMrSjVVZVpiTW95VElpL3Yyall4RjV4amV1?=
 =?utf-8?B?Smh2NFRhNEZIWUJ5czJQSHkzcWVCeFl2TlRoOEYyVjRwRkE4N1JwemVIVTNC?=
 =?utf-8?B?amVXdTI5V3VNendmR3VGMmxNS3J4UStTTEhSdDN4Q0psTEVoQStpZXY0a0VJ?=
 =?utf-8?B?clRYL2VYamh0RG5zeXl3VW1aYlU2Q2hGcjJLQlpxSHJxMWc0cW5EMTh6WDcz?=
 =?utf-8?B?TlZpakFHNkN0VU90UjRzZnp1R1JYcXUxb21hUDcwK043Ly9RRHVBRUo5RERD?=
 =?utf-8?B?WnpTcFliR1V1KzJ1SmtYZDRVQ3JKUXZ0MWd5K3E3K1VES3I1TkNlNUJOWndv?=
 =?utf-8?B?WitPZW5jWUxlSlRJSzlJUk1FZ0VQMjU0bGEwTDRMaW1IN3M4MnVVODBjSEdL?=
 =?utf-8?B?V2MzWnNWeCtEanljcjNuVEtIVmkyS1ZnYXJpd0xhRGtWd3NyaHpFMnJoVnNQ?=
 =?utf-8?B?VjdyZjR2N0o2YVFxSUhpVlZiYy96MytPektiaDRaWWZVdlJwTTF6czNaU1pu?=
 =?utf-8?B?QllLQWdoeTdrS0k3WGVKczJqLzIwTTFpejJDY2xuR1MrK21ZMUJERHE4cUh6?=
 =?utf-8?B?ZEZEVU5SdlBMWDdnRjF6T2IzVXhUdHhCT0VRZDVJY0ttQURsVnV4MDd6cjdC?=
 =?utf-8?B?QWhJQUU2SlhIVU1kNXdtenZIa2JjaEdra2dPZ2dTd0NkcmNaMjNjcnBTM1E2?=
 =?utf-8?B?U2VPcE9YNlRCd0R2bVZFbGErVlZGaTJSeUx5ak42Y1JJNlpVeWtBbklEaTNK?=
 =?utf-8?B?bm1yYkVqQWFXU3kzWW1pa3NhQWttcU9jdlBYZmJ5dTJ2d2xXME9ERGFCSzY4?=
 =?utf-8?B?MGRXY1NZbE1NUU03S01nUnhlUGlFOTNVMTBSL2JQSnVWMCtYdjh3VWxzYUd4?=
 =?utf-8?Q?JKT+9NLugpKiPe3ABRwN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MncvelpQM3o1VW5scU5GZkN6cC9hWm1uU0NBTTdxL0dzNEJrTXZSU0RnZTl3?=
 =?utf-8?B?UWdPQlZ0aTA3dytyaVljbE8zMWx1MEQrWWl2R1J3NzhNckhjZklNNC9iNVFj?=
 =?utf-8?B?YnkzV3JTMWdqbFArYnVPTWRNbG41cUR0V1JCUkFwUGpVOVBXaytxUUkzZ0NQ?=
 =?utf-8?B?YXIwdkJGWm0wanM3UGJZeFJYRDlsQzBUMUozaTNlNGtMNXM3L0Vwbm9Ed2NZ?=
 =?utf-8?B?QzJSUG5Ja3VtRDM5Unk5ZGxwalhVdHBRQWh3K3QxUG9zWmxXVkFYeDVEcVdB?=
 =?utf-8?B?NWFDclE3UzVJL0ZsRHhTakdkVGczRFZMQWNCZUFqTzl0Q2pzTjhiV2NhQlVR?=
 =?utf-8?B?RkNyTnJ6RnFuclJlbDFtVFc5NVpKWkVoOUxEbWpTMjRONFNMTi9PcDFsMVBw?=
 =?utf-8?B?Y0NzSkJSWElNMjhzT2lKdEFLRXZrYkJDZ1plU0VGdWdKY2ROTzBmaHZraTQz?=
 =?utf-8?B?VElydWl2NmJaNVd0RmxlbnhwdjVtSWQ2ZUtqVFdMVExZU1JxeSt2dmthbWg3?=
 =?utf-8?B?QjJvak5MYVVzWVk2cHgyK3BNUTJVTkpkU3BpeHlnZ0RJOG9KeG5MM3dFVkdS?=
 =?utf-8?B?SEE0YWd0MGRtQWVPM2VieUpQL1JwTExaUXEvcGg4dUtYMG5ySlUvSEw0Y0lD?=
 =?utf-8?B?NFhyU3JTdUsxckRJSXR5Z212bDVSNTNQM293RkhHd2g1Y2k3Q1l1dnRLMjc2?=
 =?utf-8?B?dytoUGhSUW93N0xXUFhZL1lxYlZxdkZHUEFxbkxnbTNYNVl3aXBwRWYxYkhh?=
 =?utf-8?B?QVRGYndRQzdhdldRQ2QzK0w1RURzRlNRVUFTV25qYmtOYXZtaEJjaVhhR3ZU?=
 =?utf-8?B?NS9udW9Cb0xIeGFXUDJBT1BDUUlUOWtKa2RGeUJWZU1HM3hRUHJXQjRJZXNH?=
 =?utf-8?B?NWNLVmVtZVZIdGkrTjJWWml6L3dSMUQzUnJPbTVIQmJQRUxjcFNReVpLTFVB?=
 =?utf-8?B?dTZsQTU2QlVjaW5DTDB2RldSQzE4dmc3WllmR1NSTk8wL3ArM0Y3MmIvME5i?=
 =?utf-8?B?aFpTVjhJWlFNT204cUpUdjNQQXp3R2hKZ0g2emhUU3VoWW1rcTZNUGUwYzFo?=
 =?utf-8?B?V1diKzBzelhFWDhpeXE3VTN0KzYzcGZJSGpJZ09EN29Ed3ludEZUTFNxYVM3?=
 =?utf-8?B?Z2RyLzIwYzBra2llRFFzbW9VcllkOUl0NzA3SDI5QitHV29iOXBVdlZLalY0?=
 =?utf-8?B?L1FTSlJJL1lNZ3VlVUxXcm53MnVRZTYzQUQ4T0MwTVc4Zi9sVU1JVzRUMG1P?=
 =?utf-8?B?TGYvcXRzQm12SjlsemZSM2o3azQxWVdlQmZ1eTBZbGRwbVcydUt1bHd0b3lX?=
 =?utf-8?B?RTlwMlZPZ21DdlovL1BhK3JwMGJyeHJqbVRJaFBzTFdhYTE1Y2pBaFhaREYv?=
 =?utf-8?B?V0xrTjI2blNKNTNzTExTVzZsaDhtSWhTUWJFRWJWTzZZcVJUM1RaK2dOOFBJ?=
 =?utf-8?B?WlVnNHZVenh6eWFhUVN6a3M0NmhCeGtXd2J6VUNwdnR6YzYvSXJIK0VNT3RJ?=
 =?utf-8?B?WTZROUU3Y3NML051U2VLaGZWYkZvR1ZyUzVJYXh4eENJWjdlY2VWNDhKSVZu?=
 =?utf-8?B?RXFTMmhUOFZUYmNuMHNMWjd6djdBdnlYa2Exbkc5Q0FSajlrV1JXbDJuZW1E?=
 =?utf-8?B?NHdmQWdpbi81eFFMQlBuNkg3Y05zMldlMFhHNHNuamZtYkZHaFdIbk1UbW1C?=
 =?utf-8?B?Tkd4RGg4Qm9ycUxkWG9qS2cvaDM2RHZkTUVSbmtJWGpMeWdRUmZZV0NXM3pH?=
 =?utf-8?B?cmVJMnlpUnQ2WWZtRVF2VUtla0lrcGY3NzkyQXVxS29GVGgram9VRDdraFZp?=
 =?utf-8?B?QzhEQTIwbnRRRmVFN2N0VVVSM3hDd05ITGV3bWNMU0RtNzV2V1MyUzkrMDlB?=
 =?utf-8?B?S255MW1odG9sanViYTlWRE9pWCswRXBuN1pjQUxNSG42ait6YnN2TlRyTlBE?=
 =?utf-8?B?UkhjNTZ5WEJPcnBXUTgvTkF2MkpTMHRvT1RyamhDLy8vUlJXVUVjRlpyTU5r?=
 =?utf-8?B?b2JYbmh1U2FIR1lLM1g1OThaS1dwWlExTExDRi9pMS9Pak5raWFYbmo0cEJx?=
 =?utf-8?B?YS9BS1U4VnVtY0ZPczNEYVpBaElLZThVcDhRd3htaFhPNGdpMlluZjJwMHMy?=
 =?utf-8?Q?EVQovlh1Xt0BXJqfcPCjCYf2c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe63b266-f116-4a4d-0c20-08dcf7e4238a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 06:37:20.1955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elRYKBCc+MrdcrxMeuRbqO/9AX2muRojVJdrezj6yU4c3jEsSd5Jhl6qhCbjFU2+jm2twIe03VPYxlmCFYl6YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
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

--------------mV2B0dKDwrCpLJVFPZPIwjLo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/29/2024 10:57 AM, Lijo Lazar wrote:
> Make amdgpu_gfx_sysfs_init/fini functions as common entry points for all
> gfx related sysfs nodes.
>
> Signed-off-by: Lijo Lazar<lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 37 ++++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  5 ----
>   7 files changed, 42 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index e96984c53e72..86a6fd3015c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1602,7 +1602,7 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>   static DEVICE_ATTR(available_compute_partition, 0444,
>   		   amdgpu_gfx_get_available_compute_partition, NULL);
>   
> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
> +static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>   	bool xcp_switch_supported;
> @@ -1629,7 +1629,7 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>   	return r;
>   }
>   
> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
> +static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>   	bool xcp_switch_supported;
> @@ -1646,10 +1646,13 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>   				   &dev_attr_available_compute_partition);
>   }
>   
> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
> +static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>   {
>   	int r;
>   
> +	if (!adev->gfx.enable_cleaner_shader)
> +		return 0;
> +

This check seems to be incorrect here, because enforce_isolation and 
cleaner shader are two different entities, with this check 
enforce_isolation node won't be created for some of the ASIC's where we 
don't load cleaner shader explictly.

And moreover this grouping, its better to be done for all sysfs entires 
in amdgpu ie., not only gfx, for other modules like even pm etc., so 
that we can have one common sysfs amdgpu framework, improving code 
consistency and maintainability

I had initiated this https://patchwork.freedesktop.org/patch/595215/ 
<https://patchwork.freedesktop.org/patch/595215/> , but I couldn't 
finish it because of other work commitments.

>   	r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
>   	if (r)
>   		return r;
> @@ -1661,12 +1664,38 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
> +static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
>   {
> +	if (!adev->gfx.enable_cleaner_shader)
> +		return;
> +

Same here

-Srini

>   	device_remove_file(adev->dev, &dev_attr_enforce_isolation);
>   	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>   }
>   
> +int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
> +{
> +	int r;
> +
> +	r = amdgpu_gfx_sysfs_xcp_init(adev);
> +	if (r) {
> +		dev_err(adev->dev, "failed to create xcp sysfs files");
> +		return r;
> +	}
> +
> +	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +	if (r)
> +		dev_err(adev->dev, "failed to create isolation sysfs files");
> +
> +	return r;
> +}
> +
> +void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
> +{
> +	amdgpu_gfx_sysfs_xcp_fini(adev);
> +	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +}
> +
>   int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
>   				      unsigned int cleaner_shader_size)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f710178a21bc..b8a2f60688dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -577,8 +577,6 @@ void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
>   void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>   				    unsigned int cleaner_shader_size,
>   				    const void *cleaner_shader_ptr);
> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
>   void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>   void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>   void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9da95b25e158..d1a18ca584dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4853,9 +4853,10 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	gfx_v10_0_alloc_ip_dump(adev);
>   
> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +	r = amdgpu_gfx_sysfs_init(adev);
>   	if (r)
>   		return r;
> +
>   	return 0;
>   }
>   
> @@ -4907,7 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   		gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
>   
>   	gfx_v10_0_free_microcode(adev);
> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_fini(adev);
>   
>   	kfree(adev->gfx.ip_dump_core);
>   	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..22811b624532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1717,7 +1717,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	gfx_v11_0_alloc_ip_dump(adev);
>   
> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +	r = amdgpu_gfx_sysfs_init(adev);
>   	if (r)
>   		return r;
>   
> @@ -1782,7 +1782,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	gfx_v11_0_free_microcode(adev);
>   
> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_fini(adev);
>   
>   	kfree(adev->gfx.ip_dump_core);
>   	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..1b99f90cd193 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1466,7 +1466,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	gfx_v12_0_alloc_ip_dump(adev);
>   
> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +	r = amdgpu_gfx_sysfs_init(adev);
>   	if (r)
>   		return r;
>   
> @@ -1529,7 +1529,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	gfx_v12_0_free_microcode(adev);
>   
> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_fini(adev);
>   
>   	kfree(adev->gfx.ip_dump_core);
>   	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 66947850d7e4..987e52c47635 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2402,7 +2402,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	gfx_v9_0_alloc_ip_dump(adev);
>   
> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +	r = amdgpu_gfx_sysfs_init(adev);
>   	if (r)
>   		return r;
>   
> @@ -2443,7 +2443,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	}
>   	gfx_v9_0_free_microcode(adev);
>   
> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_fini(adev);
>   
>   	kfree(adev->gfx.ip_dump_core);
>   	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 016290f00592..983088805c3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1171,10 +1171,6 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	gfx_v9_4_3_alloc_ip_dump(adev);
>   
> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
> -	if (r)
> -		return r;
> -
>   	return 0;
>   }
>   
> @@ -1199,7 +1195,6 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>   	gfx_v9_4_3_free_microcode(adev);
>   	amdgpu_gfx_sysfs_fini(adev);
> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>   
>   	kfree(adev->gfx.ip_dump_core);
>   	kfree(adev->gfx.ip_dump_compute_queues);
--------------mV2B0dKDwrCpLJVFPZPIwjLo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/29/2024 10:57 AM, Lijo Lazar
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241029052700.3164571-1-lijo.lazar@amd.com">
      <pre class="moz-quote-pre" wrap="">Make amdgpu_gfx_sysfs_init/fini functions as common entry points for all
gfx related sysfs nodes.

Signed-off-by: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 37 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  5 ----
 7 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..86a6fd3015c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1602,7 +1602,7 @@ static DEVICE_ATTR(current_compute_partition, 0644,
 static DEVICE_ATTR(available_compute_partition, 0444,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
-int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
+static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev-&gt;xcp_mgr;
 	bool xcp_switch_supported;
@@ -1629,7 +1629,7 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 	return r;
 }
 
-void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
+static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev-&gt;xcp_mgr;
 	bool xcp_switch_supported;
@@ -1646,10 +1646,13 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 				   &amp;dev_attr_available_compute_partition);
 }
 
-int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
+static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 {
 	int r;
 
+	if (!adev-&gt;gfx.enable_cleaner_shader)
+		return 0;
+</pre>
    </blockquote>
    <p>This check seems to be incorrect here, because enforce_isolation
      and cleaner shader are two different entities, with this check
      enforce_isolation node won't be created for some of the ASIC's
      where we don't load cleaner shader explictly.<br>
    </p>
    <p>And moreover this grouping, its better to be done for all sysfs
      entires in amdgpu ie., not only gfx, for other modules like even
      pm etc., so that we can have one common sysfs amdgpu framework, <span data-teams="true"><span class="ui-provider a b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr"> improving code consistency and maintainability</span></span></p>
    <p><span data-teams="true"><span class="ui-provider a b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">I had initiated this </span></span><span data-teams="true"><span class="ui-provider a b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr"><a aria-label="Link https://patchwork.freedesktop.org/patch/595215/" id="menurifo" href="https://patchwork.freedesktop.org/patch/595215/" rel="noreferrer noopener" target="_blank" class="fui-Link ___1q1shib f2hkw1w f3rmtva f1ewtqcl fyind8e f1k6fduh f1w7gpdv fk6fouc fjoy568 figsok6 f1s184ao f1mk8lai fnbmjn9 f1o700av f13mvf36 f1cmlufx f9n3di6 f1ids18y f1tx3yz7 f1deo86v f1eh06m1 f1iescvh fhgqx19 f1olyrje f1p93eir f1nev41a f1h8hb77 f1lqvz6u f10aw75t fsle3fq f17ae5zn moz-txt-link-freetext" title="https://patchwork.freedesktop.org/patch/595215/">https://patchwork.freedesktop.org/patch/595215/</a>
        </span></span><span data-teams="true"><span class="ui-provider a b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">,</span></span> but I couldn't finish it because of
      other work commitments.<br>
    </p>
    <blockquote type="cite" cite="mid:20241029052700.3164571-1-lijo.lazar@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	r = device_create_file(adev-&gt;dev, &amp;dev_attr_enforce_isolation);
 	if (r)
 		return r;
@@ -1661,12 +1664,38 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
+static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
 {
+	if (!adev-&gt;gfx.enable_cleaner_shader)
+		return;
+</pre>
    </blockquote>
    <p>Same here</p>
    <p>-Srini<br>
    </p>
    <blockquote type="cite" cite="mid:20241029052700.3164571-1-lijo.lazar@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	device_remove_file(adev-&gt;dev, &amp;dev_attr_enforce_isolation);
 	device_remove_file(adev-&gt;dev, &amp;dev_attr_run_cleaner_shader);
 }
 
+int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = amdgpu_gfx_sysfs_xcp_init(adev);
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;failed to create xcp sysfs files&quot;);
+		return r;
+	}
+
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		dev_err(adev-&gt;dev, &quot;failed to create isolation sysfs files&quot;);
+
+	return r;
+}
+
+void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
+{
+	amdgpu_gfx_sysfs_xcp_fini(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+}
+
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
 				      unsigned int cleaner_shader_size)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f710178a21bc..b8a2f60688dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -577,8 +577,6 @@ void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 				    unsigned int cleaner_shader_size,
 				    const void *cleaner_shader_ptr);
-int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
-void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9da95b25e158..d1a18ca584dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4853,9 +4853,10 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v10_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
+
 	return 0;
 }
 
@@ -4907,7 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
 
 	gfx_v10_0_free_microcode(adev);
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev-&gt;gfx.ip_dump_core);
 	kfree(adev-&gt;gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..22811b624532 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1717,7 +1717,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v11_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
@@ -1782,7 +1782,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v11_0_free_microcode(adev);
 
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev-&gt;gfx.ip_dump_core);
 	kfree(adev-&gt;gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9fec28d8a5fc..1b99f90cd193 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1466,7 +1466,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
@@ -1529,7 +1529,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_free_microcode(adev);
 
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev-&gt;gfx.ip_dump_core);
 	kfree(adev-&gt;gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 66947850d7e4..987e52c47635 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2402,7 +2402,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v9_0_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
@@ -2443,7 +2443,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	}
 	gfx_v9_0_free_microcode(adev);
 
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	kfree(adev-&gt;gfx.ip_dump_core);
 	kfree(adev-&gt;gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..983088805c3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1171,10 +1171,6 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v9_4_3_alloc_ip_dump(adev);
 
-	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
-	if (r)
-		return r;
-
 	return 0;
 }
 
@@ -1199,7 +1195,6 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_bo_unref(&amp;adev-&gt;gfx.rlc.clear_state_obj);
 	gfx_v9_4_3_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 
 	kfree(adev-&gt;gfx.ip_dump_core);
 	kfree(adev-&gt;gfx.ip_dump_compute_queues);
</pre>
    </blockquote>
  </body>
</html>

--------------mV2B0dKDwrCpLJVFPZPIwjLo--
