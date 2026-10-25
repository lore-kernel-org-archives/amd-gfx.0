Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F9606A31A
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Oct 2026 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dayYgshV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920A110E240;
	Sun, 25 Oct 2026 18:22:16 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 021FA10E240
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 18:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMpLzThRbgTl+V6tMgjhFKXgVXFZJwW6mdEMiHsBjKxAvtlhjTDe97V7kl5uDbTI9gCTsi2p88qC7hWJzGOrritrO6kz2f1XhVcMRZmGklA5S1Qnx2fqO41pHyTqNQD1oCsK7W4ri75LpdrpTb0VrZJhTcxdXULz6mc4vqLh0zCy21m5nzJRlrpbe4cGd/5EtsQD+9dE5tARCOMOM6Fil06auFr+sw6Zs2IIMGqIJRfn6CuHSLqq8C0M83VkE1NvdlUtgVpW45K9LD17J7VNZhh/R3BxcFrP4D/064FzQaZ/83SKs6rBp74kJyDy8fX0aV1WDWy5BUeJT9Civ6ubhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuEPOkKCeDoMgwAlMq00/guMJUs3rm8it9LDbJHV4bQ=;
 b=OCChhUejBn90kVMMbFqf1GIrUXJenmQU6A6bzrnj0pb3oCoSdRU3f93bU1Z+qfcodtQiYWg2Crp/VzIkVhOejjLI9sRl7ZUKRuPXoxswEqdmuufDCDsk6sUFXVdZSZB+hxsvvrv6s5h43NcKHp/neBFsOiIvtxiti43JO3HcH7JgStzDS74oayI/8fjkzBQXmCGEGR5r3h6sRhamlum7y9tlE/HDSEvs5zO5yPRjyA4/+Pdj1ZxdNLWuNiNq+FqfJpd8cuGqTdeJvDlXheOkbx5BO5SpXN9i7NJxq5AEjD2K53TAgAKLf94gSeXC3NiBA3vvK0CZRJGefSuOVjpJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuEPOkKCeDoMgwAlMq00/guMJUs3rm8it9LDbJHV4bQ=;
 b=dayYgshVMos+tk+UTW/to1vRYjANkDYVk0Q6FDCzHGegRjuIGHRdKkd69sYEYn5lKA07IbtSS0E/cJT0ZP4Wzm/0zjOz/9aB85suh/bx3PncUEIAaBaQkd5kUmIGwCbGXnwjSQ54mXLZEiVQCNaODMdGNr0QhlDZqcDSLumbHKA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4SPRMB0031.namprd12.prod.outlook.com (2603:10b6:8:349::17) by
 LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 18:22:07 +0000
Received: from DS4SPRMB0031.namprd12.prod.outlook.com
 ([fe80::5a9e:89da:d693:13a3]) by DS4SPRMB0031.namprd12.prod.outlook.com
 ([fe80::5a9e:89da:d693:13a3%7]) with mapi id 15.21.0546.012; Sun, 25 Oct 2026
 18:22:07 +0000
