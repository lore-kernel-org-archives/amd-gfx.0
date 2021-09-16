Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5CFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 21:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587D661206
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 21:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 587D661206
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13BC6E83F;
	Thu, 16 Sep 2021 21:37:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B3F6E5C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 21:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYyJ+aj/kX23/NUE9HrZTO25zHmKFPjKUVapaNATYs/rV0LbSbl6p5renuHSAu1x+SlZpW8VAy2lYm2qKDaJMeA7u6aAryXhAw+hdYEH01SYTcfrb+s81LCCGCus1nQq1LVdxLyR2RZzEHen92KQ5M1Ljl1A9CcpAsjg4dBO8ZyYitLY7JtFVawLeRLwcYZqPeK78ooo/AMn3VSXGd2JKgVMd/v1QVsMzMr8mnrANAosOIUBIU4Ip+k8XgMbg72HASHkbBaNPkRBnQqSJqQ4DO92TV7BsVPOYL0Evjyol29o1IUuNs+q45FbNEuslYaJahtbOkzMOhuA5l1iEdlDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=FjXHiiemGQ4IGkZFdvp+enSk81SBYFjE7DFcHikgBao=;
 b=YyoJJhU7uXBeMAcOqE73+/MugVtIP32agp0oaSketZAMhGgHvJjjGwf2AESX3IV3ud9jVEGjq0IkYLBYpEKXMCXIrZZOnJ3rABds5uYp6ipA4cJKyy09Ibv6mf1wzygYRw43RDbdhwKuuAaPZo9BDeRk/LFZ5IZJU/rFzUBkj5h8igIbxR9qLoY+V8yIqAaG7wWlybdmpTg/g7g6uUxvjwgpRuie0V7U8O6itkakn6+hhcxS0du/MXho7LAradMx4LM0W+rNFCDJWxiBVh17YTEMbL8ycBBkpJ0pBgVt9c7N1CZv/lPg/+qIyAzI/9z2KZ04Dik1SaLHOGjhg57SqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjXHiiemGQ4IGkZFdvp+enSk81SBYFjE7DFcHikgBao=;
 b=h/31IVTTdz9oiKWS4rqNRODJRzUrAFC8LJkoG9z6dBEJpGxVpDrN13AnqlomCeTzpsLGmc8j/FH8M3uSceNObFyZb4nhyr4pI7Da5o20DxMGEnNxkqgTzuyXz4vSE/EJpd141wG3QPyom5AWFWTbBoIlUphPvMr99ksiDBdCQhk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 21:37:21 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 21:37:21 +0000
Subject: Re: [PATCH v2] drm/amdkfd: SVM map to gpus check vma boundary
To: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20210913201100.27146-1-Philip.Yang@amd.com>
 <20210916211132.20341-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <0b30317b-b937-ddda-9a39-8f328b647860@amd.com>
