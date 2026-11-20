Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730EB606A686
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iCJEokFt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1375D10E293;
	Fri, 20 Nov 2026 21:49:11 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013038.outbound.protection.outlook.com
 [40.107.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1417B10E293
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 21:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H554Yi83TnUJaINeOkCYBP2l/cipVaFQz5PeWLbotYmR3XZzyePZ4Bc+zyucxkukaGirS5TW9tMbTjw2n5MqUfgJObRpKqfBtJAnPyw+E+Sz5LN35nzQNdQnNVzCztLJyiB3hRTVVdOfVamh0QMc9z5pUvGce6B/BDh9zya5ONybpea8iAZynBo5OejggYGiFcc5vtouGvFSLzr/QljJGF42DsEkhllOLdDHoALD3z7mf3MhWwSzkPm1cYjlkJ2pDKX0V9lthh5sCKqYqSwMLEZPNAu4gjaDNLrv87gTKO8u21bf7HTLYHpcbqpuhlZ6vmGc9tasQ2pMWqUnwGsm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=donxa4Uo+ZD6HqK+ryb/cUKcmEnP4ZOn00LN85F0sDk=;
 b=tnAUCTe5V2xaBumrbrvU8O/jJlAyMqchFW0ztv99zYdp7sL1ezoUKNJlbfspNy80DGc/mtXHZOYBPgdX6Ql/DhUEJ43oaIabYHBbOROXUDXm8doTKyUCh3tTi2Wv3BVhBq6sxcmzJ/XfG+Nu1gNcB7PwDS+M6glNGsrvbGVlqj4caIxlu1Rf0Qg5HEQbs0GwErRvae+DzRS+BfAgLVMbgUz9Ami0Cxmn4lcL9sqNC5x4pYFbzNRCNdcIS8icWqSfaCrYM+yh7q81XfolmV/1r2g5wpzO3BgmaLVHF0ENvCk4H0J/j27KZQBOERrE22HoYch+Y9RlZfr/FAsdrPjr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=donxa4Uo+ZD6HqK+ryb/cUKcmEnP4ZOn00LN85F0sDk=;
 b=iCJEokFtBzlUmbsAmXGLITaFc3CbBuVjDcvYdXsLeA0F8BgfwlEnFhTalkw9Iy6mTpVUvxg8vO7Ov3jzjyDw/PotcuJ87S+K9kjtNoDQOxvxSgV2v7ZMj8THqrsi5jNf074GN97UIPkX4R+DUhC3Tfa6k5zjg93A/eIqH57bjxU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8SPRMB0063.namprd12.prod.outlook.com (2603:10b6:408:242::10)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 21:48:56 +0000
Received: from LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0]) by LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0%4]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 21:48:56 +0000
Message-ID: <303ff255-f3f7-4cd1-9af1-f2281d0412e3@amd.com>
Date: Fri, 20 Nov 2026 16:48:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: drop mmap_lock between chunks when
 faulting userptr pages
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, christian.koenig@amd.com,
 philip.yang@amd.com
