Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083A2C2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 17:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971A010E616;
	Tue,  9 Jul 2024 17:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HHaj/Hni";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E7410E619
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 17:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVbBjsMAUM0GlsmQJLZebwA4n2I476EQTUiz7AGP2XzTcOxWEU7UsRMKiIbXs+4uuq2TAd584HrNbTqZwj01Kc6nnjknXeJ6vrY2Z8t3j0Yf/v6Gnt2B+lkFqClSM/jQQraHKD/vnaF88GVuljs2Bg1FEfnuvwdADTMImz77uhXJXd50eYZp1BJhlJRI1avURSZJLBX1wnTzQXrklubPQuIjP9e/tukHo9aj1OBRqm/2VSwwpDwVPDE123zbMd+UMjk7wMmhXMVhuAsHAKn71F6e6VrBjBtCsbOAlVBqPRRP8cy22mCJCc3g/gX7vV1nEOkPTsUkw7rHmgum0zVIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS0R3eWMia837AGuuCiVwSuqNxrHZOiWh9F0QPlvfDU=;
 b=ZP/6bItmOyZEPsP/W10mva5DVv6yEdkRWvpzuRVX5ZwNwYQ4ip9GksiEgczqD8/tU2EPgDEl1zXNQGd4YmVBFI+8kBecY6E+wfmwoql4pOazmeQnVfywoY9/2exGuq7A46/i4YM03++ScYwSznbF9C/sqb0b4Wt5fjLX0PQG4r3F2kp4qIH9xJCJkqjeqRAhgN44/jSFAUgHWoQUik6R/sS6ePIRIiZkPWQceZZQNwIbvhnx/zH9WiAIUfh+lRNJENaT18D/ufebcbl0ydCOwKuwtiC6Q4Jb2pGf/ncPd29wE519e7GZyQRJHA9gkaK51+Q/ZqOOTaI6lOPh8Lfg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS0R3eWMia837AGuuCiVwSuqNxrHZOiWh9F0QPlvfDU=;
 b=HHaj/HniGXf0G6DDRBbMTuT6Bn9epYa26dm84REFy43PdEOMw+ZKekbYXMEJvd4RGQJ3bgt3Iq8vFPmpic6Bm8/ew0ZztvPMFlCPti1CNrXSP52cMIiX5Di/oZ6AV+FO5ux2hAvJxAturMb2YKDesPOY9yPukLXt64zvWtqbiSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 17:52:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 17:52:24 +0000
