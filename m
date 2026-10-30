Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A4606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jBYGK5ob
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B383E10E130;
	Fri, 30 Oct 2026 12:26:45 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDD610E139
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 12:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JH+LilOZbjqcU0IfAZHV7f9oozPCvNYePlNcXuZ7VnsTSHnyBu+eIvNZyXzY3MFA7gvpNFbr1qwRXDn7WvrsWCdyIVXa06I1f/6vpVMYVR+j36iFrP2CfQ8PrKVYHSx/BbSu1Ha1q3U7X17GMiB2fYPb9d3A3RWCCXFTl5TcuZPo0eI/aa56TrD0E1KL6uadprBpTxNo24cUHgdIAOgRgdvaCobPEVBfdo7xaJgiBw8nh2SO/rvOKohpB32de7JuOUGZ2Hue1TiS3tp5Ab/tVhfGyqiEF2tJPoVgQtzpons4NGFZGbRNwH+Su1B225jt03sLDKhscuVZnhHMswXSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YqvRhrdVtnU8hP6jyOJ5W69G565skT5aLcJnxxlR2g=;
 b=v4Lyw3qp7dKizZUI0d1gjmVOu4w+tmZTcR6We8SrQheZ33byRMmdqHoNFeKUf2h/XIGaAc+AvcRSEOJUnHQsEQpucBhstwINwqulq+rynNgqZ91i+Nhyp+jjAkx+z2t+zycQ0MAy9/MpaZFBjQVGAXsF/kWzIUhrpiDST8hM4f89e7U6Zk1Dv8NI/ALoABl0hyDfbJ39Z5tEcRrq1/3ZXv7B4pRDx7ZZZwZS8lMgSEqhmidybYvfsNJMXW/8wAi06SXLN2FgY4GrdzXnE4Gn85q8Ed8//Iur+oXOWpkTvU9To53V4+4YTB0pir9r2QvCI58s5hlOnfnW5DmjYObZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YqvRhrdVtnU8hP6jyOJ5W69G565skT5aLcJnxxlR2g=;
 b=jBYGK5ob53K8lpRT1rixdSWBa+tacRd4XZy/32zSA0GBRTZilrC7mmxipHbKJg59S6tASWC+5mgy72kExFzPLGN9oUGSiTqhsoJn2OC2uOt4SESeRzvWRymLNHrGNEp07TOF0IKs8Yh9ow2pe5Uwpf4tjsMsJhMQyjXeEDQj20M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:26:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Fri, 30 Oct 2026
 12:26:35 +0000
