Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F29C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 02:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8EF10E443;
	Thu,  2 May 2024 02:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eaCRgC17";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C11EA10E443
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 02:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggahBURQGqHjbsXlCUPujumsEF2WMlKIAmn6StKGZwBd0XnoPqVWhrVXYoojD6hd+xmFudpzor/QYCcaTHIKq4Jt+10TAXVKNDcW3wwXyK/re7316ODInVEa70505iNU+JxyBv6m2235pDahTXbD+HiaHv0wNa9PVSbo0/p/qE5MA6gpdplNZj24TKfCK+9eCEcOaFVX44qar9IXrVuk1fThHyRNpER0mg6yBIgEW19h6KvVqSY6tIbSzgLHbI/wUt59t4dr85WSwxCbNEwy49i7cfR7TzHPuLDrdBDUKcWn/FMxRLZ/bnNzbtYAejF8qxzRIj2QR9fYSjIITUj1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=io97eNZcE85vqDnJIRGDmS24nf0lB7pS7DUzUIvo24U=;
 b=PJoN+fBPUfq28Awoua5gK++Fbex85yk/SRVPejWfXorVNuiOpsKV3s+2OqLBUMjvFOFxWU/We+0ApYGYGTh2EVagl3WhEaUa49Ghxx3nUWBNk8CIR9cvAzNIxuksPEFfk6sx+47FLX0Jujc9jNMS0xXfhwZfXK3f0Mt8IAGxefJAt2NXPGYYMboIUi94rg4vI/uujsfsxoQo+lwtqpz+NahPINp8Bq78KSPUsEPo4rm2stwwqFFtnwyK2xPIXfFKLWfALl0v+/Tzm0B8NNc1rmJCjarBjvGTprgSrXPbWlGz58dpRaD7oVCC5MgngmW+Lks66QEPpJn40Tp6stVvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io97eNZcE85vqDnJIRGDmS24nf0lB7pS7DUzUIvo24U=;
 b=eaCRgC17eXOHNtFaZG5Cl4of3IYD1+sY+uqQ3Sy/p5Ay2778444B0k1a7KgeQCLR15nBUcrcK8CDZmCmpUc4HsqwYn0YMMPabvK/DDl20uO28zS+mODjknyqoy8e18zyl2lF6+FooT4zzYjnQV2saV99r8FUaK2TXzh7fT50v/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 02:32:53 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 02:32:53 +0000
