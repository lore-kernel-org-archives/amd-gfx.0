Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DF2CA5FED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 22:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F18A10E1B4;
	Tue,  6 Oct 2026 22:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l35m7gVO";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A17F410E1B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 22:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql87wSKtVICmM5+Zmb5fbNoihuMln5T4e0BViEljdc8NVoX4kbT4xAdymVsuolKOqH+5YJ+nAepNOL6IbcpdxrTtpLmiTlB6lh4AgYXqwoivks1RoIHpSvde7Q4loMo8xJMVcIb5O9Wx1+fYFqneLV5hjtgDdf5Ae/8mCNsMidtUSD1DlT3D926uowJ+zRMNSxbX41cgt4hb7E1+/QUWoW8HWmZAtjFpQYjr4aqaDgueOo0Hy3u5P3ivt4rOu/h8kB5jJaBMyAyUJNcQME5xhkaxSfTqm0YAplwdUhw50p2FDp+IgbdlzWuUAftqsXJoUTOgcHt7/pD9g5icVT2t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wj+yoDRY13Av4+g88AFqJscM7zj2Jv5F0OYyoXXHYx8=;
 b=KO3qq11nw7vTizITmL1LiDWFFS3wnmKJ4F8Sn/95jQ1AngCi7ckds84trs8ExYmDkfBe+PPbTzA+vDBSckx8zS1uEf/VKIhSjA8eb5a0zLV5YRlnnlUJLGPmIqOHzQau+SeuW9wzOtWlxHS94qiDkL7fzQ1zX2ZfUGkISDfK21nRWYiqtiKGOVj7NK35sVtR2++B5N/7ULPAiUrhSyU2M7Ei8wL+1fAfyrUZhxyXwNAZJgBC8M9eyOmyk6s429eS9HwkdCI3uwyq3f0iL9+LkVGvbDAEIy4Eq8fdHeew1GVeIYZD4YVm0ePTQqyN8wtQgGnp6SQS9b1imvPiIVIoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj+yoDRY13Av4+g88AFqJscM7zj2Jv5F0OYyoXXHYx8=;
 b=l35m7gVOphv504XyoLOANeJAJlKi7z8iiP1Hzj0pmbCKXOmfryHX3YiQR1xALidEyO7ZfaqpQrWY1E3VlPIYsMipa9AGibOEOF5JxetOWCudT2v3KSvS4wdVrVl2cROCgcakuYMx7j/tjoaLE+E6s9s5rnHrUZXDCfMA9VYKK8Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS7PR12MB6189.namprd12.prod.outlook.com
 (2603:10b6:8:9a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 22:45:00 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 22:45:00 +0000
Content-Type: multipart/alternative;
 boundary="------------owsYB0N6I6QvU6qt0drthlvm"
Message-ID: <554ee275-f01f-48ee-ad8c-9253d4739308@amd.com>
Date: Tue, 6 Oct 2026 18:44:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/amdkfd: Apply HMM THP zone device-private
 memory migration in kfd driver
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260904195421.42919-1-xiaogang.chen@amd.com>
 <20260904195421.42919-4-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260904195421.42919-4-xiaogang.chen@amd.com>
X-ClientProxiedBy: YT4PR01CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::25) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f74d84-de38-41b4-3901-08df23fb73f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|5023799004|4143699003|10067099003|56012099006|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: m7EeawjTVAMG8kuFnqGenZ3s1knx1b2dfwAojrwlvP+6OmpwDENNag0zGxJqO4wQVmhNwS8CjO2xrxm+Ly2l1IdNFeKgxCrds6eJPEdntcaaPWNhR5/snuuj0cfOLeeQpXzJ/NMS+rnYe1TXNYo5cvaApklA8h36PkhcGZwOHyKuB0qTUByMwdmexkQTWVRpQgMgwNGR+ngAppD6MTgmt62ecS+QRyCGTHpgSEXxU9D/LzKAL3NPtbEKXmkypn+kHtq/hDorGYI1OowojGRYyxxkCZP+Mc8eWT6C5eTNFUMd4YFZUtAGrVnNvUCwsm/fXf6b9ByMEhsT93Pu0QNIp/R6rb7eZO1Hg9Ll/U/BW3fLKAJlL1mhE+izQ3/AT3XFubfVxApzA052ZZJ149deA0DFtMuYnYirNfF9EIjEavbvrgjrWK//3rNkYkC4BhBD7g/912axbcTLqxxRYlsjnIdbE8HhtTSKHQSOiumAduzWWrduzkLZyBRs6GFKRHR0XhBGXUjKfpc5QSnmmS8kIN7L7ZjHQl7k3auh2vCG2WWSfp+YWMKlbBUiOokDuhB1rvlbrPCeFLrXd8dp4d7UyXhrMs9htA2YYzC/KPh1NEy13tzKvq7/LBYDRvfAdZc6kfuJJbyyEzl16DBW3FMP4xUXuB50HIx8gp2MBbxuEPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(5023799004)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2RKVGU2c2xGQ2dmZVlMN3pmSDljT1pERjZnUExlbjdyd2IvZmFkWkg4ODZn?=
 =?utf-8?B?SEkzNWx5Q0l2NkMwdEV1dU1zcWIyalk4dDUzSkNIa1B6STREVW5QYTI5bjdC?=
 =?utf-8?B?WEFTWVh2cEpHZnhXb1cxZjVyMlZuVzROZkpoU1Y3a1F4WFVqM05sTytFbS9C?=
 =?utf-8?B?WnI3eHVoT2dBaVpzVFYwZ29nQlZubjgxWUZZTmoweCsvZjc5RStQOWI2ZXA5?=
 =?utf-8?B?cm9Ma00zZE1hYkVJNDVnVE05R3gwSGNhYzJHS3kvNnUyN2I5UUdKK2N2L3g2?=
 =?utf-8?B?U2d1OGk2RUFiWWZtazJkbEhTVFovZ3BFZTBTTW1DZWJmaFN0QUZ4bGhweFFj?=
 =?utf-8?B?QTBZVWhWWmFweTBYcWJWaW5MeE95RDdMOHNEcDdvTEJIVWtrSmJVVHZYbEFI?=
 =?utf-8?B?bXltcDNNMG1vU2NkUk9ibTUxYUl2c21yQ0RSN0NMNEh3YlFvYk5CQ3VvdUNI?=
 =?utf-8?B?WG5LVWd0S0hqZkh4UVdDRVRWWGN2VUNxMlFSSHBHSHdxYUFrMUJkN2ZUZHB2?=
 =?utf-8?B?SkpsemlvWkh6U2kxRTQ3dUV0ZEEwdTVPMndRcUsySE5jeUgxenpWQXk1SFBo?=
 =?utf-8?B?bVdIMTJiR0tFOC9BSkdsalU1Ympyc3RxUEF6b0F1OEZNY0FJODBXVUVxaEtQ?=
 =?utf-8?B?aWMydXd6RU9XSGNwRjBrZG55UXJzT2ErY3UzM2xaTUNjR1FRMksrejF0SUxx?=
 =?utf-8?B?UHlPMDRVOWtNbmZRbng4U0xhVmJxMlRvU0RMcmJ5SGliemZGZGM1YVZaYUVD?=
 =?utf-8?B?ZWZyKzZseExOdkxmaFMzUmFQVnhhQ1oza3NjWldCa3VwWGZXZXA1VlpXemFH?=
 =?utf-8?B?b2U0OS9WRGsxUHpHMHJGYkc5LzBNVUZTM0l3ellWbUtwQWEvSms1RFVnaDVH?=
 =?utf-8?B?MlRrSkdGSGN1OTJrZGRtTmljTy9FSjUrekhRRDNiekxTeDFBZlcvTGM0WUsr?=
 =?utf-8?B?dFRQTTYxUmpGUU1NRmtMbWExZ21xSG5EUGM3Q1AxUGFST1JtOU92d21obHRQ?=
 =?utf-8?B?ejAxQ0w1eTJyemg3b3hTbDdIR2p3dGxQQVdXdFdyaktXTTRNV2Rnd29yMDM2?=
 =?utf-8?B?Vjh1aEpwdGd2WnBUeHRuckJNeG5zd3haZEZ5Z0hvNDN5KzU2RG1VWDd1ZzJG?=
 =?utf-8?B?cWZoQ000VkF2M3RBWVFWMTNHekZIRVMxZE5QK2VVamxNTlJ1U2lRWE9LZXVy?=
 =?utf-8?B?K3drbWlJbnBiNnBrZ3RORGpycDRTc0NDcEYrUUgzWlNNUXo3SVBHSGJmUWkv?=
 =?utf-8?B?NzFkUCtveDAremtHcTBtVE45NWhSa3FPa1pPd3lXWE8xaW0xeStYc0xyaWdE?=
 =?utf-8?B?RjJPUUxZS3BGTDM0aVdsL1hKOFVtK2xIWXBxM1RIeUxzTWs4Q0hKWDJrR0pL?=
 =?utf-8?B?aEd3NEt1VCtZbzhVWEJtbTNEeExZak1SUDZKRytaVS9FMUgyT0doZno4SVlD?=
 =?utf-8?B?UnVPUGREZzNNVUVlLzF0QUx2bkdTR2NGcTNDYlNRUzEvUzBIU0xLb3pWdlBB?=
 =?utf-8?B?YzdqN24zZnFxV2RuZnhzL0tBdjJTQ3hVQi8rTHdtWGFFdjdrMy9tL1VDbU85?=
 =?utf-8?B?ZmVUQ2oxeFhpWGVDVjI0NjhZM1BNVXJEY2k4bmtSR3ZRWVphK0FXbHRaMHlE?=
 =?utf-8?B?Q2k5UHkrcmhjMk5MeWxhaDZIZTI3QXkrc2pIRFJvWUpTYnNobE9OT01Bb0FR?=
 =?utf-8?B?Y1R0ZWRKcG43ckxTMUl2QUdiQys1dHFCUElNTUY2K3Q4ZnpnQzR3eTZCOEU1?=
 =?utf-8?B?TmZzbzdpYjhyVnBKaXlxT2ZZYzFOOGtzb3RxR2k2Q1l4Y1lSL3BhMkVZV2x5?=
 =?utf-8?B?RlZscTlxMFlOWTB0UHJVN3UxUTJ4bnVab0ZlZmtTVlhCa3pkVy9tdVBkVlhr?=
 =?utf-8?B?bEpQaHpQVzZ6YmtYWlI4L0crSlU0MzM1TzhnZzhGOTFpZTkxa3FDNjhkeEVR?=
 =?utf-8?B?UnNRSzFiYVlVdFZCZ0RSQUZwelRDS01wRHFqQnFHdXU5cDhSSUd2Vno3YmEv?=
 =?utf-8?B?R28ySGg2VC93RDJCeVBNajhTS3ZxZnZYd3RrTCtnNDcvbExKdkVCaUNMbnVT?=
 =?utf-8?B?QkRaZ2F2S25HMlNaQzJGSGNtVk5DVjlFY0R1bFFrUWpyaUJtSjkxZWVURVFF?=
 =?utf-8?B?QXVIeVdGdVIvcXJ0djZLR005bWQ2SWt6OWJnSVhXcmIxZ25XWk9QU2N5emR0?=
 =?utf-8?B?M3FjckdKT1VqN3ZMdlAwNzNCczNPY1k5Q0NYcVp5aHFtUnFUc1RIZFY4ZDBx?=
 =?utf-8?B?VCtRUnkzaC90VnFnUVJDdksxalFtWk5HKy9Gd24ySXRGT2pKbEVha2N6bUFu?=
 =?utf-8?B?SFhUdmVpVDZwbUZzdnc3QUdWQWF4emhmTEt1MjNQT1orSGpHdWhxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f74d84-de38-41b4-3901-08df23fb73f1
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 22:45:00.0153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62jtMVH+KqdRiC64MQ6343RrNZY31/wg4NbIJFEhf56An38DBZYb6I4wh06SufW/wDTOSgp01UuTj+hxCUhnbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

