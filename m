Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20762C982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 15:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9707410E1EC;
	Wed, 16 Sep 2026 15:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ep4e473i";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013008.outbound.protection.outlook.com
 [40.107.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC76E10E1EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 15:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aw6KSEU98baSYUKFLE8PrVj0EJKnCk0JzN1GifXgHCsigGmiYIT4O3btJo9h5Y8zO2S3+eXMyIYlu53BFzAQ6AGZVMRY/Nj5yb16P/V0qdwPX3eAmfQs7WNiNtyHQv53/3ALzxuPmU9h8578NNND6Zupav4asqGoyzQ7qPrkzLh6ht5fSIUVYW8R1WOsc6SawhZ3y+FUhVgjuK7XNGwhL+6p/lb0sX4hcfiBnDlyyanaaBYyfgfBRA5vC9+gnKoeaYH8YQK4PlmEnVLj4bLEWBJcviY7IriqzsedUuuFNqUBJtkOCPkxjIuX74awn3CUTALqs1RJLGCXFGlabpsGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTlmd2XCWekk+zuUCS6UzskvqK2pmVBFTF+Nta1W0Bs=;
 b=nvgXSfbTkOXuBpso3p4rQLcHjFTz6yS+juvd5mAVtfOH6uarec9kud88RzSVeicVc5Nxm+72E3JL9UPYqoRWZo2ZUDoafe1snFqX8JNFuDDNzwAxV/FgwKKdJWjF4aRUn3YGUwcJENIZoGsGdzgWG3AqYBUCwRwz3NYUVCbIGGIRcfxA2OEooyaI+fMbNHeech38eDQf11GCbblk1XwmOTzCP4iqJKaM9xj1FNOnlwfumk5qTZW4AMcM4w+t5Oj6BX8e4BHi7MzUfcrZD90IdPVjwU2nqKkubakCXHHOcROtnZDmHfdunB9oXDnYUmkW5ZaSccX6J+m4qnAah53uxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTlmd2XCWekk+zuUCS6UzskvqK2pmVBFTF+Nta1W0Bs=;
 b=ep4e473iuLGLhSUpDLs2ORLpBda/fkJovhvDWvfG9T9qTe7x9YUG9XN9p8n5KoeDoDQLWEYZ95BMUOlSjGU/ImfxIIGnqt+WKSJYvOWfIiI8UuQEfXh9ylh1fiY5dZHWrbj8ISifZ7Usueom0jUxBHprgfdL7l0c+pLIJa8OxI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 15:47:12 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:47:12 +0000
Message-ID: <276aa3fe-0763-4e4f-9c4f-f45c5eb24b9f@amd.com>
Date: Wed, 16 Sep 2026 21:17:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix NULL dereference in
 amdgpu_ualink_info_set_accel_state
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260915064113.454895-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260915064113.454895-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: d908afda-9299-48f6-bac2-08df1409c62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: FkVzv4KXXvjqx8pC16bci0GeySxf3JqBE0ANRJLIOtDkJox2KQTa5B8pl5eX44zUSNoWdBUgnbaunDRevbCJSvrIbxE+oNUUoYbEMkI76rYiTs9vJW10LYEX65KjbGG1cyH1XAcv0xc0tfJxYLm5LRp/JSgqIAGX5kpgyodgP4yZkCvwldRkk2PykK+LVBzHtKlfgxQs2bEDng3sgtGCszY+TSB/leN7f3mzmuIP0D3FaBTf+50MLes93p30ON58/T9gvJwVpL2zHWsQ8HK+SJCrLg0z7g1GHKn1vamd1HljVCNlnzNb9uNpTiL/91/TuAVj/f14gHobnGsp4c1gaxvCMWZUw3+UHZ635IZ/hIhDBVQwuOXRJcSlv7WsyqP6wloX3puUxzSYSngLYbw420xqSMwad1z7kegLjODUx2OEzbw/P3jqHIJzV2o9srY96wX9Nci/3GNczZxzRgVBdGZlo/cc/AZxNKUU8C6FYTV36gDT1qrJA6AAeKJIkKmzJUMua0oU8XDQvW78r8TD/Oh/3dfyCkFgYBJ5h67qcOZwRgzE2ubAFidmeCjpj5Ay7eDtI6bI760dVcn7xff1Ql+62r0vUVvEHyQkuoNSe4yDkBBMcRtrg5A1YTzZwZBQDE52RM1IQVFwfzVIrOXQA7St4RIPhOnMniyum1OTVUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDFidTQ5NFdVZm9Kd0wrK2NHandwdENpVXYxazNSSzUzMjBmNm5QRDNQcGlo?=
 =?utf-8?B?NHAxTUx0RlM1cnFvemgvYzVrU3NYaVl1dVhib2Q4dzJoRVdqMzNrS1cycU9z?=
 =?utf-8?B?bTRTNVpma09mUEhRdjVReldDN1pCZ0o4OU1CdzU0K0h3S2ZYYURhRTI0bkY1?=
 =?utf-8?B?NWpiY1pHdmIwRnFLOTRwamlBZXRoaTdWcG1iSkUvS0FsTHdmczB3cWlCc2RF?=
 =?utf-8?B?ckE4TEQ1aWVmV0lLcEQyQitLWThRdW1HTzB5WDRodzdWYzFkRWxXTi9wdzF3?=
 =?utf-8?B?M1dTUktNaktza243QnAvZ2RyNk5KUit4RXFJN2RKMjViTHozRVk4UEN3cnRE?=
 =?utf-8?B?ZWhGWE40TXhEeEZuUUhqeDBadmIvVVhqemppeFVOZkpMUlFXU252eXVkMWZp?=
 =?utf-8?B?a0xtZmwwRlBObWU1SHlic0VqQ2ZqVjQwSEdkUWt6MElsTmw0T000OExPZkNW?=
 =?utf-8?B?dFh3WXdIQWJ5bVZuQWx5Vlc0NUpQWTFzZmJPNGs1ejU4dG0vVEh6S3ZNWTZ5?=
 =?utf-8?B?YVJvVTlWdVM1bDVaSGJkUThBbVN3Mnpyek13cm5qRkRZWE5aMnc1SUtXVHBi?=
 =?utf-8?B?TVFYRXlFT1ZqYjJML1F5SEZtWW5EVlo2OEd5Rk1BYXZhMkk3YzA4MEc5Qzdo?=
 =?utf-8?B?cGJkN3oyaHB3L3g5am9zM1NKeDQ5cHZ5czdUWHBFWVJqQkIzY3ZWajZ5azFq?=
 =?utf-8?B?ZnZ6N05ZdmpmSG0wQTdIcjQvSmNoRzdZTDdyZXd6MjNnWXZnRStxM2ZaNG9w?=
 =?utf-8?B?eEJhRUlEUmxST1ZsWVNhZ1JXUGdoek44Z0JuaUR0b0lQL0thL09RRkZKWHJn?=
 =?utf-8?B?TmlKQUZETU1HVkpoc0k5bjBOb1ExYm1KWTE4eE5CMHdEdTFzRTVaWlVkbVR6?=
 =?utf-8?B?c2lEV0ZObU82WGtGeDhCU2RKYUxXa2htVkdaRXhpSkpJb1FTS2ZjeVp6emR4?=
 =?utf-8?B?RmwxY055blI3TDgvcGIrVmVRcGxTK0poTjdEV1ViTVVOWHJ0NXhRQmo4dGRo?=
 =?utf-8?B?MmZtOW9CMFI0UEJiYXljYWVNcm1jMjJLWWRzdCt6YkRoZDJ6OXo1R01NVnM3?=
 =?utf-8?B?dU9HSlNNWGFKTDNxQndweFFPTDJRZnUvZFpDSFd3b0dTVjExZS95cXFJMmYy?=
 =?utf-8?B?eVg3dHhFWkNmZFdNMStQdHAyQStMS000VUpiRDFKL25CVlllV0VzME4rWUs2?=
 =?utf-8?B?THJQZjh6MVlvZW1kb29lWUNoM05DeXdjZGJneEtWdmZ4RXZNU2NkYnkrLzNF?=
 =?utf-8?B?dGYrVENtcU05Z24wU2pHTmU3c0lXdENra2tUL0RJRzNOTzdpcFpyd2k3Mkdq?=
 =?utf-8?B?Y1l3NWUwYm5WNWRuWjczdjc5ZytPdWtqdngrb1UzcVpsRWxKNzBhY09EeUl1?=
 =?utf-8?B?R3pPVm9XaVU2eFZsbWllZzVCaTJBbHlnUnM5R1pXQmhIeFYvTG1qa0w5aVFx?=
 =?utf-8?B?bmNsMGtpblM0RTZCUm1yNkcvT2Z1VGNxSnZIbUwrNStQMFpEcjRpMS80U3NX?=
 =?utf-8?B?Mm14N1FwTGo2cFZET2pwQ3duaHhFVzI2ZExVTFErOStPZnJHV3IwTDJaTzBO?=
 =?utf-8?B?eitrTmxIZ3BxMm1wWU9OT21ISDBjNCtPL2tRQzhTNDNxdlJDdElLdXdCRXF2?=
 =?utf-8?B?VndraDFlM1NFOWF6MHhRSWpLMlFOM0NJdVl4dDhUdUZ0eWF0YXY1c3BRQk1a?=
 =?utf-8?B?THVZS0dhdi8zYXR6NFB6TVdMK2V0b1MxckZCcCtGaWVYd1JGQ2xMNFFyVml0?=
 =?utf-8?B?U1dHYUl4c1hUSHVoVWU0Y3JPdEFHekJZeGhYK3NNeHF2OGFvakx0Qmw2bEJ3?=
 =?utf-8?B?aE5HTVVRS2hWODdXWlU1bkt5T2FmTU1ZL2JDYUZRZnNYaW5yL1ZVSnJlVmNJ?=
 =?utf-8?B?Tk9hQ01Cenk1MnVOS0dERVU5cnF4TTE4YURmSTBDV2dhRGhLc0J6Q1JBYUgx?=
 =?utf-8?B?UmtDUU1jdXN4cDRFUFBScy9hNTgzbUw2MEFJeDBXL3Z3Y0FzY1pEbUZVZEZ5?=
 =?utf-8?B?V1ZQWkRSLzlIWkY3bXkrMFRQZG85UVdnY01kZUlYL2RYQk5aQ1AyWU5wR0R5?=
 =?utf-8?B?cWZGNEdsZFUzdXc2U1FpTnF5UUtSTzVWL1FFTjFJeE9Tb2dzYVNlNGdYbXha?=
 =?utf-8?B?cUhObVcybnlqTjVHTElKU1BvVlhjR0l5Wkd3RmYwYlV2cHVtTmF6RGx3QVFm?=
 =?utf-8?B?SklLcktMYTFraWxjUnVMMVhZWm1TQnpzT3R4bE5hZGVoNytMRnpodkttcDJG?=
 =?utf-8?B?WU4yYjk4YXNaUjFCc29YZWJDeTBYbExGdmdCb1djVHRJS0pGS3JpeDd2YVNu?=
 =?utf-8?Q?IJDQQv0oOWWhOAAYjX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d908afda-9299-48f6-bac2-08df1409c62c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:47:12.5619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHkuj1OFRqkQiUAiwLdyMurYAcOsUV0MaTz5EFON+1Xz+gkgY/TudQJo5Jj5X8+B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056
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



On 15-Sep-26 12:11 PM, Srinivasan Shanmugam wrote:
> Commit bb2545b351c3 ("drm/amdgpu: Improve ualink state transitions")
> introduced an access to info->accel_state before checking whether info
> is NULL.
> 
> Move the access after the NULL check to avoid a potential NULL pointer
> dereference.
> 
> Fixes: bb2545b351c3 ("drm/amdgpu: Improve ualink state transitions")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index f4a4432c2c5d..3b0d5138a349 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -161,7 +161,7 @@ amdgpu_ualink_info_set_accel_state(struct amdgpu_device *adev,
>   				   struct amdgpu_ualink_info *info,
>   				   enum psp_gfx_ual_config_state cfg_state)
>   {
> -	enum amdgpu_ualink_accel_state cur = info->accel_state;
> +	enum amdgpu_ualink_accel_state cur;
>   	enum amdgpu_ualink_accel_state target;
>   	bool ppod_validated;
>   	bool vpod_validated;
> @@ -169,6 +169,8 @@ amdgpu_ualink_info_set_accel_state(struct amdgpu_device *adev,
>   	if (!info)
>   		return;
>   
> +	cur = info->accel_state;
> +
>   	ppod_validated = cur >= AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED &&
>   			 cur <= AMDGPU_UALINK_ACCEL_STATE_ACTIVE;
>   	vpod_validated = cur >= AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED &&

