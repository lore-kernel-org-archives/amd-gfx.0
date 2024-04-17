Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C8AC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 04:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3FE113101;
	Wed, 17 Apr 2024 04:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FcMvWASy";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB76113101
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 04:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y78gnKbNuu9Bd8eJSEg1dAr5LagOiKBosIWVWQHhV0Sb0zB2HBvnVBa8nBsuZI54VLhO2cQQ/lsA7qaDh+WU/ry60hl1E5wniMQJrLM2z8FVvigoSO4UALJv8EeaIh3afnrwPLCRIkQGB5AEfc7dUwlE/jnfqJtrV8msXr87q+C/gC8MY33xOcAa/tlY8+0TMIw0j0KQQ3/q096kFe+SOlk2erfqN0Vq05KV1gDTPGH+u7ZCGa0azI/0d1E3j6XKkoICXu+axyc5m0l4RUyQ6ByeVE4KhcYMFGBXQ0n5Nf0sK35qvB1lHULTILru+fZUk920cJ98FTz9jYomb8xTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E84VLA4FEBFaHbk2AHfyEHPejGMgnq5R/SWHb0NZog=;
 b=NINqIeIRrmwa3cY9By39SujxBHooEtXdXPZRFa2xv3DrVgJRZwsR0mqJqKhlFK2BvWvQliWsclFLRBiINmAWDo6ubiOh2dDL2EuXWbSlhjiI7Nk5fqTz//JhQh826dYAc2NBmX/PSuPS+wHd68Lnj3Rf+XjklRMPmqevzm4e4qMwSbpWENyB1uKmLcsZq1zg4ZXFIIXyXEZCzKLWiph7b/ytqevIui+Gxz2jtmrMoh+j4LkYOUW8viUMQ9hZJCyDPd3x/lWQ1F4mTGrKL5ePUgXmg/KbTQLqcskOPNKHssO0BF3/w4dUU0Uoh61cvISIMYFKTBUWAnDKAN23/dyswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E84VLA4FEBFaHbk2AHfyEHPejGMgnq5R/SWHb0NZog=;
 b=FcMvWASyMMQHSV76tBqfbG8m4G5zOYo0/2fSLLTwxB70HaxP4hhjR4nZ29hHDPFD88m7oIJYVyb0vO3/JkjsbT4SfxS/jpyrf41XNEYxLNaSJoF7PDolkHgax36XUVXgz+kMWcVSmeaSo5XJwwP5lDfLJ5TcM6ckxPndN2r9LjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Wed, 17 Apr 2024 04:31:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 04:31:14 +0000