References: <cover.1795014593.git.William.Palacek@amd.com>
 <06cc5e1afc886b72367d287a53caa92a1874637a.1795014593.git.William.Palacek@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <06cc5e1afc886b72367d287a53caa92a1874637a.1795014593.git.William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::29) To LV8SPRMB0063.namprd12.prod.outlook.com
 (2603:10b6:408:242::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8SPRMB0063:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 9209d017-b32a-4caa-b0f6-08df47501366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|11063799006|4143699003|261026140227099003|261022105027099003|261026121527099003|261021121427099003|261028144727099003|261021123027099003|261102123227099003|261009223027099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YH0DQuc8W9xj8gpTAQyaV4bcDvc/34MRTRBCPLhst8kFz9tiUAclY2rTHzIjqm5IeL3p1/dKtiWwjC8k+Th9OU9LcQyJKHrkhJYkI13Zj/I5bDtI5d8iWIKr6p8+PieCS7nknty2H8jyVOqBP6L9NJr7+/lcS5tFqlxG5WKnHPTQdSFvYNs2/M0aGLd+eh+nz/5kSYganT071010xi3qI7A5GO9mfLavQJce3LvLEBCNcYGyzsX4Q1o35IBKJisgwCLjvHaZV8A2ikZV+ijD6rcVwx98iWS1DDX9ZuBnN7WfTxCnASjQIurtu6Byy8UUA7nR9IYuTKSP6dwjMmCkEICqL2QN9UM505bUl7a0QAjAaqdSPWzgMN6XLag9oA1E53OvGdc350eTXYOgde0tr55ci2Z/JTb8KXB4CWrVbEpjbxct9jPO7ZNpSprfXg932XpsFj+LID5iHrPCzNKLuBBx3fe7LqYqwY0D4+CPtpQzEdXyu18cZNfMa0UyHDZIcGvpUCQ1+ok21AOUwVCUQzbXzBvqZLv+MdZIbPQZm0nuhU/kTzDOn5YIZtSAsWxOVF3AoV7cgOs6oSBKjuxPn9yA021mRSfdFZw4gzhH1MnoMGOujJLaffOHZQaU5s0I0xZG33WH9zWT5xvIW0W6pJCWuEQRndiQZ7Y6eEMmM3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(261026140227099003)(261022105027099003)(261026121527099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102123227099003)(261009223027099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXhkMU82K213bTNBMkNJRFZYVEdUTEZodW1qSUNoN1l0MWpYaEtwbGh2Mzc5?=
 =?utf-8?B?RUFxcU9LMFlIMHo2dVpuM0VDYUVZQmVpMzdmRDNydlh0TnRXa0tkamg3TnA2?=
 =?utf-8?B?bDdaTE9mZXd6eVpHTU9xVUpyRFF6SWNmcHlZNjgxbm9OeUlWczkybVVQTmRi?=
 =?utf-8?B?TlNBV09DM2NicFJxVHpJd3hHdlh1Mm1QRmpUdHBaTENOcVg5WEV5MEZ1V250?=
 =?utf-8?B?MzZzVXBrcjN5Ukd3anpJL0hjb1I3c0dmYkdIeEl6MERTeXVlS28wbWVON1NK?=
 =?utf-8?B?RXB2T2dwRHBXSXNMcmp2U0V3NWM3VE5VMTJrWGh3OGhNelZmRit2c1JCYWxa?=
 =?utf-8?B?N2pBUEllQ0cvQ2d6RlVmSHNqWm91bnpjbU1nbzIwNzRNcjJiakZ4c0w3Wm5P?=
 =?utf-8?B?R2VoOFJMNU9jeHNaV0ZXWWpIMXlhOWJLalcrQ2p2RVVKcW5mdTlhb3NPTC9V?=
 =?utf-8?B?NmVGSHpMVzMzMWw2TEYrTUt5R1BObERycTlER0lwSWVRbTFMSDhFN1FkVUxZ?=
 =?utf-8?B?dEpSS2J0c1RsZ0YveDhVajRmT3pzalJSNXRUMFNvYklyUjJ6UUFJYyszVm9z?=
 =?utf-8?B?MTZmdWRpVXpic3E1Y0FNUzMvbVU4ODBZM1o3SytZVWJaZTJDc2JyZzN5WkU5?=
 =?utf-8?B?YXRaTFVkcXhobzkzRkpVZW15Tm1hektjb2RvVExaQm9MNG45WmJtc3ZFdjhU?=
 =?utf-8?B?dE5rZEJudDRLY0tHVzR5WHp1dktrN2tqdEEweE8zWlgxYUN5S2xLY2V3a3hM?=
 =?utf-8?B?WnRMT3hTNmUrR0JNMytwTk5kSmpNLzdhK3IwZUZ0ditMMkFQQTlsK2hVdU85?=
 =?utf-8?B?RThpZU5TbTI2TVlZcnBrWC9rSWgrc3VyZENxTXNTczhoUWtPcTVtbmY3ZUZZ?=
 =?utf-8?B?aDNaeGY0NEhlWjFuVllHdFJ0anhocGYxSkZadEh3Z292UVZKYkd3Z2l5Tlpy?=
 =?utf-8?B?ajZHWFkrQXN4ZHJxazM5WG5JaFU1VzJNMlJVb25wemVMNWdWOTRucEY5cUJm?=
 =?utf-8?B?d3RGUHI2LytjMGg3ZWMxcTJEYngyNEY1NHQ1c211QXFZa3MzRkpJZWxNd0lI?=
 =?utf-8?B?N1pqeFhoeHcrNDNmSU9kZjQ3dmU3K1FzOTVCVzlqZC9Yakp4RURtWVVMdUt1?=
 =?utf-8?B?UWhHMVk3WUh5ejdpUGZZbHpiTExpUkxGVkcrbXhYSmg4dE82b2cwTWtmV0ht?=
 =?utf-8?B?UnEwQnB6blZoSS93eGdmWGhCK0loQ1NaamV3WTZHWmhvRWVIOVFaUVpnbUtP?=
 =?utf-8?B?Q0ZrazBReGF1cDZHRFpHTTBYSnMxdmptV25ZeW1BeDVwQzVyRUE5L2k5cmJ0?=
 =?utf-8?B?d1kzSDlUVjJ0K2pZblVnVm02QUp4UXVuUEQrbVE4NEVFOUJJb3EvUk1XWE1z?=
 =?utf-8?B?eEFmdGxIa0JiS2liUC9uR0VsQnpVV1NVVCswTUhac2dCZExaZ0c4OXFGYjJ1?=
 =?utf-8?B?SGlLSzJ3aGc4VWNKT08xdVAzczh4c3FtdUlxWnI2V0c2MmRMY09saDhIWUl2?=
 =?utf-8?B?UGFPV25BY2JwbU1pZFlpN2MwSjFtTjFUM0JCK0tzRVdnTFRrbmNwekQ4Zkp0?=
 =?utf-8?B?U3hHR3JrN1dxdjFxN09yT2hvbTZUd2svRlYyREQxTjFTeVRPMzBrbnk0RUJ0?=
 =?utf-8?B?UUpjeUNseW80Qnltd251akxsWmNHM0RIZm5IYmxOUlRRVlA5T0FDZysxTEFM?=
 =?utf-8?B?Z0VFakpzWll4QWllMVBXRFFKTGtVZk0zL1pPSTlaZ1ZOcWFiV1pzL0pTTWN6?=
 =?utf-8?B?bjMxNGVDOTJaVDJCdGhySFhrSFY5YXd1aFVSSUc0NWtwcVVackFyWEJRV2tR?=
 =?utf-8?B?RXdrdjdGVHZSdlg2Y3d3TktXTE92NUN1dHZLYlFrMVpkT296ak5FT0djMHVu?=
 =?utf-8?B?cXFuaU1HaDA3RGtjaG5mMnJzOGdnL243TWtta0VLckJZV3JBeUlqekZSQWxp?=
 =?utf-8?B?Z0RLWWZYYXhaTEdHTnBKMjk2RGxCZE9JOHdKQVhnbjNtT3pYdmxET3hiZlNP?=
 =?utf-8?B?dTZDcCtlTWFmbGJUWWNVaDVBeDhBRHAwOUw4V1lQS2RFYUtZT1NyVE95V0Uz?=
 =?utf-8?B?MEF0bXdLdm9OcE1PTkR3QWlJR2dOSVgvYThKMDV5WHVMSU1aWlhZb1hET01I?=
 =?utf-8?B?aHhMQWVRWkgvdlIzeDVtVzZreFBKVlFSM2l2YWl5dHh3cWVFMFYwcjlkOWs4?=
 =?utf-8?B?aFJpSUU2OWMzeWUveG8xTzN1MVl3ekp3ekNTbm9ZRTZ5U2RaNWNneWhWTDlp?=
 =?utf-8?B?VWlWVTJPL3JiT1FDQXk0eVptQlIxaUpsaTM4dW5PNWZHU2cvRklMbXVSVFVQ?=
 =?utf-8?B?c2pkanJFdzhKVmZheG1uRm1iRzYyWW91cGZiMjZWTHQ1UlRXZHpwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9209d017-b32a-4caa-b0f6-08df47501366
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 21:48:56.1249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHkSEzhvG6kekh623cNPAjdJaCzQWA4DpJGYk9xyvUA3vMmydJDcqfsoBaUKL/MNXs2s8TsK8Hak3hETlPegeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-18 10:10, William Palacek wrote:
> amdgpu_ttm_tt_get_user_pages() holds mmap_read_lock across
> hmm_range_fault() for the whole userptr range. Faulting in a 32 GiB
> range takes seconds, and every mmap_lock writer of the process (mmap,
> munmap, madvise, the KFD SVM flush at each alloc ioctl) waits that long.
>
> Fault the range in 2 MiB chunks and drop mmap_read_lock between them
> when the caller passes its mm. A change to the range while the lock is
> dropped bumps the notifier sequence, which hmm_range_fault() checks
> before each chunk and callers check before using the pages. kfd_svm
> passes NULL and keeps holding the lock across the whole range.

I agree with Christian, that this is the wrong approach. I think the 
root of the problem is that we're misusing the mmap write lock in the 
KFD SVM call, and that's the reason that those functions get stuck 
behind mmap read locks.

Another simple lever we have is max_svm_range_pages. That's currently 
clamped to 1GB in svm_range_set_max_pages. But it could be made smaller.

Regards,
   Felix


>
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 14 ++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  2 +-
>   4 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index a7d13e337d84..9f80ffaa0607 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -165,12 +165,17 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>   	bo->notifier.mm = NULL;
>   }
>   
> +/*
> + * The caller holds mmap_read_lock. If @mm is non-NULL it is dropped between
> + * 2 MiB chunks, so faulting a large range blocks mmap_lock writers for at
> + * most one chunk; the notifier sequence catches any change made meanwhile.
> + */
>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       uint64_t start, uint64_t npages, bool readonly,
> -			       void *owner,
> +			       void *owner, struct mm_struct *mm,
>   			       struct amdgpu_hmm_range *range)
>   {
> -	const u64 max_bytes = SZ_2G;
> +	const u64 max_bytes = mm ? SZ_2M : SZ_2G;
>   
>   	struct hmm_range *hmm_range = &range->hmm_range;
>   	unsigned long *pfns;
> @@ -205,6 +210,11 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   
>   		if (hmm_range->end == end)
>   			break;
> +		if (mm) {
> +			mmap_read_unlock(mm);
> +			cond_resched();
> +			mmap_read_lock(mm);
> +		}
>   		hmm_range->hmm_pfns += max_bytes >> PAGE_SHIFT;
>   		hmm_range->start = hmm_range->end;
>   	} while (hmm_range->end < end);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index 140bc9cd57b4..4d1c96ad2704 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -38,7 +38,7 @@ struct amdgpu_hmm_range {
>   
>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       uint64_t start, uint64_t npages, bool readonly,
> -			       void *owner,
> +			       void *owner, struct mm_struct *mm,
>   			       struct amdgpu_hmm_range *range);
>   
>   #if defined(CONFIG_HMM_MIRROR)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b0672f1747ee..fae845632169 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -793,7 +793,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>   
>   	readonly = amdgpu_ttm_tt_is_readonly(ttm);
>   	r = amdgpu_hmm_range_get_pages(&bo->notifier, start, ttm->num_pages,
> -				       readonly, NULL, range);
> +				       readonly, NULL, mm, range);
>   out_unlock:
>   	mmap_read_unlock(mm);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3f32507e2aae..8d7de7bb39e0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1892,7 +1892,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			range = amdgpu_hmm_range_alloc(NULL);
>   			if (likely(range))
>   				r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> -							       readonly, owner, range);
> +							       readonly, owner, NULL, range);
>   			else
>   				r = -ENOMEM;
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
