Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02147D33994
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 16:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8681B89A72;
	Fri,  5 Dec 2025 16:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uegPFLUO";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E316389A72
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 16:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QB8uWLG55LfrLhTCUB2uAxkIChmE8xXq2OF77NN4E/gQIvDQtJZC55JRNHlnpOaZFZz7J0LnBQscUhOWcenVjB1mp9q7t/Kz+rklTf2I4mCrEOsCOX6nfjAP1nfVBRlwWgydxFM5tKw5syf470dB4MtHgwOG4QYEQ9LqWz9Y7wGEPBbuS41+y8po3iBe+rs09dk4ju3Wk0G+W8mGFcxSAW0b3hyrTw2C4eqkf1o+Kl/scP8dwvhUfPh4pLaASx+QORGYCweeTCrl4EF5+exQz2ZrcsUFB616Eq3N5A6PXs36fNc16VWWZ27O4vqx3Svz1xyiWWyS61gN5uzGG8FnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsFm9Q8rZL2xuSf07TeyJ3yKepW8bivSErsT9m2mZW8=;
 b=mejmUQ5osn26hLaqFL/DyQLC72d+h5H+SHKRHLcQGuKjVbTnPi/vMa/5B9rqz2SNLtA2QN6cYpKmBKN3rI/MZ1Ys2h/JvhUFbCS9/uLQowTY0TVLpBc91j6J7NSgJjR++8IbZByMh0Wqck7BmoLR36TT1ES2DPG1UATol9vF+ce+3RJ8dgFelFZl83SE04TpmFRtoJTgIkrkFiRN5Dzm27rRPFEO7pOziW0T3sAMkJIXaCkKeEAH5xPrFM0nz6s72phCWDNT0xT9UGapL/miXuPBDPOv/XVxTJtiykC3QlGCx1sWDgY1trqcRPSJC5Exc4UtQCvUuzQe+RdWD3momw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsFm9Q8rZL2xuSf07TeyJ3yKepW8bivSErsT9m2mZW8=;
 b=uegPFLUO2ZMRXWXMtjQaXnPKv9VLA2OTv+LfpC5SMNM0Z0F3GAJT5YXmubBes1vMzwW4zZaRJArAezb/IfvsH4guUvKYi5pgcbbXCMYMsWfsCeRRsflJVk+WsvtmUPojlR+YgSyjy4YCY9rd/DwZhjc4TVMXJ7rhRC48jwLvF4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 16:35:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 16:35:34 +0000
