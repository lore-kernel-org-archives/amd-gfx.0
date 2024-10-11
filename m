Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A58CFD30C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 09:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C19210E0ED;
	Fri, 11 Oct 2024 09:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ipkp/Hyb";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0780C10E1E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 09:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgEXP326ytTFOS5XmGiOQJzYjkDplhoCJNa95PAvgElm1vL3la2dp37BTi/fWVQf8dUAj5p/sE+6I4btT1YcuMfHPgDq+2mVoua5DCsEW6G8h9Ui8A+jafDoq+s1FOZcItZ3uD7PfZT4S4Sa9skAmTBHqnNgqSvjSSWavdjlmYmIBY4+AhAK6rLXGsG5wyCNqt6OK24ThPfoB1p4QFoIOd98rhbEWjk0+OVt6wkYqjlaU2nUWS7Gumh4Az1+xl649MtoVoHYErXsxqFLl1yXVJnEVBlpbiuqKOh9f9cZ3gfLneHUan6e/SpKOtMq+aUBtVgN8l4rG6eIHdgMbMJ5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/siCHh0B0S4f0Nn7DRcczlzi3qa8x41OUeU3GEi5kgI=;
 b=UFH7pNbKyxQ/jyeMvA64U1Py0vhqeBM4MOxcsyBZTxeVMRujRTG5b3ohKxVvJAGyKC3XdQ0aqucv2GT2+Ga8mXv20a9uPRSOzk2ChupNPzVED3F+pg+wJSMxjBi7s/lva9RAThTpNb0V529Zotu/GJ5y4j24vB6KFMUw/xPVsPJTtrDKRNVzT79EsBYZlPjEa7ikRdXKN27aLbRVJA5wNIxccEwusyfW5pqCcZxRL/Q8ZY/h7vFvlHt/v0BvZDYRqlh2mWSRZBvxdTRPajNLu9NAm8HhiVUsTDVuKdAdPIGFuF+tsDA7H848QYJhJkovKGyRgXhluMucdMeQPqYT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/siCHh0B0S4f0Nn7DRcczlzi3qa8x41OUeU3GEi5kgI=;
 b=ipkp/HybiJzdFJpnYQoKgf0S1KoYSQNSc9qp9U2KNYX33U6oCA6bcynnGRKJnif5tauHPamn+ztNARJcd2X7917HJUFYPDQoqgSUEHqxy71B3HeKbrxBUJiHqqEbbYMolFYSg8DkXD9WVxDmd1n291K2A4h4bv6Wuk+LmuHpUCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 09:21:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 09:21:18 +0000
