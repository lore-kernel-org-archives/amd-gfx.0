Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35379606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YEU8zvtL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68CA112A0C;
	Fri, 30 Oct 2026 21:34:06 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE99112A0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 21:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9134Pc28qrABfouaTPV0Opy8kwx0OM2CUX35S7J5A/rky07thvqNqQ6ZxTjKzTz+/AkvrfjpYXmQmSmI8dFuF0CCfuQiWKSRDf1HUl6pVFTlXMG09HFQ8y2D5VHeNRSts/US0o+uKXPn3HyjvGJ0KA668Ak+t4Lp4nMmmozLtUO9oBeRyvjzUYOXeDS5yU3C62C8CvWfb4ZeI96ZJaqFSB+Re+xF+v3r4WoMW55DyRFBC3yP0FZ5Ol9HaWX5AUtR2DRK9xRgXoi82Rzc/waU84r1vExCStipZDwYD55Mj3trPh2ifkaBQcIWNaWTOMRckkW0BE23rAlAiNYYQk/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxPvIxCN4n7vJKP1ReudIeMacnT/lrwujU1U3N9Tx74=;
 b=hENzwF4jEm713SIuGSKllUEVDkSc0oXTkqayO2isJrbdUf+r2gDzguzHikz0KBrLhE/wPYqoiBVQAwFxNvT5ZIFRldSTTBv7WyGCty5J9ceg/5ay+6Oc6/Yht3gPq2vq+Qd3g3dVMtIgBM9N21vDqA06Ju+BuOBlaR6JC7ou5cMUZiSLhG4CRcilog511ukg+FhTt/Lb3OBr1fb9CH+UDUgBFgbyXZaqlIVjxjqGTfppqPvqz0r0eoFvWmeU3+eBj9zvQ+d90hvuon3Zp6cxuFGrYuzrc4k/96r0ilLtEOBpqiOg8C3nlF5ikhJE7yIlRYyZIyDwX24MCpJ0X7tHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxPvIxCN4n7vJKP1ReudIeMacnT/lrwujU1U3N9Tx74=;
 b=YEU8zvtLI8y5PVOY0KcHMMIB/VkY1dFPy8GOmt0A57SbD/bLqOXsi2zcVwKgR6W7rI4HoZIj9Cgu0SnZjgKPGDxwLvVoyMGOttkZcsNHtf8h1BtLKgsztw8ULg1oIOXOSPsLMgWIswzKGWVQccLDNKpgCL8jUSr/yM4G1ufETZ0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SA1PR12MB5669.namprd12.prod.outlook.com
 (2603:10b6:806:237::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 21:33:37 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:33:36 +0000
Message-ID: <b84afd85-a096-49e7-ac57-f51695cb9556@amd.com>
Date: Fri, 30 Oct 2026 17:33:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Don't check for vm ready on svm unmap
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20261030140550.2524662-1-David.Francis@amd.com>
 <20261030140550.2524662-4-David.Francis@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261030140550.2524662-4-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::34) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e9ca03-2a27-4bd0-5f84-08df36cd74cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|4143699003|56012099006|11063799006|261026140227099003|261026121527099003|10067099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: jqj9xHGscz2KOZDAbNUDjZ0ZGppZ6YIOfOe1A+5UHnY3YdSWmvpZBsH4vrOeJSqqA99bD1TfHJQN7qteRuIjX4r6Sq2lnxKrVz707uzBXjZNYB2iTm2CQyVXFubUjiWOFSf+bZnJNMADPFndjivVsRLaUoMHAZWLhjD+tVMmWzU9c0SGSORvD/5wVCToiahvBH/d5K3QWRUizRaEC8qC3W+Meik8ZGphCUdp8XKN320zswGtC3viFoyoLmR32tr4uBgh0v8rrp6EmH/YnQuPOZD8bJtnu0jp0/OYW6yRMEC2ge2KTe9qXTB9n9ou6Eq1ahUzILgaTss4sArMGfCaQSOr80Jrwd+uBQoc7Nz87OcIYJwgjwFzbtD9mchmAk4zBbQEq7xy5UBsqraSWeVIw0n5oUwITHXgPxbdBIh0GErlwsZtylSyQa/ghtixHtpQ4DxIlLMMg8JLYvOLuMLtXvPInayu13qLwD/odeyC9d3EdQXYOAtk8OkkqEGsn6GqurZu2Iu4vl+oOR323x+euMh01anC/5oAKI9IrdHwj+zSI+kjS6I2CDsLUmUTZXv/wsSAaWn7MvwRo8I2zV5Wn1wTT4Y3RPm7YZxxeoPX3Pr6hGm4VG6qRV0dEVrlaz74USzzjKVVp4skspuKLYQZrSPoI0ytBxio46uffm4VVk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261028144727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFJ6bGRTam5PdG9ROHpZQzMvSlZGSjZPMTJXcnM0OVBHczM4RnRUTndsVEFZ?=
 =?utf-8?B?MFdsRDhxYmkrVCtieGdveXZIQmhPa0ZlYnp5L1A0a1FDN2lHUlYrUEF2Riti?=
 =?utf-8?B?Q010RGNoRWEvalNlNnFqZmNZM1M0VkhHVEVVRGRxekhRaHI4YnhZcDlDRzU0?=
 =?utf-8?B?dCtDR2FiS0RzWG5tazFacDlHYWxzQ0RJaThCSU1SYzd0U3pMdTFGTnBUYkR0?=
 =?utf-8?B?RmpHNGJGUHU2UXViSDZuSVhMTTErclpwdzRyeDBTQkVicThuaUlRUW9uMWRQ?=
 =?utf-8?B?V3JaZFNjUW5qSlRGUGY0SE1kUmJCMERmODd2WWFiNCtrNDBuU25nWWJvUm83?=
 =?utf-8?B?VHF0OWM2Zmd2YWdoQmxNUGN1ZzE5blA4Q0hicXpUc3A5VTFlR2JyeUFRb2NR?=
 =?utf-8?B?VEZHdkFzaVFuZFlya0VwOGd3OHNjQitSRnc3RHB2WnZKWUYrZGRydlBxcExD?=
 =?utf-8?B?c1NpTDR2Yld1OXhJSW1Hb0ZhMm1BODhqTDlEYkJoQnhKelBFL0QzRDNVWVl1?=
 =?utf-8?B?b1pybzlDYlhCRFdPOVV3K0RZWVR1dXNibEVGbElkSnhLUXFRUmhsQWNRZUVG?=
 =?utf-8?B?b05aNjVCMXJhTTVTNENmRUZjaTZlNU1WazgyRzFEdHZqWFhtNVhhYnl4aCtG?=
 =?utf-8?B?bkxRRmx2UXEwSURZT3p2S1l3bW11aitxdEFmT2JLY2k4VUMwcktaUHlxTTd6?=
 =?utf-8?B?QWkwb1A4dTJMYlMxYUJTTzVOSW9UWGt4UzkvbWtmYW9GQzFFWGhPUm5GRXI1?=
 =?utf-8?B?WDJzMDdXL2dBUTB2eUsycVRWWHB5dDRDWFo3TnFGa0JEMnR1b1A0TVVnUExq?=
 =?utf-8?B?SDdmQVVHSlNQcGQ4V2JYbU03QSt2K3VyWFQ1bU85eld2anZmY1A4TkhnV0cz?=
 =?utf-8?B?SUFscEFSMitvRWRQLzRwU25PeHMraGhHRTNFOXpkRHpKeHF0TEhxcUdlSG9y?=
 =?utf-8?B?RGRKNmtVaE9EOXlSWHpPc05odXlVRC9RZ203ZWN0NklYSFJzcER4T3lOc21S?=
 =?utf-8?B?bHlMR1J1QkI2N3dCNFdNd3VNSVNvZGxqSkF4UG1HWmZuS2FhUG43ZUU2TDNN?=
 =?utf-8?B?SWhIQWZnWjc4R0Y5dWdIQnR0MlQ1TkkwRUh6aUJrdmlVQUJZMDR4RlF2Yi9p?=
 =?utf-8?B?S2RhcHNzcHRndmlpUFR6UWNOejhIL21DOW1aNURJdU1WVlJORGlSRitKQkto?=
 =?utf-8?B?Zkdwd0JKZkdCZDRMWVhZcTVGOUtUSjBtNFlLWjF4QWNTYmZBUnR4ZC9jYW5S?=
 =?utf-8?B?N1IzNWdjYXNpaWtJS0Zyb3UvT2NMUE1Wbm5DWEswWGlWcXIrU0JVNzBmcEti?=
 =?utf-8?B?Qnd3ZTBvTFZJRjVKWDhCbTFjbzRHNk85Y05GUVJYQlU3TzFrM3Zlb1JpMDRv?=
 =?utf-8?B?WWJLMENmWFFFWmlDbHZ0Zk52Z3pHcy9mWmFnUWorV3gxMEdLZnFEdnR0Q1h3?=
 =?utf-8?B?N3AxOEV5bTF4RFYySFk1QkNCajFJbmtFbWE5bmczR2JsWTFiczI1YlQraVBy?=
 =?utf-8?B?aUFuNTc2MitZc3F1TXVNSkZMVlRuOWhnVVBkdnNtMzlKanBaSHo2VkZjTkZE?=
 =?utf-8?B?aFd0b1UrR25DUzN3QjBObHg0VGMwUkJ3YytSNThZNVpVQUQrd0w4ZXhmWk9R?=
 =?utf-8?B?RTNleTZzNVRURko5T3pyamJNT210RkxJQWVtZHlxQ1JqSGt6WFpIZ0pUTXJN?=
 =?utf-8?B?cWtGYkR5TVNqTFdsRDg0dFU3YVprdFZLRmdXQm9lU0FGTE5NYWd5THNLWm5E?=
 =?utf-8?B?SGZvcm5DWEJTN0hJWDUvaUh3cTRMWENyQXhWY2NVUGsvZVhzc09NS0tSTkth?=
 =?utf-8?B?S1FscFFvWGhzZE5BRElOUGd4T3ZYOTMrcnlGWmdQZzZFRkUvN1lwbDQyZS9M?=
 =?utf-8?B?K0ZHM0toSHNQbGloVWtLTjNoank2MEl5WVFJZEh3bjMxVVV2U0xSM05YSzho?=
 =?utf-8?B?M1NHNzQrL1hDcjIzeFU5N3UyZWllWHJrWlBIdkM3NGhBOVVwaVpESHpmWnR5?=
 =?utf-8?B?UWkxT1ozdktwZ0JtNGluKzYvSkpsR1NlMURTMDhLcG54Sk5lREN3MUM1SnFr?=
 =?utf-8?B?RHJUcjI5ZmVSbkhsbmMrRWVIL2E2SWpQb0cwTUtyTUpiUG0vbEpFV0diRml3?=
 =?utf-8?B?bXRHS0o0eWpZZDlFTHdwK1pLNnY2Z25TR0xhV2Zka0krbkNnV0NvSE1oV0pK?=
 =?utf-8?B?QjhsNS9vTmtCMWs5cHQzRldmeHp6Tkt0SmtMU1lVcTVTcnV1Rk5MVi9NVEZw?=
 =?utf-8?B?UEZ0MlFKdjRvcWI2RzBGVXdNVzJyMVBzOTJ5b3UwVGg4S2c0dTNPUVFzSFNq?=
 =?utf-8?B?S1dkSmRncUl0S0M2ZjNNbTNwM2NMVzZJN2ExOFR0b3hmWkxZUE1VZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e9ca03-2a27-4bd0-5f84-08df36cd74cf
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:33:36.6880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQKuRO2kTfW7muewDNIu7Hxe1U14kPlYyuwvVK8t1HO6pKqDnKIu6SgwWlnZ0CFqJ9ls248az+4NAItw+Ihzcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
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

