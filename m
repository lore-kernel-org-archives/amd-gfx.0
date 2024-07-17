Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3982C3DA62
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C8610E3D4;
	Wed, 17 Jul 2024 19:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JuCIWLzY";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9143210E3D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMXSjNDAHECwB95iWafIHbNfseqniS9xf3qSEGlD2qufR8g7n9TKiNXyBYbe28DehonDBuuyqeB7B+ziOj5JsXWhyoh4vir9UOys87qUtx6U0ERiW8/71e1Asx4RYN9Np2ihvxjaPfQalusp3/7tZ4D7CmeSr0F14ulFELD+DbhfGWTIRzR0EQ4/7g07ICw5+3SpukMHHCNAFAicJTtEPpIskk0bSXIniym5GrCQ7UiLJIBzSZGyRDcqDnM8NbMqrwKlJFq3ViuCIwflgkpESNtLt8PLgEXI9T23k4FGP3rmKFaRvtMmxIOdEIPKWj0k45UuowoX2LM5TdJ+n58hUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8alhnuYaCwtbpNoUq7lbD8+L31KJvXkvzIwilfMEuyk=;
 b=R72ljRurtSNu0otAiXtbZBb5eom2JlitRBnxp6euxiH7AvdY3D/cT+eorU76cBtwKQtPijTt+Blrdpy/jr5FHIMMKRZgOtxov8ik0DlsNnJhh8Eg46D4uQNsi0/NUkGRkaazAlimmw302NXTjgj4UfZdlkEETafln748hTwmuHUIA8396URdjK6B12/JU4I+5rghJygQnsnCzYCosZP0g4ohFmgXbc5h7NbbinzyuGeWSomQbjz5SjC7iMVbgS7U2zGPtPL3uaXC+p2ZQlec0kISZt9PpU9sVbZAq3femZUj1a5oY7Jw46W5lq7em/FPPyFNlgCktdhu2nBA6oZsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8alhnuYaCwtbpNoUq7lbD8+L31KJvXkvzIwilfMEuyk=;
 b=JuCIWLzYfVx1mdCSOtDHz9P6sZyk7CcpzumFdEJgSfMLVLa+MoDUarVPNWPKiTAs13e2sDkWPM31LplxNc9uswOHNcILBx3YuAiIJZEqKSAAzl5whet/xc58Wwwc8FSVLOHRQlxKOZiVM9/NjJV/86Avu8MN3nDZ3KxaGlqjwfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 19:54:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 19:54:29 +0000
