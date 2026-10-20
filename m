Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED0606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=x7xK/hkW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F5710EC08;
	Tue, 20 Oct 2026 14:22:11 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D9410EC08
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 14:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPSCGf0rXcBkTx0YLbeUWLS/MUoLNpu0WgIxwtipRryE5vN/sdYT9UUPqHdnfS0XL2NzjLwjlLNRih3X700qf1xbt5RkgnSAaFKvSTRfpX/YqQ1MXIOCvLdzp0WmcJDsaoPUUK7l6IANvmygKMb0YTPrH+rK67ZO3LpmwN2h1KS218nwFck2uQR4/77rBs3MjtE1HhCGQbh0u1S6tEu53ZyuVc7TRNEFoeQI9hH/yrLArDLaZZEJJHsTbVyK/B5rLwetSPx/UY4Wuv60w9lCMM1JC8VFOirwg5iSLCOvdFx6egCN/HFC3oJBo0+wFsROro2gc2l50awIe0Gs3WuUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFcNo/dyG5cDIoRse4/VM+4MWB6qtKu08XGMG17D3MM=;
 b=uCgicNUSIyA1OPAsWMUwUGqrLirvGWdVd003Q+krzrPxkHs24IeYKvWIItJ5ZViWUnyLAkBsWeljGZn5sVvvM3mtMpKRRcts13xfAWaMwyOx9jJbuPH0TFH20kUwN2Udh/OVk2+Ie/Ka3BSE9v6xfIADt35hxZWBG+GFnOGd9h4vb/L0VRLYIhHvh2MG+SxWYFf3wVU2vs52fZl7qyOWjDqZO34yYzM1X228XljRQvpx5UIeGGqexTbve+zmFsA9cqghS89cVRcejshiYq/zomafaPzei27Q6j5WhkdO9j9msh/C9LgzcOcGQhl37icO+IlzaNvAZBz2BIYc1zEOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFcNo/dyG5cDIoRse4/VM+4MWB6qtKu08XGMG17D3MM=;
 b=x7xK/hkW5rAK5qsVESdDWRnAfNpqvoA2jEKA20u6/BBA4d6W/Gtsai1+60CZGt6u8waRk5lFRMBKAoDCeo3WS6PZQqF3MCpQ3RV74jxkbvbaqrV/+Xh838iJ5GXfHmZuF7YlMKAUecss5L816ADYet1WLYT5ZOqS3poICUNh8fo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:22:00 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:22:00 +0000
Content-Type: multipart/alternative;
 boundary="------------5Gp6kIiFtINJeyc0MfgNYwkG"
