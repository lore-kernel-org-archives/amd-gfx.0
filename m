Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAA3E7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 05:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E95CD10E29C;
	Wed,  4 Dec 2024 05:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="icn4gHix";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7060710E29C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 05:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3lrECXnqrZO6O+sQL89exeU3G9yWM3Zulwxtk+D+4yElu5LoTolh4Aa1AiOS/XU4/ynl40GRAMmJwwdR8fcfxADVLb/sAIT2EOvh2jgDaCd2oNEwVPojsEOisNBHZDMIMK7Bohmezm/UKJ9dvctOR9jQn47CygZmUC8lizqfdxX53C/HpAkyGfzeoA6yPHVeUMLJBZG+qa32B835jm5af7se1Nhi4/ej9cEidIwj9agn3A1QBXs1xp7NUZ7+7vnN2oJwE8sbRH/+4k70XS0nXA07e6RTt9fgIBkZ2LXDLu3HJPr6i9wzLH36NuPE/LYwxSQnLmDeZIi1GC6n104PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IAiz3MnjCNh31RihGR1EhIWQK7A810kX5EHbozrUq4=;
 b=v6/r6tuWlnBQfHk9PfwiDSNbfkwfPhydz02Lg4ZqNEBQXgfuodp8FumS4eZJZBpmx+YwaNDndZ2KHI9s0eUEW4V7lLE9NGm9ny6IPtysogNFljmvx5m82449WYWI9a+zAwJEJWScmYwcMyxkAySU/hgQ56fmxsyWK3bhjulQ9amqzbUUkTVeB7yyFImBoMZpaUS2zm9B3knOLFno/EikxVnL8bjFvksSvTdS8RKF6AB9wyuntPHdDPjfcUFOLguiSlnPcrEiBJwixL62nfrq3qTJH2QZK5N/qIoadE3Vg9B/DnRjuQil96DKKQLO1YS10n28+AHDCkdB97vpXCOx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IAiz3MnjCNh31RihGR1EhIWQK7A810kX5EHbozrUq4=;
 b=icn4gHixDmUOLm13l5Vhqw6KFqm++5PI7hXwL3VgrArm8c6gpj0nSJoPS2LL7br0Jtmb72gY9w4AaIjtIOTP+zvvyxrOTBimTksbKWZUyHZInfZQTcnciDF/BqHa7eriLML3CS2KZjuHXCe4J0AE/uGYcG0ST6B3cJqTtXpCxIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 05:14:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 05:14:34 +0000
