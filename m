Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5431FC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 16:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070A610E838;
	Wed, 29 Jan 2025 16:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RHS1333s";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1011410E83F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 16:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQUW7L0UliS8ljcYpu2iS679sawqaubz1onxx7epLOnUHh6GUuYNjqcB2YLFOJLSXix+27MPlYBe0G0w4F0T0LiDDOaR6BhFU9j36L98kvR04G3gQtxh7UNgVG981P/LSgtQq2giW5l1lU0k9R0wjjuGXaN+2toF0qPilxjF5x9eN0NYLDulKnwCW24bWn6VueRyP45A5OlUmJJhOxCgJNNSZjsXtBxI55ZK3G9bIJH32G8VIwhwrRVX27d79z59h/yhUT4ydhGigncGRzQ+CjTH/6+Uzn1ghhmBq89HFILNZrRafeDxXATmsIp2HidS5dIenipAcEjH1x9V/7b/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIMSlzQsLkd7DkC1wad8siEUh3pXwdaF3SLPW90wIos=;
 b=GTHGZq49eFLBWSbxyrtWwSZdYfQC9Jk9FF0TPof7h4J4p7iT77veTkvnuwWCmS52dVKGlFY+TWKQHVcpoh530J/xcciaO62QOPKnxFSuvj3PxkSWX7pngF+8BRceEEFWKsxFupATDTPkcT+N2PLbLdwdL4N5BZRuC+G98hv2dvO/P2wrkMLi2nmsmAg9Hp4wnmfSrdrZM+SzDkuIbVNFCm44yNc5xBaP0jTU5hwTUzpMH5JaEci56Mc26Xx6HAOzL5nHwUCVYMmhG3lW8fBC/GJCclGLw8F6tIvs5dZ0S0gGk7AEcNkw05mt7TY1Mhqo1LMxfHdgNGNizpdGDA5ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIMSlzQsLkd7DkC1wad8siEUh3pXwdaF3SLPW90wIos=;
 b=RHS1333sbhXksRHY/IHI11zpemCZ0bZupsk7fpSXTfJ3W8qeBr5JUN1AUA0e3ZOmg7wG5cFPKTN1yBVONTE5Mlt5VHDnto4l/jRizEaZIMKmeZJrfT90Ln15zWSosa5yu245NlkdAGgJddbZuvBYof+UazO+Ok2FeVI6W4TF570=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Wed, 29 Jan 2025 16:36:27 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 16:36:27 +0000
