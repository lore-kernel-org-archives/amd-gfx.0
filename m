Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BE1C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 13:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A18F10E107;
	Thu, 30 May 2024 13:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lFy/P3M+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0237710E107
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 13:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldlK6VxGGGQDM2E67vzh4wAhhCVchZPMH/tDHQOPqzPi+yOSG9hwiN0j2B/6AyfoJCA7MuT3w/SJ8ZxJgVCxCyoeWL3LrSZIaoQHijATrFBCCQ3AxMaEqimrHC9wbWnWPAVaf/1YRJtiMdyWEekF+FMfbfj3o1bQZAv+OWljSeAnE+ChgnaYJpbA/AnErDI/f0t+7gm27g8kwBJpy/38Dfc4nX50zgQYGNx3g8nqeZIsSMgChEDnVGXfM4BVlLCZPhTOc4XRz3trPdK6hzhekyjFq8uNfXtuwOlSAnXQu4YvZt6DdQfnKlOBmRSMJQlQ+/GcDjM9sNpZqYfjYNXcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZjsiHUeMVAHR4UByRYJt2N+W4Ky+7l02n8ljnc8KK8=;
 b=RJnwwijwbXiW+ANlFaDWsOPEfN+O2zvlgVW5CCKlxt9sZTQgzTlCXVnQ5M3r2yZjWjDfHt7FtvQ6RM/Co1KBwwnGVGGWxTyusgsRTVByQTUjtDFi3mfvdPMcrItgzawnBctRu43hg+CkKX8KOSK3mUI3Im3T5UNeNFXeSDjeEktvFo95gm2/OIaGbyGiIcRty8HDxP1uexEaKOedOuH9IgCC0cn1XjSEGmxhGq0W/+NuA7EIzy337SQnUVY8CjRG62OOGPhZHI6Z0x0tBsscjvuzSeIAIsqSG4zoXPFUq+2e0rze5Q+gmF+a6oh69CwXWhZsymmrKpnXbapl/TktYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZjsiHUeMVAHR4UByRYJt2N+W4Ky+7l02n8ljnc8KK8=;
 b=lFy/P3M+e24yYd6Cv757xx8+xpFVUgXUR5Ppu4xdkhqlZz82IJoe+/FnLSroJCFI6T+TV0FlqHxU3EbEwnB7oJHBeXOroiL/fnVdxtEN7GvUJg2DXU8VzkhAv8kkJYZSDI03oq6p97RQ9OoWJIcq/boLoazk+upoTqaRzbEl3Yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 13:51:21 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d%7]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 13:51:21 +0000
Message-ID: <7e4abc78-df00-40d7-b176-1b6271818671@amd.com>
Date: Thu, 30 May 2024 19:21:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix type mismatch in amdgpu_gfx_kiq_init_ring
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
 Lijo Lazar <lijo.lazar@amd.com>
