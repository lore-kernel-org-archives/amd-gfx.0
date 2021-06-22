Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB7C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 23:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED12560FEE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 23:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED12560FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821656E82D;
	Tue, 22 Jun 2021 23:31:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85AA6E82D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 23:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnOEeXnmmtImGFxrA898lzdpKlDGTuYkwCx3xELmAJOVlt8Q43Vrq3k70+WGP/j4ndBPAuAtx9aRDHsSBexi7ZnGjDXR4khz6HyGeuwebL9+VU+u6frm/IMefgQdpqxkFN2YNuzAjvds3K+aVLqFQdfIMkTSZRvUN7ScvHvBCyhML+9tYG8Vo96u0zRTTRI+YHZp1aLCY9XG3uph5CuFTLOKUaum1ZwV5TlEDqGmpjglmH1Oerk53znWlSkZyt8A6wvi4OAkdmbs8ZwUS3ONfLviHVXrqG0uGFtHaLl5fsVosqhVl3Pg9oyun6MZmJLEiQm94ToVp5AdmlnzoWOScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbZpX6V1vpvviBX9Ung0y1mNTGpADhDwMBRIAtcvgns=;
 b=d+eV8hMIP1H9flIUdjDZAFAWnjA0yMIQld6KjQPIqBNEWs2aBRhUqgvqNm1v5QRqRtiZAjTcS+5Rnd7LZJP+3VehBe6HwlLKGJ7Xa7A1P0hn3BTnVY1kkDJq8n907YTau4YMStnZRJYy5ROnIfgzJWcMeLs1KPL5C5rqJWx6UCx/rnfRw8EMSe8jn3BhUMXtvAMqg/4mLaYZtjKIMOG5swDgEykI8Hjm3Jy8L/etTgSpqDaxS/3vcy5w80YVu/+Yt849ngw3z3Xt0jyp42+9k/9ccpdgbGQhEksvxRvCAsUulsqzw8SXp3ElJ9XwmAPbVDboM2fLLnXBTjVvaffksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbZpX6V1vpvviBX9Ung0y1mNTGpADhDwMBRIAtcvgns=;
 b=IhPSjv65qlC7i65i4XenjD6jjPt1pRlFcZk6tLTboWsKhvf6DBbo9rup5b/ZA+wKcSg0AnYwIbzdVqi0fIzwInMwqSKc4tnQguW2D+N+6p4qftgblENgqZ7dhbI7/5J8JlzxyKhJXMbPRh1qGvFqQUQRR31IYxcYKEJU8vj3HQ4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 23:31:30 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 23:31:30 +0000
Subject: Re: [PATCH 4/4] drm/amdkfd: implement counters for vm fault and
 migration
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210622133213.21393-1-Philip.Yang@amd.com>
 <20210622133213.21393-4-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4150a526-9bd3-3d7e-0aa0-5ceef3abecec@amd.com>
