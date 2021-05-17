Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13410C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 13:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC52611CA
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 13:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC52611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 595656E0B8;
	Mon, 17 May 2021 13:54:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF426E0B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 13:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I416NuIoVu7B9rXZm4b9grFSyctla8ClmdqRkI21BsHSK4fpFKDhp4sFgIbxBTuLag47n+ondqNI90oqIq6KNPIjo07IDYT4bKbSM9o3eu0ATmMKsu0FlCbXJEsTLaaStcpKaBKdLEPdm2PHUF0ZiSkzpXfWTAchYoDb96M8lkIUgARZFnygFQGocGYWU0SPccbgjCQ+z6812CvTtAH1nWpUuj6wg3T7Rap2orTGk6ny6OSQQNW2MM4heXS9xdMq4A8I1utd/Q6HBtBsgzjpwP7+cyaG9mLy+kjcwBIUxrr8R8FkUaHDliOjBq1BvqJxomRO7m6hdv8m9vpHEJAxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik1ExhOkg9yuQEoGc71EBpaZHf63nCwWt8miXjA6R+o=;
 b=Ufi4AS4X7Bp2Gk2J/etHf+A42HDAP/h+FQFVPxly9mknXkGw1SL0USN2PdW4CNePm9gTQ7JpAEfgvORAyIoHkKnpYUKMiBMbJkAkZgYogJpeC1LTlfXEvCoFAFBFBBWx+FHeRJ76TtZLq2XgirWB6+9t+gkXiuI7jMOBe45nx+yl1ylDbIk3+PzyiwS58xOnyozsNZI7vi1yYEnVJXl6u6jsTIw37mmFvBs9F5F/EUS7waSowQ4RGBWSTPObSvakCjK35ITS1UtcXI1trtmGNWhYUlGdWwDHfghYK6WjIXj5Ge107DaohDucyf2ynEZMlEWo41Bp9McCZXF4Asi3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik1ExhOkg9yuQEoGc71EBpaZHf63nCwWt8miXjA6R+o=;
 b=wttZOHj/qnyAzE05jgeTnvje4N8uyGuuG4E3NTRxAc42bLOZ7LEvZ4FmO4BbefyTxUQFLstktfJ4hPlUamgXJu1lhGvWKCN97/mXepmAEtuluMEENI7r7owfNnAMG092GRPv98WHrDtecQd8ue3SgtZdshPssX6j9aFwOQLWiAo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 13:54:03 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 13:54:02 +0000
Subject: Re: [PATCH 2/3] drm/amdkfd: skip invalid pages during migrations
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210512173429.957-1-alex.sierra@amd.com>
 <20210512173429.957-2-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <738795f7-d2b4-ec60-7cb4-ff3f45ac1a1c@amd.com>
