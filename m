Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1553606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5XeeeFv1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6990C10EB01;
	Fri, 27 Nov 2026 23:23:23 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E7710EAFC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 23:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI1DMAoCpMbfKUBz5CbGaQHrL8cHowtsYrWoshEnmX0rgfsxS3wiXk+z93/t4q+x3hJbq+r9f02jLJtmcKwc5PTqaHiINS7LHzH/AiNxfpGgNdzJoZxVVKp1IUsp0FBG+0RbLIIXY3osJiCo1kxBDvmC9CEVyT+3DIv9IZoU5z/nj7nUn8/baBW84q5H59FzWN8Di5CWg6buiEMu7MkNmVGpKP0sZWDDkh/lW86ybHU7CQnu+j/FRkr2tzhwMQDh5afhaPs1O+sKB7xvKM7EA0MUTReGIKlX2xwaKV0Rf9gOjkxWQfInPitJHTtXI5RsBG5nhFpv26tnPXAAVoll0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOlnQ6LUOp++nczHms4V693Bobyy4KCxw7ZxagaTyfM=;
 b=mvET39BLio8byYKlEO1tsDfA4/JS5Ty/oIXJPF2c192zKeQ2aHDYVm03/k29EO5kkSfI1Vddqsf7ba8kUmX4mDSYYdWoD0yZLioADK97NrlHStMIzmLkDJ09O6YUHxKmAobCH9Y4bt9S6kXB16z3wh79aKPNdo2vmFllSdW/ApLRYUQsXDGPl42ydzah5TfcLZw4FiCbZ6J4FklA2u7fzav6vFg/mGjSsLdMpYiULlALasUqX1C98rsIS2HDaDBF7rFEtGJZ+WRAfU+zR9IUPmSttjwCwjr7a1NXhJ1JC7NXWWmlXLTmYAZzVYFWDrdRi3W0bltkCzKQZhXbwwUuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOlnQ6LUOp++nczHms4V693Bobyy4KCxw7ZxagaTyfM=;
 b=5XeeeFv1efm01w95VKr3vP+jLCfbQRkPTVe9jqc1hrIO9VgJHGChVMb9/NevQeuAajPKu3zLPYFvrHtgT+VnfG0ARurIMFYPXR1Tr6rXEjpsO35smYbjEKEsPMphde2cB8ylS1MfF8DIjOCxh29kRonk5UOFn9JvOpWXFUGJfTc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by DS3PR12MB999217.namprd12.prod.outlook.com (2603:10b6:8:390::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 23:23:15 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 23:23:14 +0000
Content-Type: multipart/alternative;
 boundary="------------Mlf5wVxRGfSPFfhivwAl0nvG"
Message-ID: <86c43618-773e-4715-9afb-8e6603867294@amd.com>
Date: Fri, 27 Nov 2026 18:23:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdkfd: Enable HMM device-private THP
 migration in KFD SVM driver
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261122202653.274580-1-xiaogang.chen@amd.com>
 <20261122202653.274580-4-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261122202653.274580-4-xiaogang.chen@amd.com>
X-ClientProxiedBy: YT4P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::26) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|DS3PR12MB999217:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a323a66-178a-431c-d562-08df4cdd6900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|11063799006|5023799004|4143699003|6133799003|261009223027099003|22082099003|18002099003|8096899003|10067099003|56012099006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: fO4ultYAHvW1B+WuSrvzy8QeGsQcj+1pq3N7fm3k7d8vVFpcFVIGnnT9gLwIwxVvM3RkBARXvZTJk6sr71DfrCBYrc3sC9Xc3uUYnJhItSOdCwBfVUmjWWiJcWKFcTpcG+TwU1buzFA146P6yuSnkPSMynT6gKYb9fRtTo2gp2mlgtRyoF6EerKe2tFKSq79qtubP86HVAo8UG25pxchoaNuozyAmqiH31B2i8GDVT+dRd7I68+zAs55qnKaxDFjOKRaxvLqnWbeHKh1AsqWWqHaHFPWnkbhqoG59Y2iIQPGNnnSs19fDi4Vo+jfOX/Ztw6V1gQ9VfcRncrGTbZv2A3EhDyaJCNTfyC2nCaH7nWt0OwOkrA7uUr7JASjmV/YaA8flcXZM2P0gc2qikmrNP6XLuqBSW/M6r1qJGOTu22X0s+I3tvSOFe/Vd5w+wRy4smJaDx9RGmkf12PwMaaC81gd3OojOd7BWPycpceNwqxU2D8RxETWgMVCacPYwpquDvx/ZdA5o/IlixSCIwGm9uT1yWA+nO3RB/yRDpC58oCxYUW5ItuJf3eB2ydAYlLVQsnDW06S1nHiz8EolmwN3rZg8N3KSNNYUD+7HTlk88pSzrszs41/DYwO/RsSDo1gOW+kVTGHKJJPQoV6DJj3a2LfsPo2Vz6P2h3SksRups=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(5023799004)(4143699003)(6133799003)(261009223027099003)(22082099003)(18002099003)(8096899003)(10067099003)(56012099006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlFrK0tqL05XUS9oVGRVWkg5UmFZNW0xWGZpcjBBOHV4TzF2cVg1M3Y2QUZT?=
 =?utf-8?B?aGlGM2VRMVIwb3gzbXl3WEtrWjdoYklpM1RJNy9VcXc1RXM5TlNqc3h5NW9J?=
 =?utf-8?B?dDhkZUxwclJGTGFrMFFMRHJzOHl5d3Z5SjZFYXVveGo1bXIyUEE2bXk3cTNU?=
 =?utf-8?B?WjJWUG9OSVdwOWhBMS90bEdLRnVQTm5PWEZqZVdUR2U4UVozcVhsWndhYURr?=
 =?utf-8?B?UU5oK0RNVlo1ZmtRbi9CLzNFQzZqdGFpWnJSYzhaaW5vY0JnWm9rMFdnbURE?=
 =?utf-8?B?ZWdNMklHQW9oenQ2YUQxMXIzbzdaY2JtVlQ0WTRTaXdBTTd1WGZjcFVUWDR3?=
 =?utf-8?B?WWorTTlUVHNKNy9GNkxJblJIMGdmNUJoK0E5OXJtRTkxeWFCa1BPOU9FNlFO?=
 =?utf-8?B?UWlqODFNNnNmbU1rZm5Hc0dpMXBWc1hpSStCTFpia0ROdml2eXlRbHVuU04w?=
 =?utf-8?B?SkhPd3NuRytDSGdkOU00UGQ0d2ZHcXhSbG1CeXJYZmQ4UzBkRDJZRkk1dmhR?=
 =?utf-8?B?aHgzOEU5Mk5BWWFJUE1BNHlnUVk1clBkWi9Sd0U4dXowaEx2WVRCYzNpcHQw?=
 =?utf-8?B?cTBMLzVpNWdTOFpzaUJZUWFsR3lhemk1cWZwanR3QTlidytwdVBvc2FNcWpo?=
 =?utf-8?B?Q2FqcGViV3p5cXNkUnVqMDJpM21QTzlnWS9VdnR0RWVmenMrY3JMNnhTMVo0?=
 =?utf-8?B?TVdvcW5udVRMc3BxUkRHWFhTTmgvb3Z6NWlkcVFPeXIwaERjakxWMFZURDlp?=
 =?utf-8?B?N01ORk4yOS9UK2V1K3lYK3ZHTmtaRTRSa2hHbk9BMU9RY0tQMkZyODZDcyt5?=
 =?utf-8?B?NDdGbzVlclQ0S2ZUMUdtcGhjTmFhRXozbkdBTlJrdllFQkd2SFNSemRNUldL?=
 =?utf-8?B?Qnc1eWNVbHhwMUYrVnQ5cjhoWWhERzB5TmR0VzFZa3hmU3pBODBpUGF6MldO?=
 =?utf-8?B?U08va1BUb0JuYlY0ZzFzYXc5K3FRQmU4WFN3T1lpdjliVHNMSGJlZERKbjdJ?=
 =?utf-8?B?QmplWm5IZlFtL3hxbllNM2RGWFpOTEVoeXV6VndBclJyQThvd0UzWHB6WGNR?=
 =?utf-8?B?ZTZXMnU1Q3RxVFd5ZEdHT0hsQTRzaklTdWxXNUNWbERGNVEvTGt3anh2OVNh?=
 =?utf-8?B?R2ZwSEFYMHozR2NZTFRlR3lQTldZTGQrL3Yyb1kwMTQwYy9TaDUvN3FZbVYr?=
 =?utf-8?B?WlppSlZkbklTeGZ5aG1HNkk1Ynprc2FjT0NtUUcrTmxmd1JEWFQ3RXArS2NQ?=
 =?utf-8?B?TisxeW9KRmNIbnQxazZzTGMyTndOaHN6WUdmWUhGMlpvTzhVZndjN24raDl3?=
 =?utf-8?B?SWtvTTM4MU1qTytxWUlGQ0R1OTVybjRCS2N0YWdrQU8ybmVBSHlhRG9Vb1ZK?=
 =?utf-8?B?UU1RZ09QYjd4VjlZbEx5SUxJam9nN1NYZk1hOFhTd3YvTkF1MTBkd2xwcXJY?=
 =?utf-8?B?OUdMZGdJQi9iMUIwdmFlSFhoVHphdm5ReGlrV3kvenk0WHpSZEtIeDVvdnFE?=
 =?utf-8?B?dlVVem0vcGhhVFFkS2M2NzBmOW5JeUdYUFdxVnVEZmVhMHNyUUNadzdsN2Rk?=
 =?utf-8?B?cUFibmc1S3hlbm56cXpDamR3SUxwMWx6dis2TzNwRk91U1AvcWZiRnNLdzhl?=
 =?utf-8?B?UUU0SmNuQnY0cUVmZHFqRkl2VHZKZ3puY2Y3UEEwVFNQZDJxaGN2ZFhqT1o1?=
 =?utf-8?B?UXl4TUs3ckdNZXFuQnZzVkNuZzM5Vy9udGZiUmlSd2dRZjJFWGNiZiszbWht?=
 =?utf-8?B?UTVoQ2JZVEtuOFE4MHRoeXgvMGxCVS9KNGR5RFpjTkJzZEM3aDAvbC9kNDlm?=
 =?utf-8?B?cTNaYkw3LzNVSkczU1JSRENhTWNISmdTZjFHSGVTTi9udHM4RXRlQVJsbWVo?=
 =?utf-8?B?eHRKU2tZRmw4VHFYSFR1OG90ZmJQWVBpM05ob092a2pPd21sRkNRcUJwRXJO?=
 =?utf-8?B?RVdGZXVtRjNqV2Z4azR3aDlyR3l4MmNPMSttZGM4NlZiZjNnVEJBbG1hMEsw?=
 =?utf-8?B?bWRhTmx1OGNSQjNibmNDWmsyTnRoWGp0bmJSUUJXSUpmV0x1WDNVOExxRTNY?=
 =?utf-8?B?MFpWeXRFclpNZWd1S2pCNEd4b0EvUWdFbkNhUm1YTVAwcG5WakY2am1OZ0dh?=
 =?utf-8?B?OUorZVpQb0hNN0NkZzM0eU1aSXZKYlduOVNoLzlKY2cvZE9BZXpiQVhsRGtk?=
 =?utf-8?B?c2tzQ3daY2JHRURoemlnNUVJWEt4ZlVNRUI5ckw5RkFCc2ZYamMyT2pYcU9x?=
 =?utf-8?B?RXNRSTdmc3FSTjZQUlZUWnJrakZmendZSUhWcE1URzAyREp3UXNTcFdEb2kr?=
 =?utf-8?Q?juwDmulZMVNXwNLtFO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a323a66-178a-431c-d562-08df4cdd6900
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 23:23:14.6619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pukul6O1QJ3q7sh7kkAQlQhElt5QCgTHEIwJ5Ww7qJKXETuniCCY2BsdG86ppin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999217
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

--------------Mlf5wVxRGfSPFfhivwAl0nvG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-22 15:26, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> HMM migrates a PMD-mapped THP as one compound folio when
> migrate_vma_setup() is passed MIGRATE_VMA_SELECT_COMPOUND.
>
> Without that flag the collect path splits the source THP to 4K pages.
> If split_folio() fails because of extra refs or pins, those pages are
> skipped.
>
> Set SELECT_COMPOUND for device-private ranges whose migrate window is
> at least HPAGE_PMD_NR pages. The RAM<->VRAM copy path follows
> MIGRATE_PFN_COMPOUND in src[] (HPAGE_PMD_ORDER device folio, THP DMA)
> and keeps the existing 4K path otherwise.
>
> Coherent zone-device memory is unchanged.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 582 +++++++++++++++++++++--
>   1 file changed, 530 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 11cda92b8878..aeb74d812c6c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -340,6 +340,153 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>   	return mpages;
>   }
>   
> +/*
> + * A reused svm_bo VRAM page may still be held by someone else, ex:
> + * (do_swap_page -> svm_migrate_to_ram). Migrating to VRAM re-initializes
> + * the page and resets its refcount, so the other's put_page() would
> + * free it mid-migration. Report whether any of the @nr VRAM pages starting
> + * at page offset @m of @cursor is still referenced. @cursor is a copy, so
> + * the range may cross VRAM blocks without moving the caller's cursor.
> + *
> + * Check the folio, not the page: a tail page of a live device THP always
> + * has a zero refcount while its folio is held.
> + */
> +static bool
> +svm_migrate_vram_busy(struct amdgpu_device *adev,
> +		      struct amdgpu_res_cursor cursor, u64 m, u64 nr)
> +{
> +	while (nr) {
> +		u64 chunk = cursor.size >> PAGE_SHIFT;
> +		struct page *page;
> +
> +		if (m >= chunk) {
> +			if (cursor.remaining <= cursor.size)
> +				return false;
> +			amdgpu_res_next(&cursor, cursor.size);
> +			m -= chunk;
> +			continue;
> +		}
> +
> +		page = pfn_to_page(svm_migrate_addr_to_pfn(adev,
> +					cursor.start + (m << PAGE_SHIFT)));
> +		if (folio_ref_count(page_folio(page)))
> +			return true;
> +		m++;
> +		nr--;
> +	}
> +
> +	return false;
> +}