References: <20240525021041.1780050-1-srinivasan.shanmugam@amd.com>
Content-Language: en-GB
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20240525021041.1780050-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::32) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b7173c-b03e-4000-2533-08dc80af9616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUI3emh1SFhxUm9TdGhjMkZCVnlveTJPU09kREllSGJ0MGZ6Wk51blhuUGV4?=
 =?utf-8?B?QnIvcFQ3TmhoN0JtSTErWGxvcVZUSisvdmsxTGhnb09yWFo4Sm9jRGZ4YU44?=
 =?utf-8?B?ZGZqemxwL0dEdU1wVjBIdFo5N3JLVDlqSWFBcHBsdzVSOW5aTGtMVGk2TklW?=
 =?utf-8?B?alBmNWJGRTBTZWp2UUkzdmZoVlNIcnRtOG1VcG5hNVZTNzNJbC8wUXp5T01M?=
 =?utf-8?B?MmttMkxSazFjZnhDRFY2QlpDWXIwdlJ5RzdlOWF3WjhLR1FCSFBIYmQ4VW1m?=
 =?utf-8?B?OE9yV2NlcTlOSHpwa21UYVAwRmlFZEUrMlF2dUM5SUR0c25SRjdEUHNkRmN5?=
 =?utf-8?B?N1Bpaml3WnpHOUx4Ymw4N2lXb1lYbzFzM2htbUZVNENoWmxGSiszb2lVNTNr?=
 =?utf-8?B?NUdqM1JTREZNazFRS05IR1QrYUU0dW82Mnc5ejE1azB1NzRsRFBjVnd1Z0Vm?=
 =?utf-8?B?UDhubVM2MGVpeXhYYzBld2tMTWFFdVBodHFwNjQ4MTdnTnQxUlB5by9EenhK?=
 =?utf-8?B?eVdkL3BRdERSQWhhclJKZUdvdFZHZ0lWRlY5NTA0MldnQ2VEOGQzQVlDUEdk?=
 =?utf-8?B?Nk5lUm9KMys1TjdnNU5DZ1RPazZhN0IzZlJ0L2FMRkIzUFZvL1hWTzN3djJa?=
 =?utf-8?B?c2c2VWVPMEVsZUZiQ1NQNjF3R2tRM0ZPejRyTDRGQWNETFNSRkwyNm9WSGM3?=
 =?utf-8?B?MlZpak5LbjRDMU1oSHpMZGdPUmhLb1M5aGo1YzNRWStaWVRPYy80b3VReC9D?=
 =?utf-8?B?ZVUyd1ArandSenB0eEkxYmJJSTNBQnhJOG15ejUzSnBSSiszYk5aRDNISWMy?=
 =?utf-8?B?TUt0cmIxdzV6VzZkeFFmaWM2SUJMbUpXRWdXYk1IcEpCL2xWMjJ4aCtvR1c1?=
 =?utf-8?B?L1Z0WGlLR3dqc0VVemk3OU5OTDJ1VlZQckYzV1BYaGtYT1orVTRwV3pMc01M?=
 =?utf-8?B?QTdSTEJVTis0NlRra0JlaUVJakxVVnEzS0E5RlcrZFptNXdYNTR3M1VEd0xU?=
 =?utf-8?B?dGRORXZWZGovbk1FU1lIclZaMkJNS3VpK0pLSXY3bzkzTWQwZ2oxem04OXFN?=
 =?utf-8?B?SXN5a2xXVzlOSVM1c1FOUk9MOGtrek9FckNZU2l5M1ZSSHlGTnFoMHRoZ1Y3?=
 =?utf-8?B?K0g3bDdSYWhuY3Bjc1dyRHVudU5zdmRRc3VQTVZVQVhSRjZoeWU4T1NtcEh4?=
 =?utf-8?B?Q3lvQjRRNGhZUERBamtOZFZ2ajhEUHNCUXd6a1Z1WXZYNlFGOElKWU1sTEdX?=
 =?utf-8?B?c3lsNEd4dzNEc1VRYXRSdlNCRmpxUlROKzA3SGxFWTdERG5rTFdzbUJBLzI0?=
 =?utf-8?B?S0xjTU9ySnc4bzVndllsVkhiMXc5MzNSTXdpbWROckdxVmIwekNTeDF0d0Q4?=
 =?utf-8?B?VGVjS0hZWVFoTXBRZlBMQWFld1BnRHQ2aDBGTXQ1azBieFdhSXFtQ0gyUGJr?=
 =?utf-8?B?bzQ5TFlnSjlxamwvMGM4K1RiaGVta2doaDF0RHZ0anRYYlRYWnQwZE1tdVpv?=
 =?utf-8?B?Qy9reS9IYWNWZlFmeW9WV1BHZmNyRi9TaGZCeVRuUG5FN3VJMEs5eDc5K1RS?=
 =?utf-8?B?S0NxRCtucTBiMkE0b3V2QUxXenAvYm00NlNBdHZDZ3U4Q1pPL3kzRHkwYUFp?=
 =?utf-8?Q?NyGJnsK3qnv0FY3fquWXZp2KhFYl70AiD8j+1dI7N57w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXdLL3Jsd2ZDMmlGNlNNNnFITHpubXJWbEhnTTN0eEwyeGZqK29UcjlqWjBH?=
 =?utf-8?B?L0ZOaTRDa2QyUGc1cm1iRGdsbUFJWkZWT1hSYXZ5SWphak5uT0ZxeUJDMVU4?=
 =?utf-8?B?Mm5vazBPSU82NTlUSDZ5enVkSmk5YjdjMk5peXRwRzVHaldhSHFwZWl3Tmdt?=
 =?utf-8?B?dkFsenNWdEY5d2VCU2UvU0Q5Y2hZMXpqVU05MDZibUhmMTR1eUVhcSt2cFI0?=
 =?utf-8?B?OXFtWGZIdWdUUVF2cmYwNTQwdnd3eUxYeVNXTzE4Zmx4UXNjU2pyamh6RCsw?=
 =?utf-8?B?V2cwQ2dxbHNITklJc2UxQWpQeUJFV3d3SDV2dUlKa2FSSXVIN0kySHBOV3Zn?=
 =?utf-8?B?MGhJbisyMEhnLzZVY3haaTZrQmdxdkxleEpsU2ZLRjdDKzVMZGNHczBwMEh6?=
 =?utf-8?B?WW1HdmF4cld5K1lzSnI2MlE5alZlQ0Vid1N0UGFMdnh5Y1MxWnVERE5BUHNq?=
 =?utf-8?B?MEU3c2hZR1E4Z0ttbStJL0c0aWtZc1dRQU9WU3ZOVjBQZzNWOGJma3NFYkt6?=
 =?utf-8?B?UmRjSmtQOW1kcU1Jb1NEZUVuRVJPTUhmeCt5RlY2bEErTlZUTUZucWprUFU3?=
 =?utf-8?B?U0pTQmI5eVdQUGhOMnVOaURONzg3SS8wazU0eXBwbisvTXZaT3hwSGJtRTJi?=
 =?utf-8?B?S3k5OFVkS283bDhxSzdSc3ZKcHFWU29UbmdKVmpzMEZjZGE3QmZMSDZ5bGtv?=
 =?utf-8?B?UG5hSHF4R1liVFNnN3ZkOGpWVVZHQlgzY0JYWEM5Rml4MWp0TGE4RzBOdmpF?=
 =?utf-8?B?cTErMFYzWUFOSTB3WGJwT1NEeFVWMTRmZ000c0FJb1FUbm1SKzFnMHEzMlNR?=
 =?utf-8?B?Vms0Mi9VOEdYUnRiS29ZcGxGVHpuMVZWSFZsenVycGI4WStDQ3dmQjloQit0?=
 =?utf-8?B?ZWNyc3V4UEw2NW1JZ1U3SUZwOGxDc2UwNUFDSG5Xclg1enplOGwxOElLLzJY?=
 =?utf-8?B?UjVyT2owbHVGT2JSRkVQM3NSMHFCeHJJUksxOUJCTDRSdkoxdjhrUXZmMmty?=
 =?utf-8?B?OGFyZFRLem9CL1FWd1E5V1pYYklEb3diSm13Ylg3QUowWVdxWFdyMEgvdUJJ?=
 =?utf-8?B?RmM1QklHN1VNcVEzdk9lTEN5Ujlzb1lzaEU2aklZMFEvZzY3VjNyMkRqVXho?=
 =?utf-8?B?a3VzUUZNVDhXSG1KYlpQZEk0Uy8zOVBvYXA3Q0NERmRlVHA0ZjIxR1NOaWsy?=
 =?utf-8?B?RlBYdVRObzBwT3E2RFNWSVlVb29sTG9mSmVYa0x3OXE4cjBIeTdBcGVGYWVT?=
 =?utf-8?B?enZhSTg4SnE3UUF1OFhrMlF3MmNoSFZWWGJVZmpjcERQS3BJMWluU1hCRDBa?=
 =?utf-8?B?YjFDN3YrVG5Qa2taU0wvemJBdzd6NVJLcHhFekdFT1BWT2d4Q2liV2duUmxD?=
 =?utf-8?B?ejhGN1AvRWdoYktJdEQ1ZFFBZTVVUjV3MVJ0bW1YaklPdG9kZUV2dEppcllD?=
 =?utf-8?B?VE84UnVDeE9zM3Nta1ROYTZNNWc4OU5WVlA1UHI4Z01yS1ZRVmpNWGY1cXpu?=
 =?utf-8?B?a0tyUkp3NVNYTThVc3JDUkszWDhQMnJVaWNKaFRWTFd3WmhoRmE1QjVRZE9R?=
 =?utf-8?B?NStpNThJTDZNY1ovdHFhckdXTjIzT28zQlNZcFNUWVpnSFl4Y1pGbnNUNEFM?=
 =?utf-8?B?QnhoU21qK013M1BraWlqdk9NcW9TMTZzUEpNZXVIZjRXazEzRU5IWWl5TkZh?=
 =?utf-8?B?bFRxTkRsMytyL2cyN2JVenc3dFlwTUR4ZGJES2t4WXZ3ek9XaUJiMlFiSm82?=
 =?utf-8?B?czZ0UGMyL2hUTC9pS3ZxZWZEU2JEelBnWk02eTQzcGxmS3BBUkFaQXdBNTcv?=
 =?utf-8?B?QllyMzFxZGsrdlZBcjV6UnhMZ1VtcDF3d2I4eFlVUU1YRk1UTHVraVdtQUhO?=
 =?utf-8?B?Wm5xNWlwaWlNalF0WjJ5UkdiV2lsZDMwcEVvKzg5VWYxY0tJZmxpdWZuNStw?=
 =?utf-8?B?NFhCbFVWTDV6THZrVlpwVzdYaXZtbmViVE5JUkx2L2d6Z2hNaW9Md3psN09K?=
 =?utf-8?B?YWZtTVpwQzdrcngwczlxVjg4RDROS2x2THRCQnU4eEhmUjFsYWpGeWJYLzN0?=
 =?utf-8?B?YUZFL1ZReTUyaGdJMThIR2t5d1BZV016Z2tySzlTeVROSHhJeVV6bnZ3T0JZ?=
 =?utf-8?Q?ravO5EK4eZtGnVFPicAWcdVr6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b7173c-b03e-4000-2533-08dc80af9616
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 13:51:20.9466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX+ezOx8KB1nGboZmr6vBEUlQ9Jk8o+f5cu6SwnDEJvaKIpdYUEnv4bhrKvxHBB3my3z5mvg4oLa35qF7WEuog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
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

