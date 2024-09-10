Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D96EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 13:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA5E10E807;
	Tue, 10 Sep 2024 13:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VpTAMGZL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF27610E807
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 13:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNKH/dATSVoAD9USBVbg5SqQ4aPxefOSi4DbxpuIw50RyyXViyl7BgCjNt1aUAXWYACA5LaXqVtrdRiro6OqgvLj/BaLfepfq0SIW1caV+hryrgCd5meXu+KqQs49eqvPus/psnrM8hOid5VKJKA4oMQMEO0P3dFA1xMsEV4b6sv2BwvPyADh2EmtrIvnk1SgvVGsxfdNHi9Fcqm1ECtu30GZmrVpsEvnSwkV8dF0VqtzbTFkQ4P+hN/lVcCQCv96tN3o9CcHTxdT+YHDQyFBG9EOpDOfWxnHZcrNDeRiOn7e91JsNSL33gvgEIeXrvAIhRFYggzZ1IO0jb0nQtuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYufVp+CyGeKV32azNbLMzkD6qLbzllTh8ulKQaqBqY=;
 b=ybnkBfANYuy0dFmTWY6MTxmiqx+pbTQnu4uQ18XH8Fc4biA4vcC1dmaFGXMuPykPmKSfMJSzjcZS0DihfyS//Ab+t8zrhXVxShbq7uny4K90U7fSmpdDBWC14cjXoQ/odlr4mObth+LKfHaMwOnLysIYHI61Vvsg9vVERvkKOpYF0bLJlSvwS45Y8y48AOVuBttFZ5UPM9o2u9Yg3rcnoj4ItAWdGdMtdTKKpVqGiPEKlRr1qxdBF+B2XJQ0op4qWIynJZEYw12ju3u7MamFOgosHxxR63Nwf6kFvBsdD0cRcV6x3jvbo4989kn8QTQs6nDYSsp9I6n0kE1IHEY5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYufVp+CyGeKV32azNbLMzkD6qLbzllTh8ulKQaqBqY=;
 b=VpTAMGZL5PCm1X6nqc09M5fngen5NbHdoSan+KQnY+ZpkOI6JvRplUl5NkiP30rF0XpCtzKNVUAk24CE7AvGkKHWJ83ft/4Ph3cEeP8bp6qApEcJJ/zi+HwRoXkwXzYCwbv75OI5CbfZHt5UhTDwYfgy3gEZkCIORdGx1P8iiDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 10 Sep
 2024 13:55:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 13:55:08 +0000
