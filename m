Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4693CC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 17:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0872E6142C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 17:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0872E6142C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7B86ED85;
	Thu, 13 May 2021 17:19:36 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD936ED85
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 17:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBuStVM9bW1fZwv918/AjmqulHssgBCRwZu5+cmQbFVb8mPdJAQjcx0/og+6O2Da2sa7d6rRd4B1o6tBtwabr3ankM98d098gKy/4P/3QcZQkukzRfH57+fwidXOR0bFAVx4CRa/kF4l7T/Sjjp0Se04fuFPGaH4EALhghc+G+NPKdXO04ZQdkwnDOkflOnBSyEw1ZGCO1CDnH16fwJziA47fz5ZkWp/5ciIaEZdxvRsUdx7oxndIboq7pbUG6Bf1XRlb9omp3rz/rwBcXcE4PpUAYo7gPsNfgL5lQX7Cqd5z6gsKCb8gVf4OXJGW4KaZKhEKzyV6+5Ey8D8vh7B4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7maHPGuhEoHulqZVR+KB5u3qY+sFgconCoqPargncAA=;
 b=XFmJG0U1L7PikiYBSiovn5zF923mwzfQb1aDs2p9r4H8gswjXVTln1+RDJ6OkYXrx8BreW8DHIFjv+mZyBZ4AIRPw8S7915HM1Rxje5sgqMELzOXH879nvVnKBWWR6sjIiWgoD0kCBkXY7QrWAMooTMSfl8cd3RU6UU/O/aiPVU/QZ6Z4Z4yHjLPHQ5ueEpS5oxgOWuQIyaBlmt+GeGyGOswNiH0Sj2cErOXWAiNk4q4wpyvAYcuGQjhNuROJR8d6WtxZl9y08XNT6tbUAhQ4dsURQjxi9Tj2iwP/dzpjfCh+3P7iWYGmt4JL+wXfZoy8BBIYs/gWUmIlsSPK72Mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7maHPGuhEoHulqZVR+KB5u3qY+sFgconCoqPargncAA=;
 b=uWd992iqvE1145dHt55KkBeXazBj23d2M9cG/k5I/xtJG6u7TwfiKZB68x4bMaEg6aJMRzKkMCwIzrsbrLv7eDcASHtRxiGwIpojRESIurSxgLeEUBblcMdJ2c/XXXzvvVrC6+nB8FHRGMhbAhMA3qDayRCgBRaoFt5SvrMBECg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 17:19:34 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 17:19:34 +0000
Subject: Re: [PATCH v3] drm/amdgpu: flush TLB if valid PDE turns into PTE
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210512123451.25900-1-Philip.Yang@amd.com>
 <20210513165809.16198-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <18ac59c0-c1fa-9856-1667-410362707ff7@amd.com>