Message-ID: <fb4a772b-5774-4aa4-a6a7-80a9b6cc080f@amd.com>
Date: Fri, 5 Dec 2025 11:35:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu: Ignored various return code
To: Andrew Martin <andrew.martin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251203144435.62300-1-andrew.martin@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251203144435.62300-1-andrew.martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0037.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 988d344a-d1f8-4ca9-c10d-08de341c4ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlFIRzZFYTkrQU8xekl1TnkwaUpiSTdnTGlmMWFzVS8rVm16REhOTFRCQ204?=
 =?utf-8?B?aHozbDFNcit3Mk1ZUU1CVi9zZzlCaDRIdlg3akJSS1dvM3Q0MkgrU1QybG5k?=
 =?utf-8?B?WXIyVTBMRi9VbXVIYVNhQWU5Wm1DNEliLzFtVlhTaDAzWTJQU3c4TjJQZnYv?=
 =?utf-8?B?OEFsVGVBQkg2VTI1dldOYnA4NFEyVXFZd1g0QVBDQzFibVJmMmdEUXAwbVkz?=
 =?utf-8?B?WE5ZQkFYRGlMV2hpOEVEaHB2Y09YRXVmcyt5ZmY2SjlLc2QwMzZObkNWeXpS?=
 =?utf-8?B?d1NXNmw3cWYvRnVpamdsS1VTYmM0Q2ZoM0V2SzZ3cnJTUWtmRmJjejNnazFI?=
 =?utf-8?B?LzFwejA3K2pSRW8xalpyY2F6KzhxQk9kNS91RWhOQlVRQ0JCeG5CTmRDeVZa?=
 =?utf-8?B?OWRxOS8wZ2VOeUR6T0dVQ2dwSGRsTWJkRE1JTW8xTWw1WDdWc1hOZ1ZhT0px?=
 =?utf-8?B?QkZ5VWRmaUdYcUFxY0ZIdHNzTmZmVEtiR0RSb3dTUmpRNEtpY2FnZEo3cERH?=
 =?utf-8?B?bG5mYi8zckV6eXUrU2VMWGwxVERML3lmZmhHaHpmc1BqVWNzMkIrb200VG1n?=
 =?utf-8?B?UEZHTHQrV1h5ajZGZHdkMlNnc2h2M3ZoRk1uc3g1T21FWlBxcXQvMzJ6ZU01?=
 =?utf-8?B?c1FGaUFtb1lPS2NBWmI4c2pCdjdEQndDVHg1a0hMZGdLVEdrOStaUEY2ckpI?=
 =?utf-8?B?d3liOGYyekJOYzlPeUFrekhkbXZyOEVqVXZtOXZRbXBxQTVwalB0dURvK01Y?=
 =?utf-8?B?Z0l6RFlLbVlVZldTZXFETkZET0R1KzRvQzV5V3FuYVhIUzA1RTVrNjdCcjM0?=
 =?utf-8?B?VHJvbi8xQXNuamQ0TkdzcFh3ZXQzTTBuZlBvektuenZ2Nk9GQW5GT1IxeDk1?=
 =?utf-8?B?c2k1SVhudUxiVUV1M2U4WXBxN0E3LysxenJJWkdRK2ZvWHdCY1JBT0F6UGNX?=
 =?utf-8?B?bTZZeGVsYmQ1QThjOFJpZWI0ZnJqbnMydHZjelF0OFFRcS9kcGxYdDRVTTRW?=
 =?utf-8?B?WWh2NG1MdExGM0M0akRWT3JDME9HZ04xTmIwd3JrMGdleEF4dkM4SElZVkNU?=
 =?utf-8?B?UmZyK0kxSllmRkFlMnRVTC9uQzJmcktpcmMzWW9jRE5VUHBDVXFvWUhXV2hQ?=
 =?utf-8?B?K1VhRXNSRnJDZ0FsTlVWVUpXaWx5dHRySVJZMmszcVhmVlBBYW5USW9NZFJD?=
 =?utf-8?B?dUR6em5LUTdsWWZEVi9TWFJQUWRtQ1ZzUHFaNTJYSGsxazR4WGVTcWZURzlr?=
 =?utf-8?B?b2pxNERDVFhwekpCL2NFRUVRZVpNZ3h4OWpVZjJGc0J5RHRUNVVMM0M1RDJR?=
 =?utf-8?B?RHVlb0E4R2dLQU56MytCRFhocXdJcXpySmVWTFloNGJhZFRndVRwblBWVTRW?=
 =?utf-8?B?eXpEZGlVelVRYjREeVgvTzFONlVEV3o3TW1Dd3lpckZKc2J4OTNZdkxQcENR?=
 =?utf-8?B?dm8vSGJlWEdzTU5uZEN3bWFMNzh0dkxPNTFjVzJPcXVsN0lCUWxZWkVYUHh0?=
 =?utf-8?B?ZWhWUUFqdlNMS25lcmM0d2k0ZkI2QmJxV1NWQWFHTlkrZ0dNTHpNWVVlQkc2?=
 =?utf-8?B?UFpBM0RHQW9HZEtVYmpia1FLWUFXYzZiNWorYVN1aXBHSFpTQVlrNjVFVXB5?=
 =?utf-8?B?dmRZYWJ0bytnd3FOajJjRk9qQWovRGlHbUFkQkVrbjhYdnZaeUVqOW9kMXVy?=
 =?utf-8?B?ZmZEbDIyaGx3V2JGaExvUXdGSFhaNm1Yazd1d2UzeUZiL29rUWcvYi9oUktI?=
 =?utf-8?B?NG0xbHd2WndUdVhoUGNyL3RJSlFvU2V2eHR3YmRyTXUzOFFoRHdUbWRnYWgv?=
 =?utf-8?B?bENZa0syZHdJUWRBVXdieG8wUXF0c1NjNU5ydk5SZGIrUFFZRFRjaURweGZk?=
 =?utf-8?B?KzNacE84eDVVN2o0dTlRd0c4aCs0eU5RaXVVUmFIMmQrdTVEUkRjM01MOStu?=
 =?utf-8?Q?/E5kuRHaJPlKPD/JenpnIfQd0pPC+xlK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1U0YytNdG1TL1V4bU9pbGh3R2l6S1ZRYlRwZHVJaDdvakNSSWo1Mmd2dkEy?=
 =?utf-8?B?OWRoM3REaEMrZ3pzTWNZR0lJVW9LQmh4ZkxkZTRJUklpNFVxYlg4SGNoUGp0?=
 =?utf-8?B?SmJ6RGxnUktvTTNabC9GdEUzUGRod1ZwV1lqYzRzV05LeFIzNlVEd3FTS3pF?=
 =?utf-8?B?c21xdkR1bU9UYjk2S2orNHdCUCs5MmNGMHB5UStEYUZzb1Z6ZTdqcTFTeHA1?=
 =?utf-8?B?VnlvTFQrMHJ1UWtlRHlLd3NsL1F0NTFqMVd5VzRrNlhTazgvazR2bk9BNzJm?=
 =?utf-8?B?Z1dTTFhBdkY2a0RORWI4ckJ4OFYvYmt3WkpJUUVrYTRSbUpxVGlad2IrNkNQ?=
 =?utf-8?B?R0N2cU4xMGJiQklSMHhNUzJheC8wOXNSVG5CUjQ3UlY0NkxvQzNqeVZOaXRF?=
 =?utf-8?B?VGxiZnJBUndWZzJSRzhHOWZDcTFVUUYwTVhUaldzMGd6eEdPbUtvVVczTWR4?=
 =?utf-8?B?bjN1dDkvdUdBMEoyVnJadTdCOEZhWUVnNWVBcXVJQnFBUUFjZTEyNWg1ekZa?=
 =?utf-8?B?WTJUbmkyZnhCeTdvWGR6OUEvZVZjUWQzK0JLMjBTb1FvL3RlZ3RZUlBHdENl?=
 =?utf-8?B?a29wV1NSeWNqV1N6bklpOCtkUlM2Y0srcy9WVUhxaHZMV1pBS0EyVE1rVXJq?=
 =?utf-8?B?UzNqSS9vcnlaaXZOK1ZhdVU5V3h1T3VjRmppQ0F3azdCOTF6S3B1bzNMZkY4?=
 =?utf-8?B?TkRoSllsRTZQM3RVZFVKTkNUODlJd3k4d21mRjhWNFQwWWo4S0FhN2dxYVBJ?=
 =?utf-8?B?UVhGSk15MExSRFRla3FsVFlwTjQwbng5RXY3M0tzSkxKQnM1T3N6M3pYdUVS?=
 =?utf-8?B?N3pnbHh4R2wzTGczaDJTWDRVUWpFTHdDakRtWlV3dm44aGY2Z3pOcjVxbFRT?=
 =?utf-8?B?T1RiUTNpcFVkU1R2clhKT1ZGeng2K1RibmkvUVRvSFNNNlNabHRsWVc2a0lU?=
 =?utf-8?B?U1FvQnJ2QTh6Y0xjb09uWTN5OXdBVkhBa1Q0VGE2OWhPN21FQm5zUkxQQlpz?=
 =?utf-8?B?Q1l6WUEzL0U1ZjVyWlBCeDhiRkN4WnZ0OGtrS2g2OXRTczNDSG0zR2srTGR0?=
 =?utf-8?B?dkw2bHZDS1pyQW9qK05ZMGRzUWFYcXZMcms4TUpmYUJRanRtd0cveEhzVVRN?=
 =?utf-8?B?cW8xOEJSdFE3clovYzdjaHNkbG4xdXVxQ2Z5K3pDcUlTVkZwL2JZZFVnZmdU?=
 =?utf-8?B?bGd3OXl4SElTWmFoNHhwL0RIeWZIQ2hvMHY1bHp3Z2tjZmJzTnF4R0s0eUZw?=
 =?utf-8?B?T3U0bDBuYXFVamFvMG5ZcGZqWXJMZlAvdFpDQmtHY1FXN0pPYVZhcnkyY1Fw?=
 =?utf-8?B?dU5Na2xKR2pQWEpzSWdoMGxFYnV2RlI2TUJNc0lNTEhlbUpEVFBJUHFMNjBK?=
 =?utf-8?B?clFuQUZ3LzJweFZxZ0szTkU3WXoxMXdYdEJqOFFxOEl5dkR6RlVtWHNmSmZO?=
 =?utf-8?B?OHMwb1Bacnd3TjdScG5vekNraTQxSkw0S0V3c0xPVm8wWXZha244STZNNTN0?=
 =?utf-8?B?NmdUL3JLbkZhTHlPcE9QNkw2MFJjMGUwMzIvOG5IMkVpRmJpU21FSlA2K2ZM?=
 =?utf-8?B?WWtCQ2hMY09EYTB3QVlleHdRdzRDU2l2YjN5MVlCelFuSFlzWjVzM3BJNDh4?=
 =?utf-8?B?OTA4RG5GTXpENWNsUTFlZVJOaG5QZ0NJcDJML0lIbU5VRERZczQ2QU1CV3ll?=
 =?utf-8?B?TmpJMGsvMlowRXZ5eWNwcUFIU2c1RkROYmUyTTdHTHBBM0hxZ1ZpZE5CVHhW?=
 =?utf-8?B?WlB3WXdnQlZPNnpXTFBKdjFnZnZIdXZTenpoV250SWVmcm96T0tWY2lYVFBo?=
 =?utf-8?B?T0R4eDlYbmlHYWZZcldxVm5wenN0aFNFL3BlMlhDd3lwWWhUcCswdlp5NEdI?=
 =?utf-8?B?UTkzRlVCM05LclFJejc3cXJOTTdtSzZySVZUclhBWVdXRVIvZ1lkVTdNeGw4?=
 =?utf-8?B?OXBpT2xpdytGM2Fwa2FrY3VyRDBJcTFjMlRIYWhVODFVenlrTzFFVit5dHcx?=
 =?utf-8?B?MEp0N0N6dC9uZ3RnVXVhbU9QQWFiMkNkR2d5OXQ1dUwxWGxuZEx6MFluZnlo?=
 =?utf-8?B?Y3hCdlpKUkFmZEJYaGkxREtCbndaZDVLY2ZqdnlVU25QVzVzRVNONjRXYXFQ?=
 =?utf-8?Q?izarKLh2T2Y8YX2kSzkNbIHpO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988d344a-d1f8-4ca9-c10d-08de341c4ee9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 16:35:33.9223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW40kG2AjedetbH58MmSv8xzpCLXG3FbbW3m0HcWMzxyBkfyArmiz0QvFiXgWtZje53H2BYE1nILfNGNd0qv9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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

