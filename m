Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4344ECD5BB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 12:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D058210E2D9;
	Mon, 25 May 2026 12:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0VIBExdx";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC7E210E2D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 12:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6mveVneQJ85XkTkdruSRGyvryq0LQgBfKSc+sTCzkczSiaYLPf22gcD2Elrvn6NLXwb6x66RcxMzch4r/1rrbQ7WIqMkR1C37jFnRosgJrYLo+mewiqvRxO5SMttJyqUsOWAKy2w7Gkno6D9s1VBav1zzTYNbSw2MFc1Bf1KyejmY4//g0DpX+D1ZWtrjENo4B6yF9tbfVFuEKgezlnXORK9LNg3Fj7QLTy1rAL7d6E+9KR6cUIM2meKRxLwZ1Wk29tOs4uHMGpRIPdxpmUSwVdzqO10TGjgXHxe6O0U+A+0xbxiijdXsB71ftnRMHucqCKwxxLRrLEPnCUkTDM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgQaZfwyEk1Ne39lBtfbsMieM20OemnOukakPiCMLZU=;
 b=Q6tnJ/ciM6cs9I+DXR6IlpSHVABHg3Xo+HL0nM3dRlRZB89eyR7gOyqW9hDKxypmGEkkEu1Oxbt9IUcxuKRNRxVweRArpzPHJgBLR03ekavjq7VYYPVYu8wE1XVJSgxhAtkPe+UUujT6zbqNe6IO0E81Nh4DPaYRWrmCPAnES5Uxj6xx2AejWDIdlpV1gAStHCR40kzZAwty1PcEzPuF2vcmxWrFZb2ubgCVjwY/3OR82c4dxXoEZaNvgm70pfY5QuQqmq8LOuUchEt/+M3TNL9l952zmqTjYmXEVhVJTiBkbenar4D1BaJe8TUMPEmhKQwA2Z3Cf5RDeSvVBySY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgQaZfwyEk1Ne39lBtfbsMieM20OemnOukakPiCMLZU=;
 b=0VIBExdx5y1PTAGmSQ3glCzlpA5U8J1V2538slFWkYolwoCubAoO2OdCXq99SMexUeVNIKh1hw/wI/k3ZU5uiJaHZXklEN1QXmU1BQuwK+xGhRTCTORHpPs2BZcMXTZQANPe+8jWK82Aag+nwkqLL8X+BCr1aZv+bO8M+DhAFA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 12:36:17 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 12:36:17 +0000
Message-ID: <43861179-4521-4625-9af0-a659a905d384@amd.com>
Date: Mon, 25 May 2026 18:06:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: re-enable MC access after hw_fini on SMU
 V15 APUs
