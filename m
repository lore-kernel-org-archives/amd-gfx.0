Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C536AC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 08:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9CD60462
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 08:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B9CD60462
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2346EC11;
	Fri, 12 Nov 2021 08:46:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B936EC11
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 08:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiKG+Jrv9uTD8sq1O/aZWgizaLxuEjrfp81bT2JLCIB9ZquplyZ92/azMW4RJkR0yOB/sF/H+FOvZhw8fmIP7OdsvcTVuCvdtaGjtGqhUHVHuXLtq8eUR4xYj1Q/AQvC7ktvrjadqANuN+FZjdZsa8Gd2Xr9hBQHGaPpioJ8EvKs4eJ/iLyd63vQLFMGRf0RzFkdu9tjEGaK4Sd7Fus6BwqCib4Ehl0mdm6ZSHvQxTHWl0DvXgjbKn6P2mBLLPg/o8z9y1gBEh2tGzyO+/AcxrB8I/HtL9HG2YpegmqyVBjjr2Kx1KqrouFvs3IC0mvwuTbgzYWldhBqXpkGA+fw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+crBkbtsKekD67vLqSLYtdwaDob5X1hCHta9+xZfX4=;
 b=ZpLPLwjy8nteZliG/aLNJPGF2xY/0kaBWN1grb5K6SMM6Lrncevxh1tegZpT3/E7FGcfy68sbpwJQLBHH6xgmgsxH/FxF/v4um9LaWWSIU1aQ6JH3tBRoYo/GFJfh9TTLp2lRsf74jBNFunba8cI29cAye9iGFBH9ouMt29PowBXpJx4ErGjTPwGvQJ0RtK23XM+bjnQGrd1B4v3NzC7lmngWeIgi8joWVSWpea1k0Fa+26immZVILp4KLawAcWfTDvyhxX5o0ASRICx1A0SQOi4nABYpe7qT0Fxgbyj9XZPVHspC9boSil1/VLquf/rcf6rFYkBXHuHeDefzu0c3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+crBkbtsKekD67vLqSLYtdwaDob5X1hCHta9+xZfX4=;
 b=G3QspyVQwGoyWJc1K5ZaUZ3QIQaTKuDz5wvl5Fub6THaeju4E1pyE6WdTGhhXSQW7CaNE2dwEfG09t9VAC9RmEL4Yu5AaK9JbHv8CCW5i+BCWfNwUJ1qMFYNrITN8kNFcOlTaQkkDO/IFIZaR5RcyYnlGIOWnu7QQGLsz0QHa9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Fri, 12 Nov
 2021 08:46:13 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 08:46:13 +0000
