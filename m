Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86B1CC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 06:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB3D10F4C3;
	Tue, 13 Oct 2026 06:58:38 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED2A10F4D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 06:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI01x6qkRhznZ0OoLFBUfz7BdOe+tuSur18wf4h66ryRrzJF3xk7RicB145omoObfQ0XnInzzijI8+BE0OmFM3VP6QbxfJmpHNoFomv0F31AsaBAHV753/8bs5mm5vm7Kd1d++If+aiqjlEzZNcyVEloDeRegJqP6OoBxmVof6gVNbDQXDnjrrNr8xJRWfbeoNrMNYv5GkLYjMYS4Ykv0FpZfnWFNOgoQWDr5IofOyA3e6Iad0u641VYLCVBy0LIQ4NmxV+KnW5WuPAQ0FVmmJTy5vdS/wV5pLihUtybeedBBVASvAHvn1whv1ZA1jUCdbYKI4ZcttmLe1MOI7RzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUMwuZo3SXH7U0oSvA9heZUwsUNTpWygvRlzKR6JU34=;
 b=ThEuebF7eWjbdeqX5rl/w45sc9qXssviCVGtO0L6Uyd2lo1DlzyVz8srofCZRu/4Dw+SapZ2rMlD2sOrm0YRAXGrOtBkmcX1IT8QAaRX91YwyvYUPCkeKGdYU+OsGBJNM7rVD5HHD+RdOwuJSZ6dEc4cWivjVC636mwo1VamzenNzK7zWwP8QbopyJynvyow1tIZ2VklHXElUxdxktxFCp9jGBm2cLa3EA8Wzua2evbKCsrum1LnNnl5TTqKe4enlsfAK9oJvM7ZPEw5aueq5rxtZ5IPZs1MjFVyeE2wKDWB2k6FYueX4KFp8ndnFnOUaK+6MbpJokQoF3w/z0hnOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUMwuZo3SXH7U0oSvA9heZUwsUNTpWygvRlzKR6JU34=;
 b=rpwOPrlUaerHCmttU+s/Wc5CFeaM7cQH3dnPjzkCKk4DPSaF+z0mBGywicJwSFOv1poqtz5E/0nycPlppOl5pb4MR/5tGVKPzxh/v/4ihhmwNtM6Ym2NXQXWw0PkTTxmsO04D4RfqO8zSiMHJu/DpeO/D1lQ+oesPjhvKyPXSy0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 06:58:29 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 06:58:29 +0000
