Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CD1C44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 09:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A9C10E6A6;
	Tue, 14 Jul 2026 09:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P8dXtvgG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD6B10E04D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 09:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xi3d8SeKF5sQOlTZdcTKD9AKj/jOto+OYj2kL+84hkGTla4gorEVFupQWuLsVPX+sGWrX2g/99KWeAfQlYmRgv2T4MZ9+Ic955ILETDa1E97ny47gPQdCZXBOdlgbeKIMqx3ljNwgAq8hM2DtXGUmPRYW4d2irqnLczkReXegwpXJn8lnRv/wUyNGZ7xwz3KY6vvGPhvcvwgeuFO+AxBZzhRsd/erNnEYB8UxQNcs4oe/CNgXfYFzlEeBW7ltGzIOHATWv51WvQFxnPKtntbZfFbEqUapgk4ucTdvzLyz1n77NqK4YCFJmZsafufrI/ipcbolg/SWAwOGJqZbWEUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HGFrc3FOofYUWC72J8piNf1KM1L9PgGEPImfAACIig=;
 b=v/iket8MKqQLSa/p/oPxIAyuafcs5yTdj/VpZVDITYtlAmnbC49mNDiD8hYjG3cMqoPl6Lv8I+x1jHUCV3vb9Luth/1v9rDK5B+xGSHPCX4wnxRoQL45lSrit+kO2+sG2wnrLLDYXi68+a0qGiCU5M9hk70Zx2K/9FFUBeyAbYcHt8piNlt+uaBjbQn1TTwaxI03DozDmgz7J7dY47eGxeHSe1e0H6/R9kI28jg8lIBHT21RMzIgajEpkU/zqlGomB686jAZ55VECLVC868wwYG2It1I5STuer00jY6S7mCAlHgq4fF/KHfBr39s55mjj6b2xYtTzPW2fYQKcMGMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HGFrc3FOofYUWC72J8piNf1KM1L9PgGEPImfAACIig=;
 b=P8dXtvgG2BWyI62kSzQFpSGvp9w+GQrikzxmatcKBPNYXGJXN6G6wYq4V4mwu3p3jGoru4/VmgnYy9mThcFi7c8lNnJdQnJ2hajrwRrSryV2vAX8T0lqq/0KpAVbLdZsQ03pJtDp+B5Vgpq/McItcez7L6mMxlSVbAKxEL9E04I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 09:28:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:28:25 +0000
