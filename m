Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E6AFED2FC
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 10:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ECED10E9BF;
	Thu, 12 Mar 2026 10:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yYoaJo/K";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A5A10E9BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 10:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqYDYc409ABmheM+nTbsHNSihB9OOAfdPmKy4eu3f8uv7pOyln5BaFAtgKUwGbfW6/3sG/Sy/Oi4/n97Qwny4ie91FGHLj+lKJ/vOOw1kzsCS7OPWwO7Ki+JV2NzI0jOGiCq+NKI2KWa2Mk02fKL13zy6hWQTrQobf16IYFf68Op+0GCZKGHLE8EBzSLn/7p/hC9RzhVix3ssU8dF8wHjsEE7sdcCnqAzIa9ePWe/Br7GixKVBdq6uyRxz1K7WLaSuce7uTD3yecyfDanGirfIQWt+5u2CERhE92qrv36fDQB4b/gf080bU4ACtPwxBJo8tNtYI61xu6ks3yevbyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcPh31/KmmNLUSu9m75rDXLjC2+XuGHeWwwoDU3xNTU=;
 b=H6hlJSm2tiEPLo+ywb6LKPiDYSrjWrXuBt1fKEMtbAyBEoIuU0FRw4z1gjgjbOC4ylwPojyJRaCo7iqGUPdNwcDXrjtAs4bQaLybSsEsJjYnaWMxXvBvJeTeF+VlyPIxK4s3UfF4tRHaNyttbKUOEzr4dv6LoynDJ6h3yeM/ur/mXXwzH7l/1DbVeXBR+mt5FpD4rqUBqaiKc7pn62zZhCa2JRU17AnkHApxnIVf7/2rjJTnQv8ORIDiQVR7ig8IVUrOrikXI5aW1qD24DwDJfp+WVMvi292LJymSx4XOru9WG5SMgBWikcft0DJ6Jj95VUTglUnnDT4FocJbOj+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcPh31/KmmNLUSu9m75rDXLjC2+XuGHeWwwoDU3xNTU=;
 b=yYoaJo/KnHz8KbKEgI+qwtZQ/5Z86fjXcg+zjQSDUBFzgFEndNiW6vMkHYHQJ+XMgPMLWdqH+F/kI0T+gBzXIoD0S7Tk4CHYY56CcJ6wHTPeRFFLNW5SStnfSM6IiLMKIHPztwV3rxGtIn2yFta6biCSBKYEaV1RxdE4uVQ28ow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 10:14:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 10:14:58 +0000
