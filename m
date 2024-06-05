Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2014EC27C52
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 08:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79EAA10E33E;
	Wed,  5 Jun 2024 08:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rVKUxsej";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFBA810E33E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 08:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm1dqJWsTUaHhXpAxbRDfvzSKbd+0TcAPWlo+LP+D8H311J5FDXaXR2JprobvSjidHvdlA5WDWno9KCLr4OdLodTCtbAzUqA7BNkoY0IvZVSJTiluAekmhom19+kNZZvJHnTKa9T3SuOIwKtBknUencl/SVztRnLJOYl8X2aksyp0fxNkMD07I0pOZkg67Hw/zw4Chus/DT9BHsqyYuQJCBHTl8Ek4qBpboIvKxZjelzzt14lwS2bqDoCUfK30zsKA1FQkp4tOy56iVU/nNQXftjegu/2n7H+quBPG9cAx7KL8AyN8TqI865GzHbhzU8djg03M2cM1YiNbY3q8cyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYwvqIeHLqAEmpK/QFDac3kIfi1Pn/DpwomPiZ2YZ1U=;
 b=U078tekQMB//LxAqSYffxLE7hJjKp2Dbqbk9DvL3OgWzqQ2OrezycKJ6g0Jk33zF1zNJ9EdVAbrvX9n6cjoTTa5iqLC6w2WBFXkL51hpTCn80LSNRGKAF0FijM97+FDJD0aVFZj0qFicRvwyPTtuSmWnA30miu3W6ml1Q5xeUdorZtBJIhxeL1saJn0vzDuf2kOy6Yb5eCLSZGPeY+PiHEa9fMQnMis0M+pNmmtW2h6brhJu5ZVCnU1hwDKu45DUDUWH0FI13M6/L8hyfugEFgAZoBjP/R9ENFqoilZ9JMc2uh5q+fAApTqHhZREvEzHsH1k7NipevgcRlKxoFzfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYwvqIeHLqAEmpK/QFDac3kIfi1Pn/DpwomPiZ2YZ1U=;
 b=rVKUxsejSoeO8fs7eS9JhThW2YpyK1DEkdh+SsffUPeAvWga0MRXKTprQQ3eYxrJ6KuoSjhOaycUk48iEmTHABmhM4hAYASpF5XTOsaifZit6YN+Ge1OJ11Vm1hqbt9NdEKlCRNaIDLT0Aa4kAeZ4BERZwD/wozFo58e6Y5JVjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 08:00:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:00:13 +0000
