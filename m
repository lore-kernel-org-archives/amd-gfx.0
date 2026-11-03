Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDBB606C87D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HdkujvfT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05FB10F620;
	Tue,  3 Nov 2026 14:53:44 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6A510F63F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 14:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOP3QjoIjmPU/Nzwm1JPODyx9CYzEXtfOqe9qSucbFck0EqzymX2HSP8ID3w1+R9+rQgw3Qr8jP3tg0MfsChU7dtBqlA3A2ASELgYhOZIuq+boUQm/NejOs65aLqqn7uBVGGLqiPQTFc0MoG9k4L2oKz5Nv8JLm8dnQA+eHq3XKFMmAtcCqM+mcJ81l4QIWFYTvZjxKFZ8sk5HXdnglvno48xz6gSM2KIF8kE2LH/ictTXP09vf+t0JTBIiZwggkryl2UocdRcPWVOLHUCLXXKQav8I/tedfSx0HIemIiGStTSPqtp/l99wxW6FIE7iZeG3KhYrycwDi4tD2kVVcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5EwH8eU0BNLagnQMOMnoeOsNjxhYbXi8nAELrn5+6o=;
 b=qxSwplpnIB5ThC9Jg6rmiG+X/7MItZsYxdVGqqaiaNsgz4wnsEFYPU3un7DL3iWplieetkcbuz53ffug6unxUBFkdfJGy3jTPhKwalrCBa/aEUnAIXUF3xCsScGDNKgYOhpxYnQJBBDJ7Hu6dK/OgH7mkWqtNw3zH/ppYBJZaCu1fyngxQTHBRashdX2nf6T7RhDK4LYaA6XahR6NAu2loMPNE4U6AJczCcrUXA+sQiykxa50FIjIuzO8lFscB5XIdufk5j44z8QWCG/IEd/B9frTajEeGASzbdMcQSDl3m7uQFKCIyKQIdSMbKMBrpkNn31d3R/AjpcVa1zDUTjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5EwH8eU0BNLagnQMOMnoeOsNjxhYbXi8nAELrn5+6o=;
 b=HdkujvfTvRA5+LNMlqdOJi77iTnMJ52WgNYcd9cqJftkU14HBlySPmCMPFraWyewNYhJkEIeSwU4iT+c8khIaQfl6t+ldybwG5ncMt2iT54m6WvLXEJr+Twg/AMY0tPao7HM9gbxCDjcs/QRFKVVdv4uCSWuwzhiihziCbXz3GU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 14:53:33 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 14:53:33 +0000