On 2026-10-30 10:05, David Francis wrote:
> There was an amdgpu_vm_ready check in svm_range_unmap_from_gpu.
>
> This is improper, because
> - amdgpu_vm_ready checks for the vm to be locked, and unmap is
> expected to occur without that lock held
> - amdgpu_vm_ready fails if the vm is in the process of eviction,
> but there's no need for unmap during eviction to be an error
>
> Remove it (and swallow the -EBUSY error from eviction in progress)
>
> This change is necessary to avoid dmesg spam from the vm lock
> check; handling eviction may require additional checks
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ed5e3318877be..4c0ccd585ff8e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1425,6 +1425,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   {
>   	uint64_t init_pte_value = adev->gmc.init_pte_flags;
>   	uint64_t gpu_start, gpu_end;
> +	int ret;
>   
>   	/* Convert CPU page range to GPU page range */
>   	gpu_start = start * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> @@ -1433,14 +1434,13 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	pr_debug("CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", start, last,
>   		gpu_start, gpu_end);
>   
> -	if (!amdgpu_vm_ready(vm)) {
> -		pr_debug("VM not ready, canceling unmap\n");
> -		return -EINVAL;
> -	}
> -
> -	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
> +	ret = amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
>   				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
>   				      fence);
> +	/* EBUSY here means "vm not ready for updates because it in the process of evicting."
> +	 * If that is true, it's safe to not update the range now since the vm is not in use.

I guess this is true. But as we discovered, we'll need to do the unmap 
or re-validation of the range eventually, before the VM is restored (in 
restore_process_worker) and user mode queues restarted. It's not a new 
bug, so we can do this in a later patch.


> +	 */
> +	return ret == EBUSY ? 0 : ret;

This should be -EBUSY (negative sign). With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   }
>   
>   static int
