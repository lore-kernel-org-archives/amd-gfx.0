Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6453606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iSuNmci0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7103A112410;
	Thu, 19 Nov 2026 13:43:50 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A40112410
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE40qIF+lYL6XV3aWQGO3X4RVUs4x6U/3BTtTdgnIsH+Cj2WftdvFWrnI/f0PjZlPtVCreMrGzRFav4G9hIUlsXeHbvlFeyiS2fV67w9D3s6AJOJQ+/4t4Zt7J9Hi/N9z4JhMevlXNCdvrIa2wNs6wcZNVQVnAIh6NLyZ2OYV7MyImUWm776XQWNiYXh71LGQDbu/gO8xNepcLwP4NLACIBBBn0HYnT8AyGko4KaCvKAs7e0Q9tXs26atGyD8uvmdhaRf8HGQ8wmg4mIP8kvsS0h6mgbNK/vL8+BURhc7UuPUHPvnbOuJiMpfyXqkeh9mO3zTyJuxHpAjymDzf6xSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GQZhpxySKfR84FLuruOCNw1zwjqVBrGbKMiHO9aSIE=;
 b=OR5qdT0WSZ1odGIVuvptFNn2W/wTyY1iXMZrQip5DeWm5XfWp9+9cv0K418tBT+iPWRplZn6R2zGC+HAkHzPPEZpKSlulrNDlHzL0bgXudgiRL1KYKnoz1v+WNIaKZhW7NdRJN6j78vmIc2WEw1NJa/2sDIjDT68yI0UMETTCis2DTsU47OAfXGX7VmBkLArSjqqN8tqYZWG4AewEIjybP0nhfZs+Rha2CbYwafDY1HaGli5tKYGmVDOb66a3rjByW+6L/5hwC6NNzVN7Q86Qqotd0VlTSulwebW0m2MWNpZRKF7tnam9clicD/H8wgQ4sjMiXQC4i4GV64lfOUeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GQZhpxySKfR84FLuruOCNw1zwjqVBrGbKMiHO9aSIE=;
 b=iSuNmci0jQ8knUqU4t5t63ySZ3UMFdx/wox2CAK5RF5Fi7TxZGFiYoodWNpZzz/ne2REsiMy8+fosKl/nN2rtiI9aLDFGERFzeYVPU17x6Nu3+QGP/bscNWLaUHOhC+I0njHqtNiagBacWrtZLczIwd0PcgbHK04FFTYjdDHJgU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 13:43:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:43:41 +0000