--------------owsYB0N6I6QvU6qt0drthlvm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-04 15:54, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> Update kfd svm driver to migrate device-private THP introduced from HMM core
> migration function. Select this function by flag MIGRATE_VMA_SELECT_COMPOUND
> when call migrate_vma_setup. kfd migration procedure is updated according to
> collected page type that can be either compound folio(physical continuous) or
> normal size page.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 271 ++++++++++++++++++-----
>   1 file changed, 219 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index bbf0fefd5722..af39e547c1fa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -298,7 +298,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	u64 mpages = 0;
>   	dma_addr_t *src;
>   	u64 *dst;
> -	u64 i, j;
> +	u64 i, j, k, l, m;
>   	int r = 0;
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
> @@ -309,59 +309,158 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   
>   	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>   			 npages << PAGE_SHIFT, &cursor);
> -	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
> +	for (i = j = m = 0; (i < npages) && (mpages < migrate->cpages);) {
>   		struct page *spage;
> +		unsigned long cur_dst_pfn;
> +		bool is_large = false;
>   
> -		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
> -			dst[i] = cursor.start + (j << PAGE_SHIFT);
> -			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> -			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
> -			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
> +		cur_dst_pfn = svm_migrate_addr_to_pfn(adev,
> +						      cursor.start + (m << PAGE_SHIFT));
> +
> +		/* when migrate->src[i] has MIGRATE_PFN_COMPOUND set the src page
> +		 * is compound THP; its vm address is HPAGE_PMD_SIZE aligned and
> +		 * its MIGRATE_PFN_MIGRATE is set
> +		 */
> +		if ((m + HPAGE_PMD_NR) <= (cursor.size >> PAGE_SHIFT) &&
> +		    (i + HPAGE_PMD_NR) <= npages &&
> +		    (migrate->src[i] & MIGRATE_PFN_COMPOUND) &&
> +		    IS_ALIGNED(cur_dst_pfn, HPAGE_PMD_NR)) {
> +

Unnecessary empty line.


> +			is_large = true;
> +			k = HPAGE_PMD_NR;

is_large is redundant. Just use (k > 1).


> +		} else
> +			 k = 1;

Bad indentation.


> +
> +		/* for THP src[0] alwas MIGRATE_PFN_MIGRATE
> +		 * just the first migrate->dst need be setup, others are zero
> +		 */
> +		if (is_large) {
> +
> +			dst[i] = cursor.start + (m << PAGE_SHIFT);
> +			svm_migrate_get_vram_page(prange, cur_dst_pfn,
> +						  HPAGE_PMD_ORDER);
> +
> +			migrate->dst[i] = migrate_pfn(cur_dst_pfn);
> +			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
> +
> +			for (l=1; l < k; l++)
> +				migrate->dst[i+l] = 0;
> +
> +			mpages++;
> +
> +		} else if ((migrate->src[i] & MIGRATE_PFN_MIGRATE)) {
> +			dst[i] = cursor.start + (m << PAGE_SHIFT);
> +			svm_migrate_get_vram_page(prange, cur_dst_pfn, 0);
> +			migrate->dst[i] = migrate_pfn(cur_dst_pfn);
>   			mpages++;
>   		}
> -		spage = migrate_pfn_to_page(migrate->src[i]);
> -		if (spage && !is_zone_device_page(spage)) {
> -			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
> -					      DMA_BIDIRECTIONAL);
> -			r = dma_mapping_error(dev, src[i]);
> -			if (r) {
> -				src[i] = 0;
> -				dev_err(dev, "%s: fail %d dma_map_page\n",
> -					__func__, r);
> -				goto out_free_vram_pages;
> +
> +		if (is_large) {
> +			if (j) {
> +				/* migrate previous accumulated pages */
> +				r = svm_migrate_copy_memory_gart(
> +						adev, src + i - j,
> +						dst + i - j, j,
> +						FROM_RAM_TO_VRAM,
> +						mfence);
> +
> +				if (r)
> +					goto out_free_vram_pages;
> +
> +				j = 0;
> +			}
> +
> +			/* for THP check if the first src page is valid
> +			 * if not valid skip following HPAGE_PMD_NR - 1 pages
> +			 */
> +			spage = migrate_pfn_to_page(migrate->src[i]);
> +			if (spage && !is_zone_device_page(spage)) {
> +				/* dma_map continuous HPAGE_PMD_NR sys ram pages */
> +				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE*HPAGE_PMD_NR,
> +						      DMA_BIDIRECTIONAL);
> +
> +				r = dma_mapping_error(dev, src[i]);
> +				if (r) {
> +					dev_err(dev, "%s: fail %d dma_map_page\n",
> +							__func__, r);
> +					goto out_free_vram_pages;
> +				}
> +
> +				/* get dma address for following HPAGE_PMD_NR-1 pages
> +				 * since src pages are continuous their dma addresses
> +				 * are continuous too.
> +				 */
> +				for (l=1; l < k; l++)
> +					src[i + l] = src[i] + l*PAGE_SIZE;
> +
> +				/* migrate the HPAGE_PMD_NR pages above */
> +				r = svm_migrate_copy_memory_gart(
> +						adev, src + i,
> +						dst + i, HPAGE_PMD_NR,
> +						FROM_RAM_TO_VRAM,
> +						mfence);
> +
> +				/* mark head page dma mapping as THP, tail pages dma addr
> +				 * are set to 0 for following dma_unmap
> +				 */
> +				src[i] |= SVM_RANGE_DMA_THP;
> +				for (l = 1; l < k; l++)
> +					src[i + l] = 0;

I hope this doesn't break partial mapping or unmapping. We'd need to be 
sure that code always aligns addresses to huge-page boundaries and gets 
the whole huge page. A safer alternative would be to use a different 
flag for the second and subsequent compound pages. So you'd still have 
the DMA addresses, but you could ignore them for DMA unmapping.


> +
> +				if (r)
> +					goto out_free_vram_pages;
> +
> +				j = 0;
>   			}
>   		} else {
> -			if (j) {
> +			/* single normal page case */
> +			spage = migrate_pfn_to_page(migrate->src[i]);
> +			if (spage && !is_zone_device_page(spage)) {
> +				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
> +						      DMA_BIDIRECTIONAL);
> +
> +				r = dma_mapping_error(dev, src[i]);
> +
> +				if (r) {
> +					dev_err(dev, "%s: fail %d dma_map_page\n",
> +							__func__, r);
> +					goto out_free_vram_pages;
> +				}
> +				j += 1;
> +
> +			} else if (j) {
>   				r = svm_migrate_copy_memory_gart(
>   						adev, src + i - j,
>   						dst + i - j, j,
>   						FROM_RAM_TO_VRAM,
>   						mfence);
> +
>   				if (r)
>   					goto out_free_vram_pages;
> -				amdgpu_res_next(&cursor, (j + 1) << PAGE_SHIFT);
> +
>   				j = 0;
> -			} else {
> -				amdgpu_res_next(&cursor, PAGE_SIZE);
>   			}
> -			continue;
>   		}
>   
> -		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
> -				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
> +		pr_debug_ratelimited("dma mapping %lld pages, src to 0x%llx, pfn 0x%lx\n",
> +				     k, src[i] >> PAGE_SHIFT, migrate->src[i] >> MIGRATE_PFN_SHIFT);
> +		i += k;
> +		m += k;
> +
> +		if (m >= (cursor.size >> PAGE_SHIFT)) {
> +			if (j > 0) {
> +				r = svm_migrate_copy_memory_gart(adev, src + i - j,
> +								 dst + i - j, j,
> +								 FROM_RAM_TO_VRAM,
> +								 mfence);

Are you sure this is correct? The old code incremented i after this copy 
was done. Your new code does it before. I think that will mess up your 
address calculations.


> +				if (r)
> +					goto out_free_vram_pages;
> +			}
> +
> +			amdgpu_res_next(&cursor, m*PAGE_SIZE);
>   
> -		/* accumulated j + 1 pages reach end of current drm_buddy_block */
> -		if (j + 1 >= (cursor.size >> PAGE_SHIFT)) {
> -			r = svm_migrate_copy_memory_gart(adev, src + i - j,
> -							 dst + i - j, j + 1,
> -							 FROM_RAM_TO_VRAM,
> -							 mfence);
> -			if (r)
> -				goto out_free_vram_pages;
> -			amdgpu_res_next(&cursor, (j + 1) * PAGE_SIZE);
>   			j = 0;
> -		} else {
> -			j++;
> +			m = 0;
>   		}
>   	}
>   
> @@ -410,17 +509,24 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate = { 0 };
> +	bool is_private_device = false;
>   	unsigned long cpages = 0;
>   	unsigned long mpages = 0;
>   	dma_addr_t *scratch;
>   	void *buf;
>   	int r = -ENOMEM;
>   
> +	is_private_device = svm_is_private_zone(adev);
> +
>   	memset(&migrate, 0, sizeof(migrate));
>   	migrate.vma = vma;
>   	migrate.start = start;
>   	migrate.end = end;
>   	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
> +
> +	if (is_private_device && ((end - start) >> PAGE_SHIFT) >= HPAGE_PMD_NR)
> +		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
> +

Why do you apply this only to device_private memory. This should work 
just as well for device_coherent on MI200 A+A.


>   	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>   
>   	buf = kvcalloc(npages,
> @@ -609,6 +715,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	u64 addr;
>   	int r = 0;
>   
> +	u64 l, k;
> +	bool is_large = false;
> +
>   	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
>   		 prange->last);
>   
> @@ -616,8 +725,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   	src = (u64 *)(scratch + npages);
>   	dst = scratch;
> -
> -	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
> +	for (i = 0, j = 0; i < npages;) {

If you reset k = 1, you could keep the increment in the loop header. 
Just update it to

	for (i = 0, j = 0, k = 1; i < npages; i += k, addr += k*PAGE_SIZE, k = 1)


>   		struct page *spage;
>   
>   		spage = migrate_pfn_to_page(migrate->src[i]);
> @@ -633,6 +741,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   					goto out_oom;
>   				j = 0;
>   			}
> +
> +			addr += PAGE_SIZE;
> +			i++;
>   			continue;
>   		}
>   		src[i] = svm_migrate_addr(adev, spage);
> @@ -646,7 +757,22 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			j = 0;
>   		}
>   
> -		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
> +		if(IS_ALIGNED(page_to_pfn(spage), HPAGE_PMD_NR) &&

There should be a space after "if". I see a few more coding style issues 
below. Please run check_patch.pl to check for common coding style issues.


> +		   (addr + HPAGE_PMD_SIZE) <= migrate->end &&
> +		   IS_ALIGNED (addr, HPAGE_PMD_SIZE) &&
> +		   migrate->src[i] & MIGRATE_PFN_COMPOUND) {
> +
> +			is_large = true;
> +			k = HPAGE_PMD_NR;

is_large is redundant. You could just use (k > 1).


> +
> +			dpage = svm_migrate_get_sys_page(migrate->vma, addr,
> +							 HPAGE_PMD_ORDER);

Do we need a fallback to small pages if if huge-page allocation fails?


> +		} else {
> +			k = 1;
> +			is_large = false;
> +			dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
> +		}
> +
>   		if (!dpage) {
>   			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>   				 prange->svms, prange->start, prange->last);
> @@ -654,21 +780,59 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			goto out_oom;
>   		}
>   
> -		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
>   		r = dma_mapping_error(dev, dst[i]);
>   		if (r) {
>   			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
> -			dst[i] = 0;

Why did you remove this?


>   			goto out_oom;
>   		}
>   
> -		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
> -				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
> -
>   		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
> +		if (is_large)
> +			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;

