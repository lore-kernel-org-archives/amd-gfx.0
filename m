Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AD7C388F7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 19:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1617F21556
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 19:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="elXyzMNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1617F21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD3A6E0BA;
	Tue,  3 Nov 2020 19:54:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E876E0BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 19:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfuMMO9w8QDFELAZn5xxF1boOfayHLAWxmhEr8iUXXiZ2pro3lzyAlp3gynqTZTxGl1lDFBcPv2SqTyKZ4rSR4M3URYbjLkfFPecPNCo1HXtY5DxWFQZUWmGCRwxLSRCmUegqa+bDH0/l+p+QSpJVLwqsF6YlZPIYmsk8wpbwT/l4cIqNJk7poB7VuUNJb8GDZ+b4/aAtaGwzxxQt7dK3qzTLcQrNpEQE3LiIHi2yrwJRVqdHadGN4ffQsDWa0iSK5YT+0lvNIQf8CJ8zpxL/Fe+NiN8ZHXoRLEAgpT9V+YQDIMlLBpfjb/8wDQddwJj2AqjUAdhp4i1lhw7RC5MhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+ciVO+PFcDTsyVAUTIEnJsak7t6+UH4sM3OxUwqz+Q=;
 b=g5LULW5989ADhnhloo+1caSvhWgLbdlRHVl1ciI1kn5whdNMO3+Ok4AlLvs3FY/Hb1cHht1C9H5XdfIG4PnA7mb7qQ9FpmvsnLP52YlNljw/AbO9pRZfaJz3Y/gF79dsEtBmxlQvBHJAqx79J9bVF3DGxMF6s6pCk4ZQSnOvABYaK/yMoaHlWP7D7D3IakXmfhxySXB7IfcGUfe1t+ER6SoruyBpyH34Sfht1q/NTftYS/Po8SlegicSBtKEXKXXxksAnNBIswlCRAHJinQrx65j5Ce0OWddzOIGs3fQQw06cPzuamxw7fg61mnZ3dkpH/ZII8Ns2a0D1VDyRy0lNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+ciVO+PFcDTsyVAUTIEnJsak7t6+UH4sM3OxUwqz+Q=;
 b=elXyzMNOfRSEqvHsqQPoDzaUBJeOMXIx30M5kkmyrViIyAXrywQbtsWbIozr1a+3AJep3S1tGvXAm56nwhitO4S/9JshOAXNe7xU0tZyexiYBaFWmG3DsrxU8uC+LiwcT5HrMOu9RRkgyLG1fdUaHIjL8cxW1fFXdkwLoy50TQY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2580.namprd12.prod.outlook.com (2603:10b6:207:3e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 19:54:49 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 19:54:49 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Enable arcturus devices to access the
 method kgd_gfx_v9_get_cu_occupancy that is already defined
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201103031050.22474-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <933bb939-074a-2f2f-6ddb-0dbaf31a4f55@amd.com>
Date: Tue, 3 Nov 2020 14:54:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201103031050.22474-1-Ramesh.Errabolu@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.13.173]
X-ClientProxiedBy: YTBPR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::36) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.13.173) by
 YTBPR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 19:54:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c5d0fdf-a652-431c-9d4f-08d880325266
X-MS-TrafficTypeDiagnostic: BL0PR12MB2580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB258049C3A39E3F9F94B2096B92110@BL0PR12MB2580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2Vk4KnVWom4QURo3bdzERSeyEtfzCklQkqrZXz/R210Elf60VKtnqagtlmW9GU8eFKMquLhDlbAXdCA2Uq413UUFrNSkN4lY6MDPhvyrtmxNA5cHGdzc4cyrFTlgWgJDAoFPzAL5rAlmQru7M0wxHVpNy3htyz0l90alRqVbxlT3r4ucDfiGOUq/tInnaqA0yzHT1EnxysB1WX6GKEEB4Yh33ha0ov/arn0y0wXZedzIsTTBl9ZYqrBMmkeS9WBkDHosjWfWj+0AD0cLGn6dRCDiQCnSnFw0ySHGh5TDR1h9pk7CGUDA0HgFSYwGWqk2+Ej4Yq6a/D/fugaU9jeNEj8s6XxZcfBhlBP0LwNurBURxev1qF01q0J5yd8GgkH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(16576012)(5660300002)(2616005)(31696002)(316002)(478600001)(66476007)(66946007)(186003)(83380400001)(2906002)(66556008)(16526019)(26005)(8676002)(44832011)(8936002)(86362001)(52116002)(31686004)(36756003)(6486002)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: defxFGhDlrfbh/PbV/mCriL+SBk3ADDsAEKYrU4JtlYwlKZhrSpgPbL+fToGSf2D7SwqWCIY7w8AVYcRmJFswkYl3bHdgVYDiufDLMeaIh90p6MwzRDW22ipCoLH1dZ9G3vkD3jFSxuRxYFhH0eplw1ISnjSxAzUOBwZW4HXrxxI9aUiCAzU8Pf5+Nczr1AHdCSQcvLhD4eZ4JvQqfrMNqNlZW7v3BS21yce2AVjrQH8cMC1rfyrWPDYNnqUCG7LY62XWnCE905XvfR2D9Q4n6asVOXi5ioLhyd00bBSz/FnXKzcZY3zGxAaHOfqYTwOAW1sC9FipouuKGNm5eG7VVnZJK829HHScLgY8l/CZk7Pvy+f0o5owh0JlK4CTetKOhhWxvlHZwW3J1dD50MYFov9B5o0QmDKuG4EPRvitfgSAfVGK0soz6edoJjOX6pJkGb03l38ZBNZlDNOxgW1C640aNynKd3ACu2wMLlYdJ8l84m84sSYKE1muEASBeeHF4DZCkjDkPFonZZpjZfrc86IFXXy2aXCQ7TzoZvCrsuJioKaTDxl90jcmvyJ46S4pLrqaF0vuDsOk41Yyv1OrLosC5P9WSP/3SbdJf17oLUk+Qp8pHxbMSPFC2uXuG7l1aEmgyycbShnlRnu23UuxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5d0fdf-a652-431c-9d4f-08d880325266
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 19:54:49.3266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oq7ryBRWWCne1SNCN9e+cjTUTQE0sct3NcGz0Uop/2+4ORhyL0bMdorc+reTr070fGnKlyGUsOzMR254Hvv+Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2580
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


Am 2020-11-02 um 10:10 p.m. schrieb Ramesh Errabolu:
> [Why]
> Allow user to know number of compute units (CU) that are in use at any
> given moment.
>
> [How]
> Remove the keyword static for the method kgd_gfx_v9_get_cu_occupancy
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h   | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 1afa8f122e7d..604757a1e440 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -304,4 +304,5 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>  				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>  	.set_vm_context_page_table_base =
>  				kgd_gfx_v9_set_vm_context_page_table_base,
> +	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index e0d5110701bd..b75bf0bb05ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -799,7 +799,7 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
>   *
>   *  Reading registers referenced above involves programming GRBM appropriately
>   */
> -static void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
> +void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
>  		int *pasid_wave_cnt, int *max_waves_per_cu)
>  {
>  	int qidx;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index f098e88d3a0d..de9eca55b0ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -63,3 +63,5 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
>  
>  void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
>  			uint32_t vmid, uint64_t page_table_base);
> +void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
> +		int *pasid_wave_cnt, int *max_waves_per_cu);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
