Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF45CD3420
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 09:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EADEA10E26D;
	Mon,  2 Sep 2024 09:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VpxgS7Ge";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C514F10E26C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 09:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHenR0SIHnsaVDAxJiH9XYt5XG3BroImawH4lTbrxubCjnux1fFEtC5wpHogOd6gCS+ktXhGrtJ2PBecbdMtcXSyBAS6xkgAgKw3BmmzfBuZuegOM94xf8kEHl2gZ3nYjt8ZQvJjJq41udwx9tZaBN8+Vwvzvqp3+fG3LV8HJII+PLPBksXIkVUxFffKazQ1yuAsXnwdvmPdIQ06gaXSO9x9ROvwGTmk6u7yG14rFM1x1Akdd3EM8ttB+qm1zuz/NWlQf+Byeuo7Er4/S4jGyENGV8zho7snMBK9vXXIWHNAWuYD2MORw/jC5m2fBgAT+HTQ6sTSuWDjXrOU+xsx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+oHdb9H0tpwFMeHI72qbfN0nQ7nnMBxtFLdy1Aal3E=;
 b=lHk8UBTmAbnAqZegRP2gdXYEdNM3iO5NVK+IqRE/MOGRL69QdYe8xQL6odPE04kyj7VwkAKgbGsKFXY9JZnuCgXvbS7flgHkNICAi+LecILPrzHiKgve324YtSkG6NIJjIBFRJ+IaC24A/UDeOxfw4FoJ30KSayecZBTzOUf2eUCPwM3Z6SJsikdxIYRnA6v1Rih0C4qJk0eFdocy0WMNMD9BcjDm0fVJv6/60pVq0n+/gLsTvfv272RT2+JjZfGJE5SbHEBbEH+yfyieYHEJq53GudgcLABXFUQWZz4klu/9IW9CFO51NHlOBAk/77J8Ywr9EyJ4g9jPiNg2jcRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+oHdb9H0tpwFMeHI72qbfN0nQ7nnMBxtFLdy1Aal3E=;
 b=VpxgS7Ge7muN/WYW+hcFtNDEJ2L/h9VTH/eN5/nj57aGCX318I9lWTyJOT7q4Wlz/ZZKYaUG8lQEcOWlg9EYVdLGS54w356VzntmH83F6W8hyntMHanYYSGoM35H9d9/vk11+tdUP0+7JuMCGBm9t/4oi22TS1QY9AIb7SvKfcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 09:07:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 09:07:03 +0000
