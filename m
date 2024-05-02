Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029C3C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 04:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88CD910EA48;
	Thu,  2 May 2024 04:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qorj56mY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C5010EA48
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 04:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTXtufMmKBi46E46asIdpm27jlGsLboycVfM7c9AxJ/6nHu7hDzowifCxHQJV31FR+dpFsEwRvKu6cN5Y77ychUTLVdk/NSIdYdJIPPvpMlklh0mTmoDGQlMW/VqGdnbcZZ9EXO/81Z4gm/3o0Td8r5bXugmayicB7uRAeZxTDvzZ5wgJKNyB9ObGaKWA5NTB5WqmiKnpRGyWdOXhf18QiBaDlIN6h6x22/aj/OoFOjf7imlVaxTFJl9GnoScNm001LfNGP7VetNWgQA1hOYmHwB+bDl7X5LsiY+pOJWO2F7YkYS4GXAdBvpdDys5ZYCzelTM3CPJb55KaDuZ6gwGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YYs5he9WqTTnmqOt7q/y76WvHDuI3X9fCh2kcoD320=;
 b=hQRBPZ+N3TsArrESNKPrc+q6vOivZ3y/8i40lfGbh/8GKHQuFsvErqMx8UKpp1YnJgnoyb894SmmuEYX4qQ8D8tocy3kPTcJrgl90WueYQGsi2J1ylf0CetxEaqu6JgCQLZhj8YAunssT51QVF2oF1mk5ecITk6/ESLouZbJ1DkenjDjbnrtLCAtPLYslj5hB28OloOxAmZNmRYK06k89wxdj4urF7UK/44x9IjLKTJc2CUbz0MXXRUC5LLultypZS6sYxv/kjnihIYuKMdf2x/UkHDQa/3/mDw5sp4qj/J3pjEGfBv6ALCs7fXW8CCrtzsqG8zaVQD3Dl9KCRr5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YYs5he9WqTTnmqOt7q/y76WvHDuI3X9fCh2kcoD320=;
 b=qorj56mYU+qhQRM7SEZzWobhQQpZ4pzzYvJV+ow+MS5grbSWgZVA1EhhikvDNbS9RMgN9GqhvhsnRaedke7PA0EFo6mePv/xApFh0rFgJIvltjerucEXGWua0k+Rnzbjz9KtSHd+QHsaumMRTwdBqcwBrNkVtt3I852hc9ZQ8KM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 04:09:08 +0000