Message-ID: <8e51baa8-4bfb-4275-be45-db5aa8c840c6@amd.com>
Date: Wed, 1 May 2024 22:32:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdkfd: Fix a resource leak in
 svm_range_validate_and_map()
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240501203806.2883081-1-Ramesh.Errabolu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240501203806.2883081-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0265.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::9) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc98e1f-becc-4934-48ca-08dc6a502ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnF1cWM2YTY3NDRWREhkWXpheGQ4bVUrbVFYOGxjOU1UYzNhTkxqY3NROXVp?=
 =?utf-8?B?UkdwdjlKVVpsRzdNZWY1S25vVVBHQXIwczRNUERqbW1DbVdmUjBZV1dnWW1H?=
 =?utf-8?B?V0dURTZlNTZWU3JuRVkyaHgzMVg3cW84TzMyaW96ZjJFaFRiZXRSYkV4NHdx?=
 =?utf-8?B?YWIyQ2JMTG1jYU92UG5sdzVpeTdTNDUzNnRiNStvSXNTZkRpUXVqQUxDWWZx?=
 =?utf-8?B?YjRMMGN1NFZ6WHF5NEV2RDQySkFWQzY5bElqWmNtcEUzVEhyT1hrMTk2c2F4?=
 =?utf-8?B?VW9lMlVxcWlmdWVhVkpMbGpBN01Ec2ZTb1krWHRER3FZUXREL1ViNkpMdnpQ?=
 =?utf-8?B?S3ZYYzhhTFR5dnpsNEV0SUFOVW1aSThSWDllRFNIMGJ0bDBRUXRRRW5uWHNE?=
 =?utf-8?B?SEZ2TU9tWnFMWHpEbXBnRDFNVzhjS0tzSnhEQUxTL2Q4Q0RxcUo0cmxVelk1?=
 =?utf-8?B?MEczNVRIejdNSkZHN3lvdWJLSjRjSVcvNzAxWW04bzJ1aDBwS003YWk2a2M2?=
 =?utf-8?B?dGpiWWp0UU5DTFBSL3FUbGw1TkgyWW5XWnRsczVaSnY0NWkyNW5XQ05QUFM3?=
 =?utf-8?B?Z3BiaS9HY2ZMcFQ3SzhtczQyN0ROU2VwRHc1UVkreHliRC9Kdmh6M1E4aVpp?=
 =?utf-8?B?T00xcWZSeXNua1EyVDM1bHJIeWZQTk9ubjhna0NrYzU4RkZWRENrNXpwMUgy?=
 =?utf-8?B?SE5ZUHlZUDEyVXpqbVAvTkpGT1pRajNMVHBRbnQyM1p6M3NOZzduTnlQVE93?=
 =?utf-8?B?NGNSWnNPU2pZU3l1Ym05S3Rkb0Y1Z3VQTTNYZDl6SDRaS3MxTjk5bWVuZzV4?=
 =?utf-8?B?MlRINHExSEE1YWd6S1FvWDMyYUdWSHdTdHhzcDdmU2UxYThOSmlBMm85Nnph?=
 =?utf-8?B?S2F4K09acWN0enJFaXpJMmhUTktaUlVxbXpqdC9vUGxwOVVmL0Njbk93WWFI?=
 =?utf-8?B?VDIwZmRCcmdZdVhJM1VDRmdWSzNFSDh6SksxMnd6T2g3azZOY254UDR0ODZk?=
 =?utf-8?B?aTF0ZW5yZ0R3MFhFWmdOVVJwU0RIMmZSSWZpUEhNaEFOQ0VUa2hwMW8rNHVh?=
 =?utf-8?B?UnYwNG9sVCswNGptR3ZxaFNWQTdOWFA3UFZ5dkNJVDc4U09vUU1JS1ZNMkFN?=
 =?utf-8?B?ODczVTEvU3ZJYllKbVBXU003YTJQUWs2cldFNVhhcGpxZ2lqM0pZUFI3RHNy?=
 =?utf-8?B?WVNPNklNOEs5TzVTL3NEclNSU2FLYUFUSmNNenExWUxmSzhRK25IWTdvazcy?=
 =?utf-8?B?NXNaMUthbVE5by9kUzBWVGJaSGRxSTBBK3lDOVFoLzV5aW9KWUdzcFJPSkh4?=
 =?utf-8?B?Q2Z5SW5HUVFudlphSGRJYnZxV0V5WHoyQ0ZCcWVhQytqUXgwWXV0MTIvc21K?=
 =?utf-8?B?RkFJSWZ3b3VuNUtHL3U1OFVTbmVIbUJvaFZ3dGU0cUcxWFY5clpOQVpoMGIz?=
 =?utf-8?B?ejExcHJCYm1NR01VaWEvMlhiTVB6WmtrWkE2cFF0OFd5RGx0d2dsU3l1YUd3?=
 =?utf-8?B?ZzlYM01QUEdtUFlyZVo4QkMxVUlOK2s0NG0vakk0RFNWNFdjaDJDRXZ6OEcz?=
 =?utf-8?B?MVVEdmNERDVXeHdxa2lLTlc1cUttTkQ3WjNYWWIzdkRvV05uNytpVGR2UVo3?=
 =?utf-8?B?RzNIZk51YWV2TjRSK3Q3azFrWWppd1FNWGJEVU9rcmlVWEZMQVB0amZhcm9W?=
 =?utf-8?B?c2Yzc0dvVEZXOXFqQWJRTTMxNlZYQkFhL0tWSWsxL0lOOVJuc3VxcFZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0tkZ3AwSjBxQ2VXWExJRjJ6TkM0NW9Eb0Nqay9IL1UrRTVvY0ZLb0pwclBN?=
 =?utf-8?B?cXBKeW9Hd1Y0UUcrSXUxdWpzUk5GRHpWWmlQckJYekNGcUFuaXpNYWtmZm1D?=
 =?utf-8?B?TkZVVjBCVDdpRGhhbzJ4QTQxV1dTUmRuNkZEUWFRd2hybXpCaWUvKzQraDVP?=
 =?utf-8?B?QzIxaVhwYmh0ODR5b2t0cG9DcWtXUkJFODExVExjNnBLaTFwVHpBbXEvS1Jw?=
 =?utf-8?B?OHJwVXN0ckI4b1pQU0VGcDZGaURCaXFpbE4vazN5ZTZsN1ZER0tzNGNWLzQ3?=
 =?utf-8?B?MjhYVk15dFF0bW4yNEk2L21yaVBMbzZqVFE0Mzg3QXJwUHk1c1BpcC9UZFRk?=
 =?utf-8?B?THRsZFh4b3kwRUhoOXJYR29iMURndFFFUHl2bnowNHFSUms0emVRb2o4VlFI?=
 =?utf-8?B?TkkzdnBnR3pJVWwyNURMckwzektvNnVqVy9xanFYRkROeWlZZitCNm9lWHN5?=
 =?utf-8?B?OSs3R2lTWEJoMm04TlFOUHZreTg0NTh2NGZrZC9nNUdUMUttWTkrTDRrQ1FN?=
 =?utf-8?B?TFNNb3JRR2lFSExMM2V1MnI1enBsZG9LNUpxTTNSOFFsRHp0Q296UkRhLzlS?=
 =?utf-8?B?bmxIR2UzNWJsZXNlWDZwVXBIMEE5TjBPNzF1NXBXZmRkd3F6cS9ZZzVUVXlS?=
 =?utf-8?B?RG5RZWYrM3A0eVFKRG9IcUJ1UDJFSkM3ajQ2OWxiZEIwTTBOUXFyU0g4NkU5?=
 =?utf-8?B?ck41MjZVQlJpZUE3UndDZ2ZmYmFWWXZEaDJHZXlDckd6OWpSSWg1R2hXazRW?=
 =?utf-8?B?dUQxZkFVTlRUaklXbUo0TXExVGpweW5sU2p0ZWduZ29BS244RkNSWTZEWVRN?=
 =?utf-8?B?MVlWZUtMVStqRG1xc1VxK0o4Zzk1aldWemNKSVFpN0RpUDR3eS9LRFZHcGIr?=
 =?utf-8?B?SlJJL3NBcURSQ3Zua2J2eG5XeDlad0FpWUYrVTNvamZ2Sk9zZ01VdEhYQThJ?=
 =?utf-8?B?dEx2Nmh5Y0pFUlAxSjNCMHdEZjgzZG9vQzhrdVBPdlp6Y1FLSERCTjlaQWxv?=
 =?utf-8?B?UWFNUWEwd2xWbW9ISWFDVTRiV1FrTSt3dVcyckZQOFlPQU9RaVkwZ21XU0Uv?=
 =?utf-8?B?dnlldHZrV2pjU0FxbG0rdlRQN3NjallQZTVnNEp0aFBpR2RDelNtQmhyRzVs?=
 =?utf-8?B?ZFk4UjVtNk1tMktoME9JUnE1QWNwek1ZSU5xMGVicUJ6WHpCSTI1WDMvZFow?=
 =?utf-8?B?M2pKQUkzWUNMTVN0aUJiRWVTV0U3ZmhRQnhvU1N3NTBIWG02UGpMbVJrejZN?=
 =?utf-8?B?VUZPYTRFZG1WL0JxeXBsQ254aHRGc3dyNy9zcFhyazVuQWJFVWllY3VVeisr?=
 =?utf-8?B?QkxVcVFiMzNQSUlQSVFhUUZjQXl4SGVFT3Z4LytSTnZuYTJIazZKYmo5RU5W?=
 =?utf-8?B?eG5iTTFQNGJVNFcyUUxISWJoUFlPWHNVYitNLzdTUTI0RUtWN2ZQendOcEU1?=
 =?utf-8?B?NFIrNVVsbTlQbDlhK1BtVjNVMm1xaUFxOFV5Uythd3ZRUTlzQWZFeWtwTHpL?=
 =?utf-8?B?NUVXOURBWENQU2NOejQ1TmFTN3VKOVF5cU9xa2ZrZVBjb3pYMmpodDdLVmlO?=
 =?utf-8?B?K0lLODBMdkhWUFpGdUJZTnZaQzBRbXY3THBrUnB3ZkhGeThDVmF5ZkNyUEt4?=
 =?utf-8?B?UjdTVWwzeGNtRkRCa1lzc0ZtZE5ubzVMc0lRUFYrSmFmOVF0c1FCY3g5d3RM?=
 =?utf-8?B?K0gyNXVDZkNSZzFhYjhvckpsU1dFUjl3ZFZaM1JBOSsrTXZKTlJLN2R1K3Uw?=
 =?utf-8?B?SURXTVRMMVA5OVNsd3FmSER3d2ZzWnNTTzY1NzFna3pqb09vaEJPbEhYWXZZ?=
 =?utf-8?B?b1BRVEthTjV6a21XZGE4TE84VjB5d3hocm9uTTNHZy9pK1gzNzlxR0I3Q0RK?=
 =?utf-8?B?VFJvV05DU0Y0Z3M1VU1FTUp1Z2tyQmpTNUh2bk51NjQ2eE4wTURaOWZBS3RZ?=
 =?utf-8?B?ZFdlVkhXOGVEeXlDUW9HcHRvOVpQaCt6dzc5V0xGNjBqM09WczFyRC8yU0du?=
 =?utf-8?B?VVRCTXJoZ3V4c1g3Ri8rdnNoRXl0bFNwS2pEVnlldy9VZXZwSjZiVUZnWXpv?=
 =?utf-8?B?UHB4SVJTdGFHUmg3NWZxM29XM2kxVERxM1VnaVdiQ2o4QWNScHdZZXlkbXdZ?=
 =?utf-8?Q?QDsZd7T0llFps/I7sKyPmJXSN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc98e1f-becc-4934-48ca-08dc6a502ad6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 02:32:52.9647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92ok4FubIZUk3IvprLee99uhkpd/EsHe+cArsJwqiWb8Q4VeBzgFInS9iWRdqphZVD0cheC0d8v5i9eXms6E/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
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


On 2024-05-01 16:38, Ramesh Errabolu wrote:
> Analysis of code by Coverity, a static code analyser, has identified
> a resource leak in the symbol hmm_range. This leak occurs when one of
> the prior steps before it is released encounters an error.
> 
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 386875e6eb96..481cb958e165 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1658,7 +1658,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	start = map_start << PAGE_SHIFT;
>   	end = (map_last + 1) << PAGE_SHIFT;
>   	for (addr = start; !r && addr < end; ) {
> -		struct hmm_range *hmm_range;
> +		struct hmm_range *hmm_range = NULL;
>   		unsigned long map_start_vma;
>   		unsigned long map_last_vma;
>   		struct vm_area_struct *vma;
> @@ -1696,7 +1696,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		svm_range_lock(prange);
> -		if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
> +
> +		/* Free backing memory of hmm_range if it was initialized
> +		 * Overrride return value to TRY AGAIN only if prior returns
> +		 * were successful
> +		 */
> +		if (hmm_range && amdgpu_hmm_range_get_pages_done(hmm_range) && !r) {
>   			pr_debug("hmm update the range, need validate again\n");
>   			r = -EAGAIN;
>   		}
