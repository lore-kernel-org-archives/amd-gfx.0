Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F29C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 07:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB9510E462;
	Thu,  2 Jul 2026 07:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WHxdKf1i";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850BF10E462
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 07:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwdNwxLpflut4iHt4ARFTI8N3PD9Fa95Osdtt+g3aaYpOSCG4sSJAKiD/t/V4yWAbuZxCRDDaZ0L8IPuKROf6ytzdpJ4/nNXjQvEb7yRSO8slNss41fsDxANbbS2nwMNuqnYFUPwDrhb3F9iNXPzutXTHRYCPnoIhZp+xIfkWr0oREvgAW2Eg0vRQbD8II73GzjI5b2Umd3mUN7p6n+zQbzYvcuvPjdhXzupvX4J1SR4biX9ZqwvD1wzN9pd4K5OewLOlw+IodGPQjlQNgW9piQ8fjvjpr64hF3A9tkzC5ClXX4th5XcePM4ePjWHMCFUasIKlHsFj5ruHasOW5qZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OYGDw/5c0Fp9XhOBDUpu3G6u1uwbS/Qs20xdo5FpBY=;
 b=tNuASphH7CIR0hcRBjXwA9wXcprUP9zujAXJw7bDRI0pV53HIFAIU/HQzGPmYD6ZlKeqm6n6qpAwP4DgBCkuArQjB4nW0emNOthkfRrx6+xoQItdhmUm6eV9JERgCm10JOL0BzfcQhC1p5qKroMFwoF0PIbzmm3WWO6XIIJJOxekTilidVkKqiumLwyjjYVPALeL9FwqQ8sxeLzjtqKXLTUht6b8G8vFl/Tq9Nqf6GkPB8QIM5m8n47dVseNECLfpoYQ+IHmWukJWU1BO3NvwqkWJDU77x1tHZWrwDruQc8dagXwRTG23NJ2183+OcjyyFgRzz0ScCxudGCm2ctTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OYGDw/5c0Fp9XhOBDUpu3G6u1uwbS/Qs20xdo5FpBY=;
 b=WHxdKf1iqpwxeOnknnPmJ5OxFJpUywPy/ccXyLAf8PZvH7w2wfNq8hisPUeWFWM2vpt2T2rKnlfJMdaomQexPAzijv9xzHivTEIZL03YW1x0zVVWePiCN5FNjiXC9vP4bVLHFtw2MTGypSaTUonuk7Xhrk8xP3fEHX2IVQPBSVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 07:13:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:13:37 +0000
