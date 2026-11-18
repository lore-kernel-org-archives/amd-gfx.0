Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF390606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E6TpjAVE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 454511120C0;
	Wed, 18 Nov 2026 23:29:46 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC471120E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 23:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/5Id3NPD3bG0D02ijJ5+lYimXDXtWCiNpl7jQHuGKpC/F7htcD2xUtoKA/HcpOvsPgSREWnvfYtAxm3ra7pvvRQJ/KT8iCEkP2U11IbssnvBMuBSVZ5b8LI/d6BmPioT4AfDgwOXfg6D29ne+IOrfLXjarYTtfxCm3Rf6iMeRJ3dqZ7Y8dMmLL1A0amcbRiEKlmKQYyowRl2TyYdL0zcN4QMQhO5CnjEht0XUXCfLsWwzoelNTNMmGczNrVYbaWBIw3jYKWygZpefjy9N7v4GSI2gppxrUhSrY2nmPHnaWbJJB/3LkN1owX2FT+8hTRUjVdit2yk0WbsuAAZZShfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSIeM8PhTb6PYjM+5xPVZPAPeMucZsaHJqTBPxDSYMg=;
 b=Nh1n97G77QwOUrd//u7DE2taouRs+OThHIK9T5whUmqL5GxxWT4zE7LDY5BE2zL34f5ELaWiUt4Kz1XokHlysBsUpMdMO5WNpgJLOm4TPER7PEhbQMO+1kKtgG5MZgszofcbLAJ5ZVKOYFb811PQ9Kl7Sf2ezmY0i3xkNGcGATOgJTlrkbP1qR60LWS3C3zDd+bdWa4hzj6kwpg7+yBOJsrblXqkm9xKSp/Vxo7dYLUxy6xy2Wvgk+zCk+6BOQq6YnV+at96XgXnwUVQLw5QkYqYhBoOXZ0/RGZV6jynnnqjOa05q0d2kqvl5S9fz8i03nkoQlzDa5kPf9rFNMd6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSIeM8PhTb6PYjM+5xPVZPAPeMucZsaHJqTBPxDSYMg=;
 b=E6TpjAVEUbX7obYTkP2Pv5cWBnGTpIsNzTOx0TYwiR682hmn5VksXLHQUijmLHuJl+UDkbrb6dfTpBKyD99gzU91BaDjGYNmc7IAI+lBwjyaxuEdTVsucHllx8zWmPCvfyrvwQ61AEiiYg7xDvTwv4lsT0xboD0O7QHbL+05OcI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SAWPR12MB999267.namprd12.prod.outlook.com (2603:10b6:806:55f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 23:29:36 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 23:29:36 +0000
Content-Type: multipart/alternative;
 boundary="------------9gawDneGKByttYbGalU3gIqm"
Message-ID: <08da11e7-0a59-4fa1-b89e-25bf1a375df1@amd.com>
Date: Wed, 18 Nov 2026 18:29:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdkfd: Swap order of svm_range_dma_unmap_dev
 and migrate_vma_finalize
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261118225834.60743-1-xiaogang.chen@amd.com>
 <20261118225834.60743-2-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261118225834.60743-2-xiaogang.chen@amd.com>
X-ClientProxiedBy: YQZPR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::29) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SAWPR12MB999267:EE_
X-MS-Office365-Filtering-Correlation-Id: cce7877b-2243-466e-c818-08df45cbceda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261026140227099003|261026121527099003|261028144727099003|11063799006|261022075727099003|261021121427099003|261021123027099003|261022105027099003|4143699003|5023799004|56012099006|10067099003|18002099003|22082099003|261009223027099003|8096899003;
X-Microsoft-Antispam-Message-Info: +3d3dSUhxlpTsTCzqpw4UKYpsC9F+TC8F7jlCpdxdIWcJxOR1sHjdyLuMeGfQlu99ifabjSmw7hmDeTTZ4HP7GRKrjkErEWN/33/pzJGg83hh+aI06eTJKN0j42OTIuLndRwqtppAL6yjWaTx6rri7L6RZKarqIa2QCbjdL61BF3YvuFsgF/1Hwn58hQLCRni1Gt3N6rfJlalfzfKGdq5EtlQeUM/E5T1afSVyiYCMBQuWsjrnJgwYTLIGk58dhTeHBe4mqnlpr/f7Mi/YLPBM5iKQKysA8KQB8HR+3nbhwZepfpHfO7WAbCO0Em1ojhSoAV/mXPGgKeokCSjYzF/5H8elBTmyiiFauwFYOC0Oz4GxMXE7A/6zNWm/28WSTRy4rcAhZCZeYxnGWMObd8jlhiMeLvNNqR4FN5HNpjXTuBzyu4mY7E/2P3LMZl8gR026wnGLYpiMQwlukwGgXYsFSh+aK7HNPIBWaqnOMzGFiHfqqFsgBY9XiCg9Vh0mjL5pJb0Q5xXC0Gx6IkPXAjSV+/qzugcNQZn8DXCSIkHUk4OLqNMpRryq2++pUXk7V8OspvPa/GGLRkjsg/eRMmD/bAcd4usYi5OqjWgxKeS7yT3jABmNOZEtwhPO7I4Ko4GHhFU+FFqmo4xLKTH2z0+e82DaR2y9EoiJUwu4i9Iyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(4143699003)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTlFaUVsUVNudGU1dG8wVnhXQ09jS2hpU3kxSGZvcjFkdUpJbFpsdlVrbENW?=
 =?utf-8?B?aU9NQ0xIZGZMR1pCdkpybmJzek9SSElTTnBwVHM2ajRHMlE5a0xJOVljUUlx?=
 =?utf-8?B?dmdCbjI0azkycjdZdFhQZ1RsUzBTaDVhZzF1QUg3WkhzZytvQmxxZENjVzJH?=
 =?utf-8?B?TWFqQjBYMHhUT0wvR09hRlNUb2JMVG5tTmtSdVN3ZGlVQ1JHMFcwUlNwT3dw?=
 =?utf-8?B?R3djczhSVGFwMEFFdWN6dDgwZEZ1bGo2WVBqUWJDeTBDWUxFeWo3V0pLeEZ6?=
 =?utf-8?B?QjN6MmZBY0hHcm85MFlsemw1ZG54OFllVFJBVVNWSkFFR1FxRnh1QXVLTzcw?=
 =?utf-8?B?QmYzcHNiUURpeHBZNWNlN1VQWm00TnZselJqMkRubURKRGhhWTJwL0pwRWIr?=
 =?utf-8?B?ak14c1BtY2E2bm9aRjY5VFgvWHVJd3RObUk2cFNDeHZna3ZZL0RxVWZFSms4?=
 =?utf-8?B?cEg2dnRicXk1ZUZra21lcUcwb1pHclZwYktsQjRPRXBIdmRJQ2VIQlRjZHNt?=
 =?utf-8?B?dXZSREIxTmhRRlBRY1BYSXBpWTN3aWJCVE1XYVJSL3ZWSmk3Y2NTL3JURFEr?=
 =?utf-8?B?TjlYUUllSHBONHI1K01TOVltZ2hWckRyczgyNzhQOE9QMVNhWGoyY0laa2xJ?=
 =?utf-8?B?SW5UbVdQd1lhOUoxUnhSQmNvbHdGRFpGOEpMUmdVMFE4ZUVoQWRXK3I2aS9z?=
 =?utf-8?B?ZWgvNGZxZTF3MUJGQ1Z6dHJFRjBOcnVyZlJyQmNVY1p2Q01TVjVnTm9CcDRE?=
 =?utf-8?B?U3dXbnlVeFhvb3o1b0ZlcDRwUHc5ejlVQldHMVhmT3JvNzZBRFJlMmRPcGJN?=
 =?utf-8?B?djhRMHVDS2Zid2J1dFlGRnd2Z3BmcitSYmQ5ZHJIQ2grOFptZlAxMDJQcUh6?=
 =?utf-8?B?aC82MlhyS01aNUVodU9tQWtzREpOL2taTjZLTW82Z3pzRlRmc3BGN1NjYTNE?=
 =?utf-8?B?QUw4c3pzOWc4VzdERjB6NUNCbWwrcUdVUHlUbUp4UUlMTHVWalp3K1lvS2d0?=
 =?utf-8?B?eElNVFlwK3A2MXFoK1ZHaGlCaEEyNHpSdDhhMUZrRkhqN21qTVczNHJJS1lH?=
 =?utf-8?B?WG8xS0w5L0VhNmNnZHhoZTRMdWpnUXpBN3ZROVRDZVA4cVhOR1RiL3F3UHUz?=
 =?utf-8?B?bC9EbWl2MzhrU3ZhTnpodjRCd0FiZUcvaStuWllqeGl0WUJTZVYwUy9tTWM4?=
 =?utf-8?B?NjE1MU5URXpuR3IvcVFYYWlDcnU5ZldXZW5ZOVh3b3ZTWDJvQklRZ0M1d0RV?=
 =?utf-8?B?bmg0ZndoVU9ZWGRFU3Yzd3VURDZDRXdjOHRCVERTNGdyYWdJMG44VVIvWW1M?=
 =?utf-8?B?RVhoWGYrSnRMVHZsdFlZWFBTQWRKa05BVVZaQ01qWHF5TGt0b2FXZ3crbXdC?=
 =?utf-8?B?US8rYkd0K0VvVU00Sm9JMzVoS0FtQ0RsMGlDcitVbW92bkVud3Z4OTlJYjdX?=
 =?utf-8?B?R21saWw2QVdMZ2tnVXRTMzA4WkVBRzFKSlJOMnZ4amlzYmpCcDdTSndvMlQx?=
 =?utf-8?B?MzBxNDBjM3dpVi9WTVZSK2ZjbG9sTVYzTXJuOG5lSDM4M3BuTjM5UjkwMEpL?=
 =?utf-8?B?dm5UYjBSRWx1RTRoZnk4T01BNXFrdXNBVGZuZWtYVTRpMU96K3AydTlzQ0VP?=
 =?utf-8?B?ZzdyVDlNbXpEdkpwYUtHNFRBQk0rd1Y2Nmp2bzNBQkVkeWZ3RVZ5R0lFME1z?=
 =?utf-8?B?d0MzVFJEdzI4Vy9KRXNEangydjcwem9mZDhYNEVYMnJlakY2OXZxMDA4WnF5?=
 =?utf-8?B?WWJFLzduRmM3VTlXYytKU21ldW5ESkFtV2h3QloyYys1cjR2UGVPUzFmWDRs?=
 =?utf-8?B?azJpYlk1S3NaUCtmSW5VQmxqa3lNWTZBRjFvT3daS0RneGZ5d211WndVTWgv?=
 =?utf-8?B?N0hlVkREek5lQUhjTmVmZlA2cTBzcGJ2RlV6R2FYb09vWmdWaklSMSs1VCtB?=
 =?utf-8?B?dWRyK0M0SWx5UmtxZDNHSDlOVEJSZHJkQWExeUxPb1BMdmdJS2NKelZWUWZw?=
 =?utf-8?B?NExDNlNiWUVWamR4dkM3OE1hWUpySW9JdFJlMHI2Z3JLNWI0RTVPYlROOFA3?=
 =?utf-8?B?ZldHcW9DRmhXWFg5akZiTC8raUxXM2FhT0FWUE1XRHNmeWRFVjhFV0FMSlhv?=
 =?utf-8?B?eWNjajBrM1o3SFozVCtjUnBzSVBjeStHOHVNMlR4Z09VZllDRWhQTlo3am14?=
 =?utf-8?B?N2xYNWZQSWd3NE9MQjAxRGpSbkRoSnpxNEx5aUVYTW5QQUdMN05iR2c4U1Vi?=
 =?utf-8?B?T29xUjRkOWNPRk5nRE1lSnFrWUMrZGNpcFEvd2crQUpvVFlELzJ6Si9DaGZo?=
 =?utf-8?Q?c0yYONMNuTWqwy/eMJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce7877b-2243-466e-c818-08df45cbceda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:29:36.3534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u27YjHPeoF+N9p8/0OA4XnH5nC7qYhmlkr0wO9mGtlYIK8JhWKIDBrdd1vO2jp93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999267
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------9gawDneGKByttYbGalU3gIqm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-11-18 17:58, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> svm_migrate_vma_to_vram() on success: migrate_vma_finalize() releases the old
> system-RAM source pages. Only after that they are DMA-unmapped.
>
> svm_migrate_vma_to_ram() for slots that failed to migrate: finalize frees the
> newly allocated dpages, and the unmap comes afterwards.
>
> Every mapping uses DMA_BIDIRECTIONAL. With swiotlb, that kind of unmap copies
> the bounce buffer back into the original page, and by wthen the page may belong
> to someone else. With an IOMMU, the IOVA stays valid for a short window after
> the page is freed. During the window GPU may write into the pages that may
> belong to someone else.
>
> So, swap svm_range_dma_unmap_dev and migrate_vma_finalize at both migration
> direction to make dma unmap happen before sys ram pages got released.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 9254d64588f0..6f1e2a68b3c1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -494,14 +494,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	migrate_vma_pages(&migrate);
>   
>   	svm_migrate_copy_done(adev, mfence);
> +	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>   	migrate_vma_finalize(&migrate);
>   
>   	mpages = svm_migrate_successful_pages(&migrate);
>   	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>   		 mpages, cpages, migrate.npages);
>   
> -	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
> -
>   out_free:
>   	kvfree(buf);
>   	kfd_smi_event_migration_end(node, p->lead_thread,
> @@ -835,12 +834,12 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	mpages = svm_migrate_successful_pages(&migrate);
>   	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>   		 mpages, cpages, migrate.npages);
> -	if (!r)
> -		svm_migrate_copy_done(adev, mfence);
> -	migrate_vma_finalize(&migrate);
>   
> -	if (!r)
> +	if (!r) {
> +		svm_migrate_copy_done(adev, mfence);
>   		svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
> +	}
> +	migrate_vma_finalize(&migrate);
You could swap patches 1 and 2 to avoid modifying the same code twice. 
Either way, the patch series is:

Reviewed-by: Philip Yang <philip.yang@amd.com>
>   
>   out_free:
>   	kvfree(buf);

--------------9gawDneGKByttYbGalU3gIqm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-18 17:58, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261118225834.60743-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

svm_migrate_vma_to_vram() on success: migrate_vma_finalize() releases the old
system-RAM source pages. Only after that they are DMA-unmapped.

svm_migrate_vma_to_ram() for slots that failed to migrate: finalize frees the
newly allocated dpages, and the unmap comes afterwards.

Every mapping uses DMA_BIDIRECTIONAL. With swiotlb, that kind of unmap copies
the bounce buffer back into the original page, and by wthen the page may belong
to someone else. With an IOMMU, the IOVA stays valid for a short window after
the page is freed. During the window GPU may write into the pages that may
belong to someone else.

So, swap svm_range_dma_unmap_dev and migrate_vma_finalize at both migration
direction to make dma unmap happen before sys ram pages got released.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 9254d64588f0..6f1e2a68b3c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -494,14 +494,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	migrate_vma_pages(&amp;migrate);
 
 	svm_migrate_copy_done(adev, mfence);
+	svm_range_dma_unmap_dev(adev-&gt;dev, scratch, 0, npages);
 	migrate_vma_finalize(&amp;migrate);
 
 	mpages = svm_migrate_successful_pages(&amp;migrate);
 	pr_debug(&quot;migrated/collected/requested 0x%lx/0x%lx/0x%lx\n&quot;,
 		 mpages, cpages, migrate.npages);
 
-	svm_range_dma_unmap_dev(adev-&gt;dev, scratch, 0, npages);
-
 out_free:
 	kvfree(buf);
 	kfd_smi_event_migration_end(node, p-&gt;lead_thread,
@@ -835,12 +834,12 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	mpages = svm_migrate_successful_pages(&amp;migrate);
 	pr_debug(&quot;migrated/collected/requested 0x%lx/0x%lx/0x%lx\n&quot;,
 		 mpages, cpages, migrate.npages);
-	if (!r)
-		svm_migrate_copy_done(adev, mfence);
-	migrate_vma_finalize(&amp;migrate);
 
-	if (!r)
+	if (!r) {
+		svm_migrate_copy_done(adev, mfence);
 		svm_range_dma_unmap_dev(adev-&gt;dev, scratch, 0, npages);
+	}
+	migrate_vma_finalize(&amp;migrate);</pre>
    </blockquote>
    You could swap patches 1 and 2 to avoid modifying the same code
    twice. Either way, the patch series is:<br>
    <br>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>&nbsp;
    <blockquote type="cite" cite="mid:20261118225834.60743-2-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
 out_free:
 	kvfree(buf);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------9gawDneGKByttYbGalU3gIqm--
