Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD21C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 15:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70F610E502;
	Wed, 24 Apr 2024 15:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PnhzHweV";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03FE110E502
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 15:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGi/QxeS4rng7QtP1OUOcnw2LUXL0VX2H6pfK5qiY0IU2dXX2h9WwXUdpm5ORIdGbOrYqIqnTR295Fnc96Jw+rIPEWoVcjxPErn6P+9UKHOwVzZLKy3+8UnzaJFjLGgaRbIVGYEM/+B3T9fGrVxBfq/qMJVbWhuUqnn/Il0O76VMFw4AJZJbg3WpNdIaRPZ37JIvoePL33G6GVvBB1X1lySw1kLiZOcNiBnn6J/QpVZsSFxdE3RL6bOAjKVSVmehdt7PqcPJk6RpH7wNl0VjNxjt9EzsosUjUURHM2WY3FxLz3XqaIMKFqxqTAmcQD7EDS7j3r50JsVpbe4pQiXDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovpqt+maz2NH/5DLxvH4nzRBcfBvV5lj7bmPHP06Q6c=;
 b=bsgyWofWp5hLhFJltuPCslXQfrxFsQmPT9gkto5X8DAZgpvuakbws8sg9UEyP4IUMvk3W8rMiyocj0G8hRIDDbsOzZj1XrABC8mbmu2mgZDsQpbB9qq6EKC0OJarLa69UOqa/0I+rBF0NvFPjj4ta3ScYclQTUUXRAB8GEB2UoSLRVpb+DkWGF5nLKg50BA7ITHTv9rW2cC8MXWkVcqU9KGV//FDZds8aHWG7fOmp6i9rq9nGwf3OmFDbijmHqueNaTs9j/cBFFKyts6PLNYK1QTn9Oj/zyahY/K4bhkyztXvcQLZzLXnJvZLiHqHTJO0kUNXukEKgM2SNfGQknssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovpqt+maz2NH/5DLxvH4nzRBcfBvV5lj7bmPHP06Q6c=;
 b=PnhzHweVFP0S8RBj1oK3FYcgSwZsumbSMpk5JBySfLszwIJIc19f9NpmoJCU3Z0mnMjD/+c8VCii33RfLyQdlCaLvumnkkdsAkeKhWIuRe3O77fb6YdGZlAZ8v/C49E5/cr9BH7X9vfDnkv6FWY11KNIoPhrjRB5SELPD26d15c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:39:22 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 15:39:22 +0000
Message-ID: <b254a0c7-9cc1-4bb3-a40b-b90b167a9824@amd.com>
Date: Wed, 24 Apr 2024 21:09:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix buffer size in gfx_v9_4_3_init_
 cp_compute_microcode() and rlc_microcode()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