Date: Tue, 22 Jun 2021 19:31:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210622133213.21393-4-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 22 Jun 2021 23:31:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 122f8ebb-4c4a-4396-5c19-08d935d5dd0d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5146A13A1D9E16A0E68C76F992099@BN9PR12MB5146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mI0u10/83oFZEc/ip9WpreD4hoQokwS2AOBXMiGfwRwm3xXA6CU0Y2kf9+jQkevBcO5b7lZsi7OAJpie98bj9Cw/Bc29w0v+FjpYIaY4+3O1iV1CJiP3UWfYmcXxn7p7IFBLPiclmHxDTvFAa1rgaryvPEbVgky6umY0u0vAT8zq+ti9PpNeb5KiQZswf0sPspaam9d6zXn35HFD22+LAI7R/xsVJfiIi5zPbdzyA4KDMY51Xp+UuzzFaqDI1kHPmr2Q6aFIyHVl8/2D8RotBvwFAubuNXe7gFNGVZyt5GCaAohNzhTMH6BQFN7AmXyPEXyIydu2iArfdTByiBzbexLMvdEQpNyAUMJXlbu1/sE9vnleyoJWDMRwElSGvrRL3vnPivLh6mNvSV/pU8xR2ILWw7TASv7yH8J0gQcCa3Dlnx3DUczE1veWL8VUxVgsKaUvkqzrRZz6fvrxR9Gu99dEJ4PKtCY/p6K5YAWgfh+OHIJ+MaPZzbMOVr/ZYF0NybB7gf6vOC5SUzmuaj8jk6qLmHlZK9bWDdfKdgxG1/oHWcedlgBlowoRZBP+99tZrn8X6GU9PgDbVm2E6GiPR2b0TlZ/BFwx2rS4zoIdES/6GBJVuYS+YTDtQwrQM9fzRkRHoGB25zGE8SvrCEGFL35od8TRgA14n859L8MaZKrXBELvn0URmhBwfnYudYat
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(66946007)(66556008)(316002)(66476007)(31696002)(38100700002)(86362001)(26005)(8936002)(16526019)(478600001)(186003)(83380400001)(2906002)(16576012)(44832011)(5660300002)(6486002)(8676002)(36756003)(31686004)(956004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3YvOU1sMEtVa1dUc3RPQ3QzQ1Y5S0EvaXhoOHpub3VSSkxPR1BPQ2ttdG5p?=
 =?utf-8?B?ZmVaQW4xL1dkQ3BNcWoyODFmSVRJR1dDem5oR29vTHRDRU10ZXNuTTFQUkxr?=
 =?utf-8?B?NFFLNCtTY1R3UXFHYWVZcFRvc0NoY1dvVHVubnJFVDgzdUtWTHZTWElNNlNJ?=
 =?utf-8?B?cTB5UEpSOXUrMTQwQlFmcVVvMVFyL1ZQSHFLSnJpdCtRekdNSm4xSUR2cmhy?=
 =?utf-8?B?TXRWS0w1azd3OVl5bHdhUlBtVmtCNkNwWW1vNWRVcjhaNWhBNU4weWlWMmF0?=
 =?utf-8?B?OEJ3NFNvbXAyakZkcktiVDBBWUEvN1VBQUtPRURzZGNRYWdHWEhNRzdrT1lr?=
 =?utf-8?B?TVkveE41N1UvOWlGTWFhd0RvbE5qQUE1c0VxeHdra1RINExoa3J3b0NrS2Ux?=
 =?utf-8?B?RUNhOUg3eFptUmhpaWZ5Mkp1R1RNMGVUejJob090c1lhQ0pIVVJQbnpPUnBS?=
 =?utf-8?B?eWlLRHg2Z0MvZ3J5dHNBek02YWszRStuK05oVytvbENKc0QveVJQUi9LQXJC?=
 =?utf-8?B?ekxYVEtlZEZhYlQyQjByS1VtOWRlQmhqaVRZZ0p6QVBMM3E4NldYaDBOSFd6?=
 =?utf-8?B?M0IrUDl1TTUwWXRYenJqMmkwWm1YNzZGZWlTVUZ4RnJmcHVvdkZiSURPRjNR?=
 =?utf-8?B?U3dnZWsrZDJSdUNJbW95VlVySWZOSFI1MGg2bmVKZ1RJRUxORUgzWjZCd3Z3?=
 =?utf-8?B?SHhKN05XTWk2QytFN2J6amRrUmVzSTEreFZ5NDQ3RE0vS3l3MWRCd1V3ZG9w?=
 =?utf-8?B?b3JXL0l4ZnFGWXlqNjA3RFA4b0xGYWZscUdqZFFtMDMvNVVnVEc5aXAvYnBH?=
 =?utf-8?B?T2RLOFUyK2pqZDJ6ZS9UcVBBR2JxSHZKVkhRaC9qdE5HMWoreWdLQjVNeERG?=
 =?utf-8?B?UHd6TTRBT05NMmRwRDFqTVJWSG1oYVF1d3BNNFlEWXMyOXNHY0dqOGkxV011?=
 =?utf-8?B?bjVmU0FTRWUwR2oraGJGQ0l2blhSajZzQlRaUUNjVWhJYmpFWCsrRElCaDhH?=
 =?utf-8?B?c0NPanRNN2tUd0xyWGRuRW5yNXYvSWNyVU0zcmxPUWFEMFJTYkFpVkRmRnR4?=
 =?utf-8?B?b1JQTTVQdnBabDVCaGxRcU5hSHZ2U0VUcnhEb3ZwWkhEM29sQksrZDlKRlZ3?=
 =?utf-8?B?azlzVjI1alRneUVCd05oMHYzejVqSW1wTk93VVFUR2swNG8wdWxkNHBvNC8x?=
 =?utf-8?B?S0Z2bUdQM2llekd3Z1V6Y1VUMzc1K0RsK25KNFhSVkZsaGdVTGJFWHo5ZURr?=
 =?utf-8?B?c2lsN0hNblpDYlNwVDBZWjFlQjJHa0VFRTJlbHFtRTJUMlNROWg3S1N5RERl?=
 =?utf-8?B?T0l3YnYvVWtKK3FRa3hZWVFMWEUrU2NxTnZJSERRZnVKc0pET3ovTEUxemV0?=
 =?utf-8?B?WE5FNDBCZ1ZBWURDSXpnczFSOVVvci9COTl3UHBFZ1UyNUNzNjFYcFRDNm55?=
 =?utf-8?B?a01nSk8vUHo3QzdGZEVraHFMQ1N0bmRZY2ZCQkJvTTJKWm56SkovM1VkQjd0?=
 =?utf-8?B?UVVnb01iNDdobkkyaDY2cXlkaHRqNnlLYjlyM0w2dm11bThmTUZKdjlMMm1o?=
 =?utf-8?B?dnQ3VE9vMUlwbXFDbmNWeDZ4M3BYc3dxZGNQZ1V2U0lXK3NwWmtSUHRUYWFr?=
 =?utf-8?B?UmMvTVVnSjhVdFpWNzlCT1NJeEY4TXk0bEQvZWc0RXNGQlpUVGhndFAwYWc5?=
 =?utf-8?B?UWM1SGJMajNycEVocVo1QVhWanl0S3d1cTRnbUpRbnZXRDhFL0lXL1U4TmRO?=
 =?utf-8?Q?3iXP+kITFZO4NGLnRBFY3AyoJNDpzrHO5xS6xVj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122f8ebb-4c4a-4396-5c19-08d935d5dd0d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 23:31:30.5768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPYRUoN5f3GWKntKQrVDGwSUeM3Ouyf6eIOPNdfrdIJC5BX1oY1GRaZJj3BW5Q/ks3uLYMOsFm5Pp6oygvXCcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
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

Am 2021-06-22 um 9:32 a.m. schrieb Philip Yang:
> Add helper function to get process device data structure from adev to
> update counters.
>
> Update vm faults, page_in, page_out counters will no be executed in
> parallel, use WRITE_ONCE to avoid any form of compiler optimizations.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 ++
>  3 files changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index fd8f544f0de2..45b5349283af 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -413,6 +413,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  			uint64_t end)
>  {
>  	uint64_t npages = (end - start) >> PAGE_SHIFT;
> +	struct kfd_process_device *pdd;
>  	struct dma_fence *mfence = NULL;
>  	struct migrate_vma migrate;
>  	dma_addr_t *scratch;
> @@ -473,6 +474,12 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  out_free:
>  	kvfree(buf);
>  out:
> +	if (!r) {
> +		pdd = svm_range_get_pdd_by_adev(prange, adev);
> +		if (pdd)
> +			WRITE_ONCE(pdd->page_in, pdd->page_in + migrate.cpages);
> +	}
> +
>  	return r;
>  }
>  
> @@ -629,6 +636,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
>  {
>  	uint64_t npages = (end - start) >> PAGE_SHIFT;
> +	struct kfd_process_device *pdd;
>  	struct dma_fence *mfence = NULL;
>  	struct migrate_vma migrate;
>  	dma_addr_t *scratch;
> @@ -678,6 +686,12 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  out_free:
>  	kvfree(buf);
>  out:
> +	if (!r) {
> +		pdd = svm_range_get_pdd_by_adev(prange, adev);
> +		if (pdd)
> +			WRITE_ONCE(pdd->page_out,
> +				   pdd->page_out + migrate.cpages);
> +	}
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5468ea4264c6..f3323328f01f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -564,6 +564,24 @@ svm_range_get_adev_by_id(struct svm_range *prange, uint32_t gpu_id)
>  	return (struct amdgpu_device *)pdd->dev->kgd;
>  }
>  
> +struct kfd_process_device *
> +svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev)
> +{
> +	struct kfd_process *p;
> +	int32_t gpu_idx, gpuid;
> +	int r;
> +
> +	p = container_of(prange->svms, struct kfd_process, svms);
> +
> +	r = kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpu_idx);
> +	if (r) {
> +		pr_debug("failed to get device id by adev %p\n", adev);
> +		return NULL;
> +	}
> +
> +	return kfd_process_device_from_gpuidx(p, gpu_idx);
> +}
> +
>  static int svm_range_bo_validate(void *param, struct amdgpu_bo *bo)
>  {
>  	struct ttm_operation_ctx ctx = { false, false };
> @@ -2315,6 +2333,7 @@ int
>  svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  			uint64_t addr)
>  {
> +	struct kfd_process_device *pdd;
>  	struct mm_struct *mm = NULL;
>  	struct svm_range_list *svms;
>  	struct svm_range *prange;
> @@ -2440,6 +2459,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  out_unlock_svms:
>  	mutex_unlock(&svms->lock);
>  	mmap_read_unlock(mm);
> +
> +	pdd = svm_range_get_pdd_by_adev(prange, adev);

svm_range_get_pdd_by_adev needs to do a linear search. You don't need
this here because you already know the gpuidx. I think you can just call
kfd_process_device_from_gpuidx(p, gpu_idx) here.

With that fixed, the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


P.S.: Thanks for catching and fixing those memory leaks in patch 2.


> +	if (pdd)
> +		WRITE_ONCE(pdd->faults, pdd->faults + 1);
> +
>  	mmput(mm);
>  out:
>  	kfd_unref_process(p);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 0c0fc399395e..a9af03994d1a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -174,6 +174,8 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>  			 unsigned long offset, unsigned long npages);
>  void svm_range_free_dma_mappings(struct svm_range *prange);
>  void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm);
> +struct kfd_process_device *
> +svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
>  
>  /* SVM API and HMM page migration work together, device memory type
>   * is initialized to not 0 when page migration register device memory.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