Message-ID: <31bfc322-131a-484e-8d3d-0133017da405@amd.com>
Date: Thu, 12 Mar 2026 11:14:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Limit BO list entry count to prevent
 resource exhaustion
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260312101334.1500935-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260312101334.1500935-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0423.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b2a10a-db39-4f3b-a1c8-08de802036db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: RTATbzrn1GcT7/aqNta40hRfNQNmyEaoOVCSTTLUBNrT00gpK/vb9gIyBQVe8e1hNM8zuW1kxeD1eIS98hrub6Ec20TIUytX0hXWQxkcjlSnDctyf7vmJzP4/VXsPBQG/f0D21jl4mG0FbuimqPYiCPdoLTWGPkZ1Dy9tDx9Strf3KBiiwBvJHnuoBe2E0HrGWwpgqo2BnuSX0GxDgg4iV1hogBQ4pRx2+lfBH9dSdTnBicSYi6b3PWFfkLDAO21iSERub2hzejCSdA2HcZXXadlkhWgJPqRFegU7k11twvWyL5iD7yg4BJ0FHvM09Rvs8fpoJ8gY3Tpv2bLODtwkD0wCwOXmrLna40TbW6tiztjxti2HvYGIvgiPt+Dpi8dY8YVj86RFIk0xfG7ZfPYMbnrh5Vrh8IO/t/vVQTXS40FnOFlSbj4+56GqqChI5sL6jsmWHT7QF9Y9LP2TxGOhuUEcofY2w0rHBuFUv229SHx/3RyjDJkx4H95Qj2cyOcEp5s4qj225APsUVC5Scq9vv7PVR1F6wdShFEvTcdHHdEThO9eI/3gdz+VosNjYaTTox+DH/eCbDjOYpWdUz/gT6v1oGFYbZdqAj1uoVClMA3Oq5N0cmKdeAk+U0RuSPtmxrmXywfEiaVe7HTpG1hJGb5lQ2jGWbQDlztmUeb0X/WPvuiBEWUPiqKlet9voFaHgV6QbHKg2qjrK1aOc/NlOfvFj5nnqcOd2uWPAiVEjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUcyUFV0QXVndGUzcGpzYlZlb1VsVnQrOXZsS3YrTGx5cDJxSEcyRWt3MVlU?=
 =?utf-8?B?aW1WRG1reUFRRGpDZnp4Z2VqUEd3NFQ5aEdMaUhKQytNcDIrUDBkcjBhejMw?=
 =?utf-8?B?MFBycy9mRWNXcllwcmkzSEpram84Yzd3bWZueDJEVFlFMmxBQms2T0ZlQlVj?=
 =?utf-8?B?OEovRzlnanZZU2o3MkdpcVY2dVlSQUxFN3NNRm05VXdLNy9FNWd0SFhEYy9J?=
 =?utf-8?B?enQzMHVTR2JRbXQ3U0liMzgyQzNJZFFHWGtRaDBtN1NiU0VleVpBR3BCYWtJ?=
 =?utf-8?B?eE5Ka1cwSWpPM1JZS2FmbE9lbDczMHR0ZTJ2MlZQWXJnaGlsYUsxcnNmeTZY?=
 =?utf-8?B?bkg3Z2FkQ3FrNDlpT1J4ZmRtZzIvOGhsS2xwQkFPV0k0alJqWjlheFVROW1I?=
 =?utf-8?B?TGo4Skt6c1JnZk1peTcvbGNSQWkxKzVrT21mWGNwOVBjVEpTZ1hmOGR4dmQ2?=
 =?utf-8?B?RVpBZzFNcVRiMUIzWFQ3OGV5UXRsMVJmTndhNUk5eVNoa253dXhNY1RZZmtC?=
 =?utf-8?B?Q2lxUk5JSmVsbjVhS2picjBQbFA3MFg0V2xSL1puWjlwcTVrTjBIY0lONFRW?=
 =?utf-8?B?RWRtUWhjODhSRTJROHlPbEh6K1ZjUEVibzR2UjE1b1hoeDhvQjAyeW9PcWh2?=
 =?utf-8?B?ajd5V2ZHZjlxZzN2U3Z3b3phSmx1T1VNaDdZUXJLSzVGcVNNMHFuNWZyK1hY?=
 =?utf-8?B?MXU1UzV1U2lHQU5kZ25uS3Qya0hUTXpEZVMwTWk4OVdnYWd1NTVCT0dHMmwr?=
 =?utf-8?B?SGNrV2tnSG5ITlVTejh4YUdCRFZWVlBkOUV6NlZGa05MUldXYk1mN2RlRjVY?=
 =?utf-8?B?d1Z3bEFBeHFhRDBVaTFrYVNzOGlzcnRtMlVBUmN5ZFNyWWRScVhUK1FIWHJ1?=
 =?utf-8?B?dTRVQTNkS3VUOS8rRGZZeE5PbkJjVkpGRy9oazZqN0JUMDlrNVFGSUN3Q0ox?=
 =?utf-8?B?cTE2ZmRpZG1iU0FiRTNJaUo4dVdESStpVUhNTG9yV0VRMnFma1NVcWhNRjhi?=
 =?utf-8?B?SzBwZmp2Z2pBL0pucE5wOWdPK3dnK2dBRVoyVFJXNWtVVGRrcnp5QjVzSGls?=
 =?utf-8?B?Vi9NWlUyNHB0VTdPRnQ0V1hWTlE0ZThkQjBOYWZ0MGlYRFBlOGFPaFBxSmpV?=
 =?utf-8?B?MTA1T1ZjZTRJajV1K1ZqMXA2UjJ3dXhaSlR1SHdtTXFFTkttd2JqVVcyQjcv?=
 =?utf-8?B?ZHl0L2dnOW4wMGFlbmF0Wm5sbVBGc0p6OFpqU1JzazRVME9YVVdKMEQrMzdk?=
 =?utf-8?B?RnN3anJTM0Rxa0x4Zm1lV2t6MGpSdHFVY1RpTFZ5U3hVWTB0YmVicWFSdjNx?=
 =?utf-8?B?WDZxdW1sbVhFSEk5RFRKMk9JZUYzaVhKbEhBVUt3K0tzc3lBUWttYmQ2RjlD?=
 =?utf-8?B?OHIrSmdlOGJtYzZQR3ZXYk45MnUyRlUzL3NEbzRFWmwwY29pK0RkWlNmeGVt?=
 =?utf-8?B?M3BtMjcyZEwzeHJrREV2NHlLMGgwWUxqdEtDdHU1VXlOaFFTT2xVL2xJaXha?=
 =?utf-8?B?UkFVQ2d2c2R5eDBCWHZEbUY3dlNEZk5TcXB1NUppVjRTVGpobjY2WU9sWVRK?=
 =?utf-8?B?ZGZCZytESWowRk5Xb0drNWpkRVJReWVHSWlGYjE0cGI4NHNrQUZhb2k0ZHZx?=
 =?utf-8?B?dVVMc3ErODI5MkFJVjRuQ01xTjhqWGo4R0xVdHEvSzNwd3IyRHkvSkFoaktS?=
 =?utf-8?B?N25UQ283V3RMT1llajFkSEIrc2p6WXAxOTR6QTVVZHY0ODRNSFltbXExZTVT?=
 =?utf-8?B?RVRrUk0yVFNINnlzNmJKdEhtalZvOGcwYUsrRGc3M3ZQQ1M3ZkV5RklLNDVD?=
 =?utf-8?B?cUhOekNobmZZNGNmS1ZhbjFFb2RLR2t3SE9ON0l3QStQSDNDNDlUTGxrT0tH?=
 =?utf-8?B?ODA3bFhCcEwyQ2k0V3pLYmRMYlExZHhTaFM1VE8vK3pLYlZDY3pWNHlBWERj?=
 =?utf-8?B?TktxeXpQNHNlWmlRckRrWjRHMEY0TE9Qa2RNb1k1UzBmYTA5S2xEV0JENVc4?=
 =?utf-8?B?T1UvU2lrL2R5ZUNIcW8xMWhYL0Z6aUNWREg5ZW0xMlhkQkhlbWFMWW01eXFU?=
 =?utf-8?B?V0ZrLzB1Si9xdnh4b2RhTkFzelR6c3VId1d0YWJhU3lvSGUycTJ3Zndrdk54?=
 =?utf-8?B?MzJWQUJGRVF2ckVLTkhMcUhnRXRvYVg0Z2tTWXJRRURJN2wxSjRab3hVWG1R?=
 =?utf-8?B?MUwzNjFXWUdSb0JDQnVxTlhwYzdFVWJoYUpEZ05aaGZ4RmM3MndOaHVmUERD?=
 =?utf-8?B?eVd3WXR4eW1oYVFxYWVodTgzVkJUSlNteTBEU3BPSXo0UndnNGdCSXJxc25p?=
 =?utf-8?Q?pqcMrtMn8a/PL0ebHr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b2a10a-db39-4f3b-a1c8-08de802036db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:14:58.2246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZmP9L62jcalE+EuPQl9LPeWavIMk47peoNEJo+TdNoGJH+FCK8p0pLrdytXH8Ng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
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

On 3/12/26 11:13, Jesse.Zhang wrote:
> Userspace can pass an arbitrary number of BO list entries via the
> bo_number field. Although the previous multiplication overflow check
> prevents out-of-bounds allocation, a large number of entries could still
> cause excessive memory allocation (up to potentially gigabytes) and
> unnecessarily long list processing times.
> 
> Introduce a hard limit of 128k entries per BO list, which is more than
> sufficient for any realistic use case (e.g., a single list containing all
> buffers in a large scene). This prevents memory exhaustion attacks and
> ensures predictable performance.
> 
> Return -EINVAL if the requested entry count exceeds the limit
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 87ec46c56a6e..3270ea50bdc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -36,6 +36,7 @@
>  
>  #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
>  #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
> +#define AMDGPU_BO_LIST_MAX_ENTRIES	(128 * 1024)
>  
>  static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
>  {
> @@ -188,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  	const uint32_t bo_number = in->bo_number;
>  	struct drm_amdgpu_bo_list_entry *info;
>  
> +	if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
> +		return -EINVAL;
> +
>  	/* copy the handle array from userspace to a kernel buffer */
>  	if (likely(info_size == bo_info_size)) {
>  		info = vmemdup_array_user(uptr, bo_number, info_size);

