Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3F8C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 03:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED1510E151;
	Mon,  8 Jan 2024 03:50:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DAEA10E151
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 03:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eApEP2QvkX2HZyWZTrWP//MWLLDjjOYXnhnK7zvNVDZNTZe/Uykuzl2l1A+oudkDGxbcKnjPUYqUKsYLIc+UyTFVPrHCfyo1kp2b6cqAhZVfwliPC+zM2U6QoFGNwso0QzzH7g4jKh7NO0P/a64M4b3c9uj4ON00l39Sullyxd3gWlY0FAOyv+1H7mbwFoREjXPZNFXtkJLEzBelqRrrfqqbM1ODY073q3hQQTHOQmUkxru9gkYOV7ZVArHxD1dm5Aj4CAsSXetpwSDod4gEI1XatHPLSQbG07SNBzj05Oz0qfWs7bZcrQv1Y63ANJxVuBmZ5pMEw91jCczesRGeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj0oGK3wN128AHWq5CEzi8MB6bNC+oIVRBwoCz4Ko2M=;
 b=WlO9eQpkD5Y7u90wtkZQDunS/MI/JNpwpPjMCxVvJ1xWtL75YxJhTJwYfheiVWlNipgMDDLxPfymBDDXusI20W5rc20HfjnROW0JdZQbO2xtLvMdV5Sd8FGf8VDGOGv1OAiYd0P9xoLyClCKe32OUsSaJdM17FowTwRUxJYlIsCA3Dub40eGR5SrAWp8sfgYEG4uZj4sPk2cQcD9gzQ1rqbSzn2mBPFPNIVP8omRlzlxlqkY8MmCK0KCHE8EX5Kwjszvo7JJ54diAfwQb7pYv1EmSeWNTtZkMW+XcEejAV4C17QvLorYsNvU+krKOMr29DbKwCjtwM+50RQebTFZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj0oGK3wN128AHWq5CEzi8MB6bNC+oIVRBwoCz4Ko2M=;
 b=hRFHF6OLvhmc0kIR+fzPajTJIJ9hfDaYzLGHpeCkOo0JXe5nTUkx6ZMk3kKoVZ1AY4ynHDGYokwGUA+cpU5gatHVZViWq4bvBzze9XRREjnmrgLeVxvEBha2LytlSXRaPiEJ4W4kkgQ6EnXJ23fzpgyga8ap17SfSE+zjoeXVVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:50:17 +0000