To: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Cc: Suresh Guttula <Suresh.Guttula@amd.com>
References: <20260525121812.2250104-1-Shubhankar.MilindSardeshpande@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260525121812.2250104-1-Shubhankar.MilindSardeshpande@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BN3PR12MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e3c6a5-5b0c-4edc-a01d-08deba5a3782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: jXd9QubYqlxQ94ykf7QJ0cc39rgO6xv0w16nG0BNcQmJpixlXlyU9qpspL6NHuTE/H8gCQCvFI2+dYnL1itfR/hvg4/CrPqhvQO2+aE/6AuPNKPqxsB307X+XauB/a82LA2BI4pcDGKUv8jtxzCbc4RMcJDTQ5fjapFUj+soN5xUrYUpHlx897Om12bWOBvu2l+p/yVzeeIxIlJNPh7RDUut0YYSUxnVsD/Zc1BSK2+I+ZymnF7eOD0y8wWQvLceWYDdvBNCc6cRqV7sOB9qiWvw/y40GXJpPdvZdqYcgfpbxAxxs+GaSsOU1aBWurSC3o5nBHVrL0Fd8NXoqygMq3LSXK24JXcyY77UPm8g9MKjjz0o6dyifc3nDgSnpAr+lZ4MspPtUaKcYPpnNm03RxF1+v+b1N62sk+LHO0X9aWoF7tA4lbR23AE/zYUeBal2D8dcQAcLfuBo0R1I21UceCGUxHw+KKIhJ/YwGXZMV4m8bUN+IEHeEj1QpTzE0TG8ocBaiEglpTtGsyrzJ8uUwtUexuIXzqL3Bww5paNf2hDUeAj08XG4PAnF4q2H7VozrUm0KqXMSYbVwdf4ykC0skk+ByR3UV8v/BMj7YZXv66LV6HHVcHoiJj0IEa5WBKGh1kYwb+NXbmAmzZizj41wfimt6Wiwcz2nkyROU7MzqZS4c3D//65snKGYSPNQ1G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmY5cEdGczcxZU5EcnQ3TmtMN1JORTV0V3M1WEswaDl1ZFlVYzd5Ynd5SGpW?=
 =?utf-8?B?WjNYVGN3T3kyNFVmZUl4T21lSmZST1UzYVJxN29UcTNlSVhoVFVOT2hSSk43?=
 =?utf-8?B?TWVBNnRtOWFuTW5rWkd1TnVzYU5lRndKcUhPQkdJSnN6QTNuMElxbGdqdi92?=
 =?utf-8?B?ZElQMVZXTTJubUFyUDZKTlo2WTgydjNBU0Y0M0J5ZkVTYklQWU9jUDlocks4?=
 =?utf-8?B?UnBiZThFRU1Cd0FLTkZjWWpzQnYvNDRKamlDbUtUdkJNM0RYNVdBeHNRNkNn?=
 =?utf-8?B?SzNiY2VwRHJYWXpVa0N2VkJpTVZtcTdmS2RDMVZBYzl5ZThKNWptamhQZGhI?=
 =?utf-8?B?S1pWUVVhSGw4VDRLWkJJcnNmL3N6UW83ZHVYOS90c0RwdkZ1b0wyVWNmN1dI?=
 =?utf-8?B?U2pDQlJRUTd0cWpydjhmNVZGK3haQ2hZNG12NFZUdTRwd2FTcy8xQ2tDNy91?=
 =?utf-8?B?NlQzSWVabXFzYUFITEMreGxSQzZ5bnJ6ZXVZOTZCSnVxMzE5YnFwdUFLOGRV?=
 =?utf-8?B?MWVIcmtKOUd4cnhCVTVrUGRock9pdEN4VnB3SUpSQzFmRVZjSXcvSFJGVlNU?=
 =?utf-8?B?RFJBRkJMVVNXaCtwcXJEeTlGZm15K1lxUThnVkU0RXVXRDRhYmdET1VuR1N2?=
 =?utf-8?B?bU8xd3FWM3dZMzhiWGZDaXNMK3lVdHdmdlVUU2orMmxzMTdCOTdGSkJHeUVB?=
 =?utf-8?B?SVRRY2R5bkFtL3dQYXBvak11VitxTHgxblJmT0F4UWJvR1ZGYUNIaHdZQTdT?=
 =?utf-8?B?UEJ4ajFhano5Y01FQ0dEdDIxM1poSUJFeTc4S2ZZYnk5NkdxZmtVcjZ2aTZV?=
 =?utf-8?B?T0ZSd1AycXZ1WEJHZS8zY1BwRytQSU5KMU56OWxhUEQxYVNvN0ZxMjlVR1V6?=
 =?utf-8?B?YmYxYXNPZWhOcHRLSnhoZ0NFdGkyb0hOU3hmNjVEempyci9qcXpSUmptT1BC?=
 =?utf-8?B?cEZrTkRDMFIxUnNiN1Y3K24yS1pzWkI0Uzg2alJ6eVFvZUhuWDN6YWZTaFJ0?=
 =?utf-8?B?SCtKK2tFWFZlQUIzUmlqZUZlaEJwZ2t2WVpUeCtFUHIrYmxsR2ZYRDZuaWRK?=
 =?utf-8?B?a0NJUXo4SWN4dW9JVE9BdlFFU1RGdU5iYXpZQUtqZzZkQVRoeW1rRzZBWlFp?=
 =?utf-8?B?OEo4b0czWjB6UXgwcDZCaUVkRWxidnlTcG1iTzluRTJvVDZDV2VzL0hNTGhx?=
 =?utf-8?B?Y2k4V29HNnpJcCtHWlJKblBNVWRwbDlJWmNvSHhlaitnckxFZ0FuR2RmQm41?=
 =?utf-8?B?ZE4yODJZTWN3K0NrcWp4RC9XcGY1UmVBdTZ1NTlITjNTdEVqSDYwSjZLQnlJ?=
 =?utf-8?B?RDVSdXd5ejhnV2NjWldCNG03Z2srVDcwRnBORFVEdEJ0V2ZNWFlRRkF4UEhY?=
 =?utf-8?B?Vy9pU1lLcExqekNkcmpQZGlyVHArcUJjallaV2w3Wk5ZeVVEeXorUzZidkk3?=
 =?utf-8?B?Mksxb1ZJekw2enpsYUo0Q1lFU2YrL0t5cVRvSUVjcEhURHI2Q2xYKzZyTzZY?=
 =?utf-8?B?aG1jOXg5YWREK05WZ1c0UHZrcTQ2bkhVVGVhY3JZeWRtc0xtOElNVnd5RFJC?=
 =?utf-8?B?YlR0d1d0RXBDNUNPYVVqWmpjQi94Tmg2NjdKTjNmYUNvVGJZblJJcjd3dDk2?=
 =?utf-8?B?cG9acko4ZHBwSHZzMWw5WkFDVkI4aWoySlR0TEpXVFdjN2psY3ZzeVZhbEhN?=
 =?utf-8?B?OGhmak1EY2JveVhRTnAzZGp6UW9aVlZnbEVwNGFhYVh6OU4xR3M2RzNXMVBw?=
 =?utf-8?B?U0QvK0dFTEdpZzBwS1hvNXcrKzUwZVFpVXhkQmpOdDQrUWFMMklkeDgwT00x?=
 =?utf-8?B?MmF1TFdhbXFLUUJiYUZBMHRwd2pDQ1FBZk5IaE55UUtRUWtWMzFJU3VTOWhY?=
 =?utf-8?B?T0hPZ01yVFpuVGNkL0hBQVJaR2RxN3BPZ1ZPWW56MmhVeWFhdHJORmxiWWFp?=
 =?utf-8?B?MVc5YVpsN2hsOGlBeGhtdGhwWDZwTUYvZit1TW9uNEhESnJDVU5IL3FLNlpz?=
 =?utf-8?B?VElBUjg4VXkyckxNcTFra21VdnVOKzEzOWtHRElnTFZkTjhCYzJPcnpTd0g1?=
 =?utf-8?B?QTNsdzc3OG41N3luT0RRRGpkRFVmRXJrZFVHRFZSejJyd25UQVpxNHNJZWFw?=
 =?utf-8?B?Nk5XenhELzdhdkVOaDF1ZzFENGNyZTUrOHV4NmNRSlNpNThZMGMxK0wydTB1?=
 =?utf-8?B?MlhjcEI0M3Z4THhpVXZTV2tXVDFsUzR0Z254Z01UYmEyc2M4MWxmOWhPRWJq?=
 =?utf-8?B?TEpqMjcwY3FwWmhoUWZWOW42Kzl3dVp3RWpGNnQrdWxhSklzM2R1VnBjODdr?=
 =?utf-8?Q?wMZ7b7cLZ0i0FZQPBZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e3c6a5-5b0c-4edc-a01d-08deba5a3782
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 12:36:17.6073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t0/E2vH5U7EiiTp3gdp7xSEFOfUESjNI4WFBxkb19xKT1FK22u9N3KGPW94dJBn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570
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