Message-ID: <dd38b339-06d5-40d5-8013-523bf4ea9c48@amd.com>
Date: Tue, 10 Sep 2024 19:24:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific
 ASIC
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
References: <20240910083739.20813-1-tao.zhou1@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240910083739.20813-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001B0.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::c) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: d014f447-957b-4e00-ce6d-08dcd1a02e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTQ5QnpnME1SMjNRQzZIVU1vQ0tDYklKS2dKMHQwZjhlUlozYVN0SEVQY3NI?=
 =?utf-8?B?cVAzTFQvVGZXYVNaMkphVEhZclFNZjVsNnFPK3RtM1pKQVEzVHUwaC9ZTjlk?=
 =?utf-8?B?bis3VSs3VlZmUHNFY29BWTkvNVhHd0lIVnh2aWlsSHpEakFQT3M5TXZxUmx2?=
 =?utf-8?B?NGRZS01yOTMrRXZHMGY2Vi9SUWVvZGZOd0g4VkxXQ2pQMGFGemMzKzZCQWNW?=
 =?utf-8?B?azYvQStRa2k5OXhIZzcwcVJsVkh2M3N2cU5RbFFxaDhoSzlWdGtpdzN6RjZ0?=
 =?utf-8?B?ejJ4UEZYWXU4U2hoeWlzUlZ2cVhkQlpxNXJLeE51V2FmYkVvOXRNQk1RN2dH?=
 =?utf-8?B?SSs2YkhoeHVWZzBxVkE0d1RSNnRoTjVOOHlGSjIvSUxWZU5iK054bmpGV3Uz?=
 =?utf-8?B?allDR2QzcXJXZVNKM1pTQ0ZNWjJOZTVnTytkVFpUZllzL1ZGaGZ2cVZFYTg1?=
 =?utf-8?B?dFBhYWdUSFBSMk1WN250REZWT2Z3aFNhKytxNDJObDZ4dVl3aUpneDFCU2pB?=
 =?utf-8?B?Z3ZyUDMwMHZkNERDRmtVTklXQy9wQ0JXWHNWdXRiTHNOZ1VnTCtJTWJ5cDF4?=
 =?utf-8?B?QkJxZkh6bjlPRW5NNXEyYThWeUxKWU5DaDZIRjlTYVhQb1NQZ2xCRzU4S0sr?=
 =?utf-8?B?SXBmUERXZmo0aEJWODl2RHZDR1ZCNXM2aUdyY0JEVWZHZGVuS2Q1RE1oNmsv?=
 =?utf-8?B?cmg4QjZUekU0cEc3OW9hU2FnVm0yTjlGNVZRcGRiWlNocVo5VnAyNk5aQi9q?=
 =?utf-8?B?TTRpQ0MvWkc5dHhXT3NlcXU0ZU1lcVo0YWxwc0liYk9SZFljYmtmbGQ1Y0pO?=
 =?utf-8?B?Z1lRWnJ6bEtXRjVocHJKcnZKZzhWa3M4OS9vWWFGZHBJTkM2dHVzV050VUhO?=
 =?utf-8?B?TTRLdnhqN1R6b2laUkFHaUxNeGpUcHhUNG1yQzFON3JnR1dXc0VYb0ZZNjhG?=
 =?utf-8?B?dG01dFUvOW9SU21GeHMrR3hGWVlQaTl6VnYxMjRkc2Y4RUhtV0g0LyswcmVt?=
 =?utf-8?B?N0xwUzNKczJwd2VFRXNvMG1ieVJnOFNlRk9ZZU9TUDlOdkNaMnNhRzFVam4z?=
 =?utf-8?B?UlAwRDJ3U2JIZU5rZEtjVitVS0ZHL1ZvT0lxMEZFNE1PUERkZ3VmUVozbjlT?=
 =?utf-8?B?azB2dEJMUXhIaUVBUWxEaVFHUWlZbVBrV2VhbnRJc2pEK0x2T1V0SWR0dkVC?=
 =?utf-8?B?T3VqTndrQTBZMGlWb3pZNURxWStPUk11bzd2NTFUUTJ6cGFyYVl4aHFoc2Vx?=
 =?utf-8?B?dHBMSlJVS2JreE9VSm5DOUMzdVhMM3RRWktTVTc3MU5hRCtDcUxBQU9obEFS?=
 =?utf-8?B?NHQyU2theTFCUnpYV09zeXE1VmtLOHB2MGZ5TXNXTFJSTjViYUF2aEZnSWkr?=
 =?utf-8?B?L0QwSmFQenFYSitzZ0lXOHdBMXh3S01qSFRKRHArTHFIa3NtL0tLbGFZVWlt?=
 =?utf-8?B?OHlJV1hiSkl1M0V2MjZvUjlzYmdwQkgvNHBISzRPMkh5ZjdRSG9XTGhVbkNo?=
 =?utf-8?B?SEZIaWJ3Mnl1Zm1Oc0NNWVRRMjEzK1h0S0hsOC9VdmZHa0VJalJuK29keVVu?=
 =?utf-8?B?bkhXMlZ1cmIzQTlTVDVjaFFsTjBGREgxYlpNTzcyVjN0aDMxSURoTDBiYlU2?=
 =?utf-8?B?WDdYVlBET3J4MUpHdlJYWkdLUTV3cVpsRVVNdFBPTm5DVWlmSW5sakdaZnVX?=
 =?utf-8?B?ZFVpT3daa3dOaTNiNnlSY1Y1YjhjWTZ2VGdaMjUxUlFMMzBtRWJKeHZPSnFN?=
 =?utf-8?B?Uk9SRHU3VXIzaFQ2anlPWjNuRWtBYXU1Uis0aXc0ZGZqbFFtS05RZndkSGRq?=
 =?utf-8?B?bFQxenVGa2ZCdEVPbWVkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEhvdGE4SkJVb2orMFZIeFNnQjNhVXhEeDUvOXVFZXhuSEVPMmJ0QytvMkhn?=
 =?utf-8?B?VU5yaDJCMzlOL0tNT3ZZSkx5QitPVTJ1aFdYTWs1bGRGazNucEU1dTN0K0Q2?=
 =?utf-8?B?b2ZOenRRWG9jRWQwWlk5M0hIWVY2d3pmdjJuS3VjUXhtREFlSERGN2RoOUVh?=
 =?utf-8?B?S21XaHFBaGE4V1cyMXlQZXVaYTBVYTQyd0hnNkp1V0YrSWdYNC9Pc29Ld1B2?=
 =?utf-8?B?SXNEeUdvdmFtUWNsRmV4S0xGcngyNkhvS29Kd0h4QzZsWGZKcksrL3dWZmZB?=
 =?utf-8?B?Y1FqL1FXYUJaY2VHa0JLNlo3ZUlLUDRsVkJ6Yll6bDVKNkhMUUtNWnlZb1U3?=
 =?utf-8?B?dUhXOTFyR1pGejJMdEY1QXFyTWxSenQ5dFpnUW51SU8xQi9JaXlHb3lPTkxW?=
 =?utf-8?B?RjhpOGlYZVQ1akM2ZHh0SHZhNmdpN3dOUllpWmY3WEVpTldLUGRGMHg3L3B2?=
 =?utf-8?B?K2pGbDNIeUs3S0FiLzlwTFBBVGk3QXNhQXpDOU9IcFBsVjhhZk1Da2hZMXpS?=
 =?utf-8?B?OHB5NStFWDNXVndXbStUUWZteWt4TzgreHNQMi9rUDY5eGJCeFJhOVhkalVW?=
 =?utf-8?B?dUtzTEVNVEc5SWtGcHpZc0IzRG9mSEsyVDc2bW9kOHZuOHczcmtiVW9xSVlD?=
 =?utf-8?B?Wk9aOUppR0dZdEppQTNLaHVEYzdmSGVBR251cE9YbWRLRjBBMVBZbHMvazA3?=
 =?utf-8?B?bUludjN3NnMvU2JsWmFGSUpLb1FUOC91VEMrWktZQy9YNklldW1LekN2TG42?=
 =?utf-8?B?ZnBwcTQ4QUpRR0U4bTJDUUhuZHRzaVgzYVRRREFTamFtL2lGSzhBNjBGQS8w?=
 =?utf-8?B?WHp6UlYzczZlSUhqeHRCK3cwcmE0M1lxTDdpclpzSXU2TUJuclNvdGZzZ1F0?=
 =?utf-8?B?ZHBrcFAxNmppWGFhSzBNTzNyc0ZQTDdic1FMSXQ3cWxTMkxZTlZoZGI4NWMw?=
 =?utf-8?B?b1FqQ3VILzZVRTFWUjBjdzliN0t6V0tGNCtEbUFqV3RXVnRTQ2lmS3RyTWpG?=
 =?utf-8?B?OE9ONUdPNW90Qk9nb01KMU03aSs2MzBLMGdESzhZMm1zV2ozUGpqZDV2blVl?=
 =?utf-8?B?V29RUUo5dVR6K3BLQ3QzSGdwUWU5N2JPMDJYejhlSCtJWTNRVjIxczZKbERC?=
 =?utf-8?B?aUVMbmg0THJrU0xxWEdSaUtnSjhZYTV6emJLQlBuNVltVzBaUGtmdkY4c3hU?=
 =?utf-8?B?NUxlUkdjck1jRWxKcEJZb1NkUU5CdUZ4WDlyRVlwS0U1dytPNTMwaVRJSzJz?=
 =?utf-8?B?Q3pCVnJjWVV2aXF5K1R3a0EyOGVNbnpaNW1NbnMwaVFIcndXcjRJVjVuczcy?=
 =?utf-8?B?OGJTQzI4UU80TjBMYnI1aUhJbjk2bFBSTWpwZEFSNkRXNGkreFZ1Q2l1U2pE?=
 =?utf-8?B?eE01R2plN2ZUOExFK0ljSW84YlhOSDVrTGJqaEx4M0NDRTBoWmM5aGFLWklq?=
 =?utf-8?B?Y0ozVGR6TDgza1ZFd25tMDFNdVZTcHRpOUdNenAyUmxCTWVjVVd0aU94R1Rw?=
 =?utf-8?B?TlREV2tSdDRpUHd3YytUUmtzdzZIdGc3OHdKbU9UM0pWR1pMaWYrU2FTM0NF?=
 =?utf-8?B?ZUN1Z1BVM293a2VjUGRZdEREaWV2cmIyMTJwVU02VlB3ejJIVHlZNG94bi8x?=
 =?utf-8?B?S28xVUNsejhkUHNtaFp3WWhPZllodi8vRFg2aW5oaGp4TWt4aVJPY2R2elV1?=
 =?utf-8?B?TWZiMXhKZFFFMENWaFFvOWJqRUkvRXdmc1oyTEpXbkdMWS9iTldBelY3dmox?=
 =?utf-8?B?Q0cyaUpzanVVUHZuVEZwNFJiY0VTZitmOGFwWlRuUklqdWFBdWJJbGFNbVI4?=
 =?utf-8?B?L0FTeWlWQ1kwV3AyVHN5Y1BMVXIySFZTR3UrSFVrRS9WbkdSMWRubUFCN3RR?=
 =?utf-8?B?ZVBlRkpqYVo0c3JtUXBZdzRjT0ltYkdIbUlpMy9BV1ZrTEh4SiszaHJTUTRL?=
 =?utf-8?B?VXlDb01wZUxDdDlXSGV4b0JTQnY1MHpteDB3Q2VyS2RtY3hDMWdySTM4RFlZ?=
 =?utf-8?B?ckJLMGYrTnRETjh1aXF6VTBMWmVjSXYrSEpoNWlURDNaYVFhT3Q5RXZoODkz?=
 =?utf-8?B?NTNzc291QXZHa0E3RnZ0aWcyWkxSWWFHMTFDd3JXdzFUeEVvYzNickxiVCtk?=
 =?utf-8?Q?So8kGo7KAQgCe6fS0Rsimu/jN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d014f447-957b-4e00-ce6d-08dcd1a02e25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:55:08.2262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLGQt9CeE5l1+vg5fJQDzqPv1jpZjn/kCe+rQwsvtL/NFAqCs5VBjh470emXbOq8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7901
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



On 9/10/2024 2:07 PM, Tao Zhou wrote:
> The feature is not applicable to specific app platform.
> 
> v2: update the disablement condition and commit description
> v3: move the setting to amdgpu_ras_check_supported
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index dbfc41ddc3c7..ebe3e8f01fe2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3483,6 +3483,11 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
>  
>  	/* aca is disabled by default */
>  	adev->aca.is_enabled = false;
> +
> +	/* bad page feature is not applicable to specific app platform */
> +	if (adev->gmc.is_app_apu &&
> +	    amdgpu_ip_version(adev, UMC_HWIP, 0) == IP_VERSION(12, 0, 0))
> +		amdgpu_bad_page_threshold = 0;
>  }
>  
>  static void amdgpu_ras_counte_dw(struct work_struct *work)