Message-ID: <124d02ee-2ace-466f-b9ef-47e71bc162f4@amd.com>
Date: Fri, 11 Oct 2024 14:51:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: correct the S3 abort check condition
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241011060106.1745314-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241011060106.1745314-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::28) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fb591c-7406-455e-21b6-08dce9d61039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlFuOEd4TTRLOGpQVndsdm1XN0kxZTlNcjNzSzBVZ0F0SHg1TnpLZ09ja3RF?=
 =?utf-8?B?RzhyS0lUVDVzZ2ZCK2U2VHhvb1lPOXB6c3gvVXlTSWVsVStuZE9FRjBkWTJM?=
 =?utf-8?B?a1k5dzF2ekM0ZzBRNTV2dXhHNktqakZNZTJUS20xQnRzdEcwVU1HWS9QbExs?=
 =?utf-8?B?Vyt0WURIcmpxSGZhdXBRcmQrZVB0alB6dkI1V3hrdGVpamVGSGJSVVF1SGxm?=
 =?utf-8?B?dHY5VzYrT3RrQVhTNXJqRTBOV01kOU5tbmF0QTZHVncvOVZpdHF3R3lsTGx4?=
 =?utf-8?B?TmFPN1pJMGFxbUNSMXkxVW1GR3dyOUJBWDRSOHNRbDFzd0FkUG1Xb3dueEEz?=
 =?utf-8?B?bkFVeGs3NHdsWkZ1aUFaUmNWU2NvN2hzUk5ZcTVkR0JFZ0VKaSs0WENWSkcv?=
 =?utf-8?B?eGtick93MDNkWHVVMVRuYWdoVVFXdDFsT3VpSnFuZXJkWVdFQWViZmhxR0J1?=
 =?utf-8?B?dW4ydnk0TlFEYzJNV1hJOHRBclVtVjZZSzVSOUx6aDRTWlZ6UnN6c0ZMSTB6?=
 =?utf-8?B?VERjQnRCNWszNTQwSitSbk5HTjV0bEZOSGFIU1ZYUHc3LzNXU242NkozSFBq?=
 =?utf-8?B?aEUwdVlxK2ZhNzI4K3JiS1I1QndRUVRhSmgxQVJGUTdCQnJxNkpxMzM5d1BN?=
 =?utf-8?B?dkJ1Uy9nYk9hdTQyU1dOd1lsOUUzZTVRcjdVZmRWM2hmRElwcTA0Q01qRlJD?=
 =?utf-8?B?Ni96NytzY2YxdFVhYStPRi90cU9JUmxrN0hiNnVnVFFKd2ZHOUtiSUE2TWdk?=
 =?utf-8?B?YjA4YlliT3czQzN0RnN4dkhIUHE5MXFVT3h2azFNNVY1NkFacGJOL0VzbFFV?=
 =?utf-8?B?NTM3cUhwaHV2UkplMi9rb0ZMcjFVeVcwbjFFQ25xSjZpbjd6RVVnVGhTWU5q?=
 =?utf-8?B?VDdjeWJNVEdJcUtTbWtlMmd1Q1ZTNmY3dE5xVGRhd2dIMkhsQkVta3ZBLy91?=
 =?utf-8?B?L21BRDRtNExRZXdSL3ZvRmp1V2QrZzg4dnJwM1BWU0ZXUlNnWnMzREhsUVMx?=
 =?utf-8?B?S0xudEZSdWUvOFcrUmM3dGh4OTNQQ2x6c0hHMlVCbkUxU2NsL0FBRnJrYjgx?=
 =?utf-8?B?enMrQ0Q1T1RoN1d1d2VnZ25BN1JYUStUVzhWTUZGaGRaMG1wcVE5S1pGUWM2?=
 =?utf-8?B?dWFJV1BCdVl6OEZ2OWRsZkVHN2pVV0dNS0ZNTnZiQTNKdjdNNVJqaE1TQisx?=
 =?utf-8?B?QmhsRzRhREk4Tkd6WGVkNVF5NDUrUUc0QjdhNzFPNGxaTlhKVDhCUzN4d3FW?=
 =?utf-8?B?d3VJamYwTlFyZEJnNENoQ2dzbE9sbDJ1TFdSZGFOclBSVkYwNWF2ZFR4OFhG?=
 =?utf-8?B?MFNsZWhENVpyZW16bWVBeHZiQmRkODB5QlNoQVYwRlJRRjNWTTdBZFpvemUz?=
 =?utf-8?B?dzdXajR1S3VCMnJiQWVVZXh4NkVpdzJ3eEwyQnBNOHVUVlhra2VQWVpIeVR1?=
 =?utf-8?B?eGdkdml5YUVFdUUrVkdhSTZ0UkZ2dVNJU3dKdzl5d3dWeG9malB5ZS9RWVFF?=
 =?utf-8?B?QXJNcVdBZk4yQ2RQYWhEcmhMTkI5TWNKK0JPM0RBY29McDFLem1oazRpb1hp?=
 =?utf-8?B?M09GS2Jrc3JDQjRkaEhkY3VyRGh0RTFZalI1Z0txakxyTVdOK1RaQm9kS0Mv?=
 =?utf-8?B?TzMzRXpoK2xBMGhtd2xZcFErc0lzQzhqZUxRSVBpQ29DZTE3S3NacG94TDkw?=
 =?utf-8?B?dGFBMThxNVY0V3UrRWRiUkxwb1RVbkVOaEVncTVCNnJKRTh4N2NZMDJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnRlZU1zaDg0c2QzbjI0RkZKaWhlVWl3WkhCZlNjcytkbFM4MnNtdmZBZzFK?=
 =?utf-8?B?ckJEMGRiWGQ1bFd6NVJaRmJYOXo1WEdIMG9MbnhTWFIvOFhHVisxVHVDZzFu?=
 =?utf-8?B?MDdnVTlzc2lpRllDeUJvSEt4V2hVZnpmNHl4UFFMQW5aRWN1bVZUaHRTOXVq?=
 =?utf-8?B?eGJVdHNPbmQ4YTFWNDZ2cHhzQ1VHcC96eHdnMlpCZ3MvNjJGcVlkaWFpS2Ri?=
 =?utf-8?B?ZXlzazdSRld5TEVxb0E3VFFTNkFVTERoTGxYcWFvWEtFaG1NbGI3Y3B4bUcx?=
 =?utf-8?B?RVZDNVdJWVpWSE5JRVptbTdaVTh6L0R6bnJoMUNOYlMwZXQza3M3MG10OE9x?=
 =?utf-8?B?c0ExaXNUd2dGZkRCTVQ0TnlpTmFiYnUySU1xTDkxaG1NYVZtL2VuMm1xczZE?=
 =?utf-8?B?SEJsbE01VDFXU1dVS0k5V2FoeGJNS3RaNlRjZHRROGp6Z3lyM1JhRGlXb3Va?=
 =?utf-8?B?dENGZnJjYWE4bmlQdVhrdENobTIyNHp4aGU1dWFhcHFtVDhuaU5wUDUvcmZX?=
 =?utf-8?B?d0hTNHVRbnpUUnJmOW13QldlYW13MVlBcEZKbW5UWXo4OG9tRUJWajViWnBQ?=
 =?utf-8?B?Y0RMaGhZU096S3paVjhGa1VIVUY2c2N2cTNGL2FXby9tTVpPZnpteUhxc3pm?=
 =?utf-8?B?SzRpMHpNc1ZJemdldmU2VmhxSkJpZjZ3NVNzRGVub25QMUgxSitURS9DcmNs?=
 =?utf-8?B?R2xkRVkwTU5kQWY5elpUOE5TNm5JdXZXWHQvQXN1eDYxbzVnUjVDYWJwck1x?=
 =?utf-8?B?YU03aW0zS3NnWXhkSHlzMjRuZkNxOVNRMVpXVkd6VXNEeXRuVUdyOEExQUJM?=
 =?utf-8?B?TXMzNWNuZ1NYSGd4bXV4RVdONEZ6QUxuQkFtZlVwWWxWbDdVMThNYSt5eFZR?=
 =?utf-8?B?WXBSaGxBSVF1VHNHL25aaHVndHZsMTd6TE5aRVEwSmVEdG5YZUVpejZLSHF3?=
 =?utf-8?B?eHkwY0ZNNlZkN3Z0RmRic0JtdDVKUUhTWnZRWXpzSmx6MW55RGtBRnV6RDRD?=
 =?utf-8?B?SXFySkdGZU9ZRUNsNUxtbXNLRGdvRW1VZ0E5MDdVQnpWdlk5TEZXdjJxcEZp?=
 =?utf-8?B?U2huUW5aTjhaRGdXZnYvdkNFUXlyazU1Nld0WDBNVmdjN2tBNkNSSUI5MFJw?=
 =?utf-8?B?TlNKWWVmeFhLOTRLWW9YL3pTVGhNdnFSK1JSTTlRQ2Yrb2hxZ1FJSDNYajV5?=
 =?utf-8?B?bzVVMkIvUnBld24ra24vWkxrR29iTWpYaWxYRlR2RmsxTVhhNWZjQ1ZqVWVu?=
 =?utf-8?B?S1pvR3R0SUxBOEwwb0Irb0pKNDhUWG93bHh3bnZ4N3ppUXFUVE5aK1RFRDlJ?=
 =?utf-8?B?bkJMQW8zV2M1SHZ2QWE2c25RZUdXbC9Nd1l2UkJncGlUdFZBa2JjTWNzR1Zq?=
 =?utf-8?B?VllCOWxHVXJNa3Vyc1lsYzVHUjJLMDNLWnpBd20wSHE5MzMrcENHRno3akhD?=
 =?utf-8?B?bkZFbUhCbVBWUXlqc3dFWldpbk0yNXEvWTRnbUozbktSZU05aFJDZjVkY2VE?=
 =?utf-8?B?eGI2MEZqSjVsL0RqaFdDQ1VQQSt2Nlh4Ni9EVUh6ZE5WU1kzaFRTeDd2MitL?=
 =?utf-8?B?SXo1VCtiMjVFaW5xYmZocFNSTVdaaW5FWTM2SS84aStCemRGNzhYQzhKSzNM?=
 =?utf-8?B?ajR5VGprenJFT0J1RHFaNHNNc2N0YTZzcy85Y01GZlZQc0Uza1dDZUcrUWU4?=
 =?utf-8?B?aUNUR20vdVgxNlBJZFZ3Q1FpM1RKdGZmZjBwUzRUZDdFT2FTdElqejVDTXg3?=
 =?utf-8?B?MUZZZXdIV3Z1YTRPU0hNUjZ2c00vYnA0RmpLNHdJd0J1YzcwWjNjQ2hXclND?=
 =?utf-8?B?ZFZEOW1NQ1QxdzhQNW9FVFcxUGJaMXBFaXNDdFJYOUFBcGVvMk1WQmlIU2Z1?=
 =?utf-8?B?NVE3aUVMeExzQXBaZVUvMVFIbEl5ZVpGbXBxZ1g1RWpKT3AxSDJLa0huTFUv?=
 =?utf-8?B?RTliVDE1M1U1eUxxTlBNRWtFMUlYYWpJV0hUNDdxVFh0UDVyZmxIclVsRlJV?=
 =?utf-8?B?TDBoVmNCeU9CU1FCUmJYS3B5b2lrWTF6WU8rWDliODhqZ3RXNjlTOUtLanhV?=
 =?utf-8?B?SUxoazF1YWc5UStIbjVSRDlXMEZyM3QwZ0RrM2c5Z3JkdDA4MVAzVXhSdk5k?=
 =?utf-8?Q?G7KlchdgCYxHi9w0RfYApw3H7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fb591c-7406-455e-21b6-08dce9d61039
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 09:21:18.8270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rjuKW4hRh2ng7g0dNYDCnn3E3WHhCI+Kf6kEDJmPL8rJkeWvclKQnDlOGGlYveI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471
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



