Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF05CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 09:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1CB10EA36;
	Tue, 23 Jun 2026 09:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cqYFxfE2";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FAE10EA36
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 09:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUSwvS+bnm+FzzFWau/YuOvE0aIAPD1RqZE/ECp/VxXllXtNk/47KiCIF1ivC6qfY3ckEofuetTkfPbg4xSn23iiAhgNXziIGgladrj5FOczMaXMOYpBZu3qpRS29xD65OhczQSWxPJ7nBGrUnL5F1FfTn9stAChkl1q3n79eO4VTmPYwyszkjHEMiakGNV0E3LUmbM/7RWDlnkB77jL/Ad3bSyaMDgiH5QOrWk5aJgLzUU7HV35Cz7m/N23E0IYggX8nP19t2IiwDZOGtam2/DL5tES2Cq3ziNU2f2MAWYZWmGclZMIpxAZOCdEUJGNP5HTaRdx6sjuj/H7HqjziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKTOHgUKGt2/O/vkiO8BeHUOL44z2WXlvm+ccHTdrbw=;
 b=DJdGgqH6wwirurd4KSFqEjvRGOh6siqEbNBIvoXk7SxN0sjcAcbfh7FCSjB702dIX8OC0evOm7NE5cuPrZj26FDDxtAJcGMhRtSB8yo5g93d2zhe3Fw2uJ5661hnu5Ak8y5I+aNDL0cXuqUWR4kkauX970HFbHJcn7hYKRccHoe1ahfZba687nx4XFymtRH4cyFOlQqsvwf4vVZQMmskBVpS3UlA68a41jHWj7cBSE5Ln/jCpOTgiDVTwVXxxdk0aQ6pBYPBtbJoWPY3Lv9AL2UzreQU6iv//MussWGov/M2fEQ+84C8MIiJ09tFZLd7tNk+gr0wa0/CJpJsRK9WwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKTOHgUKGt2/O/vkiO8BeHUOL44z2WXlvm+ccHTdrbw=;
 b=cqYFxfE2HrR4f11VOTJA8FZ3KiY/OsqokOgUIu9Lo2HMpZcKXwVkAsGoUrPwZak46cIP/73VE/pYxixH8p9gXbNGGE/U3fLz4wzlC6SySbXRj2bTmmJrk5XICc92lNhtWlhsRlFajy5a/Zuim+lQS5rB+U/FjYI98KFSPG29aSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9771.namprd12.prod.outlook.com (2603:10b6:8:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:21:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:21:02 +0000
Message-ID: <5c4c0c82-b2e2-4c42-8515-3de93814b408@amd.com>
Date: Tue, 23 Jun 2026 11:20:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] drm/amdgpu: Add PASID fpriv lookup manager
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260623081301.3046023-1-srinivasan.shanmugam@amd.com>
 <20260623081301.3046023-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260623081301.3046023-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0032.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: eccf2898-71c4-40d6-cb19-08ded108bee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: kdLooYuQlqSHAbFPd4km8mGxUqtTAYygqXyv4FRy4bfHOPGU4zCCDDcuLHrYw787HmdK4iD+aVCgeB5TMOHX/cLRE2baHLgHBn61BuL+z92it9b9FsLbTyp0DJ6vaBAHWlZNSJTHAxFdxwwXmlQSC8Mhw3m0epmLttuzy3Nu91e1R3FjAMoQZhVUWsu+z0E/vHk2HOTMehR0si5K57Xcf8gS3mDDvwNRUIMIZhok7DmanqiP/Uqe7nb1JgNLPN99x8DhXefRpG23g2moOVAHpqics9hSv2l3qIl+7UNnWDCRmgKUYZ7SOH5Rsg9pe0PXBFgg0gTV+v57OdRok8mYT4cb0nXRnrwslZdJiyeIFhYs/FaUc/DTAUq2tiwFvPKNadQFLamvEerRhJWKB7bfxRYA41P3IelEIegvFjcwhl/zFOLGt4A5R2XR2htH5HgMwyhA9Pvq9y+ICrD6brR1FpyJLhaeFVgXwNhwhBxBf3MtmAizhGR1uyzv9f5dsqtTvAV0P31gKuTzGZc8Rc7Zt8smL674gSmqqbUqQ4cqf1JNchVF0XRd3kTttOfyTM/feLapOV1a1LTe33JblK5AqH5xq4ARZYwsLsmBmwe7D0T5frAHA/ACwvkq+O8iHU4bUvHuNf5tgeh/5i+Tj39yNHjjO5hcKz0fEoQxDjMakTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRXdU5WeUx3TlJOc1UvczcxZzZ0K05IcXBVSndKU2dIa0FLaUd2MXJDTzhr?=
 =?utf-8?B?ejBqWVJkK045cE94T3BWZ0V5bE5nZjVNWVBYOVBuaDVnUUNDSVMvcThHL3A5?=
 =?utf-8?B?SUNRSEVDOGRSRS9SL3RFVmpnRUtyTFhYbW1RQlU1Q1FjWGxKdlE3Z1A2NFNa?=
 =?utf-8?B?R3hmK2NqL1hUZjlkSFZKRzZleWhSbkwxL2hnM2ZvYTVhVTFES2tWSzFoSi84?=
 =?utf-8?B?V0VQcmJRaXBOa2UrTGlTRDNYNk1MbjlIeXo4bHVrbmM3L2RKcVpTdDRiVHl6?=
 =?utf-8?B?Wkx4UXRwbVBDMm5EZmZrd21JRFBlcVB0TnNkZnFaT1Naai8reFdnaUtKdkVK?=
 =?utf-8?B?bjVnVnRPM1JCOHVOZGNaMlRDaElPa2hzWkNvdTNxZ3dxSU9XYyszYUp5NXZK?=
 =?utf-8?B?bmlKZUd0N09rZVdRbnBDTlRFeHJYOUJ4dzkya2cwNWU0ZTBWNlNOUnNpdHcy?=
 =?utf-8?B?bzdheDlBOE9hV1JOekkzZVVnaFcxR2VJTWpFZ0lhbXBnZ1doQUErTVVjT0Qr?=
 =?utf-8?B?RjZNRG9OQzJTS1prS3RtR1pPNDIvWFJOdlBiWnVmK0t5OTRMNmE3OHF1K20y?=
 =?utf-8?B?RFkvMlhWNWdPQkhpclhQZE95Y1NGcWg2eWhQdmFJcEcyNnhGTUI0UnVVVnJB?=
 =?utf-8?B?cGRWQzhyM0Q2VWkwSVRnWVBtc0FUdTlHdDUvdTRSblk5UVlCdlpDaTZqNGgy?=
 =?utf-8?B?ZGNkRjNJbE1MNzBwd0d3MG5KQi8ySjlWcC9Wa0tFV0lLTFc2WWtENnBqSGJm?=
 =?utf-8?B?L0d1SGgxWjkxTkxxb2IrRWRsREROcDVCbHZ1UXFKMTl2YjExVDNWSnNHeTVt?=
 =?utf-8?B?YXJINTJ4WDVmQjFJdE9yM25LOHNIcnJKaU0wdUI3NXJINGRBMnVQdHJkYWh4?=
 =?utf-8?B?NS9FaVZxQ3QvbEhmRHF2enY1TDVGM1JtS202dG9BSkowcGhBc1RnbFlJVXcr?=
 =?utf-8?B?MkhSSE55dVZrMGNBMjZNUnNYNFVFQTlrTjFQZ2x2clVRZzZWdkc1ZEJYZ0xn?=
 =?utf-8?B?eGMwa0thblNYdlg1UHBSd0xZNUhzRjNIcXZYUk5JbUo2aEFHd1B4N3VMWG9E?=
 =?utf-8?B?djBTR3FoNEtXa0cvR1dLY290S1k4QnhSeHVPTlhIbXBwcjVoZkUyeVUyakNR?=
 =?utf-8?B?eU9vT2QveEM0bmYyMGFkMUlWZkt4Skg5b0Z0RGM1Y1JSb3d4RGtlNlhvT0xL?=
 =?utf-8?B?cFpQOUc2SWtudjhxb1BmbGgrUWk1N3k3Y1RhRWU5S1UrTjVuVXRkUlo3Y0hh?=
 =?utf-8?B?aEJwL2pvVWZqdklMOUtRVFRWMXRoY1BNb3kwQXlDN1JSYVZ0UGxUY05SeUVl?=
 =?utf-8?B?SjJCQU01dFZWYXpmWFFtcld6aGpQOUZEY0M0RWprcHQ1NW1PYmhVN0dhaU9N?=
 =?utf-8?B?WUlnUHpQUXV4cUQvYmxVQkF3eWRqd0gyVzlNb1lwU2ptZndmcHBPd3dYTUxr?=
 =?utf-8?B?QjlpaHlQc3Bsc0EzaXByeHExZXdNMHVvS1p0cGtVMnFWRmxJN2p1bkpXcStJ?=
 =?utf-8?B?UktvRmJTb0djY0ZBdHZIQ1lwSUsrUzVJb0ZVZE0wempPL3F4M3hPN2MvN3FX?=
 =?utf-8?B?cGpHWlBKaSsvTVd5MktKMko0REVkaW0wL09wcyt3cEFxY2UwNzU0cjhOcEJv?=
 =?utf-8?B?VkZkTzcxbU5oYXJUWW8xUWVLMTZmWVRZTzZJUHRtdnNkZUhkUytvbXNabHky?=
 =?utf-8?B?eXpqUko0R0IwWU1ib3lTNUp6b09wVXFiQldjNDczK2JIVkxCZnpmZWsyUEJ2?=
 =?utf-8?B?TGpnM0lrL0lsNmxXaDRTOGxQYmIzTDVjbGpPOXlHT3ZWd29kWkEwWVFpYm5V?=
 =?utf-8?B?U0FmQWJmc3oxb0R5Kzh2TWhmZkFjWTlOL0lnVVV0QTNHdHMybTBDNGdITGp3?=
 =?utf-8?B?R1RRYWpFbmU3YUQ4ZCttSnc0MUpUYXVxQUx1ZFhuTmY3V1dnditBbWFmYVVT?=
 =?utf-8?B?ZkZ2eHBUcHdrM3owVkZENWpXN3kyU1F2akhjUEV3SUFaYWpTVFptK2pRa3h1?=
 =?utf-8?B?TWxDZHRDK0RSYy85dUllVG0zVkFEYWZLcXB1bjdPOHNtU2cxdytFeFUydkVS?=
 =?utf-8?B?RFV5YzdrbGdrbVdMYVFMWURlWnoxOVlSbzFQdnN1a0x1RmcxTEdHMzVYb3pt?=
 =?utf-8?B?SENqU0RLNTJLd3F4UkQ3YXRwSXdlR2xUcjllY0hYUFF3ejg5K09pQkR1T2Nz?=
 =?utf-8?B?VTY2dnczUVl5Z3RnMW1PVm93S1VBSndmMUFXek50L2JrMncxZnJkanNYR002?=
 =?utf-8?B?c0dRTlQxVTJraU1RRmFpbWpnYnovYmJLMEhSbDllNzY2YlVWajdielBhNk1B?=
 =?utf-8?Q?sQMlfYTLaCKHl7p56w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccf2898-71c4-40d6-cb19-08ded108bee8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:21:02.7539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRfsaXDh1c0OD1jBOdtjTDctWKG0kxvv7obbdlzeDyyXHH87Aja0E0SiKFwnJW5+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9771
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