Message-ID: <420b603c-be80-413e-a069-b1edf3f2a04e@amd.com>
Date: Wed, 29 Jan 2025 11:36:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] drm/amdgpu: Enable devcoredump for JPEG2_5_0
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Lazar Lijo <Lijo.Lazar@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
 <20250129084643.507727-10-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <20250129084643.507727-10-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::28) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d16d9f-f892-4914-f109-08dd4083136f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGFtSWd4cnVOKzVDaVRmaVp3bDJLM3NtRnRDNVNQd3NLcVhyOTNGelRKcnRQ?=
 =?utf-8?B?emNrRVRYZk5iSStiZnI1bThwckJaM0kxSDJHbFI3OG9VaU5tVWxyM3dYUTVL?=
 =?utf-8?B?MGIxdmhpcnJaM1ZKN1dibmlFSTN3RjRqdTZ6aGpMdWQ2eTZQdmFYbXpIV3JP?=
 =?utf-8?B?VGJMNlVDS1dlUFoxTngyNkZXcy9jV3c0YTRONVBXYzR2emlUZUFWQjhZaTE5?=
 =?utf-8?B?ckxuU00zS205R2lXbjRvVWY3UHBTQVpNMlg4QzRNb3FUL0RPSFVCVi9GU1Ji?=
 =?utf-8?B?ZU95WVVmemNyUlhRVThzcHhOclFNZE1NaHVnQ05zQ3hEVUxoSk04TjN2R1RN?=
 =?utf-8?B?WG1VdHlFRThhWHZjcmpvUVBEZEpDdjFSZjkrbCtDUHF6c1BYQmF6cUI4bnNR?=
 =?utf-8?B?WU9wcEdjd0Zqam53SzdOKzgrOU1kYmpobG84Ym1OTU55c0VhSURvU25iS3pE?=
 =?utf-8?B?Q2d4QU9yd2FBb3pZSTNWeHBXaTNkUzVmOUk0UkEzMmwxbks2ZXhTTGxFakk5?=
 =?utf-8?B?VDNyQTgxUFh2Skg5SDgvNDZySS85MEVyaERkQVZUOEQzaE1ZL2J1Rm8yUnFF?=
 =?utf-8?B?aXQvbWJyVkdwNzVOZ01BWUZMdDl4OVZPRXk4elY3ZGt0Z2h6QkV2L3g0eXdk?=
 =?utf-8?B?bE4vaGQrVSs3dmtuanVFemo4SUY1SnE1RWxOcHFxREF3Q0syY3hyNkIrdlNk?=
 =?utf-8?B?aVVlWDJCb3p5b2luS1lad2d0bmhLVzYrb0graUthVTFRLzBaSDFoTXFKZTdR?=
 =?utf-8?B?M0lHODByUEt6d3UyWjlOZHpXSC9OeVpJNzc3T0RFeEVhRFo0QU9ITUQyb0o4?=
 =?utf-8?B?bXVpWnZiQlhPTnoxaTgybXNuQ2grWHh0aXZMNVRSMzJ6U2psdmg2MERZQkJa?=
 =?utf-8?B?V0pod0JaZGVuQitGc0pTS3VnLzlPNnh1SmxQcVB0NitaM29zdWpCQXVxajh2?=
 =?utf-8?B?a1lNNThwSkNqQ3U0bzRxNXdrcmIvZGc1UUhiaTRCUk9UVktNRUxaaGo0dzRN?=
 =?utf-8?B?SHVyK1VzYkEvdW55S2doSG4yamN6VTlSK1N5WGd4VGNqNDNJMkxjNkhMK2V0?=
 =?utf-8?B?cWtqdEZFSmJwWHhiWklmL1ZjSzRGeDIySU44d25WMG9ackRSRGJOSE5jYWxV?=
 =?utf-8?B?VFNFdU9pNGtmV0gyU1lKb0g3QzBFVUNKbWZQOC8zNjlia0hMTTMrSDduWno0?=
 =?utf-8?B?MlA1Y2N4NFlFbGpuenpSNnJQRzVYcXMvSDBZcTh3anpRdTZnSUVyNGZlOGpU?=
 =?utf-8?B?UXJabytqS0doOXlmTlpwcGlLQWExeHJQOFRXQXl4U0hLQnN6bFdmZlErNUFN?=
 =?utf-8?B?eU9XNmhOQlFqemJWdU5ldy9PTERhdUU1b05RUEdMemFOZnhsamNIYTgySXBz?=
 =?utf-8?B?Z0d3bVptZTVFLzNwMWtDU0lubE96UEkvUHRuY016T1BuN1QxZGRIQnFtRUpX?=
 =?utf-8?B?OWltS1JKS29xd3VtYXoybUhpNHFqUnFETWc0UFFwaDRFaEdQcGxsWjNUUFAv?=
 =?utf-8?B?cFFJU2diNHUvOEVzSEhYRGRHM21ldHI0RFpYTWFiTDhZZFpBdlcrN1lxRzlu?=
 =?utf-8?B?b1Y0YUd0a2hrMHdjVURKRlZKUXJCTzUzMGJCNkE2U0ZZSWpicXh2VTYyUk5X?=
 =?utf-8?B?U3lzS0FRRmxlTHozZUYvdTZCbVVjLzFER3RzbUdPUXlIT203SUVjeVVDUFQ3?=
 =?utf-8?B?U1J6ckZlOExUWlZ6OS9Uck5DZFIxWVB5b0dLcDY3RnZFOHY0UWtVNkxaTUEw?=
 =?utf-8?B?QWMyTldRakV0L2ZiM3FJVjFZMVdJQm1JaUVTWUhPdXl2NklIVVl0Y3NVb21q?=
 =?utf-8?B?Zld6emljUDYyUHVUaGZ1YkxnOGV1MHVLbmcweDVmUzRXYTBtWC9QbE1oUUR5?=
 =?utf-8?Q?JDOHlWve4XBMm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ovL2E3d2x5K3ZSTEZRVmxxU2U1dGVnSEl1L1Q2WjZ1dExSMjMvOFZ4c3pU?=
 =?utf-8?B?MWMrSkxVdVBMaCs4V1E5bkN6V0E0ait2ZkdzZjJjMk5acmJqTUpvc3VsVkMy?=
 =?utf-8?B?YUFZQkg5cXBMNEp6M3dTN1d6MlhRQ1hsM3BlYTg5YkNPeVB2YUNrdjFmWWpF?=
 =?utf-8?B?Z1NGMXBRbzlOUXRlUmcvU0wxcU5NK0RNeURNemwrakxaUGVLaGx0UDZFK3lw?=
 =?utf-8?B?SGMzMVdhdzVTZEc0RmxTQjlHK2lKMXFyNWdVQmJzQmdubmlxdWl0QXdaRHJV?=
 =?utf-8?B?Z3dpYjc2b1p6WGFmWUNxWXdnQWZTeTNuaVNWK3JGMFYvRmFFRWJ2c0R2MmNk?=
 =?utf-8?B?Smdvb2E0ZnNsL05hRm5kTkdJQ2ZWWUVWdDlTd29KanBLL04rRW5zcEh1NWcr?=
 =?utf-8?B?Z1U0eEZrV3BnYU5KUm5ZbVJCdENKV3k3ZVNCdWV1WlF6NVd1Ym5NM0NGOU9k?=
 =?utf-8?B?ZnpVWEV4M1hUZU53NC9veERtdXU1aUsrN2FadVNwS2Q2ckV0ZHRCKzhNV2NN?=
 =?utf-8?B?N1pZY1hwMlhKemMwblE5WExHS29uR0NsNG8wUzhYNDFjbmQ3enJXbjBsemcx?=
 =?utf-8?B?b1lMNmJHWGJlbVY3cGprMStieXJGbzJZVEdhZHM0UWt4eDVWZ2pMRDJLMW5L?=
 =?utf-8?B?TW1nUlVuZWlMTmJUWmIxWHE4M2k4ZVFON2crUHBMSUtISDZUbmIwbTBZbnJF?=
 =?utf-8?B?dnQrbHlWWDdrTXNkdldjWFhxVU5qQ2JBUDVSNzZ6b3RnbnpBRnpYNms3SWtI?=
 =?utf-8?B?Mk5YbkozWmpqRUFVd0NLMXRMY3dXOGs0bUJ0KzhXRHlycU9EbnBGbEppNjRs?=
 =?utf-8?B?Tm00cWY2Q2ZHZkdIZjF3VWY3MVh6MVkycE4rSG1nM3dPeXo1RnNxZldDWUJ4?=
 =?utf-8?B?V1J2bWxpNGhleHI1SnZSYm9RRTIwSVJQK2U5VUtTWUxkTUlpSkVNbm9xMjdI?=
 =?utf-8?B?MitXNWZIckdENktkSTZiNElINktKdGl3Kys3MWVISGtaVWU2M0wxc1h1cGVY?=
 =?utf-8?B?d0gxRGs5aFFMSFZKOENKUWxIYjdIUEVlRkh3dnJRQUs3ZE5TL0xtaWRpSERz?=
 =?utf-8?B?U2YzUGh2Q1p4bFVseHc5c3hNeXIwTXpOa3lRQy9Yb2UzUlMraGJEUHdYRU8z?=
 =?utf-8?B?Q3A4RGFsMFN1N0s5dnkxZFpoNDQzTmFSY244MmlqbGh5NjlIeGlYaXdlY2gy?=
 =?utf-8?B?MVhNbGxWckxjeGtnYVNYZmhpT0srZWpLUitXN0h5bmVBTUtUeENzWTJCMlox?=
 =?utf-8?B?aFdNVzJoREhmYWxvK0t5RXhuTlRVRHg1MVFFekJMV0hCZis4TnVDeEY5cnd3?=
 =?utf-8?B?ZHUvUFpZcGZDUXU3M1cxNXVYNGxyTHpFd2gyQk9RYmsvWVdnR25IVTBRdmM5?=
 =?utf-8?B?bFNZTzl6VVRTbjRlUXhBY1JjSDNLMHpjeTRXR1RvY3U3SEdCZ1dEcGlJMlhr?=
 =?utf-8?B?UXZkT3diUHpwNVlhMitwQmkrLzZGRjA4Qms3cHVwMXBQYmMvVEdiRXRZUnU5?=
 =?utf-8?B?eUhzamtMQ1lySjVudzRIVmVPbVc0b3BUdTRDWnFnN0s5bHdIc294YkN5bC9G?=
 =?utf-8?B?NFJMLzFhM2dmSWh4YWh6U09tZFd4Z0J0ZDk1UENOdkhlWFlLRU82TzZXWm1L?=
 =?utf-8?B?ZGc2Yzl5S3piOHFFSW5nMGl2c2JWRjVmYjllbGtBRmZ4THBpV2ZDWUJtTVEx?=
 =?utf-8?B?dnBhb1pFc2doTlNJOGFJb1ZucFcvTGhLaitQbGpUdzZ3d3NJWjNhT044VnQy?=
 =?utf-8?B?aWZsUGFzakp1V3VOb2x1dng2cUZVaEVEbVlYOE4vUXR4RXRpSW94ZDcyVFRV?=
 =?utf-8?B?dkxqQ0RtNnUwd1RWclpvWldBV2tiQWExWkc3VE5MLzIyUjdtNitCU20xT3Y5?=
 =?utf-8?B?SHcrSVlqaDM3T2daTGpFd1hlSElhUmlaVzh2WXJXam9qb3F5K2MyWkdzV3Mw?=
 =?utf-8?B?Q2VjUzgrb1V1N2Q3R2N3MGpjejl3YURYcFc1UENwYzFIcEs1M3htenVhZ1hO?=
 =?utf-8?B?bXZyQlhWMnZXdVhKbldsWENMZHNlbXc5ekVRYmRLVkthV3hXaWJ5RnRpbFc4?=
 =?utf-8?B?bDEzWFZ4ODFpQlptajlqc3ovZCtTVGZnMFRYbFNNYndCcEYwb0xxeG5mZnRM?=
 =?utf-8?Q?bJNs16IsgOOBgeg+aVokZwo94?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d16d9f-f892-4914-f109-08dd4083136f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:36:27.0094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adCMzTjqZzE7PJDhYRbYqAmFJrwmo6t4acuV+0eYrNSf6Hlyr83WRRlI/A8nQVNC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150
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