Looks like you can merge that into the next if-block just below.


>   
> -		dpage = NULL;
> -		j++;
> +		if (is_large) {
> +			/* migrate previous accumulated pages */
> +			if(j) {
> +				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
> +								 src + i - j, j, FROM_VRAM_TO_RAM, mfence);
> +				if (r)
> +					goto out_oom;
> +				j = 0;
> +			}
> +
> +			for (l = 1; l < k; l++) {
> +
> +				src[i + l] = src[i] + l*PAGE_SIZE;
> +				dst[i + l] = dst[i] + l*PAGE_SIZE;
> +				migrate->dst[i + l] = 0;
> +			}
> +
> +			/* migrate the HPAGE_PMD_NR pages above */
> +			/* svm_migrate_copy_memory_gart will add a paramter to indicate
> +			 * the migration is for 2MB THP
> +			 */
> +			r = svm_migrate_copy_memory_gart(
> +						adev, dst + i,
> +						src + i, HPAGE_PMD_NR,
> +						FROM_VRAM_TO_RAM,
> +						mfence);
> +
> +			/* mark head page dma mapping as THP, tail pages dma addr
> +			 * are set to 0 for following dma_unmap
> +			 */
> +			dst[i] |= SVM_RANGE_DMA_THP;
> +			for (l = 1; l < k; l++)
> +				dst[i + l] = 0;

