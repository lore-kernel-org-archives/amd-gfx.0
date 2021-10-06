Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252BAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 20:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E197C6112D
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 20:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E197C6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C3E6EE7F;
	Wed,  6 Oct 2021 20:55:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80BCF6EE7F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 20:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTgXyQB4sCwAzcFu0kd5eUccMKnRsJ9d/X1bXckMFjMACDdoljK0zZ9q8oGwwFy2wHRxTJdRIUZRgFhDUv8Rc2KS9yfMBeAv/nx9Mnq/p2qwEbmFLHz117/xSNI+cCs6fcQKw4bxpunBJDOPvXtpaOMFUgP8MhJ0DW72xadeacXxHrNItUxrWPpLNt/6BSZ/pqrU6CHL6bPeWzDOO7nUaS89an3gPDigA0h5LRTMc9VxluMD+7gc8qwdT/ooZLHZIWGZ4V1qeoPBWR4vX7ok1DSpjFuYzxDnyMMi42OfO5KHypx4SK7lqbqxbDdFZbXQZmlgw3zNyVepi5tvkgZqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evtGTSpBpar32ZHOXEwMgsHMYBReLa4iKf0KsWl4E4o=;
 b=KbLDDSI88BiQ0FIHFpz/+dFwxXLb/bSWf4SjX8/279/uyd30E6VtiKTIptp/IP6kZSE+a7QsaWSc773+eD2YFfixegZrLuf2N474RbKUBAyaytSgc0o07LrZb6E0g5w7dx+kRt3e2fRj7aJgh0QrQLClkOcTxLjTOqa7julUfbTfRaM4RpYCY3okEIiT5QUpN91mWgKm86iaBXpa/UvZDZa1HLfQwLzPoJX+FgSlrUvUS3qFGF2C7T9VIAFxStOpcNWa+BPMcErGYaJ9eFej8heWxUrb4IzJl4LQNGVLGHyXTmP5JXmttuppjLy1TVqKMHT2ad+abbxwdIuhJqp6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evtGTSpBpar32ZHOXEwMgsHMYBReLa4iKf0KsWl4E4o=;
 b=C2G9CU+ESJefXEj8mD2CIbz+HMUrRIooXGiO5udR0nPDQeK1XNJH99vAbSMydmm5ZyTCxXBdLHyP3m6l8x1O/PWfX7bUeFsPjRyfw8qpbvNMWYh+HhsPLVucmUXtdqqayP34I/wyU/U+hj4HO3DjUETFjuv00+oY3vmDkL79E4U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Wed, 6 Oct
 2021 20:55:32 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2%2]) with mapi id 15.20.4566.023; Wed, 6 Oct 2021
 20:55:32 +0000
