Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924C5CC6B16
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 15:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 107DE10E0DF;
	Tue, 13 Oct 2026 15:52:54 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107BF10E0DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 15:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dU6183QOm1OQ2shQIirbloM+rKb6Dj7QLuXd970ypoYIIJ3V4OKO5/uly87LSkpKh6W4XcD5ERtrrxomkHEDc+h4BpghT2VQ8Od7C7+f7ps+DKvpyqIQWmvmzNhyOtN5aQhHdmq4StLXDyq3qvoznO1nFNktAHijVdrTZn46vYk8DibDKTvTLEy5uWTfZGwUoNAU2QMjwroBW4cIbBQEsI6LYxSZeZDYtYlK+tIByZseqopDDGBvE4iZim9zkaziBeG1h6S4IkzCpax7WZoBw1EbBMqkZFWJrdd5U4Ijy6ta5o0037zwQIYi9fbKnce19fIVs5p2CWuJYCTnw5Ib9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aT6WtUGT+p+gKwIlmAhO8PASs8I0POzBlfVthgKX0w=;
 b=Bux1rgruFmsZzbOq8IkQtYh3lsGpR5D/FbQLHNU6Qw1AJTdhBhI5Q3UE06bWJcBA869JjLeCrtkMPJvOaVRd7ieswZes5j2JPe0KzwQGDJnoQ9cFeLE7OUn5zHIgkEhHHO9JCNTwEmCLPPuzxYFyKxd9/1y1m9eYYbHRXOkjdv75hbfo0fvoCrZdo40RTYr6qplcxqqf+bKDmrmtbemmdB2C6/v5J4HsovddaQhCvN17R5VgEqOjBDEZyG/iWheTDhXXt8X1yNISjpjQffJZAaEoMvVA7FUeqBiOvk0mANrCkjhUX8/hX5ZsMX6ny26bZYW1cl/eOPz3zygR+8lDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aT6WtUGT+p+gKwIlmAhO8PASs8I0POzBlfVthgKX0w=;
 b=0u/EsLCrajQ2PRWYImxxmuJ52FBygLj4888mxUcM7Ly3ZhQ7CE6T4VOcPguuJg+MbwUiZyZm8GReoR8tWjtZtJ1VOdSzOnYLRLcdXwZPlKMNGjwGQ3XvlJ75biiZJmtQTENnzXhge3Spd+OntjQuT/O9hgJIPYjLVR9XIBzyOOg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 15:52:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 15:52:44 +0000