Message-ID: <c94ad3ab-669a-4529-96fa-2dbb28791a6c@amd.com>
Date: Mon, 2 Sep 2024 11:06:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix invalid fence handling in
 amdgpu_vm_tlb_flush
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240902030305.11952-1-lang.yu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240902030305.11952-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f60d827-e054-4ba4-17d0-08dccb2e9c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VitTVmtJOWF6di8yU2FuQ1ljWmhyNGVKdXhZNHA4QjRnV1k4S0xFdG5aRzBv?=
 =?utf-8?B?REpCaC9WL1MxN2FZdlczaExabUtTMVVBbzZIYlJ0UVdZakt0T1lJcW41Qk9E?=
 =?utf-8?B?WUpSYXoyQWtNbk5BRjZoeXpFR3hDR3FMcjJkRWxTMk12MGtkVnpCdWNSVTV5?=
 =?utf-8?B?R1dwaUJieTZ0WERaNmxkUTByNTRzeHUyZmVvc2FHbUZOcXlYVnpsYWdFY1Fw?=
 =?utf-8?B?OUhOcnRmUUpweWsvY0dwb1VVOUltZDFMMVFjUnVJdkgxaTM5NnJNaG44ZU05?=
 =?utf-8?B?TGRQRUVKMDRpZlpjd25OZVJaQXlvZTg4Q056NEZHOEdhWlNjR1REVWt6Y0dD?=
 =?utf-8?B?REg2VWpxeldmcmJHR25ZTHljbUpsa08rSG05NWw3UTRFMmNSNFEvbEVtTmZ1?=
 =?utf-8?B?VU5XdEY1aFcvMC9JVndaTnlHcWdPN25ZdVhZb3ZERzI2ZFhZNW5RNUVwWG5I?=
 =?utf-8?B?UVc3YzRFNFE5VTNqem0zWFV1OGZaUG9mVTZYZG9iL2FrQWh5LzJ0RUFVZjlR?=
 =?utf-8?B?Z05sT2ZFVlZQU2hpV09oQm8zZ2l4UUhGY2RFbTMzL1VZVGNkN2krSi9lS3N4?=
 =?utf-8?B?Sy9LbXh5Tm9NNENoRVJOWWNoSlRzcG1wL2hEcy9GdHFIK3gxL0FBSDY5U3hO?=
 =?utf-8?B?ZkduMXlVa1QvWGRWSjhZZkRxSjRMM2hsZXFFZEo4TSsrK1VxcmdoMXY0NkJt?=
 =?utf-8?B?YjNuZmhpMGN0U09VWCtvOWpoeEFPOVFlK0p1anpRSHhySUFLN2hGU0FNVGpM?=
 =?utf-8?B?RlUwUURPN21NY2N3bzEvL2R2SmxOYXZac0JEZjBqeURwWHlYckwwZ2JqYzE0?=
 =?utf-8?B?UWNGOEM3eGdQRVhlOVZjNFFoQXpLOVV1YU5xVFVvdXNqMmdIaXhRUE90cFZT?=
 =?utf-8?B?RUUxYXJNZnN2dlhOSEZxQnc5UWtvOUdMaEdRM1ppcTAwTXR1bFJtQVEyL0JT?=
 =?utf-8?B?QS9ZR2gyZVBVME42TVhWWHdCT000c3pmTGlVdjdZK0VZYXFZOEtTK09SSkJ6?=
 =?utf-8?B?RmlUbkJJU2xUaGRFdWtEeGREcGw5V0hpM1kvQXlnZ1ZnbmJvMURWT3BDdHJv?=
 =?utf-8?B?TlhmZm1pMlVwWklnemRlWldqY2ZSMlZub1ZQci9YYVRBRWdPeGxEeVVITDM1?=
 =?utf-8?B?RkZiaHdKVE9YU0ZIMGxWWFExSHRCZkRlbzNDbTJ4SU1DQ3pDaExxeG9hYnI0?=
 =?utf-8?B?bk95WS95ZGdmanJEZko0ZHhoVmgrZElNNVhaYXdaRnlKRjVqUnBVU1ZVZm00?=
 =?utf-8?B?TDVNOWQ5YlZuc21IUUpxOEsrZkFmbW0xdytua0lmTG5lZ3p1NkZzQ2xNVllj?=
 =?utf-8?B?THd6NkRXbzJnUUlBVUkyejRLd2lsOU1obDdnbUt5OGY0MnB3NWVUU2tEcmdp?=
 =?utf-8?B?dGs4WU1zazhNWVQ2UlI3N0J6UjJObFVKanJxQk1VL3kyMTRCRDB6SEMwT3pH?=
 =?utf-8?B?RGlEbEt0cTd4TXlLdEFXZkdHR0U2ZFJrbVBCaUNWKzZScWoxQlJ4VDBPZW41?=
 =?utf-8?B?ZTRmT1Z4RVRTc011ekEwZjF1MkpmeHBtWUUxY29QMm1qWFZFZGNVelkrcUp3?=
 =?utf-8?B?cVI1SkFqWkQ5R1o3bTZUL1lJeHJiNHJncG5hNEJzMUFySEVmU0tNaXpwVGs3?=
 =?utf-8?B?RE9DYUlYYlVUa09IUTZRN2M4VVZ0QnRCVmluSlJ0NkgzTGlSTFR3Q3lXZUxX?=
 =?utf-8?B?aklEZUVGbjRPQ1BnRXFScG84bVNnL01zR3BueEhuK2dRRHFlSTJ6UmJlT1Ew?=
 =?utf-8?B?YVd5V0d1NC9GYWs3Wm1OZHJWb1R3RE90Z0Y5WXFISVIwZElMQ2lMKzJHVndz?=
 =?utf-8?B?c2hpaUtaUGxsdjNMMVd1QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmloQmJjcjUzbTZreGlOakIxb0pyT1hUaXR0SEJFYmN1UjMzUXhic2NQdVN4?=
 =?utf-8?B?cjhwU2JDUFY4eW1vT3JGcjZLWSs3L1FCejkzWU04dUVJcVdJSjY0MWN2aTJ3?=
 =?utf-8?B?Z2ZyYmd0M1Q2S1JoSjhvQThNVmxjV095cFRMRzFJZW13aFozV3l4WDNlYXFq?=
 =?utf-8?B?TkFZdktHY0hNOGRBRXlKWGVZelpIMHlrbFZZKzZRNFR1STVsZ1Q3TFczbWQ1?=
 =?utf-8?B?bGRTbFlUS0xEVVluekdCT0lVTi9aaUJ1MDRYdDVYMHNNMnYvZzZ1cXdBQS9M?=
 =?utf-8?B?Q0tQeHdnS29mM09RQlFsczBVRUxpS3BhV0xpWE5VelY4YUxaSUd3RklUNmlK?=
 =?utf-8?B?WDZhT2R5UFBnaUtUZlVuRHpCQmM0ekNDQktPaDliVG9Bb0tRVGZCYXZ6SDc2?=
 =?utf-8?B?OUVhSHBnVVVQYmFXbnQ5dWJhK2FGaGh1TUxpdEdzVE1HaXlKVE5JTmN3V29Y?=
 =?utf-8?B?d0FvbVM3V2hDMFlHRjFoQVlpbUo2ZHRqYVZBampxQmEyOWdyMlROc2duRnA1?=
 =?utf-8?B?K3IwRFRrZmYwdzZaWmY1alFTNHNIaWV2VXFXcHNLaHp1cC8zWG1JdHpkN3RZ?=
 =?utf-8?B?dFJiZ21TT1NudkxQdWh0bHJmR2FBQ0Y1NHM1N28wSmM3TDBBdHZmYU9MejIz?=
 =?utf-8?B?U1lZV1RkUG44Y2EybmxqRmp1bThGWnR1V3pZSFdmMXlSb0RwRUt3UjBUZ0Qw?=
 =?utf-8?B?ZlZROXBHNG9La3FDbGNBK1hEdGxhUi9pZDlrMHV1bEQ1ZlZyM2ZxRytrVTYw?=
 =?utf-8?B?bFlSSlNIU1NiRkZOTGwydVFnS1phU2dPT2pMU25ZelordUYzWDUvVU9ES1Fy?=
 =?utf-8?B?OE5Pb3JRVklRdlNtMmNkUFE3ajA2MStFZ1piTzJXMThoeXRibmRVVTFVa2Ft?=
 =?utf-8?B?S1BVUUd1M0szUXRWckZWMTJ2Z1dxaUdzYVNlL3JabDRndDQ1eUNueFVvc0Y2?=
 =?utf-8?B?QmV6VHllR0s1R2RYUkY0VGRpbTl5bjFwcFpuc2V2RzZVNm4yUVVFVDQ4KzJK?=
 =?utf-8?B?YXN6V245N2Rua2FEUjBqTTdnN21jRDg4Wkh0RktlSm5wVEJNWXFaNEdrV2Zn?=
 =?utf-8?B?NHRSbEx0aFV1TVlYTHlqUDhEaUZ1QWZJTDlaU3NXUDVlQmJWUjdsY1A0RTZ0?=
 =?utf-8?B?aHo4NDBUajdmYmV2YU5lL0NhYU5iZFh6N2tPMDJXa3dpMlYycERxY0FYdHBw?=
 =?utf-8?B?VVgrUkpBeGdzSkwyRlk3YzlWSlYzRVZMZ0FlaUVuakswRnZSRnBRbEN5QnpO?=
 =?utf-8?B?QnR6VlFqTjVud1dXT2JMOEVlSTY3cmJiY3NlaTdwQWYxbUhxenJVcjh0OHRv?=
 =?utf-8?B?QkF3RnN2SG0xU3VmZ0lId3RpMUJjNnBNOHVqQWpHN1l3ZFJmY3FGUUlGRXht?=
 =?utf-8?B?UDh6RGg1QzVkWE1GNFU3c0VlekpjTCtkZTRMUUNwd0RGOFZzYVZKUk15YWpa?=
 =?utf-8?B?enM0N1VBSUlTdHVnOVN4ZkNLK3RoUVV0cXh6dVUyWThDd1pxQkg1cndLWmJv?=
 =?utf-8?B?WVZDQ3RUMnExbHdSNE9rQUMyKzlJNERKUFdlS2haWjB4R1YrWVdHTDdmd1h1?=
 =?utf-8?B?bjdsME9OZmFHVk5YM240Si9HMXNZRzhRaXN2eXpnOVZ5U1ViMzltVURPVGlx?=
 =?utf-8?B?U2hmVjRwMmhwdU11ZWRiZnFkR3NDWGJFbWZYOEh1c2FlRWRYTjdQY3BHUy9N?=
 =?utf-8?B?M1FXd2IrekhxTTNXSjZIM1hTVUp4NFNnZFZVQ0RMQ2JBK2FGZ2JMejUrYnMy?=
 =?utf-8?B?M0t2TU1qMldLTjBqaW0zRDY2Z2JodHBUTktiZUJYaS93Nm8xdDdsVzJ5NUhY?=
 =?utf-8?B?MzJnOFgzR3Q3Z2pCQTFnWGkyWDBWaGU4Z2JpZk56RnBLcDMvVlVaN2t2VnB0?=
 =?utf-8?B?d0dwSmJONnk0WTNHbUNRaWhNclM3UTdZMTV2MUxJMThGcUxkMmZZMS8wMkpp?=
 =?utf-8?B?cXg3RkxzcUJCZXJmSWtZSGdac1MrTzZzUHpVbDYzYjhzUHBTdjRxcnczWElh?=
 =?utf-8?B?RXpRZjJRa3R2bkEvTFYrWDBpN1JNN2w2WjJGR250NjB3SWtvNk1WREtJWE9l?=
 =?utf-8?B?N256R3BiZDhiOFpVZlpCbkN0aGRuLy9KZ0tjTEwwNC8rRXNWaGFjVG1Lbmd1?=
 =?utf-8?Q?4O4A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f60d827-e054-4ba4-17d0-08dccb2e9c69
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 09:07:03.5534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Nv8K20Q+UF62rsa6L2KLyJPdJVX+RZYulEkbT1VnSDUCBRJlz7O7cWRWy3tIDzg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
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

Am 02.09.24 um 05:03 schrieb Lang Yu:
> Fixes: 5a1c27951966 ("drm/amdgpu: implement TLB flush fence")
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Ah yes, that explains why CPU based updates doesn't work reliable any more.

You need to add some explanation to the commit message, e.g. something 
like "CPU based updates doesn't produce a fence."

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 1d46a5c81ec4..f93804902fd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -908,10 +908,12 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   {
>   	struct amdgpu_vm *vm = params->vm;
>   
> -	if (!fence || !*fence)
> +	tlb_cb->vm = vm;
> +	if (!fence || !*fence) {
> +		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>   		return;
> +	}
>   
> -	tlb_cb->vm = vm;
>   	if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
>   				    amdgpu_vm_tlb_seq_cb)) {
>   		dma_fence_put(vm->last_tlb_flush);