Message-ID: <291edb05-6bd6-4b3d-b013-6ad76e53b004@amd.com>
Date: Thu, 2 Jul 2026 09:13:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/4] drm/amdgpu: Add PASID fpriv ownership helpers
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260630134324.3118873-1-srinivasan.shanmugam@amd.com>
 <20260630134324.3118873-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260630134324.3118873-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: ef62f5c0-9e7f-4554-6425-08ded8096fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|4143699003|11063799006|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: p6I8UofAwqm0TQhLuHlPSmwlVvNy5Kej7CmAd5bf+otcjtQEUG5FHBzNPblW9SFKYqfQW/vuXO2kitblG4GoraUSTy9KIt40j4Ld3pT/ukJL1EwOXP4MYJoLQjyUEdrbv5GGhp2uo4taC6bvh0GDC0tVllfNwBjdg7jIhURwJtkMw4kN6J4cCDUA1p+HXtVb07xsV56kI0o9DRhu5s8iVBmO3G3T5+h3Xy2lvJOOhpGXwPFfkX+sEaHFpXewWOdSc8wrHCpGi4lYrLyJlOrLekaL29j491ZkxpP82fZcBfmlvFg29onrP6Mfg9kM+DwKMyVbjiDcmYiS8/WyHD4MuNJJz3auuSoHS+OhA85YELySEUD7W70xOLocdliEj2r+fuMSimL9Vp+rW29W5SyxLFAqHiwXhJbYQAHdYD0nnhQkErfL4Z/RA6W4KWuJ4tw4iN4NBseXAvvMcdaHi5MtDpqe5wnys2r38s0gmPqUWCdtnM6KDZ565HCClzOlrdefTxzLr8Qgnjb7h/Bygr5uvP2xHeH92vjyrrnoOT2urvRXJJ8vSUl3BeRa5fwlNo0PRg/1nPeKP8QXHPm0KMWXGH+pKhgzO3SUb6jL+AyiOnwV5ttRkG6Ah8lY4FfFvzZnUt7VO3ve3mWtedxf1eDX0vzirKZ/Of4gzZM1Xw52mJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzRXNEluMnZTMFRVK3hUNmMrNlJNMUZJc3ZRS0dWekdjSDNTWVJXWWRXL0xJ?=
 =?utf-8?B?OHBXUnVwYUVGL0E3UTJYNjlkZlY0UmZ4TXFnQkN0b0xSWjRReG5QLzJlUFFL?=
 =?utf-8?B?bkJxWEZRZWxXSGlzY01Vek5ZSjdLUVBzaGZvNzQwN2dBU2JERnVFTzYrZVpm?=
 =?utf-8?B?VVZyRXNhbm94ajFoS0dLek4ydkdObUdwLzVTV2Fjb2Y4alVCVXo2dWgrTXdw?=
 =?utf-8?B?QXdNWCtzdVdyNmtvQUZIQjFzUm80dVlkb2FWbk5xVnNERmpCanJNQTViQlpR?=
 =?utf-8?B?U0dDWUx1UUdlWVZiQnlxMHNZakdJWDM4aTVuWHVTSVNMZmFybUNvSlBnSGRp?=
 =?utf-8?B?cy9YQlpJMGtYV3ZEZHY4UU5xbDJsT1RJVmpCekpFbFU3dTJSNFYzcW5XWG1M?=
 =?utf-8?B?VDFXZVNhRFhBNGt6aEl4aUJEY3lvRi84QWE5VDNmd1RqRTJTbU5CYXZLU1NN?=
 =?utf-8?B?V3VkczAyeGRUaUF3MHlMVWpkVlhWaTVkYzMvdVFvaXpvQncvbWZxR3hva0FZ?=
 =?utf-8?B?SnVSVzlkZ1JyTW04bnF4UTB0L2RhRWswblBHd0J6NUsrYVFzOC9sc2lpcUlU?=
 =?utf-8?B?SnVmYXZRS004cTZiVy96ZkdBYzFjM1VaZGhRQlJ0ZHlKUE56aTBBM0RsU0lT?=
 =?utf-8?B?N0E0QzFRajljdTJFaHlUWmt4UVBwcGpGaUxBM2djN24ra0pVanZmWkllVFZz?=
 =?utf-8?B?eWpkZkVUTmJDWVJnNUlEQldRYnFjVHc4NHk4U3Z4b3IxdTQ4MzNQOGJYL1BV?=
 =?utf-8?B?Wi9vaHJUQllMY0JQU1NBb2JZRTlkaXhYWldMU3Q0N1lKR3V2aTc4cFhnL1RW?=
 =?utf-8?B?Z052bDhOMkdleit3ZlFXVmhieE14N3R4bVNFUWZobkJKaS96S285NUExek9F?=
 =?utf-8?B?NXUrSlpMTFp0TVVjL1RpcXhwNkRDNW55c0V5UElreEFLNjZpYU1JOENiT0k3?=
 =?utf-8?B?SnRWamlzNUk2ZVgvaENielBzNGE0b2VuWTZ1VnJtaUxwWG5xZjF5TjM3d1dU?=
 =?utf-8?B?c0Y2MkZ5NnhyQTh4dWh3NXdBL1RrNENteGhVSEFEQnBSeDMvVGd0cnA0TERZ?=
 =?utf-8?B?alc4bUgrd1lTRzVUdG1Jc1JTNGpKS05KaDFuNDEzaG5MZFdhNHNKaTIzaE0z?=
 =?utf-8?B?ZnBGSEpMZXR0RnVwMi8vRG9jT2o1S3FSTVlDdHhGeUZvREFMNWJDREdHRm44?=
 =?utf-8?B?UE1UUHNHcjNqcTh6cldBZjJobEJaMmR6M1U3bzZJblNyUUhIM3pEcDR6Qld0?=
 =?utf-8?B?RytFVWE5VUpUSDNZYlQ0VUYya0dna0RIUk9qSzUxdWlPVDRaMU5OQnNrSUxX?=
 =?utf-8?B?Nis1VGNUVUNPRUNhblpUK0NDQ2tSeUpmb2hWSEZKV2pabWVhWEJMMDY2eW1Y?=
 =?utf-8?B?QUs4bUdQK0M4L0lwd0ZIUzNYQWxhL0NlVm1pUWtRNjNRZDN3UFZEZlI0bENp?=
 =?utf-8?B?VndDdGh5aWlQWkhIbUIxejVPcS9GNTl2bDBXbjRCSTB4d0U0VkpGSW5wcmZl?=
 =?utf-8?B?blV1bzNpMHYxd3A5WTR4NStiYUl0UTV3RlA2TWdoVlptSVpsKzNzVFJqK1M2?=
 =?utf-8?B?SGd1N2VocGpDM2xweTNOY1ZpVjhsMzRnWnJoT2VCelYvamNqVjlQNUZaVXJT?=
 =?utf-8?B?MWxqeFJISjl2ZlVjSnJaU255SE0wTmtMazlaRXhPNEdTM3RRY1o1K1lnRUda?=
 =?utf-8?B?bDVyUjduVEw4ZXovdFpiOGIwSXB1U3ZLclJaNUVLdjJ1M0lLWjg4T2VnQ1cx?=
 =?utf-8?B?c251b0FQdlZDeC9HYStqaFRVRmVwNytxaTUzMHhWdDRWYVpYUGQ3VktGU1hQ?=
 =?utf-8?B?aWt4NzIrZW1GOEF0dzJqUHRUNEJLWEtUdDBZMHp0dGlVN20zK3hla00wQ0R3?=
 =?utf-8?B?Z2tiT1JJMlRIamwzZ3hiRlBRRHkwNUltQkJVRjc3TFhmWHZ3aVFodjZJMTJR?=
 =?utf-8?B?VFhvbkt2aXFtV1ppTitxRGM2RVhNbUs3T1RCY05hV1lOWnF3M1QxYlltYlN0?=
 =?utf-8?B?QzZGTkxZbU9KQmpVVk9USmpNUWlzam1mcDFKc0p4QXFuQlRZQXhJdzFjMkox?=
 =?utf-8?B?cFJjY0xYaFg2dllwZ1NURmdsbm9rcVVSYjlNNzZWSWRNazN3ZnZHaE10a29W?=
 =?utf-8?B?NVVQMlVzcGVHNjhjOGZTK1VTc3dkUTNMRmgxRjFrT3hzcjZrMWF4R1JpUWR6?=
 =?utf-8?B?V0xrM3RSaGp3bGcwaVlLTlFXZVBodnJBeThMK1BKVG9ldlJwcjhSemoxRWFX?=
 =?utf-8?B?d20zemw0STNsQXkvcUM2M1VyOEhoMGR3dDkyS1VCWi9QblIzNklLTnNwUjB1?=
 =?utf-8?Q?RnSkCqqMYpD+JJim1L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef62f5c0-9e7f-4554-6425-08ded8096fc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:13:37.6526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDiw5+8tiyLYxF8sgzXhVhKuX5nY13J/midEDC/wQzItV3WHX+uTvrf9NpYrNveW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
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

