Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D81C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 05:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4FF10E79D;
	Wed,  5 Feb 2025 05:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j5bbBum1";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A30010E79D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 05:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smQ+Wp1shMkaezDzfCAKBby3W+5twzSkLEHfuLX2xT5rsi+MNKZn6OTUlhnSb25d6Ck/sKqLOXNNLFI1asuP0ItH9Af7Gbf36uYigemWqE0UzWiLBVdZUaHZfB7oMASdO4T2Eetbwizczapic//CFEdg5GlyA1ZCJEQ9ZxC4d0371sILSDQDeVh0/ZMn4VjGrfUJIsGRJn02tIOGlyBABxIox6Ouonro9aXxzsXOmALhG1Gzss0UbMwhds0zhoBAM6ujuZOv/VNmupxzYmKziCC0EkVgS9TNVSL5wVgz01GkMZ5mbkYzlmCxpNnt7nGVEsBitKqd8hqrjPP44YpCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyMOHTBq0yegYpMCQvdI+AcWb3gDOYnWEjNrOFCnsRU=;
 b=fIxhE7w1ePIv1zVzyE8B57QU3QSIDcO/WbFX4deqOgLnRECqlybCBBfBxHGP4YSt0GZiizlnh2Eh5Y9kNB90UOfiVOpgMYEgAJEfZV3DzeJ20gE0Wlfd8c5ibmQwTM+XSgBDb8pnGSZmsLw8qYfN/5ldb1Y2FB1/zEtP/eJjykSc7DHXTwgRku491UGKIkyz2cnQ1YBsjVSn8GGV6Ac/mHvmG9m3CI22jFiaiWWMGI/4FOTcnK+MFwiB9U+qP7JBZ0ztiyNCij1WRTQ1y8CrR8rHL4Tay4uh1H6eWuI+XzXI7zyt5AdbuD7CeGPIhkhe6K1FYHULHHWeoc/c7wUPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyMOHTBq0yegYpMCQvdI+AcWb3gDOYnWEjNrOFCnsRU=;
 b=j5bbBum1MpRY00xmkEXvVScCWpsYwCzh9lo+gJaOPUOAekEO1i1qjULBGtNRVZVLaVxs2DuafpuStlwp3Khxzah1kVvrSAhZYKRP5/FGmPj6Tv5vK80edxdcrG4XJ0Abhdppq8a7WaPmfa/JcnPhGxPzvsohVqIL6E8T5h9iesA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 05:45:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 05:45:44 +0000
Message-ID: <2e74324f-67b9-4a2e-994e-d52ffa76206e@amd.com>
Date: Wed, 5 Feb 2025 11:15:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/pm: Add APIs for device access checks
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kenneth.feng@amd.com,
 mario.limonciello@amd.com
