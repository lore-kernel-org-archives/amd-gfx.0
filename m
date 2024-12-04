Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AB0E7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 07:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8757210E0E4;
	Wed,  4 Dec 2024 07:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VDLKjmyn";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8098F10E0E4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 07:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VikL5VBzF7gigk8/Zyytub04Ag6PCtCoYmkriY3vlQbgjhQzxIb0som0cXdC4uYZ1NDu2LHrILy+f79eXre4nx3QZ2/4/AyCS540FC9hHtVOkXksXKY/giL2wOA2WPDhiy55Vpy3+BlVmY/E7Uh7C9a3J7SwIyfinddr6XmJNV4cY78Iy0XJCC58P5COttCLGnl9dMFmbSduNcRNHAMY7ReBM2XN+G9k4kX3AsrNh4O1vo4pOvAbIuU9l/ueadmzWqlY9EjsoA+xwT/QUAF287qUMTjkFc4C41S7peqXMmlpWfQQWd0URhizPo+Tjsl/UpmnoroYS4Xri0nNPL5xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVeyKQ41f653au/PdPdoawPNRNoLVqstgiAy2KeLK6o=;
 b=b1BW7tcvPS40A9he09Smn1xfIHvwI0+rt5CbBC70HMNgpGMEy7xSvOBoelUiFCG7N4BFmy34DEmqu1c74B4aEc8UD8esI5e6PSm+Y3u9myNLY91ULAYzyritB+6GAq+ZpahKUllww0W+eEPpHw19d74Al/7Xe7MPP118JH3fC2+s+/ye+pAJhRJmhuTNI1OJAC/QCB3LxVn2fJAzIgawVRSdOd8bCcY5RJhNzNbGlO3sHZ7cvjTMxlPym4c+LrhhXxIFMp2A/GQVzrjeXCmtp1C5Svm4DHaMwn+4xntd4AmSB3wM9R6Uescq2aqAF/Tj28nv1Dp8yhohPSlKU43KBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVeyKQ41f653au/PdPdoawPNRNoLVqstgiAy2KeLK6o=;
 b=VDLKjmynQv6Qt6YeAOU2rmYxdYHlBcOci+QimNpxob7fR9YTWxESds+R/C2bEixgKaF57bl1+OU8XP/8cISW1C9xAZi1aO2R9mephll6U2/oQWBj5R5F5cJCCu0NP9kqW/PqjFaU9wOyu95FM40hThHsMebdP9fyRw0hK2sAoi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 07:58:05 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 07:58:04 +0000
