Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7371CC282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 10:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029C810E2CC;
	Fri, 14 Mar 2025 10:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QWUZyjDu";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBBC610E2CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 10:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8ZjcP+VdBrUqwF+2MmGpa4AKGCEXU50LEDl3qyDhDlFWJ9Vb9kYRd7Fa8NVDZfgm33YrkxMv3qSCffEhCg98JFGolS2wOV2lSPFYdkpaf9hsfU+EjN2P/r7h2NubsSwa+uCgy1fpH9yf5SO4qkdmL8t8wG4yRPh/P8EaT0oGLBSvC+nFDGCJcrNmNEKPNsSrxyJlNbg0VWmCY8e0XBCyJXINOxeorYzEt2xa3wqIC4v4rxQYmEI14c2/sekJf4zayEKnEtiM00mZ60w0D90vyRuwUp3thYrZv4rVTxHpYmeLS7j96JyCGcyPBEibCVsqQ5LzL7zwRDKfmYICWduag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLzf/hKs+vAnxTTSoLmB9ovZK0I2BT7sqOYwNedtj5E=;
 b=cRUBuYAzgDlnzQiksdG5k5j+vopR4yBr5WFT8rLccHXrxX9lOI8RdOjt5aVbgmflBoYZqYSZWm+6L1lcn5A4qXcWlBAJrKVs8wUbl1Q+dudDI81x6pDegZW/avf8j+Lm48f53AsGP1OM0m3Pr+tpozdHBsDOVlfLkCvvghwjWk4Jt6dQtxTZdRRCpd2f7S8e4aY/9wRGQSlLttbcgygorWkEfHOlapn8D04SoY8GwTF6PKHHGmGyLr0ZNxxJBenB0HCyD2TzmsRkBbN0AacIHBjiKvf6wEq3/QCFnLQgsjZJWMLKyxz4sViyqLVeJkAdJ33nbpBQkjBkcWpfaukK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLzf/hKs+vAnxTTSoLmB9ovZK0I2BT7sqOYwNedtj5E=;
 b=QWUZyjDu1wHLsHxXWCKnaLI9ULAPbdh4P4InQovin03deXZJHdtf9CW2kVWpiSUm7+4UKakOo2Pg05JqQntXat/tqLdYhBuJ6Tn4SmZxNbHQqyg28ytz5kv8HWKuzMExziWDZqjbSs90kAJf3/oMg8ZWv4pJ1lvgPevCiLlGQqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 10:27:17 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 10:27:17 +0000
Message-ID: <debc9622-7460-475f-977d-90fbdc89f896@amd.com>
Date: Fri, 14 Mar 2025 15:57:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/discovery: optionally use fw based ip
 discovery