Message-ID: <b7186d5a-e1f6-461b-a0f7-2ea408eb82bf@amd.com>
Date: Wed, 5 Jun 2024 10:00:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] drm/amdgpu: call flush_gpu_tlb directly in gfxhub
 enable
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240605013318.11260-1-Yunxiang.Li@amd.com>
 <20240605013318.11260-7-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240605013318.11260-7-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 37900a60-1330-4978-ef63-08dc8535874b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym1ZZTEyUFFCQzRiRnVzbDAxU0pJNHVQZzNNWjQxemtvdS9ZT01ralJISHpr?=
 =?utf-8?B?SXJBLzkwTTBJb1JqRWNyR1AzM3EycHozU3laRG40Yk5pc3lxMVorZWFGbHVz?=
 =?utf-8?B?Uk9TUkJWbDlER3JjUXlwa0N2c0U4bUNpcmhycmV5Njh4UnlCSEY2OUVpRjZs?=
 =?utf-8?B?dzlYdVlnb1RFSzZGL0VEOGdOQnlRbTRVaCs3MlhYamxXbWRpcGppY3A1RDMv?=
 =?utf-8?B?aFA4ODBYVlZyTEhCejNTL3QxZlY5RS92NHdYUm5xNlYyS0ZsdXBjU3dZckZh?=
 =?utf-8?B?LzdpK3V3RTgwZ2tVYnIyL1o2Z21LczlxRGVYUTNUU05SeXJvT3oxZUt1TjY3?=
 =?utf-8?B?STFncmUwMXlGeW9tSkJMc2lGejRBZG85b2xtWm1ETlVsNGJ5WlBBTEpmTVRI?=
 =?utf-8?B?Q2xPQnB5dXhPaDhieFVIVUJJMG45aGtjZG1EUi9OM0FyaTUwRnlvWTF5alI5?=
 =?utf-8?B?NnIzTGhSSlFldlBremQwajRJRFo4LzhEaE51QTY4MHRPRmZQV3Fyd2pjMktv?=
 =?utf-8?B?YnFMcnBDcnkxZGtPZ0pKZVFqSlJ6d013bi9EQzZPalZ6N0lZaVZGTitZZHRQ?=
 =?utf-8?B?WldPSmNPdW5xT2lqUCtzWmJ0R2hNMGoxWHFCYUhKTG9TOXkzMWtwNGRZVEFM?=
 =?utf-8?B?UDJwcHIzQUxDampUOTh2QThHTUQvalNOdEI3bk80Sk1tY1IycXpKSjNTRGI2?=
 =?utf-8?B?UDZDNWtGMzBkN1ZNODNubHRxM1JjZ05NeFdDMGJ4bFNYR0F1dWlNM2xuVjEy?=
 =?utf-8?B?N1lUQXppeEtCOXg5OE1IcXg3Q1ZIS04rblFPQWt0K09yRHJGeE15dTA0bVRz?=
 =?utf-8?B?aVUyUDBVTzZZT3VkZWd4WDFLbmhxcWxPUnBGWjc0TEVJQ01OVGhwRjRoQXB0?=
 =?utf-8?B?S2hPb01YV0ptaFphQkZkdDFrMWVKQ2h1TGlULzRpMFpzZFZob045eXltZ3N5?=
 =?utf-8?B?Uk16S0hRUWpySEhiOVJEdmxCZXA5ZGtIZVRBQm5HcXhFNmQzS2ZpYkVEZE5N?=
 =?utf-8?B?LzBReDVTcFpxNTVJVForWTEwL09TRFl1MElPSUlsc1VqSEFNUlZNYWZPdXJj?=
 =?utf-8?B?aURpUGFTMlVMTkRCL25wWjYzS09Obng1TDNVUmxlSmZZeUhaeWFma3BjQ2NV?=
 =?utf-8?B?RzBMaTBZREhFWkN5VEx3UUZrUkM4UHhNVTVZTUVQcjFwYnhtSzVNZkl3c0Jy?=
 =?utf-8?B?M2RzRXl2czJRbGovV2h6TVVnRlJKRGt3SHlXME5IeFkyYXQweTV0UDBJblRi?=
 =?utf-8?B?L1FITG5sQWliUDdneHpXQkFKRUtGbjhnZVBPdUM5SmR2bHdOVC9wRXpTMmR0?=
 =?utf-8?B?VzJyYmxycE05MGRKUHFSTVRuUDdhN3YyUmZNcWlvK0RQYjd3Qm15SVRMQjB2?=
 =?utf-8?B?anBQYVBlbDhPM0JJVmVYZnRvcWdxc2dPUnM4MnpmRTZzM1JEU0JSVW9KaUJa?=
 =?utf-8?B?OTExY05SeEF6bHVadUR1cFNOLzNIQStjdFVxdnBXM0FGNGV2S055VWt5MERY?=
 =?utf-8?B?NU4wVWV1VHBYN2VSa1huYjlSODNCbi9XZlhlWHl5ZTNzWlR2dzhQYklHWit4?=
 =?utf-8?B?ampZNmx0RjZaMlMxOEJmVWRNNU5SVTJlK2poNVhXMjIwYnBuRW93aXU0bmda?=
 =?utf-8?B?R2F0SnJXc1BaSE9LYllkdXFCQlB1ZXREdksvdXBVdGpQZ0g4bXBoNDFBejFY?=
 =?utf-8?B?OVlIQjl0QnAvTnhrd0R3UXRHTWtsbStnQ090RU0vZnhkcmJRYUJ1TXZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUFpaE9IbTFDa0lUcFhzbVR0amV1cmUxK2p3b1dZd3dyelZoMzVydlYrYlVD?=
 =?utf-8?B?OEFnckg4OGdKUTJLL095Sk9yMFNlejVvZzdlSXlLcGpBbFFsZmQxZlZjSTFC?=
 =?utf-8?B?NkxwUmNZeEVUYUw2TzNiYU0wU3I5ZW84VXdyaFVjOEFaWUdweU1iUUZaTW9V?=
 =?utf-8?B?SFpaR2ZwdXJMZkFQbnlnbC9zZzNDYkNtTXF0L21VUzBHdU5oWkRUK1JGU1V0?=
 =?utf-8?B?MDlSWFltcm5JMzhTZ2ZwOVRYM0ovTHgvdzZoQ2hYdktyOGEzRlY0WldYVmhT?=
 =?utf-8?B?a0d3anhPd3VaV05DUng1T3E2NTdINnA3V2g0M1BFSCtFd2FlYUdPRFFQaTB2?=
 =?utf-8?B?VUVWdlNHNFByK1FQMlZVS3JGZHBoUXRCUXRpZFNuRDA4RUZlcENiWVNUVDMx?=
 =?utf-8?B?ZjNaanR3M1pVM0NJTXVXL1FEanFjblpnNVd1Y0tMQjZkZEZrZVgxUmVKYzFL?=
 =?utf-8?B?OXdDRjNTejA5RERhdVpoS1Q4WVk0aFcxQkRKQlNIUWlERlVOeDRuVHJHNVdV?=
 =?utf-8?B?K3g1TzQ0RHoxWkRlVHQyQzBvYUtjK2RpZC9rUWlVTFJHQ0xjWjlFMFViVEFI?=
 =?utf-8?B?Yktnc0Z6NDV1NUNBSFRWZVQyaDJneFFXR3NqZFRpSGdxQ2pxTTExSGdnWjIz?=
 =?utf-8?B?RERLZXJpaE01c0V4LzRtQUVsRTBieW1sNXc4QWRYRk5PTUEzM0tIZmFmRERQ?=
 =?utf-8?B?UFJKL05CeFM2TUN2VHpOMWFuVFhxdlNodXdkZFBGMG1ycyt1QUdtRU9TaWRu?=
 =?utf-8?B?dURJWUVyRW1Md0ovRTFXVEhDS1dRWGFpdytCdXo4d1hnWXNUZk0rZmpsY3Ay?=
 =?utf-8?B?Rms2NGduSVZKd2t4L2tmVlcrVFdCeVpRWVdXWHRDMyt0YjExWi9xL0VJLzBL?=
 =?utf-8?B?SUIzc2k1cDRxTUJnNVR4Q2Y0SC9zZjA4VWRSY3MyaDlhdWFzUklsUGZkamFW?=
 =?utf-8?B?aGlTZGJaN1ppRS85aEdyalpzeitEOVBBMCtweG9tTXBFdktDS2xBamFxRCtU?=
 =?utf-8?B?MnJ1ekNHM0Z6bEYzTHErd3diSVFCU3FmbHcrKzUxbGZjQkJCMVdGWUFVa3p6?=
 =?utf-8?B?bXdSKzByQlRLNS9HVUdwTVU0VGw5UE9EM3crcnhHcDd5MWVyTWl1cWZYbFhF?=
 =?utf-8?B?WVFHeUY0YllFNEUrYkJEREdQdTJsenl4azZmMlVGVkQrZWtCRTMyK1ExRm42?=
 =?utf-8?B?MHR2bGJOMUxlaFE3R0NtcXJ2L29vTWFiSTBQUlBsdFFzV2VrU0RUSHlyeHRN?=
 =?utf-8?B?US92S0h3ZlpsanNGbGZpMDltSkFRYkQwK1d5M0dwbTdzeEJVYUY4SDY2QnJh?=
 =?utf-8?B?YXBEZXVZMWpsTkRURXIrSFhYWldIdmRKSWR6ZWJpUGJkSjZ4SmxhOTEzKzJZ?=
 =?utf-8?B?cmtSbWxERzMxYStUdjRMa1pZbEN1UGliMlpYZXRuSnY2UkJicVplNE5Pa0ov?=
 =?utf-8?B?MHVYYlVZNkVSR0dqOUtWTS9OZVlURW9HdW44T2tBRFFoeDZ3YWhScnJTNWta?=
 =?utf-8?B?S2FSUUs0a2xFUW4rKzZxOE01bHVONUxKYXhmdzB1cVNWSkxzUUx4VDFJSkNG?=
 =?utf-8?B?UC8yZVRNYldHRnhLOENQZ1RBaHZZYVQraFZ1YlBOcDBHa2FPdC9NVndML0Zv?=
 =?utf-8?B?c3N2VWFkdklST1o3bUYySzdSeERVQkNhTEVWbWdoYjVuUVJNenFBbkhFNDRX?=
 =?utf-8?B?MWR5YTJYN3V2aUhBUWU0Tmhwd0JkV3hZeGNxd2JGRlRsL0gyR0pyVFhPTE1w?=
 =?utf-8?B?SEpxeXdmQTJwcmpZbDFuK0pvTUZ1SElGeHdnV0dxSHpkRGZVY0NKek4zMnk3?=
 =?utf-8?B?Nmk1YlFMR2dOcm5wQVM2clJnTEREZ3NYWklpYVZkaXhMenkvdnVNazdsb2N1?=
 =?utf-8?B?azJYaSswR1V4aG42c1Yza2l1N3Y0OUR5SmRTbWxSaloxdWsyNGV6VXljaEZ2?=
 =?utf-8?B?bzN5Y2tvNjJBSEdoNHVubktGbThKeXN1US9QME1zMXczRzJSTFNzRFYxV0Fl?=
 =?utf-8?B?b2lxNHpGVzZWK3JWMm0yU2ZKc2JFMnk4b3U3QTJsSTNzdUVEaG1LQ241SGI2?=
 =?utf-8?B?YUJzWnl5N1ZzaG9uT1hOQTRmMGo1dTU5bmhFQmNwazFRU1JuSjRKTW42di9h?=
 =?utf-8?Q?jIDMWy0q2jwhuU6Dnqcq3Vrm+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37900a60-1330-4978-ef63-08dc8535874b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 08:00:13.2034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpiV9KGwJSiDHkeXF2VbKiRUv8xFP9MXNAYD2cpHj2EByoApLd1rD6j9VZ0ztLm3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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

Am 05.06.24 um 03:33 schrieb Yunxiang Li:
> Here since we are in reset and takes the reset_domain write side lock
> already. We can't use the flush tlb helper which tries to take the read
> side.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Please add some code comments with a TODO that this needs more 
investigation.

With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 +---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
>   3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 603c0738fd03..660599823050 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -620,10 +620,8 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	int r;
>   
>   	if (!hub->sdma_invalidation_workaround || vmid ||
> -	    !adev->mman.buffer_funcs_enabled ||
> -	    !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
> +	    !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
>   	    !ring->sched.ready) {
> -
>   		/*
>   		 * A GPU reset should flush all TLBs anyway, so no need to do
>   		 * this while one is ongoing.
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index aba0a51be960..93b62107f7a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4401,7 +4401,7 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_device *adev)
>   		false : true;
>   
>   	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
> -	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
> +	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 1ef9de41d193..b7ea46ed0c72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3213,7 +3213,7 @@ static int gfx_v12_0_gfxhub_enable(struct amdgpu_device *adev)
>   		false : true;
>   
>   	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
> -	amdgpu_gmc_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
> +	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
>   
>   	return 0;
>   }