Content-Type: multipart/mixed; boundary="------------xf1Pge0xtd0qZBaPGm0E0wzL"
Message-ID: <1813ce01-4dcd-44c4-8db3-2c91426c456c@amd.com>
Date: Wed, 4 Dec 2024 13:27:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: set the default workload type to bootup type
 on smu v13.0.7
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kevinyang.wang@amd.com
References: <20241204070346.1295087-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241204070346.1295087-1-kenneth.feng@amd.com>
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 2041e2f5-2d75-4299-8d4f-08dd143961d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THZhVlJCd3pxTXM5SzFoNWttaVNRZzlpMFlpanI5ekpCaFEya1V5dnA2T1hT?=
 =?utf-8?B?cmpRai9lZ3FibTZ3Y25uZW1acGI5Q0Z4WnZIQlhtQ2dySWIyVkNtaU1iRE52?=
 =?utf-8?B?MjI3WUJ4YnBLeXlVK3MramNMRnp3MmlINElKc1Z3M3B1NjI5bGRrTnZKMG1Q?=
 =?utf-8?B?NXAzQVZaenVPbG16Lzk1Qzc2aHpnRkpzT0MzT2g4YllyTzJ4ZURUT1g3U1N5?=
 =?utf-8?B?Z1hyb0VYL0tqd3VpRk1lRWRucnZxRnpva0RGdWc4blhpS2VURnJ2SnBSaFkv?=
 =?utf-8?B?bUI5UmtPaWk4RWl1S3Yza3R5V2crNWFnKzU5eW96Q2RObFNrZEY3bjFjeTRz?=
 =?utf-8?B?TFZyQkhJQ2NtSXZNcE13dzAyUDB1Qy8ra2E4S3V1Wlg0dDhFaE15VnN0RlFa?=
 =?utf-8?B?ekNyRjM3OFlpenBqeVlXWjBvSzFmL01NcFhwbTNSald6VXFTSU9GRjNVQkI2?=
 =?utf-8?B?aCtlNU5oNVBmWDc0WnlDSXNCeXJDVnpmK0hsQ3Evb2U2a3ZhWWY2dWJNYkZH?=
 =?utf-8?B?SHV6amRyK2VWMXFWSThyNU9JcXhhbzFvMW8vT0N0dGpUQ0JodmM2TlNzWWtx?=
 =?utf-8?B?ZHJwMlI4RDBEcEkrdU9XRVFpbHRmcVZ1V3FqY0RWL3hFWDc4QzFoNHRDczNw?=
 =?utf-8?B?V3RqckZWalpUZStKM3E1N0xKamE4WXEwMk1JN3R3eGlIbGFMR0lJKzg5WFdT?=
 =?utf-8?B?YjdHMTA5M3RzY0VMeWhoZlU5QzFYOHAvODBwYzlCS1VBL2w3WldQV2xUUUYv?=
 =?utf-8?B?WWFmbzBsZ0FKVkpsTEEydUlkejhKWGsyU2g3bGJnK211Rm1JOTZJUU9FUG5N?=
 =?utf-8?B?Rzg0eERBVnB6TTJ1U2pqdnFKMUladWlaQU9SWDVpd0lacU90WlNpZm5kanFL?=
 =?utf-8?B?aXVGRlNidUEzZ3FSVFhqdUpPWXFPa3pldzFpeW8rZXN3dEdVb2puU0IyS3Ex?=
 =?utf-8?B?dEgzdkdkczFqTVRYeEZHQXg5Y1VkMitrWFcya2VzdE5OL2pwczZIelcyZkFG?=
 =?utf-8?B?NDF5L0xkVnRHUlF3QnkrVUdjbGlEWmg5QVZqT2dNYk5SMko2QWF1TWpjZHN1?=
 =?utf-8?B?bjVFZkF1aU9GZ25zL2pRb2F0dml0RXd1djlPNEpBUXNoTFVkOGxmbzMrNWNC?=
 =?utf-8?B?UmV3dTdrOVQ2VDFUdVZud21IQ1UyYm9YT29aMVk0WW05WXZSdVVZMzNuR3Er?=
 =?utf-8?B?TGZSK0E5R1AraHNSY2dZakR1NnA2MnoybFYwRElOM2E4MXBMdmdXaDNtQk9v?=
 =?utf-8?B?clIzcVcxUFZSc0NqZ2JMUUJwM2xMa1NlQ25HWFUwRnp3Vks5MXVOT0Q1NUdu?=
 =?utf-8?B?OHJuWWVTV1NCelVKMXRsaEwwamNWKzlRc01WejhjN255MnNCWnYzRWtVcTI0?=
 =?utf-8?B?ZkxYR3NVVXh0T1RScXlSbXRMSjhjc3ZrZzVYb1E0NkQ5UUJnT3hRemsrWGRN?=
 =?utf-8?B?M2NVZWQ3VDZuS05kdS8zSkNXMHZURFhOb215RHNFbFRXY1BCTDVCaGlVcFZo?=
 =?utf-8?B?OFMxa28vakxrR3FnN1UzbVYyNldOWERtbFJ0alo3cUoyMDd4Y2lESFh0WHMz?=
 =?utf-8?B?amlHbVhiYXNGRC90bWUydmt1cEZPaGlkbUN1L3RveFBLMk95Z08rNFdmQm43?=
 =?utf-8?B?eXBscndUeWRWQVR4a1hZWllhU0ExNndBY3dLcUwzSWcxaWgyRWE5U25yM3Vo?=
 =?utf-8?B?TW1HZE85UzRIdko2OEVRMzRzZGFyWnBjWm80c2tyRzlldHhOdVJxMGhQbXI0?=
 =?utf-8?B?Mk1BRWV3cXpINmx1SEFhMlpzM0s1bWVzcUY5Zjl2a1FITzlYQzAxSlFiS1l3?=
 =?utf-8?Q?MAirhUdiDLlztbgkV5nkwJAEtARk0yPPXlPds=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkRNbEhKenUzaHFBdW5OWnVPRUdYRFhqQ1dFbFBWdUtkYXlNUVJCUmRqMklx?=
 =?utf-8?B?NWEvZUhtMlRwK0tFRDFGUkdRdldnU2FoUUlocHUyTDhWUUM4ZVVUbjhWVG8w?=
 =?utf-8?B?MXBRQ3VKdEVFSmQ2SW40TzlXazF4eUxSYVd3ZnAwWW9UVDE1K0RwWjlEdElH?=
 =?utf-8?B?bml4b2s2NnczR25HYmp5Skdzb2pKUzM0VWRMVXYzS2s4TGNFUURpQXR4VEd4?=
 =?utf-8?B?b3NmSkZNMmRWVlRTT3lvY3J6MzZCK3F5aitJNmFZVmJaaVlFUkUyWVI2THg5?=
 =?utf-8?B?M3dPSGFUWjJqeUNoTk5ONkJKYWlveXJnWGpsRVcveCtreWwyVjAzNDNkTEFk?=
 =?utf-8?B?MzNSVkZ4RTlUY0o4OGo2NmRNaWtULzhqRmdsK3c4RFA1Yk1WUVp0N1V6Z1F4?=
 =?utf-8?B?bFl0eHROQTYxeUxiM3dGUElxM1RtZkNRU3hnWTA1R2xpSGl4aFhKcVVaeFl4?=
 =?utf-8?B?YjIxbjB1Z3lXTGo3UTBqcnA1RUNCRHduV1lxZjlJWVFCTHlqODV2N0NIR1pS?=
 =?utf-8?B?bzFmbzljeGcxUGJrY3gzOUsrU2o0Rm5mQmpZOUorMXBmU1BkK3hEVjZmMGs1?=
 =?utf-8?B?Nyt0eitKN3ZnMmJqTHFiQm10aktkRnR4eXd2bE5QUmFiVE9iY3lqcFREYzQ3?=
 =?utf-8?B?bStRNWtHOXU1L1BBc0x1VVhFeHQ2QWkxMm1KL1VPT3JOTUw2eHovcnkxQkVx?=
 =?utf-8?B?Q0JxcThSUW04ckhvNWFQaDhWL01oOGxRMVBOczZnWlNQNGI0cDhmNGJoeFJj?=
 =?utf-8?B?LzB2WlBCb0FlUkplVGlRYVowSDZORWR5SXZ3RGRnSmdKRWpMUUdvL2tBNnNs?=
 =?utf-8?B?NzhvWjVtcTFSZ0c3clNNY0s5RE5MTGpQaVFLY2FqSVdtd1NsSThHTkdZNGdI?=
 =?utf-8?B?dGJRNW91d2huNGFBQndjSll1YXVRbHFaaHJpbGpFb01rRDhSWE5rUmg3MWNr?=
 =?utf-8?B?T1dQVHF2MXZ0K29idis2WlZ2TXBRTkRMN2l2NzJDYWZKY2t4SUJsN2VsQU1u?=
 =?utf-8?B?bkNwdTQ4UCtLV20wZFhIQlpudDlIaFN2UDFSZ09KcVpjUFNpZUoydFRKSG5S?=
 =?utf-8?B?Y0QxaGJTcXhudmx4TkE0dXF5WTM4ZkNaVW53UHBCcENwbTA5ZzhGMC8zNXhz?=
 =?utf-8?B?OHZiOUNwd0FNNm9OQmJRV3pBMzJFNGgzOGZZamZMOWh4Q2VDVU1leTZqSTEx?=
 =?utf-8?B?WjJYVmYxVmhBZkhaektjT0o3UVo1bDgxSGlkL1ZmS2VxYXVLMU1TQ291ZXFl?=
 =?utf-8?B?RjJ2Z0kxWnJXM0JvOFBjS2V5SmE0di8wNnZJdkUvN0xNcmZ3bklyaXBlQ2NY?=
 =?utf-8?B?eHhVYXovL2JyRFFIa3JTbklTOHhXRkNpZEYxRGJQRkdTMXpiTjFLSG1pVFFy?=
 =?utf-8?B?eEZHZTc5cXQzZHFxeXYxby9UVEJ4Z21UQ3NJdGV0ZUh4MjF0dzRyWEtzbktE?=
 =?utf-8?B?cHhnSnlVa0hybDhheXdRWFczSEVZb2RqQjZPMnVWSWdWcitNUDdHcWxSRnNR?=
 =?utf-8?B?MkFMTnY3RHQ2Y1lkZ0RVNXFmVFpzTnNvWEFtKzY5M3VKMUI3alVIY0FHVWZz?=
 =?utf-8?B?eXFKb2krNDRMdXBXOE4yNGJ0c0R3cTdYWndGcUtlRlQ0WExRMWFQQzltZ3JU?=
 =?utf-8?B?R2FGNUVDMy9iVEhoRGtpR1BPWXdpc3h4TnZ2cnJEN0lXUURzeVI2d2dKRDRO?=
 =?utf-8?B?WElSaUU4eDdLbHJyWkRpQ1VGajhXUGtnWUEya2dGaEhFWVlzVmxiREVoUDVI?=
 =?utf-8?B?U2FUQXBPMUtkL3ZxZGg5YnIwL05UbDVSYU1WVHk5L25IVHg3VXFvQVU5bWxF?=
 =?utf-8?B?Q3FOZi9CcGR5U0Jtc1RKRVFhYXRDQlVUTmR4dzZoMFd1a2Nla2Q5REpBc1Uv?=
 =?utf-8?B?NGhzWWZXeWllS2daN1psdm00WHJSWHVaRjUydGllYUtRUVlYODJ2Wkp5NVpH?=
 =?utf-8?B?WmF5c3FuZldlRC9yWEgvWGdEWUZmZHVCZlhXMHorbnBpMzRqZXVaQm9jdjgv?=
 =?utf-8?B?b2VtQ29rRGxoS3pJNGVrVGtKeVlQWGw2M2Y1NlBSQWVtbkdVYmgrUlN6Rmw1?=
 =?utf-8?B?S2hhSWd3d2pDc0VtSStGdlRrbnl6MjlHbWVGUzk1dmFDQjlveHU2RkxnNGsy?=
 =?utf-8?Q?xIuMkL8lo9UEC8xtyU4SwF0Qf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2041e2f5-2d75-4299-8d4f-08dd143961d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 07:58:04.7927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoQ/uNvUOUaW5ZKmSZa+xIJjpYpYuehUspbUkug9hwoxqXw1I0v5J+vyMzUT0vJ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856
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

