Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C851FC07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1F4600D1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1F4600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD396E40A;
	Wed, 14 Jul 2021 15:22:41 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65076E40A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbwSks8+Th/fzJRZx7oOLfeODO+GzK9t7rHu8CIpbaB+J3JY0cINs8dGLFPaEFDtyKLbdqLpO/OA4VuBIkxAAlJaX+omX79Iui9cmG619hpGMog77KRt+RxtgDeNy3uQErY9TKCVJiJsGfdd+mXjmqLGXKCl7lY4tp3JgCds9UAU5roMq7fMoTeIoCThPrbnXQBMtVqmN/ugq2VT3/IyQ6Vv60sDbOkoCaFqHlyK7mUtTwvsTlNWSUq6zUw4dWRKsrwyZjuZs2K6K/2jHXfUFK2scfCoX9l51ImTLrNrELimKYGoUbp47uoL1pmCckQh7lOXOKVpUVtZZlk7EOMkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTUch4Mdimlzupy5oLdeA5sqjYzfJ/bPV12PjhOtk6M=;
 b=L31Arcw2ZVh6XPnIFkv2aNcNtES6wRvlnDsS9tlHVc+Ee2+fJG1E1i4rdPiGzEUevOVZqc8mUZZaUGX5SvTiYSANdYt8P6GkTlzAswI6pODaIlSOT8KZuU4bwiJ9SLS1RFj17z4mLxZzSEh7ONVI767nUs5AjFJlEoR5X3QIOow4psOsVigZGTsQvbmKdUEAf9esro5723JbjNAuyZySMhOUHPacxoTYdW3uFRFuw45aoUZpzITJH+5QZLlGL7e6Dfw/Pcs5tjud/YVY/zuKTE/FpG7/t2ZMbsAvn8pKMeSqytuzJO4JmVjYfsNKMa6zcp0y+1QmtKC2OSCjrjId8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTUch4Mdimlzupy5oLdeA5sqjYzfJ/bPV12PjhOtk6M=;
 b=VSO8kQHs3Ed60vLkVLegZO8HvqP0vaKvWi3EUGTip61whd24U/ok9dnF0nykyld53wo5lUdxPrUuBFwm5/D7hPDz9CeO6oy25SNYenMJGDe6x99JqlDzJk4rPg/t+1DSj0LAov/Q17cGyJYJXVkdO029wgdfITKy3XxDzGsKjhk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 15:22:38 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561%4]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 15:22:38 +0000
Subject: Re: [PATCH] drm/amdkfd: Only apply heavy-weight TLB flush on Aldebaran
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210708195333.322119-1-jinhuieric.huang@amd.com>
 <CY4PR12MB128747CFF7E872B1170AF60CF1189@CY4PR12MB1287.namprd12.prod.outlook.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <401e0e0b-2f44-0eb4-e8fa-e61cb3598d03@amd.com>