Message-ID: <b5fdd2ba-2e85-4c72-b8de-e79b799a2395@amd.com>
Date: Tue, 20 Oct 2026 10:21:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: split vram_pages of SVM ranges prefetched
 without a GPU mapping
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Philip.Yang@amd.com, Felix.Kuehling@amd.com
References: <20261019020859.1493373-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261019020859.1493373-1-Jesse.Zhang@amd.com>
X-ClientProxiedBy: YT4PR01CA0438.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::9) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: d52717bc-03ea-48e1-6419-08df2eb5816a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|18002099003|22082099003|8096899003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: /C/nx/ZD6hSIE3UgF/qEWaUmkggyMVCE3/sOh41pMzJcjKEr60tOVT4R6vyZ5AxntVgQ+up6SpmaslgamsHtcEsMp6F8Iaav6TX+Jjk7O/n7RsKeMIxAmnB4aCfH5zxx1vk79GrRVnrqWG1RBmN5HUqKQI79fOUgmvFncJ+LidRrQdSUeGfGE/T5hsTLeoyqxvyhyXpQN6MjeZHL28oED3DVClUe8/gv50A+0AFqXaS1UBrvVUFXZnbyqZ6BqrCs3RhyeKAFLByy+nDQRseSe7emRX/Bb9eti/sgoFunY5BP8zAAT32heAvQyFDbEVl9hKTfi08qiuDz0UBGGMnGvXgHIsf1joYDdJ+WhboUP0J6yLNmGeecv/PUJN5AeG1+c24jTfenccDLvsf1WKXaGFcRq/1567hoAd98+uXPXDtgkrf66foCuGzFkQTVohJcWFggZJYuUO96dcpOAl9aZcdP/Y0aCyVPdZR2fY6PMVi+MRgODb1SF0Pn4e1z/sJcyhYti19H1IaX7tJAiSQGiJS0ztPa9F+yzz7gqNLr+7/pR8PepOpl2jm96DvhoGOFlK5fzMlbbR/oi2IC9dlp0ApXWP3oGS8s/WqgAFZoUbT66VFnJkmXXBtRSj77TniKHIWw7IP9ILmqSlKMke0ZZbOAhbiFy3pvfXtCZmh+lwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(8096899003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c25tWnV5aGxlSHdpUVFPUDY3TzdCVFptQTZUTlJSTCt0TUE2cjJVdm94aHJa?=
 =?utf-8?B?ZHE5M3l4MFZWbk9rR1hZckRFNXB0bkgwSkJheGgxUWRqam9EM3dnVkozNy9p?=
 =?utf-8?B?VWo5bHcyd1VPRzJSdGQzRFVZQjVHWitQZ0RYQjJjQ1pWZ0pjMXpOV296NXZS?=
 =?utf-8?B?NHJEckRLUktVT013SDZoMEZNNHpxNEM4OXlJTmgrd0NTQS80WmpWSTl3Vzdt?=
 =?utf-8?B?SGw4Y1c1OXNsNnFYNnpEdi9GTFVXcjFTWVhndDZBRC9CQ0FOc1VPZmFYTDM1?=
 =?utf-8?B?cDhaQWgwYk9xSEdDNzJ1RjQyNERwd084bUJOcXlMUjVDWWZybC9yWFpLbTh6?=
 =?utf-8?B?Q1dyd2J6MEhPd2NJWTZLM3VTUVRubEp5cExHUjVzdVRNL285KytNbWNGMWZV?=
 =?utf-8?B?eHhrRVhHT3R6SkcvZ28wVlYxVXo1MDU0WUk3L3VLeTFDQXFnYlE4eldDT3Yz?=
 =?utf-8?B?WURReDJ4Wk1EbDloV25qWlB4VXlZZ2MrdzhYaWdOR1ZKb1VLVkx3QmNOa1NG?=
 =?utf-8?B?UWRnQi9PckxFTUNWbWxhMjJ3em9Pc2hIN1dVaEJkL0sxeGZiQmh3WUZ4VHBI?=
 =?utf-8?B?d0hEZE0xWkJkTW44MkVuVURLdmRFK3g5SVR0Wkw3SlBPZnljSFBnNGhGOUc2?=
 =?utf-8?B?YU9PZTlScGw0MXRNQ2t0Q21kYnlaTkFKbk9ON3JOekpKdjNia0dDMDZia0p3?=
 =?utf-8?B?djdidjFpQ1pKSFpObjQ1WEtRMWxqQXI3dHRIcER1NS9QZzlyTWNJeVBnWGZo?=
 =?utf-8?B?OGpHdi9vY0ZOT0V6R01EWTJLL2Y1RUN0eHdoVXpkMGNhWFB3NTl1TUpjaTJu?=
 =?utf-8?B?QkQ4L3FYbENNTzdFRW9VVzlGckpMVkhIODVJbGYvOUwvbW1kTVJGRUMvdjk1?=
 =?utf-8?B?MzcySzBOVnA1ZTliejh3bEsyWS95TTNtSVdmS3RlMjk2VkpZNG15Ri8yR01y?=
 =?utf-8?B?UDRieFlKQ3lYWHZJelBvR2VkODJINXdLYUFvTVRIRlNSblhScDBYbkZ3NnFE?=
 =?utf-8?B?djJuWnNHTjg5WTZ3YWREbHU3SWNsL2tvemFOM0pYK2M5L0JsY3pjdkRWYlNX?=
 =?utf-8?B?eW5aK2E2ZnVqMVJjNXo1NWxWRk1iK0ZWeTlNSnBiMEsrR3JoV0VRenZHajFu?=
 =?utf-8?B?d1Z4SFAraU8vVDNOSXFJZytQRXB5K2FyV2xjWnMrSkFyREFHaHNiRzg3RG92?=
 =?utf-8?B?aDQ2ZW5HQlI3ZFcxaW5icmxSei9xdVNTMmFsbThNSktYNzFMSTRIVmErbDQx?=
 =?utf-8?B?RkdwRU94VXpEZ2ZKemFGY29FTEFRYjBDQklad1ZDTXV6RldwK0ZhWjQ4Qi83?=
 =?utf-8?B?V055T3ljTkNSSlRydkhmcSt0aEEzMUN3QzFOTElKNHlGK0gvb2czRkZJTHVZ?=
 =?utf-8?B?QStUdVJHN0ZDSE9WOGlDZU8zKzdVQXg0dzRJZ3ZjY2FzMVZUeEtsanR6YmZX?=
 =?utf-8?B?U2l0UFJvNDFPTzFKMTVzS0srT3Q1TWxRUGNPRjVCWHlSWjk2ci9sdnVsRUgx?=
 =?utf-8?B?NlJLSUN6dXgzc0lVRUhteEhZYStlRUJwUjk4Z2R4ZEZTZXZvTWgyT0FFTHE5?=
 =?utf-8?B?eVpQb1A4emtlcVpEUDVNKzNzTm5yM1dtaGYxWlBmT3IzbXlCOTVRZUV4Z3lX?=
 =?utf-8?B?UGk4QnpxNnhiNHVMaDgwbm53ejN2S05sck81M2lxSCsxNU1HZm9pRE1yV0tV?=
 =?utf-8?B?WGt6aUFkMW1pL3RmTXVCSlFPTy9DY2JNVkk1M002bjlJS2w4VnlVMGw1T2VF?=
 =?utf-8?B?Snl4MUdFM2VwZTZya3hST241THhlb0NoSGJ6b0d4TXN2OWtqTzZtRkxoR0Y5?=
 =?utf-8?B?cm9uSW96V3pFL1U3RklCRnNhaHBMeWRBeFRlN3pTNWxxWDN3R0pnTW5zMUFF?=
 =?utf-8?B?ZDJhRlhZRWozWGI1Q1BYVWJIZjArVzJoRCtmSkczOURZbXR4K1BWMEM0TnZW?=
 =?utf-8?B?Ym4zYTVBVFFid3JFUmtKTXFMWmI5emhzTk8rZFJJTVl2VjRiTzFzclRsTlN3?=
 =?utf-8?B?M0hyb1dpUVJYU3BJUXRhb01YeFltajhNZ0FqYVlXMk93Nk9oZWFRTzlOb3Zy?=
 =?utf-8?B?MWxBN29sWVJQTkFZcDlIbWl6VXcvQlpYcWdkNDFGSTI4OHBUeHFuSi9OZ1Fs?=
 =?utf-8?B?cnRTSlZnRTZRWWgxaThGbmdWU0l6R0JrYXY3TE1vc0EydVNkWmovWXVEUW5r?=
 =?utf-8?B?ZHZjejdpUjExWmRvc1pEVi9TZUxlUmo4ZkhrWWlMc1V6Z2tIelZTNEVMaEZR?=
 =?utf-8?B?czF3MmFVYkZHbHRNYmlnd09pQnM4a3psNmgwSmZrZlExZUtDbHdwT05lZmd2?=
 =?utf-8?Q?4CtqmjmFG54vCkg/iB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52717bc-03ea-48e1-6419-08df2eb5816a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:22:00.6490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiDf3y9/AqJmBkgA146bD4mD3zmcxy+4wiqjxRldCa2waDiroCZz2JOOYF7HDvzA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------5Gp6kIiFtINJeyc0MfgNYwkG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-10-18 22:08, Jesse Zhang wrote:
> When an SVM range is split, svm_range_split_pages() gives the new range
> the number of VRAM pages counted in its part of the dma_addr arrays and
> subtracts it from the old range. Pages migrated to VRAM by a prefetch
> have no dma_addr entries until the range is mapped on a GPU, e.g. with
> no ACCESS attribute, or with XNACK off before the delayed restore worker
> mapped it, so the new range gets 0 and the old one keeps the count for
> both.
>
> Migrating the parts back to system memory then gets the accounting
> wrong: the old part keeps a VRAM page count after all its pages are
> gone, so its svm_bo is never freed, and the new part underflows. On
> navi31, as an unprivileged process: prefetch 4 MiB to the GPU, prefetch
> the upper 2 MiB and then the lower 2 MiB back to system memory:
>
>    Recorded vram pages(0x0) should not be less than migration pages(0x200).
>    WARNING: ../amdkfd/kfd_migrate.c:922 at svm_migrate_vram_to_ram+0xbdc/0xcd0 [amdgpu]
>
> and /sys/class/kfd/kfd/proc/<pid>/vram_<gpu_id> stays at 4194304 until
> the process exits.
>
> Without dma_addr arrays, the split is still exact when the old range is
> completely in VRAM, which is what a prefetch of the whole range leaves.
> Give the new range all its pages in that case. The warning is gone and
> the VRAM usage drops back to 0.
>
> This doesn't cover a range that is only partly in VRAM without dma_addr
> arrays, e.g. after a partial migration, since svm_migrate_ram_to_vram()
> only counts the pages it actually migrated. That would need VRAM
> residency to be tracked per page independently of dma_addr.
>
> v2:
> - Rename counted to has_dma_addr and compare against old->npages (Philip)
> - Mention the XNACK off case and the partial migration limitation (Philip)
>
> Fixes: 006ad514a50c ("drm/amdkfd: Use partial hmm page walk during buffer validation in SVM")
> Signed-off-by: Jesse Zhang<Jesse.Zhang@amd.com>
Reviewed-by: Philip Yang<philip.yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 1f5d73f0ebce..c67132d9ae9a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1020,9 +1020,12 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
>   		      uint64_t start, uint64_t last)
>   {
>   	uint64_t npages = last - start + 1;
> +	bool has_dma_addr = false;
>   	int i, r;
>   
>   	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
> +		if (old->dma_addr[i])
> +			has_dma_addr = true;
>   		r = svm_range_split_array(&new->dma_addr[i], &old->dma_addr[i],
>   					  sizeof(*old->dma_addr[i]), old->start,
>   					  npages, new->start, new->npages,
> @@ -1030,8 +1033,16 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
>   		if (r)
>   			return r;
>   	}
> -	if (old->actual_loc)
> +	if (old->actual_loc) {
> +		/*
> +		 * Pages migrated by prefetch have no dma_addr until they are
> +		 * mapped on a GPU. A fully resident range still splits exactly,
> +		 * old->npages isn't adjusted yet here.
> +		 */
> +		if (!has_dma_addr && old->vram_pages == old->npages)
> +			new->vram_pages = new->npages;
>   		old->vram_pages -= new->vram_pages;
> +	}
>   
>   	return 0;
>   }