Ping!?

On 5/25/2024 7:40 AM, Srinivasan Shanmugam wrote:
> This commit fixes a type mismatch in the amdgpu_gfx_kiq_init_ring
> function triggered by the snprintf function expecting unsigned char
> arguments due to the '%hhu' format specifier, but receiving int and u32
> arguments.
>
> The issue occurred because the arguments xcc_id, ring->me, ring->pipe,
> and ring->queue were of type int and u32, not unsigned char. This led to
> a type mismatch when these arguments were passed to snprintf.
>
> To resolve this, the snprintf line was modified to cast these arguments
> to unsigned char. This ensures that the arguments are of the correct
> type for the '%hhu' format specifier and resolves the warning.
>
> Fixes the below:
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:4: warning: format
>>> specifies type 'unsigned char' but the argument has type 'int'
>>> [-Wformat]
>                      xcc_id, ring->me, ring->pipe, ring->queue);
>                      ^~~~~~
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:12: warning: format
>>> specifies type 'unsigned char' but the argument has type 'u32' (aka
>>> 'unsigned int') [-Wformat]
>                      xcc_id, ring->me, ring->pipe, ring->queue);
>                              ^~~~~~~~
>     drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:22: warning: format specifies type 'unsigned char' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
>                      xcc_id, ring->me, ring->pipe, ring->queue);
>                                        ^~~~~~~~~~
>     drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:34: warning: format specifies type 'unsigned char' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
>                      xcc_id, ring->me, ring->pipe, ring->queue);
>                                                    ^~~~~~~~~~~
>     4 warnings generated.
>
> Fixes: 0eb430076172 ("drm/amdgpu: Fix snprintf usage in amdgpu_gfx_kiq_init_ring")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405250446.XeaWe66u-lkp@intel.com/
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 68505eaa92f9..19b1817b55d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -330,7 +330,8 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id)
>   	ring->eop_gpu_addr = kiq->eop_gpu_addr;
>   	ring->no_scheduler = true;
>   	snprintf(ring->name, sizeof(ring->name), "kiq_%hhu.%hhu.%hhu.%hhu",
> -		 xcc_id, ring->me, ring->pipe, ring->queue);
> +		 (unsigned char)xcc_id, (unsigned char)ring->me,
> +		 (unsigned char)ring->pipe, (unsigned char)ring->queue);
>   	r = amdgpu_ring_init(adev, ring, 1024, irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
>   			     AMDGPU_RING_PRIO_DEFAULT, NULL);
>   	if (r)