Message-ID: <7c029350-a2c0-4ad7-b9d1-f7b7e32f9209@amd.com>
Date: Wed, 17 Apr 2024 10:01:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Skip the coredump collection on reset
 during driver reload
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240417041336.65366-1-Ahmad.Rehman@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240417041336.65366-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: cf30878d-3571-4890-99d7-08dc5e973772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmtpSEhIT0VTMlRBRTNtSzJPdDBvdkJWNXFKdU1UQWMxQ1dMSzlmWnZuVFpV?=
 =?utf-8?B?MC96MjZlNTJrSnlMZ1NFeTFEQkZXMWUzRXlqWVJsaFlHY0R4Tzc1bVJnZzJt?=
 =?utf-8?B?ZHpCdVpjL3BHQXBCTWUrViswRmtwV2lVVHZQbHo2Z2I2aHlwdWFtVUpadjJX?=
 =?utf-8?B?bWtIZFNtQTFjYUFMK2hXTmxxYzNST2gxUHRhZmlkRXphcm9GZzV1RDZzQUd2?=
 =?utf-8?B?QmRBYXJwQjRTckF1U2tkYkNicW1LbW90K0l6VzcrOU54VDBBaU55YnJmUVlB?=
 =?utf-8?B?WE1QeHpNTzRGWFd2UzdQQ1hUSE4xSnpXU29QWjNjTUh2U0N5QnE2R3h4ajNW?=
 =?utf-8?B?MGdpS25sM2ZxTTU3R1BKOG1aQnhzQ3N2TFFkUWxwaGxVcDMyWFZvN2RXUmlQ?=
 =?utf-8?B?cW9KckFxNnBUZGpEREEzS2hrYlRld2Z3L2g3dVhBQWVONEl5blQ4amx1c2M1?=
 =?utf-8?B?YncrekJrNDc4L2ViNTA2UmRaeXYwWURKaVBpZ2lhMnVyZW9tck0zUUtCclMr?=
 =?utf-8?B?MWpaeFU2dGYwN1NNbDhrTUMzSnRwRlNrS0hsSGc5VTBoUVNVSU9uTGxtbTNo?=
 =?utf-8?B?UDMrclc0VW9CZmFMcnA4cGZ5TzR0enNKcHJnaTRremhITXBBS0s1UkFDTWVx?=
 =?utf-8?B?NlovZGR6RHFrcUJpSUg0V3RLSCtVVy83Y1F5Kzl0cWUzMHJydUJBTWNNM2Qv?=
 =?utf-8?B?VFgwbXRSakVGQ3dlcHp5enh4VXc4SXFycXdqZ2NISUlTVWtjM3liLzdiZG9B?=
 =?utf-8?B?YXI3MHZrNnUyWmRKUDZkK1Z4QlZLYjQzWTlJWHhpNWxOazF1RnlvWkN4aTht?=
 =?utf-8?B?RmtudWN4VndwZnE0TWJacUkxaXFtL2w2K3Ura1F6clhxRGZTTWNDNGtjV3R5?=
 =?utf-8?B?SGdZcThlYjVtamo5ZHo0ZXZ6TlB2V1B1WjcwZGcrSmxzLzlqeWxYRExXVUZX?=
 =?utf-8?B?Qi9TdER4K3ZFeUtoUklBdVl2UWpNTVVjYXBNL0szamVkMHlMVTdNOE8rbG9K?=
 =?utf-8?B?Zy96R1ZFcmFWQy9SYW5IV1F1MUhsVzdPV0prSWxsL2U0UWgrTnRlYklTd3l3?=
 =?utf-8?B?aGdOY09WRHRKVWhobEkvSkxoSXRJdGM2ZEJxL3R1YWpTY2JxTU1IWWxlSERP?=
 =?utf-8?B?aU1YMGM3czZGRTlXdlE0V3M0MTRrMUxKVkhlMmhISDArQUlPM2l2UlZTMXJL?=
 =?utf-8?B?RkhzSVhWTm85YmtIZEoxRDJEWWF6RG5LclhiUjRZMWdyQmM0VGJuWm9BN2kr?=
 =?utf-8?B?ZEtXaFZXWnJ1WTNnMC9zUVg3RkRIc2xIZ2dOYzRDR3hLNnk3T0c0YnJyR0g2?=
 =?utf-8?B?emZFbm9EZ3JpWnZnSHFXRkVVTTJKZlhpaXV2RHF0WUptYmFUUXUvS1AvN3hP?=
 =?utf-8?B?WUcraXNLdkwzeXR2UXF1eFdLMUZ6d25ZM0t4ME9mMWs1TThxOGVCcTA1YXRQ?=
 =?utf-8?B?US9yNk5WbkNQQWNXOXVtLzA5cTc4cXd6cU5lSzRwNVNTczlsVnR3OGZHR2hv?=
 =?utf-8?B?dDhDZUI2QVpsRTRRemxLVXdJSkZPblkvRG9hNEVhM3lIUDRLaW5TMklDT3dq?=
 =?utf-8?B?a2IrVXFTQXc0a3FPMDRBR3V1YkxXbzNBZjZ6WXd3UGV4TUdzYzE1WWhuQ1pN?=
 =?utf-8?B?L3FzY3AxS2ZBL1ZKS082R1dwWDJNOVJWMDRiZklCcUgxSEtmdXBzWHBvNFdC?=
 =?utf-8?B?NCtsT3NuZ3NLMTZXYmFid2ZQK0h4TStudWJFbm44ajRDWUk0VEZLY1BnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWpDZnNySUdmTTlkRDZEYTNmcjNGb0twYWNhV2ZjWmdQVlU5ek1lc3N3dTVl?=
 =?utf-8?B?SkpwL1EzanM0c2cxOVM3bXFkd0NzK01qVU1FZjVUNWFVemVjcS9PSmJYQXY2?=
 =?utf-8?B?RXBuZHJYelg1WjJDN3E4MnBNamptQ3pzRFZ2ejZCcDB2VFVyVTNHNFUvYjJF?=
 =?utf-8?B?UWJpZE1KSmFEV2crSHJlOUpQZEdkTGVrYVNZRi9RSG9vVFJHalJyTnFYRGJq?=
 =?utf-8?B?b25yTndjQ1JKR3V4WU9GOE5xU09xSXJ5ZEQwV1FtNGJiTTlOVnNtVWF1Z3gv?=
 =?utf-8?B?QXNYMkNFZTlWQ2pLVzZqd3hGZ3BsSjB1ak9MelFZVWRiMEMvQmN3OUIyRXpq?=
 =?utf-8?B?SHFnTVByYVpUZTdmUHN6SUJqOE1Oc0FtUFc4UStXd0k2ZWRqU2d1M283Rll6?=
 =?utf-8?B?emRuY0FkR3RQeXQ1c1RIdFBVVXREeVRzZGFNV1FDSGlJUzlEQ2xYMEFKZGhP?=
 =?utf-8?B?WDhaZkpaNFh5bEgxQUJaS09VL3o0RXB6ZmxFQ0NsdWx4L1gySFpmTFV0T0JP?=
 =?utf-8?B?dGpuVXhWZ2hMTnlkWkJOMEtPL21BUEtWdVZpdXFBY1RCRVdsRkhEUTRWYXJ2?=
 =?utf-8?B?a1c4ak1MZkFHVnlReTB3d1BxTXVmWTRSZzdCUnk1c1RveEpjcUF3QjIrN3Np?=
 =?utf-8?B?MXlpL2NLMkc0RFBSc1E3aWpKM2ovV0Y0ckU5NjFKSUFPQ0JWSHk2VStxeGM4?=
 =?utf-8?B?R1hMNG9yMGdSUWx5eGRMMUFRaEl3dUNEVWRkVlVCR01vY1Z6aGowcGhISFdW?=
 =?utf-8?B?NmpaL1djQTUwYTRqLzVRb0VYVm9FVWhzUEZhallWUC80VmY3ZFFZNnFOd2dh?=
 =?utf-8?B?SlFROWdyTWdJWUFScFBsRU51SzdOOGpaWjUyY2Rzb1M2M1B0bGxzU0l1Y0Fp?=
 =?utf-8?B?RldnNU8zMWFxS3p3VVlZSTRqNjU1aU9yTUZYaFlUUjhVMC9POFc5ZFloMngx?=
 =?utf-8?B?a2FZY1hVNGUzL1htUWdHOFFIalZVMm5QOXpDTlZhWVUvb2pPY1liQnBPcWxC?=
 =?utf-8?B?eG9hRDNyN1gzR0h1WFY1WWlIc1V6Vmh2SVYxODJEOGsyWlM2NTBqcDZMV202?=
 =?utf-8?B?dDZqblVNTWc3Y3UxcCtiS2JHd2dBNlZ4eHlLbXhHLzlnbzJYT0Y4amhZQk52?=
 =?utf-8?B?SVhOUElrb3NDeGw0SzZhU3RGTkZaQ3J2RHhDbmRxSjBSY1ZmYytzbSszM2VI?=
 =?utf-8?B?TGlwM2RqcHl4aHBUOCtheHpiMDM4MUhNMmhZVDVQRFBLOXpXaDV5aWIyeHpZ?=
 =?utf-8?B?dms5TVdwcHZhZU1TdGkvem80QVVLbWthSnpRK1lFYzczMkk1OENDSURvcjgw?=
 =?utf-8?B?Tk1tNEJVanRVL0VHZ21RcERDOXBXL25Ddm9ZWi8yOG9BR0dEOW9jYnhwbE10?=
 =?utf-8?B?cFdtWVUzdUZxRUx1cStJNm0va0o1MDVWRzB6OFUxL2EwVlV6QlVzWVJWZWZa?=
 =?utf-8?B?WVpHY1g3MTRQcTg4dm1pbUZkMENUemxFeGpBM3U5UU1wTGJMQjhSNmlRam8z?=
 =?utf-8?B?VlE3WHU3QTBBU2hLakp0Z1JsZy9RTlFwYWY1dXRzajFoN05ZOHFFTndYQTZV?=
 =?utf-8?B?TnBPdER5NGFEZEpwbUxoVUoyOVAvR0JGam1kajFKWTh5RXdoNFlXNHp2NkVN?=
 =?utf-8?B?aU1FTFFWUm44YnlQNndXZDJ1OGZFT3c4L3YvQUtOTng0NFNkYU00TjZNYlZP?=
 =?utf-8?B?MEcvWlRENmtvZUJ1Y3VUd1NJTXRnMU1YYVlmRDF4ejllSzVsL0N0Q3hHWTdL?=
 =?utf-8?B?bmtvRHZUMGM2d2I1MzU1NlZ0OHFkU0xwZnpoeTNyZzBXQ3pvSHhoNXZVSDdy?=
 =?utf-8?B?bUVuSHlYUXV4cUxUWkRxY3Q4OERBMFRzemJIandqUmM4Rkd3WHJ6aDRoa1dn?=
 =?utf-8?B?ZlpZb3NsYTRXZ3RZWjRhV3g4S3MyR1ZrZFBjWWVVZEd1RHFDeExVOThocTBK?=
 =?utf-8?B?ZGZ0MGVSUUxFTVFSMTM1NlZ6TjdSYS9Fd0o2ZFVJeFd1Uk9qTU9sNHVaRzRK?=
 =?utf-8?B?aHFmc2JnYWJNc1kxeVVrbWVEZkQ0bGxlMFQ3Smc2aUtIWW9DaUZXb2tiWW5i?=
 =?utf-8?B?QkM4UlFrVWhOcFpTMG5WOUFJUXRxOWg2eG5Caml4UXpPb3JwM3hmb2lmdGlu?=
 =?utf-8?Q?KKYftDjMYlGk/7IAP1mp6XqM1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf30878d-3571-4890-99d7-08dc5e973772
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 04:31:14.6619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRMvo+xKrvCF6DrD0Zfij1wyiIPwN4D/GWSxc7pP/GANSyEBZG7ruR1C82l885Rh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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