Message-ID: <80598a3b-b57f-4900-b408-256374b56f6e@amd.com>
Date: Tue, 9 Jul 2024 13:52:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Restore uncache behaviour on GFX12
To: David Belanger <david.belanger@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240708214127.1330692-1-david.belanger@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240708214127.1330692-1-david.belanger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a517727-dbe8-46b3-c1b1-08dca03fe3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGt2VWxpWVlsSXRaNXpvRkttbzR5c28yRWNxTzZLZkxzbDVMRGVDUVQ5NEdV?=
 =?utf-8?B?QzVCZVBjKzBEYjYzL0Rpak9ha1E5OHZJMUhtazlXdTN1L3ZCRm0vMEFYdkhJ?=
 =?utf-8?B?ay9maU5WOUZldUJtYUlaSEZDSUx4UnBFY1JlRjh1TGt2SmNpa1Q3SlJ2QWFm?=
 =?utf-8?B?MzhIbW1yd0xMSUEzREtoNFp4aWMzM2tUbXpwK2VvemJwMFBmczZkOUJkck9K?=
 =?utf-8?B?UEZlc2JHWHpGNFFQckRlR1BBNmxuMStSYjFrSXVxcnhBY0w2bjV2TWNBZDlI?=
 =?utf-8?B?MzkwME52ekVIeWJvb2dFWVlRTDJIMWRPRzBNdTRiUVFRMTNlYW4yNXI2dkQx?=
 =?utf-8?B?d3lLZUtjZlY5UWZNK0VRSVh0KzZiRWRxVG4rcVE1ZWRVaVdXU0k2TVoyclFS?=
 =?utf-8?B?SVh5THdXT3lqSHhpdEVFWDlhSkxldTRZNEdDN0N1Y3RubFNHR1NnWGZaUklM?=
 =?utf-8?B?M0IzMy9DQW9rNDVXUVo3c3h2WmlIRWk0TE9mZUpMc2JUcXhYcTc5WEduei9I?=
 =?utf-8?B?WXpSQUxxWTZzblNkL2pnUlJTaGs2Mm9XaTF5dWp0aEdzamkvVG1sZkdFTDhP?=
 =?utf-8?B?am0zZUFIQUpmdkVjek5BQVRQdE8yeVdxclNCc204WnhUc3Jxd2ZxRVQ2K09o?=
 =?utf-8?B?aTNkQUF2V1hyMFJ1Q3k4RU9OOXdSS0JHSndXaDMzN05VL05YeG01djQ5VnZQ?=
 =?utf-8?B?UjhuVDJYWVZlaGU3Tnk1eExCbS8rQnhPUmoycGlCL3l5aFVBNWIvb3JQSjJK?=
 =?utf-8?B?NjFkNVA1OTYraWY1MXIySW5ZL1ZaYkE1akZuRXE0UnFFbVRJeXJtTXVJSEFq?=
 =?utf-8?B?ZVF0a0RYT0wzdDEzbTFHZTRWcjM3MmRjZDI0R29WSUlvSGppS1NReS9xZjQy?=
 =?utf-8?B?VmIxYUhLTTlRQVNSNUVHU2lEbEtheGtqOWw1WDBRb0t1aDZaV25rTXZ6VEoy?=
 =?utf-8?B?MEViS3dtck5kRzBwdyt0YUdjMVdDMkRjdjBjMnJ2aURLeWtCdnJIK0EyaU1w?=
 =?utf-8?B?dFZwT1lmaEJjWjg0WW9xbzFPRHVVRFVyWGFrdHREOTdiTEZBQ0NsOEUyMGZX?=
 =?utf-8?B?Y0c3R1ZzWXB6azhWY0tLVXJDamxSY20yRFZEZURsOU03TVZlRkRpbHNnZDJ4?=
 =?utf-8?B?MXRac2g4ZlZVTXQ2ekhhc2lkYlcxdkw5eGpPSjdqWkFxaGQ3VjEzUzVBT29s?=
 =?utf-8?B?enBiZjNzOS9NbytLd2Zka1d1MDlYS1U5UHFBNEtRWXQ2TC95cFJLNjY3Rnp3?=
 =?utf-8?B?SFhWRWxpbHJWS1JTbi84UldCS2hlY25aeTI0dHFtYklLMUZMS2N3TCtpNWpK?=
 =?utf-8?B?UmJBTjFIazVhNTBvS1ZaWHM0WkgvN2VieGxoc3o0WktIUmtRbmlaM1NZMHBw?=
 =?utf-8?B?eEJ5aGtjNkJrak1TNGJOanVTeVFHZTNHNmlvYWVRaDZmSzJ5aXZNVlh2b2F3?=
 =?utf-8?B?bjlmcTB2OEVRbC9qVC9xYlZTMitKUVg2b1ZSOUNNNnBoVE9ISlBqWmNkSStD?=
 =?utf-8?B?WHFIMTl5SmQ3VytZRXhjTFgycDB2c3d2ME11M2xQckUxRis2bzdBcFRCS29r?=
 =?utf-8?B?Y1dKUGFxcW1ncm0xdzVPNi9LdWFhNG43bzgrUkp2QzJaUUZFeHZ5UkxMRFhm?=
 =?utf-8?B?SHNEcmVMQThYUzBpY24zVTl6b0NsYzYzT2lmQXc0Q3JIM0tvY0IwNFBiTXRn?=
 =?utf-8?B?RkdlSVVWY2gyMEhYRWdRQ1h4OUZtaTBaRThkOThRQ0NxVXM0UGdRYStsM2FB?=
 =?utf-8?B?TnhiOWxrWTlZT2VOWjU0aXdzd0xEdDZLczg2Y21WTUJJcmJqU2RSSWJmOU5s?=
 =?utf-8?B?dFlZMmRCSG5BN2Y2TVZ1dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXdtMVZ0cDBwNTBsQ0NGd0diazRrL3VWZmVUa1RCRDlnd1JUWVYzL0tTMWJF?=
 =?utf-8?B?VkYwRnprYXAzUSsrZVFJbjJ1bjhtWXpiV2NSejE5MEFuVVFIL25tbCsvMlQv?=
 =?utf-8?B?L0FlTHhkWVc3a1V4OVdJNWhnUjYwMFVoTzErMFRnZXJjK2N6K1hMaGI0TndU?=
 =?utf-8?B?S0dTSXc0bGhqdWJHeEt6UnNHY1h3U1ZRMCs1VFRqem9jam9SZ1FBNnQ5SjJX?=
 =?utf-8?B?VXJWVThyWjg5UndqSDZiWG5VUEFRK2MwK2x1ZzZOaVVPL3hpNjlrRCtJd0dP?=
 =?utf-8?B?NklSY0VpTk9FRTlFVEQ2NDVMZE9iSkhTRCswMHFjZThLZ0Z6aVppMHE0YUo4?=
 =?utf-8?B?Znh3N0dlOC9DOVg5ZzRJeE1JajhuUTlKSG1xS0dYSStSYmIwVExpcVY3djh5?=
 =?utf-8?B?anNVV1crZlNsWXErYll1QlRremZkV2xJQ21HUWNoR0hVQjVjaCtmYlp6UG5q?=
 =?utf-8?B?dXphbTk4Q2VGb3Eyek9MaHZvRHpSM0hBNFF4ZnJhL0lKd3FCbHNlQVk1a21p?=
 =?utf-8?B?QmJwekswL00wM2MxQmdVRXN2N0s5YmErYkhhUFpkNVBCVXRHUFphQUlva1Uw?=
 =?utf-8?B?aEtVQ0E3S2c4cFg0SnMvdXpPV01JVGhxWlFuNCtpVURMQmh4WUh3YVdxYUpP?=
 =?utf-8?B?aWwvbG5id05Mb2Jabkt3MXRiYmJLOCtueURGL1IvaXJPMmo3NmcyZURuaVVz?=
 =?utf-8?B?bjhvbkhWVGhWZk9KN254MGx5eFVqZGdMdXIrRjhaa3RERDk2U2JUTEZWOElE?=
 =?utf-8?B?Y2RjZlZDbnhnbkt3UTUzTWdWeStzSzhOWkJsS2xnc3RSRVFJZkIxQ2V4WXVw?=
 =?utf-8?B?Y05wa1BxUDlrSmFkaXVXUjRNd3pFMVMvZG9EdjBMK3lrUFM1RVlCYW9pbVVp?=
 =?utf-8?B?YTNUd1JWNUVJbGczcFNzNmllMXNrMXAybThIY3ZmVnh1TW9lMHZEY3RBbWc5?=
 =?utf-8?B?RVZSczAvU3E0NTJQbGRXZ1RmeEpGM2VYQ3VzYzdUUVBwSmhDSE8vcFZlTEl3?=
 =?utf-8?B?R3hUem4yMmFNdkxpM1Y5a1NoZmFuaVM3dkxrOVJ1c3cvZmtuNHZFdzVBTjlL?=
 =?utf-8?B?UGxsRnl3Z2hpVU5HMnBIcnMyMXlzUUFxTUdFK290clFzQjZKS0pmVmtTTkFZ?=
 =?utf-8?B?cGFIMEc5TitRYUwwcXF1N2o3V3FmTUdneDZBZUhPM1JzSnpFelo0bzdTSVlL?=
 =?utf-8?B?MzVibUF0RnFhRGEzamVGTFRWbnZ6S1dMbUVCS3NTSVRUQlUyeHQ4bXFDWVRo?=
 =?utf-8?B?QXVoWUh1VGc0NG5kK2hLZUxKM2svN3F2cXcyYWxQMWxJU0xCUnFIU1hIVGVu?=
 =?utf-8?B?aktBL1JrQW1MZWlXYVVIWmhwb2hPZncwR2xTN3k5Tk5FMmRSTTk3dTlKNTNY?=
 =?utf-8?B?cG90UjFqMDBRaHZQcmxIVjhPSU9PbFlqb2hJRzFvTjU5OFlGVFI2ODNUNFlR?=
 =?utf-8?B?cytvVkxqYllWa0VuaFFNWVpYalkyTGtkR2Y3bHBielF3T21KQi9uZ0NySFFn?=
 =?utf-8?B?N3FiWHR5anJYSzQwZFFxSXRmaEo4THc5MDRXY0lJZ3RibXlwbTV3elkxUC9Z?=
 =?utf-8?B?YUxmcFFBOUloS1haakcrVlNheUwrNnV5MXU3RzlXbVYzYlM4WVNBSkFkQW9x?=
 =?utf-8?B?ajhyVWNXaWdKUDVyNlJrbXNpOFdiTThhOUYzSVlJKytZU2NkRFJJWFkzY295?=
 =?utf-8?B?RFlmSHdHOTFVOWowRUJYWm1qMFAxV1RYTm0vNHFWOGdVMnIxN0FGeEVQeWhn?=
 =?utf-8?B?MVN5czh0dVYwMjR6eEdqekMyTWtUK1pUT1ZJUGxZSzZpVW1jNm5EdEwxb3hL?=
 =?utf-8?B?VE16dTlYTHhHakFqb25LcnFMT1labDRNY3QwTnZ2QWZHcmJrVGcyOFRacDRH?=
 =?utf-8?B?RGtoVkp2NWlTWkVDSGxTZmNra29MVDEyMjJRR2dUcy9QMVBxTlAxTDJSck9E?=
 =?utf-8?B?V0ladHBaTUxab0NmZm5YZ1VhajM5cHRhbXRvN2QxSXNpUHNHZkFZQ2tjZGkr?=
 =?utf-8?B?K0pkdVZWenAvK1JDVStlVFBONWZ3azdxMjZhTlZNT242T1QwSGxTbmFGWjhz?=
 =?utf-8?B?MS9SU3YvSE5xdGR3VGpLYTVkRWNmYzVCblBLSnBiVkRXT0JDd1ZZSFpLRHQ4?=
 =?utf-8?Q?84TlKuaff6TR4zmciAvxtrPt/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a517727-dbe8-46b3-c1b1-08dca03fe3f4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:52:24.9066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Donu3roKgOHnjI+DXNjvWFEGU/enTjWxySnBmJiJoC+51W120EWi/11OmVzCZ9+Kj18u95Z9wAU7RdqUhHxdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
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