Received: from SA3PR12MB7808.namprd12.prod.outlook.com
 ([fe80::9ca0:c2c:c5b3:5635]) by SA3PR12MB7808.namprd12.prod.outlook.com
 ([fe80::9ca0:c2c:c5b3:5635%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 03:50:17 +0000
Message-ID: <b1b545df-0332-462f-9cc0-0d99deb09b7d@amd.com>
Date: Mon, 8 Jan 2024 09:20:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Update irq disable flow during unload
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com
References: <20240105152100.471494-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240105152100.471494-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::23) To SA3PR12MB7808.namprd12.prod.outlook.com
 (2603:10b6:806:31b::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7808:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5984afc9-4674-44ba-ef35-08dc0ffced44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Wp1kN2TJ3iTINA2elVo6rXa7IqhRdh64epm68b30nqBfis0j1zaKptyhj00MJH9oAuZMA4BGG36m0IClJN/8Cf5a9LKhy/iyNavs44P3HXAz552CwnAmxHS4hnG+SSTl8mN6HGr4PDP/e4OKoEhtzKfASBzRy6bf8PYU0cnDpRZriIzEVU+vtMkW3/DNswWbBaf0SMZ9qvsE3BS/90NkycmCVlUWJ6xSYsLUmBdu82aWGCMNi7QR/tDjVxZzYqgBZ0lqoSxtMChTX+ZSR9NI8d6NSyNMygBus3qFsqTWXVumSVThe7EWDmxLeXA/tI0xD+VNL0YN2Y2Q3IsIuyhtsetNnYlh2X/ijJ9YMxiSbLva2hDU1LdjyIyTXDWz+3xF2GvbE6K0L+LlmFpPS7zbaS9I/P+8ocmXEyXwLDRCpzxdRHT41h+JU0ssrznzjv8/jghiOhSGwgI9ENCkY/NIDcDSKbkfSCjytP9pBb4atVDDHl97MFvlpreZvQuikMOxwrJ8sRqRS7NEgdJdY+djRGvKXBqv5C9Y0HrDPCPX7GeCZgDDj7mDZqtO5fXZRIci+VQ0LJA/d2iZQS4aCZgighUcn2ySCQHO2QkNR0IzQWDcxsBKTHnodi7xdIrYrjbjurqbz4pfZZVRe99ZS5ezA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7808.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(6486002)(2616005)(26005)(66476007)(66556008)(66946007)(41300700001)(31686004)(86362001)(31696002)(36756003)(5660300002)(4326008)(15650500001)(316002)(83380400001)(6506007)(53546011)(6666004)(6512007)(6636002)(478600001)(8936002)(38100700002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhtT3ZKU1cyaFBiOG5IU0U4c0xkUGZ2ZUhCQ2Q4dGpyclo3WUVKVEU3Rmpi?=
 =?utf-8?B?L1JWVDAvRkUrM0ZhNEsxTHVBbTFYeW9KcFRHdklNM2Q4SnVKNzcwMXZwUEda?=
 =?utf-8?B?cWMwYmc5Z0txY0FhMm10N3BFZnVhMGxINTVlYjcxQU9rQSt4T2U4cFNDMGhB?=
 =?utf-8?B?Y3BBc2wvUWMrckEydHYzNlJHbG5pSU9uNTZJTmhFYXJqcnBvekU3TG9FL2Zt?=
 =?utf-8?B?dCsyUitNdVViOGFZMStqSnFwWlNGOGdEcm1OSGhwU2h4NDZHYmpnbDJ2dk5M?=
 =?utf-8?B?c1NteHlyK1Y1NTNLcU1kZlZlbDZtK2dpek1ZUHRyam4zRmkyWE1rUmNFTHdT?=
 =?utf-8?B?N2FoWjlPTXFma2pSdjNDS2Nka05xbUp5LzRFWExVM0xrZmtUUkdzZ0hGNWdO?=
 =?utf-8?B?RlZtZTd5allabE1SN3h1ZVE5aHZIQUxhV3ZLaFpDV1ZxK2RqOWs5WVBibS9D?=
 =?utf-8?B?QVF2MVBhS2ZoOGRReTdGbEx2R09yWDRlemI4cjRiR29VRm9EbHNyODZjVUdy?=
 =?utf-8?B?VlU4VzVGN1UxV1kxK3FVcmw5MVl3NUF6VUtxY25rVTcxYWxVOHA2MVRrK2Iw?=
 =?utf-8?B?MDVkRFRsT2FTYk9HRWNqRGMzOFlHT1ppM1hGVUdFZWhzR25CbVBZRFZORWdF?=
 =?utf-8?B?ZmxHYmFpQ2Qvd1RCeUtmNlYrdVBiMnd4cXJwSUJURjFzRUV4NUZ5VjBaS2J0?=
 =?utf-8?B?M3NJWjhoSVVDMU1mZE5wR0xUN0R5eHR0Y1JjdFZmaHZhL3o1N1JnMEhMb2gy?=
 =?utf-8?B?enV6RWlQRytLZmk2QzRuU2pJaXVZTGNQanJOM1FHSmdnUXRLQ1RzcWlWZEs3?=
 =?utf-8?B?RzNJZ2FYWjJvMVB2OTRJWUwzVDhub2gvUEVGdy9zendYdXppWnBad2RzQUcz?=
 =?utf-8?B?MSs5SVlkdEs3QVp3MUMwU1RIUTBCQ1RBNHpJZmZXblJIZml0K244ZnZIVHNp?=
 =?utf-8?B?WEZuS1luL3J2WVBkWnBVRGhzR3ZsdXR0OXFVOGcxL2xUbVFVSFJDMDZEV2hn?=
 =?utf-8?B?T2hOb1ZRQzVwS2lwdUtCeDNLd0E4TDVFdXVCelo2NXQwQURoTFgwVTkwSlRq?=
 =?utf-8?B?aDU3TmliSnZDZ25zOWRXZjZqby9yTVhIZWhFM2lMVHFXMnE3S2Q0eVExWkt2?=
 =?utf-8?B?RERlSTJMZFhHaUZEVHFYVmJ1L3R2c1RPV015T1hPcUdyT1hUZDFha2IyR2p0?=
 =?utf-8?B?d1hNQ243S3oyTjllMjQ5NTNMcEtQd1h6c0J2Zm1CU3NnZ2tzVVMvalB4cUFt?=
 =?utf-8?B?TG5JOTZWcWxKQjRXREN1VGJHVC9TUm9OZjQ5dmI4WTRRcFk2WFVuYnI3OFVk?=
 =?utf-8?B?SU5VNEdxdGRxeEt4N0ova3VPamJrZ09DMnFMWnRQUEhPS0dLVm5xSTdSbFZK?=
 =?utf-8?B?MTdxYXpnaU43dFJKRndadDJHQ25jSFlmUjNSZTVsNnpLUUpKbXpIRHViN2F4?=
 =?utf-8?B?RFoxRHJEOWVxU08xdGREL1JoMDVkeGs2Yk9VL21lR28xVmdZajBLbkVPbU1O?=
 =?utf-8?B?YWZGeVg2WDh4R1o4Q0ZWMkFTMVA4eXV6UTFvYVpKczhDVU1jR1FpVGJvaTk3?=
 =?utf-8?B?M0NzbmRkRW9aeFhNWnkyOExoVmRlVHhpUzlGMW5oZjNXYWIzUGdTMTRvZlFH?=
 =?utf-8?B?b2Z6djFRZWRIUTRIblBtV0pNazAyU2RVS1FSOE9Mbjc5b2RDbk5hcXBseHpo?=
 =?utf-8?B?cVk5MkdMcnpzbGFHbE1qL01xL1ZMd0g0V2NMQjBIYmd0YjJGMFRtZHlFSlRn?=
 =?utf-8?B?QTJBSlVtU3FNZWhaMytQazk5T0o4Q0ZFcmQvOCtWbVJuOCtMS004RTB6VTVT?=
 =?utf-8?B?WlFhQmQ4S0R0U1hFWU5KQjk4UkwwbCtaSVJkbkprSXFKQy9SbjNtRmplUm5W?=
 =?utf-8?B?cGpMTTFENWR0R0YvNWVTTTlZcm1nMmhrcE16UDNiL3ZnTU5TTHp1bVZiVS9E?=
 =?utf-8?B?UkdHYmU4bEppOFhxeEJrdkUwVEhFZ1RCZmZTZTBOTFpZZWZrb1VOWTUzd3du?=
 =?utf-8?B?dWpwanczbmhFM3Vvdm8vVDdPWExONlg5ZkxNUUFsRW5vdnJmNEM1TlU4RkVj?=
 =?utf-8?B?TCsxcHpWOHZuME5XbkY2VE9QMlNqYlBhUHNFUlpvdzVnd2p5bzBmK2xsbXgv?=
 =?utf-8?Q?YW8zxlEqrx9sNTtiJSs48a4bR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5984afc9-4674-44ba-ef35-08dc0ffced44
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7808.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 03:50:17.0561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsb+tT1qi1+x9d0GkGPXpKHBmSITZgBiAFu1mh1f712VrM74o9/EHQseXi+YldZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
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
Cc: le.ma@amd.com, shiwu.zhang@amd.com, xiaohu.meng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/5/2024 8:51 PM, Asad Kamal wrote:
> In certain special cases, e.g device reset before module
> unload, irq gets disabled as part of reset sequence and
> won't get enabled back. Add special check to cover such scenarios
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>

Please also add the tag

Fixes: f5c7e7797060 ("drm/amdgpu: Adjust removal control flow for smu 
v13_0_2")

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 ++++++++++--
>   drivers/gpu/drm/amd/amdgpu/soc15.c    | 13 +++++++++++--
>   2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 372de9f1ce59..a4e1b9a58679 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2361,6 +2361,7 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>   static int gmc_v9_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	bool irq_release = true;
>   
>   	gmc_v9_0_gart_disable(adev);
>   
> @@ -2378,9 +2379,16 @@ static int gmc_v9_0_hw_fini(void *handle)
>   	if (adev->mmhub.funcs->update_power_gating)
>   		adev->mmhub.funcs->update_power_gating(adev, false);
>   
> -	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> +	if (adev->shutdown)
> +		irq_release = amdgpu_irq_enabled(adev, &adev->gmc.vm_fault, 0);
>   
> -	if (adev->gmc.ecc_irq.funcs &&
> +	if (irq_release)
> +		amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> +
> +	if (adev->shutdown)
> +		irq_release = amdgpu_irq_enabled(adev, &adev->gmc.ecc_irq, 0);
> +
> +	if (adev->gmc.ecc_irq.funcs && irq_release &&
>   		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
>   		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 15033efec2ba..7ee835049d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1266,6 +1266,7 @@ static int soc15_common_hw_init(void *handle)
>   static int soc15_common_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	bool irq_release = true;
>   
>   	/* Disable the doorbell aperture and selfring doorbell aperture
>   	 * separately in hw_fini because soc15_enable_doorbell_aperture
> @@ -1280,10 +1281,18 @@ static int soc15_common_hw_fini(void *handle)
>   
>   	if (adev->nbio.ras_if &&
>   	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
> -		if (adev->nbio.ras &&
> +		if (adev->shutdown)
> +			irq_release = amdgpu_irq_enabled(adev, &adev->nbio.ras_controller_irq, 0);
> +
> +		if (adev->nbio.ras && irq_release &&
>   		    adev->nbio.ras->init_ras_controller_interrupt)
>   			amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
> -		if (adev->nbio.ras &&
> +
> +		if (adev->shutdown)
> +			irq_release = amdgpu_irq_enabled(adev,
> +					&adev->nbio.ras_err_event_athub_irq, 0);
> +
> +		if (adev->nbio.ras && irq_release &&
>   		    adev->nbio.ras->init_ras_err_event_athub_interrupt)
>   			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
>   	}

