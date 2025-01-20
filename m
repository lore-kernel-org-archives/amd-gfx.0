Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A205C02185
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 08:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25F010E374;
	Mon, 20 Jan 2025 08:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YhwlVMQU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A957D10E374
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 08:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ae4TDU56Bl3/gdVauIpEA5MBMj6t5PkzHniPilWZhNQUZdbcKZn4hpzWHvfF8f5zrr4WqfuCNBcZcy21gYUtO7nDnx38uCFfsInVlHjedk/Kd4y0+FF/C5KM6Xh5PwST3irWuT+5Oo6/DgrcVzS59ano6+vKPQpwYx4mYiP8DKvfP3unO6OTbTclPuOXzYecV+o4F/Jlm/Mf47j9YuC7y5nB3L9ej3jZej6sCpxOvrRLbGky/f92gaFjOEPiyPdnuCdH3y5pmh4D/WcOHNpj94uc75dlrhOSe6cMCmgTb/ohay/NpUdl/+yHOoDTXSYNyzYrJ9wfFUJVni5io6+6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7nZpWJWzlMBuPy9sQcHElwsG8GRPqWlV7mpbVLry+A=;
 b=EmXA15BDS9aNv9hKJvS51eDA7spey29nFFdaLFQu+xZJ5V7sePf0YPamf+k37i49cVfGOytRRU4t2L8z/q76ywXkX8xYAi6nRmKrPFnXgzdrZ5s+0Ia1ew6EEo/uHhUbvQACMnd2is8u7RtRUElZo+QMYdlXvvXlgBj5v2lTxy9eSupSZotbXUBsaiVwwld+FzGdPU3tLLek7+6hGqeXsyI9nT6y1sqz/zaWVITWt75dHFwiCpmdUqhpKeKteWuUSSxvrVaAjJo5Q79rtWl1pvVWbz4AZ+QzAzZclJoApHXDnKlYvpROevswm4fb6Ky8qKEnflEBKJPccIPzp2Tm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7nZpWJWzlMBuPy9sQcHElwsG8GRPqWlV7mpbVLry+A=;
 b=YhwlVMQUReoGImyflc3JykQlcyokp1k/u9qE15ax9fp3R9RvEwHMZ8xHZM7Q8pP+M+NAhQOpNP44lVYkUx64PiI4x0GoFAsTZ4/N5Jyyc1D8Tz4OfHRXjyjpGkZJRZiUBP6LKiCKPWEwXtzdwu952t0yT3rNBdq7ChXcPTXY66o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 08:59:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8356.014; Mon, 20 Jan 2025
 08:59:13 +0000
Message-ID: <fa7d0cd2-8a38-4dbf-b603-b922f853836b@amd.com>
Date: Mon, 20 Jan 2025 09:59:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix ring timeout issue in gfx10 sr-iov
 environment