Good catch on checking for busy VRAM pages for both the 4K and THP
cases. However, this patch is not based on the last code review,
"Simplify svm_migrate_copy_to_vram()", which already cleaned up this
function:

     The THP and the single page paths were written as two separate
     flows using five single letter loop variables, with the same "copy
     whatever has been accumulated so far" block open coded four times.

     Fold them into one flow:

      - add svm_migrate_flush_batch() for the accumulated copy, it is a
        no-op when nothing is pending so the callers no longer need to
        guard it. svm_migrate_copy_memory_gart() is now called from
        there only.
      - rename the loop variables to i, batch and off, and derive the
        step nr from order so that order can be passed to
        svm_migrate_get_vram_page() directly.
      - claim the destination in a single branch, the tail loops are
        no-ops for an order 0 page.
      - map the source with one dma_map_page() of nr pages.

The simplified svm_migrate_copy_to_vram() is about 150 lines. With this
patch, the same function grows to about 330 lines.

Please rebase on the simplified version and add the busy check there,
for example:

/*
  * Read each page's own refcount: the block may hold old 4K folios or an
  * old THP, and page_folio() can follow a stale tail to a freed head.
  */
static bool svm_migrate_vram_busy(unsigned long pfn, unsigned long nr)
{
    unsigned long n;

     for (n = 0; n < nr; n++)
         if (page_ref_count(pfn_to_page(pfn + n)))
             return true;
     return false;
}