On 4/17/2024 9:43 AM, Ahmad Rehman wrote:
> In passthrough environment, the driver triggers the mode-1 reset on
> reload. The reset causes the core dump collection which is delayed task
> and prevents driver from unloading until it is completed. Since we do
> not need to collect data on "reset on reload" case, we can skip core
> dump collection.
> 
> v2: Use the same flag to avoid calling amdgpu_reset_reg_dumps as well.
> 
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1b2e177bc2d6..c718982cffa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5357,7 +5357,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>  	/* Try reset handler method first */
>  	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
>  				    reset_list);
> -	amdgpu_reset_reg_dumps(tmp_adev);
> +	
> +	if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
> +		amdgpu_reset_reg_dumps(tmp_adev);

This may be saved to some bool. Anyway,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>  
>  	reset_context->reset_device_list = device_list_handle;
>  	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
> @@ -5430,7 +5432,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>  
>  				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>  
> -				amdgpu_coredump(tmp_adev, vram_lost, reset_context);
> +				if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
> +					amdgpu_coredump(tmp_adev, vram_lost, reset_context);
>  
>  				if (vram_lost) {
>  					DRM_INFO("VRAM is lost due to GPU reset!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6ea893ad9a36..c512f70b8272 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2481,6 +2481,7 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
>  
>  	/* Use a common context, just need to make sure full reset is done */
>  	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
> +	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
>  	r = amdgpu_do_asic_reset(&device_list, &reset_context);
>  
>  	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 66125d43cf21..b11d190ece53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -32,6 +32,7 @@ enum AMDGPU_RESET_FLAGS {
>  
>  	AMDGPU_NEED_FULL_RESET = 0,
>  	AMDGPU_SKIP_HW_RESET = 1,
> +	AMDGPU_SKIP_COREDUMP = 2,
>  };
>  
>  struct amdgpu_reset_context {