Subject: Re: [PATCH 1/4] drm/amdkfd: ratelimited svm debug messages
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211006143210.4954-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9a5d8ae9-db74-4fb0-22dc-f571c8bdb775@amd.com>
Date: Wed, 6 Oct 2021 16:55:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211006143210.4954-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::34) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT2PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Wed, 6 Oct 2021 20:55:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b83608d6-040f-42cb-821e-08d9890ba335
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31149CF59A2FA69B6C0C042792B09@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/y/ma5CKYhZYIv/ts3H70W6a+nMo0vuJbNPThg9Nhrd+Rsw6yStpkbaWJW2BqLN7kvtbg2ggKGYCWHx0k9/F2RwlM4bOMHiflh6Jer3X7uT6Cm7ruwnGsbF/68LnJGEEP2ILCdpzTXOvmDVlrG5rb9dmaRF3mSSdo13h/ia8tlL3nLIHxl8HC2MsV5paSzovR27FEwLJid0h0uGfahK+aMYvMrEqJEXaqTb0oNCCPS12klnflEP59aUaxlsOGBSnJwIrg2CWvs6bHBIqAKfvIs4+w3IEfY7rk4eSTpCM2iNVle1IRT4eJYJUwWGykD9uvz9Y24fSe2biigPLX6P/2emYMRIOQZXcnoO3lcPygDN7BxVDPZXyXOCHvDkPAKl9gUIAhbzBZXh4wpxGhaXoIbaScXFoEj9UeVNzA0xeQqs0o+IMyiqC73CxQ1LEW8DWnO+lNlgcMqSY61v6n1s+okMGb6R9ZOKQ8HCnu0O0NDx7PL3qsppCha/NjG4O2MM3HG0bVbW1NhbDAp17JC7MzuFQ5Kgm6Y42zWL/aouLUmQnvJiBh0pjnhNfGCwXXnXdkwYLuFq0+nXlwJOBdK2J9qL/JWJajo1K+OenLYDzV5vD0P9E8kcCZUHdgHqr2NzWvVV+/CFmRGIHoiZiorRRzN3JdMtIPm8nYohRYalU39/Jee3CRArb3aUh+yH3fY48ClycIFEQz50HEcm5Yey1ct9BbDUk+RKHWAWsPzr+5xR+SvDHqTwjvdUy+k7qyjJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(16576012)(38100700002)(6486002)(36756003)(83380400001)(186003)(31686004)(44832011)(2906002)(31696002)(15650500001)(66476007)(8936002)(508600001)(26005)(2616005)(86362001)(66946007)(66556008)(5660300002)(956004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkVCUjlBVHZRQkNxRUYvMjlTeUl2Z1diTjc5UXpBWXRPTW5TOE9uUDZZYzA2?=
 =?utf-8?B?RDFDeEJtaEVzR3dQTkFKYVR5ZnA2VG94MGd1L3pkb2VHaS8xUG1tVHByTmhr?=
 =?utf-8?B?UkRLQVJnQ21UVGFjV3NnQUhLSVltWC9ja29uNWhsK2VEM0xsWFg5RCszSlFy?=
 =?utf-8?B?YlpjcWNyekFsTCtxd2FhNytFdlZwRDFkOXhQcEI2cTlUbDZUdDNYUkpXYnlW?=
 =?utf-8?B?b2t4N2pubTR4d2hBYS9MUFVXanFyRExYaDZwaElodkVqbGJyWTNsUXR0aDdU?=
 =?utf-8?B?dExGc0MvalFZY1dmRFYvaSsxRkJyTDFnWitNN0VnTHNBR1ZCRmxHTUkvUEY4?=
 =?utf-8?B?U3JJZmE0L2U1dXcxcGVObUhTWHJnNC93c3kyUnNsalpqeFpveDJBbDFkdzdV?=
 =?utf-8?B?SkVoYnpTeWFOc0VLaVdpYnoySGVFaUF6NEgzamFHTjRmL3VDRm1kR0F0UHFN?=
 =?utf-8?B?VkVBVHluRTluTkVqWEF1bExNTUYxbmFsN0VBM2VxNzJnVWRaeFl5Z1kyNzVo?=
 =?utf-8?B?K3NqdXptWmZGeVBUa3pXOGorQzVpSkNDUm12dnVHQTdFN1paQnRUeHdCaWhu?=
 =?utf-8?B?Y3htRkEwUzkwRHNyM2dTeGh4Wko4ZHJXYmJwYlNTZDJBdnlmdTdZNG9wdlIv?=
 =?utf-8?B?Szdjb3hMSmdMcStXU1FLUVVTWmxRd2pDTGd4RHR0T2RSN201U1FtdS8xcHZD?=
 =?utf-8?B?bDdPQzVLWnQwTXFZTVZ3QW9JL29HdDVleDQyUDVKRzN2OXhWQVhUK2MxNzZh?=
 =?utf-8?B?RlRSdVUyV3c4djJEK2RVcFNEY3FGMWovbHI2c1V3QW1FT0dhb2dUSm4zRVpP?=
 =?utf-8?B?N2FPTkF0a2ZLdjBzZjZKL2NENGs3dkFCWHRXM2g5NGMwUUhzRkd4T2FMZzlZ?=
 =?utf-8?B?eWI3ZUVtZ05HbUZkUWp5TlFZV28vUmd4czFxSzBIQVBjK29uSnZVNThKYll3?=
 =?utf-8?B?R2ZnbDVSNFYxTWZvZDdjK2E2WXd0bkh3L2NiWlNDM0RpRVUwQVRrakIvTVIv?=
 =?utf-8?B?ZW43ZjgzYmt6Ylo5VlFVRHd0RFVBbHl1TGtsOUcvMnhZSlZrdXhYVEtvTjdH?=
 =?utf-8?B?U3Vpd284a1FwVUZKVVdrZFVqS2hYRWNVZW5vZHB6YUl0Z0JibXg1YkRMK2Rt?=
 =?utf-8?B?ZGUwSXNXRlMveERQdHZZckcybUhNZE9CMVd6MVVtZlFLOFdzeVlWNjhtSGtY?=
 =?utf-8?B?bmpvaW9pK1pTUldBaTc1UFpVa3NnNklCeGVxYWVDdHEwL2hjQkdiS0F6N2hW?=
 =?utf-8?B?YjNpNTlvZzQwOUhwUFlybW03OVU2TUhBTnBnSG90SWpiV0N0RU9QMGp4alUw?=
 =?utf-8?B?bVRTa2tHV3pITFFQTERtT1VCSDd5aWVjbDhvNjZjeERraTBodG9zUk5uZlBq?=
 =?utf-8?B?bHlrajVmZ0ZvakRzZ294ZDRZR3ROTDdMRnhQbjhPNnZaWVJmMUhxRFMyY3Va?=
 =?utf-8?B?NGNMMzJ6MWJWSGlPV0M3TmYyUDBzb3JNUi91NDNJSjU2eC92MlViY2d0M2pH?=
 =?utf-8?B?ajBVZnZlQTZNUFpUcDNwWWFzVm15Sjl3ZUdCek9SNUZzUE03eTN0NmU1UENK?=
 =?utf-8?B?NEk5YUdCVlo0R0RhS2NHOHpjeWZ0RStCeE1hYmNWRXVLUXB1NlJub1Jhazgw?=
 =?utf-8?B?YjBqVXZsVTB5elR1eXNNZHYvYVBYMCtPcEI1K3k1MWFjK3lncWx0MEpzM3lo?=
 =?utf-8?B?OEJXbjM3cVBacUZIckxhNlN4WkptZm1NUnE3SnlVL3ZVU3QrOE9lME0zUFFP?=
 =?utf-8?Q?Lwnl+1y9VDCqXDKhpjlyqt4T7YTJAcs4P70dRt+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83608d6-040f-42cb-821e-08d9890ba335
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 20:55:32.7073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpaQYJLcTFEUTHkaEHWSMaz+wCnuX4Y7p35hfIN0v7EQjeI9otJxcjnA0PFUVE4h/mdFcs3jUWaEzGFg5mUZtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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

Am 2021-10-06 um 10:32 a.m. schrieb Philip Yang:
> No function change, use pr_debug_ratelimited to avoid per page debug
> message overflowing dmesg buf and console log.
>
> use dev_err to show error message from unexpected situation, to provide
> clue to help debug without enabling dynamic debug log.

AFAIK, dev_err does not print function and line-number information. So
you probably need to provide a little more context in these messages. I
think this could be done with a

    #define pr_fmt(fmt) "kfd_migrate: " fmt

in kfd_migrate.c. I'll make a few more specific comments inline.


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 34 ++++++++++++------------
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 12 ++++-----
>  2 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f53e17a94ad8..069422337cf7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -151,14 +151,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
>  			gart_d = svm_migrate_direct_mapping_addr(adev, *vram);
>  		}
>  		if (r) {
> -			pr_debug("failed %d to create gart mapping\n", r);
> +			dev_err(adev->dev, "fail %d create gart mapping\n", r);
>  			goto out_unlock;
>  		}
>  
>  		r = amdgpu_copy_buffer(ring, gart_s, gart_d, size * PAGE_SIZE,
>  				       NULL, &next, false, true, false);
>  		if (r) {
> -			pr_debug("failed %d to copy memory\n", r);
> +			dev_err(adev->dev, "fail %d to copy memory\n", r);
>  			goto out_unlock;
>  		}
>  
> @@ -285,7 +285,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  	r = svm_range_vram_node_new(adev, prange, true);
>  	if (r) {
> -		pr_debug("failed %d get 0x%llx pages from vram\n", r, npages);
> +		dev_err(adev->dev, "fail %d get %lld vram pages\n", r, npages);

This message is misleading. svm_range_vram_node_new doesn't care about
npages. It allocates memory for the whole range or reuses an existing
allocation. So I'd drop the npages from the message.


>  		goto out;
>  	}
>  
> @@ -305,7 +305,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  					      DMA_TO_DEVICE);
>  			r = dma_mapping_error(dev, src[i]);
>  			if (r) {
> -				pr_debug("failed %d dma_map_page\n", r);
> +				dev_err(adev->dev, "fail %d dma_map_page\n", r);
>  				goto out_free_vram_pages;
>  			}
>  		} else {
> @@ -325,8 +325,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  			continue;
>  		}
>  
> -		pr_debug("dma mapping src to 0x%llx, page_to_pfn 0x%lx\n",
> -			 src[i] >> PAGE_SHIFT, page_to_pfn(spage));
> +		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
> +				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
>  
>  		if (j >= (cursor.size >> PAGE_SHIFT) - 1 && i < npages - 1) {
>  			r = svm_migrate_copy_memory_gart(adev, src + i - j,
> @@ -347,7 +347,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  out_free_vram_pages:
>  	if (r) {
> -		pr_debug("failed %d to copy memory to vram\n", r);
> +		dev_err(adev->dev, "fail %d to copy memory to vram\n", r);

I think you only get here if svm_migrate_copy_memory_gart failed. That
function already prints its own error messages, so this probably doesn't
need to be a dev_err.


>  		while (i--) {
>  			svm_migrate_put_vram_page(adev, dst[i]);
>  			migrate->dst[i] = 0;
> @@ -405,8 +405,8 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  	r = migrate_vma_setup(&migrate);
>  	if (r) {
> -		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
> -			 r, prange->svms, prange->start, prange->last);
> +		dev_err(adev->dev, "fail %d vma setup 0x%p [0x%lx 0x%lx]\n",
> +			r, prange->svms, prange->start, prange->last);
>  		goto out_free;
>  	}
>  	if (migrate.cpages != npages) {
> @@ -506,7 +506,7 @@ static void svm_migrate_page_free(struct page *page)
>  	struct svm_range_bo *svm_bo = page->zone_device_data;
>  
>  	if (svm_bo) {
> -		pr_debug("svm_bo ref left: %d\n", kref_read(&svm_bo->kref));
> +		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
>  		svm_range_bo_unref(svm_bo);
>  	}
>  }
> @@ -563,8 +563,8 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
>  		if (!dpage) {
> -			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
> -				 prange->svms, prange->start, prange->last);
> +			dev_err(adev->dev, "fail get page 0x%p [0x%lx 0x%lx]\n",
> +				prange->svms, prange->start, prange->last);

The prange->svms pointer (or its hash) is pretty meaningless in an error
message. It's OK in a debug message to correlate with other messages.
But in an error message that's always enabled, I'd prefer a more
readable ID. I think it basically stands for the process because svms is
part of the kfd_process structure.

prange->start/end are also not really meaningful for this failure. The
page allocation failure doesn't depend on the prange start and end
addresses. It's basically just an OOM error.

I think Linux will be pretty noisy about OOM errors, so we probably
don't need to add more messages about that here.


>  			r = -ENOMEM;
>  			goto out_oom;
>  		}
> @@ -572,12 +572,12 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
>  		r = dma_mapping_error(dev, dst[i]);
>  		if (r) {
> -			pr_debug("failed %d dma_map_page\n", r);
> +			dev_err(adev->dev, "fail %d dma_map_page\n", r);
>  			goto out_oom;
>  		}
>  
> -		pr_debug("dma mapping dst to 0x%llx, page_to_pfn 0x%lx\n",
> -			      dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
> +		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
> +				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>  
>  		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
>  		migrate->dst[i] |= MIGRATE_PFN_LOCKED;
> @@ -631,8 +631,8 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  	r = migrate_vma_setup(&migrate);
>  	if (r) {
> -		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
> -			 r, prange->svms, prange->start, prange->last);
> +		dev_err(adev->dev, "fail %d vma setup 0x%p [0x%lx 0x%lx]\n",
> +			r, prange->svms, prange->start, prange->last);
>  		goto out_free;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7c42a0d4e0de..7f0743fcfcc3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -158,17 +158,17 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>  				   bo_adev->vm_manager.vram_base_offset -
>  				   bo_adev->kfd.dev->pgmap.range.start;
>  			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
> -			pr_debug("vram address detected: 0x%llx\n", addr[i]);
> +			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
>  			continue;
>  		}
>  		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
>  		r = dma_mapping_error(dev, addr[i]);
>  		if (r) {
> -			pr_debug("failed %d dma_map_page\n", r);
> +			pr_err("failed %d dma_map_page\n", r);

Why not dev_err?

Regards,
  Felix


>  			return r;
>  		}
> -		pr_debug("dma mapping 0x%llx for page addr 0x%lx\n",
> -			 addr[i] >> PAGE_SHIFT, page_to_pfn(page));
> +		pr_debug_ratelimited("dma mapping 0x%llx for page addr 0x%lx\n",
> +				     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
>  	}
>  	return 0;
>  }
> @@ -217,7 +217,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>  	for (i = offset; i < offset + npages; i++) {
>  		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>  			continue;
> -		pr_debug("dma unmapping 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
> +		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
>  		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
>  		dma_addr[i] = 0;
>  	}
> @@ -1459,7 +1459,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  		/* This should never happen. actual_loc gets set by
>  		 * svm_migrate_ram_to_vram after allocating a BO.
>  		 */
> -		WARN(1, "VRAM BO missing during validation\n");
> +		WARN_ONCE(1, "VRAM BO missing during validation\n");
>  		return -EINVAL;
>  	}
>  