I hope this doesn't break partial mapping or unmapping. We'd need to be 
sure that code always aligns addresses to huge-page boundaries and gets 
the whole huge page.


> +
> +			if (r)
> +				goto out_oom;
> +
> +		} else
> +			j++;
> +
> +		addr += PAGE_SIZE*k;
> +		i += k;
>   	}
>   
>   	if (j > 0)
> @@ -687,12 +851,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		/* release previous allocated sys pages and unmap dma address */
>   		while (i--) {
>   
> -			if (dst[i]) {
> -				dma_unmap_page(dev, dst[i], PAGE_SIZE,
> -					       DMA_BIDIRECTIONAL);
> -				dst[i] = 0;
> -			}
> -
> +			/* follwing svm_range_dma_unmap_dev will do dma unmap anyway
> +			 * not need do dma unmap here
> +			 */
>   			dpage = migrate_pfn_to_page(migrate->dst[i]);
>   			if (!dpage)
>   				continue;
> @@ -733,6 +894,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	unsigned long cpages = 0;
>   	unsigned long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
> +	bool is_private_device = false;
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate = { 0 };
> @@ -740,6 +902,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	void *buf;
>   	int r = -ENOMEM;
>   
> +	is_private_device = svm_is_private_zone(adev);
> +
>   	memset(&migrate, 0, sizeof(migrate));
>   	migrate.vma = vma;
>   	migrate.start = start;
> @@ -750,6 +914,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	else
>   		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>   
> +	if (is_private_device && ((end - start) >> PAGE_SHIFT) >= HPAGE_PMD_NR)
> +		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;

Why do you apply this only to device_private memory. This should work 
just as well for device_coherent on MI200 A+A.


> +
>   	buf = kvcalloc(npages,
>   		       2 * sizeof(*migrate.src) + sizeof(u64) + sizeof(dma_addr_t),
>   		       GFP_KERNEL);
> @@ -1132,7 +1299,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
>   
>   	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
>   
> -	pr_info("HMM registered %ldMB device memory\n", size >> 20);
> +	pr_info("---XCHEN 3.2 HMM registered %ldMB device memory\n", size >> 20);

This looks like it's not meant to be submitted.

Regards,
   Felix


>   
>   	return 0;
>   }
--------------owsYB0N6I6QvU6qt0drthlvm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-09-04 15:54, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