--------------xf1Pge0xtd0qZBaPGm0E0wzL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/4/2024 12:33 PM, Kenneth Feng wrote:
> Set the default workload type to bootup type on smu v13.0.7.
> This is because of the constraint on smu v13.0.7.
> Gfx activity has an even higher set point on 3D fullscreen
> mode than the one on bootup mode. This causes the 3D fullscreen
> mode's performance is worse than the bootup mode's performance
> for the lightweighted/medium workload. For the high workload,
> the performance is the same between 3D fullscreen mode and bootup
> mode.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index d1bab508ade2..c8eecb54a16d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1280,7 +1280,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>  
>  	if (smu->is_apu ||
> -	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
> +	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D) ||
> +		amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 7))

Instead of adding IP version here, what about the attached patches?

Thanks,
Lijo

>  		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>  	else
>  		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;

--------------xf1Pge0xtd0qZBaPGm0E0wzL
Content-Type: text/plain; charset=UTF-8;
 name="0001-drm-amd-pm-Initialize-power-profile-mode.patch"
Content-Disposition: attachment;
 filename="0001-drm-amd-pm-Initialize-power-profile-mode.patch"
Content-Transfer-Encoding: base64

RnJvbSA1YjNiYTgxZjBhNDRhZjMyYTE0ZmEwNWMzMGMwMjdmZmEzOTE3M2Q1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+CkRhdGU6
IFdlZCwgNCBEZWMgMjAyNCAxMzoxMToyOCArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0v
YW1kL3BtOiBJbml0aWFsaXplIHBvd2VyIHByb2ZpbGUgbW9kZQoKUmVmYWN0b3Igc3VjaCB0aGF0
IGluZGl2aWR1YWwgU01VIElQIHZlcnNpb25zIGNhbiBjaG9vc2UgdGhlIHN0YXJ0dXAKcG93ZXIg
cHJvZmlsZSBtb2RlLiBJZiBubyBwcmVmZXJlbmNlLCB0aGVuIHVzZSB0aGUgZ2VuZXJpYyBkZWZh
dWx0IHBvd2VyCnByb2ZpbGUgc2VsZWN0aW9uIGxvZ2ljLgoKU2lnbmVkLW9mZi1ieTogTGlqbyBM
YXphciA8bGlqby5sYXphckBhbWQuY29tPgotLS0KIC4uLi9ncHUvZHJtL2FtZC9pbmNsdWRlL2tn
ZF9wcF9pbnRlcmZhY2UuaCAgICB8ICAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
YW1kZ3B1X3NtdS5jICAgICB8IDI0ICsrKysrKysrKysrKystLS0tLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUva2dkX3BwX2ludGVyZmFjZS5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9pbmNsdWRlL2tnZF9wcF9pbnRlcmZhY2UuaAppbmRleCAxY2VjMDljYjVmYTcuLjhmNjAy
ODdhMTA2ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2tnZF9wcF9p
bnRlcmZhY2UuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUva2dkX3BwX2ludGVy
ZmFjZS5oCkBAIC0xNjQsNiArMTY0LDcgQEAgZW51bSBhbWRfcHBfdGFzayB7CiB9OwogCiBlbnVt
IFBQX1NNQ19QT1dFUl9QUk9GSUxFIHsKKwlQUF9TTUNfUE9XRVJfUFJPRklMRV9VTktOT1dOID0g
LTEsCiAJUFBfU01DX1BPV0VSX1BST0ZJTEVfQk9PVFVQX0RFRkFVTFQgPSAweDAsCiAJUFBfU01D
X1BPV0VSX1BST0ZJTEVfRlVMTFNDUkVFTjNEID0gMHgxLAogCVBQX1NNQ19QT1dFUl9QUk9GSUxF
X1BPV0VSU0FWSU5HICA9IDB4MiwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVf
c211LmMKaW5kZXggZDk5ZTNlMTI0ZjBhLi40MjZmOTg2ZmRiMTQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jCkBAIC03NjcsNiArNzY3LDcgQEAgc3RhdGljIGlu
dCBzbXVfZWFybHlfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykKIAlzbXUt
PnNtdV9iYWNvLnBsYXRmb3JtX3N1cHBvcnQgPSBmYWxzZTsKIAlzbXUtPnNtdV9iYWNvLm1hY29f
c3VwcG9ydCA9IGZhbHNlOwogCXNtdS0+dXNlcl9kcG1fcHJvZmlsZS5mYW5fbW9kZSA9IC0xOwor
CXNtdS0+cG93ZXJfcHJvZmlsZV9tb2RlID0gUFBfU01DX1BPV0VSX1BST0ZJTEVfVU5LTk9XTjsK
IAogCW11dGV4X2luaXQoJnNtdS0+bWVzc2FnZV9sb2NrKTsKIApAQCAtMTI1Nyw2ICsxMjU4LDIx
IEBAIHN0YXRpYyBib29sIHNtdV9pc193b3JrbG9hZF9wcm9maWxlX2F2YWlsYWJsZShzdHJ1Y3Qg
c211X2NvbnRleHQgKnNtdSwKIAlyZXR1cm4gc211LT53b3JrbG9hZF9tYXAgJiYgc211LT53b3Jr
bG9hZF9tYXBbcHJvZmlsZV0udmFsaWRfbWFwcGluZzsKIH0KIAorc3RhdGljIHZvaWQgc211X2lu
aXRfcG93ZXJfcHJvZmlsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKK3sKKwlpZiAoc211LT5w
b3dlcl9wcm9maWxlX21vZGUgPT0gUFBfU01DX1BPV0VSX1BST0ZJTEVfVU5LTk9XTikgeworCQlp
ZiAoc211LT5pc19hcHUgfHwKKwkJICAgICFzbXVfaXNfd29ya2xvYWRfcHJvZmlsZV9hdmFpbGFi
bGUoCisJCQkgICAgc211LCBQUF9TTUNfUE9XRVJfUFJPRklMRV9GVUxMU0NSRUVOM0QpKQorCQkJ
c211LT5wb3dlcl9wcm9maWxlX21vZGUgPQorCQkJCVBQX1NNQ19QT1dFUl9QUk9GSUxFX0JPT1RV
UF9ERUZBVUxUOworCQllbHNlCisJCQlzbXUtPnBvd2VyX3Byb2ZpbGVfbW9kZSA9CisJCQkJUFBf
U01DX1BPV0VSX1BST0ZJTEVfRlVMTFNDUkVFTjNEOworCX0KKwlzbXVfcG93ZXJfcHJvZmlsZV9t
b2RlX2dldChzbXUsIHNtdS0+cG93ZXJfcHJvZmlsZV9tb2RlKTsKK30KKwogc3RhdGljIGludCBz
bXVfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykKIHsKIAlzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiA9IGlwX2Jsb2NrLT5hZGV2OwpAQCAtMTI3OSwxMyArMTI5NSw3
IEBAIHN0YXRpYyBpbnQgc211X3N3X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxv
Y2spCiAJYXRvbWljX3NldCgmc211LT5zbXVfcG93ZXIucG93ZXJfZ2F0ZS52cGVfZ2F0ZWQsIDEp
OwogCWF0b21pY19zZXQoJnNtdS0+c211X3Bvd2VyLnBvd2VyX2dhdGUudW1zY2hfbW1fZ2F0ZWQs
IDEpOwogCi0JaWYgKHNtdS0+aXNfYXB1IHx8Ci0JICAgICFzbXVfaXNfd29ya2xvYWRfcHJvZmls
ZV9hdmFpbGFibGUoc211LCBQUF9TTUNfUE9XRVJfUFJPRklMRV9GVUxMU0NSRUVOM0QpKQotCQlz
bXUtPnBvd2VyX3Byb2ZpbGVfbW9kZSA9IFBQX1NNQ19QT1dFUl9QUk9GSUxFX0JPT1RVUF9ERUZB
VUxUOwotCWVsc2UKLQkJc211LT5wb3dlcl9wcm9maWxlX21vZGUgPSBQUF9TTUNfUE9XRVJfUFJP
RklMRV9GVUxMU0NSRUVOM0Q7Ci0Jc211X3Bvd2VyX3Byb2ZpbGVfbW9kZV9nZXQoc211LCBzbXUt
PnBvd2VyX3Byb2ZpbGVfbW9kZSk7Ci0KKwlzbXVfaW5pdF9wb3dlcl9wcm9maWxlKHNtdSk7CiAJ
c211LT5kaXNwbGF5X2NvbmZpZyA9ICZhZGV2LT5wbS5wbV9kaXNwbGF5X2NmZzsKIAogCXNtdS0+
c211X2RwbS5kcG1fbGV2ZWwgPSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9BVVRPOwotLSAKMi4yNS4x
Cgo=