Date: Wed, 14 Jul 2021 11:22:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CY4PR12MB128747CFF7E872B1170AF60CF1189@CY4PR12MB1287.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::31) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:890e:34c4:757:cc76]
 (2607:9880:2048:122:890e:34c4:757:cc76) by
 YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 15:22:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 538082da-ad07-4186-150c-08d946db36a0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52381A53EBF53D950572DAC682139@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPMdGg0WCUI3uLliDsn8cAX5V1GervwwHO7ZO1E3+dytwlULB83Of2O8+kE9peh3KAzZfsQrB9l58C9z2MlUu5nnVs7YZRZx6xiEEoZJU46LZe+SouLFc8t42q/13oWq+kyPQSQCfuk/KdaN7WyjDZUrV9x7pDtc3Xb263UgLYFR0FgBShtSxBhUIroNG91rjuS364oA3oye0jEHro+T0ugmKQJAY5rCWGrd6qAbHejzfs1RZ5d7j/7aydJKHxDeyBAaiI6s5oJAzPJVjfBg/ttpjUZIsSYOmgMMSUtIyDpx35lqAuB7jxWTpHQ6JyBK8TNNhXr/1fbClvsLAvNnKEybAkBIMvDmY7deb0GQfy8L5pUj8SaXL0YoiOhLt9WHr674jM+ahDg/1fpZ8qo2mKGpTi7+xrJcaeJca8qCBRHeLJKdDz3UY3Emd4R3BhaPPMfPv1HKSXvdwQBe/HBXdwMeC0lb5khUCLBuaEDvV/eAFWXerIEzJv2+pSb8+zUBAusmuv1RvzqSF13kmwS7z0rkQfNU9g9SKTFw+MoAjUUZ/MgU3E8oiMTzDY/bqCM2ZR+oMT+jY6xmG5iGFrLlCmImbdJXB6zoqQmXncTXkaz/bU2KRe6EX+LPZfjfpMNaayQLNtnmV0kdnElXUdcdI+6RPHkxz+aoznBVFa7yzQ6DBNozgRX3WD+89khkw4lwrXENYWKGhHOW7XLkrOussLvwncaLg+ypBDfqWgnOzQOs+3avWv12HWJjUiyp1SJO2aVga7ZcakQolrxxRac/PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(316002)(110136005)(86362001)(36756003)(45080400002)(2906002)(2616005)(186003)(83380400001)(66556008)(66476007)(8936002)(8676002)(66946007)(53546011)(6486002)(31696002)(31686004)(38100700002)(966005)(5660300002)(478600001)(4326008)(16393002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SExORHhjYXM2N2JTcjFCVmRpT3RmOTd3b3k1dU5HSCtVOFNRNHVVTU9LNEdX?=
 =?utf-8?B?UERpbUhUaThaNzJhYTNLTVZROGpxRTNLRHc5bHpTQjZWNVJaQVVmSW5WckNC?=
 =?utf-8?B?QXhCeVB6QWl5bkEzb0Zyemk2YzkvWTE4anpTckpTdFpob1R6b3BwMlMzODZI?=
 =?utf-8?B?ZDlkZ2ZaVjQyaU5PZkdBWVVPN3FSRDVsMmdkaDlUa29IQnVHOTdQWTViNGdq?=
 =?utf-8?B?S3E5TUtDVUdWV0p5YmV5anFrZWZucmt5M0NIU21LWlJ6cmN6V1gwbHYyL0hj?=
 =?utf-8?B?azJzWkJYL01YUURJSEhPTzVSbXgxdHlDQi96UE1ZVEoyK1ViR0pXdHdldXdY?=
 =?utf-8?B?TjNWbXpMOEJ5SG1yUndBYjU1WGNpTmIwRUFsZGJpNzl4SzNYQ2RxQU95S0lt?=
 =?utf-8?B?SnNVMzViVnBUZUQ5c2ZoN3ZlU1BaYTVFdHhXVS9IVWpPbUk0SytGWGFOdnQ0?=
 =?utf-8?B?enorV01uTzhzbmhmSitWUERJRHdiUU80RDNlM0dwdThuVjdmajZYQWR1QmZX?=
 =?utf-8?B?Uit3cDNxb1luTTFwVklGWktVRW00YjFVSjU5Vkc5bVRtTkI4SitHTTQ1Y3Fv?=
 =?utf-8?B?QUFFdVl2T3lVeU5rYU1xZVEyS2tzbnhwUVF1MTd6K3lMZUtTWmthTDBZZUJN?=
 =?utf-8?B?WGl3L2JvODRmQy9zbWZXckhIbXkySjR3eDhaY2NYc09NSXlTTUJHWmxvWEo1?=
 =?utf-8?B?WFhNWCtuLzdGNHFVWkpZR0hRRGZDdk5nZGdDTXJSSVpGMWZNd2VodzZHd0g3?=
 =?utf-8?B?K0tTZDVDUnVod25HS1VKVVVCNzlLK0RZeDRFSFh2SnNabVRFUXFJN0ZXbjBn?=
 =?utf-8?B?OGlzQWhEZUtIVEQ0ZFRMSWpJeVdVeEI2aVR2WGFCMWZhazc1c0o4V2pZQnNX?=
 =?utf-8?B?YzM0eit5eWFiTnVBNG1Jenc4Q0J4QW8yQWJYZHdEMGRZNDN0Ym04NjJzQ2NP?=
 =?utf-8?B?NnZtR0N1aVBBek1lK1ZJNDA0VC9ML0FuMnNFNGZ4RWY5YWFhS0M0MmJvSmhB?=
 =?utf-8?B?VGZLa0V1QlFMY1U3ejBMRHFGaXZuUmgveFBRN1RYU0d6YUhqM2tLbjNweGE0?=
 =?utf-8?B?NUt2cVRjMWlSeWxOWVEvYUFLTzJGeWJJa25jQytFMENlK1FYTm15TUtTZHdT?=
 =?utf-8?B?cGJ4MmtiTjhYdHI5ZUJVYll3L2owdlhwY2RmeGhsQ3g5UU1YKzlGV0RCUEVv?=
 =?utf-8?B?SGt5NyttVEVrb0p4SzBWQ2pYSWoyOWRWWmFRY1o1N0t2NzBzMHlKUjNYaUp0?=
 =?utf-8?B?QjFKSUhsN01VVXlHRWtaalJCM1NEcytJRnYwdUczVjlpeElwYmhxUjZZWmwx?=
 =?utf-8?B?S2lzbVQxclY4MjQrUDliRmxFVjBERUpjb1JnU1ViN1kvWWd5N0FXZnhqYlNJ?=
 =?utf-8?B?TGI5QWdJLzR4RTlqaCttK1lEbEI0VUo3RkE2NkhYd3UreXRHNGxKTk43bitB?=
 =?utf-8?B?VU9TakxpZTVaNjUxTDA0aXgvVUhmZVB2OUUvOEszd2Q2U2xrbEdlY1ZSUHBE?=
 =?utf-8?B?Ym1PTUZOWEFhVzFEaFJaTU5pdUhRRWZlSnpnY3pjdWQ1eEtabFQ4VFY1MGMr?=
 =?utf-8?B?NVcvRVlRSEg3d3VITG1lOXoycTdmRUQrYW9reGI5WWJrVFFVZks2ZHl6NS9q?=
 =?utf-8?B?d1l4anRnN1E2eHRNWGR4S0RSL3FReXhyOWNJd3VYWFRYZHRiT3ZCMXM3RkhU?=
 =?utf-8?B?bU1EbldCdkluZzkyNFl5ZFdOUG5TL081UW5DTnZPeWRjT2pxck1wS1RIRHlr?=
 =?utf-8?B?UCtRTzd5aDVzYzJkRnVWMGJVbUdhUXVJWm1vdXo3T2YwWmxtRUc5emhPUlRo?=
 =?utf-8?B?Q1VNbDJNQXJUK3FmWll4bTI3QXZmYW9pSlpIREFuU1hDWEltYjEybXprRy82?=
 =?utf-8?Q?GrNv7fpqtdW7R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538082da-ad07-4186-150c-08d946db36a0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:22:37.9551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVcheMtJmsw5p1arPDd1p4v/4VZFt5akSaQuSKuutakUmAg9F0aQD7JgICg49BdsDmu6/Utt/AZs7ALy6hFCtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix,

I was not able to reproduce the VM fault issue of SWDEV-249241, which is 
the only regression reported on MI200. So the patch is valid to review. 
Please take a look.

Thanks,
Eric

On 2021-07-09 1:45 a.m., Chen, Guchun wrote:
> [Public]
>
> Original patch will cause regressions on Aldebaran as well, so this workaround is still invalid.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Huang
> Sent: Friday, July 9, 2021 3:54 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: [PATCH] drm/amdkfd: Only apply heavy-weight TLB flush on Aldebaran
>
> It is to workaround HW bug on other Asics and based on reverting two commits:
>    drm/amdkfd: Add heavy-weight TLB flush after unmapping
>    drm/amdkfd: Add memory sync before TLB flush on unmap
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 37 +++++++++++++-----------
>   1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index ebb4872c5a9d..5f2655cf0162 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1773,26 +1773,29 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   	}
>   	mutex_unlock(&p->mutex);
>   
> -	err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd, (struct kgd_mem *) mem, true);
> -	if (err) {
> -		pr_debug("Sync memory failed, wait interrupted by user signal\n");
> -		goto sync_memory_failed;
> -	}
> +	if (dev->device_info->asic_family == CHIP_ALDEBARAN) {
> +		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd,
> +				(struct kgd_mem *) mem, true);
>   
> -	/* Flush TLBs after waiting for the page table updates to complete */
> -	for (i = 0; i < args->n_devices; i++) {
> -		peer = kfd_device_by_id(devices_arr[i]);
> -		if (WARN_ON_ONCE(!peer))
> -			continue;
> -		peer_pdd = kfd_get_process_device_data(peer, p);
> -		if (WARN_ON_ONCE(!peer_pdd))
> -			continue;
> -		if (!amdgpu_read_lock(peer->ddev, true)) {
> -			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
> -			amdgpu_read_unlock(peer->ddev);
> +		if (err) {
> +			pr_debug("Sync memory failed, wait interrupted by user signal\n");
> +			goto sync_memory_failed;
>   		}
> -	}
>   
> +		/* Flush TLBs after waiting for the page table updates to complete */
> +		for (i = 0; i < args->n_devices; i++) {
> +			peer = kfd_device_by_id(devices_arr[i]);
> +			if (WARN_ON_ONCE(!peer))
> +				continue;
> +			peer_pdd = kfd_get_process_device_data(peer, p);
> +			if (WARN_ON_ONCE(!peer_pdd))
> +				continue;
> +			if (!amdgpu_read_lock(peer->ddev, true)) {
> +				kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
> +				amdgpu_read_unlock(peer->ddev);
> +			}
> +		}
> +	}
>   	kfree(devices_arr);
>   
>   	return 0;
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C69113cf367eb450a8f8808d9424a23fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637613708477013366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=0ESYvG5kCSJaFT9dR4jW5VacL8x7TghGw1aKWTRa9R4%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