On 2024-07-08 17:41, David Belanger wrote:
> Always use MTYPE_UC if UNCACHED flag is specified.
> 
> This makes kernarg region uncached and it restores
> usermode cache disable debug flag functionality.
> 
> Do not set MTYPE_UC for COHERENT flag, on GFX12 coherence is handled by
> shader code.
> 
> Signed-off-by: David Belanger <david.belanger@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 21 ++-------------------
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  8 +-------
>  2 files changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index fd3ac483760e..542225eb13b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -498,9 +498,6 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>  				 uint64_t *flags)
>  {
>  	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> -	struct amdgpu_device *bo_adev;
> -	bool coherent, is_system;
> -
>  
>  	*flags &= ~AMDGPU_PTE_EXECUTABLE;
>  	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> @@ -516,25 +513,11 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>  		*flags &= ~AMDGPU_PTE_VALID;
>  	}
>  
> -	if (!bo)
> -		return;
> -
> -	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> -			       AMDGPU_GEM_CREATE_UNCACHED))
> -		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
> -
> -	bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
> -	coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> -	is_system = (bo->tbo.resource->mem_type == TTM_PL_TT) ||
> -		(bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT);
> -
>  	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
>  		*flags |= AMDGPU_PTE_DCC;
>  
> -	/* WA for HW bug */
> -	if (is_system || ((bo_adev != adev) && coherent))
> -		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
> -
> +	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
>  }
>  
>  static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index bd9c2921e0dc..7b671aefab01 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1248,13 +1248,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>  		break;
>  	case IP_VERSION(12, 0, 0):
>  	case IP_VERSION(12, 0, 1):
> -		if (domain == SVM_RANGE_VRAM_DOMAIN) {
> -			if (bo_node != node)
> -				mapping_flags |= AMDGPU_VM_MTYPE_NC;
> -		} else {
> -			mapping_flags |= coherent ?
> -				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> -		}
> +		mapping_flags |= AMDGPU_VM_MTYPE_NC;
>  		break;
>  	default:
>  		mapping_flags |= coherent ?