On 6/30/26 15:43, Srinivasan Shanmugam wrote:
> AMDGPU already has a global PASID xarray used by the PASID allocator.
> 
> Currently allocated PASIDs store a dummy value in that xarray.
> 
> Add helper functions so DRM-owned PASIDs can store and retrieve their
> owning DRM file-private object.
> 
> This prepares for using:
> 
> 	PASID -> fpriv -> vm
> 
> instead of the separate per-device:
> 
> 	PASID -> vm
> 
> mapping.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 91 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 13 ++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 684f40fce73f..f65d57b4cc04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -78,6 +78,97 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  	return pasid;
>  }
>  
> +int amdgpu_pasid_set_fpriv(u32 pasid,
> +			   struct amdgpu_fpriv *fpriv)

What exactly is the reason that this isn't part of the amdgpu_pasid_alloc() function?

Regards,
Christian.

> +{
> +	unsigned long flags;
> +	void *entry;
> +	int r = 0;
> +
> +	if (!pasid || !fpriv)
> +		return -EINVAL;
> +
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +
> +	entry = xa_load(&amdgpu_pasid_xa, pasid);
> +
> +	if (!entry) {
> +		r = -ENOENT;
> +		goto unlock;
> +	}
> +
> +	if (!xa_is_value(entry)) {
> +		r = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	entry = __xa_store(&amdgpu_pasid_xa, pasid,
> +			   fpriv, GFP_ATOMIC);
> +	r = xa_err(entry);
> +
> +unlock:
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
> +
> +	return r;
> +}
> +
> +void amdgpu_pasid_clear_fpriv(u32 pasid,
> +			      struct amdgpu_fpriv *fpriv)
> +{
> +	unsigned long flags;
> +	void *entry;
> +
> +	if (!pasid || !fpriv)
> +		return;
> +
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +
> +	entry = xa_load(&amdgpu_pasid_xa, pasid);
> +
> +	if (entry == fpriv)
> +		__xa_store(&amdgpu_pasid_xa,
> +			   pasid,
> +			   xa_mk_value(0),
> +			   GFP_ATOMIC);
> +
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
> +}
> +
> +void amdgpu_pasid_lock(unsigned long *flags)
> +{
> +	xa_lock_irqsave(&amdgpu_pasid_xa, *flags);
> +}
> +
> +void amdgpu_pasid_unlock(unsigned long flags)
> +{
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
> +}
> +
> +/**
> + * amdgpu_pasid_get_fpriv_locked - get fpriv from PASID
> + * @pasid: PASID to resolve
> + *
> + * Caller must hold the PASID XA lock.
> + *
> + * The returned pointer is only protected by the PASID XA lock.
> + * Callers must not continue using it after dropping the lock
> + * unless additional lifetime protection exists.
> + *
> + * This intentionally does not add kref/RCU lifetime handling.
> + */
> +	struct amdgpu_fpriv *
> +amdgpu_pasid_get_fpriv_locked(u32 pasid)
> +{
> +	void *entry;
> +
> +	entry = xa_load(&amdgpu_pasid_xa, pasid);
> +
> +	if (!entry || xa_is_value(entry))
> +		return NULL;
> +
> +	return entry;
> +}
> +
>  /**
>   * amdgpu_pasid_free - Free a PASID
>   * @pasid: PASID to free
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index a57919478d3b..220a0ba0cfb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -38,6 +38,7 @@ struct amdgpu_vm;
>  struct amdgpu_ring;
>  struct amdgpu_sync;
>  struct amdgpu_job;
> +struct amdgpu_fpriv;
>  
>  struct amdgpu_vmid {
>  	struct list_head	list;
> @@ -92,4 +93,16 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
>  
> +int amdgpu_pasid_set_fpriv(u32 pasid,
> +			   struct amdgpu_fpriv *fpriv);
> +
> +void amdgpu_pasid_clear_fpriv(u32 pasid,
> +			      struct amdgpu_fpriv *fpriv);
> +
> +void amdgpu_pasid_lock(unsigned long *flags);
> +void amdgpu_pasid_unlock(unsigned long flags);
> +
> +struct amdgpu_fpriv *
> +amdgpu_pasid_get_fpriv_locked(u32 pasid);
> +
>  #endif