--------------5Gp6kIiFtINJeyc0MfgNYwkG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-18 22:08, Jesse Zhang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261019020859.1493373-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">When an SVM range is split, svm_range_split_pages() gives the new range
the number of VRAM pages counted in its part of the dma_addr arrays and
subtracts it from the old range. Pages migrated to VRAM by a prefetch
have no dma_addr entries until the range is mapped on a GPU, e.g. with
no ACCESS attribute, or with XNACK off before the delayed restore worker
mapped it, so the new range gets 0 and the old one keeps the count for
both.

Migrating the parts back to system memory then gets the accounting
wrong: the old part keeps a VRAM page count after all its pages are
gone, so its svm_bo is never freed, and the new part underflows. On
navi31, as an unprivileged process: prefetch 4 MiB to the GPU, prefetch
the upper 2 MiB and then the lower 2 MiB back to system memory:

  Recorded vram pages(0x0) should not be less than migration pages(0x200).
  WARNING: ../amdkfd/kfd_migrate.c:922 at svm_migrate_vram_to_ram+0xbdc/0xcd0 [amdgpu]

and /sys/class/kfd/kfd/proc/&lt;pid&gt;/vram_&lt;gpu_id&gt; stays at 4194304 until
the process exits.

Without dma_addr arrays, the split is still exact when the old range is
completely in VRAM, which is what a prefetch of the whole range leaves.
Give the new range all its pages in that case. The warning is gone and
the VRAM usage drops back to 0.