To: "cao, lin" <lin.cao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250114100603.20997-1-lincao12@amd.com>
 <PH0PR12MB549789733ACA53285FEF9696F51B2@PH0PR12MB5497.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH0PR12MB549789733ACA53285FEF9696F51B2@PH0PR12MB5497.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c1e59b-0f08-48c8-024c-08dd3930b63b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWJVWVVha2t1MWRCS3AxZ2dMRjRzbHpMV1FnbU1nYXJVaVp4M3ZlNTlLVDZs?=
 =?utf-8?B?RmZQd2hDdTVmSk9iVEtUdXVXZnpFVDJjeStiQ2R2UlIwVlBDOXBvZzUyekRt?=
 =?utf-8?B?RGpBOXBrdkJvNDVibGRmUHdKMWtSVHErc1Baempxdmk4eTJpR2JPc1Jybmx1?=
 =?utf-8?B?Y2V4azJIcHhwREd5WHFwMUUrWEtFK1B5ak56QlUwNTRPZU82V2dpYzd6OGJX?=
 =?utf-8?B?bGhDT05NNEJVYTVIY0plVU1YUjI2VUt0U2RKL0VTN2s2clhiRHJoNGZ2VW9Z?=
 =?utf-8?B?OVBGRlBqNmFYRDZXMTh0Tk82V0s0dWxYSElqbExwNjdEdkJxZGZOa3BOZ2NQ?=
 =?utf-8?B?L0ZMZHlTaVl2WUJ5SFBIb2lqVkpmRFhuTHJWYmtaZGNIN05xSGRSSVYwaWNz?=
 =?utf-8?B?TTloVGZwTEdEMU9qTjducjM5UVRWTXdybXhOR3lvN0o0SmI4dW5QL09GU0Jq?=
 =?utf-8?B?OTlnbmFQVi9vTUhYN1E2WHhUV25rNnVCWEFFeS9EWkhBcGpsc0lxOGxWNzJW?=
 =?utf-8?B?ZGtPaDVBZlpPYlY0dE5obW5aUkNIZElFZUNhOUFXSGw3eHo4TXlXYSs2Yzhj?=
 =?utf-8?B?WkN6SmJ4OEU4a1d5V25WZHM3YkdlYXpVVmE2enArUGJZcGVNa08wUFNLaFlF?=
 =?utf-8?B?WmpLOEIyWnpoYXpTN3ZiaVNSbG0rRlN2WU03VGlGZlF0VGU1Z29SRmpYc1V5?=
 =?utf-8?B?d3JsUzhGVSs3em1ZMjQxd3JkSDlnMFZTRzZuZTd4UktLQTNyN3FlVW5ZMkNJ?=
 =?utf-8?B?M3VwTTdBcFJFVUpjU0FGK05sNFZGNFhhRWZUV0FTOWFXRjZQeERkVXI1MFJD?=
 =?utf-8?B?cjA2dUpvSjU0UUl6R1ZBTnhyZkZ6MFk0cHYvdlE2Mm5hRGF3b3gybmk0bE83?=
 =?utf-8?B?ZVNOMWlBczZ1amUwYXZGODJvOEtQbWg1amdRSGppNTNMcW53UjdUN3JTNzNw?=
 =?utf-8?B?VlpkVCtCNGhDMkhsQUtIdWx6bmNLRHI1VGhGd3NkekJqcWUyTWhFWVUvUTls?=
 =?utf-8?B?dnQyQzlubzBlZTVTZkNFcGdmRmVjMFJJaThsd3NrenNzZC9jS05GYnN1STdE?=
 =?utf-8?B?Z2k0c1FYdGUzTUpIU3JHMHF1NVJYNVY2MkRTZXZienFEVnFvYkVhSmNuY2Zs?=
 =?utf-8?B?cUNoalUwZjFTTFRRaHUvSzBBcVNPT3BIOEh1cW44T3pBZ1NZQ2lwZDIxNFF6?=
 =?utf-8?B?bXRiNE5lWVUrK01rTXpZbFlSY0xPblhxdUJ2dFlMa2ZJVGh4SGRYZG1YVGdv?=
 =?utf-8?B?NENZTE5za0FhMHZ0VmpEVWc3VFExWkcvNFRiS1FxUWZoZWJEbmR2SmxHOHFu?=
 =?utf-8?B?b2N4UzE4d1QyL0Znb01pTGlBVWI0alhveEFGSHZla0tCdG16d2xkYXdRWmhK?=
 =?utf-8?B?Q3NydDhBNnJPNEdWZ3ZDZ1FrTXJ4c09VcVh4TkhiNVl2b0xWdGtWMFFFcGhu?=
 =?utf-8?B?b3FhK0NoZ1hycFloc3dOYmVYU3NFUG56OFRTNWpnOGNlc3dEUVNXQUlmZlRp?=
 =?utf-8?B?SmhNRVlEOVN0eDVEd0VuMTFNY0tacFoyb25mdVFCbnFLQU9jR1QybUVJM215?=
 =?utf-8?B?MVM2czRqSnMyNDgrR3VpbjNlOG4xb2VZdTJGbHFQYmEvRTVmNFFjZDNCWjZn?=
 =?utf-8?B?TkhVRkhPRnFnSmkrMjZyQi9ZWkhaYVhXWmdzdEtFTXlvRElhUm04cnZTWjdy?=
 =?utf-8?B?dy9tdzNYdmtnRFpzL0l5SnlhVmFYbUhHUlY4UGMyb25ta09rNnhCNWpEdE9I?=
 =?utf-8?B?L1dJL2Rob3pYK1NLMStDYTZJR09BRStRcVBMdjV0MVVkdS8yWVNUYnpIN2xN?=
 =?utf-8?B?VTVWQUd1dE9VKzZHVmtrUDREQ2VlMm5JTFhjS0poUTZHdlMxTm5Oc01DZVda?=
 =?utf-8?Q?eNjGLEanvw7NF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUdWeFhwUnBVQVVXdm5sdVVKOW5EbzIvTmRmRFBwV1E5TTk3UDBBV1ppL1A1?=
 =?utf-8?B?di9tenVNSmpFREs1QVZVMTZIN3ZSYU1Sb0pFbGlqY2FPM0oyTkQxamZkaDhP?=
 =?utf-8?B?cnJXUVNqeFRycGJaV2ppeU9hRm1lbGZZWCtCV1ZOVVJuLy9TMkdDM2g3Y1hy?=
 =?utf-8?B?elhYWVRONGVhWTlxVzZmZVdESit3WVV6dzZlM2hJVmIrVmpnNzZkdzlLUVNs?=
 =?utf-8?B?MVZrakFSL09JTXRRRVREamY2dVF5YklOSDBVRFRDQzU1RzA5Q0JLVWw1U01Z?=
 =?utf-8?B?T0tWYWl6cmdxMmo1UFduaXlXTWVDeXdhQzRHMFJSbGZaWCtuTjkyaE9JL2xK?=
 =?utf-8?B?SXc5aGp3bFFkemg2NVlaY0VRNEdrMS91RVJZWXc4QTYzKzBzZUNxOWd3STlN?=
 =?utf-8?B?K1JWSnJUZUt1U3hHdXpzS0ZURTBUNWJFNTdpTW9KYTd6eVFZN1VJUWdIb3VI?=
 =?utf-8?B?ZVJPNWJwQjdxeFZTTHYxbTgrdkZXdjFmUjk1S2ZRcVVyM3BuUU03RGY1YmU1?=
 =?utf-8?B?YytGdmI5YUhxczhvaVNyRDdSSXN4ZzUzZ1lSZnh2QnB6QmRGY2lsMXFwaUx2?=
 =?utf-8?B?UmZ3QlBsVFpNUy93YnhQNkJZV2dCUG0yNnZ3TlREb3hWUkp6dk9xcnlTNnhD?=
 =?utf-8?B?eGRkS2JSR1VUU3d3Tzk2aWkvS3FUWW9RZnpOM2svKzUrelIrVitQS3pZZ2c0?=
 =?utf-8?B?cUQwZ3l6Q3ZRRmJOQTFTbUs2TVZ5eVBiVCttTzJ6eEg4TE03UXJkSERyWG1z?=
 =?utf-8?B?RktLME1wVkcrZHdWOG5Vcmd2ZG9WVDdLNWdwUllSVFZlWHVMWTE2YWszbWcw?=
 =?utf-8?B?TUVBNjBSbW1VRDhZSm1qWHkzNWtyWWhianZ4Z2xFTTRHRDFDMUJDRDdXK3ky?=
 =?utf-8?B?WXJPTVNNcjQyR1VISEtHTnl2ZndyV0dER2RCeDFqUkVwWnVRaS80N1V5bXM5?=
 =?utf-8?B?YzloRHgrU3lkenpySFhLMEhncXhRSmpHVUdDUmtOQXF0T052bGR3OW8rcEpw?=
 =?utf-8?B?Zk1US09pVmpnNFoxTkNYeU5SMisxYkZkUUxQYnBUdGNmVUN5KzVvMUtHUHJ1?=
 =?utf-8?B?QTI2TDVxWVVhQk0zTVNMYlVXVDVEUHcxdTZmb2Z4Z0RWdzlqWVFtQ3lGNkEx?=
 =?utf-8?B?bWtuY0tmUk8vckpCL1JkeGpVTy94RVIwQ3dCMFJSVlBGcGtDcEsrcytnZTd1?=
 =?utf-8?B?MWoxR2RoMDc1VVBoMkZ3U2o1S09GZDdRMEE3SWlFdnNBOVRDK2doQXNsL0ll?=
 =?utf-8?B?ckVEVGkvZmpSejQycm5FbXI0c1dyNTdpRFNCWGkrUll5MU5Tc3FjZDNmNGJQ?=
 =?utf-8?B?QXUxUkFuSVJ1am9PVURTUVJxZE5yRXE2KzlZbEt5Y0ZPN2UzOHhCWnE4K2Uw?=
 =?utf-8?B?dEtVcTdndzhrL3AwdnVyTzlFekxNNUZ3c1RBdDBPK1JOVkNSTk9NZzRXbm10?=
 =?utf-8?B?M0V3N3NRNkJtYnlWMHBtMnBvcUV2R091bmNhMmhtVzEwZG5EOW9ZUm9VVTBl?=
 =?utf-8?B?UEVyclVOcFNwSVVxUEl2elJldS85ZG1CRXk0OHRpdzZHUGxJY0F5cHJCemlJ?=
 =?utf-8?B?U2JlTTIrcEJHb0ZqczhiZjRZSE1ITG03K1ZmZFh2NmhadG1XY1JyK0FiS0Zq?=
 =?utf-8?B?S1NsbTNGKzd1WnUxaVc3S3IwdWdXWHhtb1ZxRG4weUZJdWtUb3BhYUJYSjdi?=
 =?utf-8?B?L2hZQnByYUM2SUlzVWtuQlQvMkF0cVY1dkMvYjE3MUhQaGxzNFkvanR1akZx?=
 =?utf-8?B?SHdYdnpGWEFxY3Vtbjg2TTN1S1hFOVJTT2hKZWV3OXRsOW1HODdGdS9Zekx2?=
 =?utf-8?B?d1BLSHZLc0FhS1h5ZWlNdW1HMTZSRHNXYjRNZjg2UDVvdnU4d28reHpPT0NH?=
 =?utf-8?B?OFFTN21vVFNpM0p1c2VtUldidDdGeEs4MG1pVi9rMHVTSHlPK3VISTIwOEds?=
 =?utf-8?B?bDJhZkxidDVpdlEzNXJ6OVB0cEwwdko1b25nRmNhT09kVi9QQjBPRGFLMFhs?=
 =?utf-8?B?ZGxaaEEvTTN1c2FjR3hqdzJ6d3Bjc0pjd0l5YldCemg3Z2c5R1dIUk5ZYWJM?=
 =?utf-8?B?WmtTVFNocVZ0Snh1RjROazV6bW5UbFhIWTQ2aWpudFNTVjBOWGpEaTRQOWRt?=
 =?utf-8?Q?Sqzg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c1e59b-0f08-48c8-024c-08dd3930b63b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 08:59:13.7477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zabdGzfLqd+cMXr5np8Pu4Zc+df5Vq3PlwmJFojMdUYOt4vt3G7zOyvR9RMSWQJX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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

Am 17.01.25 um 07:05 schrieb cao, lin:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Lin.Cao <lincao12@amd.com>
> Sent: Tuesday, January 14, 2025 6:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; cao, lin <lin.cao@amd.com>
> Subject: [PATCH] drm/amdgpu: fix ring timeout issue in gfx10 sr-iov environment
>
> 'commit 6e66dc05b54f ("drm/amdgpu: set the VM pointer to NULL in amdgpu_job_prepare")' set job->vm as NULL if there is no fence. It will cause emit switch buffer be skippen if job->vm set as NULL.
>
> Check job rather than vm could solve this problem.

Good catch.

>
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index e0bc37557d2c..2ea98ec60220 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -297,7 +297,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>          amdgpu_ring_patch_cond_exec(ring, cond_exec);
>
>          ring->current_ctx = fence_ctx;
> -       if (vm && ring->funcs->emit_switch_buffer)
> +       if (job && ring->funcs->emit_switch_buffer)

Maybe better to use "job && job->vmid &&"... here.

You should also remove the vm variable and see if there is anything else 
using it.

Regards,
Christian.

>                  amdgpu_ring_emit_switch_buffer(ring);
>
>          if (ring->funcs->emit_wave_limit &&
> --
> 2.46.1
>