Message-ID: <7f48411f-3578-4ad0-8158-935692a3e55f@amd.com>
Date: Thu, 19 Nov 2026 14:43:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdgpu/uvd: stop using amdgpu_bo_fence
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
 <20261118185225.1857845-8-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118185225.1857845-8-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: aa56715e-b0b3-43da-7cab-08df46431f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261026121527099003|10067099003|261026140227099003|4143699003|56012099006|11063799006|261021123027099003|261021121427099003|261022105027099003|261028144727099003|261102123227099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: gzr+AOnuJaTfmYiYkcL4RWjeflm19igyk+jwLeoIMYEiVZm39ZxeT2Z8WI2MN8U5ll1YEIkgk9x7kLH+fz7tNu0puc3dDqb9he+0hIQGnJCTqsoI7bD5xLAkN5LBkbIoBj5tWulsZI2/5871/m9OCDwNmKF4LEq9WFTnOKL8xmEgWvh/i/gjQJ02+IXISuj5Crz8GyISQ8wnFQUmlLShU7GvniyKCx5/GtMxJYnInTdkuiG2fUnx+l4Y8Dt9ryEVoNRPml/O/iZ9iVmUrVBJdI4MTpxMJd1jXxiJ4Q2rpk6vBpUFPhSGHm6dJBCkkfuLoBbjVmKxu5Byv+ialKlAkYf81UlUbC7tc4sdu82I00pXrWfBKLzOwkvqRXEIFzff9uqRdFHAb1hUw75HQuohTL/qCi9ncQUeGU34gd2hbhRLbYoGuvP/lge92cUbZltyvJfMCTruGu9CrqqLAl4RwZjehPb6KB7pxRMRAsNI2P38BBfs1vQTyPYxkhY+NdObhYmJVrmnuWIEZpd6Xu84uZ2435nMZEInWEcHIMVLi56uBBtwRhldUirNmHrdZTvKv9Ewqclr4b+JSKQTm8I5vqYcb5d0M3ki9M7nSS9A1jiDGBvbJapCNn+hikJCbXjBALFEftB3YiyyWl2XjUetiV90PXask/ldzReOW78cNKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261026121527099003)(10067099003)(261026140227099003)(4143699003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azdqZWRXaUdtNXRrMk52ZXRaS29PbkhxZG5yRkdJY04wL0RMNEpidTc3M084?=
 =?utf-8?B?K1JnelY5V0k3WlArY3JrYmpBcllZRzU3M3dnbm9kcFFPc2gyb2NJK2t4Und5?=
 =?utf-8?B?WUJTQnRRazJNYm1rWWVwZG1ISVpmMGVQdUVvV1RvVUF3d0pNVWNaOVlUdG4y?=
 =?utf-8?B?MGhuaGxBcm42Z0liU3RRS3ovMEVxaFhMdyt3SHkxWWl5STFtM2xDZmszaHpn?=
 =?utf-8?B?MTFMSkVpd2RCZmFNalFoY1czZ2Ird1J6MUt0KzNuWW94bFNuUVg0R3ljSjFt?=
 =?utf-8?B?dmtJSkl0OUk1S0ZXVG1XcVZZU1h3WmRIMnVmUk5UeHQ0OVdIVEQ4TzB2bDFC?=
 =?utf-8?B?ZzNUbmVHU3F3d2lNNTAzOFI1Q005R2JQZHVHV3JleC9oNDhmbUdHR05SRDBW?=
 =?utf-8?B?VHA2V2NPYWJUTEtYS3pYZXVHeXFaR2ErN2ppMjdYczVJMXdhaUhkMFpZcXFl?=
 =?utf-8?B?Unl6Zm5rU0ZkZG9XYW8vVS9FS00rMDU0MTRkSEEvb2VWRjhEdlBFODZWdmFH?=
 =?utf-8?B?N0lISC9adE9OaER2c3Zpdm92dHdMZTh6K3pWT1d2V0R3UjIxTmZwNjJ5VElW?=
 =?utf-8?B?NTdabDhaVkN2UzhRZFB0SVViNXJYUTFVUVpURWthNm9zUjJJRWdLMWV1d0JK?=
 =?utf-8?B?UkVobTlWT2ZTbDJodEkxVlBtOW5SM1JYam42YWdJR0YxdEttWEkvQ2R6TG5o?=
 =?utf-8?B?aHFEVXQzZHFDMEV4dXJuQ1BqcDRSZmR1WHlLL1NldzY2MUVnTENRS1E3OHIw?=
 =?utf-8?B?eFpPRms0UlZPanM2cDl3cUhoQ2oxN0dIVzZjTlV3YnZOaFlyUnlGL1VtOFd0?=
 =?utf-8?B?NVNRNHMxb2Fldk8wdnBYMElaR2k4em5yamEyb0RNbVdObmx0bVpTZi9zRnRD?=
 =?utf-8?B?dUZXOVM4cUt4azgrajBoeEUzT2U2SkJpSTBYdTlKQTdraTNNMktwVTQ0Y2xL?=
 =?utf-8?B?RHdaMUNLdWY3Tjd5SG80bVVSYy80ckFLZEFHb29URURKSjVzUTdJOTVNTk1I?=
 =?utf-8?B?OVcxMUQvRGRVNjlyMXl2QlE0VzhEL2pnL2haQkVweXZaOEl6Mi9rVkR2ZFRF?=
 =?utf-8?B?TDRJWGppR2pzWWpuU1E0WXV1cnlmS2p3YW51YXczTi9pSHJIV1JCUVo3NG1q?=
 =?utf-8?B?ZlMrNkhMemppWGtpWEZKQXV3RjNLREZkemJiZ0o5MEtYdU9JWVpUK1gvNFJa?=
 =?utf-8?B?ZDFHcjlwM0lDSU9VWXB0b1FpREM1dFJZUEFZV3RwYkNvT2VaWUFUbTdONVNl?=
 =?utf-8?B?Q2NFYXFOdTdCWkE4bDdrbzEwZGI0eGFxY3RtZDBuZVN4NzZNOG50VTdXd2xR?=
 =?utf-8?B?bWt0M1hRTDAyV1hyNVdTYjVNY2xFWWNWZUcvYU5XV0o4MVhUK1NuOHlPZzk1?=
 =?utf-8?B?R3l5U0RvZG15QWh3VlluZ1c2T0oxYlQ1WlBOYStDMWVLY1ZuYmtGMnJkVFFi?=
 =?utf-8?B?UlRyTGZKZ0RETFNHS3NrbTFsRStpQ0RYLzhEN2xwZUFocGNKMmNxU1VEQXJn?=
 =?utf-8?B?THRodlV3Z0Z5d3dNSHpNUm81cEVRNm8yc0JreDJmM1VRMkt6ZGtzdW9wODA5?=
 =?utf-8?B?eHR6MVZSeWdYNGhQTmQzVFlUYnYxZm1TelJpZDdtSUQyZVdrb01FbTV6QXg4?=
 =?utf-8?B?bXpnM283VS9yS0wyR01PQlNkQjZjYVk5bGVGc01qbnpiM210NU53V3pUMWQ5?=
 =?utf-8?B?RUp1RWo1R3NHekY1VnRmY1lINFlLdk5DeGp2TUw4NTZZYXpmZXNvZWtadEow?=
 =?utf-8?B?NUVlc1E0MEpBOHp0RmpWakZOMmJpRlo4OVRhaUdTZVByamM2ZmRPQi9tL250?=
 =?utf-8?B?SVpQbFZOZFR0ZkR5S0MvVWJvZGZTeUk2SFZIVE1idFVZY1FyZGpEekpWTFhT?=
 =?utf-8?B?amhOdEszbEJiS0tFek9Od1RlelR5WWRsWVQ3aGkwRnYxcnd1MW1WRG1KMS9N?=
 =?utf-8?B?TmVsNjZjbmpBU01CUmsyaFBsQTF5TXhwZHk2TGo3cEFzTnNBU1dFTlVsZEg2?=
 =?utf-8?B?MEhKK0VXNXc0d0JsRGh6eTU4VVhnV0ZwdFlFZDZkZXFOZkRZcXN4TFR6Wlpr?=
 =?utf-8?B?V2J1Zm1KNVBJTHljVUtWWkdWalU2WGhLNW9vNk9OU25rcHpoTjVQSEF5dUFI?=
 =?utf-8?B?U0pPSk9DVk0vWUtCVnZzT0VRYTdaa0FnRGxacDZZWXIzcGdldkF1cG5yMU9Z?=
 =?utf-8?B?YWtpY2VHNUdJMForaEY4WDJKVjQ4bmd2RXVzWUxOV1RqWmZRQ2NudGRCaDdV?=
 =?utf-8?B?ZlJmcEJGUEJTMEFpbERDR3hhZ3doRzhIODU0c20rak1yRFJ2bWFLUUtWOXNw?=
 =?utf-8?Q?7zBS2pDVYGqepAZTpW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa56715e-b0b3-43da-7cab-08df46431f0c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:43:40.9467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Vg0JDWAA2/GyUQ6h6q/oIkfTiQoIHKZAd1Buwxs/pERN+IQxTGKjCsfuaMMP0lh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480
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

On 11/18/26 19:52, Benjamin Cheng wrote:
> This helper is deprecated since it is incorrect in most circumstances.
> This was a circumstance where it was mostly correct but it is the only
> remaining usage, so get rid of it here.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index d88dde859615..9570db033b18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1154,16 +1154,24 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  		if (r)
>  			goto err_free;
>  	} else {
> +		r = amdgpu_bo_reserve(bo, true);
> +		if (r)
> +			goto err_free;
> +
>  		r = drm_sched_job_add_resv_dependencies(&job->base,
>  							bo->tbo.base.resv,
>  							DMA_RESV_USAGE_KERNEL);
>  		if (r)
> -			goto err_free;
> +			goto err_unreserve;
>  
>  		f = amdgpu_job_submit(job);
>  
> -		amdgpu_bo_reserve(bo, true);
> -		amdgpu_bo_fence(bo, f, false);
> +		r = dma_resv_reserve_fences(bo->tbo.base.resv, 1);

That line should come before the amdgpu_job_submit().

> +		if (r) {
> +			dma_fence_wait(f, false);

This way you also don't need that hack here.

Regards,
Christian.

> +			r = 0;
> +		} else
> +			dma_resv_add_fence(bo->tbo.base.resv, f, DMA_RESV_USAGE_BOOKKEEP);
>  		amdgpu_bo_unreserve(bo);
>  	}
>  
> @@ -1173,6 +1181,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>  
>  	return 0;
>  
> +err_unreserve:
> +	amdgpu_bo_unreserve(bo);
> +
>  err_free:
>  	amdgpu_job_free(job);
>  	return r;

