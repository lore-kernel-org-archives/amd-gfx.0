Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45186E6748D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 07:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52F010E3DA;
	Mon, 22 Dec 2025 07:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rtYQO24Y";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C76310E3DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 07:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwWKpFDJpwPnTxS5d9tFZwDX/cNsHljV00ht3H2NIKIms0ru4yJlX/1eK10rOnV4YQuEfbZN9YmnZML+EPWpKnu+QfrrUABJ5D9n4fOXiUA5tTABoEPqGKlZibtQjUHYSW5O6u4ggtPYxsBZXOxoV31JIj6Uj9gd5bibVp2+IOU64KK0nmGOOBwIAOgPoNQ5NVllwziiJV0qur7TcrBiZA0/MwQrQ9o+NIRYgCh9Ff7YGANnaIIoviP0f2CXkxevL0Uz4wRTyV+xQhDMytzA6GArNVfaoRPEM16udbJA1HhR6Ohbf3zIEHE5mnvZoO4BypAlb5xhcsoIN9ZlbgWfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV6/GD6Zh2kHco14LI+1QpmRsYfWIssAxeYhBEZH8s4=;
 b=P+QYpVPfzU4/+fxPS+h230tVCWnfNMD4BQqD7tRp7g+itCp//BPlZbNut7gxskSk6/juRK0kBwipwXrlX8s+KE7lmzVieKF0PWWkUUTnISZCUyrLO3/uJdSJIlai06lUTtcYjRXed+PZqycWEx1LKoFv1UJl6Y4nOPQrXiXj54UOB6vX+0R9vbEQOSLfcIL8a1Mi1Z5MZEyUCM2jjfemGsvEJXxwlpPuwsmzodvquBYUX7wFVwHRdzNyvazyTp+z0XC3fWyPbbVmO5pVyAXCoKi8sa4+xWKAfjTUGU6jf9EI1vTK7ePQ98rP8yjPzMyc4x1/RVFNCvyITKBKld406w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV6/GD6Zh2kHco14LI+1QpmRsYfWIssAxeYhBEZH8s4=;
 b=rtYQO24Y2wyFA4CM6DkRfOJr9rzu4yv5x+255gUbn54DL4sdmvxAMR62Q4KI4rhBpAGvbeDm3c48Dw+k7IhKPrsco5IEFk9dhvNjTQNSIwscHUlhjQ4vxdMoAQmRwPphGeiy9HBriBi4dhh+JkCVORgnkdo9VYy8/nRD+ajX/xA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 07:02:30 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 07:02:30 +0000
Message-ID: <1064ca5e-d62e-4898-9d0c-41be9d79f8ba@amd.com>
Date: Mon, 22 Dec 2025 00:02:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/amd/display: DC analog connector fixes
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <Harry.Wentland@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, alexander.deucher@amd.com,
 siqueira@igalia.com