On 6/23/26 10:12, Srinivasan Shanmugam wrote:
> Current VM fault handling resolves PASIDs through VM state:
> 
> 	PASID -> VM
> 
> That is sufficient for VM fault handling, but process-scoped event
> delivery paths need a different semantic mapping:
> 
> 	PASID -> amdgpu_fpriv
> 
> Although both mappings are indexed by PASID, they serve different
> purposes:
> 
> 	vm_manager.pasids
> 		PASID -> VM fault handling
> 
> 	vm_manager.pasid_fprivs
> 		PASID -> process-scoped DRM file-private owner
> 
> Add a PASID fpriv xarray beside the existing PASID to VM xarray.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 450bd9dc6bc0..3141ae1383b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2869,6 +2869,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>  #endif
>  
>  	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
> +	xa_init_flags(&adev->vm_manager.pasid_fprivs,
> +		      XA_FLAGS_LOCK_IRQ);

I think we should completely remove &adev->vm_manager.pasids.

Take a look at amdgpu_pasid_alloc(), we already store the PASIDs in the global amdgpu_pasid_xa xarray.

But instead of a real value we just give xa_mk_value(0) as dummy for the entry.

I think we can re-use that array to store pasid->fpriv mapping. It just needs proper locking and interface to retrive the fpriv for a pasid (while holding the XA lock irqsave).