Update kfd svm driver to migrate device-private THP introduced from HMM core
migration function. Select this function by flag MIGRATE_VMA_SELECT_COMPOUND
when call migrate_vma_setup. kfd migration procedure is updated according to
collected page type that can be either compound folio(physical continuous) or
normal size page.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 271 ++++++++++++++++++-----
 1 file changed, 219 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index bbf0fefd5722..af39e547c1fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -298,7 +298,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	u64 mpages = 0;
 	dma_addr_t *src;
 	u64 *dst;
-	u64 i, j;
+	u64 i, j, k, l, m;
 	int r = 0;
 
 	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx 0x%llx]\n&quot;, prange-&gt;svms, prange-&gt;start,
@@ -309,59 +309,158 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,
 			 npages &lt;&lt; PAGE_SHIFT, &amp;cursor);
-	for (i = j = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) {
+	for (i = j = m = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages);) {
 		struct page *spage;
+		unsigned long cur_dst_pfn;
+		bool is_large = false;
 
-		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
-			dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
-			migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate-&gt;dst[i], 0);
-			migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
+		cur_dst_pfn = svm_migrate_addr_to_pfn(adev,
+						      cursor.start + (m &lt;&lt; PAGE_SHIFT));
+
+		/* when migrate-&gt;src[i] has MIGRATE_PFN_COMPOUND set the src page
+		 * is compound THP; its vm address is HPAGE_PMD_SIZE aligned and
+		 * its MIGRATE_PFN_MIGRATE is set
+		 */
+		if ((m + HPAGE_PMD_NR) &lt;= (cursor.size &gt;&gt; PAGE_SHIFT) &amp;&amp;
+		    (i + HPAGE_PMD_NR) &lt;= npages &amp;&amp;
+		    (migrate-&gt;src[i] &amp; MIGRATE_PFN_COMPOUND) &amp;&amp;
+		    IS_ALIGNED(cur_dst_pfn, HPAGE_PMD_NR)) {
+
</pre>
    </blockquote>
    <p>Unnecessary empty line.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">+			is_large = true;
+			k = HPAGE_PMD_NR;</pre>
    </blockquote>
    <p>is_large is redundant. Just use (k &gt; 1).</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		} else