Message-ID: <303f03b3-144a-460a-b4a7-cf08fcd79d47@amd.com>
Date: Tue, 13 Oct 2026 08:58:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] drm/amdgpu: add spm_vmid and exclude it from the
 MES, KFD and kq pools
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261012092429.3937825-1-sunil.khatri@amd.com>
 <20261012092429.3937825-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261012092429.3937825-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: e51499fa-77f1-445f-241b-08df28f762e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o69A5jgGxZuMyAHb3ykViMPBpsucTdm3wyLZ8aVx/fKhttVWEbHxDrKYcn6QUZwRbbjkgNXgbKRMMRSHgQE69MBq65YkmHjqsH0qEZfVoHjVuadUYJScOmC66e7SMpG0cgZyWd3/mAulzQa6aYslinj7sYd5QX+JfDL2X2BABoaALEWKQgcmc5tTUudc4wk8Zbi7+Yp62DDa8mKc52PAK28df715XdPZ/0/rTvVRmH/WsG2srgghVG51SH1WzVS2CuizTchP91K6P+Ty3lVNnplB9tDOHYYJMslxPEoWTBHvC7w/teuU6JbsQp8nG5NIHptqPgdY1s7p7yF52TgIiTFXNRDIVkozoByJxgis+yRoiuyzRUTv1+THDygEDlkGJdXhvMC4SKrcR79aHrRho8ZTlEssA2qnTtG4xemT0pjR5IOxjdpwMAj+odKZ1t67Kq3spgmcS1HtjDndKoZ/+5E5skxwY77znRmk4kbKi1/LMlUq5eJRRvcOg+bTee/mgiW8nozuIaxeYRIRWO9/2XyFyiFSnt7snKu2Ad9llL7UlDq/mvSMFAq761ixQSCTOp7rOA+kImMk/nXvwUgBG/+CupHleb+EGmU8ru9Yu806WjgtenH/a8yGRpXQKE4fPMw4Bu5T4QhWBqnyALE7YMeOb+8oQiZbuRRoB37IY5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnpDNllydnM4aW9mUjBZQVRiSHJTdUJMT3J6L1lkdzl1bUJiZDAzNDVNNmpY?=
 =?utf-8?B?SG9rK1RldlBsNUwzd1R1ancya2N3U3NPV0lpMnNBYml2UjJsUE5oVWpDaEQx?=
 =?utf-8?B?R3lIYzJiTFIwTnluQWxvdmNidTRqNFAwcDMrRFJISVNBeW9WSFBWYzVOK1M1?=
 =?utf-8?B?VGJEcys4YzdQRkVlS2c3Q2ZEN00vS2FVajFJT3NuK2ZrY3k2eW5WdnRpSnpp?=
 =?utf-8?B?YWR2UVI5cHByZHZwY0U0U01KZHJUeFJFR3gzS2h3ejE3b1lqMmtsb1lDVjhi?=
 =?utf-8?B?WExjMUpoVGhzNlFOYzQ1ODZaUzZPMEhNb0VYL0hVZG9uME9yU3g2TjA1RCt0?=
 =?utf-8?B?ODRub3pwQWY5YVNUSWZiMmIyTHR1b21UWmRSUjlLbzB6eFFXRGNybHBJRk1t?=
 =?utf-8?B?M1pwWFdkS05oOG9rb0tUaXhzSnQxcWh5aW9UZ3hPOXB4d2M2UHlGQy9UOWFX?=
 =?utf-8?B?cWlzM2RYM0kwdGVPc1oxKzMzalRTVHRHK0E3emdYT25DdmY2ZThraDA0c1NL?=
 =?utf-8?B?WlByZVBMM3N1R2VGQ2pnZk1RNVpuZ0tmbkdzTXZybHQ3N1N2WWQza1hyS3dV?=
 =?utf-8?B?cGs3TnFSN3ZVNXpqVmtyS3VKc3RqREp2TmdTMThtNm00My9KUklxZ1FtV2pk?=
 =?utf-8?B?cTd4d0U0T0RVUFZ0czBjcmRvK3dGUVJ3OWg4MWhOaGNUcEFMRDMvclV2OERW?=
 =?utf-8?B?UWgyR1NySFRua1gwd0FqWERtTCtsOEROenNuNDdRcGFWVzA3L3IxM0REUlkr?=
 =?utf-8?B?aUtDeHRuSVpScnRzanlGUVQrNjFISmVLeEdzYklwY3RxcjFwb2IrdjRIWVBC?=
 =?utf-8?B?dld6bmJjSXl4SDhBRm9NZ3QrcmNNV3dlNGN5NU5laTNVYnFnZlFUek5yUEds?=
 =?utf-8?B?MERHM0NCM0RPOFo1YloyNllvd0UxM1k0eEVvVWpkZU1VQlpoQ2kwa0loMzFV?=
 =?utf-8?B?SmhhdGVZS2RCSG1hUnMzZkhyaUpZYWV2VzBuamgwOWZjUWdjNnJKczJEQjQ3?=
 =?utf-8?B?aGk2cXh1R1RTUzlVSWhOM1IraGorbkJUcUordEVleFBCR0g1UDVGK2pmR2Nq?=
 =?utf-8?B?VEJiaVFMT3p4dk1hTXoxREplQ3ZOVkJ1ZGlFeDhOdFYrS212WG1PbS8wdlBJ?=
 =?utf-8?B?MTNldnBjYllFcXBFd1A4WFA0NG9OOFBQaXU1RFZoZmV1eksvU3gvT2w5SlRk?=
 =?utf-8?B?RWJ5UXNYNzV5K1dTU1FFcnR4cDBnYUxBdUF2Qll2S1FpRFJvZ3JYNTVBaW9q?=
 =?utf-8?B?WGovTFpHWnZVL0s1RmZPam9nNlRjeS9uZlFFRGdFemFHak9rT2NvaCtrRDJT?=
 =?utf-8?B?RGt0WHVKYXp1cVBLOGRTUVdVY3NkR1VrL3plVnNFNlBBdUdTL0YvZHhhNy9v?=
 =?utf-8?B?ZFFHN08raWtqWTk4OHZMV0JibFA1T1BmcXBmT2I0OUNOYkVjSGo2TncvbXB1?=
 =?utf-8?B?V2U3TUpRNU5ESmhuQ1NUeEtrL01QNWVZS0o1SlNwdCtmWnZzZkNXUjRWTi83?=
 =?utf-8?B?SzMrNzNIZitRcGhVd3JGeVhxdXowNnhXSGF4bllpcVZ3T2l4ODB0N3VZQTAr?=
 =?utf-8?B?UVFackg2NGlRSUFuMVhsc0NsZTd3dUwzejU4VEZNRE5XTU4ydWlxL1A0aHNG?=
 =?utf-8?B?TVQzMThRb2RuRG1nalZXS1VMQWYzTDEwNHc0RzBteUpPVXBVV25RTkNYbGhi?=
 =?utf-8?B?cFRxVzlkY2h5MkkxMXJ6YmpFTUZPamkyUTNkZTlQZklrczMwM0xBOHJreUhw?=
 =?utf-8?B?RnpIbnBmYWNjSFZnMEZzWmRjSXhCcDV3OGJNWGFWV25Cdkk4WE1kS3lmR1Jq?=
 =?utf-8?B?NXJEM0tDQXdLUFpvRnR2ZXArTjB1L0Q3OVl6NnlPd3oyeEtVeWRCc1RvR2Jt?=
 =?utf-8?B?dkJtSGkyUFpLWjM3V24wT015Yzc5WGJWUHNnNU9yeEZNdUZxazlucENkQnNm?=
 =?utf-8?B?NGJxampCOFVxVmdUd2QzbngvWGdFU1lFT3NPQzRKSkJmdStVeEI1SnppdnF2?=
 =?utf-8?B?SEVleUc1K0tpVFpSZGg0SHJXWjh3YjFtSk9wRmQ2K2lMdGtZeVptbDRSNUVM?=
 =?utf-8?B?SnVRNzdCZHFVc3FEZDhpNUQvRUpNS0hLcndNRnhsdkJ1dzZjTnFwd2FBUjlj?=
 =?utf-8?B?bVByM1UrbGxaN3paWFhsZzVIU01Ea3dkWDRUT1hMZmxWZnJsUmNRWS9WZmFh?=
 =?utf-8?B?VG82SWp4SnNpRUxtRTdzVURtSW8wbk9yTEJFSTJicHNPVjc5Qkl6eS8xNzB4?=
 =?utf-8?B?NEMxSWQycTBOYVlwdnBRd3BCcHBtK2IvZkRFVllPUkFJOHRmWTlscnY2VUhW?=
 =?utf-8?Q?K/u1ulc77qMavaV6AH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51499fa-77f1-445f-241b-08df28f762e5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 06:58:29.3245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW84z17TF2JF2yl5rZnEjstuWcHVPOWpgr2zUFXsm975IryRo2HUBKedC2gQbeWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
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