To: Flora Cui <flora.cui@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Li.Meng@amd.com
References: <20250314095428.2914973-1-flora.cui@amd.com>
 <20250314095428.2914973-3-flora.cui@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250314095428.2914973-3-flora.cui@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a44469-39a6-48ad-200f-08dd62e2cb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFdvT2JxdTVBWE1VUVNaUVp0WU5hYkV1Nk9ybjlPa3ViSzRhTFl2OWMyMmp6?=
 =?utf-8?B?K2MxTDE2RmROTlllTG94V2RJUGo3WTQvUnJDZ1NkQk1ERG5wL2F2VkZjYnZz?=
 =?utf-8?B?VHVPTllkeDhKUHVEdFdpdWt2VjRuazVyVUFwNThRQUo0TVdUZ1loS1cxaWMz?=
 =?utf-8?B?aDNmUkNLQjh5ODZDd0p1N28vZm9DVWoxQ3FhN0d4bnNydUV3aWM4UWJWZnFx?=
 =?utf-8?B?QjAzMWVMSmh5b2ZUa1BPemg5dGZZMVNsYmlJd21mU0dGM1RQY0ZBWFNxdFpw?=
 =?utf-8?B?M0hUT3hpblNrcGF5Q2FSRzhMeGVnS3dMZW9RUkU1T05Jazd5V1lQamdoYnlZ?=
 =?utf-8?B?WGNla2tZNXE3bXpFcVhkclU3eGNLakVKQkJkRDEyaVdHeWI2NnpkWUl4eU1x?=
 =?utf-8?B?eDVDa1R4amdIMjczZkV0UDJJcGMweGthSkkvSlRXWXFoaFBoSmN0WEMrZXR2?=
 =?utf-8?B?WXIvdm5rWndSc0dOZGMxV0N1MGQzMkpWMFk5b1FrcDZOM2FyVHgwZExQK2Q2?=
 =?utf-8?B?NmlzRXFWQ0dJaGN1NFR4dFJKVEo0RndvRE5MeWVHYVBhSzVCM0Y4YlkzVFJZ?=
 =?utf-8?B?aXFYZVhVK2hxWlFnV2pvSXlvbWl5QlZ6c1JxZXBuT0JKZExybXd1UDlXM2dx?=
 =?utf-8?B?MzBrbmk0aVhGMU1RSEUwcGtlaExuamtIQ0JZUTUySk83VFR4bUVyMjZvcitG?=
 =?utf-8?B?TEtXYkJhN0dvL2xPTlp0V1FoR3NGR1hVbnkvZ1FqSVNvdnQzVy9tZVdhcVNI?=
 =?utf-8?B?UWROMlExUS9FN1dCUUFGRDVoV0ttSU9MMHhtMVVMdFZHVW1zTktrNjg2V3pV?=
 =?utf-8?B?NHNhRVhERVdXSTlaek00ZjU0TVcxVm51anFYWW85ZVIzUEhHamdFdUp1ZXYw?=
 =?utf-8?B?OEhzaEp1bk5qZG1UczJ5SUQ1eEtMSkVWSlo0aFQxRXRYVm1IM3hnMXNVR3ZE?=
 =?utf-8?B?TVV5OG1FYklGWDhwUnI2MVRyckpTSGNiZWcwYkxoZXlWdThuUnhQcVRFVTVS?=
 =?utf-8?B?clJ6WUpqaUwxOXZuMDhMQzVPa3hmOVpMVlc2cWpxTnpmRThVT0hTN3ZBeDc3?=
 =?utf-8?B?VnFtYlJXeXlXQzlnaHM2bUxISGh3MVJBWXV4YXkvQ3BjYThGdjlLQmx0QkJw?=
 =?utf-8?B?RjNJUVA4bm4yWUYwV09CcElJWHZMbGlyVm9pV2RxeER3SEMwWkpkN1hUNW1v?=
 =?utf-8?B?OVhhVzZvYkh5RkYrRmxiZE5sTE83LzlneGtNay9qdWJmcGFnRjNlL1c3Zjk5?=
 =?utf-8?B?MTZXWW9idnpaMllGRVpmSTdOeWJDWlhBYUlGVVFpTkVIRnRVWkQwS3NySmdZ?=
 =?utf-8?B?OHhFY05pbXl3RkNnSXlUUVJHeWtNWFJHYzZEeGJPY2VnRitGZWlOWktLaTBM?=
 =?utf-8?B?b3N2TVd1eW5jSWlmRmxzclp0UUhGYjlaeXdSYk5zOTA5RVAxUmt1OFRhQ1JB?=
 =?utf-8?B?UzZVVFl0MGcveHdVZ29CT01UNjk5U3Y0bm5Wd3FKWFVFeHBJOFdta1JhdGJp?=
 =?utf-8?B?Mks0bk91U0crL2Y3ZERSTFhZZnFCOEJxcjA1VUQrOEtFTkE1bWh1L2NNRUp0?=
 =?utf-8?B?YVV4QTVrdWZtNjVVQ1BnOGhOUWtycjFkMTNxeEFHOTZjVDRjMnVPVk9rVm56?=
 =?utf-8?B?MU1wdzQzUnRwQUx0ZEtid2czSmhHZUFvUkwrc1VSYzJYOHBGZ0JISDlOa1FL?=
 =?utf-8?B?S3AvVkV1VjFxRFhXbHM0cTZObGQ1elVDVEE3dXVDdjZ2QWhjNUgzYkNxdFVu?=
 =?utf-8?B?RlJkdHNkTGdpZm0vaC9ESUpPNmp6bjNteHBwbmlDVE1aZjdsbm10aUU1NjR5?=
 =?utf-8?B?bkt3cXFJb25DaHl1bWM4Q21PUVBwNkVQbWRWU21qZXI2UlhyY3ZDYTdNMVBn?=
 =?utf-8?Q?HCJ96HcqeqZCE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1RoYlpWd3JXd3c2MHBSUlUwM2pyajJwY3BnQkJzeDd3eVBEeVBod3BQdGlC?=
 =?utf-8?B?NlNsUGtDSExZMldhY3YyRG5Ld1VESDExbXhoV3krUHM3bkllVmRBeTdyd0lU?=
 =?utf-8?B?MytPRmJuWTVTYUYrZGttQXlpYitISU45YXFvZDlZdFZlZ0dEdHU4czUrSUVw?=
 =?utf-8?B?alFpSVJJM3lOV3dRaHZEZHBsNWZGNjk5M3ViSzhFTnpzdE1lNFNYd1hzb00r?=
 =?utf-8?B?MXlsaEFtUm9QNDVQTFFjQkdIRUFDd1lvck9vVWllWnNNU0tTT09YcGxlQm53?=
 =?utf-8?B?czFGMkZNYTM2eE5TTlVkNXBCZW42YkZGbkl4WElyK2lKMVJWRXVQUXh3ME5H?=
 =?utf-8?B?VHVsYWFIZ0ZJREtqWVpnelZVeDkweC9INGUvZjlTZm9BdnMySC9VQThXQVFF?=
 =?utf-8?B?RnZ1N0VvOUJtSmhSeDExczhtcU9CTmkvNnBEVzhyNStNWW9MdDBTOXljcVVk?=
 =?utf-8?B?c3JqSWNNamY1UHRTNXlRM09PakkwOEl1NHgrbDZOUXRBT1RYbjVMakplRkh3?=
 =?utf-8?B?ZHd1eDk5aGxOQnlOMTZreFNEamJUNWt6Rm56K0MxN1ZNRHlIQVk5RHpna2Vr?=
 =?utf-8?B?SEtjc0FJaHNpSVJWTU93MmFlaTNlYWtmNUdXdU80VWl3b1FZUU95Qkt5UEZO?=
 =?utf-8?B?Z0xnNlFiODNTd28yaCtpUW5iVUExckxVYytmbkRacWtrR3RReEFFTWo0MXQx?=
 =?utf-8?B?Y29zNXc1eXJNM013TElSL2p2dDlTcE5nK3Z0VDI1Z0FIY1RhTWFlSy9wb1dG?=
 =?utf-8?B?RzN5S1ZMN3IzR0pLZy9zM1dCMXFlQ29DSnM4cnBmajN3RDVPWW5YZzVaYnRF?=
 =?utf-8?B?NGxnT3h1STBTdUxOQlE2SCt5N3lkY3laem4vYWd2c0RxMGxMR3VMV2R4Rm1v?=
 =?utf-8?B?SWZZUG1RTUt0Vkl5a203dzJIdVg2QjZuL2cyaGRPWndsWHBwK2ZWYkFEa1ho?=
 =?utf-8?B?WmRndFh4WnppSTNVdHVwcDlnRmVUNDdFTTJEVmQ4TG9oTzY1aGN0V2hDSlQ2?=
 =?utf-8?B?TXo4M3JqYU1iZnNuR0J1VytVNmtnNTVSekJTQTQ3UElWcFF5NjcyS0xTdzJj?=
 =?utf-8?B?V05YdGY3ai9sZDNabXVpb3JNTzAxT3BCS0hyMTV6dHNCSWNWbmplTThsSDJN?=
 =?utf-8?B?V1JlVSswTFI4T0ZZbnVrbFA4dktGeXVETzQ5dlMxcHJOQVV3VkFJaklmYm5F?=
 =?utf-8?B?QVBiWTU2T3pWNUZCd3IrN1RVZ20wU0kzQWxSaFJDZmlGMU9KMWRxVW5iNG5F?=
 =?utf-8?B?czh4bzlRZlV6OCtKRC9qeWRtcG5oamRVQjNpMS8rb2E2Z0NVWnViWExpeHRI?=
 =?utf-8?B?N0hSV2labGJlbk5tZWdHK2tYZ29zWnB3NDk2TTlaanV6T1Q5SitJdHJzNGdI?=
 =?utf-8?B?c2pFMHdzam9GZ1V2eWF0NngzZ1hPZDdKR1pqQVhYdTFPZ2pKbVEvd0U4RzY1?=
 =?utf-8?B?VXBYYzhtblFJWjdIYzl0MFRlUnpHNC9SZlFhSGZQWWtnUGlEeUI3eEl1QVFB?=
 =?utf-8?B?SVNCN1BhQytYZWhiU2wxYlM1TDdQcUZIUU93MjBOQjhFNmVWcUMzSjBmTFY1?=
 =?utf-8?B?MkdpRktUcmpabTJ2d3IxWTFUWlBkVG40SWpxT2hXYk9NSU1lcm83UzB2djM5?=
 =?utf-8?B?ZXpOSWZEL1VCTXhYZ0FOMXFYYWpZNnExL3hwenhIOU82YkhzRU9PdVFEWkF4?=
 =?utf-8?B?WTZyY2wyc3RwVmdERkQ2akdhQzNKNVJ3S3g2UlNhaGtNOFk5MThETnkvN21J?=
 =?utf-8?B?WUswUzNLclBZSi9iOGI3S1ZBTmg0NU50V0xPNXJwZDU0bEFMUDE3NVVsWnZ3?=
 =?utf-8?B?clZod3hJcjAxaWxSaFZBQ3RZV1BkRG1mL2VsMGh0WEo2YWl5TmRsRW0raWVE?=
 =?utf-8?B?WEo5VHBmNDAwWEdZMDJSRHU4M0hPcUlkcnRoZFQzekN5QVRUQXBENjVrdDFu?=
 =?utf-8?B?bHZRUVAvOFQ2YlM5MnFxQzRxcXMvbmVmZ2gxV1c4MFNTWjA3UmswTXVxL0tz?=
 =?utf-8?B?UDZTWEx6T3pFM1M4ellpS2hEZmMvTlF4RVZUYzdqL3NUdlJQc0NCQy9WM1N6?=
 =?utf-8?B?YjY5MHZBbU9ocHhETGs2T3QrM0pRd0E1bHFtVUptM1lOTUN2NjNvTkpXdmVm?=
 =?utf-8?Q?FY5UoZN09SUwu/lAeCYCeD4HT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a44469-39a6-48ad-200f-08dd62e2cb2b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 10:27:17.0897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFt9SWZ4fcOgiqkgNt9QEwxjQkmUToHpRaqQnRri371Mn+TG4gLU3IyG48RhCh9W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
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