References: <20240423014359.1597545-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240423014359.1597545-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: d887de0c-58da-4316-477d-08dc6474b643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEhtd2EyTEpTUTFWY1VBc0x4TjUyaW50UGxnWHJCcWZsM1VNL2NXcEZ4S3Er?=
 =?utf-8?B?RHFoRTRIb0lTK2Y5c1o3c3g5K28vZUR1aEIyZ2M0VEh6WGRaV3NTRW5YenVk?=
 =?utf-8?B?Ly9RSm1ZZ1VmVHprR3dKQi9uaGFoQ20wUGpYa2t4clE5dGJuREdjYmhZZE02?=
 =?utf-8?B?eGlMRWlsTG9qTVZXZjRuMlpWSXdKcFloY1lNZjlNRnBYUUplUUZqV3E5b2pr?=
 =?utf-8?B?aStCNjlOMFZGaVg1SnNqR09uUHpOL3R0d1ZXVmNjcHN4SWJzM2owNnNoNVJO?=
 =?utf-8?B?WlAwVU9OV3htNHZPa0t6dWhGY0djMG5OYjZ2dmNaczJTNFJiUk5tbE9CV3ZR?=
 =?utf-8?B?SzRLYmRnNVhEc0ZwYnNSWmhEV2tHamFRQnQyUm4zZk1zVXhIS25VOERGQTZS?=
 =?utf-8?B?ZmdDZkpMQVFwaFVmcktWMGd3KzQvY2RiYXRDWGxSVFI1MUxkOHNsRXhhWTBD?=
 =?utf-8?B?dSt5c01zc3UvWExZZXM2eHVVam94NWFrYVVIYXh5NUVWTWV6aHVIbjk4a3k1?=
 =?utf-8?B?d0FncjhOYVVVT1QwSk53Ri9OZXRIMUVZeVNZeERQcEw2cUNpVWJCOEtxa1lC?=
 =?utf-8?B?UVJXdmpqeUV2Y0JvSUJaVjlYSTQwMEJ1ckVQS2ROaEtONmpHb0pWQlJpM2ZJ?=
 =?utf-8?B?cTg2Q3ZhSmpJUG5SekUxVkcvM2kyS2U2d3pZNml2SzVJMkpyajBNb3NvUVh0?=
 =?utf-8?B?Znd5dEd0RlZ6WXRNeUlaa0M4b2M0aVNUSE5Qc2NYdTRRcnNQV2c5NjNMZUFV?=
 =?utf-8?B?U01mekNoVExnbDBoaEs0NjRyK245T3ZxS0ZsQ3lUVko2d2xuR2Q1Uk1XQnhk?=
 =?utf-8?B?OGNaYUVIZWlDQ29qTzNmeGI0VHN2WTBHMHlIbHR4SjMyNkpTNE82NHcvVzVI?=
 =?utf-8?B?cDZUb3RtVkZHeklER1EyVVo0T2tUejNKQWRyUnQ3MHVsZ3hDMUhkcE0xYTRC?=
 =?utf-8?B?MDc3QjQxVUVjeE5FQjhtVEwzT21FcnVrZldyaTZLcDJ0cExvL2VtMjQ3cHhV?=
 =?utf-8?B?dWpjR0FDYWNiQWthWFFJRkZoWWhVOEJ0STB2Q3hiUitPSDczbEhBeWIwblRo?=
 =?utf-8?B?eXphS05OaGhIMkJMb3dIWlppSnJ1VjdQeVdqamh4dWg4bkJxV1d1SndPTGVw?=
 =?utf-8?B?c1YzZGNsRzMwMzh2REs0SUxMWko3bGRaUmY0YmpqQ1V5YjFuYXJsUjh4T0lh?=
 =?utf-8?B?TWMxRkp1Y0JqQ2FaNERCSmE2Unlzd3hRL1ZiUXg5OFVDK1YwVGFVVi9Fb1dY?=
 =?utf-8?B?MTlEL2R6Yk1pdnRGNXRIUmFhMmxrdU5taXd3ME96a2pqN2k0TVRzTUZQWHVr?=
 =?utf-8?B?Ym1PSVQ4TEsyUkNFZGFPYU9WNU4wQXhCMUJMczQya0tDem5RQ0NvTmo1emxV?=
 =?utf-8?B?czE5WVRSNTA2dks0QW4rdFg3ZkNzMGhGdWVwdlJFd2lGd293MTZ2QlJwU3NE?=
 =?utf-8?B?ZlNCMVg1elkyMFhHTGYyeVQ1ZGRyVzlvYTZoKzR0bVJyWVVzWmpRRXNqSWdr?=
 =?utf-8?B?OG1oUDhpLzFjekEyQ1oveHJLWGlOeEs1Ni9uanNMQ1k5MEFTL20wdmJ5TGFJ?=
 =?utf-8?B?cHY3cGViRHNYSGM3TkhRUFA2TUsyQm1YV1QyVW16Ty9RWG9aWGxEcFNEazhY?=
 =?utf-8?B?Smk2bnFscUM3cmtuMkZwRUtxZFJPYVVPZkNpV0xLTjltYVlldW5HQUNuZ2hw?=
 =?utf-8?B?ZzI4bUdsK0NuK1VHK2Voc1lLRXMvUUsyTzhKbG5KalRJVTFUbGdEa2xRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3hWQTAxVWVhTDAxcWlndlJ2cVM2Z0F5OCtDcHQzbXA2TzNHbFFyRnVobUhU?=
 =?utf-8?B?RGJlR3hjSXdyaFArTmQwaThHcStJc2Y5dFlYeUNUak1FUUNjYkR6Nk95NUl4?=
 =?utf-8?B?SnRDTlNPd2pDN3NQU2xCcU5iTkY5dk1yZW5pc1cxWmdLR3k3OGM4a1loTk5r?=
 =?utf-8?B?cGQxWEFxZVVzNi9jZGNpUWg4WGh3UmtCK29JUjhWR0pNNXErVnByUHZOaGVX?=
 =?utf-8?B?Q2ZOVG1WcEltbGJwbXNmbVFLNlRqVXNERE1mMG1BVmVnM21YTkZyOTRUN3Fi?=
 =?utf-8?B?VkxKTGppTWoybTFnTDZtN3c5NHNway9jT1BDWms3eDllUEcyWHZ2RFpEWVFY?=
 =?utf-8?B?NzRITTJ3S1Q0SEVEck05eGo4R3hJTVJycmxvdHJicGVJVEpVcTlCdFJDSkJ2?=
 =?utf-8?B?U1NvYmJJK2ZLM0FlcWZsZ295T0ROY01ZelhzeFBpd1hEdjJYZHM5RnZ5U28x?=
 =?utf-8?B?ZTJhdFRFalNVZm9GZDlPRHZvTFNkb3pZMXZ5TEFMaVpvV0N4STc4Y00xclhP?=
 =?utf-8?B?WHVxM1RLdXB5U1hxemJnS0RwRi9NR1VsWVFNVWhUMUVlMGdjYzhnd3dBUlEr?=
 =?utf-8?B?L2JrRkFzZDVqeEhQb3duMmJRUURUdGduN0hwUlR5OGx1VkQwQ0R1c2V6ck81?=
 =?utf-8?B?R0Z4QjZPaWVkdGlwYWVWNE5nOEt5NzVMbUh3UDAyR0cvOCtPMGZMTjZnN2Vk?=
 =?utf-8?B?UUJBa2xWR0JkU1NtUzhIYllMZEJ0Qmk5dXRObnZIS1VxZzFyd2lKRUpaamJq?=
 =?utf-8?B?MCtMbzJxSExIRnlqakF5VVFERHlrcVBCQkVySWs3VXRhcGJOVm45KzN3WGtp?=
 =?utf-8?B?eDRzOVplNkJXdnM0OHA5Ym9hTmVtVGlBS2ZkWmtVQkJIZlRMTDNxeWxndHNO?=
 =?utf-8?B?VXFFdEthT2MrWitjUnY4UEZnNS81NjJuaVBndVg0MTBTbldkQVdzbFJXOTZp?=
 =?utf-8?B?QnMvQUNyMG9JQmJVZWNvNkl3MFNmWndwdnh2RXdPMDJHSENJUEErYzJGam5Y?=
 =?utf-8?B?UTlSY0c4RkNreXdzRlRaVno5d3JDeHpWenlkR0REMVhyMkJ0c0tnenh4VXRo?=
 =?utf-8?B?emxXSVdkY1VtQUpjQVUwcVhhS3duZThTZzJoV2NyRlZyZWVGWkkvL3JsQ2RS?=
 =?utf-8?B?eWxpV2IzOWh1V3poZ1ZLMWJWRTYvQ0RKVVRhdnc0amd5a1JHWExnWlFWQ0xp?=
 =?utf-8?B?WGZSdEdFQkNERUxCaFBvMjBzWXdjUTdNSDd6YmJJYXFubW14bVNTYWxnTDlS?=
 =?utf-8?B?cC9nWmNTanU4aDQxZ2pGeHJUeHlWcS9VakdpckVIUEtCLy95MjVPVFIvTm8y?=
 =?utf-8?B?TFFmWjIyd3FJclFGbUNNNUhWaHllVnlZeElvU2djb2txNWUrYUxMNUszVFRv?=
 =?utf-8?B?Sld0NTJQZjcvZEh2NlBoczhPUFYzdVN6d3p4L0hVdlBYU1NCcEhtbTV6VitY?=
 =?utf-8?B?RVBGVkpIbDlscVp3VTBIVGo3S0VFWEJ0N1NQWmpPRWl5UlJJRzNEV25mYkVW?=
 =?utf-8?B?cDl1U0FKcGJXK01SOHVzNzN4QTQycUpZb3BpdlZKYXVzOVJUQTB0eDk4c2sy?=
 =?utf-8?B?TXpWUnVpNTZuc3NUZURuR2Z2dTdHZG9hSGYzMU1VUVVucmxUMCs0VmxwQmhO?=
 =?utf-8?B?cW03WWExZ0JwZ1BHT0lEQ1FtNkF5MzkrajFWOFd3cVFwM014SUluWDlrRGZw?=
 =?utf-8?B?Qi9vYmJyZTcxbjdXZzhrZjcvRXBSWCtpRWlZZmFZdExUUTNoeVVIOUhGRUt6?=
 =?utf-8?B?akJobWQyMFNGREkwOW5zVGlNS244U2dmZXNJeXBhc0ZEdlU5MHZLYTE3bWVr?=
 =?utf-8?B?d1VMQTh3QVVhUFhBa05DWnlFRzM0WHh3ZXJMeVcyM3F6czNYMFE3RjVnNCtC?=
 =?utf-8?B?NEhWUnZkWktEbC9mOEdKWXZHQmwzNHlEU3gwNEo4c050cU5qa1c5RmlVdWVI?=
 =?utf-8?B?L2VibmpaMUN0N1VVb0lrZjA5YmZ4RXhLRUdxOFJlUDBCaVgxVlVza0FtWEgx?=
 =?utf-8?B?WEtWZFFzRU9pTWhmamlqOXNNY3JUNmQvK1hKOURtL09mNE1oU2JvWERUamx0?=
 =?utf-8?B?V1AwYVJJWldOb25GTDYvWTdGaTRwd0tTT3UyT1F0K202VXdQRFBxWWdmN3Rz?=
 =?utf-8?Q?/VjyhipAovraEFP4ocYqwKN5O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d887de0c-58da-4316-477d-08dc6474b643
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:39:22.0750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c62kKiadqYn5NFkEsQYSr7NaMCuS838xuUh55D+I7pZzzex1gok7+uGNVHsQQsE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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