Message-ID: <1bead8a7-bc0e-4f1c-9b6c-bab16aa35a14@amd.com>
Date: Wed, 17 Jul 2024 15:54:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdkfd: amdkfd_free_gtt_mem clear the correct
 pointer
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240715123502.7013-1-Philip.Yang@amd.com>
 <20240715123502.7013-3-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240715123502.7013-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::45) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: a199f684-7e25-4458-95bf-08dca69a452e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjFqNFFJd0VPL0lzczdNVm8zZjF2V0ZjOUZ1MWxRa3RrWnJXOXlqV0FLQTZB?=
 =?utf-8?B?NExaUmtyYitaZWVlWEVyeGVKRlZMOWNMMTFwZzNZclFOWFE4SVEvN0I3Qi9E?=
 =?utf-8?B?UlpMQjVCdHVDZkNjZjk3Vkp4V3N5WU93WEZnOEZadUV4cS9IMmZpOFpJOEVp?=
 =?utf-8?B?b2Y5OE5pWnVRQm1JalZoajdVQytNcmI2bWFvaEdIUGl6eVRsdkl0a1ZQU2xP?=
 =?utf-8?B?a1dWb0M5Z3M3elZTbWx0WVJMZGFnd3BBaFZ5N2l2eUFHbmpqeEVvUVRZOGRh?=
 =?utf-8?B?d24wWXVjUU9NWUpNclhheGpLYWhtYkxZcTV5dVFYc3E1cVE2dXptSk15cHJq?=
 =?utf-8?B?RStTemtKdzJkem1xZHllNlpYbVR0M1VhRExmRXQ0a0hOekpWV3Y5Zm05Q1Bj?=
 =?utf-8?B?YW1YVExjUjdrSmxjNmxyNThuNDRpWmlZT0psNDk2Y1dVa2FwZW9yeXJaMXZE?=
 =?utf-8?B?TlV5RkxndUh1Wktvait4elpSdlBTR25iSmplL085RVMxUzhvdDB6bzB1RDdp?=
 =?utf-8?B?dUliVmMrTW5HdEdQRExTb0lRSzRaK0VGMGU4dGQyZnYzVWJrTHBkUGFmbE9U?=
 =?utf-8?B?WVhyTTdnclVCM3pUamlxSWNCYVJzWWFPTmhtVGlUZkdlY3Q3bEUxdmFZY25u?=
 =?utf-8?B?VENSUmo2Mi9Ocjc3SHRzN3ZUOTk1cmcvRmg5cVNKRnNzcG9wVXdvdC9heDh2?=
 =?utf-8?B?VzFDSFZDSzNOL2VpdGtGbU1RTDBLek1tek5mWFRmY21kSHZvY0VjRU93ZE5r?=
 =?utf-8?B?cFIxZFkzaWxQQzN1RkcvTWMwWUlsdzhqcnJ4OURkUkxKb1BvNDlmQjVOeSsx?=
 =?utf-8?B?eTlQVFlVeW5Qc1JnVEpnSnA1bkk2ZnE2OFY4Z1BTS2RsYTZZeFJWYndNc2pF?=
 =?utf-8?B?bUpYdEVib3ZhdytsN1lGUTU3eTFSYVhlbzJsM2pCSU5oWUkxT0hmNktNM3Yy?=
 =?utf-8?B?UE9xVThhb1dkUXZUaEpxcUY1UzNnUExtMiszbkpJeUc3ak90aDZXNWpBTGZ5?=
 =?utf-8?B?Y2tTVkgrbFJ1ZnRQUHl2Rkh1S2R4Y0tmdHloOWRibkJYMlRiS2FoV1ZkelBQ?=
 =?utf-8?B?Wm1uWTk5cWZnMUZpU1dOVTFuTmhTRHR6bHVnNVhTaFNOMGNkWHh1MWZNaVJF?=
 =?utf-8?B?bko1TEFTbHRTb2JFLzdCL0lZZ0pZcTlZdzhqc0lvWkdWVEhlSk9YcHZiVWxy?=
 =?utf-8?B?OWdlYm5EZWxnMkFJVkhDOXBtWXJCUjFHZFZuUHE2TkZQaDY2RnlGT00rWEVJ?=
 =?utf-8?B?YkNXektOdm5zUnhRNDNaWEFoTzBjVXpkdEZBUVVCQXlPcmVDVFpqY21rZ2lI?=
 =?utf-8?B?L2cyNW9FMWhVZ0s4L3V6cWNzUHJWOU4zc2ZVZ3lJdFA4VjJEM2xmQk9qVFBN?=
 =?utf-8?B?Sm9pY2c5YUxHNFFOengyNVJoNXdubm1xcnloL2FZK3J6Q01qc21nd0xCQ01Q?=
 =?utf-8?B?bG5CQUw2ZTR2TWw3T250QzNmK0R4a1VQWFBsS2JyZTRtRVRFcjNKNUZNZ2VU?=
 =?utf-8?B?Z2FQYVQrS3RFK1ZCaUhJS0hZWm1TSnBXLzYrK1dGdmlHdjdhRjlRUTRXSUFI?=
 =?utf-8?B?enBWSEtuRXJMMjk1SEYrSzlFN3dYVUtTTHRHbFM4Q1ZRdkI5WnNuVjlHTVR5?=
 =?utf-8?B?SndJQVJaUzgzUjVIRlFEbFNqRU55aGI2WHNkSE9rN1JhTzdMNWhtU01IY1or?=
 =?utf-8?B?NTlJcVJkWElESS9TZUpiQUx4WHBmdEdiNGVWaEprSHFFaDMyUnZ2bWVnZWk5?=
 =?utf-8?B?cDk2OHVFQlVYTFQ1dGY1SThFYWRxSXpOREswUVg2dnRxSnNQbkRTQUdvS05n?=
 =?utf-8?B?MVl5YUYvZ1RkTTBrSjRkdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1GNkRnZDltbUZ6MWZzWDZYcmFaSDBJSHhWSzR1aVpCenFQYmg0TWdFd21s?=
 =?utf-8?B?UUlIdzNTVSsvUmlTV2FFbDlDTHBmN0VzWllXYStuSFhXQnpqNkFGNG9oYXVM?=
 =?utf-8?B?VUR0TDNQWENJTjFacjhNK0pzOE5yZTU0a0Q3MzRxY0NIWXhQOFllZ1Z1eVpz?=
 =?utf-8?B?WUpIaityK0hGdU1uT29XelBaZ29LQWFMaEQva2FvZW1iYWhqL0ROUkQ0bW9m?=
 =?utf-8?B?SUNKRUE4SW5VY0RXUHBEdmhhakpKVnJNeGhJZ05UN0tnMFZlSC9FanRaUUg5?=
 =?utf-8?B?blNhbEJwTmVCbXBDOWl6dUNKc2FTRE02dk80VFpNWDdxQmdKTlJFenh6WHRK?=
 =?utf-8?B?ZFJZejVSaXJuUHllaFZ4bUpmYXBFNGcvTUs3U2UwY2ltb0dBKzRUS3pOdXhp?=
 =?utf-8?B?WVIySkNWYmk3Ky9BZkVlWk1PWFJhSitWSkxVS0RNdjNBQW5ZdlhiamNRM1Q2?=
 =?utf-8?B?QmFsRFN6N1haTEhwMWdtamVMVlJRY2luNUVQdXBiNGpRQ1J0RHhVVzdLM2sz?=
 =?utf-8?B?aDIrcytISCtTaFpFZHh0M3FiN29xWjl1UTluM2RlZzVVMDdzODMvSTYzYWZK?=
 =?utf-8?B?RWt2YU5hOTNIeUlHYTZqQUdEaE50TWMzNWQ0Z21GbFpab3BhWWNQWG41Y3pt?=
 =?utf-8?B?aWgyN2VFaFBBZzIrU3RKcEliQkxmSkRwd1JzTiswalRzemVrMzFYdHlvTjRy?=
 =?utf-8?B?dkhhSmpuSEVJSlhBYWY1aFk3MW1kWDA2Y0RZWElJL1R3djM5V04zOWJIc0d5?=
 =?utf-8?B?S0J0RVFrR1hGT0lCVm53enpBU0JBZVM3YSsrMk1kQjc4MWs4RmFBQlJiMUpv?=
 =?utf-8?B?S3RVejlEQVRTS2FrNVRjVUtMR3QrUytpSXVwenZxWlgzcFNuSU5HWFE5bnZV?=
 =?utf-8?B?Zjd6Vks3M3hGYjlRSnVoRHp3Tlp1aWMxVUNHSlNyaEt3b0UrallTVVVsRWpE?=
 =?utf-8?B?andJL0JWMGcyQ2NWemgyNjRSMFN1WDFRNGJMb3E1VTlIczVoSHlhSDloMFZ6?=
 =?utf-8?B?dEVJMDdyZzNyU2pNbUpJWm51OGgvZ2xVYkd3ZlFHK2RZdnF3ekoweHFCZ1d0?=
 =?utf-8?B?ZXQzYzdUclU2MGdXcmtrNEdPZWM0RCt5cklNWExyMHBKTTBMM3YzYktkRnBT?=
 =?utf-8?B?REVpbThGcnZsTFlRL0N2RU9hQjJDM3NYSXdUQ0kzRDZTb1FLcFZmTDJXMjdB?=
 =?utf-8?B?VDZrY1Y4eW9nSFNqRjlvZ21oVkpTN09hUTVuSW4rZFlLYnNVTVc2WmZWMUJX?=
 =?utf-8?B?RzFkaS9Mc1g4VTBvdW5UNDVpdE9sNWpQOVFJazBDNHUzQjJ2cXJ4OU03dUQy?=
 =?utf-8?B?RGJiakdXTjcxMHNHT0ZrL0I1TVhUUnl1V2ZrMUk5aE52ZlE1VEZzVE1Ock11?=
 =?utf-8?B?SHBqcmVrV3hwWWU5cVNwRk9BNG9kZXJ2aU9ndXlFY2NTbXhObXk5WXRTMS8w?=
 =?utf-8?B?MTJwelpJK3YzWjhwQkxpTE5nOFBHcXFXclE3MTFSSGtlQW4xdjVKclVueEpE?=
 =?utf-8?B?ODZUNFpZQWhNckJSdXB6a3NLeHlQQitUZFNsN2hTaFdTUU5OV2Z0emZoSk1J?=
 =?utf-8?B?cVNuNGVXRU4zdkdUcllmYVZvNFpRT2dLd0U0cWN2czU5a3BaVHM5QmNFSnZL?=
 =?utf-8?B?UE0zNzlnVSsrTVdlODlFcVJadmpTcHl1ZlJSN01xeFBEUWxwZXovc0IxSmVp?=
 =?utf-8?B?c2dvdWxYQ21MclNyUXZKdnJMQUt5bjVJNnRvOE5nYncrSmh6WGtEZTBjRVRR?=
 =?utf-8?B?L255bFdpUXhiOXpUMmF0QXh6elFUMjZGQlB2MmdsRU8xMnZsaDJzNlRaODM4?=
 =?utf-8?B?UmxwcndXOVRMcHoxWm5nbzEwMU4wdjZLVkh0SDZXT041SVM1ZGQydXJaWjV4?=
 =?utf-8?B?YlBUcjRFa004N29ES3ZUc3Y0b0gyYVJkWHl0Y0hVbUN6MlJiMTlMQStValVk?=
 =?utf-8?B?cUN0NjYwanVUalhuWWxHYm43MnpHNDRISjlzSHVJeXY5cmY4OFl3Vy85cVlL?=
 =?utf-8?B?Tjk4dDNOWjUzcFZDbDB3SUtRM3lUZnhMbkltbWo1SXZPNWtNRHhvV05ZaGlU?=
 =?utf-8?B?MnZXYm9HVElVbnB5dzNucUJnbWlmWUgzL0t2OHhkRGRleVFXdkhYSUhXajhx?=
 =?utf-8?Q?Rm/eSn4mmgBucxpvagjjUHAPe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a199f684-7e25-4458-95bf-08dca69a452e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:54:29.6968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iExhfwTBPz0c3ZrVGL0u57MQYucNql6AtRIC6BuEclu6Y9E0IkF8+Khz0B2+z8+AWh/sAn1niiDR2oqGldyAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958
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