Message-ID: <89797211-c4fa-4ac3-94ce-7af6ae65509c@amd.com>
Date: Tue, 14 Jul 2026 11:28:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
 <20260714080220.3395155-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260714080220.3395155-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: fc55778b-11c9-4d47-30ee-08dee18a4175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: ledtQXHH9JgqbYRmuX9YUIJEJunAfBupr6S6aow8ipfvPufGfmyArj7TVYT/FUHiapPiYlUOUJn9UtY5s18L5uAl5ni736pRzeZ7LUhQ0j/qIoVlMjJQJB5ZrfGzHYqT/PUVX3qUQtmmfrJM37I7ClzkNfVZDTzQ1MgMumZmoN1DzZQD0unhk0thlN4RBfvVkEAyLsTsAwj+kMyxJLYmIz2u5sG5fztiwt7ayG4POOVu8VqVwNnPASDPwPe74L9DboN5FQF71Nht0aNY8ypFNd1rWnz1zAhZHqj21+NrQ1XqHpvtaacoTyQChCl+lCotQbVxFleopGAyYh12UNF6vrCdcTh63EEfjtbKMmbPogQzS0nMBT/iBwTRolSO//Xr52qOEip1Zh6XjEEEIFxrEUt8jkREAJp1IDxMkvd54WFcBqNGHRG82Wnnw0nR/OqNZCW83IURaFPHHHnceXKG/bUCLhkC42OGkNUB5mjH+8Ykb9PYhBcyWeL1A/x4KOkwd/2+8UwuSF36YvWxhapBetjZJjPZUg1+Ew6Dx3BkoOWLFNXV9BgHv7rl6eJvdGF1E6mbj5NxWZ6Ntbu+SK04wo+c+2bgSjjr/tW1S/WyyZCguY7qWdd9HUL8H0czKPpMRmc7u8b26Aq1rDgQbXFSnfyhHMhOCsFE3VzEY28m6iE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlORFJZZk54Nlo5azhpL1Z1ZUd5bFBPV1FYVGF1NFVmMTdXTHNJME1vMUJt?=
 =?utf-8?B?Q0xQdHA3bkFUM2MzTWF6aVorMWdURE5Fb21pdVpPVWNpczhNZVpsWmhYRmN3?=
 =?utf-8?B?VG14cm5McXlqNk40UTIwV3B0cWl0Sk9tak5GNnc2M2Vzd2MvVXVwZDJRNTdk?=
 =?utf-8?B?ODZnWnZucnlwYlp4aG4vMXB2SkI1b3hGbSs5Qm02MzRRTzBXOUJaUmVIT2cr?=
 =?utf-8?B?Z2VhQk8zUnhqRUF5MlJURlN3NjhhUEpQQTdVRWVvQjVCOFl3d1NodVBqU0dk?=
 =?utf-8?B?dFlyU1kzSU1ITkFSakZVMVJLMzVCa1NaU2IxTXRkcTcvNVNlWHY3WjhScEth?=
 =?utf-8?B?MXBEeVgvSThDTUNPVjNBM3IwWGtSRUhyQzNBaUdYU0xKalVGUGNsSVFFWlph?=
 =?utf-8?B?UHgyaDM0eHp5VTRKNWRTUzFZY2NqcTlKS1BINW81YllDaUxuYi8yU1NuZkMv?=
 =?utf-8?B?c1hJWnVlYkQxOEkzSk0zdXhMb1R1K1l3SGp6SG01ZDhhODB1dnpVaFM5Rlpk?=
 =?utf-8?B?Q2dQa0lWei9od1JJKzhXWEtTbHQ4bXFrWUt6SHJnZ0FJbFVoam5IT3JjbEN3?=
 =?utf-8?B?V1J0QkVYVjZsSU5LWlUrY21VQnhsVkhabGo3NUtuTE0xaDhtaWJ6dFJCWTFz?=
 =?utf-8?B?cU5WRWk1aFZoRTdIOHU0NDBRaE1kQlVJTkxCRWZnRlYxOE8wL2Nvd1pocWRp?=
 =?utf-8?B?OXNNcksva2RQSlN6a3h4UDkva3ZnUHdtRHhHeWhWK292Vm1hcHA4eXpjRUtK?=
 =?utf-8?B?NVoxR0dEZjZlY1o4VjJXT3lJODQveS9weDJESEltSUR5Q0dMbVovczFVc2Q1?=
 =?utf-8?B?aUg4M1dpNHVjbEpjdzc1TDdYaUlkdVU1UENUcjhlWldXaEYySjAyQTIyYVBi?=
 =?utf-8?B?cGtMMi80akZGWWhWSy91VVNmK2ZmVGJlVWRoN3VRcVYvdXY3VHZsWjlFRlRO?=
 =?utf-8?B?L3FRS1NzenRWVGdacVQzelVSREJaOEZrVkdHYzFTTms4SUxobEx0SVBzVkN0?=
 =?utf-8?B?M0FDdUJVVnNVeDZVV0xYdFp6K0xJUUw3MnVQQlpuRDI4dC9FYmJUT0s0WmpE?=
 =?utf-8?B?dTQ3QUlFYVVEVmxZMjdXYW9qcG11WUJyVGFHZGVEc00vSSt6R2FVODJzOC9E?=
 =?utf-8?B?V3ZpV05zVTg3SmlYVW9PZDZJeTZGMXNDWjJLRW9LTGNQTHhQOFRsaTROSjUx?=
 =?utf-8?B?dDBRNFhWbzhFRS9yNnFzZjd0K200ZEFhS0dnV1FldnVCczFvU2hRbHhOSWR2?=
 =?utf-8?B?V1d1eHNPRDVEc1VQOWxQVEErWFNzRVVNTkFwQnlOS2VaMUxVMS95bHVxcUxw?=
 =?utf-8?B?UVNmRkh1YkdWYlQwN1hkdUVHSTl2Q3pKTml4MUxvTHVJUW1lTERuWWowdjdS?=
 =?utf-8?B?NW95SmNxc3VIT3JtS0Vjdk03THFHZXNjVEU1aHlLcjBkZVgyKzR6R3laMlYr?=
 =?utf-8?B?YmNOMklraytreTFqVm45QTZoTmcxWUdZU0VlcDRRamwxV2VONk5oQ09DdW1k?=
 =?utf-8?B?OGxwTFFWNjhEMHRKaGJRLzRjRmpndUZHdVZQN241VTBHamMvc1ZGekNVQjdo?=
 =?utf-8?B?T0daaWJVdm1DUUlIbEw2VGJqalFjS1FFc3Z3Ky80UnlIMUNTcldybXpURnJI?=
 =?utf-8?B?SWpKWmlubzZWUnBmTVJVemZLUTV1aUYvSFFkSXJzWU9KaUFyb3hMcSsxWlNp?=
 =?utf-8?B?N3ozK1JEb0J0dEdGSENXRHE0Z1Z0VlpsemEyMVJtRDFmenY4WEo5RnNQYjRu?=
 =?utf-8?B?c1RsUUExRlM2NnNjN2tWTHR6NnRidmZ4T2ptNFllMktrMDdwS0tjcXdTRmZM?=
 =?utf-8?B?NnFSayswVTcyZ0pSb0xWOU9KN2pmcFBjVDFwckIwTTVzYUNIcTFzMW1ZN0xZ?=
 =?utf-8?B?dWFpazFMWmc5L1BTMTFDaVVYTG1PdmxGdldMdHhvMzNrYlpzMFZFVFQ4VUhQ?=
 =?utf-8?B?ZnVpMVE2MWRDVjViMEhXS3gzenBIT1QxeThQZDRpZ0NiVGl6SFpMRXhUN3hG?=
 =?utf-8?B?Q3JCVUtZRUEyTXM5Y2NjM2xmTUNEODVET3FLRWpIQ3Vpa0VDWTkvZE5kdW5L?=
 =?utf-8?B?Y0RPdW9jdnRwc3JCSzA4WWJVb1FYNmt5SnMvTU51blJHUE1tTUo2ektWR3pC?=
 =?utf-8?B?a0pDYmJ3eGRQeUQwQ3Q5a2I2YkRmblZpOEJFVFRWc1J1L2RETERxd25WQ2px?=
 =?utf-8?B?d0pHK0NwSWpHenQ3cmplSWxEYjhTS0lzUGdZV0FtQWlscm5vT1hjNGtnVFdi?=
 =?utf-8?B?T3dzZHN1NjA1OHV0MUhBMjNFQktnTjFodk15ZXhWQUtlUGRwU2p2dGxLcTJk?=
 =?utf-8?Q?etxK1qi3iI42I1et6N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc55778b-11c9-4d47-30ee-08dee18a4175
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:28:25.5945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXYaTHDiCxZaVwuaWRWdwAWNtmzxD0cuK7nybUc6R/Kc5cQqwESTGhNFKwUIS6rE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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