On 2025-12-03 09:44, Andrew Martin wrote:
> The return code of a non void function should not be ignored. In cases
> where we do not care, the code needs to suppress it.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 +++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 8 ++++++--
>   2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index a2879d2b7c8e..02259886f93a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -312,8 +312,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
>   void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>   {
>   	if (amdgpu_device_should_recover_gpu(adev))
> -		amdgpu_reset_domain_schedule(adev->reset_domain,
> -					     &adev->kfd.reset_work);
> +		(void)amdgpu_reset_domain_schedule(adev->reset_domain, &adev->kfd.reset_work);
>   }
>   
>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> @@ -714,9 +713,8 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>   		if (gfx_block != NULL)
>   			gfx_block->version->funcs->set_powergating_state((void *)gfx_block, state);
>   	}
> -	amdgpu_dpm_switch_power_profile(adev,
> -					PP_SMC_POWER_PROFILE_COMPUTE,
> -					!idle);
> +	(void)amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_COMPUTE, !idle);
> +
>   }
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 041237861107..66ded3c07eef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2796,8 +2796,12 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
>   		 * SET_SHADER_DEBUGGER clears any stale process context data
>   		 * saved in MES.
>   		 */
> -		if (pdd->dev->kfd->shared_resources.enable_mes)
> -			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
> +		if (pdd->dev->kfd->shared_resources.enable_mes) {
> +			ret = kfd_dbg_set_mes_debug_mode(
> +				pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
> +			if (ret)
> +				return ret;
> +		}
>   	}
>   
>   	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