Date: Thu, 13 May 2021 13:19:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210513165809.16198-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Thu, 13 May 2021 17:19:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e307283-15b4-4ee6-5705-08d9163346d4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51292ECE50A155A95E735EB592519@BN9PR12MB5129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aF2lJhSwLR2D0rDlNPFfZcco6+Zgdebx5YEOI6bmP1hDWm5mR1Ra761sviR437hfi3A4CKtUp6zq0BlwdRad8Ks0zMdkhwASqsJq73onVekSlh5hUIVfzAS6esvQIvSIFb6CRDkodSdNzpV/TJqWClR9P6yFms8e7Ch6CqQXmOThL1gXxOhyMMWonX5gNOsyTZYz35r57UxBHhfFI6riaEqcgcza6D3nxpr1G6kEJ/XSAxSDO7p5eshbYSI/kJ9EJkvd0tz5teaoDiVaPwqaVmxdJZ2rBQ1prC5BeGkd+XcBOp7UOUdTldgZUD+RLI6bvia/+p+D8HM/hB9E122UdBqcjgcytBzqo/LuW9RDOY6cDR5OJWZTjM8pyNaYU5GhzuM7zrBzRp9bXLdDsh3modqe2V55E4O2UYCRvOYxa1Or2lIstdOeRQsYznWu/qRP4ESZ3oZQk3Ot5+48FaZ77T/6XoZ/LvC1eFeJx0R6QtRVZ+ZjLpmI0HiSW5EteFEdxWKJSAGc75516gsghMLkxnGTgtzzdkf7bBH3PY4nqYDNwR/pqbj2iI6+19xhY6oxfcXeIm9BLv6G6UBSEMdQC0E09AxYzh7E129/voFaTKyJgkZK7Q4T2v0ZO5zv9VSivNzEgYXc2IBSSsOTfjdFtTVfNHWIR/tDYVljTysZhmrz/SxhwKLsTyYAVN75d11r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39830400003)(136003)(376002)(346002)(396003)(38100700002)(2616005)(8936002)(44832011)(956004)(66946007)(36756003)(16526019)(26005)(2906002)(31686004)(5660300002)(83380400001)(86362001)(478600001)(6486002)(8676002)(16576012)(186003)(31696002)(66476007)(66556008)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aXNXKzF5SUdJNGF6cHVuTnRjWm9pVjVlaFBXMGRMWXdqOUlVMjlLM3BKdlA0?=
 =?utf-8?B?aTFVbm1uM2x0SCtQWWtIRStpT1hCT0dMUk1sM0dIUzMyOEZaWS9xaVh3MytT?=
 =?utf-8?B?U2I5a1JWdWpwK1dZemxJblc4Q0VCWHAyeUlWa3NoTjJ6THBEZmM5R3orc0Yr?=
 =?utf-8?B?L25DcWlseDN4d1BHUzlmNWs4cWRmYU1QU1RYK1Y2SE1uR3FtdHd4NU1aMEFB?=
 =?utf-8?B?S2RURWcxSEZjZnhRb2Nremxpajd5Sml1MHNnQWJ5UUZyYXhENkRHVS8vbVpx?=
 =?utf-8?B?VFdVeWRsZFNUdjhJM0ZmUVNhVG8ycno5NEY4M0l0Q3Y4TVdSbTBWN04wZmlk?=
 =?utf-8?B?dnFHclRocW5UK1lnQnlMT1NOSWlwa0c4amp6aEErSWp4YWU0alZubmd2VURp?=
 =?utf-8?B?bGZ6UVA1MFh5SC9GVjBwY0dQU1EycHB3UGI3OGlITDhxV3MvVlA2Q1pMZStE?=
 =?utf-8?B?cjFGakR5am9tdmVRVUNlUE8xSWwxdEMwdTlzem5kbFFRQ1dVSTN1N1h6NUtG?=
 =?utf-8?B?UFVBTS9hQlMwWDRFOEV2c3NqT3hjWDFhbHZrTkVtd0VVTlhFZFZsYWJRLzN3?=
 =?utf-8?B?bE5ZMEttMGxUaXhLeC9kSHlGQ0xXeWpPdEVhNHBGdEZpZ3JVV1QzSWt5TnMz?=
 =?utf-8?B?azZ1eWkrWllQVGVhUS9UZEJNNXkzL29EYm9vVFBsejEwaGJkRXFGUnZVY09B?=
 =?utf-8?B?Vkg5VXhwSm5zTkZ2WU9UbGYyTFhYeVVIR0cwa1NLaVpENStaMFdicTBrTWxv?=
 =?utf-8?B?SisvMVR4NjhPdkNmNUZSeUltN2JjbmxlSndmTHRrZTZMeU8wZUJQaG5GSFdm?=
 =?utf-8?B?dnJ4aDhsMW1RTFhtTHBwdzdOY0ZPNjBXTXcrQTI1N09haGxxQkZWT0V3dVVB?=
 =?utf-8?B?eExsaGl0MUhWWHVLYzZ3bHhacFRQblZoNG5DMG5Zd2VWMERuVHpWVzhjbndR?=
 =?utf-8?B?NVZjTE1IQW5qZnQxN3dsZU5PNG80aitHQWRIZXJmVXJSTXZ2SUExWWhpS0Vi?=
 =?utf-8?B?eTI1ZFl4MGt1dXdyTm9PL0hLV0wyL21KMngxcHo2SDd0ZE10TTVHQUVIYy80?=
 =?utf-8?B?TFRYSVlqcjJSWlVUWUV3aUtqajV0NVQ0WEFmMDg2U2lPVFpYVU95K3BYVTRY?=
 =?utf-8?B?OWpJWVZkY1ZVMDhoL3Z2Tm1ZU3RrTGUwL1AzSG5JaEdhRzRQTnhTLzlPekwz?=
 =?utf-8?B?d0dZTzJwVVdVMVV4d0lsdGZyUitwWk16eDhrTjl5TGc4SEFmYlkvT1ppazEy?=
 =?utf-8?B?TlBCN01MNGFkRVNKKzd5VDgwZDducVl3clQwNmhXdlVlVVd6ZFplN0ozR25r?=
 =?utf-8?B?UzlySk5vSmlKUmxnT0F6WWVObHUzQ0tsc2pDcWNGRUVYelBEeE10UHhvTWxv?=
 =?utf-8?B?ZTVFYlg1S3kxZFJ6c1JOcC9qWUdRUUxIUVE5dFRHRUdsd2hWbW9sYjlSWjlr?=
 =?utf-8?B?Z1Ztd0N0VUg4SlFMQ09rL21IZXlicUZ4QnBhYnEzSnlRWDZaeUgzcDYxL3d1?=
 =?utf-8?B?cWIyNktGRERqNys0K3dJKzR0Ym1OWlFZMzhKRnJmWnJwalhnT01SWmYzUGpr?=
 =?utf-8?B?dThpTWoyT3h5MGRadDRxaDgzUU1lUENtcFkvdTh3YmZ1Ukx4Y0VRWlhQa1dM?=
 =?utf-8?B?d0psbkVRdDRCc3VQamVZRlhGNzA0dDRXWFlHeVQrMG13aVZZMzJ4NXVVeFA1?=
 =?utf-8?B?VkV5ZjBOTWd0NGRRc2FsWEJlMFkzRmtqak1BbVhOenFxRHpCYXV5WFcyejBQ?=
 =?utf-8?B?cmdyN1BYTGJTbzBUYTVSR3haUGY4VWJkUysyUzJMVE95b21PWXJGMzVyT29w?=
 =?utf-8?B?MU5ZODVPQnl4K00zSldKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e307283-15b4-4ee6-5705-08d9163346d4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 17:19:34.1142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2rk1A8y71HnYm9e7v5Z1/27Z3prdNKHyxxkzvD/Y0jeq9zNdkNiyRPIYmy2roSPSQ273pXdgEYUUrLe4tKPHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
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