On 10/12/26 11:24, Sunil Khatri wrote:
> The SPM (Streaming Performance Monitor) path needs a VMID that is
> isolated from other GPU contexts. Introduce vm_manager.spm_vmid to let
> a GFXHUB dedicate a VMID to SPM.
> 
> When spm_vmid is set, exclude it from both the kernel-queue pool and
> vmid_uq_mask_gfxhub, so neither the round-robin kernel-queue allocator
> nor MES/Userqueues ever maps another context onto it.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 46 ++++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 ++
>  2 files changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 392a18b1f2b4b..ed1efde29a9a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -638,26 +638,45 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>   * @vmid_kq_mask_gfxhub: kernel-queue VMID pool mask for GFXHUB
>   * @vmid_kq_mask_mmhub: kernel-queue VMID pool mask for MMHUB
>   *
> - * Sets both hubs' kernel-queue VMID pools (tracked least-recently-used
> - * via id_mgr[].ids_lru), and both hubs' KFD/MES user-queue masks.
> - * vmid_uq_mask_gfxhub is set to the
> - * complement of @vmid_kq_mask_gfxhub, since unlike MMHUB's it is always a
> - * clean partition of the full VMID range; vmid_uq_mask_mmhub is the
> - * fixed pool set here instead, since MMHUB's kq and uq pools are
> - * allowed to overlap. A VMID dedicated to a single fixed purpose on
> - * MMHUB (npa_vmid) is excluded from both MMHUB pools; it is the
> - * caller's responsibility to have already set npa_vmid.
> + * Sets both GFXHUB and MMHUB kernel-queue VMID pools
> + * via id_mgr[].ids_lru, and KFD/MES user-queue masks too.
>   */
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>  				   unsigned long vmid_kq_mask_gfxhub,
>  				   unsigned long vmid_kq_mask_mmhub)
>  {
> +	unsigned long uq_mask_gfxhub, uq_mask_mmhub;
>  	unsigned int i;
>  
>  	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
>  
> -	if (adev->vm_manager.npa_vmid)
> +	/*
> +	 * Derive the uq masks from the kq masks as given, then carve each
> +	 * hub's dedicated out-of-pool VMID out of both of that hub's pools.
> +	 */
> +	uq_mask_gfxhub = GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~vmid_kq_mask_gfxhub;
> +	uq_mask_mmhub = 0xFF00;

That looks like it was derived from the original first_kfd_vmid or some fixed MES value.

For now the patch is Reviewed-by: Christian König <christian.koenig@amd.com>, but I think we need to take a look at that value again.

Regards,
Christian.

> +
> +	/*
> +	 * SPM uses a dedicated vmid that is reserved from gfxhub.
> +	 * Unmask the reserved vmids from both user and kernel queues
> +	 */
> +	if (adev->vm_manager.spm_vmid) {
> +		vmid_kq_mask_gfxhub &= ~BIT(adev->vm_manager.spm_vmid);
> +		uq_mask_gfxhub &= ~BIT(adev->vm_manager.spm_vmid);
> +	}
> +
> +	/*
> +	 * NPA uses a dedicated vmid that is reserved from mmhub.
> +	 * Unmask the reserved VMIDs from both user and kernel queues
> +	 */
> +	if (adev->vm_manager.npa_vmid) {
>  		vmid_kq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
> +		uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
> +	}
> +
> +	adev->vm_manager.vmid_uq_mask_gfxhub = uq_mask_gfxhub;
> +	adev->vm_manager.vmid_uq_mask_mmhub = uq_mask_mmhub;
>  
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
>  		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
> @@ -666,13 +685,6 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>  			    is_mmhub ? &vmid_kq_mask_mmhub : &vmid_kq_mask_gfxhub,
>  			    AMDGPU_NUM_VMID);
>  	}
> -
> -	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~vmid_kq_mask_gfxhub;
> -
> -	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> -	if (adev->vm_manager.npa_vmid)
> -		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index d99e42ca308ef..ddcdc7256ef07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -411,7 +411,9 @@ struct amdgpu_vm_manager {
>  
>  	/* Global registration of recent page fault information */
>  	struct amdgpu_vm_fault_info		fault_info;
> +	/* VMIDs dedicated to a single fixed purpose, 0 if unused */
>  	unsigned int				npa_vmid;
> +	unsigned int				spm_vmid;
>  
>  	/* VMID masks for GFXHUB and MMHUB */
>  	uint32_t				vmid_uq_mask_gfxhub;