Date: Mon, 17 May 2021 09:54:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210512173429.957-2-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::24) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Mon, 17 May 2021 13:54:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48604564-ce4c-45ec-e738-08d9193b3a85
X-MS-TrafficTypeDiagnostic: BN9PR12MB5194:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51944D52EFA845B39F635450922D9@BN9PR12MB5194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWBNH8ITxPRWPcwBVP2E11msSVpIPPuhigb5+Tke24UEU0hTBMY2PxHeUdWDl9ve5YoTSdgWTalrdL/jJo/7CrOO7LIm9l5jiIK0QOt56Mo6FLaFSJ3iLNM0yBjUPsdjULXXeLJxEVX7H5nRW+IGtVLgp6xG7fVFOc6ha0HvAUmvWNil5+rPY8dF6HoLGJ8U1TdNacL1GSdiwnadqUKYor57SRqSR7J0xzzBC8mlI5jPLWFdzimtdBUI9Wo9yhi7MUON1thUREJZiXS6QmeeWT+TYBgBgPEf3Gqikt2LtihI5JyVp9cuIDFgOnJBKuyXv2IGXBN9RI4qF/YzjurL9I34Ge44K7SGUnDycLsK98nI6o30UfEZcIrGedxgQrirPta09YJWcf26TPMD4LW2ehG9K0UgwxBPjKB2AWry1ylN3PsAAvvdFkvTzWVIGwnj9+5Sdss2vAeYRHiPZyBb6VNWMvDmtlsXqoi5x6gqyXU08u3xzutCL2kPgk7abGD3hD+uyFvXPDUIi1OYU1i8d2GBDXZCsi1xMZtDCXCkF8aDdZqH59LHnirzv/33USVYxS6PyOoZGzV5+jK8RVYXXGA30Lb5pvikTesxAxvp+PbEqBcOYciNok286vC5st3v7Ua2DLgKy5MgKabwRROu0wIjmBeby3JMLfwLylPhDjKF8/zZwB7R2O6s20/6zhcj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(31696002)(31686004)(2616005)(83380400001)(44832011)(8676002)(66556008)(6486002)(36756003)(16526019)(26005)(66946007)(956004)(16576012)(38100700002)(316002)(66476007)(478600001)(5660300002)(186003)(8936002)(86362001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SHUrSTh3V3lEL012eGpkbm1HWURaUVFGalJkWUpWTTVBa0Y2QWNUMFVXQkZE?=
 =?utf-8?B?eURUNHlSTzcyc1EzcCtyV1FDQ3RBYmZPR3FpTnZFN2hJY1lLVk9KcWlSa0ZR?=
 =?utf-8?B?NlVWcWtFY2FRUHhLb1ZKNUNVU2xBMkdObnpqaHVaQkVaVmxqTXltZU1tTmdM?=
 =?utf-8?B?cnNnVFRqWG9mRnBBRDNVYUVDUVYyNWFpUWpwS1JQeGwxVENWU1hIZmFUd3BM?=
 =?utf-8?B?NWJqVGthSERmWFVuUE41NWNrUkR6YTVuem84akFaaTZ5VFRTcnNSUkpUSWF3?=
 =?utf-8?B?WW4xMDM4V0FNMlRNN1U3MHhsVUU0NEtHR1ZPdXVVUGNtSVJwRXhEOXc2VXlO?=
 =?utf-8?B?bk5mdVAybUhaMFRBeTczbFJ3ajNJdXc4d2o5MjE5VUMybjZscUtRSDZUNk5p?=
 =?utf-8?B?QjJXQnYwa2VSNGxmOXRxNHZsM3VlWUo2RlZTYXlYSXdXbFdKSnpiR2Q4Um1q?=
 =?utf-8?B?M2FtS1Y0RW9RZjdYNWtmMGxsVjdkZHRzemlvMXVFQ245VnJIellSWHN2UEkw?=
 =?utf-8?B?eFQzdTlHZGdDVFp6U2ExRWI1aFdrK1NSWXZPYjJjK3V0djlmb0J0V0pkTDQ1?=
 =?utf-8?B?c3QySllpcTU5U1RKbUhlWm82ak1oOENhRUVxWnVha2gwbEIwUDNZU1ZFb1V0?=
 =?utf-8?B?SzVFeUt6b2c0ZDNkWmZnOWtSYjNheENJM09kUDUrV2ZsNFNNaDAxbzJtTWli?=
 =?utf-8?B?S2REOGpRcVdKRkczckVIS3hYQjRKQ1hDTkZSZy9DUllMcVl6aGdCZ2FuYUhE?=
 =?utf-8?B?eHIyL3ppdExZR3VUSGw2YUNlQVA3V1FGbmZtZklYZ1kwcHhIbUxFR3RhRHFz?=
 =?utf-8?B?K1hNWlFsNk1mdG1CLzBheXViUTBsZmg0R3ZOT0U0WUpmWk1OVk5GLzE5UGI2?=
 =?utf-8?B?NDlYdVVsZVhPZC8xSFpocVJXZDlXWURhOXVLOVgrV0RiZUxRcy85UEE0c0tX?=
 =?utf-8?B?RG5NUVdNb0c1SVVmZXlXLzNWcExNYXhMZHcxRjhROG5mcnNRd2JBK3V3VnFY?=
 =?utf-8?B?elBUak5jaytpOFNZbWIzZ1FRVW45UTllWVRvMm5OT3hIVXdxdzQ0RTRVOVR0?=
 =?utf-8?B?WmpyNUlkK04vc0xsN1FHeE1MZXgyT2hnUFB2Y3NwYkp3WEYwejBZMW5nLzFo?=
 =?utf-8?B?R3lTNnpRVnp6YUtuK0l5NFJXM2Q5bmpEZXdQakhhQm9FU2EwNlA0UDBaTGkx?=
 =?utf-8?B?Y3lNY092TjBLbHRIS1h6WVp4blptc1dYUFJUcDdrd0svd1p2alFjNENZb1Yw?=
 =?utf-8?B?SWhQaWV0SW5aN1ZvSkhmZzlKcmIyTnh2a3VWSjd5czI3QXpoaVVqK05RWGFp?=
 =?utf-8?B?MEptWFBOeGQreEtMTHpBU1A3OTJERENjY0k0MW9TcmhwRExyUWx2cGlnNlk2?=
 =?utf-8?B?NDRjODBVRVpmMnZ5UDBMMG9vb1JzeHZuazBsSGNjTVRzdHY2K2toeEorZUx2?=
 =?utf-8?B?ZWxqNTNoeUI3bmJmY2kwODBYYWNoVWUxM1dXODVCdXlhRmhqL3pIOFRTRFBi?=
 =?utf-8?B?Umt5N3hFem9udUFjaXBJblNGdmd5NytVNlJqN2RWS1FjdFhXNXd5bWNrNUlW?=
 =?utf-8?B?WU5vck10QTBCU1M5NGFlam80cDZnTWsvakpUZC8zWmJxNll5N2RIVFdKZFox?=
 =?utf-8?B?ckplQ3RHcjZucFlIQWFzbWFzOFNIeTJxNGN4ODREd0RPaDB0c09zV3lkallh?=
 =?utf-8?B?UCtZR2NSWkpvaWk0ajVCM0V1TmZCSHFkOGpYM05aZGpZUzVvU1h2bkpoSlFl?=
 =?utf-8?Q?TiLfnunn3XDiumqg+Kihn0si1Cv07Xd8YtoSpIK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48604564-ce4c-45ec-e738-08d9193b3a85
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 13:54:02.6439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eW6w3IV89tp0id28wFbE/DUF+I36lVYOeQD9KFWk6ljADgbJ0lkG2B2O0P9BXhjllFr1JY3fOK9vJrz+Ot7j1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-05-12 um 1:34 p.m. schrieb Alex Sierra:
> Invalid pages can be the result of pages that have been migrated
> already due to copy-on-write procedure or pages that were never
> migrated to VRAM in first place. This is not an issue anymore,
> as pranges now support mixed memory domains (CPU/GPU).
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 36 +++++++++++-------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index b298aa8dea4d..e1cc844b2f4e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -419,7 +419,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  	size_t size;
>  	void *buf;
>  	int r = -ENOMEM;
> -	int retry = 0;
>  
>  	memset(&migrate, 0, sizeof(migrate));
>  	migrate.vma = vma;
> @@ -438,7 +437,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  	migrate.dst = migrate.src + npages;
>  	scratch = (dma_addr_t *)(migrate.dst + npages);
>  
> -retry:
>  	r = migrate_vma_setup(&migrate);
>  	if (r) {
>  		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
> @@ -446,17 +444,9 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  		goto out_free;
>  	}
>  	if (migrate.cpages != npages) {
> -		pr_debug("collect 0x%lx/0x%llx pages, retry\n", migrate.cpages,
> +		pr_debug("Partial migration. 0x%lx/0x%llx pages can be migrated\n",
> +			 migrate.cpages,
>  			 npages);
> -		migrate_vma_finalize(&migrate);
> -		if (retry++ >= 3) {
> -			r = -ENOMEM;
> -			pr_debug("failed %d migrate svms 0x%p [0x%lx 0x%lx]\n",
> -				 r, prange->svms, prange->start, prange->last);
> -			goto out_free;
> -		}
> -
> -		goto retry;
>  	}
>  
>  	if (migrate.cpages) {
> @@ -547,9 +537,8 @@ static void svm_migrate_page_free(struct page *page)
>  static int
>  svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  			struct migrate_vma *migrate, struct dma_fence **mfence,
> -			dma_addr_t *scratch)
> +			dma_addr_t *scratch, uint64_t npages)
>  {
> -	uint64_t npages = migrate->cpages;
>  	struct device *dev = adev->dev;
>  	uint64_t *src;
>  	dma_addr_t *dst;
> @@ -566,15 +555,23 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  	src = (uint64_t *)(scratch + npages);
>  	dst = scratch;
>  
> -	for (i = 0, j = 0; i < npages; i++, j++, addr += PAGE_SIZE) {
> +	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
>  		struct page *spage;
>  
>  		spage = migrate_pfn_to_page(migrate->src[i]);
>  		if (!spage) {
> -			pr_debug("failed get spage svms 0x%p [0x%lx 0x%lx]\n",
> +			pr_debug("invalid page. Could be in CPU already svms 0x%p [0x%lx 0x%lx]\n",
>  				 prange->svms, prange->start, prange->last);
> -			r = -ENOMEM;
> -			goto out_oom;
> +			if (j) {
> +				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
> +								 src + i - j, j,
> +								 FROM_VRAM_TO_RAM,
> +								 mfence);
> +				if (r)
> +					goto out_oom;
> +				j = 0;
> +			}
> +			continue;
>  		}
>  		src[i] = svm_migrate_addr(adev, spage);
>  		if (i > 0 && src[i] != src[i - 1] + PAGE_SIZE) {
> @@ -607,6 +604,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
>  		migrate->dst[i] |= MIGRATE_PFN_LOCKED;
> +		j++;
>  	}
>  
>  	r = svm_migrate_copy_memory_gart(adev, dst + i - j, src + i - j, j,
> @@ -664,7 +662,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  	if (migrate.cpages) {
>  		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> -					    scratch);
> +					    scratch, npages);
>  		migrate_vma_pages(&migrate);
>  		svm_migrate_copy_done(adev, mfence);
>  		migrate_vma_finalize(&migrate);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