On 7/14/26 10:02, Srinivasan Shanmugam wrote:
> Signal USERQ_EOP EVENTFD subscriptions from the USERQ interrupt path.
> 
> The EOP interrupt already identifies the queue that completed. Use the
> queue object directly to notify matching EVENTFD subscribers.
> 
> Routing notifications through the queue object keeps delivery tied to
> the queue instance that generated the completion event, avoiding
> ambiguities from reused queue identifiers or doorbell indices.
> 
> EVENTFD remains notification-only and carries no event payload.
> 
> v2: (per Christian)
> - Move USERQ_EOP EVENTFD signaling into amdgpu_userq_process_fence_irq().
> - Reuse the existing doorbell-to-queue lookup instead of duplicating it
>   in the interrupt handler.
> - Keep fence processing and EVENTFD notification handling together in a
>   single helper.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index fbf783946f6d..ab3ef3a9f655 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -215,6 +215,7 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>  {
>  	struct xarray *xa = &adev->userq_doorbell_xa;
>  	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_eventfd_mgr *eventfd_mgr;
>  	unsigned long flags;
>  	int r;
>  
> @@ -232,6 +233,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>  		/* Restart the timer when there are still fences pending */
>  		if (r == 1)
>  			amdgpu_userq_start_hang_detect_work(queue);
> +
> +		eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
> +		amdgpu_eventfd_signal(eventfd_mgr,
> +				      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
> +				      queue);
>  	}
>  	xa_unlock_irqrestore(xa, flags);
>  }