Am 2021-05-13 um 12:58 p.m. schrieb Philip Yang:
> Mapping huge page, 2MB aligned address with 2MB size, uses PDE0 as PTE.
> If previously valid PDE0, PDE0.V=1 and PDE0.P=0 turns into PTE, this
> requires TLB flush, otherwise page table walker will not read updated
> PDE0.
>
> Change page table update mapping to return table_freed flag to indicate
> the previously valid PDE may have turned into a PTE if page table is
> freed.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 ++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  7 ++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 13 +++++++++++--
>  3 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3dcdcc9ff522..7e4c60a90eee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1583,6 +1583,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>  			while (cursor.pfn < frag_start) {
>  				amdgpu_vm_free_pts(adev, params->vm, &cursor);
>  				amdgpu_vm_pt_next(adev, &cursor);
> +				params->table_freed = true;
>  			}
>  
>  		} else if (frag >= shift) {
> @@ -1610,6 +1611,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   * @nodes: array of drm_mm_nodes with the MC addresses
>   * @pages_addr: DMA addresses to use for mapping
>   * @fence: optional resulting fence
> + * @table_freed: return true if page table is freed
>   *
>   * Fill in the page table entries between @start and @last.
>   *
> @@ -1624,7 +1626,8 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>  				uint64_t flags, uint64_t offset,
>  				struct drm_mm_node *nodes,
>  				dma_addr_t *pages_addr,
> -				struct dma_fence **fence)
> +				struct dma_fence **fence,
> +				bool *table_freed)
>  {
>  	struct amdgpu_vm_update_params params;
>  	enum amdgpu_sync_mode sync_mode;
> @@ -1736,6 +1739,9 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>  
>  	r = vm->update_funcs->commit(&params, fence);
>  
> +	if (table_freed)
> +		*table_freed = params.table_freed;
> +
>  error_unlock:
>  	amdgpu_vm_eviction_unlock(vm);
>  	return r;
> @@ -1879,7 +1885,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  						resv, mapping->start,
>  						mapping->last, update_flags,
>  						mapping->offset, nodes,
> -						pages_addr, last_update);
> +						pages_addr, last_update, NULL);
>  		if (r)
>  			return r;
>  	}
> @@ -2090,7 +2096,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  		r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
>  						resv, mapping->start,
>  						mapping->last, init_pte_value,
> -						0, NULL, NULL, &f);
> +						0, NULL, NULL, &f, NULL);
>  		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>  		if (r) {
>  			dma_fence_put(f);
> @@ -3428,7 +3434,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  	}
>  
>  	r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, NULL, addr,
> -					addr, flags, value, NULL, NULL,
> +					addr, flags, value, NULL, NULL, NULL,
>  					NULL);
>  	if (r)
>  		goto error_unlock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ea60ec122b51..e91288d637ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -231,6 +231,11 @@ struct amdgpu_vm_update_params {
>  	 * @num_dw_left: number of dw left for the IB
>  	 */
>  	unsigned int num_dw_left;
> +
> +	/**
> +	 * @table_freed: return true if page table is freed when updating
> +	 */
> +	bool table_freed;
>  };
>  
>  struct amdgpu_vm_update_funcs {
> @@ -404,7 +409,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>  				uint64_t flags, uint64_t offset,
>  				struct drm_mm_node *nodes,
>  				dma_addr_t *pages_addr,
> -				struct dma_fence **fence);
> +				struct dma_fence **fence, bool *free_table);
>  int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>  			struct amdgpu_bo_va *bo_va,
>  			bool clear);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b665e9ff77e3..a518ad26ceec 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1084,7 +1084,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, true, NULL,
>  					   start, last, init_pte_value, 0,
> -					   NULL, NULL, fence);
> +					   NULL, NULL, fence, NULL);
>  }
>  
>  static int
> @@ -1137,6 +1137,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
>  {
>  	struct amdgpu_bo_va bo_va;
> +	bool table_freed = false;
>  	uint64_t pte_flags;
>  	int r = 0;
>  
> @@ -1159,7 +1160,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  					prange->mapping.offset,
>  					prange->ttm_res ?
>  						prange->ttm_res->mm_node : NULL,
> -					dma_addr, &vm->last_update);
> +					dma_addr, &vm->last_update,
> +					&table_freed);
>  	if (r) {
>  		pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
>  		goto out;
> @@ -1175,6 +1177,13 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (fence)
>  		*fence = dma_fence_get(vm->last_update);
>  
> +	if (table_freed) {
> +		struct kfd_process *p;
> +
> +		p = container_of(prange->svms, struct kfd_process, svms);
> +		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
> +						  p->pasid);
> +	}
>  out:
>  	prange->mapping.bo_va = NULL;
>  	return r;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