On 2024-07-15 08:34, Philip Yang wrote:
> Pass pointer reference to amdgpu_bo_unref to clear the correct pointer,
> otherwise amdgpu_bo_unref clear the local variable, the original pointer
> not set to NULL, this could cause use-after-free bug.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  4 ++--
>   .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  2 +-
>   .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  4 ++--
>   8 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 03205e3c3746..c272461d70a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -364,15 +364,15 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
>   	return r;
>   }
>   
> -void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj)
> +void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
>   {
> -	struct amdgpu_bo *bo = (struct amdgpu_bo *) mem_obj;
> +	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
>   
> -	amdgpu_bo_reserve(bo, true);
> -	amdgpu_bo_kunmap(bo);
> -	amdgpu_bo_unpin(bo);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&(bo));
> +	amdgpu_bo_reserve(*bo, true);
> +	amdgpu_bo_kunmap(*bo);
> +	amdgpu_bo_unpin(*bo);
> +	amdgpu_bo_unreserve(*bo);
> +	amdgpu_bo_unref(bo);
>   }
>   
>   int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 66b1c72c81e5..6e591280774b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -235,7 +235,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
>   				void **mem_obj, uint64_t *gpu_addr,
>   				void **cpu_ptr, bool mqd_gfx9);
> -void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj);
> +void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
>   int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>   				void **mem_obj);
>   void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 1d9b21628be7..823f245dc7d0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -423,7 +423,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   
>   err_create_queue:
>   	if (wptr_bo)
> -		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
> +		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&wptr_bo);
>   err_wptr_map_gart:
>   err_bind_process:
>   err_pdd:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index f4d20adaa068..6619028dd58b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -907,7 +907,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   kfd_doorbell_error:
>   	kfd_gtt_sa_fini(kfd);
>   kfd_gtt_sa_init_error:
> -	amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
> +	amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>   alloc_gtt_mem_failure:
>   	dev_err(kfd_device,
>   		"device %x:%x NOT added due to errors\n",
> @@ -925,7 +925,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   		kfd_doorbell_fini(kfd);
>   		ida_destroy(&kfd->doorbell_ida);
>   		kfd_gtt_sa_fini(kfd);
> -		amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
> +		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>   	}
>   
>   	kfree(kfd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4f48507418d2..420444eb8e98 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2621,7 +2621,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
>   {
>   	WARN(!mqd, "No hiq sdma mqd trunk to free");
>   
> -	amdgpu_amdkfd_free_gtt_mem(dev->adev, mqd->gtt_mem);
> +	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
>   }
>   
>   void device_queue_manager_uninit(struct device_queue_manager *dqm)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 50a81da43ce1..d9ae854b6908 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -225,7 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>   	      struct kfd_mem_obj *mqd_mem_obj)
>   {
>   	if (mqd_mem_obj->gtt_mem) {
> -		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, mqd_mem_obj->gtt_mem);
> +		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, &mqd_mem_obj->gtt_mem);
>   		kfree(mqd_mem_obj);
>   	} else {
>   		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d65974f3b34d..70d6359bb5a3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1048,7 +1048,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   
>   		if (pdd->dev->kfd->shared_resources.enable_mes)
>   			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
> -						   pdd->proc_ctx_bo);
> +						   &pdd->proc_ctx_bo);
>   		/*
>   		 * before destroying pdd, make sure to report availability
>   		 * for auto suspend
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 21f5a1fb3bf8..36f0460cbffe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -204,9 +204,9 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
>   	}
>   
>   	if (dev->kfd->shared_resources.enable_mes) {
> -		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
> +		amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
>   		if (pqn->q->wptr_bo)
> -			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
> +			amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
>   	}
>   }
>   