Let me know when you have more questions.

Regards,
Christian.

>  }
>  
>  /**
> @@ -2881,7 +2883,10 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>  {
>  	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
> +	WARN_ON(!xa_empty(&adev->vm_manager.pasid_fprivs));
> +
>  	xa_destroy(&adev->vm_manager.pasids);
> +	xa_destroy(&adev->vm_manager.pasid_fprivs);
>  
>  	amdgpu_vmid_mgr_fini(adev);
>  	amdgpu_pasid_mgr_cleanup();
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 4d96bb8c2c6d..5318e833bd97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -450,6 +450,8 @@ struct amdgpu_vm {
>  	struct amdgpu_vm_fault_info fault_info;
>  };
>  
> +struct amdgpu_fpriv;
> +
>  struct amdgpu_vm_manager {
>  	/* Handling of VMIDs */
>  	struct amdgpu_vmid_mgr			id_mgr[AMDGPU_MAX_VMHUBS];
> @@ -484,6 +486,17 @@ struct amdgpu_vm_manager {
>  	 * look up VM of a page fault
>  	 */
>  	struct xarray				pasids;
> +
> +	/*
> +	 * PASID to DRM file-private mapping.
> +	 *
> +	 * This is separate from @pasids. @pasids answers which VM
> +	 * should be used for VM fault handling, while @pasid_fprivs
> +	 * answers which DRM file-private owner should receive
> +	 * process-scoped events.
> +	 */
> +	struct xarray pasid_fprivs;
> +
>  	/* Global registration of recent page fault information */
>  	struct amdgpu_vm_fault_info	fault_info;
>  };