Received: from BYAPR12MB2600.namprd12.prod.outlook.com
 ([fe80::de04:6cf7:afb0:a72d]) by BYAPR12MB2600.namprd12.prod.outlook.com
 ([fe80::de04:6cf7:afb0:a72d%3]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 04:09:07 +0000
Message-ID: <d949949b-fb30-45c7-a53d-a4d32874b3c7@amd.com>
Date: Wed, 1 May 2024 23:09:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Remove arbitrary timeout for hmm_range_fault
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20240501225655.5215-1-Philip.Yang@amd.com>
Content-Language: en-CA
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240501225655.5215-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0139.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::25) To BYAPR12MB2600.namprd12.prod.outlook.com
 (2603:10b6:a03:69::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: a3854cf5-7a55-4d28-edc0-08dc6a5d9cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkE1RzAvQTRMYTJaSUJ3cXBOR3RoNFdDdC9SS1ZZK2JVU1o5cWRjc3VSQkhB?=
 =?utf-8?B?MWFZSzR2OWpQWThyc09BWWlZQlYxcFVNMXlneWtRd3hwcjFydVU5L2k4TUlY?=
 =?utf-8?B?RmVIMTZ2d2ovRWlrY3pUeUoxYWhaZFJqbmgzWTdIM0RNS3FjNmdIRDc3TXkr?=
 =?utf-8?B?NkE0VTVPWkFoUGpsYVdxNVVmMGVIMXhkdnloeGZQK1pMWDc4aFFNdDNUemNY?=
 =?utf-8?B?U25oNU9VUzZDTWxIenl1Mm55R0t5andibGFxZ0IzSmJwWVhGZVNHVk5heUFF?=
 =?utf-8?B?dzYwKzg4WTRwVEVra05RK0h2eFVOVE5mWm16MnFjdy9UL09lQ2JrQ3hidXhs?=
 =?utf-8?B?ekcvYkdzT24wY2ZRdzZuaDZDcVVRWDVJUVN0L1VaZkZVV0xSLzQzOHZzZVNN?=
 =?utf-8?B?M0lBR3YzektSR1pVekZFWDNOOG1id2NFZVJGaDEyTWVMQ0tvMzV3TG1MQnNl?=
 =?utf-8?B?QzBmNHFHdm9RT2dEc3pNdEVJY1dIU09ITEUzckh3eDBURFA4RTV4czZNdTNH?=
 =?utf-8?B?SDQxRWs1LzVkRzdJWUtjL01BZC8yRnpVMnNmYlV6T1h3OFF0RkpkSS9HRXRP?=
 =?utf-8?B?SXlGcDh6QklpMHUwYy83cHVCQ0FWYVp6ZFJxS0h5UEErRitzQUZpU2Y4eWNC?=
 =?utf-8?B?SCtVRnlKdDJZUXF5YTEvbTU5RGI3NzNSRzI2SC9FWTNZNmF3bWFRcjl3YjQz?=
 =?utf-8?B?UUZGMVZvQlNoeVJ6QnVONVloYkNIakc5cEtFMU5xNnlrdEFLL0xuVk1hUHNV?=
 =?utf-8?B?T3hnaUFTMzBDT05CdVY4SFROeHhHTmJQdjBSLzN1V2M1b3Y3TENlbmdSZnUz?=
 =?utf-8?B?OUMxQW9Lbk52WGtUYmVBUmdFRXl6KzRvbElLeFhiNGs2cG1ObVpSdWt6K3RL?=
 =?utf-8?B?bk1QMmViMmJMblgxZGc1R2tYRDM5aGVaeEY0V0NObm5xbGRZd0FxNDkyOU5Y?=
 =?utf-8?B?UTlFOGg2Wjk1cys3ZTFTWUthclhZdVFUdVpRN1BvSHFkY09NMFhQamNmRWRD?=
 =?utf-8?B?cnZSL1VJYmlKeG1mc2djV3d0R1R0bkJDMW9vQUVueDlBMy9RNjhma1Zaejlj?=
 =?utf-8?B?aXhtaWU1VW12cHMvQjd2QUJLcWtGWUZzSUFQRDY4eSs4Z2pHaFl5OXJuRitR?=
 =?utf-8?B?L1VkK0dRVWFOTWtFRFRhemJFK3N0S1B3MG1oTjQvV1JMRDVJem1KUjBTL1FG?=
 =?utf-8?B?VUhNTnY0eFF5dVpDNkxZWnpCT2FleDdZV091Q04rTzA4Vm5NbXZYV0J1TzZZ?=
 =?utf-8?B?SmZrK1VPeHA0MFgvblZGYzFiTGtBb1BJcjFIWDdlbmlpVXdlYmhLczRnMmt0?=
 =?utf-8?B?U01zenZhS3lYdFl6bGJoNjl3VDFkRFN2THlYaDZFNUlGZUZtS2ZNY3ZTbEQz?=
 =?utf-8?B?OWpiZjNBQ3ZaUzdPV0xBclNKa2pCdldTNFh2T3RxL1NlZlpwT29XancwZVlX?=
 =?utf-8?B?Q0lSOGI0TGNQK0dvbFo4amJQVmNuR1A1Ni9Ga1BYVmpNWW15N29OTGJjNVpL?=
 =?utf-8?B?R2pUdE9QYU5BcURRRnJSU1pzWlFyMzN2bWZPamRRaFd3Q2ZGQndzam9oNkdp?=
 =?utf-8?B?aE1KbDRHYWxiLzBZUFZyZncwd3NTcFhBWER3anZvTlh3Y3BCZmZ4VFJwSTRI?=
 =?utf-8?B?U0NmK0ZmR3ZmbUlOekxmd1BadWtYY2UvU1lYcEZtTHozRjUza1U2QnZOU29r?=
 =?utf-8?B?MThqMlhEWGZ4TDdhMElhSGVDRENDeWVTYU5FMUI3OE5YRWRiQnhYZTBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTJKOS9PcjdiT1k1V0tJWG9jVVZ4MW9adjl2dm84WVFZT3NpTWVHUXpleEFq?=
 =?utf-8?B?eGxDYzdjS1A1K3A0eWplRzJSRFBsc0pjQ2FxVjNsSHBDNHR5Wk9TaVNTV0Qr?=
 =?utf-8?B?NkRoZnpIQ0cySG5VdW1tenllTjdMRXV5MVZiS3oyUzNUODQ3OVlmSVM0YitE?=
 =?utf-8?B?UEdwM2xpUUNrR1E5a283SE1UY1lLM2pEWEdqYW9JUjN1UXlNTCtzd09yWTJl?=
 =?utf-8?B?R3pxaDJMYTZQVWR6Nm5COTZzeENJYkoyTTdlVXlBK3VVUzJHbnVRSjdoNDdP?=
 =?utf-8?B?OWxjc2M2WUN1N2xLSmRKb0hjaFVYdm4rVitFTFdxQmNWamg0aTVBanNkN0pQ?=
 =?utf-8?B?eHp5ZTVRNkRqN1BJV0JTaEdVc3d4RlY5dEtxWTBXY294bTdmaEltSU1PVmc2?=
 =?utf-8?B?S1pjTWFhbERCekhWQ2ZCVHBlRDZmd2NtNUQyN1Q3YjJ6TlU1UUYrMVpOeGVI?=
 =?utf-8?B?YTJUaGQyYUJMcXlhQVArZXhUdkUzaC9IRGN3T0x2NUh6RWJORDEwR2RVdzFx?=
 =?utf-8?B?am5jRm05aUdRZDJWS0NkS2l3dWhaZHVLMllDR0pqVnBrTDA3T0laRFVKT2hh?=
 =?utf-8?B?ck1TcG1SdXZyNFduY2llajVxZUZEUWt5WnZBZTNNbE83aUs0Z3hZcE1xOEVG?=
 =?utf-8?B?K1FhdjlRc1BrYXQ5Tkk1MDRvRWRNajlqamQ2dW9VY3Jzb295OVRJY2tubGxa?=
 =?utf-8?B?SnJBVnBMNzdXVG5hVy9QYlk5MHJjOVJwbWVZTmZwWFhqU0JENjIrSnlnaGpX?=
 =?utf-8?B?c2VNMTJGRzBUalpid3pEM3JYRmZ6dWtMZlhoelQwMmFSbitvV3JxRXd2eDkv?=
 =?utf-8?B?VTUrVnIvMDlIb1kxNG5CemhYNEtEbldiamhpYW9iQjNIRHJFUzIvYndTcldM?=
 =?utf-8?B?VFpQVjhmTHFwR3piaTRGZExwMFBsUDhmVXBhN21maXBDN0lab0pBb3REaXlm?=
 =?utf-8?B?TXhCQmZGMGxEZ2hWWGdYM2haZFd5UmdlbHlGWGZzSCtDRmxmblN2YkNkZWt4?=
 =?utf-8?B?emEvbVFZK040MS9JakIra2hYeFZ6aGVROVF0T0lMdTJnTGtFYVI1YXNwRXZW?=
 =?utf-8?B?c1BMblRjRVRZd29NOHlyTmp3dFVWa01VSEZycFEyTDRNVWZRQ1VTK0NXMTVT?=
 =?utf-8?B?RlMxcDJBVXdMeTlOaDh2Q0FUYjNENWZuY1V2YXdRTm93YlJKdkNUbDZaekU1?=
 =?utf-8?B?VlVWNjZLbEdIaUZ2clBXOS9nOGo2dmd1MjAzeEJ6RGpqSlZpcytSbVRDSGky?=
 =?utf-8?B?TFhaUDZibnlYNGducFJzd1NQK25CbVkzMDd2ZGt1V0NjMDdxbDR2c052T3pU?=
 =?utf-8?B?TGhYbGRlRy9OSlJHY2tnOS90NnFLZnpmV3VuNWpFdHgxR2tqbEF2UWJVUU9l?=
 =?utf-8?B?bU5kMEhCcGR5QVY2UFJqL3ZJN1doUVo5WDFMY05nQjIwQU0yTy9SOE5LQXF1?=
 =?utf-8?B?L3NMR0I5ZlJKM3RoN0ZiNmJWbFROczVCZStlSU8wZE83V2pPT0JuVExLaExt?=
 =?utf-8?B?VWFrcmNzdU8wWm1PbCsrRVNjSy9PNytjbm5MOUdLTFBCQ29iNDRLMzhodmY5?=
 =?utf-8?B?cmlTRWpsWTBuYmVNYkNhc1JwY2s3UDg4NWFWNnhSUmhsbllMWXo3SVJqcFZ1?=
 =?utf-8?B?dEM0TjFQdDQxZ0xndnpVZE9yZFNGenBSTEhKaHZsZ3I1QUVrV2MyVElZS3FV?=
 =?utf-8?B?aDJqV2p0WVlicVNvcUJRUVg3TXN1TlYzbTA4UUhvZVRxVlZSNTJLTFBEbmNy?=
 =?utf-8?B?L2FBVGhQN2x3azJQN0J1Tlc0eC83dDZRM1l4bXlvbUU0eXo2TDNSL3NoRW80?=
 =?utf-8?B?YW1pTlFqU2VReGtPNnc4VkY0NDNNd2pab0FZWVgzcFhKZjVmTzBIWDZKTnhj?=
 =?utf-8?B?WlQ1cTZMUzBrWXBHTzVVTGFDeDJENU5mQTRkS09YK21OZ1pCLzdFUk9sSHVY?=
 =?utf-8?B?a3l2VGFoYTJ1WTREUktBNjVYc0MrWFZUOFJaYVRBQ3VhdVk5dzltYjBnblhp?=
 =?utf-8?B?aERjcFJaelBlMHBrMWk4ekZ4ZGdFMnFNNGJTNlB3aG9NRlJjNzU3T1kzYnVh?=
 =?utf-8?B?eVRpd3VtQzBUYUEyeXJvK2lNRW9UR042SVU0VUpSR25YejNXTm9ZczRKSCta?=
 =?utf-8?Q?xkq8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3854cf5-7a55-4d28-edc0-08dc6a5d9cbb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 04:09:07.6006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqEPVl0h0uGFXXIMHJBb0NKcjZJRKB3n/ytqI2iNw7aR7b2BOUIzBeLVYSzlONkd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
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


On 5/1/2024 5:56 PM, Philip Yang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On system with khugepaged enabled and user cases with THP buffer, the
> hmm_range_fault may takes > 15 seconds to return -EBUSY, the arbitrary
> timeout value is not accurate, cause memory allocation failure.
>
> Remove the arbitrary timeout value, return EAGAIN to application if
> hmm_range_fault return EBUSY, then userspace libdrm and Thunk will call
> ioctl again.

Wonder why letting user space do retry is better? Seems this issue is 
caused by hugepage merging, so how user space can avoid it?

And applications may not use Thunk or libdrm, instead, use ioctl directly.

Regards

Xiaogang

> Change EAGAIN to debug message as this is not error.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  5 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 12 +++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  5 +----
>   3 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 54198c3928c7..02696c2102f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1087,7 +1087,10 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>
>          ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages, &range);
>          if (ret) {
> -               pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
> +               if (ret == -EAGAIN)
> +                       pr_debug("Failed to get user pages, try again\n");
> +               else
> +                       pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
>                  goto unregister_out;
>          }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 431ec72655ec..e36fede7f74c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -202,20 +202,12 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>                  pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>                          hmm_range->start, hmm_range->end);
>
> -               /* Assuming 64MB takes maximum 1 second to fault page address */
> -               timeout = max((hmm_range->end - hmm_range->start) >> 26, 1UL);
> -               timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
> -               timeout = jiffies + msecs_to_jiffies(timeout);
> +               timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>
>   retry:
>                  hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>                  r = hmm_range_fault(hmm_range);
>                  if (unlikely(r)) {
> -                       schedule();
> -                       /*
> -                        * FIXME: This timeout should encompass the retry from
> -                        * mmu_interval_read_retry() as well.
> -                        */
>                          if (r == -EBUSY && !time_after(jiffies, timeout))
>                                  goto retry;
>                          goto out_free_pfns;
> @@ -247,6 +239,8 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   out_free_range:
>          kfree(hmm_range);
>
> +       if (r == -EBUSY)
> +               r = -EAGAIN;
>          return r;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 94f83be2232d..e7040f809f33 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1670,11 +1670,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>                                                         readonly, owner, NULL,
>                                                         &hmm_range);
>                          WRITE_ONCE(p->svms.faulting_task, NULL);
> -                       if (r) {
> +                       if (r)
>                                  pr_debug("failed %d to get svm range pages\n", r);
> -                               if (r == -EBUSY)
> -                                       r = -EAGAIN;
> -                       }
>                  } else {
>                          r = -EFAULT;
>                  }
> --
> 2.43.2
>