On 4/23/2024 7:13 AM, Srinivasan Shanmugam wrote:
> The buffer size is determined by the declaration char fw_name[30]; This
> means fw_name can hold up to 30 characters, including the null character
> that marks the end of the string.
> 
> The string to be written is "amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin",
> where %s will be replaced by the value of chip_name.
> 
> The length of the string "amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin"
> without the %s is 16 characters.
> 
> The warning message is saying that the chip_name could be up to 29
> characters long. If we add the 16 characters from the string
> "amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin", we get a total of 45
> characters.
> 
> This is potentially longer than the buffer size of 30 characters.
> 
> if chip_name is longer than 14 characters (30 buffer size - 16
> characters from the string), the resulting string will not fit into the
> fw_name buffer, Thus increasing fw_name buffer size to 50
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c: In function ‘gfx_v9_4_3_early_init’:
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:379:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>   379 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
>       |                                                    ^~
> ......
>   439 |         r = gfx_v9_4_3_init_rlc_microcode(adev, ucode_prefix);
>       |                                                 ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:379:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
>   379 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:413:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>   413 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
>       |                                                    ^~
> ......
>   443 |         r = gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
>       |                                                        ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:413:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
>   413 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 86301129698b ("drm/amdgpu: split gc v9_4_3 functionality from gc v9_0")
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 0e429b7ed036..1c46d5f6677f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -370,7 +370,7 @@ static void gfx_v9_4_3_free_microcode(struct amdgpu_device *adev)
>  static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
>  					  const char *chip_name)
>  {
> -	char fw_name[30];
> +	char fw_name[50];

Thanks for the patch. You may solve this by changing ucode_prefix to 15
in gfx_v9_4_3_init_microcode.

Thanks,
Lijo

>  	int err;
>  	const struct rlc_firmware_header_v2_0 *rlc_hdr;
>  	uint16_t version_major;
> @@ -407,7 +407,7 @@ static void gfx_v9_4_3_check_if_need_gfxoff(struct amdgpu_device *adev)
>  static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
>  					  const char *chip_name)
>  {
> -	char fw_name[30];
> +	char fw_name[50];
>  	int err;
>  
>  	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
