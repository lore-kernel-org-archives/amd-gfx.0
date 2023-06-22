Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06D0EB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 15:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DAFF10E010;
	Thu, 22 Jun 2023 15:02:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC3710E010
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 15:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbVXEomG9uEGAKPKyyKbshc1Fh5yQ9lS2lrPJtzPiBMFQ3yY/uhOZLB1UpJqrzkwIW30HMNI/TD6ulOarH1fY5yzr+z/Ai6sv1ESnyVKvR6SwvmXPyDeCoroIam+wZPc+d+AkcNqndP84bhK7D5nHiZa0lwgVgJ9awlrmV2l383XcQ64beoARTNDCP/zmZxqVLiv9t80Y+csUhjAUgUK9JwaKSMzANM7975y+AXxuKSjWq0qgMYH0rZ9NlMvMFkrv3FNuQ+1NK7PD3YjiK86zI1QkILO6eR7eRpK8ywATd9VvNU34N+M8ZnyfLnq4EpVJJnb+PHeM9BCSYCE98qUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlUDgsCNvyFd1hwJ3icvzmL2qFsa7xtn6KnU7QAcUnM=;
 b=eGl+Xom93pE6glgFiiMIy7ETnzviRDAqQZd2VQaHbwcddVn2DjWkWpsuOIMRWS6co+OAMUU6wsmRZ5lzsrgpoXpY6jm8cyazSNBKEJE5q6OyG+4Okq2quXK7ilJdN2BKmMGu2547tz1t3jMcbBLenpE/Rw8REWnCE0i+ZzdwlO31mDgvnDNRItBgtvmkNnCXbnlv+r76zl+0e0oHoX1JRiBPHDJ6i17oBR2/Efvr24Tfz2jd3j2PzRTQ+YJdq7K2RSnVw1Sa9PwDdVbQV9/hFS7xMD9NSrAcsD3Rw+2Up1wFm6HHiP/KvYYK1POFyiLzz8Q+fZKwtd5Wla8bQm5+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlUDgsCNvyFd1hwJ3icvzmL2qFsa7xtn6KnU7QAcUnM=;
 b=OlJfYFOFlV62WX8wrFGIQGK/Lms61MgR/RAKhnBW/igUd1xFP+j8QqB0g2lA7veKEbc5hzAANpZ+pFysKdsvDSIAxInbPsMojVTWz3fpWfZQPhv/YAbpDwdfLgt9ZBwKgh9iIP0CNYo3qXbP0iNna+14KoAWpJZUrf43iA1akgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Thu, 22 Jun
 2023 15:02:17 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 15:02:17 +0000