This doesn't cover a range that is only partly in VRAM without dma_addr
arrays, e.g. after a partial migration, since svm_migrate_ram_to_vram()
only counts the pages it actually migrated. That would need VRAM
residency to be tracked per page independently of dma_addr.

v2:
- Rename counted to has_dma_addr and compare against old-&gt;npages (Philip)
- Mention the XNACK off case and the partial migration limitation (Philip)

Fixes: 006ad514a50c (&quot;drm/amdkfd: Use partial hmm page walk during buffer validation in SVM&quot;)
Signed-off-by: Jesse Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:20261019020859.1493373-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 1f5d73f0ebce..c67132d9ae9a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1020,9 +1020,12 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		      uint64_t start, uint64_t last)
 {
 	uint64_t npages = last - start + 1;
+	bool has_dma_addr = false;
 	int i, r;
 
 	for (i = 0; i &lt; MAX_GPU_INSTANCE; i++) {
+		if (old-&gt;dma_addr[i])
+			has_dma_addr = true;
 		r = svm_range_split_array(&amp;new-&gt;dma_addr[i], &amp;old-&gt;dma_addr[i],
 					  sizeof(*old-&gt;dma_addr[i]), old-&gt;start,
 					  npages, new-&gt;start, new-&gt;npages,
@@ -1030,8 +1033,16 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		if (r)
 			return r;
 	}
-	if (old-&gt;actual_loc)
+	if (old-&gt;actual_loc) {
+		/*
+		 * Pages migrated by prefetch have no dma_addr until they are
+		 * mapped on a GPU. A fully resident range still splits exactly,
+		 * old-&gt;npages isn't adjusted yet here.
+		 */
+		if (!has_dma_addr &amp;&amp; old-&gt;vram_pages == old-&gt;npages)
+			new-&gt;vram_pages = new-&gt;npages;
 		old-&gt;vram_pages -= new-&gt;vram_pages;
+	}
 
 	return 0;
 }
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------5Gp6kIiFtINJeyc0MfgNYwkG--
