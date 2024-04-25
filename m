Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3353BC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 14:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A161112089;
	Thu, 25 Apr 2024 14:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NXmC7tXy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D154112087
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 14:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXevcirxear1C67XUVyHBhpGHg841pN3TCf4Uhy2oxXmEf9e4EhnoDtO9luhJdsd6/71fEDjm4Qgq3KhSSQA9Labr3syXlAeG6vWRTvFAtlfnwCURq+rFQ2GG9KrMtC6GtrMJIaxbbeuS+ntHpzJdMjueKsSXv5z5ZuxQfbiIFp1lk4gYI4ZzQXt8wB0RkIercqLJAVWkbXuBfcPPPaTOy3Md/MfOIVsY+OdtlF6FKNpmXnclOSpovSjQpRnteEqxlig5HezB+Ac/zkyfOqsKQ0c4J0N3EtZry1QviQiIYrAF6h62A18YSwM0xxGCzLxPzsVTJYFZLZbRbbcc72gvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6qJY7QLBwG+uD0Dlpu+26mtllwTiL7fKBfEBEUxojw=;
 b=k83Z9rduMXqtrPxI/7NUfSJ1eQUS1bXIqSkwrUY9Cs+hU1Ex4jc3pYDArJGVUH+OYly9I96zLtJHJTQuAGoVS9oBYrorNMzy0hQC00cjPAoMjsTOA3c3Axd3zmylDEWP/PC6txa+olhhEATWL+LGq8N+9rpalf6uJHyAOVNojoVc++pmcufAxQvwQhcnml2tB7JUyKDdYf3czfFiLbmy/oLTLsoVYmxaAPw0PVbQK10W90vJSOxiNZlNiBbQZ0txBosneYezSC+d+VS0l9IuE1wAzlU6BXJJC2/MOtAZsHkurnOc2gEj/jPm69ftQ7OI8eoVkSArWO0CDj5S1kbeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6qJY7QLBwG+uD0Dlpu+26mtllwTiL7fKBfEBEUxojw=;
 b=NXmC7tXynGSaNboDLMQuUuPvjUn1cAz3pVOEWL3TAwdfJ329hutRye5LJNvV1XYTdvg/blQiWh/BGmjKtMBr9LLmzth4GVLqU7vdFEMJY6sqNAXPDgjUx3hmcfFq0t8ze62TjvILyuQB5a8IL77+/HcoSXRrS7yOpfD8n2OhuBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Thu, 25 Apr 2024 14:13:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 14:13:55 +0000
