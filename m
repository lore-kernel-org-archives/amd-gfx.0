Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674CDC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F0610EBF3;
	Fri, 14 Feb 2025 08:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3tYqWMpu";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843AC10EBF3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do5dT7lZpCmCOyZs5Z9l7Kqs9ydrKIvB6XgiM9rO4fnns3L0F0QRIvLE5VG7hgqQOFZdeLZbhYK6Ro6Tfu6SQr7imRkv5kQUNujcaoZ5QLwCkOpFPpAsrRE4JV4Q3AYNUYnVizeaGlz8pmakXquCSHNmEJL9ZyGlDNIgXXcyY9IBhKX4v8dngx/Rhc6cOzMKY1GbNisWeT7ESeeQDg146e+pdUdZujsLqH75Nzp5kRIF0hU4E8f3/qV07aGeWfjNfoDCJ3eCd+E1O//q94kqSXvBJgpHDHvxiM1aGZZ5juwOb0r3mqPCTWGMMmT1OWMmV3/UOVcl7OkDw5qWrvQJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py0WBchvz3kUNN5OUCVCuW/E5Ao0dmJJrXEIIbgkN8w=;
 b=KhDTv9rJ8QI2ncWv33kz4tiqob5phx4bgky5kU1RhGmUFqszMpkYwHnNdQpTGGE0m9davzq4HjB7i4eoChF7NcNsR04OdLKEAMygkx5VWGhVovPAsjgtEHruhq65CJ3PjJ13OyPrKGtdT/AUfxCK3Caxy8yZqvzRmqCCKbcHe/0OtJZUc1b7rKgw511j4I/j1KLuqVv/npKmLSejXdjuo5VKDwe+lePm4jAnD25EpCNSlUITVpeKEcb7CER3fOaRrt92OEd6AJJVs/HSDedPSUBuROjzzkSCCSuseVrV9/3y4o0f9eEfcVkidvOTOznUyUSaPHCh+vDm3vXKm5Zcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py0WBchvz3kUNN5OUCVCuW/E5Ao0dmJJrXEIIbgkN8w=;
 b=3tYqWMpuFf8ojU3PAWR79YiE12XiMrOAyK0jVx5LWXK57lm9Peby7iFHkej4T2rMxQ7BmK2w7dfVvzfAtJKNf1JdjFwrm6bR1DqXcntIJ1+vJbLrkWEc7HE2ZvlGEIDA7h+QxXKLMtLKvDltjQF6oQkhkCcvcx3wdbjHlb/n024=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Fri, 14 Feb 2025 08:08:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 08:08:16 +0000