and in svm_migrate_copy_to_vram():

          if (!(migrate->src[i] & MIGRATE_PFN_MIGRATE) ||
-            (!order && page_ref_count(pfn_to_page(dst_pfn)))) {
+            svm_migrate_vram_busy(dst_pfn, nr)) {

An order 9 destination is only chosen when the whole 2MB fits in the
current VRAM block, so the nr pfns are contiguous. A plain pfn loop is
enough, and the cursor walk is not needed.

Regards,
Philip
> +
> +/* Move the VRAM position (@cursor, page offset @m) forward by @nr pages. */
> +static void
> +svm_migrate_cursor_skip(struct amdgpu_res_cursor *cursor, u64 *m, u64 nr)
> +{
> +	*m += nr;
> +	while (*m >= (cursor->size >> PAGE_SHIFT) &&
> +	       cursor->remaining > cursor->size) {
> +		*m -= cursor->size >> PAGE_SHIFT;
> +		amdgpu_res_next(cursor, cursor->size);
> +	}
> +}
> +
> +/*
> + * Place one MIGRATE_PFN_COMPOUND source into 4K device pages.
> + *
> + * A device THP needs one PMD-aligned VRAM run. This folio does not have
> + * that run: its device pages continue into the next VRAM block. Publish
> + * one dst pfn per page so migrate_vma_pages() can split the source, and
> + * copy each contiguous VRAM run separately. SDMA copies a contiguous
> + * destination; a single 2MB copy cannot cross a block boundary.
> + *
> + * @m_in is the page offset in the current block. On return *@m_out is the
> + * offset of the next page, or the block size when the folio ends on a
> + * block boundary.
> + */
> +static int
> +svm_migrate_compound_to_4k_vram(struct amdgpu_device *adev, struct device *dev,
> +				struct svm_range *prange,
> +				struct migrate_vma *migrate,
> +				struct dma_fence **mfence,
> +				struct amdgpu_res_cursor *cursor,
> +				dma_addr_t *src, u64 *dst, unsigned long idx,
> +				u64 m_in, u64 *m_out)
> +{
> +	struct page *spage = migrate_pfn_to_page(migrate->src[idx]);
> +	unsigned long done = 0;
> +	bool mapped = false;
> +	u64 m = m_in;
> +	int r = 0;
> +
> +	if (spage && !is_zone_device_page(spage)) {
> +		unsigned long l;
> +
> +		src[idx] = dma_map_page(dev, spage, 0, PAGE_SIZE * SVM_HPAGE_PMD_NR,
> +					DMA_BIDIRECTIONAL);
> +		r = dma_mapping_error(dev, src[idx]);
> +		if (r) {
> +			dev_err(dev, "%s: fail %d dma_map_page\n", __func__, r);
> +			src[idx] = 0;
> +			return r;
> +		}
> +
> +		for (l = 1; l < SVM_HPAGE_PMD_NR; l++)
> +			src[idx + l] = src[idx] + l * PAGE_SIZE;
> +		mapped = true;
> +	}
> +
> +	while (done < SVM_HPAGE_PMD_NR) {
> +		unsigned long chunk_pages = cursor->size >> PAGE_SHIFT;
> +		unsigned long room = chunk_pages > m ? chunk_pages - m : 0;
> +		unsigned long step = min_t(unsigned long, SVM_HPAGE_PMD_NR - done, room);
> +		unsigned long l;
> +
> +		if (!step) {
> +			r = -ENOSPC;
> +			break;
> +		}
> +
> +		for (l = 0; l < step; l++) {
> +			u64 addr = cursor->start + ((m + l) << PAGE_SHIFT);
> +			unsigned long pfn = svm_migrate_addr_to_pfn(adev, addr);
> +
> +			dst[idx + done + l] = addr;
> +			svm_migrate_get_vram_page(prange, pfn, 0);
> +			migrate->dst[idx + done + l] = migrate_pfn(pfn);
> +		}
> +
> +		if (mapped) {
> +			r = svm_migrate_copy_memory_gart(adev, src + idx + done,
> +							 dst + idx + done, step,
> +							 FROM_RAM_TO_VRAM, mfence);
> +			if (r)
> +				break;
> +		}
> +
> +		done += step;
> +		m += step;
> +		if (done < SVM_HPAGE_PMD_NR && m == chunk_pages) {
> +			amdgpu_res_next(cursor, m << PAGE_SHIFT);
> +			m = 0;
> +			if (!cursor->remaining) {
> +				r = -ENOSPC;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (mapped) {
> +		unsigned long l;
> +
> +		src[idx] |= SVM_RANGE_DMA_THP;
> +		for (l = 1; l < SVM_HPAGE_PMD_NR; l++)
> +			src[idx + l] = 0;
> +	}
> +
> +	*m_out = m;
> +	return r;
> +}
> +
>   static int
>   svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
> @@ -352,7 +499,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	u64 mpages = 0;
>   	dma_addr_t *src;
>   	u64 *dst;
> -	u64 i, j;
> +	u64 i, j, k, l, m;
>   	int r = 0;
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
> @@ -363,69 +510,251 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   
>   	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>   			 npages << PAGE_SHIFT, &cursor);
> -	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
> -		struct page *spage = migrate_pfn_to_page(migrate->src[i]);
> +	for (i = j = m = 0; (i < npages) && (mpages < migrate->cpages);) {
> +		struct page *spage;
> +		unsigned long cur_dst_pfn;
> +		bool thp_dst = false;
> +		bool busy = false;
> +
> +		cur_dst_pfn = svm_migrate_addr_to_pfn(adev,
> +						      cursor.start + (m << PAGE_SHIFT));
> +
> +		/*
> +		 * MIGRATE_PFN_COMPOUND is one slot for the whole folio.
> +		 * src[i+1 .. i+SVM_HPAGE_PMD_NR-1] stay zero and cpages counts
> +		 * the folio once. migrate_vma_pages() splits that folio when
> +		 * dst[i] is not compound and then reads every tail dst slot.
> +		 * Those slots must be real pages. A device THP is placed only
> +		 * at a PMD-aligned VRAM pfn. Any other compound source is
> +		 * migrated as 4K device pages, including when the folio
> +		 * crosses a VRAM block.
> +		 */
> +		if (migrate->src[i] & MIGRATE_PFN_COMPOUND) {
> +			unsigned long room = (cursor.size >> PAGE_SHIFT) - m;
> +			bool fits = room >= SVM_HPAGE_PMD_NR;
>   
> -		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
> -			dst[i] = cursor.start + (j << PAGE_SHIFT);
> -			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>   			/*
> -			 * A reused svm_bo page may still be held by a CPU fault.
> +			 * HMM collects a compound entry only for a PMD fully
> +			 * inside [start, end), so the folio cannot run past
> +			 * npages. If it ever does, fail the whole window: the
> +			 * error path releases every published VRAM page,
> +			 * including the 4K pages still pending in j.
> +			 */
> +			if (WARN_ON_ONCE(i + SVM_HPAGE_PMD_NR > npages)) {
> +				r = -EINVAL;
> +				goto out_free_vram_pages;
> +			}
> +
> +			/*
> +			 * Every path below re-initializes all SVM_HPAGE_PMD_NR
> +			 * VRAM pages, and a split source needs a page in every
> +			 * dst slot, so single pages cannot be skipped. If any
> +			 * target page is still referenced (see
> +			 * svm_migrate_vram_busy()), leave the whole folio in
> +			 * system memory. Flush the pending run first: the next
> +			 * VRAM page is no longer contiguous with it.
> +			 */
> +			if (svm_migrate_vram_busy(adev, cursor, m,
> +						  SVM_HPAGE_PMD_NR)) {
> +				if (j) {
> +					r = svm_migrate_copy_memory_gart(
> +						adev, src + i - j, dst + i - j,
> +						j, FROM_RAM_TO_VRAM, mfence);
> +					if (r)
> +						goto out_free_vram_pages;
> +					j = 0;
> +				}
> +				svm_migrate_cursor_skip(&cursor, &m,
> +							SVM_HPAGE_PMD_NR);
> +				i += SVM_HPAGE_PMD_NR;
> +				continue;
> +			}
> +
> +			if (!fits) {
> +				u64 m_next;
> +
> +				if (j) {
> +					r = svm_migrate_copy_memory_gart(
> +						adev, src + i - j, dst + i - j,
> +						j, FROM_RAM_TO_VRAM, mfence);
> +					if (r)
> +						goto out_free_vram_pages;
> +					j = 0;
> +				}
> +
> +				r = svm_migrate_compound_to_4k_vram(adev, dev,
> +								    prange,
> +								    migrate,
> +								    mfence,
> +								    &cursor,
> +								    src, dst,
> +								    i, m,
> +								    &m_next);
> +				if (r)
> +					goto out_free_vram_pages;
> +
> +				mpages++;
> +				i += SVM_HPAGE_PMD_NR;
> +				m = m_next;
> +				if (cursor.remaining &&
> +				    m == (cursor.size >> PAGE_SHIFT)) {
> +					amdgpu_res_next(&cursor, m << PAGE_SHIFT);
> +					m = 0;
> +				}
> +				continue;
> +			}
> +
> +			k = SVM_HPAGE_PMD_NR;
> +			thp_dst = IS_ALIGNED(cur_dst_pfn, SVM_HPAGE_PMD_NR);
> +		} else {
> +			k = 1;
> +		}
> +
> +		if (thp_dst) {
> +			dst[i] = cursor.start + (m << PAGE_SHIFT);
> +			svm_migrate_get_vram_page(prange, cur_dst_pfn,
> +						  SVM_HPAGE_PMD_ORDER);
> +
> +			migrate->dst[i] = migrate_pfn(cur_dst_pfn) |
> +					  MIGRATE_PFN_COMPOUND;
> +
> +			for (l = 1; l < k; l++)
> +				migrate->dst[i + l] = 0;
> +
> +			mpages++;
> +		} else if (k > 1) {
> +			for (l = 0; l < k; l++) {
> +				unsigned long pfn = cur_dst_pfn + l;
> +
> +				dst[i + l] = cursor.start + ((m + l) << PAGE_SHIFT);
> +				svm_migrate_get_vram_page(prange, pfn, 0);
> +				migrate->dst[i + l] = migrate_pfn(pfn);
> +			}
> +			mpages++;
> +		} else if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
> +			/*
> +			 * A reused svm_bo page may still be held by someone else.
>   			 * Reinitializing it would free it under this migration,
>   			 * so leave this page in system memory.
>   			 */
> -			if (page_ref_count(pfn_to_page(migrate->dst[i]))) {
> -				dst[i] = 0;
> -				migrate->dst[i] = 0;
> -				spage = NULL;
> -			} else {
> -				svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
> -				migrate->dst[i] = migrate_pfn(migrate->dst[i]);
> +			busy = svm_migrate_vram_busy(adev, cursor, m, 1);
> +			if (!busy) {
> +				dst[i] = cursor.start + (m << PAGE_SHIFT);
> +				svm_migrate_get_vram_page(prange, cur_dst_pfn, 0);
> +				migrate->dst[i] = migrate_pfn(cur_dst_pfn);
>   				mpages++;
>   			}
>   		}
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
> +		if (k > 1) {
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
> +			 * if not valid skip following SVM_HPAGE_PMD_NR - 1 pages
> +			 */
> +			spage = migrate_pfn_to_page(migrate->src[i]);
> +			if (spage && !is_zone_device_page(spage)) {
> +				/* dma_map continuous SVM_HPAGE_PMD_NR sys ram pages */
> +				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE*SVM_HPAGE_PMD_NR,
> +						      DMA_BIDIRECTIONAL);
> +
> +				r = dma_mapping_error(dev, src[i]);
> +				if (r) {
> +					dev_err(dev, "%s: fail %d dma_map_page\n",
> +							__func__, r);
> +					goto out_free_vram_pages;
> +				}
> +
> +				/* get dma address for following SVM_HPAGE_PMD_NR-1 pages
> +				 * since src pages are continuous their dma addresses
> +				 * are continuous too.
> +				 */
> +				for (l = 1; l < k; l++)
> +					src[i + l] = src[i] + l*PAGE_SIZE;
> +
> +				/* migrate the SVM_HPAGE_PMD_NR pages above */
> +				r = svm_migrate_copy_memory_gart(
> +						adev, src + i,
> +						dst + i, SVM_HPAGE_PMD_NR,
> +						FROM_RAM_TO_VRAM,
> +						mfence);
> +
> +				/* mark head page dma mapping as THP, tail pages dma addr
> +				 * are set to 0 for following dma_unmap
> +				 */
> +				src[i] |= SVM_RANGE_DMA_THP;
> +				for (l = 1; l < k; l++)
> +					src[i + l] = 0;
> +
> +				if (r)
> +					goto out_free_vram_pages;
> +
> +				j = 0;
>   			}
>   		} else {
> -			if (j) {
> +			/*
> +			 * single normal page case; a busy VRAM page is not
> +			 * migrated, so treat it like a page with no source
> +			 */
> +			spage = busy ? NULL : migrate_pfn_to_page(migrate->src[i]);
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
> @@ -436,12 +765,16 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   out_free_vram_pages:
>   	if (r) {
>   		pr_debug("failed %d to copy memory to vram\n", r);
> -		for (i = 0; i < npages && mpages; i++) {
> +		/*
> +		 * A split compound source allocates one dst page per tail
> +		 * slot while mpages still counts the folio once. Release
> +		 * every page that was published.
> +		 */
> +		for (i = 0; i < npages; i++) {
>   			if (!dst[i])
>   				continue;
>   			svm_migrate_put_vram_page(adev, dst[i]);
>   			migrate->dst[i] = 0;
> -			mpages--;
>   		}
>   	}
>   
> @@ -514,6 +847,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate = { 0 };
> +	bool is_private_device = false;
>   	unsigned long cpages = 0;
>   	unsigned long mpages = 0;
>   	dma_addr_t *scratch;
> @@ -526,11 +860,18 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	if (svm_range_window_resident(node, prange, start, end))
>   		return 0;
>   
> +	is_private_device = svm_is_private_zone(adev);
> +
>   	memset(&migrate, 0, sizeof(migrate));
>   	migrate.vma = vma;
>   	migrate.start = start;
>   	migrate.end = end;
>   	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
> +
> +	if (SVM_THP_ENABLED && is_private_device &&
> +	    ((end - start) >> PAGE_SHIFT) >= SVM_HPAGE_PMD_NR)
> +		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
> +
>   	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>   
>   	buf = kvcalloc(npages,
> @@ -711,6 +1052,57 @@ static void svm_migrate_folio_free(struct folio *folio)
>   	}
>   }
>   
> +/*
> + * Migrate one compound device folio at @idx to 4K system pages, used when
> + * no THP destination can be allocated.
> + *
> + * When dst[idx] is not compound, migrate_vma_pages() splits the source
> + * folio and then migrates every one of its SVM_HPAGE_PMD_NR pages, reading
> + * each tail dst slot without a NULL check. So every slot must get a real
> + * page here, not just the head.
> + *
> + * The device folio is contiguous in VRAM, so one copy covers all pages.
> + * On error, pages already published in migrate->dst[] and their DMA
> + * mappings in @dst are released by the caller's error path.
> + */
> +static int
> +svm_migrate_compound_to_4k_ram(struct amdgpu_device *adev,
> +			       struct migrate_vma *migrate,
> +			       struct dma_fence **mfence, dma_addr_t *dst,
> +			       u64 *src, u64 idx, u64 addr)
> +{
> +	struct device *dev = adev->dev;
> +	unsigned long l;
> +	int r;
> +
> +	for (l = 0; l < SVM_HPAGE_PMD_NR; l++) {
> +		struct page *dpage;
> +
> +		dpage = svm_migrate_get_sys_page(migrate->vma,
> +						 addr + l * PAGE_SIZE, 0);
> +		if (!dpage)
> +			return -ENOMEM;
> +
> +		dst[idx + l] = dma_map_page(dev, dpage, 0, PAGE_SIZE,
> +					    DMA_BIDIRECTIONAL);
> +		r = dma_mapping_error(dev, dst[idx + l]);
> +		if (r) {
> +			dev_err(dev, "%s: fail %d dma_map_page\n", __func__, r);
> +			dst[idx + l] = 0;
> +			unlock_page(dpage);
> +			put_page(dpage);
> +			return r;
> +		}
> +
> +		migrate->dst[idx + l] = migrate_pfn(page_to_pfn(dpage));
> +		src[idx + l] = src[idx] + l * PAGE_SIZE;
> +	}
> +
> +	return svm_migrate_copy_memory_gart(adev, dst + idx, src + idx,
> +					    SVM_HPAGE_PMD_NR, FROM_VRAM_TO_RAM,
> +					    mfence);
> +}
> +
>   static int
>   svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			struct migrate_vma *migrate, struct dma_fence **mfence,
> @@ -724,6 +1116,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	u64 i = 0, j;
>   	u64 addr;
>   	int r = 0;
> +	u64 l, k;
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
>   		 prange->last);
> @@ -732,8 +1125,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   	src = (u64 *)(scratch + npages);
>   	dst = scratch;
> -
> -	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
> +	for (i = 0, j = 0, k = 1; i < npages; i += k, addr += k*PAGE_SIZE, k = 1) {
>   		struct page *spage;
>   
>   		spage = migrate_pfn_to_page(migrate->src[i]);
> @@ -749,6 +1141,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   					goto out_oom;
>   				j = 0;
>   			}
> +
>   			continue;
>   		}
>   		src[i] = svm_migrate_addr(adev, spage);
> @@ -762,7 +1155,58 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			j = 0;
>   		}
>   
> -		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
> +		if (migrate->src[i] & MIGRATE_PFN_COMPOUND) {
> +			/*
> +			 * Flush accumulated 4K pages before mapping the 2MB
> +			 * destination, so a flush failure never leaves a 2MB
> +			 * dst[i] mapping that is not yet marked SVM_RANGE_DMA_THP.
> +			 */
> +			if (j) {
> +				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
> +								 src + i - j, j,
> +								 FROM_VRAM_TO_RAM,
> +								 mfence);
> +				if (r)
> +					goto out_oom;
> +				j = 0;
> +			}
> +
> +			/*
> +			 * HMM collects a compound entry only for a PMD fully
> +			 * inside [start, end), so the folio cannot run past
> +			 * npages.
> +			 */
> +			if (WARN_ON_ONCE(i + SVM_HPAGE_PMD_NR > npages)) {
> +				r = -EINVAL;
> +				goto out_oom;
> +			}
> +
> +			k = SVM_HPAGE_PMD_NR;
> +			dpage = NULL;
> +			if (IS_ALIGNED(page_to_pfn(spage), SVM_HPAGE_PMD_NR) &&
> +			    IS_ALIGNED(addr, SVM_HPAGE_PMD_SIZE))
> +				dpage = svm_migrate_get_sys_page(migrate->vma,
> +							addr, SVM_HPAGE_PMD_ORDER);
> +
> +			/*
> +			 * No THP destination (allocation failed or THP is
> +			 * disabled for the VMA): migrate the whole folio as
> +			 * SVM_HPAGE_PMD_NR 4K pages so migrate_vma_pages() finds
> +			 * a page in every slot after it splits the source.
> +			 */
> +			if (!dpage) {
> +				r = svm_migrate_compound_to_4k_ram(adev, migrate,
> +								   mfence, dst,
> +								   src, i, addr);
> +				if (r)
> +					goto out_oom;
> +				continue;
> +			}
> +		} else {
> +			k = 1;
> +			dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
> +		}
> +
>   		if (!dpage) {
>   			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>   				 prange->svms, prange->start, prange->last);
> @@ -770,7 +1214,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			goto out_oom;
>   		}
>   
> -		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
>   		r = dma_mapping_error(dev, dst[i]);
>   		if (r) {
>   			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
> @@ -778,13 +1222,40 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			goto out_oom;
>   		}
>   
> -		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
> -				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
> -
>   		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
> -
>   		dpage = NULL;
> -		j++;
> +
> +		if (k > 1) {
> +			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
> +
> +			for (l = 1; l < k; l++) {
> +
> +				src[i + l] = src[i] + l*PAGE_SIZE;
> +				dst[i + l] = dst[i] + l*PAGE_SIZE;
> +				migrate->dst[i + l] = 0;
> +			}
> +
> +			/* migrate the SVM_HPAGE_PMD_NR pages above
> +			 * the migration is for 2MB THP
> +			 */
> +			r = svm_migrate_copy_memory_gart(
> +						adev, dst + i,
> +						src + i, SVM_HPAGE_PMD_NR,
> +						FROM_VRAM_TO_RAM,
> +						mfence);
> +
> +			/* mark head page dma mapping as THP, tail pages dma addr
> +			 * are set to 0 for following dma_unmap
> +			 */
> +			dst[i] |= SVM_RANGE_DMA_THP;
> +			for (l = 1; l < k; l++)
> +				dst[i + l] = 0;
> +
> +			if (r)
> +				goto out_oom;
> +
> +		} else
> +			j++;
>   	}
>   
>   	if (j > 0)
> @@ -849,6 +1320,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	unsigned long cpages = 0;
>   	unsigned long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
> +	bool is_private_device = false;
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate = { 0 };
> @@ -856,6 +1328,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	void *buf;
>   	int r = -ENOMEM;
>   
> +	is_private_device = svm_is_private_zone(adev);
> +
>   	memset(&migrate, 0, sizeof(migrate));
>   	migrate.vma = vma;
>   	migrate.start = start;
> @@ -866,6 +1340,10 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	else
>   		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>   
> +	if (SVM_THP_ENABLED && is_private_device &&
> +	    ((end - start) >> PAGE_SHIFT) >= SVM_HPAGE_PMD_NR)
> +		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
> +
>   	buf = kvcalloc(npages,
>   		       2 * sizeof(*migrate.src) + sizeof(u64) + sizeof(dma_addr_t),
>   		       GFP_KERNEL);