Looks pretty good to me. One question that why this is not added to JPEG 
5_0_0? Since the patch 3-9 cover the rest of versions, they are:

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 1/29/25 03:46, Sathishkumar S wrote:
> Add register list and enable devcoredump for JPEG2_5_0
>
> V2: (Lijo)
> - remove version specific callbacks and use simplified helper functions
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 11f6af2646e7..536a6101dcf9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -36,6 +36,22 @@
>   
>   #define JPEG25_MAX_HW_INSTANCES_ARCTURUS			2
>   
> +static const struct amdgpu_hwip_reg_entry jpeg_reg_list_2_5[] = {
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_INT_STAT),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_CNTL),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_SIZE),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_STATUS),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_ADDR_MODE),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_Y_GFX10_TILING_SURFACE),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_UV_GFX10_TILING_SURFACE),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_PITCH),
> +	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_UV_PITCH),
> +};
> +
>   static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev);
>   static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> @@ -147,6 +163,10 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_2_5, ARRAY_SIZE(jpeg_reg_list_2_5));
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -168,6 +188,8 @@ static int jpeg_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	r = amdgpu_jpeg_sw_fini(adev);
>   
> +	amdgpu_jpeg_reg_dump_fini(adev);
> +
>   	return r;
>   }
>   
> @@ -623,6 +645,8 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
>   	.wait_for_idle = jpeg_v2_5_wait_for_idle,
>   	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
>   	.set_powergating_state = jpeg_v2_5_set_powergating_state,
> +	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
> +	.print_ip_state = amdgpu_jpeg_print_ip_state,
>   };
>   
>   static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
> @@ -638,6 +662,8 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
>   	.wait_for_idle = jpeg_v2_5_wait_for_idle,
>   	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
>   	.set_powergating_state = jpeg_v2_5_set_powergating_state,
> +	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
> +	.print_ip_state = amdgpu_jpeg_print_ip_state,
>   };
>   
>   static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