+			 k = 1;</pre>
    </blockquote>
    <p>Bad indentation.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+		/* for THP src[0] alwas MIGRATE_PFN_MIGRATE
+		 * just the first migrate-&gt;dst need be setup, others are zero
+		 */
+		if (is_large) {
+
+			dst[i] = cursor.start + (m &lt;&lt; PAGE_SHIFT);
+			svm_migrate_get_vram_page(prange, cur_dst_pfn,
+						  HPAGE_PMD_ORDER);
+
+			migrate-&gt;dst[i] = migrate_pfn(cur_dst_pfn);
+			migrate-&gt;dst[i] |= MIGRATE_PFN_COMPOUND;
+
+			for (l=1; l &lt; k; l++)
+				migrate-&gt;dst[i+l] = 0;
+
+			mpages++;
+
+		} else if ((migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE)) {
+			dst[i] = cursor.start + (m &lt;&lt; PAGE_SHIFT);
+			svm_migrate_get_vram_page(prange, cur_dst_pfn, 0);
+			migrate-&gt;dst[i] = migrate_pfn(cur_dst_pfn);
 			mpages++;
 		}
-		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
-		if (spage &amp;&amp; !is_zone_device_page(spage)) {
-			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-					      DMA_BIDIRECTIONAL);
-			r = dma_mapping_error(dev, src[i]);
-			if (r) {
-				src[i] = 0;
-				dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;,
-					__func__, r);
-				goto out_free_vram_pages;
+
+		if (is_large) {
+			if (j) {
+				/* migrate previous accumulated pages */
+				r = svm_migrate_copy_memory_gart(
+						adev, src + i - j,
+						dst + i - j, j,
+						FROM_RAM_TO_VRAM,
+						mfence);
+
+				if (r)
+					goto out_free_vram_pages;
+
+				j = 0;
+			}
+
+			/* for THP check if the first src page is valid
+			 * if not valid skip following HPAGE_PMD_NR - 1 pages
+			 */
+			spage = migrate_pfn_to_page(migrate-&gt;src[i]);
+			if (spage &amp;&amp; !is_zone_device_page(spage)) {
+				/* dma_map continuous HPAGE_PMD_NR sys ram pages */
+				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE*HPAGE_PMD_NR,
+						      DMA_BIDIRECTIONAL);
+
+				r = dma_mapping_error(dev, src[i]);
+				if (r) {
+					dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;,
+							__func__, r);
+					goto out_free_vram_pages;
+				}
+
+				/* get dma address for following HPAGE_PMD_NR-1 pages
+				 * since src pages are continuous their dma addresses
+				 * are continuous too.
+				 */
+				for (l=1; l &lt; k; l++)
+					src[i + l] = src[i] + l*PAGE_SIZE;
+
+				/* migrate the HPAGE_PMD_NR pages above */
+				r = svm_migrate_copy_memory_gart(
+						adev, src + i,
+						dst + i, HPAGE_PMD_NR,
+						FROM_RAM_TO_VRAM,
+						mfence);
+
+				/* mark head page dma mapping as THP, tail pages dma addr
+				 * are set to 0 for following dma_unmap
+				 */
+				src[i] |= SVM_RANGE_DMA_THP;
+				for (l = 1; l &lt; k; l++)
+					src[i + l] = 0;</pre>
    </blockquote>
    <p>I hope this doesn't break partial mapping or unmapping. We'd need
      to be sure that code always aligns addresses to huge-page
      boundaries and gets the whole huge page. A safer alternative would
      be to use a different flag for the second and subsequent compound
      pages. So you'd still have the DMA addresses, but you could ignore
      them for DMA unmapping.</p>
    <p><br>
    </p>
    <p></p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+				if (r)