References: <20250204063817.1865562-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250204063817.1865562-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: d5840b18-2f9b-4fd8-7f55-08dd45a8555b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlM4cDdCSmFvY3JuUmlhTTExSG9HNE95bkIxZU1CWUZXWW1Sa3V2MDBTUnNS?=
 =?utf-8?B?cDMxVGIzNzB1NmZ3bHlIb1IwdVhMNGpRVzRNY0lJcG1LTHRRYTNyRElxNEJL?=
 =?utf-8?B?VVltMWdSVXNMRGd2R1RLQ3RMRXcvL0RJTVU0aXU2ZkEvSUFlTEUrUEVRc1pO?=
 =?utf-8?B?VTRKMXVEdHpINjhPUW5RMzRoUXRpUzlJRXhXVTVQOTNGRGc5V1NtQlhISXFQ?=
 =?utf-8?B?SHJFV1hNclY3Ri9RZTJ1enhUTk1ONHJHbndubUVkMURQcWtlbyt1dlA1QlND?=
 =?utf-8?B?Zjk4aG9iczVHbzBKQ0xrdVhDSTVnOWtlOGIrWXRhN3REbzhEUEFjdjRXSWxx?=
 =?utf-8?B?SStGZFVZNHpvb1JLZnFGYmNVVjJpRFRRL3Q4UG5OQWFpeVJXV3hVS2U5QjRB?=
 =?utf-8?B?Zk9WWm1WMTdlTzhRVTlFcGNHRk1CMmkzbDlvdXh3YzNPODdXZGFkS3NOUGVM?=
 =?utf-8?B?anYzWGNwbGdqclY5aExsWVhOMmQ1ZktwWGh2YjBOa3p4UWNQQllQenMwRFJl?=
 =?utf-8?B?enNwQjJMMEUyYXIyYjR4UCt5eUFBSnRJeGhDb1VabDIwSHQ5cWxWUmYxcVR2?=
 =?utf-8?B?QzBZeEZCMEVEUlYvcTFnWU9tRGRGcDZ2RlBmSWliOUZsNlROZUJiL2tRejJI?=
 =?utf-8?B?djVmTGlsRGlkR2RxUXhEUjZPS2FOczhJTWdya2JtQ3ZUNFc3TTFKZU9ucmRC?=
 =?utf-8?B?MlN2azU1MGRFcCtqWXZuM2FNaUNUbHllQk5FQXI5bGNDR1hXdWVnN2tzZVpq?=
 =?utf-8?B?bmhtdHJpQURZRFRaUXY0UXdLU081NUlyN1hNeWJja2IvZVByZVhzSkVqQUhY?=
 =?utf-8?B?WU5vSjdCTmw3TFgzREJMRVd1TXdIa0FydVVyV1IydGdrMms3NWxqb2lmY0pH?=
 =?utf-8?B?ZDB0QkUrc3NyWGNzckFjMmR6WGNxVkw3WGVYdkZFMDJ3VWpRN0hYUHIxcmow?=
 =?utf-8?B?d2ZsTTlmWTd0LzJQd1RQQ2UwVTU3UlFIOUprMmRnTXp2dWpKY0VyYkp5Y1Nk?=
 =?utf-8?B?amVkVXA2bkRJemZ4a1lLMVFHdE1sUFlwejJBcERJcDhKTTBTeGpmUUh5eStm?=
 =?utf-8?B?VnJPWjkzeXNQTmQ2Q2FOVEJtVTJhMkZ5NDJaWm4yWlBNZmlxUUlFU2NCdTFO?=
 =?utf-8?B?eE5TWUg2SVdVaFhYazlYazBzSC9iaWJWRmJqTldTbnJtMFE5RGdWN1B4d293?=
 =?utf-8?B?K3VmL0FBdGsyM1ZOd0dyUUN1TW83T3ZIRlQrWlZuMHkrV3o1UlhONnZmTnhS?=
 =?utf-8?B?cDExTXlFekZpRkJOUGlNMmh5QWxPck1Yd2F0OFpMR296RHpsa2NiNklIYUVN?=
 =?utf-8?B?V3pNdjFJSTVsTllMMFlJWTVIUlZiWVBtK2JZZ21PNU9xWjF3d2xDdS9BcUp5?=
 =?utf-8?B?SlRrTmJTbmwvcFRQMGNabTdwVU4xRkducjg3cHpYczQ1YkZqRDJOdWZ1emdt?=
 =?utf-8?B?NVZkODR1UEExU05IOCs5cm4yQW5mN0tGeStoRis2YkRjOHRBYVpSUFVqWmpU?=
 =?utf-8?B?WGk0djhvTFVDQkFlOFJMUmt2bHUwd1pWa0Z1LzQrcFRxM2hwRmNmRkY3dWkz?=
 =?utf-8?B?U1RzYTdUZGxkcWRIbGptakFVZ0dUM0c2ZGRKR2FxV0xGM3FvSmQ5VUxnYk04?=
 =?utf-8?B?N1VlRE1MSGRJMFNSYWFHczZMZHdPS1lGYTBKNFhkVFoyUEtQTjFodXVRR0V3?=
 =?utf-8?B?Wlh2UFBTZUN1cmJqQU94SDFONjQvU0NkemtZK250SitJYlp1REwzaDV0d0pk?=
 =?utf-8?B?TVF6RmFTUUVuekxlMU1KbHVDUmE1a0R4YnBQa0VuUEV3KzBWdW5QTDFrNjFx?=
 =?utf-8?B?ZFZzMGNqMWJMZU1BSnpBWElQU2FLbUd3YjZNdXBBbCtrWEdzSEVxU3NRNVVU?=
 =?utf-8?Q?VwUIQ5ZP5S6k/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUFzejdoK0JKUFQ1Tmd2UXJRdnJTSW1CalVDd1h0dXE4WVd0NWpHTkdZYjM5?=
 =?utf-8?B?TCtvc1J2ajl5YXNtWEhWQmZzMi84MnVFaVdab1pZSm1UZnBBaEVjaGR1RG5S?=
 =?utf-8?B?emFmbGlYZ2Y4M3ZHUDZxalBhaE90a0M3aTlQSmRlUkxzYnVNVDJnRVFVN2FS?=
 =?utf-8?B?bUFKU3hkOGxNVGRBbXZJdEFuVEtzQ1JBRG5Pbmo4U29DY0REQ24xUFhIWnl3?=
 =?utf-8?B?WDJsODJGZkZZOUpjdytJU1pMSDFKc1dIYW1kcXlpa0pOZ0hadUduam9ZdnpW?=
 =?utf-8?B?dzROUHZBd0U0Q1VZRFNCanNXZGJmOVNrTDdMMUlodTJMS05BVnEvZGJGQkFy?=
 =?utf-8?B?L2I1UVNTN25Sd2JBNGszU0dLaHFoRDc3emo4VVFLYkRWR05rZmdPMDFBOWV4?=
 =?utf-8?B?a21OekErUVlhb3h2WVBBSHJNRTYzQk9PRmdLSW81anN0emxXVUx4RitOdnZP?=
 =?utf-8?B?bUFKTitoSFhQZ1h3bFBzQXowbUFOOVM0MitwNnVPREcyNmF1amsxUmF5NWpS?=
 =?utf-8?B?c3NIS05la1BGN2RRTDZGWEpVL0RrNXZSZkFQQkNjM3FOQ1ZCWDNMcEl4eCtI?=
 =?utf-8?B?NFpTR3ZsTlQ2V0RxbzdldWs0VUsyNWRBK2M2MEZiZVF1b2tFV25pNi85QUx5?=
 =?utf-8?B?MW5pZUZHcWV5Q2c5THdCVmdtd3ZVSGlaVDBJRFNwcnV3cXpPZkJ4Ym1wV3FH?=
 =?utf-8?B?Q0VYZHNITHRYS1FqWDRKQ3pNQkpIYk5aM3JnWDBtcW93NVA4S3ViRUlSWXNm?=
 =?utf-8?B?R2dXcXFxeFA3QnlPODc3eVZaazh1QURkZzlRS3N6b3ZhN1NjOFB4MEQ4NDJ4?=
 =?utf-8?B?SHR6dkRtZnhjNVZubUNRNU9ZQXV6RDlNRW1nMUIydk1aOGhKeHozNWxxQnd5?=
 =?utf-8?B?SkRrNURxS3lFL3ZFdVdSOU9JNWZvMXdIUzlTVm93V2taayt3eHl5NnBnSmRJ?=
 =?utf-8?B?OTROWDVmWCtOSlBvd0ZPUXdUczZBWVd3UjAvTUZiWDJobkN1VzJ6K09JcERE?=
 =?utf-8?B?U1NEZmdUUDZ2MUYvZnlJeFdodVh6S2VFOG1ET0R1UVFMaUsyVGdtaW40bGtm?=
 =?utf-8?B?eHROSUhYNVgxTnZ4c2lzSm1ELzJsZ0FVem9BQmJQdzl2cS9QdGU3M3dwU3Zo?=
 =?utf-8?B?bWhHdDdieHpvT1RBNlRVQUxIMXdMWWVieWhKdmRyTlBiWTdzMHdtaUtnYmgy?=
 =?utf-8?B?eXNFd1BNSURkNVVFbjNqQmVJeUMxckppSEJyenNNakVIaTl3d3ZUdm9TOFVn?=
 =?utf-8?B?R2VIYUhwcTJyQXR1QUQ4Q2NVVmgyN1RyT3ErbGNKT0JBUjdzQTI3WERtSVhv?=
 =?utf-8?B?bk9qWHUxV2JFRU52b09ZbTJ5ekZpNzZqN2lHM3ZHdWxjMEdGcnl0U3FCaTNl?=
 =?utf-8?B?Nm4zQW9CK3F4NFd3K3cxVGRVWkMvRXZFWXdyUEhjNWx4bVh2K1drSkVVZ3VJ?=
 =?utf-8?B?dnJTRmlCYzEwclJtZFJYVWw1N093TXM3OXo5WnlWY0FWNldHOGlpeVhDcGw3?=
 =?utf-8?B?S2g0bVpUQnNzcVFPbTJBRytaUk94L01yWXpWam8wTW9XUy9VOW5SelNSWHo4?=
 =?utf-8?B?azc2Slo3algrdWcyb2RjeVFMVmZxTkJIcHN5ODhPTTNqZzNyNlNBUEtoVGFQ?=
 =?utf-8?B?Q0k0V3VtL3VUaFhYUHBVeDNlTUFQTWJDZzUxaGdvRFhBNWRaNlhNcXNaVGMz?=
 =?utf-8?B?YjlNQTBBclhLL1BuRkFPT2V3K1ZkN0h6aXc5T0tMZWZiYWplOGtkWDBYclRB?=
 =?utf-8?B?VGg0bVVBSXUzY3pkWGw0YWl6d21NOGc0dEhIbVBVc1JwUEFaUG94UzNnUTJW?=
 =?utf-8?B?UXhoZFg3dkdEUkh0eVJabUxkeUxVYnppQWxMMFUrRkhYSlA4ZGxWWlpiV0Vn?=
 =?utf-8?B?cjFiV0s3SEJqbDR3azBidk8rbFVSSHBOUWY5WlZsUVVSdjdmdEZ2QVQvdVA0?=
 =?utf-8?B?NGJzN1Jqa2lPcFZTcGt0VExnRkVzeTVPckl1eXRMR1NkcXpyVjdBTGZXWkdB?=
 =?utf-8?B?N21CZ2tHRHhLYkZ4ekpPMDFZZ1d5U2hHa2NkZE9SenhCSks3YzJ5QjBYNExR?=
 =?utf-8?B?UU5qWWJ0dzd6aHc0TGRRK1JxUERPTno0SytSSkdOYzA3dHF6WlNnUktCMzJt?=
 =?utf-8?Q?vQvo78X2rEn3eyMPX+6ms85oA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5840b18-2f9b-4fd8-7f55-08dd45a8555b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 05:45:44.8957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAzOgyeQuxos0k2A6KwoOp6lXa8wiiJpZBvh0ofXSbiW4llktfZq/d6tKybMqPKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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