On 25-May-26 5:48 PM, Shubhankar Milind Sardeshpande wrote:
> During amdgpu_ip_block_hw_fini(), the driver sends a prepare-for-unload
> message to PMFW. PMFW then performs nBIF and SYSHUB function-level
> resets (FLR), disabling PCIe CFG space reset, which clears the FB
> enable bit to zero and disables MC (memory controller) access from the
> host.
> 
> Re-enable MC access via the nbio mc_access_enable callback after
> hw_fini completes, scoped to APUs with SMU V15.
> 
> Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
> Signed-off-by: Suresh Guttula <Suresh.Guttula@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ccbe6c885cf..7af9065ee5d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2826,6 +2826,13 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   		amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
>   	}
>   
> +	/* SMU resets BIF_FB_EN to zero during hw_fini, re-enable MC access
> +	 * on APUs with SMU V15 */
> +	if ((adev->flags & AMD_IS_APU) &&
> +	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 0) &&
> +	    adev->nbio.funcs && adev->nbio.funcs->mc_access_enable)
> +		adev->nbio.funcs->mc_access_enable(adev, true);
> +

Could you keep this inside smu_v15_0_0_system_features_control?

Thanks,
Lijo

>   	if (amdgpu_sriov_vf(adev)) {
>   		if (amdgpu_virt_release_full_gpu(adev, false))
>   			dev_err(adev->dev,