Message-ID: <a0e2ce83-5214-494c-a681-28590beb07fd@amd.com>
Date: Tue, 3 Nov 2026 20:23:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: add support for FB carveout disablement
To: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Nikola.Prica@amd.com
References: <20261103144401.298613-1-Dejan.Andjelkovic@amd.com>
 <20261103144401.298613-2-Dejan.Andjelkovic@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261103144401.298613-2-Dejan.Andjelkovic@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0034.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: ad968954-0173-4608-1828-08df39ba3b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|4143699003|261022105027099003|56012099006|261028144727099003|11063799006|261009223027099003|261009221227099003|261021121427099003|261026140227099003|10067099003|22082099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info: rG2g+HXda2H60Q5aMm++eo/qYkXOzDr1LHZCfYuicF7UxlTrUK4fRBHZ5opYhHadaovbJtfpJqDihcTLSvj/kXP7pTqcCR+JYRj1FjvDLe8HkquLg090l1cLZFRblwXPPGA3RSLdNw1aN64uNcSTempW0Ztn/7FlVikWkjJiNHJFhh7kspsDF//oBRQKzyLoTbCoGDiIdnJFqp6t7bzIdsd5zzK8GAjZM2wFNl7dJnkrbB3+ta78GjJnFWFq9aic5+K180dGGagTw9sBlVDeRfgmewg6APpgs9PbQaOUU9uE6U/fBeamKaRyeKKJCB6JDSQZTu+acw9MofWlC+xU3aZll8Ihn3UPu6VC4UXWoiikzH61sLyBjeZEn8G9djO3n33oLEfyBbCXiWo6yQKemEMSvG8h1GiXHd9Q++Zk1gRN7dRUbr+Q+0MfKKZuhlyTABEeGSe103VDEPGP+ApBBrjW9xRHkqWzMXackoKASZIQr94ubU+vFG8VJZ78cNJ0NQGcWOipQ5izxhJqPNRg3SEmVcCWiSgYKntMa7MiOkV1mPmMUdZMUfqnkqI3bntF0BcLt3kzOo6kbGrGblmeP4gRthxn3DRyVXBgWzszJxOVXaS2kKemi4dy+eqevyQ/o4QcVTNVCHCNiCYh+bknw0DI9g6m6o4vdvJ0oQEBXqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(261022105027099003)(56012099006)(261028144727099003)(11063799006)(261009223027099003)(261009221227099003)(261021121427099003)(261026140227099003)(10067099003)(22082099003)(261102123227099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9VbUlZa1NTcWI1aG5UQk5CZnFUU1lwNEJvRE5xS2MyS2Nzb1BhaGpCNjBk?=
 =?utf-8?B?MWtUa2NtNlZrbHU4MDZ1cnhhN0NOcnZMNXhFeDRTR0RpTGsrbGMwTVZRNndr?=
 =?utf-8?B?dXFCbEVKOVJGZzNMUDVuQnU0V2trcGpablY3U2VnYktBcnVaNlE1dmlCTGFZ?=
 =?utf-8?B?NkxGbWdoOW9pZWdUYngrOEJRNmd2ZUNlTXFpY2U1RWNYbkVuRnJ2blFUenh5?=
 =?utf-8?B?YnpaYUNrdDQrM0VlcFdVeGoxQ003V3E0b2gwdzVJWHFLdkc2aVE3STIvTGsx?=
 =?utf-8?B?M2paVTFVNGplbGo0MXg0K1I0dFA3MjJEUDJSSTJtY1ZnS0VNRG5xQ1NDd0VP?=
 =?utf-8?B?RUZSQ0JHRGhySTllS1ZTL3crTDRBY2U1ZTRCSmxWNDZLWjNJampoOWdjRmVD?=
 =?utf-8?B?YUNETithaEU0R2d6d3lrMGpYUUlSSW5ubDVNTmZRMk1UUEp4QUd4QUlVSmJQ?=
 =?utf-8?B?T2o0bysvT0FhcE1YUkd3cjdIck1YWm5uMThpM2V3SGQxcEZ0YmU1bkt2WWND?=
 =?utf-8?B?ZkZHSkhFV1pyRTQ3bkdNcE9hcy84c0QwRGJ3RHlaVnR1VnVqbENLQkdsZnU1?=
 =?utf-8?B?R01JcEV6a3NiVkpnTHluYkh1SUlkbE5sa2NEeEtxRFRqb0JDeW56eldXc0cz?=
 =?utf-8?B?ZTRaUzExc1AraVJHeEo5bDVVZEcxSmpVVU5XcWp1djUza2txN1hpRlp6WVZ1?=
 =?utf-8?B?UGVXdTNxZC9IRUVpK0pVWU1heDVnVkdKSmEwQjZSTlBxeWxGQnRpdVlqNmVj?=
 =?utf-8?B?SVNDQ3FWQjgzNnlrQlcxK1JPTGhrd0lUYTJ3dVNHVnFwa01FZSsrMzA3aDBv?=
 =?utf-8?B?TzIySHNGNkpEU1ZtKzA4VmJuMEFVMkc3OGRXek8reFhTdXRMTWxRUjgxaFVB?=
 =?utf-8?B?VGE4NFFJL0VOQnF4YjVCc2t3dUliNnhZampUejNiektLNldzdXZodFZGa0N5?=
 =?utf-8?B?aTh3RVV3eUZ2THJRTkd4RTRMMzJDS1pWU3lTR3lNRm8rT1RqUy9iU3ZlajVT?=
 =?utf-8?B?RHFyeE9OTXNuTUhkSmRCclJFTEp0QlhWbXdLekd5VmxlQkVhVncxZE5XVUpo?=
 =?utf-8?B?eUdFNGtkVTgva0QzNElwNFlUTWhoVTlpYjNYQUlLdWUwNjNSNkRpMkJLcHZZ?=
 =?utf-8?B?SVJ1MDBieHVHT1NZV0RjRXJ0bnRyM0tMc0NBZGRid0FKVmViMW10TTZRdHFW?=
 =?utf-8?B?TzBsK3BJQXFLOFZWT3B6VDhKcGx4QnEydTNrcUE3ajZPcmpmaVZvT1ZteDFq?=
 =?utf-8?B?ZEE1MG02TmROL1pKbmJFdkVSUnJ4L3FxTkRSVEExL21TL01FanNBR1ZDM200?=
 =?utf-8?B?V2x0emh3UXRsQWpBVmdYZkdIbHhDazV4TDFDVm5sR0F2djdSUHBBZVd3TzVl?=
 =?utf-8?B?UE9OeDdYQ25oN2EzNTlrYzhsT0k5QjhTaGphRUQ4b05PaituRTRCeFFMS1o4?=
 =?utf-8?B?aW4xUWhjR29VYy8xVVlTRFp3dEpWUjd0dFp1dVBZanE4UzMvaDhyVy9ZbW9G?=
 =?utf-8?B?VmlVQTdxMW9nYWNqTHRyZXJvQ1VVbUlGS0hHdWd2TVRkQjRuYUxaV1dHQ1Jq?=
 =?utf-8?B?TkVMa1o0NTVMMHVLRXU0cHZNY2RlMm94NDNyZ2RBSktLSjJwS2U3QjZWSG9w?=
 =?utf-8?B?c1QzQWtGSWw5czVhN3AzK1RJUHJlbzYxazdkL2d3bHlBVzhxeXBReW9HcnlV?=
 =?utf-8?B?VXZEbm9tUlNDaDhCR2w0a2xkVEErZ0d4UFNJY1dzMStiM2xMdmdCZW1CRzFH?=
 =?utf-8?B?RzZWODBDQURQd2JLdW5oMmdOaUxOdXZmV20rT1FudnJKOU9LREtlbUF1cFB1?=
 =?utf-8?B?NGNQNnNzS0xna1FmelJ5OUJnc2tVOFJyZVRUMU85U1MzZllDV3VQeUJ3SWl3?=
 =?utf-8?B?TVRqaTVtSVVvTmpBdjRCZmVYclhjekp4QWhFbEsvKzBuWE9QTmZTQmhWdTND?=
 =?utf-8?B?RXhJUGNUc1V2eUV3S2o0RWlGV0RXcEpHa2lvTTkzTzlPUk01VDJDbWR5OWta?=
 =?utf-8?B?YUIrR2d5NlkxNkI1Q25aSE1VQnNwbnpETkFOR2hENmxxY0lNMHFDNGtjVzN3?=
 =?utf-8?B?dEhxbFZmcFFWbmNTY1NTbU4wWFhyUFRmdWtGVlhDREdKT0NOOEVRa0R6dWVh?=
 =?utf-8?B?S2lsS2RrRGtLUVh6dEhSdDBJVFF4ckhQWmRmdFJHMXdjdi9wY21VQkpTWmVv?=
 =?utf-8?B?eVVJd21ET1NsMGF1VzlaY2ZLWGt2RzRCOStSbnlJckM1YUhyZXdVdGhTamZm?=
 =?utf-8?B?WCt0bHpZeW5Ec1Z4RUJnd2l1eExnNC94YlBuUDBwb0p3NnpJOE1ZTmR5UC9B?=
 =?utf-8?Q?B1C21fCuVmJeM2lkBl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad968954-0173-4608-1828-08df39ba3b01
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:53:33.0739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TP+TSYt+YDx9e8c4udGdgEicMbuQjV2oWaftKRrHRQTss2Itn6plrsSqEFxgGYYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 03-Nov-26 8:14 PM, Dejan Andjelkovic wrote:
> Adds support to disable FB carveout via PSP mailbox for passthrough A+A.
> 
> Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>