Message-ID: <5c7f52c4-9b54-4987-b29e-d115ebec5a17@amd.com>
Date: Fri, 30 Oct 2026 13:26:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/gfx11: program the SPM VMID once the
 RLC runs
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
References: <20261030090043.652799-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261030090043.652799-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: c7757d76-ab13-4b47-9448-08df368109a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|5023799004|261028144727099003|261021121427099003|261022105027099003|261021123027099003|11063799006|10067099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: mAvMd9nmPPwIMYuXShe/zp8VC4fBBeYPtvluodhfyEek1z3VEQPuJNhCIFBfnQIXAuaZKTdzMU+CJth5sHTFarxiOp3DAqwpufkkh32OjVZGfMYGZ2N7kCzab2hrJ/LZbe4FsMeNgpn9kYlDBRNj+JTzlKWUC6tQtswdw+vlaTOGlckgg+fAgUQn5qzl1KK5X1++ifR9Dfdt/ZKTOxsaLT3pDiV8+Fwzqrlx8uLlTy+te/n7f/5kK1DaLuUIUJJO4Jl0y+gl6iUxgn/lEkbtW7SJkqE50KXLmxrjU+BBgWeIivxlnmhGgLYaHoKQX9iaqmSL3h+q0FpJ30iqmTxdWOSYb3bmqbeDbM91NK0CFh7s1FOHY/jzriYO0Xb0K75aA2to3ZgVb/AWq6RBKPmByigggl0fCKgv9B7860shpayjwwP5xKTpwpoR2o5Riysxb6dEvGGAirQDt5RGfxORSLmVVVj009YM0K4WmOtG0XYW3sZqNdeSSjfHs2HHiRt16pLSZw9usemU1/KBlk3++IgQ7slpYeOKOf7ZD/GflQpCEbHKo4o68mVDLWGaToa8y2shSE5T6UMdMTpuPn/V6jW2DvaxvB5qD4u+4bFWxeGX6EwQpBBi1oxpRM0/m2Luey6uqpRTncVbK7DovogVsBFE5bA/837reHdLLzg+4rk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(5023799004)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(11063799006)(10067099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDd6S3pvMUtzS29lb3dScTI2TW9Yc2FZZmRsVER0RHd3N0FnUFp2MjNkSzJk?=
 =?utf-8?B?UzNKcFVHdUpHQVZqSXBWTkNnbmx3UzVtRHppYzgwMjk4YlY4SnpFWEMxemdq?=
 =?utf-8?B?SC9rME1HUFovb2FiNkowOWJCVnRDa3RNajRxQ2lIVkVWQmZEVFNWejJSeFhr?=
 =?utf-8?B?WHBvRHQ5cm9yS1Q2MHQ3SENhY1d5SnFER1FDQng0U1ZUb1gzUSthNTBRU2E3?=
 =?utf-8?B?RHVacklWclBtQ3BJWDNOY09iZmt6WjY0TWZHL09PNjlwNnJjQ3hvT1YyYmhi?=
 =?utf-8?B?cldBYVRIbDN2am9jRlVPSldYNjFKbGRYWVlqc3M0YUZtTFQ2d1p1MFh2V25Q?=
 =?utf-8?B?UDY3RHpodUlKWU5Qd0xyaVVYR3lYWWZhQStnVkxySWVJMVdZOTl2Rkp1VWQv?=
 =?utf-8?B?ajlBalM5OGxQTzVHb2wwWUUvdFNVaGZON2Y2OUN1YXpieXJlWElGRlZuRHV0?=
 =?utf-8?B?YWk4YWVMd0syUmU0Um41YkczeWVRZGJHYXBGcmVhN0czMnBxRzVLRXRrd09O?=
 =?utf-8?B?Y3VtTHMyLzVGODBIRUxxL0RyUHhtWi9BaUpZYUwzeWRqQklZeEI5UExrTDhY?=
 =?utf-8?B?RFUxNW5kRUV5aHNQTmxEWGxQVHJ1TjRjWkpwZHN1LzV0MGFtUy9iSW1aUWk5?=
 =?utf-8?B?d0hGL1BjTGV3UGVWZTNzTWtEVGlaZndoT1RHcVRTYVhmQ3JaVVZHY0JWcExM?=
 =?utf-8?B?TFhGVDFlUmZsR0FINUpYM24wdmM2b1VudlNFeGlSazk5S29PMXRUMGo0WGJh?=
 =?utf-8?B?QlZaYnNSQWhxNC9wMENxRklwOHkzSzNxTG1hdmJMWFVubTNyWjMzdXFRZlZQ?=
 =?utf-8?B?UXU0MTdVcUJrSVY5Z2g3TFhxT3hPNXkvZGFrWENKdUo1TjlQWGttNi90MFg4?=
 =?utf-8?B?Z3kyejVKN2xDQ3FlNEZqeEJMWWVSQ1k4YVRoV1JPOXlRdkJqN3FLVzVETGxt?=
 =?utf-8?B?eUxNN09Gak5lK2lGMmVpVlZZcEwvd0JNN3hwb050MWlXd1JhWmQ3VVV5UHpM?=
 =?utf-8?B?QXhMcmkxOGJOdXFYL0U4UElpbkZjS01STGxpRFBudGZQWDJSZmNZZnQra3Qy?=
 =?utf-8?B?bHJyWHMvZklEdnFtYUpzTFB0S2MzSEtUK3JFWk1TeXl0b2x0RTVlOTBWejFS?=
 =?utf-8?B?bGZQMmZMbEJtcDN5aVRvMjY3OXlDWEYvL1ppMXRZay8yeC90cGQ4dGZVeFla?=
 =?utf-8?B?bm15ZTV4K0gxWEJFMmc5d294MGhYZVRMQVM2akVZNFMzUmxMVGRjaloyeGFS?=
 =?utf-8?B?UXlpMDdqb2wzN1Z3aUJ3eFYrMTJMVVJlcEVBcXZscTlSNjFFL2RRYjEvL0hC?=
 =?utf-8?B?eUllRk9ub2t6SEZ3ekFKRW9tS2FSZlhXWEpURVU3N0R4R1R1UXdwdDJMRFVD?=
 =?utf-8?B?Zkx2ZHdIMU44dFJmZzRNSFQveVJvd0d1ZDJHK2hURFVCSDNRWndHbG9ucWpn?=
 =?utf-8?B?VHJmd29iT3RTYzRMMVMxMXlrWXp4d3QxdGdYOVlSdGJKZE5tbU1Ub2UxcE54?=
 =?utf-8?B?QWJqdk02aXVsK0huTG1xc09DamkrRmx1ei9kVThiWnNSeHhHcUhoYXRXOFlx?=
 =?utf-8?B?SmI1eFNRMVorN2tTd3RuUWh0Lyt0V1duYWtBeHY1RFA3TEViMkdLYkJYLyt0?=
 =?utf-8?B?ZHNSc2RUanR6ajlwVzdCWGw2dHJkY1Y2MFlxVmxOQmNZcEFNQ2N1d1g2UnBh?=
 =?utf-8?B?ekpMU0Z0azJTbjRqZUpaK2tHTGFUd2RUUGFPZDF6aE5zQTFTTVdkWndsb0g5?=
 =?utf-8?B?eUlFTHYwV3RXMWpyaTRJem1rYWhUdTRxMVFpVlAvZlg3SUY2b0ZmajUvNU9C?=
 =?utf-8?B?RUwvbCtmdGN2aVJJRGlSY1Y3b09HZ05NU2lQa2xFNDZiazRQRjNjN1Frc2hG?=
 =?utf-8?B?WDZMQzkrelc1Z2hac2RwM3BWM2RleFN2aFQxN2NzaDk0a1JEVENQRk4xZ0Vm?=
 =?utf-8?B?S3l5R1A5QjVYMHNKYmdDODIwa1hYeWI5VlozQzR5aS9wVWNHUmRnaCt3OVVH?=
 =?utf-8?B?WksxeU9qYWt6SllSMzBUSVNFbW12bE9lb1NyK043eHZMYm9OU1ZUTEU5eGJ6?=
 =?utf-8?B?QzhuRStYaHFqVjdRbzZvcjBnOTdURWs0VGtxaUhzVFJGTTJRNzRPcStSU24r?=
 =?utf-8?B?Q3FjMXluVHI2RHVFODZ2MXFFWlVGUHZRZ0J6SUNOM0R1cWNnblBLU29wbDRl?=
 =?utf-8?B?dmNRSkVXUWYxQzZ4RWkrdVJERTFCdXdHUnk1ZzJDZnRUMnFLSDcxblhiR3dJ?=
 =?utf-8?B?MldVRkxLMlFoYnlXUDF0cFZLN29GVW8rZFF3U3hqT1Z6UFFMMTlGQVRDWmtR?=
 =?utf-8?Q?LzkTQi7XBmFwGqGT0b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7757d76-ab13-4b47-9448-08df368109a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:26:35.2994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlURGVG07JAIIYZpQaWZ7ICCbsGKHH5PCx5dJp9694ic0Qf5qJX6YZ8QMuKl21+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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

On 10/30/26 09:59, Jesse Zhang wrote:
> GFX11 programs the SPM VMID into RLC_SPM_MC_CNTL only in
> gfx_v11_0_rlc_init(), which runs during sw_init, before hw_init starts the
> RLC. The RLC comes up with the register cleared, and nothing programs it
> again after a GPU reset or a resume either. Until commit 38e07c072833
> ("drm/amdgpu: remove the now-redundant runtime SPM VMID update") the
> update on submission covered that up; since then a process which reserved
> the VMID for SPM never gets it. GFX9 and GFX10 program it in the RLC
> resume instead.
> 
> Program it at the end of the RLC resume, which runs on hw_init, GPU reset
> and resume, like GFX9 and GFX10 do, and call the gfx function directly
> instead of going through the update_spm_vmid() callback.
> 
> This doesn't cover GFXOFF, the RLC doesn't save and restore
> RLC_SPM_MC_CNTL over it.
> 
> v2: new patch, split the init ordering out of the GFXOFF issue
> 
> Fixes: 38e07c072833 ("drm/amdgpu: remove the now-redundant runtime SPM VMID update")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index cdf543f1cd9a..cb2c4d0dab87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -362,6 +362,8 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
>  					   bool all_hub, uint8_t dst_sel);
>  static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
> +static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> +				      unsigned int vmid);
>  static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
>  static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
>  				      bool enable);
> @@ -942,10 +944,6 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
>  			return r;
>  	}
>  
> -	/* init spm vmid with 0xf */
> -	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> -
>  	return 0;
>  }
>  
> @@ -2582,6 +2580,13 @@ static int gfx_v11_0_rlc_resume(struct amdgpu_device *adev)
>  
>  		adev->gfx.rlc.funcs->start(adev);
>  	}
> +
> +	/*
> +	 * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM VMID
> +	 * once it runs, also after a GPU reset or a resume.
> +	 */
> +	gfx_v11_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +
>  	return 0;
>  }
>  

