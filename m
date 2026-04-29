Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734C3FF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 08:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F9210EEC6;
	Wed, 29 Apr 2026 08:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mPuDE2FJ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98BA10EEC6
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 08:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQR1qK5HZUGv+Wxzrx3IIhNd77Q5aMFpgHHXFuB6+2Iw9dSHHIkNnu0CHa9cWWd7XZ3BX+GKzDD4RW89Z4rUjM5n4zbCZaWN2l2t96Wn/Sf8uAQgHI+6SbJcA+ZqaIQG3JBwYe4KH4wtgdY1u7sKRfvv18nFWPK5npY2c3Sc/h7UMZGjPvQKX80vni7AZHxHxFpWTsIK5DkrlFGHFDgQ69m2n4jAizjasWSle7NGCYcaHoRDg1vnqJnG5VLF0rknQDf1zlb2oipC72wIosUDNqxA8EQzYnSMuEYCsABfgMuJpVZHZqiwBXKenidgfGjGBIl8dIbo0aNgMVAn/h8TnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQeKXTrra3GzPVxCLCrlezFc7pz5UgdMdzIe38g5c10=;
 b=nCqBnXELjoCoDn98OCkF+Z+e31QK2Sq2vUdozvilN8oFLyZuieS3LQTzzwFW9pc0LEGv9nZt10vfhcUtx8fv+py7r7YMXsDJgJ4A5obummtSg0xpNC76DKcBJiRHmhne9JGQ+Njl255vN8MRqDAghxfr95FZt+AsX6xEgQ9qMqJ/m4YSq+qmd4WrogmprSauEqjwjp1dwVB/t8dW9c0G0pwrxERh7hWHJZIdj9cl+D7kF/1HFZ6DHEXMvhh0TKoE/Kliwt/bqB0iNrpc7zjPqAB2jVQbJoeweIETnRS+CdtgFk6tKuYR+LLVUpAiyzXbA0kwTJgV8W3h3jCCFF1QEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQeKXTrra3GzPVxCLCrlezFc7pz5UgdMdzIe38g5c10=;
 b=mPuDE2FJLG8TZ0RSh995D8hdlsccmsU0meZfVLxMHs3wSrAvQB8tpcfgKHukHmhMlOj9BPPwOq5qreTxP4UIOPRb6G/aoeUlZcJiLBQFxzyLF0LNDuuPDeIpFV0KiJBX0HpQY9SJxoIpImvQnzgWx7z4BYn4LRJTRfrgOyJiS3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9732.namprd12.prod.outlook.com (2603:10b6:610:253::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 08:21:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 08:21:23 +0000
Message-ID: <ac567435-2fbc-49d5-b4c2-7dfb6139f4eb@amd.com>
Date: Wed, 29 Apr 2026 10:21:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: zero-initialize GART table on allocation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260428162219.3761327-1-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260428162219.3761327-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: 938911d1-ff72-4d0f-0815-08dea5c84c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 5ODRCPvN81XmIYFdTVz3gQPDxfGNV8QFw3DK4H3PQAnWUssd+R2yEgZdix3ppx/AUNzjVBA5bQH5oNhUadYdiYO9bQAIExl2+fbTiWt8OwFz1YGkYnMx4kYBMXCY5h8axVzZm0MZ3OKMsgNSQR19u+EnmQyhghC98rp963ksmXsLuwNDJwEuLXWx6cRPJGIJpSD2IMjapm40GfIKkfqe8xHi1TUD+SV4v6bW7PTlGl0zWmMgqZJ0NOJG/9PvDwHOlq4oMn+RZXLJDNNK43MXzPm/yZVLwnOMvxiep2wKR43K+5UbSiiaKcFxh6k0ztlDUb3Gp74QJTJBqZcttBEu0EI60X/5vV3eqad2DF8N/iTjWunsnDuVs6qpcmBv4K2kZDAo0y64/fwcv3K7IkhuP2nFiJC9gkZyFVSOif5WMm5EF+mbYy10vXQdY/MX8BajB82Jep1D1r4SICEXpSqBCPU/71CC/9ejzgibJLRquq0LaxHFfbuUDqflC9lmzoQEurFxNey/Ah3G7adIgcNsx8GyvzKokZvS+9Euwy9FAKgsmVqjwpXqcTijjfYUceD6W6oOWPf5YYl74LO92EpBvnCSmbyvIl7xcUC9iN8oQ9dvl2aq0v99yuyYD0HFJtlee0e5kjPzHj2/PkIqcSBzWoOfX2Pfk+3ODJ77d8zVSpKOd6tSg0siAbeL4isVPd6A0jdRnHJGvtCyOR/eLUg0LlH4txkt5XVJ+o7nKwTjP2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3BoZVBCeU83QTlsUDZ6TUpUSEU4MzNJYTFNUmtKKy9RY2o1M3IyRFdGdUJV?=
 =?utf-8?B?WVAzNHZBOC9mcUJsRCtuYmR0VTdDdjZ1VU9sR3Y2OEpHaXpjTjdwRmZqck5w?=
 =?utf-8?B?QnpZQWJwR2lJMGtBRUZQM3pRdU9BQ1ZoS3p2Nnd6cXpWcEFwTzFJU3R4RG5k?=
 =?utf-8?B?UTVmOFBrMnlqQTZzaEJiejZUWUNUUng0NkFFcXQyb3VkVm1KTjFDUTUrVWFU?=
 =?utf-8?B?T1lObkp6bEw2T1lXQTVXTjVCM3gzWFVjQnp5eE1xK0JZYjFhZXpTV3BXd1Ja?=
 =?utf-8?B?MnFDNXFrSy9PZWI5eXlIVlZqK0tEQjZkRUhrOTFqWTZEaVl2Qnl5UmVXUjh6?=
 =?utf-8?B?cDZtNFh1MHVqTzlyR2NtS2JPOWJoNi92N1F5ZnBFWDNCcDdKKzRoQWQrN0pJ?=
 =?utf-8?B?SFVwc0xpZlR2Y28vcmVXREY1ZGMvSVJQbkkxSGJkSTNVb01pa3ZOWnZNN2NO?=
 =?utf-8?B?NGtqR2F0UllTZEJmZVNMUk1YLzdXL2FDU1FlRFpmbEV2TFltbzJsbldxYktD?=
 =?utf-8?B?WktOMTJvWG5wUThPKzRhMmNVdnBPV0RoNEZydmtCRi85Qk9BKzJNbElOaTQ5?=
 =?utf-8?B?b1FCbTc5Q2djZkMxYTFEMFptKzZGOU9FMmlULzZvUG9jY0d3Rk1LM2RMRUFZ?=
 =?utf-8?B?OE5EaHFMbndIZnNsVmRzQ01XRmZObFBobDlnU2k5dVVCOUxXSklOeXZObGdU?=
 =?utf-8?B?V3hmRmZEOG9JejNhMm9mc1J0TXZBblRZeHpVT1NYZzNYQ3YvalE5SkdhK2Zr?=
 =?utf-8?B?UmF5M1dCWWtMck5ZSWFmS0ozRU43ZUk3czhZUHQ5Sy8rYWNqU25FMFZXVDJY?=
 =?utf-8?B?NzFpaG81RVRXZ2I2dGRQUG1meStDRExPdzM1VHQybDcxcUpxQWFUeE8yM3lH?=
 =?utf-8?B?Wnpwa3RVL3Q4VWkyWHdNSzV6YU1GM29KRzlrbTh4Qzh5VS95elhoOWdvMnBM?=
 =?utf-8?B?SEltK09QNDZmZWVRNTF1TW1OZGw3TkFzNUxKa0ltQVRpQVpwendPemJpdmVV?=
 =?utf-8?B?WWE1NzNSSXhMSGdrNERoSWVEQWRCUDB4SVR3d3NiQWNwd0hxOW5BVmFZYk1h?=
 =?utf-8?B?UHB0a09ES2l5OGs2YStkNVluanJ0SUNWRDdyVzNXY1VFRHdkOTcvVFpBS1ll?=
 =?utf-8?B?ZzBVQmsrdmtoVVZsdWltTlY4cXltbTdlZkhVV0NjMjZhT1Z2L2o0ZjZGTitW?=
 =?utf-8?B?UGZlRnNGR2VCUUcrY1J6NHptdHQ2ME5VM3EyOXIxVXcvTklPckNlUFNSemZB?=
 =?utf-8?B?Mjdvalk3cm5XMkRIUXNMRGhDU3lHbmxZL2JDaXlhSHZUckJkdlF0eGhORk5J?=
 =?utf-8?B?RGVmdEI3d3V0SVJwbWZocVZKbllneGIvditZSFJNdTZ6Y0dMOWhZK3ZOUkZH?=
 =?utf-8?B?SmxlN3IweW1YN0dRaVc1djJHOTl6U29DOFJsSGhjaGJ6U21Xdm5CL1NtYjlW?=
 =?utf-8?B?aHlQS2pielBrV0cxeUVvN0IrcjdNODZwc0ZndGJ2VWwxL0hpbFA0b2luZXg2?=
 =?utf-8?B?b1YvZTFSNG9QSW5zcG96bnFsamN6cEZ4SVE5dGtDUm5UVlR3Nld3YUN5SXdk?=
 =?utf-8?B?SUs1UDRkTGtFMW1XUjF6YXZOZ3ZqRTdzMlR6VnFUU1FENDBIaGs2Mi9ZRzJn?=
 =?utf-8?B?VXhpZ0J5bEpFUXpTU2RRMzdkMVQzaHQrWS9GRFpnK0tWaVdoYXlMQkcrSkxr?=
 =?utf-8?B?OGd5alJqQktYU3lud1dOTkEvYlFkU05YSlFFRzNrdm16MGNtUGpTL3J5NEJH?=
 =?utf-8?B?VnNVNG1HZEdmTkpYVk16NmM2WlRLWml0bHh3dVBLNUdJdHd1ZmEwSTJnN3V5?=
 =?utf-8?B?eXZaVE5oZ1cxeVNHU1JuaGNGeTlPUThKUVR3RGdpMGR0VndPSDJkVDRMekFM?=
 =?utf-8?B?d1hyZnZmOUxsc21MTEZ3UFFYbTNZQWNlTEhBcHBzcC9MYzEreElHd09QMHJk?=
 =?utf-8?B?UFVhbVJVSlRnamZHc0xmT3VYeVpZdEU3RWhQaGxaeGFaazhZUWluYkF0Q2JV?=
 =?utf-8?B?VEp3OTgzSUdwVDR2YjVYU1g5L0JNeWg1ZTVJRHdyZVd4aDB0RE5iTGhUMklW?=
 =?utf-8?B?Z3h4MC81UnpBSDRCbkpvVGZjanNmekEvYVYzSHo5dkY3ZHhuV0ZJVlBxcmNO?=
 =?utf-8?B?dUZNeDgwMFRKam92M0cyNzJEWjBRQUtlOWNaekFhalE1S0d4RGQzYXVmRHdI?=
 =?utf-8?B?VzQ5bS83WllFNmRHK2psOXJsTlVrbDVrSTVVNjJVbnV6TjVFOHlTUVlTN0VK?=
 =?utf-8?B?WkJjV3ZCWXlLNVVVWTc5OUE4RWpQdVZyV09jaHBveWo0NnRJY2xBa0JTdW8x?=
 =?utf-8?Q?WMrwCDEkPMEEW0EJI9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 938911d1-ff72-4d0f-0815-08dea5c84c93
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:21:23.2206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aci0DeIgVyGkLdTlqQakFqw4zdWiyhcTacK+DM8GS/7YZZOvlopTTMoHwEB2Vjnm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9732
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

On 4/28/26 18:22, Philip Yang wrote:
> GART TLB is flushed after unmapping but not after mapping. Since
> amdgpu_bo_create_kernel() does not zero-initialize the buffer, when a
> single PTE is written the TLB may speculatively load other uninitialized
> entries from the same cacheline. Those garbage entries can appear valid,
> and a subsequent write to another PTE in the same cacheline may cause the
> GPU to use a stale garbage PTE from the TLB.
> 
> Fix this by calling memset() to zero-initialize the GART table with
> gart_pte_flags immediately after allocation.

I'm surprised that we didn't previously had clearing of the GART table during initialization.

> Using AMDGPU_GEM_CREATE_VRAM_CLEARED (SDMA-based clear) was considered,
> but is overkill here: the table is only ~1MB and initialized only once.

Well the main problem is that the SDMA needs the GART to be initialized to work.

> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 4d884180cf61..f09337bac0e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -262,12 +262,19 @@ void amdgpu_gart_table_ram_free(struct amdgpu_device *adev)
>   */
>  int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>  {
> +	int r;
> +
>  	if (adev->gart.bo != NULL)
>  		return 0;
>  
> -	return amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
> -				       AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
> -				       NULL, (void *)&adev->gart.ptr);
> +	r = amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
> +				    NULL, (void *)&adev->gart.ptr);
> +	if (r)
> +		return r;
> +
> +	memset(adev->gart.ptr, adev->gart.gart_pte_flags, adev->gart.table_size);

Please use memset_io() here, apart from that Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> +	return 0;
>  }
>  
>  /**