Message-ID: <54fd40c6-f13f-45ed-ba55-ca38052cc3ad@amd.com>
Date: Sun, 25 Oct 2026 19:22:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vce1: Fix checking whether VCE1 is idle
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20261006170352.26722-1-timur.kristof@gmail.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <20261006170352.26722-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0094.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::22) To DS4SPRMB0031.namprd12.prod.outlook.com
 (2603:10b6:8:349::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4SPRMB0031:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f26373f-cae0-4edb-fdee-08df32c4e085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261009223027099003|261022105027099003|261021121427099003|261021123027099003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: L5R3QVPbF/rrAJ1iLScJyeYvrZjXZfTxHBaA5zQDWm6OQCL7nZnkYiD1d9yy9IeA9tLDhS3SvLeXFM/a4HKO1VqRqKvnIDgOyuA7TKTUdUS1Q5ykyGRm3msJ2WE79vfZFaMLtyKk83H/+k2h/ohnf698roJIK3VK7JiSMfs2duLGPwSgq12mPY8+4rb9W/F3RoMUeUQ8VHNdwSGUfK1ZwmfHUOjeghKgjkiRxFGxTltEYFprc4Zzy1V8e3RoIXG8iwUKP8oCvYyvHvvcQzym5Yi2rbGFLhTO7v++Ca8N1qj4oT84Q2UhFUYrW1VwSGIuaDw8IoCCUCtlBs6Z6JLwB9Z6nwoFAZw7eRLuENwh7oqrCXFas2rvYsCgbrxBDpsWF2tNbB6ozkYpvsF/iDjl/NzN4jD9umDCjTWd0s4YG6tAmbmoqG56WrcEQdDhG05yV7wUWR7tJ41b6UHKDBFBcX6y/hd4zTDAvweOVY0xuI+XoRuy0StjugyDr7lJnU7s5hrehuah2nj+7JsEqcyVsOSUkxt5K6qod/Y12Xl7S5pxadqLo0oCUr41yl1MOWTVNScAW3dF86R7q4yDTRkpX5W/HoQqX/pX+sLdi0Q02ccJa0ZrhkF1biEdcimxotQjoMNUdRS/6pdlEost/2eP4BTMzvNMOR8WRfE3KkEIGY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4SPRMB0031.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpBWG1GUzNYK0t3dmVlcnBRdjFwRnhVRWdRZEtGSzdsaHNTRmdqcjg2UURV?=
 =?utf-8?B?K1d1S0xnaHRtU1FsbDcrWFVYbjJNQzZOOXFCNTNUYjM3NzZTOFN0UWpuWVA2?=
 =?utf-8?B?SVlDTUpVY1RMTHowYzFmcStiMjUvTlJpaHB5RVN3aGttcERNcmxaL1pRZytq?=
 =?utf-8?B?R0xDd3l5T0JjUkVWN3QyMm1uU1dtRVkwRlNhNDNpUklDVEJ3UmlDWGl6OEwy?=
 =?utf-8?B?am5QOHdBRFI1czZUS3VNcStUWHIydjhjdWJoT1d1Z3RaeTdqNGpveHpzS1ll?=
 =?utf-8?B?U3FMaktYaElDMWNQMEFUWmYwOWw1Z3lnZGdwUWdQanY5WUQxcDhzSyt5UVpM?=
 =?utf-8?B?Qm00K0xoODRLYUJKUmQvYWM0bXptMkZZekwrOFhlZ29aMk01eEJVU2VJTlZB?=
 =?utf-8?B?RTE3T3c0V1JuNmw1QnQycis4RlVXaDFSVW1ITUNrZ0xyNDBnQWpvNlE1WHgz?=
 =?utf-8?B?KzBLaHBSdElsUnBLbExhT1E2N1J3R3BaZlVQeG5jUWpORXM1MjM1NW5RMmlE?=
 =?utf-8?B?RHVtcDRwUUtOaHpLSXd4MHNDZVhIclJVdGwwUmpMYXZiVnlEbE9uTTlaU2NP?=
 =?utf-8?B?K3V6ZEk2NVMzMHlVWkwwVHJ5d2xNRjVqV3oyZ2ZJQTVhOUpqNlAyNHJyNjlQ?=
 =?utf-8?B?ZC9sOUxJQ24wbS8wOFZsUHAxeklzOXNVNXBNZXQ3TmhsSTcrS3hpTVRTWDlo?=
 =?utf-8?B?VVM2TFRrVFRpU0RGL0RWNVlKdkd6OFpjcmZIZFdZcFdjUEVTVk0rRHIxem45?=
 =?utf-8?B?V0hMMnVPUVoxZVNXTDlBcVlYTGxVTHcxZzgyVjBhRjFXTmFTbjY2UFJiUlJt?=
 =?utf-8?B?Q3crZUkwYTA1c1FEeHIyT1JRRkNkeVZiVzJ2cG5VZHpLZk8vN2Y3eDNYZXJj?=
 =?utf-8?B?WlRnaFdZRHNyaXJkbnEyakpQMUtvOE9ZU0NyazVFS0hvbFJVUlFONWZUZFJ0?=
 =?utf-8?B?T2VQeFBtTHhpVHZta3FGU3IxTzV0NnQydHZkaFNncWVTaWRjcHNSbjA1YnND?=
 =?utf-8?B?MHhmS2dGR2EvS29KQkExOEIxQXNrWGlCc3ZVT0M5MGJsK2NoVUFPbEtpb0NO?=
 =?utf-8?B?QjdRTS90R1VsWGc3UGc0RkdGM0hwVENzVGVWN2dnNGdVeWpaU1ZLNm82V2wv?=
 =?utf-8?B?ODdZbmdrZUdsbVBxd0lPbUtZQ1luMnpCQXVrYmx4YVkvN1E1UEVTSHBSRkV3?=
 =?utf-8?B?UEdYSlN2UVRldW93OHduL3BYd3hJdTZDWExwMUxtb2lhei8wMHR2S0dhZ1Rt?=
 =?utf-8?B?UVhjZ25XSURhWFEzc2k1WGU1alU0RWptMVh4TzcrWVZTNjZNNEZCMWJ3bUxi?=
 =?utf-8?B?bDh3dXFvNERTL2ZpSlk3OWJNWGhyWGNqa2w0Ym9TTVJpV0JWcktjaVB3ZTBW?=
 =?utf-8?B?cGc3TDUycmwxcnVzM2s3RllPbkRPSWFCaFdudW1KZGJQVHY0RXFDbUlURTlT?=
 =?utf-8?B?akVrdjJ4aUY5L1RYYkJwTVBUSzFEbDNHNmluaGNZc25lVGFsVDJ2QUc2ck05?=
 =?utf-8?B?Vm1pTmMxZWZ4ejBmdGxtZHR1RGh4RG8zMEtWWmJZdzh3NGxjQW5wQzJMNk5I?=
 =?utf-8?B?NWJnODVPOW85TjNyS2l5Z1dnY1BkTStxelBCYXZJRmpwWW1vVGdBVldhOG1v?=
 =?utf-8?B?MFNnVGNITXlwZFhxaXJVN1BSUkZrUHNiMmtOZ2dJejEzdGJSQ3I5emJxaWFx?=
 =?utf-8?B?a09kL2ovQi9xLzJxWTBYZzZ1VkNmQ0tiNUU5ZE02K2tYLzBiL1lUeThNTk0w?=
 =?utf-8?B?b2ZGekFvM1BybVlvT1hBR0gySm4zK0ErOWVQVUZrVG84bHdRckJZSkpwS0Vn?=
 =?utf-8?B?d2o5aGsyenl2SHArY2V4dVNLWllkNHlOTGpobE9lTUhBS2ZYZWVMQWIwTzZm?=
 =?utf-8?B?MW1BNGx1VFFpWnkrd3dFaTVrWklwWWl1TGdFaCtGczRHZEVla2QwK0N2LzEv?=
 =?utf-8?B?N2p3QkFPZmhaTVBVVnNESFdFQ3UwYkRNWUZ2YUVvQTMzb1ZTTXdPY2NESVhN?=
 =?utf-8?B?dG1RMzc1T3hSd1ordVNMbW1MN0gxTjZKYlFPMHpDcS9lUkRkVjB2eHhRUlZC?=
 =?utf-8?B?TDdOazhEUDlCSlNXZkhKT3hLZ3BUalp4ZW15SGhkTWNHelpTR2dEUG95OUhL?=
 =?utf-8?B?QVpDbGNZdkVkZCszOW5hbzY4L3cwQUZyYW0vOTdrcTdyYVQ0N21kM2lFeGY0?=
 =?utf-8?B?Yk1BVGFHVXNGdGxycFNDdEhmOGZ2RTk3RDJUYng5ZU5BODJocElsQURLb1ly?=
 =?utf-8?B?MHMwK3dQR21MUVJMUDI1d1lBQklnQ2lEVThOaE1MTzJaQnB5RU5obUJLbmgx?=
 =?utf-8?B?MzkrTUlYaW5LUFdDTWpiSlJic2tSQ01XdC9nNDRPeXJuVzQ2NlZxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f26373f-cae0-4edb-fdee-08df32c4e085
X-MS-Exchange-CrossTenant-AuthSource: DS4SPRMB0031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:22:07.2683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f22rwggAnpHsu1Y1MTYzI8jJv7r9yTsjRFsHPpgBmgVStbTdUG9Hp2Gd1WY1iioDcHIvDb5rlyq6hpyvG3VVXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/6/26 19:03, Timur Kristóf wrote:
> It turns out that the VCE_STATUS register bits that we
> used to check whether VCE1 is idle are actually not useful:
> VCE_STATUS.JOB_BUSY doesn't exist until VCE3
> VCE_STATUS.UENC_BUSY seems to be stuck high on Cape Verde
>
> Instead, do the following:
> Check that the read and write pointer matches for each ring.
> Check VCE_STATUS.VCPU_REPORT bits to check busy status.
> Finally, also check SRBM_STATUS2.VCE_BUSY just in case,
> although this one seems bogus on VCE1.
>
> Fixes: d4a640d4b9f3 ("drm/amdgpu/vce1: Implement VCE1 IP block (v2)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

There's still occasional warning that VCE is not idle on my cape verde, 
but it's much better than the current state where it prints it every time.

Acked-by: David Rosca <david.rosca@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         | 25 ++++++++++++++-----
>   .../include/asic_reg/vce/vce_1_0_sh_mask.h    |  2 --
>   2 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index b1428f5bbc81..38e21d1a3ebb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -47,6 +47,9 @@
>   #define VCE_V1_0_STACK_SIZE	(64 * 1024)
>   #define VCE_V1_0_DATA_SIZE	(ALIGN(7808 * (AMDGPU_MAX_VCE_HANDLES + 1), VCE_V1_0_ALIGNMENT))
>   #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
> +#define VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK   0x08
> +#define VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK    0x10
> +#define VCE_STATUS_VCPU_REPORT_RB1_BUSY_MASK    0x20
>   
>   static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
>   static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
> @@ -349,19 +352,29 @@ static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
>    *
>    * @ip_block: amdgpu_ip_block pointer
>    *
> - * Check whether VCE is busy according to VCE_STATUS.
> + * Check whether VCE is busy according to VCE_STATUS
> + * and whether the ring pointers match.
> + *
>    * Also check whether the SRBM thinks VCE is busy, although
> - * SRBM_STATUS.VCE_BUSY seems to be bogus because it
> + * SRBM_STATUS2.VCE_BUSY seems to be bogus because it
>    * appears to mirror the VCE_STATUS.VCPU_REPORT_FW_LOADED bit.
>    */
>   static bool vce_v1_0_is_idle(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	bool busy =
> -		(RREG32(mmVCE_STATUS) & (VCE_STATUS__JOB_BUSY_MASK | VCE_STATUS__UENC_BUSY_MASK)) ||
> -		(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
>   
> -	return !busy;
> +	/* Check whether the rings are busy. */
> +	if (RREG32(mmVCE_RB_RPTR) != RREG32(mmVCE_RB_WPTR) ||
> +	    RREG32(mmVCE_RB_RPTR2) != RREG32(mmVCE_RB_WPTR2))
> +		return false;
> +
> +	/* Check whether the VCPU is busy. */
> +	if (RREG32(mmVCE_STATUS) & (VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK |
> +				    VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK |
> +				    VCE_STATUS_VCPU_REPORT_RB1_BUSY_MASK))
> +		return false;
> +
> +	return !(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
>   }
>   
>   static int vce_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
> index 1f82d6f5abde..13c15c2138b3 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
> @@ -63,8 +63,6 @@
>   #define VCE_SOFT_RESET__ECPU_SOFT_RESET__SHIFT 0x00000000
>   #define VCE_SOFT_RESET__FME_SOFT_RESET_MASK 0x00000004L
>   #define VCE_SOFT_RESET__FME_SOFT_RESET__SHIFT 0x00000002
> -#define VCE_STATUS__JOB_BUSY_MASK 0x00000001L
> -#define VCE_STATUS__JOB_BUSY__SHIFT 0x00000000
>   #define VCE_STATUS__UENC_BUSY_MASK 0x00000100L
>   #define VCE_STATUS__UENC_BUSY__SHIFT 0x00000008
>   #define VCE_STATUS__VCPU_REPORT_MASK 0x000000feL