+					goto out_free_vram_pages;
+
+				j = 0;
 			}
 		} else {
-			if (j) {
+			/* single normal page case */
+			spage = migrate_pfn_to_page(migrate-&gt;src[i]);
+			if (spage &amp;&amp; !is_zone_device_page(spage)) {
+				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
+						      DMA_BIDIRECTIONAL);
+
+				r = dma_mapping_error(dev, src[i]);
+
+				if (r) {
+					dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;,
+							__func__, r);
+					goto out_free_vram_pages;
+				}
+				j += 1;
+
+			} else if (j) {
 				r = svm_migrate_copy_memory_gart(
 						adev, src + i - j,
 						dst + i - j, j,
 						FROM_RAM_TO_VRAM,
 						mfence);
+
 				if (r)
 					goto out_free_vram_pages;
-				amdgpu_res_next(&amp;cursor, (j + 1) &lt;&lt; PAGE_SHIFT);
+
 				j = 0;
-			} else {
-				amdgpu_res_next(&amp;cursor, PAGE_SIZE);
 			}
-			continue;
 		}
 
-		pr_debug_ratelimited(&quot;dma mapping src to 0x%llx, pfn 0x%lx\n&quot;,
-				     src[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(spage));
+		pr_debug_ratelimited(&quot;dma mapping %lld pages, src to 0x%llx, pfn 0x%lx\n&quot;,
+				     k, src[i] &gt;&gt; PAGE_SHIFT, migrate-&gt;src[i] &gt;&gt; MIGRATE_PFN_SHIFT);
+		i += k;
+		m += k;
+
+		if (m &gt;= (cursor.size &gt;&gt; PAGE_SHIFT)) {
+			if (j &gt; 0) {
+				r = svm_migrate_copy_memory_gart(adev, src + i - j,
+								 dst + i - j, j,
+								 FROM_RAM_TO_VRAM,
+								 mfence);</pre>
    </blockquote>
    <p>Are you sure this is correct? The old code incremented i after
      this copy was done. Your new code does it before. I think that
      will mess up your address calculations.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+				if (r)
+					goto out_free_vram_pages;
+			}
+
+			amdgpu_res_next(&amp;cursor, m*PAGE_SIZE);
 
-		/* accumulated j + 1 pages reach end of current drm_buddy_block */
-		if (j + 1 &gt;= (cursor.size &gt;&gt; PAGE_SHIFT)) {
-			r = svm_migrate_copy_memory_gart(adev, src + i - j,
-							 dst + i - j, j + 1,
-							 FROM_RAM_TO_VRAM,
-							 mfence);
-			if (r)
-				goto out_free_vram_pages;
-			amdgpu_res_next(&amp;cursor, (j + 1) * PAGE_SIZE);
 			j = 0;
-		} else {
-			j++;
+			m = 0;
 		}
 	}
 
@@ -410,17 +509,24 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
+	bool is_private_device = false;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	dma_addr_t *scratch;
 	void *buf;
 	int r = -ENOMEM;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&amp;migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
+
+	if (is_private_device &amp;&amp; ((end - start) &gt;&gt; PAGE_SHIFT) &gt;= HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
+</pre>
    </blockquote>
    <p>Why do you apply this only to device_private memory. This should
      work just as well for device_coherent on MI200 A+A.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
 	buf = kvcalloc(npages,
@@ -609,6 +715,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	u64 addr;
 	int r = 0;
 
+	u64 l, k;
+	bool is_large = false;
+
 	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms, prange-&gt;start,
 		 prange-&gt;last);
 
@@ -616,8 +725,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	src = (u64 *)(scratch + npages);
 	dst = scratch;
-
-	for (i = 0, j = 0; i &lt; npages; i++, addr += PAGE_SIZE) {
+	for (i = 0, j = 0; i &lt; npages;) {</pre>
    </blockquote>
    <p>If you reset k = 1, you could keep the increment in the loop
      header. Just update it to</p>
    <pre>	for (i = 0, j = 0, k = 1; i &lt; npages; i += k, addr += k*PAGE_SIZE, k = 1)</pre>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 		struct page *spage;
 
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
@@ -633,6 +741,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 					goto out_oom;
 				j = 0;
 			}
+
+			addr += PAGE_SIZE;
+			i++;
 			continue;
 		}
 		src[i] = svm_migrate_addr(adev, spage);
@@ -646,7 +757,22 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr, 0);
+		if(IS_ALIGNED(page_to_pfn(spage), HPAGE_PMD_NR) &amp;&amp;</pre>
    </blockquote>
    <p>There should be a space after &quot;if&quot;. I see a few more coding style
      issues below. Please run check_patch.pl to check for common coding
      style issues.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		   (addr + HPAGE_PMD_SIZE) &lt;= migrate-&gt;end &amp;&amp;
+		   IS_ALIGNED (addr, HPAGE_PMD_SIZE) &amp;&amp;
+		   migrate-&gt;src[i] &amp; MIGRATE_PFN_COMPOUND) {
+
+			is_large = true;
+			k = HPAGE_PMD_NR;</pre>
    </blockquote>
    <p>is_large is redundant. You could just use (k &gt; 1).</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+			dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr,
+							 HPAGE_PMD_ORDER);</pre>
    </blockquote>
    <p>Do we need a fallback to small pages if if huge-page allocation
      fails?</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		} else {
+			k = 1;
+			is_large = false;
+			dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr, 0);
+		}
+
 		if (!dpage) {
 			pr_debug(&quot;failed get page svms 0x%p [0x%lx 0x%lx]\n&quot;,
 				 prange-&gt;svms, prange-&gt;start, prange-&gt;last);
@@ -654,21 +780,59 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
 			dev_err(adev-&gt;dev, &quot;%s: fail %d dma_map_page\n&quot;, __func__, r);
-			dst[i] = 0;</pre>
    </blockquote>
    <p>Why did you remove this?</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 			goto out_oom;
 		}
 