Message-ID: <d62e834c-cbe6-4c46-b7ce-d00a1406e4c7@amd.com>
Date: Fri, 14 Feb 2025 13:38:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Do not set power brake sequence for
 Aldebaran SRIOV
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hoarce.chen@amd.com
References: <20250214001348.4767-1-victorchengchi.lu@amd.com>
 <20250214001348.4767-3-victorchengchi.lu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250214001348.4767-3-victorchengchi.lu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 9060af98-e9ff-41ca-b94b-08dd4ccebc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzlMK1c3MlA4cWdHS1d6WFVLSmVkUXVhZmQ0SHRBak8rSC9zVnNJQzhMUmpy?=
 =?utf-8?B?THJYaHhGOHFDZGtvQ25pS0dPMVVRd3k1MEg0YUxmRGpUQU16UU5LVnRrVzgw?=
 =?utf-8?B?cENoR0NJL2tnUDV5QzA0UDNvejJzbHVLTzBVVkFJSjZjekhWUlc2VHNMUEtk?=
 =?utf-8?B?YXdHUEFMbngzRm1GZ2dYcjV4ZHhrSjROZUpWbzUxak9ING9ZcC9DZ21SK1ZT?=
 =?utf-8?B?VzVibjJrSU0xZXdFbk00M1N6M0JEOTlOdWhzTjlyZ2Z1a2xwQ0grVTJoKzEv?=
 =?utf-8?B?Z2M0M0dQQzYvclhBWG4ydkk3UWJwS29yb2FBY1BWSXJDZWFtSHpqdjNOVzF0?=
 =?utf-8?B?UGlZVXdvZ0ljb1lyTlJtZUp3YmVvcDRPVWxFUUJ1eVhyek5tMjQ1OTZEYjNW?=
 =?utf-8?B?azdzMU9WV2hnUGY3RmZFYWxTS0o5VXVMN0U2ZlZuQnZqdTRmQ1pMcGQvWm5Y?=
 =?utf-8?B?VWFhRzBWcTVNOXA3VjMwRlZoS3FpbWdKcTFsazRmVGk3Y2FDU00rK2lHQ0tN?=
 =?utf-8?B?RFZrK0h3ZkY3OHI1Ly9ZaENYdzBOUnBoSEJnVWxuZkh1UCtNNmNlbjR5K2xV?=
 =?utf-8?B?TUo2ck9hczFoSmFPY3RSemxISGF0eFFtaXo4ejdDMTJXZllNMzdBMzBoNDRx?=
 =?utf-8?B?eUcvS2Qwd2dDc05RUm1mSmxsRzVPbmx4YUdIK0FBenNzeW9Qdk1DaDM2R3FS?=
 =?utf-8?B?dzBUQmVmbWo1QStickNQckNWSEJkaVNvK1pNNGhUcTNseFJNYmxVMEppNnhI?=
 =?utf-8?B?Y1Z1dk5lOW5PaUdKMFNCVElUNDN4c2VUeXpWbnJsT0xiUElkY0o5M1BONDB3?=
 =?utf-8?B?anFTU3pnWUtGY3VSQmZPRzZXa0RETWlURkY4OWhMeEVxd0RSdm10WDQveS9V?=
 =?utf-8?B?WVF0eVkvZlY5c05HTHdBZDR4bVV1ZUYwQTB2YU5FL2hGRDdUQy9RaGdwUFZw?=
 =?utf-8?B?QzNoeC9ITERCamIxZ0d2Q3ZxTW1jcDI5YmkrdUhKUU5xNWpacjRiY0VVTFVs?=
 =?utf-8?B?d09rcmc1N0FVNTgxL3VjRy9HdzV5L25tVjAzL201bmFORWQ3UG1KbU9scm9F?=
 =?utf-8?B?eGtyaDcyNWRIb0k4cGpSUmxwY0xYWkhTTnZZQ1RPTWUwT292c1FiWnRFVUJD?=
 =?utf-8?B?SDc5a2lWTnlHV09aY0JZaWdPRWZyVzVqK0VST2dYN01waW8xMFEzMjdLTkxw?=
 =?utf-8?B?cDl1VGhlSThJNkpJMFZPUHZnUTY4MmljU1FnLzJiVytxNkFZdVgza3UvUktl?=
 =?utf-8?B?QmpjUEE5MFJFeGdUOVM5UUpnTFhxK2hDdUpTVVphTGdiWVM1RkxxNFJQNjI1?=
 =?utf-8?B?ZjdJYmpjVkVOZTV1QUlrWWMyN0JBZUFzYnRaSTJCWFVyMFFJWUI5LzBYR0F4?=
 =?utf-8?B?LzJYWlI0UkhRUXdXWTZFUVhLcjEwU3VqbVhubmNIQWZta096YnBDNzBmRndH?=
 =?utf-8?B?K2FEY2drNzJGejVyR2g2dTBIajlTeHVLT044QUpsbUoxcUhRVk42MjJNU25M?=
 =?utf-8?B?SW5KNi9yTFBrVWNXQzhkbVZvYlZTNmFOVkVkS0xvcG00cXhYMElrbkxaQkFj?=
 =?utf-8?B?cHFRMUl4enp1d2tvczBPeGU3NEJrQjFaYUhjUmRPRTZFWDdQczRVRnorcXZP?=
 =?utf-8?B?MnV6cGFia0VXWjBBU0FhTFgzdmFCQ09tOXlRMWRJWkhKUitkRTd2REhvV1A3?=
 =?utf-8?B?dmlRZEQxb01KTXAyTWlGblN0SjRLTVNoVHFMbE5GQTZaTFExQ1EraWo0VWl0?=
 =?utf-8?B?L29CWjVhZVNGMGlYYkxCeFVyOW1sR0NWd2dNVXY0bnN3KzFENjhJT3prc09C?=
 =?utf-8?B?K3pMSUFYUHpyWkFJdWtlZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTN6MytUVkFSSjY5VFNVWlQvSnV6ODd0TW1wZDlmTmo2SWE0Q0h1SHd6ZjdC?=
 =?utf-8?B?UEFPaTZDRERvUTloUndDWmxMeTl3YjZscjdyMjhUM2RWeTBJM1JjeldSc2Nz?=
 =?utf-8?B?ZGp0bWN1cVZyMkZqUDkxajFaRU1WSGl3aFoxcjNQVExkenVqMi9mUUlIcFlu?=
 =?utf-8?B?U1k0a25JZDBiTjNuaTdLYmZ6TnFuVWRRd2VZa0lQTDJGRlZlMDczd0t5bmdj?=
 =?utf-8?B?VUdHdEhseGh0V0JaZ0Q2K3NOM3ZWbm4yQWdVbXZsU2Jick5lTnVQMUNYRXJZ?=
 =?utf-8?B?bXVFMTVQU0dMTHZlbVhlY256Zm84VGZtbDU4aExVWTZlSElnTnYxWDdieVEr?=
 =?utf-8?B?QnRDK3ZtK1VsWUo4U2VBajBVL2h6WWdHRDk4dTU5aHA5Njd6RWpOemhDa0w2?=
 =?utf-8?B?UnJkMXd5allvZWpVKzZvazE2d1lrUUhoUW5MK3VrMlk3UW9FK2ROeWxWbmVh?=
 =?utf-8?B?RXFiU2xGTG43T0xOdk1HRG8yRjlPVTdNemovbExkMGlrWW1KRVNSSE9yMVI3?=
 =?utf-8?B?V0tvZjNCL3RGQjlLV0d1UGRPalRvWE81U0VwUW9EWFhyVzlENzRMdHBRMW9s?=
 =?utf-8?B?d1hZcmthSm5IWHdNdWlyNFU4VUlRRjE5OHJZc1d2N1ZEYjZzNk9nbFRQR3p2?=
 =?utf-8?B?Rm4wNGZBYlhEYnhXU0Ezcm81V2NpUWFXTldLcTk0alZ4QlFvRlR4SUVmWmtJ?=
 =?utf-8?B?NkdxVDFpOUQrNlVZT21xZHpIT21SaXZwMHNHQm9QMUVzaTdhVVJyODFoMCs4?=
 =?utf-8?B?NjR1ckl2WndHNlVOMC80aWV3RHB0Z1FCNFp3WDhpYTVIQStuMzdXZkVjcVVk?=
 =?utf-8?B?Z0dQM1Uwd0IyNzhOWlQzYUhnMEo2MTdBeEN5bmova1RORG1FWWZKREJ6ejlY?=
 =?utf-8?B?SFd0dEMxODFxcmhpa3B4enpzSlk5SEhZdzhTMEJzdklGVkN1WExYOW5aTk4r?=
 =?utf-8?B?NnRoSWRBbzJrOE1qUUVHcnZwVFA5emFFNTFBcmFGSXY3RjNjZGhWZUhTVFdw?=
 =?utf-8?B?YjI0NDNDSm5ralN1OUgvd2xIT0F2Q3p1bWlBSWZ5NlowUktRY3dKeTRhczI2?=
 =?utf-8?B?RGVBZitvOHJVRHEwNXprN094MVEyaU10Uk1aWmNsTEFpcEZ6NzJWM1Y4NXc3?=
 =?utf-8?B?SEtsVGxCUDB4VmFwWGY5RGZEZGV1UFplMTE5NUJtZU9IeWdqZjdkSEhXWVhJ?=
 =?utf-8?B?TW1xOVdwNHRHaGFzTXdrdkdycU0rd25JdE5kUHA4M1E1bVZ3cTZaMjBTMGla?=
 =?utf-8?B?VHpYaFNNWlRtK2pXdzV2VEhvME5vUzVqbVF2VHdlNjVOaUFCMkpMcTdLazcz?=
 =?utf-8?B?cmhsRDRGNnczdmRqTE83NmQ2cjBKOU04UXFTSGtmZ0gxTG5kRnRqaG85YmVP?=
 =?utf-8?B?WnZzYktqdkNWRkZ2M2cvVmpvMDhVRTdUeWxwaTFRM09JTXdqUUhVV2lTOTQ0?=
 =?utf-8?B?T1RCVlA3SXRVejkwazhyWEErWm5ka3I2S0xHVTFDM2hnbVBlcHN5MXIrK3BP?=
 =?utf-8?B?ZDdBTTREU0tRbmZVVm9Md0orLzRuNFgraDJjMVhGWTlBVlJ6bXowaEZVNlI0?=
 =?utf-8?B?N3FCMnkvY3dKVmd0aEdDVWJ0Qm1FYldONE5pVXZoOXVvekdqUGtCai9CcWxN?=
 =?utf-8?B?bEFaTC9Tb0hMcXZiTGYzRW12d1FzeCtORnRkQjRMSVRUNHdheC9YdHR5QVNv?=
 =?utf-8?B?ZWU3WmhOZ3FHSmdQUjFlcHBoVW9Ud1VWNjQvcDJGSUpCK3EzVFhCY2t1Z2s0?=
 =?utf-8?B?UEJNbjhmcVBKVnJSdDE0cXpZTlZvMEtLcTVpbkozWDl0REp2RkFBanhTWHBE?=
 =?utf-8?B?OGVMdDFqRWpMRWpXZXI0UjdQVjBoZVo3bWZYNzlhQlQyQ252UldkNlIydWd2?=
 =?utf-8?B?Yy9ML3JWdzJ5Q1Z6K3B4Q0ZacU1mL1FPbkY1WlVZSU9BTXhYYWNia2pweFd0?=
 =?utf-8?B?ckJEc0QvTVZRamhlbzN3RUhSUXNITlcvT3o5czU2enF3MCtiVVpubDQvWi9N?=
 =?utf-8?B?WXRLTmN2ZUZkMm9uUXAySS9xQ2JFK2VCa1BQWk5aeC9saWxOZ050OXN1VXRS?=
 =?utf-8?B?aURzeVg1QTlvUURIbGtCMjBMK01lYkVGRkNXemNzZldXWHJhdTE2Vng2SzRq?=
 =?utf-8?Q?lhABlCeaVt+4YMWyiZKLvqPqW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9060af98-e9ff-41ca-b94b-08dd4ccebc76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:08:16.6878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th4+gerGbBapSW7IsjlA0sTegJvCP+dA1ypmuPcU9r7gvao5mPdIwVbkEU2yNI0H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
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



On 2/14/2025 5:43 AM, Victor Lu wrote:
> Aldebaran SRIOV VF cannot access the power brake feature regs.
> The accesses can be skipped to avoid a dmesg warning.
> 
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 569a76835918..31b378eb5318 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4044,7 +4044,8 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
> +	    !(amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN)))

Asic type check is not required here -
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c#L2639

Thanks,
Lijo

>  		gfx_v9_4_2_set_power_brake_sequence(adev);
>  
>  	return r;