On 10/11/2024 11:31 AM, Prike Liang wrote:
> In the normal S3 entry, the TOS cycle counter is not
> reset during BIOS execution the _S3 method, so it doesn't
> determine whether the _S3 method is executed exactly.
> Howerver, the PM core performs the S3 suspend will set the
> PM_SUSPEND_FLAG_FW_RESUME bit if all the devices suspend
> successfully. Therefore, drivers can check the
> pm_suspend_global_flags bit(1) to detect the S3 suspend
> abort event.
> 
> Fixes: 4d58c599df75 ("drm/amdgpu: update suspend status
> for aborting from deeper suspend")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 619933f252aa..d07cf8137bd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -578,16 +578,18 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>  
>  static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
>  {
> -	u32 sol_reg;
> -
> -	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> +	bool suspend_complete;
>  
>  	/* Will reset for the following suspend abort cases.
> -	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
> -	 * 2) S3 suspend abort and TOS already launched.
> +	 * 1) Only reset on APU side, dGPU hasn't checked yet.
> +	 * 2) S3 suspend aborted in the normal S3 suspend or
> +	 *    performing pm core test.
>  	 */
> +	suspend_complete = !!(pm_suspend_global_flags &
> +				PM_SUSPEND_FLAG_FW_RESUME);
> +

Is this expected to be done after hibernate also? There is a function to
check this - pm_resume_via_firmware()


>  	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -			sol_reg) {
> +			!suspend_complete) {
>  		adev->suspend_complete = false;
>  		return true;
>  	} else {
> @@ -603,11 +605,17 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
>  	 * successfully. So now, temporarily enable it for the
>  	 * S3 suspend abort case.
>  	 */
> -	if (((adev->apu_flags & AMD_APU_IS_RAVEN) ||
> -	    (adev->apu_flags & AMD_APU_IS_RAVEN2)) &&
> -		!soc15_need_reset_on_resume(adev))
> +
> +	if ((adev->apu_flags & AMD_APU_IS_PICASSO ||
> +			!(adev->apu_flags & AMD_APU_IS_RAVEN)) &&
> +			soc15_need_reset_on_resume(adev))
> +		goto asic_reset;
> +
> +	if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
> +			(adev->apu_flags & AMD_APU_IS_RAVEN2))
>  		return 0;

If this check happens first, then !(adev->apu_flags & AMD_APU_IS_RAVEN)
and goto/label can be avoided.

Thanks,
Lijo
>  
> +asic_reset:
>  	switch (soc15_asic_reset_method(adev)) {
>  	case AMD_RESET_METHOD_PCI:
>  		dev_info(adev->dev, "PCI reset\n");