Message-ID: <6a0f8917-3a86-4f18-8a76-1e4062e44865@amd.com>
Date: Thu, 25 Apr 2024 19:43:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip ip dump if devcoredump flag is set
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ahmad Rehman <Ahmad.Rehman@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240425102318.14883-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240425102318.14883-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 797be97b-f456-465c-ac33-08dc6531f0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MG9FQzU3RXlBM3hQbmZwV1lGY3lDQTVTTFczUjhiN3h6UlhWSmZQbk1oWTMr?=
 =?utf-8?B?cHhnM3k3QmZTRDlBbkcraWR1dVpmMk96MzVGVVdVcWdkUWlQSEZ0cVhySFlI?=
 =?utf-8?B?RkFRUzkyRkkyWm5LOS96S3UwaFFQd2NEajJVVEFXOUhhZVVCWlBRZFNNaEI4?=
 =?utf-8?B?R2VDNUVSQ2tzbHdrTVlkMGZQQm5LbDNtWUp5dnRiclhjbis1bUo5RTJUZlhS?=
 =?utf-8?B?RkdUenRRaGlYdW9acEc3b1RzbmNIMU01ZDFuZlFiVnZCc0hNanNyQ1lyS1c0?=
 =?utf-8?B?RG94d0N1NXBZTWpsUTBYcTRVSWFsblZFNkg3TTVCeXRIZW5sQnJJc3VrY2Nx?=
 =?utf-8?B?OTNET0wzaFFLYS9xU0RrSFlxZm5CQUFOZ2V2TmN6S3hiQUlsYkdvSVJsbDM0?=
 =?utf-8?B?UHZkNzZucDhHNlFBUUpWSXRFVEdqTnVpOUl1bCtLS1cvS1ZqVkpPY3NhZ21y?=
 =?utf-8?B?UFBlOVhaa01tc1NRZXVPa3dWVG05djNmRmM2bEhwT0dDay9ndGd2VFFoc3ZE?=
 =?utf-8?B?ZzZOV0lmS3Jlbk1pcHRna0tkV3JFZVQ1K2RkZjl2YW8yZ0dEdW5FYTVnRitN?=
 =?utf-8?B?NjZ0djk3ZmlUZC83bExJU3NYd0RySlRYdmRFaE1WeGUwRW5YbTBhN0ErWmdO?=
 =?utf-8?B?MDR6ekVpVEJzYnMycFdVMXhkUTFWWjJvTTJ0Z2JDNWVMSGZMbk1PbXlpTTRs?=
 =?utf-8?B?QVFOVWU1TzZieFlqUmZYcS9XRHlIUUFBcnBzSlBmQ2ZDdzVQamwvK1JObzlj?=
 =?utf-8?B?elFEMzBsa1JpbDQxSWVVcXplTjBGdkFMVWZ1MThwVFJNMEY2dlBHL1Vtb3dF?=
 =?utf-8?B?WG5od1NKMkNrZTRpSnlTamlzQnorc1VnYTNJQXpSNmJuSjZieVVhMklHcUFK?=
 =?utf-8?B?WjMvd2JzK0xBM2xCOXdML3RxUHowSEU2ZUVjVWJmVHZDcEZ5WVlJdVlQaUZ1?=
 =?utf-8?B?MjhiQXBGZlFtWXdwNm9ONkl6UXovME9SVzFxTEUzak9CY0FMQW84MXNyVkty?=
 =?utf-8?B?NnlUeWNvT3FSWlhrRjZRenQ2WFFVcVpuT3R3eDdFM1RxbWcvMXlMUEYxKzV4?=
 =?utf-8?B?OVZsRXorT1VDTFhkeVByNEEzSHVDNEZvU1VTMlNycnFuTDB4cDVxWlNDd2Vm?=
 =?utf-8?B?dHdtVVM3eUFwaU41QTNLem9lTXFVNnhDK3A0NEp3Y2prVUo3N0syMzlvMnMr?=
 =?utf-8?B?MXB3QmcrNHZETXFjVzYyVlBqWUMxWSt1Y2dvTEsyMHVUclJiODZpS3JVTTN1?=
 =?utf-8?B?RmpCSTViUkUrOFROOTJVKzRxQ1ZaTDdaMzlPSCtjMVhzUy9DUFdDeTZGKzhW?=
 =?utf-8?B?bERWdW1SY3VoUXlhQnduNFhUQzZJSGJYNWV6Zm1tYm40dW1jV2VhVGo4SEll?=
 =?utf-8?B?UzZKRGRBTHFXTWE2MmJtbFQyYWF5WEZiK1ZDVENteWZqUlA1TURVSGVJQys4?=
 =?utf-8?B?c2xkOFRpMTRWNG9iNDNWQmdvRXZ2ajhDRnlzUEtyZDR6NEdVbVVXZmdRWnQw?=
 =?utf-8?B?YkFWZGpkQ0NJS3EwNVVNQ2c2YkZ4VzN0QWhpMjBZUVlKWGNiTi8zWXZhWktw?=
 =?utf-8?B?V2JvTTlQOEgxSTE4TTI1bFdhaFhhb2hGSWlPcEN2dm1TNEdJdFk4VXhBT0gz?=
 =?utf-8?B?RlNCakJOUXd1OFd6TUU3bjB2bjV1WGI3dFViNmZXaGJXVGhzbFIwZkpxeWNS?=
 =?utf-8?B?eHZNTTczK3pTdm55RWNVQzFsWTJNSGFJQ2RYKy9JR0lwTllGbGNxOHVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3lJZ2dFbkxsREFOV3VsTUZ0djNFTy9RQ05QN1pBRTducHQ3aElqU0diTlZC?=
 =?utf-8?B?WS9FREc3M3g1S3VVWmc4V2tCamZ2ZjNuTmtsSXVWKzIvTU1kUzl6Q29xMENL?=
 =?utf-8?B?ZzJDWG9nNXUrMk15dEFqN1U0MGEzVWhHaUVFdUduODM3T0VweVlFU1c1dERW?=
 =?utf-8?B?YU9pRTcwdmk0QytuSVRTWTloYjYxeU5jY3ZLNS8vZVNyVmNNMkFaazBxVjdx?=
 =?utf-8?B?RlNVYU5Cc2FxQ2lLek52NWpHS2lrZWpSM1V5cDR3b1IzS0ZGUmYrQS96cmtD?=
 =?utf-8?B?V2xmaHNIN3ZLNDJEa00xRXpxMkIyeWVXbFVDTWxtanZyKzQ4U1BRalBpMWx5?=
 =?utf-8?B?V3pCVHBSdzMvVVpmc016M1BlNzdGdVVtSTdVSlFtMWlRcTJQWmEyQkVOYndX?=
 =?utf-8?B?WUZlbFdiV01Yc2ZkWDdyQWsrbnlvcHlOaFlaVVVNSHB4TFNQTEV6cHUvNmJL?=
 =?utf-8?B?VXFxUHNQdHA2cHFCczFxL2ZKSzRxZEZhSkY1N0NQdUU0bVhuTSt3a1RVNnFF?=
 =?utf-8?B?bk5vTGtiT2xiSEZqY1I3K1kxcmQ4cGtDZXExcVlkM1U1NWcvU3k4bFdWTW5F?=
 =?utf-8?B?MUI3YTVrcURnYjlJRW1YMGo5b2RKTlA3RmZ6bnBvTHFQNnFsY1Fub2Rjbm5S?=
 =?utf-8?B?NDZ0Y2tITmpneENIaDFqZ2NsSmtZRGtzUUcrUjRpWkkwaExtME9ZRC83a1ZR?=
 =?utf-8?B?OGhlSVVQTWpyVFVLTTBVU3hBQVR0Sk9yZEZjQ2ZTSklwOFU1M2lqWFVrSVN2?=
 =?utf-8?B?akxIVDJEZlhLdDNlRFYrWlRPYitML1F0bHY5STJkTkxtUXdhUHNtSWgvcWQ1?=
 =?utf-8?B?NDEybm5OaXpnN1BCUmc3YWh2OTNWQTAyYytkdFhqTmtCdnNralg1emwvTm95?=
 =?utf-8?B?TUNxOUxRVEZSSFgybms3TjJ4ZjdkRGl1YXczNWpsMzc2TDBsWGt4a0szVEFG?=
 =?utf-8?B?dm0vdEpmVzNycDlqa3VGeEtNaGkrb1lSOTJUeVdXaUxxUUpaa1F1aDc0WlFK?=
 =?utf-8?B?NVhUcDJ3ZjhTcTJIVURjbFMzSHdjZHdoWlZ6dlhBK3QzT2c0dEpQbEY0ZzVY?=
 =?utf-8?B?STAvN09SRjdrVjJ1N3RoalZrMTJ4SXVYTHVHTlJTNG51M0JCeGFQc1JoOHIy?=
 =?utf-8?B?MDVjSnlhNnN5U21qd1N3OHRJM2VRbi95OWh2ZG5nZUc5T0NZbHlOb0tZMGlI?=
 =?utf-8?B?TGYyMG9NQkVKQmJsa1RvRlBaRm8xd24xeTZHeW9KUkw0aWNKSFQ2WXlrM2cw?=
 =?utf-8?B?emJKbkw3SHpkZFh2TkpkdEIzMGFXSzRudWI5TXBabnNwQklROTJNMENnK0Vv?=
 =?utf-8?B?akxhRnJTQnErNDNDQXJ6YXVNYitzdEVlREMyc0ROTHc4ZWdsYVVDQnArZTV1?=
 =?utf-8?B?QkZQUmsrSWNoenFSbVpGTzNmYmJzOERqbnJWQzhkeWZYWFRlVHhFYjZzcnIx?=
 =?utf-8?B?R2FlZkVPb0lGMDNIc3dGUjZVSldtSUFXbk04NFdLdVBiV21DRU1ZOTV0Zzdw?=
 =?utf-8?B?R2grWHBOcnpjY21lTnB5WDBsVEJ2emxITnZEcnBlMTJDQTBNbU1ZUzhwbHAw?=
 =?utf-8?B?R0JuRmFaUUMyMlNYbU9lbUJ4d1dpVEp3bUJjam5mNExZNW5xWWNqczB0czlh?=
 =?utf-8?B?TGYwMGpsakg2d1hXalE2OVErQVJNTWFMMjlCNk5aVXF0Zm9IMHc5cXJMYnFO?=
 =?utf-8?B?bzhnVSsxR0g4cEdaSmd1NU9nSmRqclRBYlc1S3IzWkJJNW9oamJnd0pDU05m?=
 =?utf-8?B?L1NMVURIcHFpRjZRTnN4SUhhbGJqMFN5Q2VnZEt4RkxTWGJ3eER4dnM5THQx?=
 =?utf-8?B?NERJOGJwSlU0Nmhnek12VEs0WjdZV3pXTnVaNDlkWGcxM0oxWTNHZFRidXdK?=
 =?utf-8?B?cTdjMGNSTk1EOWQydGRiZVBSM01XK2xlaDhxNVZqeUVoUFVmMzdNNFppWkRl?=
 =?utf-8?B?T1ZZZERGL1htQ1YvZUJqSklJaC94MThUYlZzVi9jNUxsajFYS0s2SGZHVTJO?=
 =?utf-8?B?V2dONGcrd0Y1TzdxZm5jQU1WVk1PaFF1akdYOFBGTlNoSGZRYWJ1cUdQOG90?=
 =?utf-8?B?WCtBQmVGMFJRMit3bThrQVh0eGFiYTh4eXh3UTlpVWdsMVFKZlQ4TFdrRGZt?=
 =?utf-8?Q?YMAnD7JuZHwUn2CJUZmiNru6l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797be97b-f456-465c-ac33-08dc6531f0ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 14:13:55.0604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBSg7o5zwZc7gDkE6Wv+5EDonQZ8vDI0k4Sp0a1fRlph5/SSvLHF5iuWiw9Avxzh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
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



On 4/25/2024 3:53 PM, Sunil Khatri wrote:
> Do not dump the ip registers during driver reload
> in passthrough environment.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 869256394136..b50758482530 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5372,10 +5372,12 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>  		amdgpu_reset_reg_dumps(tmp_adev);

Probably not related, can the above step be clubbed with what's being
done below? Or, can we move all such to start with amdgpu_reset_dump_*?
>  
>  	/* Trigger ip dump before we reset the asic */
> -	for (i = 0; i < tmp_adev->num_ip_blocks; i++)
> -		if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
> -			tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
> -				(void *)tmp_adev);
> +	if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
> +		for (i = 0; i < tmp_adev->num_ip_blocks; i++)
> +			if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
> +				tmp_adev->ip_blocks[i].version->funcs
> +				->dump_ip_state((void *)tmp_adev);
> +	}


Anyway,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
>  
>  	reset_context->reset_device_list = device_list_handle;
>  	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