Series is -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo


> ---
> v3: Carveout disable moved to amdgpu_psp, and now called in device_ip_early_init
> after successful discovery as suggested by Lijo.Lazar@amd.com.
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 13 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h    |  2 ++
>   4 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ef01d280cd0d..4088b8f0472b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2055,6 +2055,11 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   			adev->num_ip_blocks = 0;
>   			return r;
>   		}
> +		if (amdgpu_is_spm_passthrough(adev)) {
> +			r = amdgpu_psp_disable_fb_carveout(adev);
> +			if (r)
> +				return r;
> +		}
>   		break;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index b1492f8d5d92..a3869bf0c4d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3400,6 +3400,19 @@ int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
>   	return ret;
>   }
>   
> +int amdgpu_psp_disable_fb_carveout(struct amdgpu_device *adev)
> +{
> +	int ret;
> +
> +	WREG32(mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT);
> +
> +	ret = amdgpu_psp_mbx_wait_resp(adev);
> +	if (ret)
> +		dev_err(adev->dev, "disable_fb_carveout: PSP wait timed out\n");
> +
> +	return ret;
> +}
> +
>   int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
>   {
>   	struct psp_context *psp = &adev->psp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 3ca2fe9ce94d..ec7cbcaa5c35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -690,6 +690,7 @@ int is_psp_fw_valid(struct psp_bin_desc bin);
>   
>   int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
>   			 GFX_CTRL_ADDR_TYPE addr_type);
> +int amdgpu_psp_disable_fb_carveout(struct amdgpu_device *adev);
>   int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
>   bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> index e0713e27556f..664c885a8cf0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
> @@ -50,6 +50,8 @@ enum psp_gfx_crtl_cmd_id
>       GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
>       GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
>       GFX_CTRL_CMD_ID_GET_IP_DISCOVERY   = 0x000D0000,   /**< Copy IP_DISCOVERY_DATA to host-specified address */
> +    GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT = 0x00100000,   /**< message runtime VBL to disable FB carveout */
> +    GFX_CTRL_CMD_ID_ENABLE_FB_CARVEOUT  = 0x00110000,   /**< message runtime VBL to enable FB carveout */
>   
>       GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
>   };