--------------Mlf5wVxRGfSPFfhivwAl0nvG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-22 15:26, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261122202653.274580-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

HMM migrates a PMD-mapped THP as one compound folio when
migrate_vma_setup() is passed MIGRATE_VMA_SELECT_COMPOUND.

Without that flag the collect path splits the source THP to 4K pages.
If split_folio() fails because of extra refs or pins, those pages are
skipped.

Set SELECT_COMPOUND for device-private ranges whose migrate window is
at least HPAGE_PMD_NR pages. The RAM&lt;-&gt;VRAM copy path follows
MIGRATE_PFN_COMPOUND in src[] (HPAGE_PMD_ORDER device folio, THP DMA)
and keeps the existing 4K path otherwise.

Coherent zone-device memory is unchanged.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 582 +++++++++++++++++++++--
 1 file changed, 530 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 11cda92b8878..aeb74d812c6c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -340,6 +340,153 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 	return mpages;
 }
 
+/*
+ * A reused svm_bo VRAM page may still be held by someone else, ex:
+ * (do_swap_page -&gt; svm_migrate_to_ram). Migrating to VRAM re-initializes
+ * the page and resets its refcount, so the other's put_page() would
+ * free it mid-migration. Report whether any of the @nr VRAM pages starting
+ * at page offset @m of @cursor is still referenced. @cursor is a copy, so
+ * the range may cross VRAM blocks without moving the caller's cursor.
+ *
+ * Check the folio, not the page: a tail page of a live device THP always
+ * has a zero refcount while its folio is held.
+ */
+static bool
+svm_migrate_vram_busy(struct amdgpu_device *adev,
+		      struct amdgpu_res_cursor cursor, u64 m, u64 nr)
+{
+	while (nr) {
+		u64 chunk = cursor.size &gt;&gt; PAGE_SHIFT;
+		struct page *page;
+
+		if (m &gt;= chunk) {
+			if (cursor.remaining &lt;= cursor.size)
+				return false;
+			amdgpu_res_next(&amp;cursor, cursor.size);
+			m -= chunk;
+			continue;
+		}
+
+		page = pfn_to_page(svm_migrate_addr_to_pfn(adev,
+					cursor.start + (m &lt;&lt; PAGE_SHIFT)));
+		if (folio_ref_count(page_folio(page)))
+			return true;
+		m++;
+		nr--;
+	}
+
+	return false;
+}</pre>
    </blockquote>
    <br>
    Good catch on checking for busy VRAM pages for both the 4K and THP<br>
    cases. However, this patch is not based on the last code review,<br>
    &quot;Simplify svm_migrate_copy_to_vram()&quot;, which already cleaned up this<br>
    function:<br>
    <br>
    &nbsp; &nbsp; The THP and the single page paths were written as two separate<br>
    &nbsp; &nbsp; flows using five single letter loop variables, with the same
    &quot;copy<br>
    &nbsp; &nbsp; whatever has been accumulated so far&quot; block open coded four
    times.<br>
    <br>
    &nbsp; &nbsp; Fold them into one flow:<br>
    <br>
    &nbsp; &nbsp; &nbsp;- add svm_migrate_flush_batch() for the accumulated copy, it is
    a<br>
    &nbsp; &nbsp; &nbsp; &nbsp;no-op when nothing is pending so the callers no longer need
    to<br>
    &nbsp; &nbsp; &nbsp; &nbsp;guard it. svm_migrate_copy_memory_gart() is now called from<br>
    &nbsp; &nbsp; &nbsp; &nbsp;there only.<br>
    &nbsp; &nbsp; &nbsp;- rename the loop variables to i, batch and off, and derive the<br>
    &nbsp; &nbsp; &nbsp; &nbsp;step nr from order so that order can be passed to<br>
    &nbsp; &nbsp; &nbsp; &nbsp;svm_migrate_get_vram_page() directly.<br>
    &nbsp; &nbsp; &nbsp;- claim the destination in a single branch, the tail loops are<br>
    &nbsp; &nbsp; &nbsp; &nbsp;no-ops for an order 0 page.<br>
    &nbsp; &nbsp; &nbsp;- map the source with one dma_map_page() of nr pages.<br>
    <br>
    The simplified svm_migrate_copy_to_vram() is about 150 lines. With
    this<br>
    patch, the same function grows to about 330 lines.<br>
    <br>
    Please rebase on the simplified version and add the busy check
    there,<br>
    for example:<br>
    <br>
    /*<br>
    &nbsp;* Read each page's own refcount: the block may hold old 4K folios
    or an<br>
    &nbsp;* old THP, and page_folio() can follow a stale tail to a freed
    head.<br>
    &nbsp;*/<br>
    static bool svm_migrate_vram_busy(unsigned long pfn, unsigned long
    nr)<br>
    {<br>
    &nbsp; &nbsp;unsigned long n;<br>
    <br>
    &nbsp; &nbsp; for (n = 0; n &lt; nr; n++)<br>
    &nbsp; &nbsp; &nbsp; &nbsp; if (page_ref_count(pfn_to_page(pfn + n)))<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return true;<br>
    &nbsp; &nbsp; return false;<br>
    }<br>
    <br>
    and in svm_migrate_copy_to_vram():<br>
    <br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!(migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) ||<br>
    -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (!order &amp;&amp;
    page_ref_count(pfn_to_page(dst_pfn)))) {<br>
    +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; svm_migrate_vram_busy(dst_pfn, nr)) {<br>
    <br>
    An order 9 destination is only chosen when the whole 2MB fits in the<br>
    current VRAM block, so the nr pfns are contiguous. A plain pfn loop
    is<br>
    enough, and the cursor walk is not needed.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20261122202653.274580-4-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+/* Move the VRAM position (@cursor, page offset @m) forward by @nr pages. */
+static void
+svm_migrate_cursor_skip(struct amdgpu_res_cursor *cursor, u64 *m, u64 nr)
+{
+	*m += nr;
+	while (*m &gt;= (cursor-&gt;size &gt;&gt; PAGE_SHIFT) &amp;&amp;
+	       cursor-&gt;remaining &gt; cursor-&gt;size) {
+		*m -= cursor-&gt;size &gt;&gt; PAGE_SHIFT;
+		amdgpu_res_next(cursor, cursor-&gt;size);
+	}
+}
+
+/*
+ * Place one MIGRATE_PFN_COMPOUND source into 4K device pages.
+ *
+ * A device THP needs one PMD-aligned VRAM run. This folio does not have
+ * that run: its device pages continue into the next VRAM block. Publish
+ * one dst pfn per page so migrate_vma_pages() can split the source, and
+ * copy each contiguous VRAM run separately. SDMA copies a contiguous
+ * destination; a single 2MB copy cannot cross a block boundary.
+ *
+ * @m_in is the page offset in the current block. On return *@m_out is the
+ * offset of the next page, or the block size when the folio ends on a
+ * block boundary.
+ */
+static int
+svm_migrate_compound_to_4k_vram(struct amdgpu_device *adev, struct device *dev,
+				struct svm_range *prange,
+				struct migrate_vma *migrate,
+				struct dma_fence **mfence,
+				struct amdgpu_res_cursor *cursor,
+				dma_addr_t *src, u64 *dst, unsigned long idx,
+				u64 m_in, u64 *m_out)
+{
+	struct page *spage = migrate_pfn_to_page(migrate-&gt;src[idx]);
+	unsigned long done = 0;
+	bool mapped = false;
+	u64 m = m_in;
+	int r = 0;
+
+	if (spage &amp;&amp; !is_zone_device_page(spage)) {
+		unsigned long l;
+
+		src[idx] = dma_map_page(dev, spage, 0, PAGE_SIZE * SVM_HPAGE_PMD_NR,
+					DMA_BIDIRECTIONAL);
+		r = dma_mapping_error(dev, src[idx]);
+		if (r) {
+			dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;, __func__, r);
+			src[idx] = 0;
+			return r;
+		}
+
+		for (l = 1; l &lt; SVM_HPAGE_PMD_NR; l++)
+			src[idx + l] = src[idx] + l * PAGE_SIZE;
+		mapped = true;
+	}
+
+	while (done &lt; SVM_HPAGE_PMD_NR) {
+		unsigned long chunk_pages = cursor-&gt;size &gt;&gt; PAGE_SHIFT;
+		unsigned long room = chunk_pages &gt; m ? chunk_pages - m : 0;
+		unsigned long step = min_t(unsigned long, SVM_HPAGE_PMD_NR - done, room);
+		unsigned long l;
+
+		if (!step) {
+			r = -ENOSPC;
+			break;
+		}
+
+		for (l = 0; l &lt; step; l++) {
+			u64 addr = cursor-&gt;start + ((m + l) &lt;&lt; PAGE_SHIFT);
+			unsigned long pfn = svm_migrate_addr_to_pfn(adev, addr);
+
+			dst[idx + done + l] = addr;
+			svm_migrate_get_vram_page(prange, pfn, 0);
+			migrate-&gt;dst[idx + done + l] = migrate_pfn(pfn);
+		}
+
+		if (mapped) {
+			r = svm_migrate_copy_memory_gart(adev, src + idx + done,
+							 dst + idx + done, step,
+							 FROM_RAM_TO_VRAM, mfence);
+			if (r)
+				break;
+		}
+
+		done += step;
+		m += step;
+		if (done &lt; SVM_HPAGE_PMD_NR &amp;&amp; m == chunk_pages) {
+			amdgpu_res_next(cursor, m &lt;&lt; PAGE_SHIFT);
+			m = 0;
+			if (!cursor-&gt;remaining) {
+				r = -ENOSPC;
+				break;
+			}
+		}
+	}
+
+	if (mapped) {
+		unsigned long l;
+
+		src[idx] |= SVM_RANGE_DMA_THP;
+		for (l = 1; l &lt; SVM_HPAGE_PMD_NR; l++)
+			src[idx + l] = 0;
+	}
+
+	*m_out = m;
+	return r;
+}
+
 static int
 svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