References: <20251206023106.8875-1-timur.kristof@gmail.com>
 <2595415.XAFRqVoOGU@timur-max> <96ac728e-1d58-46e8-a4a4-b722023f6a45@amd.com>
 <5017406.vXUDI8C0e8@timur-max>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <5017406.vXUDI8C0e8@timur-max>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 14923416-202f-4d19-12e5-08de412812ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkxkdEFOdVEwdkhNTTBLRXUxMGVzTGpYWnhxM240b0FqblNLdEVLUGtzd2Ez?=
 =?utf-8?B?NE5aVzNlQjg1YjhidW9XOVArdmRKZkxLLzdrNVJsY2xvQzdjV2V5dXlxZDRt?=
 =?utf-8?B?ZW9HQ0RSV3RkcnVJNU85TklibnJFSElNNzJ5dlhweGcwcmJ6OUQvZ0dyN1lH?=
 =?utf-8?B?MGw3djh4NHNuQzJTTFNDM3o4Kzl1d0J5VGdyVFVVMVM0QWJtQzBEcWl0VEYw?=
 =?utf-8?B?M2pSUTlwbGYxdmdZQWdaeGxvaWJGZ3NDT25LTzd2UjMyRDVyTXBQL3lZQVNV?=
 =?utf-8?B?SUVXaS9TaXUzWTNjVEZhcHdUWk9CcnkyemZNenl1MnBjNzQzT1lWc2gwQndC?=
 =?utf-8?B?akRqMkkzT0xwZU0rZVhlNEVvOVZUNU1hUkZzUDh2Mi9vVHZvMzdtSUV5RXJm?=
 =?utf-8?B?eUE5dFd6bHZLcEVXV2hYN013RGttSXY2NStOWHhmQVVWTHBNUzh6Rm1YQUJ6?=
 =?utf-8?B?eE1jMXB1SGM5RkpZQkRJcXZCOVlQaitqM09Ed0g0cjQyYjIyU1F5ZlR3YkdS?=
 =?utf-8?B?UUVqczZrVUtvRjNrdTQ1N1cxS3J5WmhoK1NLdjdhUGFaWmQ4RjhESTZPaHVa?=
 =?utf-8?B?S3hZNVRITUc4WVQ1cC9OaXFmcWhFV0dSSVRlV1lkbEtsM2YxWThxTng4d3Z1?=
 =?utf-8?B?dGxGcTB3WERVL0JscnljZjZqUS9GaDRnS3N3ZWNrSDNod05zWWlKVWNRSGZ5?=
 =?utf-8?B?WVFOcEU1aGtTUyt2UVZKL0ZSMWR1NURJdXVOUTFpUDVyMUsrUTU4UmxYcC9F?=
 =?utf-8?B?MExibHFZQjdjaGxtVFNWYlAzQVRNT2lOU1hMRERieFB6enNHUTlYVTFNTzI2?=
 =?utf-8?B?QTEzb1FhMDNEOUUxSVgyRDBLSzh2bUtmbEp5TndtcFVjWWpIdjE4Y2RCbU5H?=
 =?utf-8?B?OHhBaUtIZFRWT0NVUWQxZng1SnA5RFJtdVJOeURRTWlMaUNHSmlzK1RhNXpT?=
 =?utf-8?B?cUpRd2ZSdmNyYlEvZ05uMk9pMFVTNGdMcVNVOU94R2QwZVFmK1AzNUhzZklU?=
 =?utf-8?B?S0JEMnVLa0R6bXVUYUtLV2tsYUZHdzN1ZytuOVNnTWZ3SlkwMjlEdVlBYmR2?=
 =?utf-8?B?L25PR0U5cnJQQlJOd05JVlNCSC8yd0ZTN2gxUDYvczd4YmdKdGZ1cWVnalpp?=
 =?utf-8?B?V1dkYUIxVHNvYkZPUlExMlNHMDBib1dXMkl4WFJnVitGcW44b0hRdTYzRkZE?=
 =?utf-8?B?d05laGxhV0Y1L0FjeldsNlllcnMxSFNKbjBxSVNvcWtzMG9XMXU5NzdnRFlp?=
 =?utf-8?B?KytLSUQ1b3VlUEs5c09JQS9xOVJvanlMWEY0NjJKc2dOODEyTnhycU5FUW9C?=
 =?utf-8?B?V2ZTclJKcW5oMEtJcjNPVmRIaFdEeGlyWWVOQjlTNHpSOVQxNjVIZ3ZHemVP?=
 =?utf-8?B?RTZ2R216NVpxbGNyS1FlU3ZkbXZRYVhHaytMcUZabDMxOE9oSlBLc1hMK01n?=
 =?utf-8?B?YWFsU2M1cmZUR2kzU2h3b2g5MXdLOXpFK0p6bFczRExEZFY1M0MvdS91UWhx?=
 =?utf-8?B?OTR6RmMrVENuRUhMS1ZDWEtwMFAvMHNGUkhDd1FJT2FUNTRNUnVwM1J4Tmtw?=
 =?utf-8?B?U2ZITkVOWDlZc09DMHRubXRvRjJXVjUxQzFhSHgvVkE2MTc4S3dTR01GOG0x?=
 =?utf-8?B?NG5uVmFaV2hkMnFCdnhxc3V5ckQxVVRHYklCVnZPVlhlSUxMT0REZHBIRm1U?=
 =?utf-8?B?a0IwV2E5dEo1NmxMNmpDdHNBYmgvbjBkUkI2aUJ2UGVSWW4vekFmdk51VExj?=
 =?utf-8?B?K1FZVC8rYXlWQjNjNVBHazdadDhJZktkd2tNRndsdDRuazlOWHhvV1ozc000?=
 =?utf-8?B?aHNJZUIyV0oyVFc2ZVVpeWRqMStSNE5FTVNUQkpCWWt0UlZqMlZqcEdlQmor?=
 =?utf-8?B?ekNSMXpXWVc2akZMU3Q4cXM5akJZeUkrUjZRaytPT3p6ek4rZlhIcE84M1J6?=
 =?utf-8?Q?DPf1sjUaDiL8tQaAp2JEfKT7HwoPRfCh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnkxZWpsUHMyL2dhQ3phM1J1Skp4S2o1MVVrOGNJM3prbzQ5c0NUanZEWGMz?=
 =?utf-8?B?dGt4K2UrdS93MklnU2Ria2FkTkYwTXlIVVpBUHFuM090NFVzY1B6YnY0dDdU?=
 =?utf-8?B?M1Flb000Q0R0VFQ1VjhoWGNXaG5YOEtsb2V4aWNwaTVZSlU5N1FMYkVIcFF4?=
 =?utf-8?B?bksycEJNRVRLa25Dc2JWa0hUckwyT1pia1BaZ2ZNUjVYY0Y2T3I5K3JvVXpH?=
 =?utf-8?B?NlY2MU0vbXZ0YjFTbjV2K0wzQ2FYOHIvWGtpTHNGVy81VjVic0JubmtiTDls?=
 =?utf-8?B?V1BjQnJDM1p1dDR2MHpDeStuLzJXc1hNR1pBSTdFTmN2SjlWS25RQ2lqdVAy?=
 =?utf-8?B?SW5GZWJTcGJXTUdDbU82UElVbGhXaFk2bTVEQUJqR013VFZvbmZRZjB6bzZi?=
 =?utf-8?B?eTdraDFsWURYY1RlOU1RSkYvM25OVWgwdlJNUldTdUc1VlVnanl0YmNqUmNo?=
 =?utf-8?B?QWozOWhPcjVieVAyM215OHl1MHQ2aGVqL3lDMTIxZHJlUlcvd3RsL2d5M09r?=
 =?utf-8?B?SzZ0WE1MUmU1RTRZblN4RTF5Vkl3ZTFjbGpRYXpuY04yR1NkQ2ordGNITk1N?=
 =?utf-8?B?b09iNG5EdUNWQkZvZzF3WFhtSmtTRGNab09TdHd5VWRpc0hLam5md2F5RE14?=
 =?utf-8?B?UndlQUI2RDcrMmJtQzhUdC9XRzkvcGhvSGtpWHhhTVU1UWFKN0tzMGZCUTBs?=
 =?utf-8?B?WllWUUg5K1VyUXl2SkFtU0JjNTMwc2E2aVQ1dURtTDk4REVhS3RnbXZyR1pE?=
 =?utf-8?B?NUhhUTNCdG9XRDUxOW9lZ0pzamVteFBzVUprb1V5enc0MUh1TWx2UDl0K3N6?=
 =?utf-8?B?SlVlYU9aaU55QkNVKzgxTXVYQnF2MldZb2hkSEhyWkgycDhSYVpCdzFsZUZ6?=
 =?utf-8?B?M3RJdHROdHpTblBwbWw2UXRFNW9xRTU3Uk5zMGRpWmJybi8ySi8zY0duUDgz?=
 =?utf-8?B?amVoempoYlBkTlo1MWN2TldYT0RMOTBtbFZORENiNWJFakQzOVlVWWdsMldK?=
 =?utf-8?B?NExLSmFrblB3b1Q2LzNKWDlFN045REdOVi9ocXlKdUFXSytlNGRzbmMrYTJE?=
 =?utf-8?B?bDY3ZEdRcE1NMndIMjFSY0l2a0VUallwS21EKzJxK1Q4QnB5Zit6VzRXYlZj?=
 =?utf-8?B?OGR5WWszZ2FNUTFZWGNzWmkzUmRBWkRwMWRiWEFVbzZaWUVyZmlRYXQ3YUQ4?=
 =?utf-8?B?bXNMakxCMFhIb3hPQm5GbFdpTDd3MXhRd0VJYk9Oc0NWUEdRSkdFNURLemlo?=
 =?utf-8?B?SWlGdlFOYUZwZ21MVnYycUpzbzdlUmhwRzltVTVkS2cxT2dVUlBmN2YvK0sz?=
 =?utf-8?B?aWtDMGNiaFBFVm4vbGNBcWErNXpxQnhUQlFVWWIvWEYrd1lkTkVVRkhRdDRP?=
 =?utf-8?B?OTgvTGlSa0pzLzJOckJkSHIwelpkOWl1bFY4bUZ1VkNiNWE4TWtuWUF5Q01M?=
 =?utf-8?B?RmI1UU5xRGtEUEVIQytGWUIyVm1tMkdnUE03N3RSbk5zWTFCL3BDRmJIMFVk?=
 =?utf-8?B?UURjVUdwNGRPbmpaTUlMeFNxZXY4M3d5MnpGZjdTNUhGSFVxd2dLdGVhcmJL?=
 =?utf-8?B?TTRoQmJOUGdpN1oyY21hNWpKcEpSRDE2aDhtajRHQms3ZFpNNVVmUDJOS0V2?=
 =?utf-8?B?R3o1QzZRR3ZpNUNYTHZQNXV4TW5hVSt2K1F3a3lwTXBGRmt4YVRmNzR6eDNJ?=
 =?utf-8?B?TTBBK1ZLYmZPZElnRWF6ZDhOVnpjZEZlSGJTaXVSSkJ1TUk1TUJkajlFNlZD?=
 =?utf-8?B?a090cTgydjIyTUs5UU9zM2plV291b2NUOGR0eGxoUjBLTHpoM3g2ZXpzVGQ3?=
 =?utf-8?B?RnpDci9IS1krTTF1RmllQjgreGl3OEsvYnZzbWJ3SVgzT0JQTGU2b2NkMGhU?=
 =?utf-8?B?RzRzNU9XVzZxWnJWYS9hVkRlVithdFFuNDFqQTkzZHo1RGRmK3VLY283dW5G?=
 =?utf-8?B?Zkt5eFJ6TkVJQzlSM0ZuY0FSOHFVaFRqR0p1b2RuNUg1VnRkVS80S3dBb0dx?=
 =?utf-8?B?NEt6cENPbmdwZGUwUWZVMis5K0dWaVdVWFBKUmxSdEM3S3Z0MFBkZHo0c1Jt?=
 =?utf-8?B?SkxVd3NwTkN3cCtXYUVxNm1jbGxSMXpzbndWT2ZZQUY2RmtEYWNZSHdzM1hL?=
 =?utf-8?B?b2VtRFh3cFcrM2dLaW9jaDRaaUNUeGY5aUkvSCt2L3lhWGxMQmZ3TTI5bmlh?=
 =?utf-8?B?TkxrbUlOUDJsVGVkZkdPbGlsaUhnbHVzSG5XelNUbDFtc0FmN3JEQjNjTVY4?=
 =?utf-8?B?MFZMZVZNUFRtb2xIUXJnSzlzRGFFUk1zdDQzNzdUcG44WE9MaEpQb1Fnc2sr?=
 =?utf-8?B?Vjhrekg0QnBERTFRVUU4VEN4WnBEODhIb2FHcHd2NlJDYVFPaU8rdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14923416-202f-4d19-12e5-08de412812ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 07:02:30.4740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpbW+eTHgBt9HR4jUrMKW9Cabmmtc+NTxCnAvMT5obPl4cHwWnCZmYf4f/+OY1usLh8WeqKa7kF6lKC3l6VcaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
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