Date: Thu, 16 Sep 2021 17:37:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210916211132.20341-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT3PR01CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:37:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bd0cf7e-5f9c-4380-b5e1-08d9795a2a63
X-MS-TrafficTypeDiagnostic: BN9PR12MB5367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5367635D205CE639544A760392DC9@BN9PR12MB5367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TC+fpPaydxyMxYdIaYsDL6iww1c0Yjg6H7CZJIh75AJgUczsjrZ+RzqDCJ8NELGp7XnBgNO2jUhmCbDifO/Mycgp/Eg9bKDhjH3pGExaozAR+uz+Yz01bqSTZWW0QtVdmmBii+6qvm1jYleBX6QgeDt+U9lgEoupd1P3ZseZ2O8u7u5VENuiP645y6OKzDmKw0EJYm24u9xqTlqybqdchYBJakI42IJeH7UQWahgyapGlVqiQ0Ojd6vnFq0WwlXrTBB2kvQ0WiwdHFe8WLSLqVZ4hX6J5U4K4Emw2DeVi/BfUtKboiHpQbQdiG32C+45eKPt8cXFOtJfrpAtuFtkw/ccXO/TNj4bBWNjKskfXWEZXjpQE9rSbmx57jsm8ldfV5zPd5Nd9FP/YYpz2MlKFsv6L3KUvqmzrlySeqZncniVGfY9Khw9bXvdGh3eRnqjK3IOm5n9Y7qH1Pfyvi/OQdAfRGnAGjzhZ4QDMIvsCSXY9xCfiiCNR2LMQB+get/ZTJYc8XJh8vCpMn0bYUuofXbrImc1NbXyTiAdcVBTz8TFfavIKXnyZotr8uXD9HfEEnaIwfZvVqOEVDNTEKmDsH0It+1wVBWhZcaohD4KdVKKGLNTmHefhRyqFEIK6tLTYFhWm9IPPR2K4ndoTPA7Gb5CVNfE3e7WauLlJ1avc6xUzd0GZXc9KOaK9U9tq5/hIPxOpc0WAO+EOBdr0uO3xxtxTYMkmDO80AxR1Jz4JFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(2616005)(16576012)(316002)(36756003)(6862004)(66556008)(31696002)(86362001)(6636002)(508600001)(37006003)(6486002)(8936002)(8676002)(26005)(5660300002)(53546011)(186003)(83380400001)(36916002)(2906002)(44832011)(66946007)(66476007)(956004)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eklXNkFIUU5NOHQyd2c5VUNpNTgvY2NCaXNFK0o5TFh6QUpyUmpwekpvYXZk?=
 =?utf-8?B?TTk3a0J3TVpsUjFBcDVvMjVydHdKMkVsK0plYkorR2pPTHZXZ2d0bjBJQmoz?=
 =?utf-8?B?UVp2NVBlMWVEOGp6RlFaaWxTQTJxNGxMVVF5bzVrV29CUDVWY2d6R1kvLzZY?=
 =?utf-8?B?cFBkaFlmZVkyajc5UTRTRGxjdFp1c0FCbG5ZcmZrNFd4Nk9VRDl3eW9Sblcz?=
 =?utf-8?B?a2NmNWF5VktnUkpZV0l5a1FMcFE1L01LdE1aOHpJeVdiNm9mNkRJMURzeHNR?=
 =?utf-8?B?OEVSTEthTkFvZW5aclIyUFE5dkV1SDFFUjBiTXFCc2g1cXNhL3REcHpqaEdW?=
 =?utf-8?B?TW0vcVY3RU5KaHhrUHJTTlp3cTB0SDJ6RzBnSDNKL0tia2FCUXo1OHhORlhJ?=
 =?utf-8?B?V3F4SnhGZjRtM09UZ2xIQnVzdDN0U1pPRHgzc2VXcXp3WHd5RFY1MHQ2Q1pU?=
 =?utf-8?B?U1Y3cWNBdGZ4bXkyMUJqQUdqMWdsbVBzc1ZxdXJHN05tZ0tKaHZwKytyOURT?=
 =?utf-8?B?aW95eStLenZsUGRML2FMRUFQclJvY0FtellwTUQxWTRKbmZ4WHBsbnBLTHRt?=
 =?utf-8?B?ZW1idVpHTkR1SjlqN2sxelZsbjh0M3AyVnNIbFJCMExRcVF5cnRtWEFBRGRx?=
 =?utf-8?B?VzRBQjVHZkQySmdFRXZaMzVMTkxrNmZ2MjAxVERiaEkrOWtSUW04OWRtV0Z3?=
 =?utf-8?B?WUQ5cmluOHVQL05aZHJRMlF1QTJUSWRYOWNpUTNzT3hmNWk4QnpyOTBFa2Rs?=
 =?utf-8?B?Wi9YRXM5SmJSQ2lIQVFTaGpsQnhSb1M4d0RxU1Nna2JKeWJiYVZoS3ZSSUhu?=
 =?utf-8?B?MEVjdkIxVGxMTVVjUG5WRkRUbzlwK0Z2NWRmNHM0eVdnelFnM3BuU1JKZm56?=
 =?utf-8?B?eEdFU0pZV3RzR1ZJVmRjZEx4TllGalpRVDRoNzc0QitwOU5BSXYwTm5jUEYz?=
 =?utf-8?B?RDAzb2FNUE1BcnZIOE5YNGVZK2RMWk13QjRyNzJ1ZFRMSXJqRFR2ZnNIc2JT?=
 =?utf-8?B?UkYwakY1N2RVbGtBVW9HNlJtb0VRczROK2QxejFyRjdJUGtlNHZWL3FKL3Q2?=
 =?utf-8?B?bE03aHRiSGE2RC8wQzFKZ0RXbGVFSGEremdPVEZqVVJPcWFLTjV0VWJ6Rmk3?=
 =?utf-8?B?YURqanRLdjJWc2F2L2pjN2hrZnlMbi9uVU5LNnhMOGs2TnNOSVJjUlhlN3kr?=
 =?utf-8?B?VWhLemdBSm11Rml5QXIxQzA2NlZDMnllT1V6U0lwTEJ0bWllN3RXM1RtaFZq?=
 =?utf-8?B?VUtVSWZ3dUI1Y2xCcE9kOVBJeEZaZ0hFbFBteTc2WE94blk0a2tlL1hpakp3?=
 =?utf-8?B?czRtSWc1OFJldkNpNzBBQ0xnWHVNVTFMTCtWTVdnQlIxR0FZcGRoWUJ0SzEy?=
 =?utf-8?B?bzAvNkFmZTFHOHc4ZjZ6SnpCcUM2eFBWbld0VVJRSWUxMGtVeElJRE8wQUQ2?=
 =?utf-8?B?aWNadVRVTGVwYVQ1d0hZMXJocWdYZ1REeEJ5U3VrdXNTVm56QllmM1Fud0pC?=
 =?utf-8?B?ODdQcmR5SlUyRCs1SXMxSi82YU9Iemx2VTVKL0wxSk5lZk4zTFdYQnJnSmZT?=
 =?utf-8?B?YmZwR1VtTEZaVVlTUS95ZFBPQWRNalFBMFowZ3pnam9XVlpVWEo0NUR2eUs3?=
 =?utf-8?B?RE9pTHRSZE0ySU0xQ1pid0JHeXhOMkpXWnRKTmQ1RnI0QVlwZVpGRzVoRnNL?=
 =?utf-8?B?cCsxdzBFRXZWU3N5NDBwQkRjb3kxSEwrZUxmTW0yMkhFTXJkdzFVQnJwY3B3?=
 =?utf-8?Q?kcu/20H1sXhsDfQOntR+/0JgreodCqMpGBq+emp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd0cf7e-5f9c-4380-b5e1-08d9795a2a63
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:37:21.5946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rp6JuTgu5e2lCDDvJah6t6mdy/Z9quBogPpTHniNsUSI9GB6dD8xeHWy73XoEXAuvScZRaTeuKDcswEHXOvtog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
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

On 2021-09-16 5:11 p.m., Philip Yang wrote:
> SVM range may includes multiple VMAs with different vm_flags, if prange
> page index is the last page of the VMA offset + npages, update GPU
> mapping to create GPU page table with same VMA access permission.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 110c46cd7fac..de91c7e83bb4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1178,7 +1178,12 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	for (i = offset; i < offset + npages; i++) {
>   		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
>   		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
> -		if ((prange->start + i) < prange->last &&
> +
> +		/*
> +		 * If i is not the last page in the range and next page is in
> +		 * same VRAM or CPU domain

This comment doesn't add any information. It basically just restates the 
condition below without explaining the intention. Maybe something like 
this would be helpful instead:

/* Collect all pages in the same address range and memory domain that can
  * be mapped with a single call to amdgpu_vm_bo_update_mapping.
  */

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

> +		 */
> +		if (i < offset + npages - 1 &&
>   		    last_domain == (dma_addr[i + 1] & SVM_RANGE_VRAM_DOMAIN))
>   			continue;
>   