--------------xf1Pge0xtd0qZBaPGm0E0wzL
Content-Type: text/plain; charset=UTF-8;
 name="0002-drm-amd-pm-Set-SMU-v13.0.7-default-workload-type.patch"
Content-Disposition: attachment;
 filename*0="0002-drm-amd-pm-Set-SMU-v13.0.7-default-workload-type.patch"
Content-Transfer-Encoding: base64

RnJvbSBmY2FjNmMwY2Y1ZjA3ZWNlZTAxNWM0ODhkMTZhN2YwNDFlNmY0ZWZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPgpE
YXRlOiBXZWQsIDQgRGVjIDIwMjQgMTM6MjI6MTAgKzA1MzAKU3ViamVjdDogW1BBVENIIDIvMl0g
ZHJtL2FtZC9wbTogU2V0IFNNVSB2MTMuMC43IGRlZmF1bHQgd29ya2xvYWQgdHlwZQoKU2V0IHRo
ZSBkZWZhdWx0IHdvcmtsb2FkIHR5cGUgdG8gYm9vdHVwIHR5cGUgb24gc211IHYxMy4wLjcuClRo
aXMgaXMgYmVjYXVzZSBvZiB0aGUgY29uc3RyYWludCBvbiBzbXUgdjEzLjAuNy4KR2Z4IGFjdGl2
aXR5IGhhcyBhbiBldmVuIGhpZ2hlciBzZXQgcG9pbnQgb24gM0QgZnVsbHNjcmVlbgptb2RlIHRo
YW4gdGhlIG9uZSBvbiBib290dXAgbW9kZS4gVGhpcyBjYXVzZXMgdGhlIDNEIGZ1bGxzY3JlZW4K
bW9kZSdzIHBlcmZvcm1hbmNlIGlzIHdvcnNlIHRoYW4gdGhlIGJvb3R1cCBtb2RlJ3MgcGVyZm9y
bWFuY2UKZm9yIHRoZSBsaWdodHdlaWdodGVkL21lZGl1bSB3b3JrbG9hZC4gRm9yIHRoZSBoaWdo
IHdvcmtsb2FkLAp0aGUgcGVyZm9ybWFuY2UgaXMgdGhlIHNhbWUgYmV0d2VlbiAzRCBmdWxsc2Ny
ZWVuIG1vZGUgYW5kIGJvb3R1cAptb2RlLgoKU2lnbmVkLW9mZi1ieTogS2VubmV0aCBGZW5nIDxr
ZW5uZXRoLmZlbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dTEzL3NtdV92MTNfMF83X3BwdC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92
MTNfMF83X3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEz
XzBfN19wcHQuYwppbmRleCBmNGFjNDAzYjhiMzYuLmFhYmI5NDc5NjAwNSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jCkBA
IC0yODEwLDQgKzI4MTAsNSBAQCB2b2lkIHNtdV92MTNfMF83X3NldF9wcHRfZnVuY3Moc3RydWN0
IHNtdV9jb250ZXh0ICpzbXUpCiAJc211LT53b3JrbG9hZF9tYXAgPSBzbXVfdjEzXzBfN193b3Jr
bG9hZF9tYXA7CiAJc211LT5zbWNfZHJpdmVyX2lmX3ZlcnNpb24gPSBTTVUxM18wXzdfRFJJVkVS
X0lGX1ZFUlNJT047CiAJc211X3YxM18wX3NldF9zbXVfbWFpbGJveF9yZWdpc3RlcnMoc211KTsK
KwlzbXUtPnBvd2VyX3Byb2ZpbGVfbW9kZSA9IFBQX1NNQ19QT1dFUl9QUk9GSUxFX0JPT1RVUF9E
RUZBVUxUOwogfQotLSAKMi4yNS4xCgo=

--------------xf1Pge0xtd0qZBaPGm0E0wzL--