On 3/14/2025 3:24 PM, Flora Cui wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> On chips without native IP discovery support, use the fw binary
> if available, otherwise we can continue without it.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 38 +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index fff438baf64b..cf286fde18d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2536,6 +2536,36 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> +	switch (adev->asic_type) {
> +	case CHIP_VEGA10:
> +	case CHIP_VEGA12:
> +	case CHIP_RAVEN:
> +	case CHIP_VEGA20:
> +	case CHIP_ARCTURUS:
> +	case CHIP_ALDEBARAN:
> +		/* this is not fatal.  We have a fallback below
> +		 * if the new firmwares are not present.
> +		 */
> +		r = amdgpu_discovery_reg_base_init(adev);
> +		if (!r) {
> +			amdgpu_discovery_harvest_ip(adev);
> +			amdgpu_discovery_get_gfx_info(adev);
> +			amdgpu_discovery_get_mall_info(adev);
> +			amdgpu_discovery_get_vcn_info(adev);
> +		}
> +		break;
> +	default:
> +		r = amdgpu_discovery_reg_base_init(adev);
> +		if (r)
> +			return -EINVAL;
> +
> +		amdgpu_discovery_harvest_ip(adev);
> +		amdgpu_discovery_get_gfx_info(adev);
> +		amdgpu_discovery_get_mall_info(adev);
> +		amdgpu_discovery_get_vcn_info(adev);
> +		break;
> +	}
> +
>  	switch (adev->asic_type) {

Looks like this fallback gets executed regardless of the
presence/absence of new firmware.

Thanks,
Lijo

>  	case CHIP_VEGA10:
>  		vega10_reg_base_init(adev);
> @@ -2700,14 +2730,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
>  		break;
>  	default:
> -		r = amdgpu_discovery_reg_base_init(adev);
> -		if (r)
> -			return -EINVAL;
> -
> -		amdgpu_discovery_harvest_ip(adev);
> -		amdgpu_discovery_get_gfx_info(adev);
> -		amdgpu_discovery_get_mall_info(adev);
> -		amdgpu_discovery_get_vcn_info(adev);
>  		break;
>  	}
>  