@@ -352,7 +499,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	u64 mpages = 0;
 	dma_addr_t *src;
 	u64 *dst;
-	u64 i, j;
+	u64 i, j, k, l, m;
 	int r = 0;
 
 	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx 0x%llx]\n&quot;, prange-&gt;svms, prange-&gt;start,
@@ -363,69 +510,251 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,
 			 npages &lt;&lt; PAGE_SHIFT, &amp;cursor);
-	for (i = j = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) {
-		struct page *spage = migrate_pfn_to_page(migrate-&gt;src[i]);
+	for (i = j = m = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages);) {
+		struct page *spage;
+		unsigned long cur_dst_pfn;
+		bool thp_dst = false;
+		bool busy = false;
+
+		cur_dst_pfn = svm_migrate_addr_to_pfn(adev,
+						      cursor.start + (m &lt;&lt; PAGE_SHIFT));
+
+		/*
+		 * MIGRATE_PFN_COMPOUND is one slot for the whole folio.
+		 * src[i+1 .. i+SVM_HPAGE_PMD_NR-1] stay zero and cpages counts
+		 * the folio once. migrate_vma_pages() splits that folio when
+		 * dst[i] is not compound and then reads every tail dst slot.
+		 * Those slots must be real pages. A device THP is placed only
+		 * at a PMD-aligned VRAM pfn. Any other compound source is
+		 * migrated as 4K device pages, including when the folio
+		 * crosses a VRAM block.
+		 */
+		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_COMPOUND) {
+			unsigned long room = (cursor.size &gt;&gt; PAGE_SHIFT) - m;
+			bool fits = room &gt;= SVM_HPAGE_PMD_NR;
 
-		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
-			dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
-			migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
 			/*
-			 * A reused svm_bo page may still be held by a CPU fault.
+			 * HMM collects a compound entry only for a PMD fully
+			 * inside [start, end), so the folio cannot run past
+			 * npages. If it ever does, fail the whole window: the
+			 * error path releases every published VRAM page,
+			 * including the 4K pages still pending in j.
+			 */
+			if (WARN_ON_ONCE(i + SVM_HPAGE_PMD_NR &gt; npages)) {
+				r = -EINVAL;
+				goto out_free_vram_pages;
+			}
+
+			/*
+			 * Every path below re-initializes all SVM_HPAGE_PMD_NR
+			 * VRAM pages, and a split source needs a page in every
+			 * dst slot, so single pages cannot be skipped. If any
+			 * target page is still referenced (see
+			 * svm_migrate_vram_busy()), leave the whole folio in
+			 * system memory. Flush the pending run first: the next
+			 * VRAM page is no longer contiguous with it.
+			 */
+			if (svm_migrate_vram_busy(adev, cursor, m,
+						  SVM_HPAGE_PMD_NR)) {
+				if (j) {
+					r = svm_migrate_copy_memory_gart(
+						adev, src + i - j, dst + i - j,
+						j, FROM_RAM_TO_VRAM, mfence);
+					if (r)
+						goto out_free_vram_pages;
+					j = 0;
+				}
+				svm_migrate_cursor_skip(&amp;cursor, &amp;m,
+							SVM_HPAGE_PMD_NR);
+				i += SVM_HPAGE_PMD_NR;
+				continue;
+			}
+
+			if (!fits) {
+				u64 m_next;
+
+				if (j) {
+					r = svm_migrate_copy_memory_gart(
+						adev, src + i - j, dst + i - j,
+						j, FROM_RAM_TO_VRAM, mfence);
+					if (r)
+						goto out_free_vram_pages;
+					j = 0;
+				}
+
+				r = svm_migrate_compound_to_4k_vram(adev, dev,
+								    prange,
+								    migrate,
+								    mfence,
+								    &amp;cursor,
+								    src, dst,
+								    i, m,
+								    &amp;m_next);
+				if (r)
+					goto out_free_vram_pages;
+
+				mpages++;
+				i += SVM_HPAGE_PMD_NR;
+				m = m_next;
+				if (cursor.remaining &amp;&amp;
+				    m == (cursor.size &gt;&gt; PAGE_SHIFT)) {
+					amdgpu_res_next(&amp;cursor, m &lt;&lt; PAGE_SHIFT);
+					m = 0;
+				}
+				continue;
+			}
+
+			k = SVM_HPAGE_PMD_NR;
+			thp_dst = IS_ALIGNED(cur_dst_pfn, SVM_HPAGE_PMD_NR);
+		} else {
+			k = 1;
+		}
+
+		if (thp_dst) {
+			dst[i] = cursor.start + (m &lt;&lt; PAGE_SHIFT);
+			svm_migrate_get_vram_page(prange, cur_dst_pfn,
+						  SVM_HPAGE_PMD_ORDER);
+
+			migrate-&gt;dst[i] = migrate_pfn(cur_dst_pfn) |
+					  MIGRATE_PFN_COMPOUND;
+
+			for (l = 1; l &lt; k; l++)
+				migrate-&gt;dst[i + l] = 0;
+
+			mpages++;
+		} else if (k &gt; 1) {
+			for (l = 0; l &lt; k; l++) {
+				unsigned long pfn = cur_dst_pfn + l;
+
+				dst[i + l] = cursor.start + ((m + l) &lt;&lt; PAGE_SHIFT);
+				svm_migrate_get_vram_page(prange, pfn, 0);
+				migrate-&gt;dst[i + l] = migrate_pfn(pfn);
+			}
+			mpages++;
+		} else if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
+			/*
+			 * A reused svm_bo page may still be held by someone else.
 			 * Reinitializing it would free it under this migration,
 			 * so leave this page in system memory.
 			 */