Message-ID: <207e70b7-1993-386d-168f-e56c564cf045@amd.com>
Date: Thu, 22 Jun 2023 09:02:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/display: Clean up style problems in
 amdgpu_dm_irq.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230622141239.1096287-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230622141239.1096287-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:408:ac::39) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 326510ee-5dae-4d5b-6ca7-08db7331abc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEcbw61NjRRMMobzJvnl/BElEuebaEOvP1XY9+O6qdeAoWjUlUmBiaIX2u7+8mGYX7666c4mhKbqPSUopmebuBjsvjaKfWRCOybBLk6dDZsRQWtM5ivG/mT7/vSUruv/fZ9NKByJIVpajE3jk1hW9+sMIQS8bnpy17SgWYbtW8uiDk/c/ZyWUhi2Fqq89vVbP40UDMrAn1cdrX53J+wmgLAsZu+ZGAUF8MMKixWjtgwaA/L49rrK+hDbIbZGhwuR8HhOtp9xN8f4/SdupYvX+ED2ykZIc5omIQ1l+YvvnX6NocA/bBBCMha39N5kIKyT1UUm2S0HgZgExlizon3ol3dMB4xHKkSBWJYPX17S+AwyPvNdiVL2gQFYQB20bZCWOWA9WM7eiUER3L6VzelpSBc1MjE0m/3v2thr5E5EChnbBUQyR+GpEnjr2xHTvZ3HcQZPQ33CaOW8W4tfR/J7RXWJ2KgGPsEU/hW76OV5hWAZfh5mpsIr0GB23pAAg/m3oeDDXRzsfJi3IpO6sBLGPrMiTdH1SNNZBDJle7ciY+nWRbyKFwuWGzlEWvAr4qLJCEdu7G1yUnRxpyV5kngSD9NVCmSIqYkHYgEpMwRIF7Yx+1r6/lnte1KjASRGUZhaxFwPaR99qjhC9BUPeio7IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(2906002)(8676002)(5660300002)(8936002)(36756003)(41300700001)(31696002)(86362001)(31686004)(478600001)(6486002)(6666004)(83380400001)(6512007)(6506007)(53546011)(2616005)(110136005)(186003)(6636002)(316002)(38100700002)(66476007)(66946007)(66556008)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGgweEx1VElnNUxNanN0cFhCb2VyRHNrN01nYUpwUWlndGZmVFAyd2owVlRx?=
 =?utf-8?B?YXF6dlMwb3pGS2cwMzN1bFhYWkdOb2VMWXZqVU9Tc29lYXI0ZFI5cXA5VGk3?=
 =?utf-8?B?NjJtWnkwVFg2WUpScnNld2RIalpibUhmVXhxLzE4V0Y4YnFnNEIxK2NLdDdq?=
 =?utf-8?B?RFRrUlNxZXVERjh5cTFJMlpydzEwa3hiaWNNUjVxK01tZGFHeVV6V0ZvczFh?=
 =?utf-8?B?SmRNM1R0ZUhNM3hxRmhjVWozeTIxcTE4bEN2QVZ0MUw2a051aER2S2Y5WGFj?=
 =?utf-8?B?OEpGT1BaaGFENlVSNk5vdlZCT0xKOEVMR3psZnVwbzdwalJqaTRKcWNiTFNJ?=
 =?utf-8?B?K21wbFpGVmxoaEwvMjFVZDM2dWZjRmFCbi9zMEpNT1RpVWhMMWhQMGVzUVJD?=
 =?utf-8?B?eEsvUTBzL0ZEUnNOVUo1MlhxcE15N0M5enlzeDJRc1o1RzJNZExvNWw0UUx3?=
 =?utf-8?B?L0xBS3UzSEt5MzhCNmpkWTZROGlGeitTTlc1VUtVNGRBZXdISWg3TjczR2h2?=
 =?utf-8?B?VGoreTRwcCt4Q2h4a20ySUM2enpDSDhaSCtiTzVFTzk2QlFkYXFBV3pDSElL?=
 =?utf-8?B?UjNPd1R1V0daaWNuV2JZMEVKcUlJODA4OEdCVXl0SnNvcnE5bDhlVmIwOEdm?=
 =?utf-8?B?bTdqVENhY0lYVldOK0JSZStuYWd1ZEpxSmh1YjRqL1dRS3A3VjJqL1MwY1Rz?=
 =?utf-8?B?SnlUTlUvMWk5d1A5UHpVWk9vQWxFSkxqT0dDM0ZtL3hyNFozdWErOE9zWUtW?=
 =?utf-8?B?MU1Lb1hTdVhmVVJaVU5ST0llYnlONllmdm5MUzlhR2Fnd1Y5emRnaWlSUlUy?=
 =?utf-8?B?YmJjL0I1QnJ1djhWNzNWUy81VXpDR2xMTENpMWlaZTU5OUI5U2pZOGZQcGpW?=
 =?utf-8?B?UHdBb0d2a2RkSmVwaFdua0FVY3NDL2daSjQvR0RRN2RnMW9mdmZ0NWJ4V05y?=
 =?utf-8?B?N0hKYWE5R3BwQTk0aUNzb3BVZDdpSkFWQjlKaWtzN1oraDcrTVhxNFpXTVl2?=
 =?utf-8?B?ZHZYVUM0cXNURXFPSnJnYVVaRkI4dmpNZDBpYmlIL1RqS3dpZFJiS3VUZGtl?=
 =?utf-8?B?cjlIMG11NU1rYWcwMm54TkFwVEpZNzU1aWtCQkVqZk4wWWN4N0JqSHYyc2ho?=
 =?utf-8?B?M25EdFVCdUg5Q3Q4SWdieWVqNnhsUklzVFMwcjZJNlp6MEZuQm1KVFZMUlBJ?=
 =?utf-8?B?L3o0RVNkb1BUd0tGZ05pZGZlUElrR0dwNFM5dFpiS2pDeU1aMHBSaFd2aGJt?=
 =?utf-8?B?bTZyOGk4cEVzekU2K1BVbTVDeWtaZmVIbU9iR3MrUjNMVFZyMFVtM2ZubFo0?=
 =?utf-8?B?cm51TkI4NklkUUI0c2ZVbU9pclEyNHNJdHJodnJ4eG1mNnQ3ZVh0cmt2MDNS?=
 =?utf-8?B?RmZ4dW1tYW5tWkdjRTFnaXpuclJmd2JBNE1IUUxLcFYwaks4SjNHSHRvQVdj?=
 =?utf-8?B?L3ZjNjg1Qnl0V2t2cUFydGoveVI4dFlKN2wvUmF4WDdTVjRvVm05WTJSd0c1?=
 =?utf-8?B?RWxmL2c2a293cDJYNHZ3a2ZsdXlrdlhsSnIrb1pHVVhjVGxBU0xLSmFGS3o3?=
 =?utf-8?B?RFBNblJjMG9EeGFIcUg0NktVRy9ZWm1YYThzSzVxdjhlM2xoWEQ3YlB1emxr?=
 =?utf-8?B?WmpJRExhRE1tSGJGODJoWDZ1VGtjVm9uYzlzV3U4RnBESTBoc1ZBME1tZGRG?=
 =?utf-8?B?dDhZc0pvSUo2eWRmcG12TXBWWm9PcURtNmpWN1k5YzQzcFRhNlE2ZlN3dlND?=
 =?utf-8?B?TnVtNS8yOHVNNUthSlZHZi9nOEI4Z0ZOeDZudWgxanZ2U0pZdEpjbUIzZTRn?=
 =?utf-8?B?bDdwdXhYQmpkTkdNeXp3RDl1NHkzWDY3bzU5aEtpdldNVm1sekN1M1JNbjY0?=
 =?utf-8?B?eFlDNkV1a3JsZGJaMUYrMFBJZnFsS05jTkpYRTJzSndZQ3ZDTGNabmV3S0dn?=
 =?utf-8?B?aVpSS0hxUysyWGFWRFJUc1lzVDgvZW41eFh6d3M4b2NVSHh2TFY5NmpubnRT?=
 =?utf-8?B?bURaeW9zNnp6TkZ6OEdwY0RYTG16dzBtWnA1b2E2ZjR3SnFBU2JQcWh0QVAr?=
 =?utf-8?B?dEw3dU53bzZiVEJneFhqNzBPWnc3SGJjNmJoRHlHbDRZTUR3L2g2elFJYmFj?=
 =?utf-8?B?UGk2d0U4c0hFRVQvSlh1VmVBcW1KSklnamdjS2M4TlV6NlBJb0k0MlFQV2NM?=
 =?utf-8?Q?f4pbOdpuWmXCdOKWPQIjIMXpbt8I32T80zgamwFTdtGF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326510ee-5dae-4d5b-6ca7-08db7331abc6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:02:17.7073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4qpgFoeOfpnirbotDpf2Mq4tkF79UmHlReQ3aYT11zt19A8fj8L9OiIYeDcyprKIxbpMn6ErFwR6TQCg84eQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/22/23 08:12, Srinivasan Shanmugam wrote:
> Fix the following warnings reported by checkpatch:
> 
> WARNING: Block comments use a trailing */ on a separate line
> WARNING: Comparisons should place the constant on the right side of the test
> WARNING: space prohibited between function name and open parenthesis '('
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 42 +++++++++++--------
>   1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 19f543ba7205..51467f132c26 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -120,7 +120,8 @@ static void dm_irq_work_func(struct work_struct *work)
>   
>   	/* Call a DAL subcomponent which registered for interrupt notification
>   	 * at INTERRUPT_LOW_IRQ_CONTEXT.
> -	 * (The most common use is HPD interrupt) */
> +	 * (The most common use is HPD interrupt)
> +	 */
>   }
>   
>   /*
> @@ -172,7 +173,8 @@ static struct list_head *remove_irq_handler(struct amdgpu_device *adev,
>   
>   	if (handler_removed == false) {
>   		/* Not necessarily an error - caller may not
> -		 * know the context. */
> +		 * know the context.
> +		 */
>   		return NULL;
>   	}
>   
> @@ -261,7 +263,7 @@ validate_irq_registration_params(struct dc_interrupt_params *int_params,
>   static bool validate_irq_unregistration_params(enum dc_irq_source irq_source,
>   					       irq_handler_idx handler_idx)
>   {
> -	if (DAL_INVALID_IRQ_HANDLER_IDX == handler_idx) {
> +	if (handler_idx == DAL_INVALID_IRQ_HANDLER_IDX) {
>   		DRM_ERROR("DM_IRQ: invalid handler_idx==NULL!\n");
>   		return false;
>   	}
> @@ -343,7 +345,8 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
>   	/* This pointer will be stored by code which requested interrupt
>   	 * registration.
>   	 * The same pointer will be needed in order to unregister the
> -	 * interrupt. */
> +	 * interrupt.
> +	 */
>   
>   	DRM_DEBUG_KMS(
>   		"DM_IRQ: added irq handler: %p for: dal_src=%d, irq context=%d\n",
> @@ -390,7 +393,8 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
>   
>   	if (handler_list == NULL) {
>   		/* If we got here, it means we searched all irq contexts
> -		 * for this irq source, but the handler was not found. */
> +		 * for this irq source, but the handler was not found.
> +		 */
>   		DRM_ERROR(
>   		"DM_IRQ: failed to find irq handler:%p for irq_source:%d!\n",
>   			ih, irq_source);
> @@ -450,7 +454,8 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
>   		DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
>   		/* The handler was removed from the table,
>   		 * it means it is safe to flush all the 'work'
> -		 * (because no code can schedule a new one). */
> +		 * (because no code can schedule a new one).
> +		 */
>   		lh = &adev->dm.irq_handler_list_low_tab[src];
>   		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
>   
> @@ -494,7 +499,7 @@ int amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
>   		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
>   
>   		if (!list_empty(hnd_list_l)) {
> -			list_for_each_safe (entry, tmp, hnd_list_l) {
> +			list_for_each_safe(entry, tmp, hnd_list_l) {
>   				handler = list_entry(
>   					entry,
>   					struct amdgpu_dm_irq_handler_data,
> @@ -571,7 +576,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
>   	if (list_empty(handler_list))
>   		return;
>   
> -	list_for_each_entry (handler_data, handler_list, list) {
> +	list_for_each_entry(handler_data, handler_list, list) {
>   		if (queue_work(system_highpri_wq, &handler_data->work)) {
>   			work_queued = true;
>   			break;
> @@ -627,7 +632,8 @@ static void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
>   			    &adev->dm.irq_handler_list_high_tab[irq_source],
>   			    list) {
>   		/* Call a subcomponent which registered for immediate
> -		 * interrupt notification */
> +		 * interrupt notification
> +		 */
>   		handler_data->handler(handler_data->handler_arg);
>   	}
>   
> @@ -664,7 +670,7 @@ static int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned type)
> +static enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
>   {
>   	switch (type) {
>   	case AMDGPU_HPD_1:
> @@ -686,7 +692,7 @@ static enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned type)
>   
>   static int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
>   				       struct amdgpu_irq_src *source,
> -				       unsigned type,
> +				       unsigned int type,
>   				       enum amdgpu_interrupt_state state)
>   {
>   	enum dc_irq_source src = amdgpu_dm_hpd_to_dal_irq_source(type);
> @@ -698,7 +704,7 @@ static int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
>   
>   static inline int dm_irq_state(struct amdgpu_device *adev,
>   			       struct amdgpu_irq_src *source,
> -			       unsigned crtc_id,
> +			       unsigned int crtc_id,
>   			       enum amdgpu_interrupt_state state,
>   			       const enum irq_type dal_irq_type,
>   			       const char *func)
> @@ -729,7 +735,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
>   
>   static int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
>   					 struct amdgpu_irq_src *source,
> -					 unsigned crtc_id,
> +					 unsigned int crtc_id,
>   					 enum amdgpu_interrupt_state state)
>   {
>   	return dm_irq_state(
> @@ -743,7 +749,7 @@ static int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
>   
>   static int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
>   					struct amdgpu_irq_src *source,
> -					unsigned crtc_id,
> +					unsigned int crtc_id,
>   					enum amdgpu_interrupt_state state)
>   {
>   	return dm_irq_state(
> @@ -893,13 +899,13 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>   
>   		const struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
>   
> -		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd) {
> +		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
>   			dc_interrupt_set(adev->dm.dc,
>   					dc_link->irq_source_hpd,
>   					true);
>   		}
>   
> -		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd_rx) {
> +		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
>   			dc_interrupt_set(adev->dm.dc,
>   					dc_link->irq_source_hpd_rx,
>   					true);
> @@ -928,13 +934,13 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
>   				to_amdgpu_dm_connector(connector);
>   		const struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
>   
> -		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd) {
> +		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
>   			dc_interrupt_set(adev->dm.dc,
>   					dc_link->irq_source_hpd,
>   					false);
>   		}
>   
> -		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd_rx) {
> +		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
>   			dc_interrupt_set(adev->dm.dc,
>   					dc_link->irq_source_hpd_rx,
>   					false);

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