On 12/16/25 17:26, Timur Kristóf wrote:
>>>>
>>>> Did you have an update for this series, or are they ready to be applied?
>>>>
>>>> Alex
>>>
>>> Hi,
>>>
>>> I re-reviewed my patches in this series again and I realized that my
>>> comment was mistaken (I confused link encoder with stream encoder). So
>>> the patches should be good as-is.
>>>
>>> However, in the meantime Mauro got back to me this weekend, and told me
>>> that he determined that the patch "Setup DAC encoder before using it" not
>>> only doesn't fix it, but regresses the analog connector on his HD 7790
>>> further. Before this patch, he got a black screen on boot, but the DAC
>>> started working after suspend/resume. After this patch, it no longer
>>> works for him even after suspend/resume.
>>>
>>> What do you think is the way to proceed?
>>>
>>> A) Merge all patches but that one. I'll submit a corrected patch once we
>>> figure out the HD 7790.
>>> B) Merge the whole series as-is and I can submit a fix once we figured out
>>> what is going on with the HD 7790.
>>
>> Plan A sounds better. Let's not merge a patch with a known issue. I will
>> also share test results by the end of the week.
>>
> 
> Hi Alex,
> 
> Thank you, that sounds like a good plan to me.
> 
> Timur
> 
> 
> 

Hi Timur,

No regression is found by promotion test.