-			if (page_ref_count(pfn_to_page(migrate-&gt;dst[i]))) {
-				dst[i] = 0;
-				migrate-&gt;dst[i] = 0;
-				spage = NULL;
-			} else {
-				svm_migrate_get_vram_page(prange, migrate-&gt;dst[i], 0);
-				migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
+			busy = svm_migrate_vram_busy(adev, cursor, m, 1);
+			if (!busy) {
+				dst[i] = cursor.start + (m &lt;&lt; PAGE_SHIFT);
+				svm_migrate_get_vram_page(prange, cur_dst_pfn, 0);
+				migrate-&gt;dst[i] = migrate_pfn(cur_dst_pfn);
 				mpages++;
 			}
 		}
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
+		if (k &gt; 1) {
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
+			 * if not valid skip following SVM_HPAGE_PMD_NR - 1 pages
+			 */
+			spage = migrate_pfn_to_page(migrate-&gt;src[i]);
+			if (spage &amp;&amp; !is_zone_device_page(spage)) {
+				/* dma_map continuous SVM_HPAGE_PMD_NR sys ram pages */
+				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE*SVM_HPAGE_PMD_NR,
+						      DMA_BIDIRECTIONAL);
+
+				r = dma_mapping_error(dev, src[i]);
+				if (r) {
+					dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;,
+							__func__, r);
+					goto out_free_vram_pages;
+				}
+
+				/* get dma address for following SVM_HPAGE_PMD_NR-1 pages
+				 * since src pages are continuous their dma addresses
+				 * are continuous too.
+				 */
+				for (l = 1; l &lt; k; l++)
+					src[i + l] = src[i] + l*PAGE_SIZE;
+
+				/* migrate the SVM_HPAGE_PMD_NR pages above */
+				r = svm_migrate_copy_memory_gart(
+						adev, src + i,
+						dst + i, SVM_HPAGE_PMD_NR,
+						FROM_RAM_TO_VRAM,
+						mfence);
+
+				/* mark head page dma mapping as THP, tail pages dma addr
+				 * are set to 0 for following dma_unmap
+				 */
+				src[i] |= SVM_RANGE_DMA_THP;
+				for (l = 1; l &lt; k; l++)
+					src[i + l] = 0;
+
+				if (r)
+					goto out_free_vram_pages;
+
+				j = 0;
 			}
 		} else {
-			if (j) {
+			/*
+			 * single normal page case; a busy VRAM page is not
+			 * migrated, so treat it like a page with no source
+			 */
+			spage = busy ? NULL : migrate_pfn_to_page(migrate-&gt;src[i]);
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
+								 mfence);
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
 
@@ -436,12 +765,16 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free_vram_pages:
 	if (r) {
 		pr_debug(&quot;failed %d to copy memory to vram\n&quot;, r);
-		for (i = 0; i &lt; npages &amp;&amp; mpages; i++) {
+		/*
+		 * A split compound source allocates one dst page per tail
+		 * slot while mpages still counts the folio once. Release
+		 * every page that was published.
+		 */
+		for (i = 0; i &lt; npages; i++) {
 			if (!dst[i])
 				continue;
 			svm_migrate_put_vram_page(adev, dst[i]);
 			migrate-&gt;dst[i] = 0;
-			mpages--;
 		}
 	}
 
@@ -514,6 +847,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
+	bool is_private_device = false;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	dma_addr_t *scratch;
@@ -526,11 +860,18 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	if (svm_range_window_resident(node, prange, start, end))
 		return 0;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&amp;migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
+
+	if (SVM_THP_ENABLED &amp;&amp; is_private_device &amp;&amp;
+	    ((end - start) &gt;&gt; PAGE_SHIFT) &gt;= SVM_HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
+
 	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
 	buf = kvcalloc(npages,
@@ -711,6 +1052,57 @@ static void svm_migrate_folio_free(struct folio *folio)
 	}
 }
 
+/*
+ * Migrate one compound device folio at @idx to 4K system pages, used when
+ * no THP destination can be allocated.
+ *
+ * When dst[idx] is not compound, migrate_vma_pages() splits the source
+ * folio and then migrates every one of its SVM_HPAGE_PMD_NR pages, reading
+ * each tail dst slot without a NULL check. So every slot must get a real
+ * page here, not just the head.
+ *
+ * The device folio is contiguous in VRAM, so one copy covers all pages.
+ * On error, pages already published in migrate-&gt;dst[] and their DMA
+ * mappings in @dst are released by the caller's error path.
+ */
+static int
+svm_migrate_compound_to_4k_ram(struct amdgpu_device *adev,
+			       struct migrate_vma *migrate,
+			       struct dma_fence **mfence, dma_addr_t *dst,
+			       u64 *src, u64 idx, u64 addr)
+{
+	struct device *dev = adev-&gt;dev;
+	unsigned long l;
+	int r;
+
+	for (l = 0; l &lt; SVM_HPAGE_PMD_NR; l++) {
+		struct page *dpage;
+
+		dpage = svm_migrate_get_sys_page(migrate-&gt;vma,
+						 addr + l * PAGE_SIZE, 0);
+		if (!dpage)
+			return -ENOMEM;
+
+		dst[idx + l] = dma_map_page(dev, dpage, 0, PAGE_SIZE,
+					    DMA_BIDIRECTIONAL);
+		r = dma_mapping_error(dev, dst[idx + l]);
+		if (r) {
+			dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;, __func__, r);
+			dst[idx + l] = 0;
+			unlock_page(dpage);
+			put_page(dpage);
+			return r;
+		}
+
+		migrate-&gt;dst[idx + l] = migrate_pfn(page_to_pfn(dpage));
+		src[idx + l] = src[idx] + l * PAGE_SIZE;
+	}
+
+	return svm_migrate_copy_memory_gart(adev, dst + idx, src + idx,
+					    SVM_HPAGE_PMD_NR, FROM_VRAM_TO_RAM,
+					    mfence);
+}
+
 static int
 svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct migrate_vma *migrate, struct dma_fence **mfence,
@@ -724,6 +1116,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	u64 i = 0, j;
 	u64 addr;
 	int r = 0;
+	u64 l, k;
 
 	pr_debug(&quot;svms 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms, prange-&gt;start,
 		 prange-&gt;last);
@@ -732,8 +1125,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	src = (u64 *)(scratch + npages);
 	dst = scratch;
-
-	for (i = 0, j = 0; i &lt; npages; i++, addr += PAGE_SIZE) {
+	for (i = 0, j = 0, k = 1; i &lt; npages; i += k, addr += k*PAGE_SIZE, k = 1) {
 		struct page *spage;
 
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
@@ -749,6 +1141,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 					goto out_oom;
 				j = 0;
 			}
+
 			continue;
 		}
 		src[i] = svm_migrate_addr(adev, spage);
@@ -762,7 +1155,58 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr, 0);
+		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_COMPOUND) {
+			/*
+			 * Flush accumulated 4K pages before mapping the 2MB
+			 * destination, so a flush failure never leaves a 2MB
+			 * dst[i] mapping that is not yet marked SVM_RANGE_DMA_THP.
+			 */
+			if (j) {
+				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
+								 src + i - j, j,
+								 FROM_VRAM_TO_RAM,
+								 mfence);
+				if (r)
+					goto out_oom;
+				j = 0;
+			}
+
+			/*
+			 * HMM collects a compound entry only for a PMD fully
+			 * inside [start, end), so the folio cannot run past
+			 * npages.
+			 */
+			if (WARN_ON_ONCE(i + SVM_HPAGE_PMD_NR &gt; npages)) {
+				r = -EINVAL;
+				goto out_oom;
+			}
+
+			k = SVM_HPAGE_PMD_NR;
+			dpage = NULL;
+			if (IS_ALIGNED(page_to_pfn(spage), SVM_HPAGE_PMD_NR) &amp;&amp;
+			    IS_ALIGNED(addr, SVM_HPAGE_PMD_SIZE))
+				dpage = svm_migrate_get_sys_page(migrate-&gt;vma,
+							addr, SVM_HPAGE_PMD_ORDER);
+
+			/*
+			 * No THP destination (allocation failed or THP is
+			 * disabled for the VMA): migrate the whole folio as
+			 * SVM_HPAGE_PMD_NR 4K pages so migrate_vma_pages() finds
+			 * a page in every slot after it splits the source.
+			 */
+			if (!dpage) {
+				r = svm_migrate_compound_to_4k_ram(adev, migrate,
+								   mfence, dst,
+								   src, i, addr);
+				if (r)
+					goto out_oom;
+				continue;
+			}
+		} else {
+			k = 1;
+			dpage = svm_migrate_get_sys_page(migrate-&gt;vma, addr, 0);
+		}
+
 		if (!dpage) {
 			pr_debug(&quot;failed get page svms 0x%p [0x%lx 0x%lx]\n&quot;,
 				 prange-&gt;svms, prange-&gt;start, prange-&gt;last);
@@ -770,7 +1214,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
 			dev_err(adev-&gt;dev, &quot;%s: fail %d dma_map_page\n&quot;, __func__, r);
@@ -778,13 +1222,40 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		pr_debug_ratelimited(&quot;dma mapping dst to 0x%llx, pfn 0x%lx\n&quot;,
-				     dst[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(dpage));
-
 		migrate-&gt;dst[i] = migrate_pfn(page_to_pfn(dpage));
-
 		dpage = NULL;
-		j++;
+
+		if (k &gt; 1) {
+			migrate-&gt;dst[i] |= MIGRATE_PFN_COMPOUND;
+
+			for (l = 1; l &lt; k; l++) {
+
+				src[i + l] = src[i] + l*PAGE_SIZE;
+				dst[i + l] = dst[i] + l*PAGE_SIZE;
+				migrate-&gt;dst[i + l] = 0;
+			}
+
+			/* migrate the SVM_HPAGE_PMD_NR pages above
+			 * the migration is for 2MB THP
+			 */
+			r = svm_migrate_copy_memory_gart(
+						adev, dst + i,
+						src + i, SVM_HPAGE_PMD_NR,
+						FROM_VRAM_TO_RAM,
+						mfence);
+
+			/* mark head page dma mapping as THP, tail pages dma addr
+			 * are set to 0 for following dma_unmap
+			 */
+			dst[i] |= SVM_RANGE_DMA_THP;
+			for (l = 1; l &lt; k; l++)
+				dst[i + l] = 0;
+
+			if (r)
+				goto out_oom;
+
+		} else
+			j++;
 	}
 
 	if (j &gt; 0)
@@ -849,6 +1320,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node-&gt;adev;
+	bool is_private_device = false;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
@@ -856,6 +1328,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&amp;migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
@@ -866,6 +1340,10 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	else
 		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 
+	if (SVM_THP_ENABLED &amp;&amp; is_private_device &amp;&amp;
+	    ((end - start) &gt;&gt; PAGE_SHIFT) &gt;= SVM_HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
+
 	buf = kvcalloc(npages,
 		       2 * sizeof(*migrate.src) + sizeof(u64) + sizeof(dma_addr_t),
 		       GFP_KERNEL);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------Mlf5wVxRGfSPFfhivwAl0nvG--