<Ping as the fix with second patch is a bit urgent>

On 2/4/2025 12:08 PM, Lijo Lazar wrote:
> Wrap the checks before device access in helper functions and use them
> for device access. The generic order of APIs now is to do input argument
> validation first and check if device access is allowed.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 616 +++++++++++------------------
>  1 file changed, 229 insertions(+), 387 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 0aca0803514e..0fe0b798f559 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -97,6 +97,77 @@ const char * const amdgpu_pp_profile_name[] = {
>  	"UNCAPPED",
>  };
>  
> +/**
> + * amdgpu_pm_dev_state_check - Check if device can be accessed.
> + * @adev: Target device.
> + *
> + * Checks the state of the @adev for access. Return 0 if the device is
> + * accessible or a negative error code otherwise.
> + */
> +static int amdgpu_pm_dev_state_check(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_in_reset(adev))
> +		return -EPERM;
> +	if (adev->in_suspend && !adev->in_runpm)
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_pm_get_access - Check if device can be accessed, resume if needed.
> + * @adev: Target device.
> + *
> + * Checks the state of the @adev for access. Use runtime pm API to resume if
> + * needed. Return 0 if the device is accessible or a negative error code
> + * otherwise.
> + */
> +static int amdgpu_pm_get_access(struct amdgpu_device *adev)
> +{
> +	int ret;
> +
> +	ret = amdgpu_pm_dev_state_check(adev);
> +	if (ret)
> +		return ret;
> +
> +	return pm_runtime_resume_and_get(adev->dev);
> +}
> +
> +/**
> + * amdgpu_pm_get_access_if_active - Check if device is active for access.
> + * @adev: Target device.
> + *
> + * Checks the state of the @adev for access. Use runtime pm API to determine
> + * if device is active. Allow access only if device is active.Return 0 if the
> + * device is accessible or a negative error code otherwise.
> + */
> +static int amdgpu_pm_get_access_if_active(struct amdgpu_device *adev)
> +{
> +	int ret;
> +
> +	ret = amdgpu_pm_dev_state_check(adev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_get_if_active(adev->dev);
> +	if (ret <= 0)
> +		return ret ?: -EPERM;
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_pm_put_access - Put to auto suspend mode after a device access.
> + * @adev: Target device.
> + *
> + * Should be paired with amdgpu_pm_get_access* calls
> + */
> +static inline void amdgpu_pm_put_access(struct amdgpu_device *adev)
> +{
> +	pm_runtime_mark_last_busy(adev->dev);
> +	pm_runtime_put_autosuspend(adev->dev);
> +}
> +
>  /**
>   * DOC: power_dpm_state
>   *
> @@ -140,18 +211,13 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>  	enum amd_pm_state_type pm;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	amdgpu_dpm_get_current_power_state(adev, &pm);
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return sysfs_emit(buf, "%s\n",
>  			  (pm == POWER_STATE_TYPE_BATTERY) ? "battery" :
> @@ -168,11 +234,6 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>  	enum amd_pm_state_type  state;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	if (strncmp("battery", buf, strlen("battery")) == 0)
>  		state = POWER_STATE_TYPE_BATTERY;
>  	else if (strncmp("balanced", buf, strlen("balanced")) == 0)
> @@ -182,14 +243,13 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>  	else
>  		return -EINVAL;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	amdgpu_dpm_set_power_state(adev, state);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return count;
>  }
> @@ -263,18 +323,13 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>  	enum amd_dpm_forced_level level = 0xff;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	level = amdgpu_dpm_get_performance_level(adev);
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return sysfs_emit(buf, "%s\n",
>  			  (level == AMD_DPM_FORCED_LEVEL_AUTO) ? "auto" :
> @@ -299,11 +354,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>  	enum amd_dpm_forced_level level;
>  	int ret = 0;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	if (strncmp("low", buf, strlen("low")) == 0) {
>  		level = AMD_DPM_FORCED_LEVEL_LOW;
>  	} else if (strncmp("high", buf, strlen("high")) == 0) {
> @@ -328,14 +378,13 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
>  	if (amdgpu_dpm_force_performance_level(adev, level)) {
> -		pm_runtime_mark_last_busy(ddev->dev);
> -		pm_runtime_put_autosuspend(ddev->dev);
> +		amdgpu_pm_put_access(adev);
>  		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
>  		return -EINVAL;
>  	}
> @@ -343,8 +392,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>  	adev->pm.stable_pstate_ctx = NULL;
>  	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return count;
>  }
> @@ -359,19 +407,14 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>  	uint32_t i;
>  	int buf_len, ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	if (amdgpu_dpm_get_pp_num_states(adev, &data))
>  		memset(&data, 0, sizeof(data));
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	buf_len = sysfs_emit(buf, "states: %d\n", data.nums);
>  	for (i = 0; i < data.nums; i++)
> @@ -394,20 +437,15 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>  	enum amd_pm_state_type pm = 0;
>  	int i = 0, ret = 0;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	amdgpu_dpm_get_current_power_state(adev, &pm);
>  
>  	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (ret)
>  		return ret;
> @@ -429,11 +467,11 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
>  {
>  	struct drm_device *ddev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> +	ret = amdgpu_pm_dev_state_check(adev);
> +	if (ret)
> +		return ret;
>  
>  	if (adev->pm.pp_force_state_enabled)
>  		return amdgpu_get_pp_cur_state(dev, attr, buf);
> @@ -453,11 +491,6 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>  	unsigned long idx;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	adev->pm.pp_force_state_enabled = false;
>  
>  	if (strlen(buf) == 1)
> @@ -469,7 +502,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>  
>  	idx = array_index_nospec(idx, ARRAY_SIZE(data.states));
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -490,14 +523,13 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>  		adev->pm.pp_force_state_enabled = true;
>  	}
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return count;
>  
>  err_out:
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
> +
>  	return ret;
>  }
>  
> @@ -521,18 +553,13 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>  	char *table = NULL;
>  	int size, ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	size = amdgpu_dpm_get_pp_table(adev, &table);
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (size <= 0)
>  		return size;
> @@ -554,19 +581,13 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>  	struct amdgpu_device *adev = drm_to_adev(ddev);
>  	int ret = 0;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = amdgpu_dpm_set_pp_table(adev, buf, count);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (ret)
>  		return ret;
> @@ -735,11 +756,6 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>  	const char delimiter[3] = {' ', '\n', '\0'};
>  	uint32_t type;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	if (count > 127 || count == 0)
>  		return -EINVAL;
>  
> @@ -785,7 +801,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>  			tmp_str++;
>  	}
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -806,14 +822,13 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>  			goto err_out;
>  	}
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return count;
>  
>  err_out:
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
> +
>  	return -EINVAL;
>  }
>  
> @@ -835,14 +850,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  	};
>  	uint clk_index;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
>  		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
> @@ -861,7 +871,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  	if (size == 0)
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return size;
>  }
> @@ -892,23 +902,17 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
>  	uint64_t featuremask;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	ret = kstrtou64(buf, 0, &featuremask);
>  	if (ret)
>  		return -EINVAL;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = amdgpu_dpm_set_ppfeature_status(adev, featuremask);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (ret)
>  		return -EINVAL;
> @@ -925,20 +929,15 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>  	ssize_t size;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>  	if (size <= 0)
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return size;
>  }
> @@ -991,14 +990,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>  	int size = 0;
>  	int ret = 0;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
>  	if (ret == -ENOENT)
> @@ -1007,7 +1001,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>  	if (size == 0)
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return size;
>  }
> @@ -1057,23 +1051,17 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
>  	int ret;
>  	uint32_t mask = 0;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	ret = amdgpu_read_mask(buf, count, &mask);
>  	if (ret)
>  		return ret;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = amdgpu_dpm_force_clock_level(adev, type, mask);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (ret)
>  		return -EINVAL;
> @@ -1240,18 +1228,13 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>  	uint32_t value = 0;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	value = amdgpu_dpm_get_sclk_od(adev);
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return sysfs_emit(buf, "%d\n", value);
>  }
> @@ -1266,24 +1249,18 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>  	int ret;
>  	long int value;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	ret = kstrtol(buf, 0, &value);
>  
>  	if (ret)
>  		return -EINVAL;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return count;
>  }
> @@ -1297,18 +1274,13 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>  	uint32_t value = 0;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	value = amdgpu_dpm_get_mclk_od(adev);
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return sysfs_emit(buf, "%d\n", value);
>  }
> @@ -1323,24 +1295,18 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>  	int ret;
>  	long int value;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	ret = kstrtol(buf, 0, &value);
>  
>  	if (ret)
>  		return -EINVAL;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return count;
>  }
> @@ -1378,20 +1344,15 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>  	ssize_t size;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>  	if (size <= 0)
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return size;
>  }
> @@ -1414,11 +1375,6 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>  	long int profile_mode = 0;
>  	const char delimiter[3] = {' ', '\n', '\0'};
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	tmp[0] = *(buf);
>  	tmp[1] = '\0';
>  	ret = kstrtol(tmp, 0, &profile_mode);
> @@ -1445,14 +1401,13 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>  	}
>  	parameter[parameter_size] = profile_mode;
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (!ret)
>  		return count;
> @@ -1466,19 +1421,14 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>  {
>  	int r, size = sizeof(uint32_t);
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	r = pm_runtime_get_if_active(adev->dev);
> -	if (r <= 0)
> -		return r ?: -EPERM;
> +	r = amdgpu_pm_get_access_if_active(adev);
> +	if (r)
> +		return r;
>  
>  	/* get the sensor value */
>  	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
>  
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return r;
>  }
> @@ -1576,24 +1526,19 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>  	uint64_t count0 = 0, count1 = 0;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	if (adev->flags & AMD_IS_APU)
>  		return -ENODATA;
>  
>  	if (!adev->asic_funcs->get_pcie_usage)
>  		return -ENODATA;
>  
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return sysfs_emit(buf, "%llu %llu %i\n",
>  			  count0, count1, pcie_get_mps(adev->pdev));
> @@ -1615,12 +1560,11 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
>  {
>  	struct drm_device *ddev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	int r;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> +	r = amdgpu_pm_dev_state_check(adev);
> +	if (r)
> +		return r;
>  	if (adev->unique_id)
>  		return sysfs_emit(buf, "%016llx\n", adev->unique_id);
>  
> @@ -1715,9 +1659,9 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
>  	struct drm_device *ddev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(ddev);
>  
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
>  	if (!ret)
> @@ -1725,7 +1669,7 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
>  	else
>  		size = sysfs_emit(buf, "failed to get thermal limit\n");
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return size;
>  }
> @@ -1749,20 +1693,18 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = amdgpu_dpm_set_apu_thermal_limit(adev, value);
>  	if (ret) {
> -		pm_runtime_mark_last_busy(ddev->dev);
> -		pm_runtime_put_autosuspend(ddev->dev);
> +		amdgpu_pm_put_access(adev);
>  		dev_err(dev, "failed to update thermal limit\n");
>  		return ret;
>  	}
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return count;
>  }
> @@ -1786,18 +1728,13 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>  	ssize_t size = 0;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>  
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return size;
>  }
> @@ -1824,14 +1761,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>  	ssize_t size = 0;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(ddev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>  	if (size <= 0)
> @@ -1843,7 +1775,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>  	memcpy(buf, gpu_metrics, size);
>  
>  out:
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return size;
>  }
> @@ -1939,19 +1871,14 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>  	int r = 0;
>  	int bias = 0;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	r = pm_runtime_resume_and_get(ddev->dev);
> -	if (r < 0)
> -		return r;
> -
>  	r = kstrtoint(buf, 10, &bias);
>  	if (r)
>  		goto out;
>  
> +	r = amdgpu_pm_get_access(adev);
> +	if (r < 0)
> +		return r;
> +
>  	if (bias > AMDGPU_SMARTSHIFT_MAX_BIAS)
>  		bias = AMDGPU_SMARTSHIFT_MAX_BIAS;
>  	else if (bias < AMDGPU_SMARTSHIFT_MIN_BIAS)
> @@ -1963,8 +1890,8 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>  	/* TODO: update bias level with SMU message */
>  
>  out:
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
> +
>  	return r;
>  }
>  
> @@ -2218,14 +2145,14 @@ static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,
>  	struct drm_device *ddev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(ddev);
>  	struct amdgpu_pm_policy_attr *policy_attr;
> +	int r;
>  
>  	policy_attr =
>  		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> +	r = amdgpu_pm_dev_state_check(adev);
> +	if (r)
> +		return r;
>  
>  	return amdgpu_dpm_get_pm_policy_info(adev, policy_attr->id, buf);
>  }
> @@ -2243,11 +2170,6 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
>  	char *tmp, *param;
>  	long val;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	count = min(count, sizeof(tmp_buf));
>  	memcpy(tmp_buf, buf, count);
>  	tmp_buf[count - 1] = '\0';
> @@ -2273,14 +2195,13 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
>  	policy_attr =
>  		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
>  
> -	ret = pm_runtime_resume_and_get(ddev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = amdgpu_dpm_set_pm_policy(adev, policy_attr->id, val);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
> -	pm_runtime_put_autosuspend(ddev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (ret)
>  		return ret;
> @@ -2704,18 +2625,13 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>  	u32 pwm_mode = 0;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(adev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>  
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (ret)
>  		return -EINVAL;
> @@ -2733,11 +2649,6 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>  	u32 pwm_mode;
>  	int value;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	err = kstrtoint(buf, 10, &value);
>  	if (err)
>  		return err;
> @@ -2751,14 +2662,13 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>  	else
>  		return -EINVAL;
>  
> -	ret = pm_runtime_resume_and_get(adev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (ret)
>  		return -EINVAL;
> @@ -2789,16 +2699,11 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>  	u32 value;
>  	u32 pwm_mode;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	err = kstrtou32(buf, 10, &value);
>  	if (err)
>  		return err;
>  
> -	err = pm_runtime_resume_and_get(adev->dev);
> +	err = amdgpu_pm_get_access(adev);
>  	if (err < 0)
>  		return err;
>  
> @@ -2815,8 +2720,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>  	err = amdgpu_dpm_set_fan_speed_pwm(adev, value);
>  
>  out:
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (err)
>  		return err;
> @@ -2832,18 +2736,13 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>  	int err;
>  	u32 speed = 0;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	err = pm_runtime_get_if_active(adev->dev);
> -	if (err <= 0)
> -		return err ?: -EPERM;
> +	err = amdgpu_pm_get_access_if_active(adev);
> +	if (err)
> +		return err;
>  
>  	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>  
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (err)
>  		return err;
> @@ -2859,18 +2758,13 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>  	int err;
>  	u32 speed = 0;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	err = pm_runtime_get_if_active(adev->dev);
> -	if (err <= 0)
> -		return err ?: -EPERM;
> +	err = amdgpu_pm_get_access_if_active(adev);
> +	if (err)
> +		return err;
>  
>  	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>  
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (err)
>  		return err;
> @@ -2920,18 +2814,13 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>  	int err;
>  	u32 rpm = 0;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	err = pm_runtime_get_if_active(adev->dev);
> -	if (err <= 0)
> -		return err ?: -EPERM;
> +	err = amdgpu_pm_get_access_if_active(adev);
> +	if (err)
> +		return err;
>  
>  	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>  
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (err)
>  		return err;
> @@ -2948,16 +2837,11 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>  	u32 value;
>  	u32 pwm_mode;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	err = kstrtou32(buf, 10, &value);
>  	if (err)
>  		return err;
>  
> -	err = pm_runtime_resume_and_get(adev->dev);
> +	err = amdgpu_pm_get_access(adev);
>  	if (err < 0)
>  		return err;
>  
> @@ -2973,8 +2857,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>  	err = amdgpu_dpm_set_fan_speed_rpm(adev, value);
>  
>  out:
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (err)
>  		return err;
> @@ -2990,18 +2873,13 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>  	u32 pwm_mode = 0;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(adev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>  
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (ret)
>  		return -EINVAL;
> @@ -3019,11 +2897,6 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>  	int value;
>  	u32 pwm_mode;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	err = kstrtoint(buf, 10, &value);
>  	if (err)
>  		return err;
> @@ -3035,14 +2908,13 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>  	else
>  		return -EINVAL;
>  
> -	err = pm_runtime_resume_and_get(adev->dev);
> +	err = amdgpu_pm_get_access(adev);
>  	if (err < 0)
>  		return err;
>  
>  	err = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (err)
>  		return -EINVAL;
> @@ -3157,14 +3029,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>  	ssize_t size;
>  	int r;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	r = pm_runtime_get_if_active(adev->dev);
> -	if (r <= 0)
> -		return r ?: -EPERM;
> +	r = amdgpu_pm_get_access_if_active(adev);
> +	if (r)
> +		return r;
>  
>  	r = amdgpu_dpm_get_power_limit(adev, &limit,
>  				      pp_limit_level, power_type);
> @@ -3174,7 +3041,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>  	else
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return size;
>  }
> @@ -3235,11 +3102,6 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>  	int err;
>  	u32 value;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> @@ -3250,14 +3112,13 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>  	value = value / 1000000; /* convert to Watt */
>  	value |= limit_type << 24;
>  
> -	err = pm_runtime_resume_and_get(adev->dev);
> +	err = amdgpu_pm_get_access(adev);
>  	if (err < 0)
>  		return err;
>  
>  	err = amdgpu_dpm_set_power_limit(adev, value);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	if (err)
>  		return err;
> @@ -3695,20 +3556,15 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>  	int size = 0;
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	ret = pm_runtime_get_if_active(adev->dev);
> -	if (ret <= 0)
> -		return ret ?: -EPERM;
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
>  
>  	size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
>  	if (size == 0)
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_put_autosuspend(adev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return size;
>  }
> @@ -3776,11 +3632,6 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
>  	long parameter[64];
>  	int ret;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
>  	ret = parse_input_od_command_lines(in_buf,
>  					   count,
>  					   &cmd_type,
> @@ -3789,7 +3640,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
>  	if (ret)
>  		return ret;
>  
> -	ret = pm_runtime_resume_and_get(adev->dev);
> +	ret = amdgpu_pm_get_access(adev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -3808,14 +3659,12 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
>  			goto err_out;
>  	}
>  
> -	pm_runtime_mark_last_busy(adev->dev);
> -	pm_runtime_put_autosuspend(adev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return count;
>  
>  err_out:
> -	pm_runtime_mark_last_busy(adev->dev);
> -	pm_runtime_put_autosuspend(adev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return ret;
>  }
> @@ -4785,16 +4634,10 @@ static void amdgpu_parse_cg_state(struct seq_file *m, u64 flags)
>  static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
> -	struct drm_device *dev = adev_to_drm(adev);
>  	u64 flags = 0;
>  	int r;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> -
> -	r = pm_runtime_resume_and_get(dev->dev);
> +	r = amdgpu_pm_get_access(adev);
>  	if (r < 0)
>  		return r;
>  
> @@ -4811,7 +4654,7 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>  	seq_printf(m, "\n");
>  
>  out:
> -	pm_runtime_put_autosuspend(dev->dev);
> +	amdgpu_pm_put_access(adev);
>  
>  	return r;
>  }
> @@ -4831,10 +4674,9 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
>  	void *smu_prv_buf;
>  	int ret = 0;
>  
> -	if (amdgpu_in_reset(adev))
> -		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
> +	ret = amdgpu_pm_dev_state_check(adev);
> +	if (ret)
> +		return ret;
>  
>  	ret = amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, &smu_prv_buf_size);
>  	if (ret)