Message-ID: <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
Date: Tue, 3 Dec 2024 23:14:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: feaeb83a-e019-493f-9100-08dd14228a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mkw4U3FrWlFHN1h6dmI4NmIvYlBNZkdDQVp0ZC9FZUFaN1ZIRXdwbDkxUEMy?=
 =?utf-8?B?bWN3RGtRVHZXUDhJZ2U1RDJNeHZ0TE1Gb1J1UTh6NmJ2ZVMxWDVlcHp6elJ1?=
 =?utf-8?B?WjdtOFZUam1Eb3hmQm9uNzBXU0ZLUjBiSWpxUS96Q0kyZXY5Q0E0Z0NmR0d4?=
 =?utf-8?B?N1A2a1F1Vy9MODFmQS9ONjNhV0RPRm9YRHVFekErVklGVzZXbForSG5zUm5U?=
 =?utf-8?B?eVl2RjM1aDNqaTlKamVjV21yVit4aWI4TCtpRDNqbldXZ3V1NW5CQkVxcnd1?=
 =?utf-8?B?azlUYkVtY29BVi9Sbk9XM0daQTVkOHFkVDVEMDV4QlU2Qy9hVnJ4OUg5MXhr?=
 =?utf-8?B?VUJ0MXk4M1dKemdXYUJRR2FoblZ5cHdUZ1hEN1Z0TTFLK1RqbkhacGo1UXhr?=
 =?utf-8?B?WDlKQmFPSXFYU3NiQ3RBKzlxNkNyclUrUk85YTNtcWhYVFQzQXFITi9jZmVj?=
 =?utf-8?B?L2pETFZGb0NmTy8rNXgzRG9SZXFKMll3Qmpac29lQU1PWFVzYndONHVuNlhr?=
 =?utf-8?B?SFdLb0EwSCtzSEo1YWxSc2FMdU4vWUVyUlB6RjJXUXVrRi9PT1c5a2swYm8z?=
 =?utf-8?B?SGFNV2hrVG5YWnVFdFR3UHNadWRYSlhPT3Y1YzNDaDNkWUdUMFdBdTFoTUV2?=
 =?utf-8?B?Rzlwb1VLS25zRkM5Q0hTL2dzckNVbHVIc09Sa2ZpZ3BHZTlxQmtFdVo2ZGxa?=
 =?utf-8?B?enk1bTdRYlZQa0R5WDMwTHMvcUtoTitwbGJNeEpaRVQ0SjUxS2dDT29qVXBo?=
 =?utf-8?B?MkJ2VFc3MnhEbGdUMTEvUE56RWxHeitndmZNZU51bWZZNytaUFREQlk1RXYz?=
 =?utf-8?B?eTJYUUFoKzN6bFJiSGIzSU9xSkN3WHl6VzQ1ZGZtVXAzSlE1UHVndFkyenQ5?=
 =?utf-8?B?RTJuQjJEaTZTbTMzcDRoWkE0MUN1K2dMQndSQkV3VmVxTTNKMzVCVFdEZXQw?=
 =?utf-8?B?YVI2MGhtUGV3d1VJcUltd0VUUU9TcHAxZ2N3NHZ0dXdOZ2FQMXBzODJ0VDYy?=
 =?utf-8?B?c3l0VThLRTJsMGRvTW9aMi9Xb3Q3STBlT2tUb24raVpQNzUrcDRLMTMvMm8r?=
 =?utf-8?B?WnBvOHI3bkJzQXRsNGhmenNnVEF1Q2ZNb0dnSCtxVXFGKzFYV1F0T3NtZDlP?=
 =?utf-8?B?ZDdqeGx6RmNrUktFRU4xcnlFZVkzVFUxamh5UGlmQUZEdG90N1NqeDVEZzAw?=
 =?utf-8?B?T2NHZnNRN1Y1YzJQa2k3KzVSMzJYeG9GdDNiSTVhakpyNnVEWnZhcktoQThP?=
 =?utf-8?B?WjZDYVRIWjZ4eEVaeVhrTC9yN211cGVpWURPUVlodVQrR3Y4V3hsNWREd1da?=
 =?utf-8?B?UDVockc4N0haQTFBd1VWWlkvdy8yZnd5SEptdERjTXNVb2hpL25CSU12SzIz?=
 =?utf-8?B?OTVYcmFPN0ZDS2k2cnRUM0FPd09Bb2JEU2dsWjIra29CTEZzNjdXNTVFaFVE?=
 =?utf-8?B?ZmMzZUdOcG81REZpb3dnMlhmOXlyWHhhVG1MU2VFY0JTblNUZjJkeGJGc1hx?=
 =?utf-8?B?TVZqSnVSQ1NFK0FZTTZvSUpHWWVsSlVPK0tISzFlZUJpVjNXOXJCNzc3aDlV?=
 =?utf-8?B?ZzVCQVowTnlSU0FhWGtlZ2JkaWVZY3NhV1pzOHpjWFlMaUZZNzN0SnAvRElt?=
 =?utf-8?B?YUwzdkJqeGVjVVE0dWRhLzhuVTVLQXg2UFpETUhGZTdrVnlKeldwSHZaa1V6?=
 =?utf-8?B?OU1tbmoyZWVINkNyczZTQk5JNUtNZVFJd3ZYM1JYNjIzTG9DUFRaNUE0UjBE?=
 =?utf-8?B?RmdhNjA1WThabVR2aXBWY1FMWCs5V1RDblNzUWF0RHJ2Z3ZkM3RrT3FUUEtL?=
 =?utf-8?B?OEJtSkY3eFdhOW1JVzM3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3R5Qm9PMVp1cHM3WHdBWUlnNTNFbnE0c0V5dGhkRzl1dmxzTnN6WDhHbEd0?=
 =?utf-8?B?Qjh0SXNiS29tNkE2SGFEblU1WGJxSnpGNzlmcEozQ3VobUZMWVMyTTN4d3hz?=
 =?utf-8?B?ZnVjd2RNYWJjdzBvSUxxS05BWEI2WW5HbjdKQjlzVzNKNjYzM1ovUm1PQ1lQ?=
 =?utf-8?B?dFJtT1lZcUNObFIxTjJORWV0ekU2VTdoRXgwTUw5dndQV3dKR2llRnJRSm9z?=
 =?utf-8?B?MnNCa3Z2bDFVRkVNYStyRmtuQmtkbTJwR1phZURiVEY5L1kyWWJVVVYySWsz?=
 =?utf-8?B?RXBCNGxqWUNUS1FWUkszUUNSUmE2OGJDTEZrQUxxQ0hmUjlVaDBqTWZGUStI?=
 =?utf-8?B?c3NNQ0gvTXl1eCtsQ3VhaU5qTVVPbm9DTlNFVExOYUFKLzhxQkVBUkdNT2Qr?=
 =?utf-8?B?V3Y1VU12c25RcW51Q2JMUlpIUGpaOTg2bXJaZ3NObHFybmUvaDVkKzlHcEc3?=
 =?utf-8?B?MlJhTWFpSm1JRGNyYlNyNlRZNU1aT0YxYnBQMFBYY2ZSaHpHeWRITkpZeHFT?=
 =?utf-8?B?cWRaRnh3cjhPTm5STFhtMTJXQUZ3TlBiMktRUldmU1ZRQ3EwY250bVFwdjQv?=
 =?utf-8?B?WnBRb2JKZ1puSVl4WGtwbHV6SjJQUlhsdUNvZXZ1aG5zb012VjFyM0ZDOVA2?=
 =?utf-8?B?blVNdkcraWNoNTJpRnIrZ29mOSt6dm94MVRwVkpVV0Eyb3dHQ3JPbGZHcStR?=
 =?utf-8?B?NUIrTHpFZ3RWYVhFNFlsQ3k0TVdyWHpEb0JhZXMyNGhRWVpHeFg0YzNDd253?=
 =?utf-8?B?NGE3T2pCbjI4SE5NLzlKM1FqV0IvMGkwR1cxY2kyVXJsK0ZLQU4rWHZjN1Q1?=
 =?utf-8?B?TzRyTlR5cjdwMEUvbGdvVjdVVEtBeUhOeFRaanV6eGVzdjFjTXhTckxXR3Y1?=
 =?utf-8?B?cFVRQlVHc2VXZmdFV1lhMkRYTEhPenZzNDZ5Y2wxYk9IVTNtZ2dFVmU1NWVp?=
 =?utf-8?B?di9OUHdYUlJOOHN6NGpUTzQ4SHNsSm0rM1M2TlRLSkZ2a3BQY1lrc2J3RUND?=
 =?utf-8?B?MEVYaExQVTJwUTRlLzhxM2JJdmF3eGVSSHVuTEdhcDRQdzMwRlhrVUYxbkRT?=
 =?utf-8?B?NW80QkYrTzBOcUFZd0hWRVhvTlo0U05tL1pmNlhWajRZWk5MS2dvM2VPOWNH?=
 =?utf-8?B?M3BpK01YcnlQOW1sVC9keHVRQ05yQ2FwSDYrOGVJQ0ROTkVLOUh2WEkzS0Mz?=
 =?utf-8?B?ZGxMKzhxZDdMQjY1aWxiVmlYNFdMWDljM3A3M1FlSjhlbnl3elNXc1JNVlpq?=
 =?utf-8?B?T3dLUno1R2tMOUxRdm9rK1BCdkZBaS9ERmZ2T3I3cDJBbU9hbzZIQ3VRaXdv?=
 =?utf-8?B?ck1EdlVYV3FuVjBPSCs4MFprUUIyM1pzZGRvWTVEcVpwU1VTeUk1UVBnNWxP?=
 =?utf-8?B?RmRQQk1VVmFQL1Z5ZGJXbjNhWXhuQ2h2SHZoaFlrRWY1UGNvSTRNdzd4Y0dE?=
 =?utf-8?B?ZklpeVFSQTAvblZ2V3k0OUVZV3BJM1FjN0hxV0FzQTJ2V2YrR3lkcmV5bjZZ?=
 =?utf-8?B?SmtOMU85STJHd3ljR3VxNDlNOG8yeUZVWFR4STEvbS85ajNYTWNYV2tVeld4?=
 =?utf-8?B?YmwxQ3IzUGtzQmJGNHNndUs2eGlSZ2xja3lnb1ZOdXdKcTh0WUxjajNXaXpw?=
 =?utf-8?B?Zy9VbkVUNDFNQmpjSGxVYXIwZngvbVY5RHoxV1JIV0pPaEpzQ0U4RU1RcUFF?=
 =?utf-8?B?Z3Q0aWQrc3UvbitqbCtvTlJMbXRiWGZhRmJuWDU0dWJxMzJFMGI0c0pXZERP?=
 =?utf-8?B?TG5BeVpYM01ZZUlrbEduaUliMlRyeUFCNSs5OEJSVEI3S0hMc0dwVUtpYm5R?=
 =?utf-8?B?ODBrYUpXTXpPblNIYWoxY1lsa2VmdXlPNGcvNURlcXd6Uk1RYlkwWTg2T1hN?=
 =?utf-8?B?TWVtazF6WERhWTRza0VVMWlZNDdXeE9wN2hQUm9ZQXhOSTFXNzczT25mc1BE?=
 =?utf-8?B?N0poNGQ2ejZ5MGRJeU1HODhBZ1ZjdjNPSVFZZTFmMFZ0WjhFWjIrdDljdEdq?=
 =?utf-8?B?VmorbzQ2SEZQaDBYclRibmhIOStiRS9mdS94cm9hTlZCdVlkT1oyUWhlZDR6?=
 =?utf-8?B?YTRvQ2V5NGUrRW0xdTF3SmhLankyZkRuV3kzWE5kcXRMeSthVFRJYVRIbUpo?=
 =?utf-8?Q?ZdvP/LP0TCUt3kR7YVGUArk6r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feaeb83a-e019-493f-9100-08dd14228a4c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 05:14:33.9427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQT757fUGBsKPfEnCUWD0MyWW4s7aiXKC/ljJnbioiRR93IfPZywhoywggNU1cHJ7MhqzpEcISo0AqWcdC+QAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
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


>> +enum amdgpu_ucode_required {
>> +	AMDGPU_UCODE_NOT_REQUIRED,
>> +	AMDGPU_UCODE_REQUIRED,
> 
> Couldn't this be handled in another API instead of having to flag every
> load? By default, every ucode is required and if optional may be skipped
> with amdgpu_ucode_request_optional() API?
> 

I guess this would be a smaller patch, but 6 eggs one hand, half dozen 
in the other?

Alex - what's your take?