Message-ID: <5555d424-1e05-404b-aed5-e36163685a48@amd.com>
Date: Tue, 13 Oct 2026 17:52:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/userq: actually validate userq BOs
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261009154651.632259-1-benjamin.cheng@amd.com>
 <20261013154716.1951333-1-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013154716.1951333-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f40aab6-85bd-4611-14c7-08df29420527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|10067099003|18002099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mu6VRpvIwgZDGRkWWqIiHKrGNAsLD4PdIXmRD7j2OmXM1RDNG/6YiNZLG5996bXGcH9ziSKaLycnDv2jDmRcUPKyrMVJragaUe7FU8VCR6C4d9yXW1wAqIppqfcQCbmCb7EZN3/NmARTrEhmrk5lQC46UJvIhWi6H9lW2htr1SJbp9jQJcf0Ug2nesZa1wdXaRDdU3Bmh/hR97PzTYalmR7JM2SamM1eJcaDdeRX5fQWtOxCdZSegJ09dOgPgDhbUnyamEIJ1gvTF1SOrIWB9ajljOrOAJuc9yIcyEBKR7IVxIYH7luOCRHrJjzIVRKSZCQD59T7XfdTxpRwMH5AooUnEcd64vvGZSDQS/r8/q/GeeKZmJiriEirGyz4duLzbXm4iJ6NVa2ndnk2vsbRsk1ExAHGDUWP+TsRxVHg0qYY7cDkBikCC+HYbPq6mYX+IEL2FRNbsu8wxXiGi6ao6/zn0wXaZj+btdqERwas4FB+EScZad5spy8Mbakq0wtHu2KatgHU/ItaVNX2b5t4X1yULV+PCO1RQPkctaMkjhkTaUSZt5DzGlDqPQVE+Ky3vDnWgJ7HcUyKVS07HabDL7tlUEO+5ibcgq8zvWlPH1nwD1DRkPWyRyi96NDIut62YFbQ2aCeg6jUqqvPAtNNguOXdfgbt/zN1O8+CY0hbRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(10067099003)(18002099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGRWeXNtVVNvUzg1a1Q5ZXMveU12TndTKzBJY083R1BnQ2FHeGVjSlpWb0hM?=
 =?utf-8?B?ejI5S2I1K2tzd0pJSG9qQVdPbHBXSkIyVkJtK2ZXZEozYTVwMzh3QlFLUUJj?=
 =?utf-8?B?b2hUbUE1cGRTL2UrZVNBYVptT2Uxd1JqeWE2aTUxbkxoMWtCMEVIQXFCWXI2?=
 =?utf-8?B?TkZFb0ZGbEFuUndGZTRpaTRlUFdKY3lMRVZxaldyQUNqTWFnYnpJZ1BhOFdT?=
 =?utf-8?B?V04rNFpjbEpkWXE0TTlNdldvYWY1THBoa0k2RmoxRmtIY0oxOFk3QmVRTmZl?=
 =?utf-8?B?M0FQOVcwUG9zQjJ5SDRERDdxaktyNHFnaGFQSjJCVlcrb2pIOWFOS0VIQThK?=
 =?utf-8?B?TTNtYlAyYlE2MWpJOG8vTm1aTmpCRVpnY2RZOS9kY2NDK1dMMS91WGxwZEpR?=
 =?utf-8?B?enFzOXZBQnBEbkJUL2JwaWw3RUk3Z1JDRFRFRHErYUpvWk5ib1RnalRyck1X?=
 =?utf-8?B?RVBybUpqKzNZdXl2Z2F1RGpOdDl4Lys0WXZndHM4VVVMRlF5QUQ0TFBQMEpJ?=
 =?utf-8?B?R3FDbGRxcCsvNVM1NkFWY2dJV0oycCtvMnkyZGhld2VhVnlsNmlhTTQvYXdU?=
 =?utf-8?B?L2l5cUxsSURYcU53ZUNHZHZzVXdBN3JKQmdrRUJZaWJVS1cvZGhFQ3Q1Um5v?=
 =?utf-8?B?WjFmVGs4V3F1NjBMUnd6MndHMkRpWmJsc3FOVHNvaWFvSnNITUhyWmJjbFJM?=
 =?utf-8?B?SCtVTC9YKzZuWXArYXBIYjFTcnFSMzZwR0MxejVxV0VzZm9oQUFIWEltL1FZ?=
 =?utf-8?B?TFBjZTBrNzExSGpmYjEraTFLbG1VN3c5QjNIWlNvcUx5Y2w3aGFWWWV0ajAw?=
 =?utf-8?B?WnJqdGowVndsSkZJcDZYOGlLcndsZnBSbVEvckJYb3k3eWpLWURNbkRDT1h1?=
 =?utf-8?B?UXlJK2NJcHNlVThxaDRGa29ZdVdBTkhockM4aXJhNmMzYXArUGczc1BzRVUw?=
 =?utf-8?B?VjBIVnF3ci9FY2hkWklkQnh3WmFiMm5tcWcra0syMW9vcmZrU0ZxV0xrcHRw?=
 =?utf-8?B?MHZXNHZremN4MDE3VVY3QmhydUxhOWpwVlpRTWtoWFNncUJNbkhPQVBPd0Va?=
 =?utf-8?B?cy9ZYXZJTnhmS2prdUsrNlJZaGN0dzdlZ1dDS2FlZVIyYllHT1gvK1VoL0dz?=
 =?utf-8?B?dlExa0xkamo5VUNRdGVCTVFmU0NCamVOYmUzNTZhbUk1enlXQzh2ZnVwQmdY?=
 =?utf-8?B?dWFFM1pyaXB1Z1dpQUd0cUZQRUZ3cTJ3bTN5cnFzbk5WMytrRXNVWUNiV3VF?=
 =?utf-8?B?VEtkQ202TlZKQ1dORWZXRzJWUzFjS2hXTmw5L1V2bllNUTZlalROWkFBS1VS?=
 =?utf-8?B?NCt0aHdKZWhjQW8zelZGMXArQTZUY25HU2hveXg1a0paNk5OeVZKK3VTWGJl?=
 =?utf-8?B?YmUxQjZUK2JzYmtJazZJeGdwc2oyR0VmTFRLLy9ka21MS0tsTGk2T0Fsc2NG?=
 =?utf-8?B?UDc2Ni9PbXFOZkpnUGZkQWZwK3lqMjZMUUQ2a1ZZbzd0QS8vVVFkNWF5WGcy?=
 =?utf-8?B?U3JTTkZhT0xTQ0wwNEJpRUU2VU1aM3dzVFVNUHBQME5HNEFMUzBhVDhzalhp?=
 =?utf-8?B?WHJUUEFXSmVac1pLcU9XdnVVK0s2aS9HbXc4WEhWL2xFT2FEZ0pkLzJGMmVV?=
 =?utf-8?B?N2J3c0NERHo5N01LMENZSHRuL050RzNUSUVqMXlmd2tMMENOVjd2dTBXNEha?=
 =?utf-8?B?cVd4bUpkbTJXTWY0YmVVUkRFS25VKzdjMTRmWTdHcEVHRXlockQxcG82aU84?=
 =?utf-8?B?ckgzczF3Z3BwdkxXVlZJL2R2K1dpMUd6c1ZvdjMwckV0cERCa09PWWNHQ2kv?=
 =?utf-8?B?QUdCbGNQcUpWNXJHS2s4amFUOWo2VUk3cFZ6Ni9XNXpPVDdZQkZRTldxUkky?=
 =?utf-8?B?ZVQvVmx6Vmc2UzlqVC96L00waUNVS2VqWXpOMVFMNWZob0JhckRxT2hlRTVE?=
 =?utf-8?B?eUxlNXZ3NDR1SjI3V3M5TTVVclFkVXlJTGdkdkNBZ1RMQlZjbVYxZlgyVE5i?=
 =?utf-8?B?aEVFNHBDUVdQUHEzS2lGN1VrVzFyM3VUcHpFQlkyTWNhbVlrMCtQM0IrakxC?=
 =?utf-8?B?MjN6MlJXRUtoQVM4S2lnQ3g2NXpPWjJYVlJnWmx1U2V5eS9xRno0MFV2WGUy?=
 =?utf-8?B?R2h5TXNlVTdlRitKY0JiOGdHaGZsMU9vajJ2SmdUb29YNjd3TkJPOUtOVzUy?=
 =?utf-8?B?VmN3emFwYlRSYkpTTmNGZmxXdXVFeXlpOWNYemZLdGJwdTd6VUlVdFNRZEJs?=
 =?utf-8?B?M2d4a29NdjhFYkE4ejFNV2xSVWFCaHFyeVQzdlY2RjJBZUxGTi9hYWtxemt5?=
 =?utf-8?Q?yDO/CbWCw+yN8wIlYY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f40aab6-85bd-4611-14c7-08df29420527
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:52:44.3024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIsRjxQ0/Zclb3FVnG9cSYf0aT2nmv9eQlWKe7O7MJ6UH5xwzZY3If0AfQtvxys+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

On 10/13/26 17:47, Benjamin Cheng wrote:
> This was supposed to loop over the individual evicted list, as the
> kernel and always_valid evicted lists were already handled in
> amdgpu_vm_validate.
> 
> Without this, BOs that were created and evicted before a userq was made
> would never end up in an eviction fence rearm.
> 
> Also add the missing ref to the BO before drm_exec locks and refs it.
> 
> Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2:
> - ref the BO before drm_exec locks it
> - updated commit message (s/invalidate/validate/)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e29823ae8672..4dca1ab48410 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -998,19 +998,21 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>  {
>  	struct ttm_operation_ctx ctx = { false, false };
>  	struct amdgpu_bo_va *bo_va;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_bo *bo, *tmp;
>  	int ret;
>  
>  	spin_lock(&vm->individual_lock);
> -	while (!list_empty(&vm->always_valid.evicted)) {
> -		bo_va = list_first_entry(&vm->always_valid.evicted,
> +	while (!list_empty(&vm->individual.evicted)) {
> +		bo_va = list_first_entry(&vm->individual.evicted,
>  					 struct amdgpu_bo_va,
>  					 base.vm_status);
> +		bo = bo_va->base.bo;
> +		tmp = amdgpu_bo_ref(bo);
>  		spin_unlock(&vm->individual_lock);
>  
> -		bo = bo_va->base.bo;
>  		ret = drm_exec_prepare_obj(exec, &bo->tbo.base,
>  					   TTM_NUM_MOVE_FENCES + 1);
> +		amdgpu_bo_unref(&tmp);
>  		if (unlikely(ret))
>  			return ret;
>  