Message-ID: <c06186fb-6718-aa3a-8402-d4dea52f6fa1@amd.com>
Date: Fri, 12 Nov 2021 14:15:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211111075730.184218-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211111075730.184218-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::30) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0175.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 08:46:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd42135c-d01b-4116-deb8-08d9a5b8e18c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4451A8786ED6BC38AF516D0897959@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdIFzsp6f3BRU9nKAfqlxYfnctdYmRHhx69b5uU7J+7NywNRjnMEw85uEUPk3NiAuzgInocSImgr8WBsFQLsRtSHpQfWFhzvwROocDTpIZxJZ3I44T3Q0QAqN1MHZCWJAZMhXKJLgTn7Ar4iASa/N4B9fC+psH5XfY83mP7YzSI/wRKe535l9BrGfkMScI/ONCu+HgS7xi6r8eW+ZWQbp6k3E5i5GHfIxuah1DL8OxHyTRdGEm1pwYxqxWspoXfIoE+VhROyFN9LD92LBvCZfXAfev4u4dlqUE01MhI+qbdZwGqdqK4qaffD//KfOETZwxiC/daj1xow9763jQo+EmYsTmuYK/iCxpZhcSnip3sKfXvqLgf8FNtfAChR8T2XuYsjNGNea/CMD9vXEWO/cR7U14Uw9xypYDPecoanAlboRnrYDc03fnbhYHvis9LVrT7jWlgTGukMiEYE5cAxOhXoiM5sDzOT/4C7f4f9QOADygSl8bQOrbe1v26Z06Mom8OjeYb4tj/YUTcLE4VIiqA9MWgm2M4GwOkGD2SAsxEjc+ZuSSa8gQNDnoBNVUHdW+mWEbp3l90onk3YNpGjaoIdYJzr3PE+nYw1Tvylwd/f0qg0apoA4YwUjpeQQpHjMs1l9eVSiOLgk9/QPYhYd88y5U7nydlWEKQmofnVdE6kdRNlikAN3+IoJMXM5hrAf3eQusWEEMKmK6x142sXrB0gbIaordKZuSt6S9ndQ0lXJAvX5yHwgahR6Z/AG/nVDTtmYyr5WB7EQxXPsH1z68F60tIIpEHcp0nNy17dJPzjH2mO7TQp8bpaYvH+hNgf/stfKg3pswVbmbmxgFBlsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(53546011)(26005)(4326008)(6666004)(186003)(956004)(2616005)(66476007)(8676002)(66556008)(8936002)(16576012)(5660300002)(36756003)(31696002)(316002)(6486002)(83380400001)(508600001)(966005)(2906002)(86362001)(31686004)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZYeGZLcGJ2a0ZUREdTYTJ2amo0NlUrS21vak91czJid1AzWEpMa2dFOXBt?=
 =?utf-8?B?U3VsdVowQmcydTVmaWFGY0NQRHhKR2JUZVFaMWtkQWFZUndha0NYc21tU1JV?=
 =?utf-8?B?TGJ6ZXMxcnhzNkRHVi9ENjNIelFnTTNhUlhydzBpRlFCVm9yOVkxV082R1py?=
 =?utf-8?B?UGNzMWN6eTFEYit6Vm56OGp2MnN2dHRvdWhNaStZZDg5S0hiSmhoVzUxcm42?=
 =?utf-8?B?NTVwbU5xUjA5dUkycElmRE8xMm9rMDZXQ3RiY21ZVnhlaHdDZE10QzJER0Ns?=
 =?utf-8?B?cWlrbjVkTXhSQWVzbytZZE1BaTBkMXBKU0FZUEtnUDBzZTVzNmxhWEJkSCs1?=
 =?utf-8?B?UTNVN2ZiUEE4THFsT2c3cE9PbXBEWFhJUkNuVXFIazRLUmxjRnB3TFdHdDZl?=
 =?utf-8?B?OTg2SUNtQlEvZmxyNms1UVZDRlJLc0VCeG5FRzE5c3JyUStmUG5pQXpvWHY5?=
 =?utf-8?B?VjBIbVdKWjQ3UFdXTE94aDJzc3ZqcGRZYTVQbnlWL3ZiakpwMCtsajRqVk5P?=
 =?utf-8?B?Tk9tcVRVYmNISTdTV3dSYnNiK0QvOFBwSzV6VEpvdFVPK0ViMHN1KzJYaXRy?=
 =?utf-8?B?ZVpZR0x1VGo4bmhYdnBITDRyVStZblArZE5IVGw0UTc3K3J6Sk5rYUY2SnFx?=
 =?utf-8?B?amV1bllBVEdPQ1FyaGR4TGVWekFzMGFlcm0waDZlZVRzM1Q5Ym94MU0zd3JD?=
 =?utf-8?B?ZVJScW02MExnRENyVVhZV1pLZ0pSc3JoVDEybWNKNEV2VUhTNEsyVTJEeFhQ?=
 =?utf-8?B?Q0ZhVmRKVGhEZ0cwK1ZvTXBNZWozNlJoTkx1UDJYS0piWXRZZXZpQ3owMVYz?=
 =?utf-8?B?MXRQNGpnMTBuTDBHQkl4d0tIZXdVZnJuRzk4a05aV2Q1TFROWkFHc1FCVmFS?=
 =?utf-8?B?ME9GNVN5ajlibVJtWmR0d3hZNmx3Ti9oZms5eEpEL2VwT0xZbW5wcUNFU3Zp?=
 =?utf-8?B?UXVISEJKcGVnR2JHWVFxZnVac3BMU3VkeGlJcTR5WW9xOTBWUEY2VWF5aGha?=
 =?utf-8?B?VHc3ZVJWZm9wT1Vsem4vYmhOUDh3ME5KaW1MeFpaVGoxcmxIWTlYekJDTitI?=
 =?utf-8?B?SmcvcThmQmZjWG81YXVxTkU0bTZoRldoVlRpcFk5b2hiUmJpODlIVGhyc1VW?=
 =?utf-8?B?bmQwUDFhVHYzTlBWbWhkZTV0WkFOQmthamJGSElRTndpcEN6NFA0enkxU1ZO?=
 =?utf-8?B?OEZkMk1VUEhMUmlMQ1ZhNGFoVCtNdVp1UUxPV3gvbzhOb0NsSjhib1VVNjhZ?=
 =?utf-8?B?YmRVc0VXRkFuR3N1Vko3TmlUS1czYUF6M0tUSDljbHpzcFptQ2NoWDI3VW11?=
 =?utf-8?B?K1lDSlZPYXIxOG9kNXlVcHdJaVZ6elZDcEVLcndWMTNrVU8vSVpEUXAzRExO?=
 =?utf-8?B?ZUw0ZG5sZjNpVGJEUENINmxOV1RKaFlpb1gzTlNCdmx0L3pwZFJQcHFwUFUx?=
 =?utf-8?B?NlJmT1ljRWFBYXJSa240Y2RSZlVndm9jSWtxQlNpZU15aEJtRjAzZHNzdFlK?=
 =?utf-8?B?by9DUmwzQzErcVdITThqZXk4cTYvYXJlRjNEWC9hZ1dJTEE0TVljRm1PVTFW?=
 =?utf-8?B?VjJPZnBxQW9KSnVPZDgrQlpHQllSMTBRY2crbFFqcVNIQWxGTHY3dDNKZ2tE?=
 =?utf-8?B?YjhydnVwMVkycGd4ejAvYjQvSmxuMUM0ajcxcUhDOWZhaVVNakVHbFZYeGJ6?=
 =?utf-8?B?dytXUEdWbjh1ZWxUek40Q0l5SS8vN0hOSkEyMFMzKzUxSll4c3dxRzE5ZkQw?=
 =?utf-8?B?OWZrUDFNQmlSdTVjQ1ZodFlpR2x1QjNTWVNkRzBkbWNjbElSNTRsZW1mYzEy?=
 =?utf-8?B?VVNKaTVOWXZneFRyZ2p5dldiSUxpcFVIZW56aEh6VDRaaWo5K2hrTDhrdnlB?=
 =?utf-8?B?WktFYS82Y3I4WC9VejkwVFlGRFY2UldHcFdGd3VNMDJVRE1qU2NvTDJETEFh?=
 =?utf-8?B?ZTJhRFR4Y0k2SzFsZ1N1cVdPQk1CTHE3T1J6OVlqQzA3YW1TbmtONUdma1Nj?=
 =?utf-8?B?bXdOa0NkNXlKR0YzVjVRSVZYcnQ1VHoxYWpjUTc4a1VhT21hVCs3SkdnWE9o?=
 =?utf-8?B?dy9NRzNJZnBzQXlQb0lBNXRWM1YzWU5JMVk1TDhXNWpwdUFta3VHMWltNCtU?=
 =?utf-8?Q?PHhE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd42135c-d01b-4116-deb8-08d9a5b8e18c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 08:46:13.0524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v95D4hpFeq/QTEruzPYQ9zeVZGSaDjH/PNMmynvb+SpWM6HG6nwtqc+O68iDlyko
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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
Cc: Alexander.Deucher@amd.com, Borislav Petkov <bp@suse.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/11/2021 1:27 PM, Evan Quan wrote:
> Just bail out if the target IP block is already in the desired
> powergate/ungate state. This can avoid some duplicate settings
> which sometimes may cause unexpected issues.
> 
> Link: https://lore.kernel.org/all/YV81vidWQLWvATMM@zn.tnic/
> 
> Change-Id: I66346c69f121df0f5ee20182451313ae4fda2d04
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Tested-by: Borislav Petkov <bp@suse.de>
> --
> v1->v2:
>    - typo fix and add link for the issue referred in commit
>      message(Paul/Boris)
>    - update the data type to uint32_t(Paul)
>    - better Macro naming(Lijo)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
>   drivers/gpu/drm/amd/include/amd_shared.h   |  3 ++-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 12 +++++++++++-
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  8 ++++++++
>   4 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0bd90ec9e43e..fca592394fa1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3508,6 +3508,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
>   	}
>   
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> +		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
> +
>   	adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
>   	if (adev->rmmio == NULL) {
>   		return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index f1a46d16f7ea..4b9e68a79f06 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -98,7 +98,8 @@ enum amd_ip_block_type {
>   	AMD_IP_BLOCK_TYPE_ACP,
>   	AMD_IP_BLOCK_TYPE_VCN,
>   	AMD_IP_BLOCK_TYPE_MES,
> -	AMD_IP_BLOCK_TYPE_JPEG
> +	AMD_IP_BLOCK_TYPE_JPEG,
> +	AMD_IP_BLOCK_TYPE_NUM,
>   };
>   
>   enum amd_clockgating_state {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 03581d5b1836..40fda199a86f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -927,6 +927,13 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>   {
>   	int ret = 0;
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
> +
> +	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state) {
> +		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
> +				block_type, gate ? "gate" : "ungate");
> +		return 0;
> +	}
>   
>   	switch (block_type) {
>   	case AMD_IP_BLOCK_TYPE_UVD:
> @@ -976,9 +983,12 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>   		}
>   		break;
>   	default:
> -		break;
> +		return -EINVAL;

IP blocks which were not handled by PMFW were default pass before. Will 
this be a problem or return 0 here to keep the legacy behavior?

Thanks,
Lijo

>   	}
>   
> +	if (!ret)
> +		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 98f1b3d8c1d5..16e3f72d31b9 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -417,6 +417,12 @@ struct amdgpu_dpm {
>   	enum amd_dpm_forced_level forced_level;
>   };
>   
> +enum ip_power_state {
> +	POWER_STATE_UNKNOWN,
> +	POWER_STATE_ON,
> +	POWER_STATE_OFF,
> +};
> +
>   struct amdgpu_pm {
>   	struct mutex		mutex;
>   	u32                     current_sclk;
> @@ -452,6 +458,8 @@ struct amdgpu_pm {
>   	struct i2c_adapter smu_i2c;
>   	struct mutex		smu_i2c_mutex;
>   	struct list_head	pm_attr_list;
> +
> +	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
>   };
>   
>   #define R600_SSTU_DFLT                               0
> 