-		pr_debug_ratelimited(&quot;dma mapping dst to 0x%llx, pfn 0x%lx\n&quot;,
-				     dst[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(dpage));
-
 		migrate-&gt;dst[i] = migrate_pfn(page_to_pfn(dpage));
+		if (is_large)
+			migrate-&gt;dst[i] |= MIGRATE_PFN_COMPOUND;</pre>
    </blockquote>
    <p>Looks like you can merge that into the next if-block just below.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
-		dpage = NULL;
-		j++;
+		if (is_large) {
+			/* migrate previous accumulated pages */
+			if(j) {
+				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
+								 src + i - j, j, FROM_VRAM_TO_RAM, mfence);
+				if (r)
+					goto out_oom;
+				j = 0;
+			}
+
+			for (l = 1; l &lt; k; l++) {
+
+				src[i + l] = src[i] + l*PAGE_SIZE;
+				dst[i + l] = dst[i] + l*PAGE_SIZE;
+				migrate-&gt;dst[i + l] = 0;
+			}
+
+			/* migrate the HPAGE_PMD_NR pages above */
+			/* svm_migrate_copy_memory_gart will add a paramter to indicate
+			 * the migration is for 2MB THP
+			 */
+			r = svm_migrate_copy_memory_gart(
+						adev, dst + i,
+						src + i, HPAGE_PMD_NR,
+						FROM_VRAM_TO_RAM,
+						mfence);
+
+			/* mark head page dma mapping as THP, tail pages dma addr
+			 * are set to 0 for following dma_unmap
+			 */
+			dst[i] |= SVM_RANGE_DMA_THP;
+			for (l = 1; l &lt; k; l++)
+				dst[i + l] = 0;</pre>
    </blockquote>
    <p>I hope this doesn't break partial mapping or unmapping. We'd need
      to be sure that code always aligns addresses to huge-page
      boundaries and gets the whole huge page.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+			if (r)
+				goto out_oom;
+
+		} else
+			j++;
+
+		addr += PAGE_SIZE*k;
+		i += k;
 	}
 
 	if (j &gt; 0)
@@ -687,12 +851,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		/* release previous allocated sys pages and unmap dma address */
 		while (i--) {
 
-			if (dst[i]) {
-				dma_unmap_page(dev, dst[i], PAGE_SIZE,
-					       DMA_BIDIRECTIONAL);
-				dst[i] = 0;
-			}
-
+			/* follwing svm_range_dma_unmap_dev will do dma unmap anyway
+			 * not need do dma unmap here
+			 */
 			dpage = migrate_pfn_to_page(migrate-&gt;dst[i]);
 			if (!dpage)
 				continue;
@@ -733,6 +894,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node-&gt;adev;
+	bool is_private_device = false;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
@@ -740,6 +902,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&amp;migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
@@ -750,6 +914,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	else
 		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 
+	if (is_private_device &amp;&amp; ((end - start) &gt;&gt; PAGE_SHIFT) &gt;= HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;</pre>
    </blockquote>
    <p>Why do you apply this only to device_private memory. This should
      work just as well for device_coherent on MI200 A+A.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
 	buf = kvcalloc(npages,
 		       2 * sizeof(*migrate.src) + sizeof(u64) + sizeof(dma_addr_t),
 		       GFP_KERNEL);
@@ -1132,7 +1299,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
 
-	pr_info(&quot;HMM registered %ldMB device memory\n&quot;, size &gt;&gt; 20);
+	pr_info(&quot;---XCHEN 3.2 HMM registered %ldMB device memory\n&quot;, size &gt;&gt; 20);</pre>
    </blockquote>
    <p>This looks like it's not meant to be submitted.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260904195421.42919-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
 	return 0;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------owsYB0N6I6QvU6qt0drthlvm--
