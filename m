Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C79C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 21:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E402610EEF0;
	Thu, 30 Jun 2022 21:39:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B133D10EB94
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 21:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvbxsqmn4iNRjHui1tPL/JcjP44ny376iLnhpQ4Gmj1XVbjkVSvTvpIzbgkme4WTwakWtpbTnLXpOVNAkIGDnPr0cXIvz9AzGusuNhgv1fSp7+TPLdG6ltF1aEzBQ3saAfgsMt36jyGbWOhY6IAXV231rwP2d+0zCBYsvV2lvleouKSCZ97W6w5+QfQv0YnhJvOcVpIqSWpjuB+U3vhj3n3nqm04sr7mBHIAA0um/hWYpztir/z9sOO5p2FsZK6LmnYGVm5QqImbEwGoyA1p1ELB6MGltlp1q7Rxr3has2Ep2eM0ZTGAtui0nksxuMGZvBKlcoYUTvsHvfet4o1GzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrjvlDv87nLhTqjBxbzQRtyUeMp5rOjd0Nkheat7lDQ=;
 b=guVJxaTRkPq16h9HVp4rfcNOKcg3aRxWB5L40bVuELFKIDYEFnLUUoiDQAG8IZ5Zxvt6r8SxqmRTFxWTA5c7HLluU8f5Ym5fiptsXn83YNaUPDBJlCu5tEG9d3vv7y3+qoY+9VAw3u4bCbulnzTqDpMvo1gUmWmSywMJlJ1d4NvED0ppPL+1LL0iSkRFL5ibgQS5yOL6rJL4vrrAeOZupf7PA9DpIW5YTRtebV6kbph5zeNm9X1KLfaCzptUakjv3kX4wyjZeLa7kjpiU3rzQCSyZihNXV0400HkpZz6mcJXR2iYjvffZJH9bEzVIzXaurTseHUFzgIeSt2zWCoz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrjvlDv87nLhTqjBxbzQRtyUeMp5rOjd0Nkheat7lDQ=;
 b=piOPMgxaSgedWmj+2+m/Ec7RYZ43PUBJgkY3RwA9ma6yaGRg/iOumPgQgdaSsjVsH1bbEC0jPnzdySFOg8Ow2eW9F2xL3aWg8ZCw/v0pf32NhPfAKY5PGPgJRi0NpclFoqmKEb3lPpoAffJ+0OBTuzABHTgIT8CyjZjCTd0mZLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 30 Jun
 2022 21:39:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 21:39:09 +0000
Message-ID: <3fa6edab-880a-eda1-355f-3ea924721722@amd.com>
Date: Thu, 30 Jun 2022 17:39:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] libhsakmt: allocate unified memory for ctx save
 restore area
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220630190309.119238-1-jinhuieric.huang@amd.com>
 <20220630190309.119238-6-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220630190309.119238-6-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:207:3c::40) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5b03af4-3b7d-4814-702e-08da5ae0f779
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5USYvBjltjKCP1fr1DGg39D2o+EsabXEkD8WehdQss1+Nq2PWJJVsb1aRaAXxXMz293BIEcgGcVBdQKRpAtTendXnPuZiLfnxVkBBk/XOGTwz5dXbnw0xJ5390zqhu45/WTnKoTqOcq61l/tT8ayzhFm06n+61HDe92YxbZctM1Tc9SFTdfUpO9OxOYc/u0T9hZ4vnrY6NkL9XK9hgkwDLMuNZR84VdnxjcACHQlPJK0CZDXXISpyE1TB0TB4jIwxVJe5q1lYwnpZxbS1xGH14ATXQ8kZm8hRLmTZxBkkhLKgvKHYfLHuVk0iDChHgl7oxpYcR1DRXyih1nX2M12zrFZHI0yQpueCyU13ADKV54pVwMZ0AU5+2fMSwlJ0jJSctfPomrM7x9FOvBzRaNz4YPqhdQuAB2EDBSAYOI7oKPFelirpRJuSYEuIPieMrOZic7m6bfQe7Z0nWEglieK5WXYQWz/AKogOpjol0EdyDO0UBHYKBEi75GYknpW1I1FWH0ijeFAg8mdk/DCAsdgcRGl0ycYtkTizCgd/WkC6Wa5NElQP/J3dLR2ZhB3ueon1DEg9TlfITVyBw6azKq3wFSR9BPoTmis7dkb6kVc0mSbiBQ3UJ/Ix//b41PZjAcbyI40WdoI/qIm1Ak5zWBJqJRTKIUnXkqByerpWc6UQgIKeu1Nvbiqf6WwkmpZ2RsmKV0VHcFI4R4J2xyAKgprpKUm8d7w0SL+LdUaXg1qBCn3T5i+ygIM7iwP8JEw+oLtHiLjATlmWgx1t6lV5VJysIqp6XaQ92iZu0CdvBiOOz179mbTX2gQ24w3lw0lox30IHbvlg0yUwKKRFSU2pFaRPEAMxM5fFKDbDjlQXRp46k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(478600001)(38100700002)(31686004)(6506007)(316002)(2616005)(4326008)(36916002)(8676002)(83380400001)(66476007)(86362001)(2906002)(8936002)(26005)(6486002)(53546011)(44832011)(36756003)(41300700001)(6512007)(31696002)(66556008)(186003)(5660300002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1kwaEVtZ2xKU0htL29ycWdOYlRFaWVTOFdWZEtLbUZ3NnhTeGtCeVQ4VzY4?=
 =?utf-8?B?NFMrUWxEUlR0SzFuYzBGTUFHMVl1eGZJWTZ1aFMzM25PMUlaSitRU1R4S290?=
 =?utf-8?B?RU5pcXZiemtmMEg2aEhmV2tLUXBPL2FBVFJKWGVuamdUUXlVNzFXV1ZKcjNM?=
 =?utf-8?B?OUpHRmZQOS9ZbVY0UDgwb25pVHFjT0RnT1lzQnRnU3U2b0x1VHJkb3JLb1Nm?=
 =?utf-8?B?NjVEelROSG5aYmtZUFdVZU5oWmNKOTJNd0liY2gyRlRqb1V4YWRxcVA1TU5W?=
 =?utf-8?B?SjBkRnEybGJLcHJRbE8raWgvQTAxcVFMdmNjbGloUlpGbUFUM3VEK05pczli?=
 =?utf-8?B?ZG5zemZlR0RMZ3ZQYWszUVg4SXIxaFhOUFlRTUZzdnNHaEVGcFRZb2tvZWVt?=
 =?utf-8?B?cFZwYlFBU0FZY0hpQTBvMEJsUi9FSHZ5SHhVSnIvcHVPazRYSjAzT1ZJbTV2?=
 =?utf-8?B?ekQ4cThMTUFMSkViTW84N00reGNxYUhGc3ZFWDJwM1pNSUZQTCtxbkl1bElH?=
 =?utf-8?B?bW5ScGlLcjNBcUZaam9jcU5VeStTTVVJQkE1RDlWSXFuV2t1V1Z1Uk1SMWFF?=
 =?utf-8?B?OFJHODI4Q3g4ZmcrT1BsNnVQSDgzOHpQOWV2a3FDRUpHYzhxcWwrcnpIc203?=
 =?utf-8?B?NUMyY0xxVlF3aVM5dWhKQnJKdXhDNnB5SzNuYjlRSCtReEtHM3JSRzVQTC9K?=
 =?utf-8?B?Znk5dlV4RnM5ajR6cEpCOUQyNHYvbkdBWWtvQ1pISU1TNm5PMFUxOUZUSjZD?=
 =?utf-8?B?RjBoWGhnU0NsYVZYYlVKSExJZUREODl5aUovN1FwT1RQa2RNVFdybFNTNm9h?=
 =?utf-8?B?eWRyakE3bWs5ZVhXQ1hROWtnODhZM1pxMFNGV3RZNFNQY1JQd3FHTEM2UWNv?=
 =?utf-8?B?dXg0VmNBaXpka21rd014cnprbmx0WHh1RXVRQmVGVFF6Q0Z1TzUxSWJ4aVV4?=
 =?utf-8?B?S0ZCdWkybGVJckhjT1hncG51YVlTNUZ3WEZnMlVEYlAyR05DLzdjU2l5VXpH?=
 =?utf-8?B?eXJMSVJKZGZYZnNWcXFJMkZXc1RmZ1ZKM2hVbzdKdFhqeTZNbUxlMjNBUm04?=
 =?utf-8?B?Uk9FSjhvYkRIQjUzSTU5NTlkTXBSK0VqWUQrMTJnVHcwMUEvWlVjNlB4RlFs?=
 =?utf-8?B?K3BYNnRvOXZFODFSUUVPK0oxK3ozM0M5UmVTRG9UTFcvL1FZciswelhHeGgw?=
 =?utf-8?B?K2hOZGsyN2hLZXFHUzBMSVNtSExUZXJvOWFyZWxnRzE4bFh2Q2t5aStFUk9K?=
 =?utf-8?B?TExVTy90TmZBWXRTRy9EMmloa2NqdE05b1MxNlJPZ2hhODNXekxXTXBBWHhj?=
 =?utf-8?B?dis0Zi95RlZzN24yZ2xCSTdNMXJnTDBlWWxHV0FnUzE5MSswVllselpzVHQ0?=
 =?utf-8?B?UWwzaThSUExuU2hOK1J1eE9SQTNITWovNmZrb0tnOVhjZE5xRmxOZWxVNW1i?=
 =?utf-8?B?V1cxSHgwbEovR3h6YVJWakpPKzA1Tmh2dTJOaDl5bmtQOVg3MWhGWlBIY0V6?=
 =?utf-8?B?dGlMd2F3SUE1RktJRzhuKzB3MFNOSzNWVnBrK0NyNVowajQrQ3dBTFVQRXRj?=
 =?utf-8?B?ZTlrbURHamhkTjVhaWQ5dlFySEVLcExvQjljdFdMVDdSUjFKL3JqbTAxMm9i?=
 =?utf-8?B?U2NLbXpqaXdnTXpCUzY2RWRPS0dFOXJ2VU8vK05WUjhoMCtNSGVhM2Y2SHR4?=
 =?utf-8?B?eDhTTUYxallCdWwzVHV1NWxFa1ZkRVZVSHVvVnkrbFNFNUg2TnZteUozbitD?=
 =?utf-8?B?RVBzcTZXUHhPRnova09iYjJRTWJ1VCtlU2dlSmNRTzBvZG92d3dSNVd4dlhI?=
 =?utf-8?B?Nit0SGhWVFA4L29SeDkxN1o4dHhZcStpb1ZrbjZwZjF4cW96RDhXTG9nSTdC?=
 =?utf-8?B?V1JOcnByMWc3bkRxdmQxZXltRHZsb0I1LzJDSEd4ZUsxOVlVblRuZU5YcGVB?=
 =?utf-8?B?Ti9pV0M1V09tVXhEMzczVnFFc3VSZFJTTUp2Tms1Zm9kb1Z0K0NRMmpNajVT?=
 =?utf-8?B?c0tJTzhjV0RiaXA4dXF5MlVVLzk3NFZuTktyVW8wNjlxRnJNb0YxUG9mWldz?=
 =?utf-8?B?L3BjdmN6MFVYU0dBZ0gwbHZWSlhTTEJXWk9IQjhJYWNSOGMwVm5xZWwvL05X?=
 =?utf-8?Q?Ar9mlp4ZCUsaA46aHQst6FXP7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b03af4-3b7d-4814-702e-08da5ae0f779
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 21:39:09.8857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKuznV/cSPl1R7pcmMYCBjrwm6PDMXD35OhIi8ZGsi0b+puOEb6OISE/hn/NMgEwzKuuhB5c6RBWr7h8BqHl7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-30 15:03, Eric Huang wrote:
> To improve performance on queue preemption, allocate ctx s/r
>   area in VRAM instead of system memory, and migrate it back
>   to system memory when VRAM is full.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> Change-Id: If775782027188dbe84b6868260e429373675434c
> ---
>   include/hsakmttypes.h |   1 +
>   src/queues.c          | 103 ++++++++++++++++++++++++++++++++++++------
>   2 files changed, 90 insertions(+), 14 deletions(-)
>
> diff --git a/include/hsakmttypes.h b/include/hsakmttypes.h
> index 9063f85..2c1c7cc 100644
> --- a/include/hsakmttypes.h
> +++ b/include/hsakmttypes.h
> @@ -1329,6 +1329,7 @@ typedef enum _HSA_SVM_FLAGS {
>   	HSA_SVM_FLAG_GPU_RO      = 0x00000008, // GPUs only read, allows replication
>   	HSA_SVM_FLAG_GPU_EXEC    = 0x00000010, // Allow execution on GPU
>   	HSA_SVM_FLAG_GPU_READ_MOSTLY = 0x00000020, // GPUs mostly read, may allow similar optimizations as RO, but writes fault
> +	HSA_SVM_FLAG_GPU_ALWAYS_MAPPED = 0x00000040, // Keep GPU memory mapping always valid as if XNACK is disable
>   } HSA_SVM_FLAGS;
>   
>   typedef enum _HSA_SVM_ATTR_TYPE {
> diff --git a/src/queues.c b/src/queues.c
> index c83dd93..d5109f9 100644
> --- a/src/queues.c
> +++ b/src/queues.c
> @@ -68,6 +68,7 @@ struct queue {
>   	uint32_t eop_buffer_size;
>   	uint32_t gfxv;
>   	bool use_ats;
> +	bool unified_ctx_save_restore;
>   	/* This queue structure is allocated from GPU with page aligned size
>   	 * but only small bytes are used. We use the extra space in the end for
>   	 * cu_mask bits array.
> @@ -383,13 +384,47 @@ static void free_exec_aligned_memory(void *addr, uint32_t size, uint32_t align,
>   		munmap(addr, size);
>   }
>   
> +static HSAKMT_STATUS register_svm_range(void *mem, uint32_t size,
> +				uint32_t gpuNode, uint32_t prefetchNode,
> +				uint32_t preferredNode, bool alwaysMapped)
> +{
> +	HSA_SVM_ATTRIBUTE *attrs;
> +	HSAuint64 s_attr;
> +	HSAuint32 nattr;
> +	HSAuint32 flags;
> +
> +	flags = HSA_SVM_FLAG_HOST_ACCESS;
> +
> +	if (alwaysMapped)
> +		flags |= HSA_SVM_FLAG_GPU_ALWAYS_MAPPED;
> +
> +	nattr = 5;
> +	s_attr = sizeof(*attrs) * nattr;
> +	attrs = (HSA_SVM_ATTRIBUTE *)alloca(s_attr);
> +
> +	attrs[0].type = HSA_SVM_ATTR_PREFETCH_LOC;
> +	attrs[0].value = prefetchNode;
> +	attrs[1].type = HSA_SVM_ATTR_PREFERRED_LOC;
> +	attrs[1].value = preferredNode;
> +	attrs[2].type = HSA_SVM_ATTR_CLR_FLAGS;
> +	attrs[2].value = ~flags;
> +	attrs[3].type = HSA_SVM_ATTR_SET_FLAGS;
> +	attrs[3].value = flags;
> +	attrs[4].type = HSA_SVM_ATTR_ACCESS;
> +	attrs[4].value = gpuNode;
> +
> +	return hsaKmtSVMSetAttr(mem, size, nattr, attrs);
> +}
> +
>   static void free_queue(struct queue *q)
>   {
>   	if (q->eop_buffer)
>   		free_exec_aligned_memory(q->eop_buffer,
>   					 q->eop_buffer_size,
>   					 PAGE_SIZE, q->use_ats);
> -	if (q->ctx_save_restore)
> +	if (q->unified_ctx_save_restore)
> +		free(q->ctx_save_restore);
> +	else if (q->ctx_save_restore)
>   		free_exec_aligned_memory(q->ctx_save_restore,
>   					 q->ctx_save_restore_size,
>   					 PAGE_SIZE, q->use_ats);
> @@ -425,6 +460,8 @@ static int handle_concrete_asic(struct queue *q,
>   	if (ret) {
>   		uint32_t total_mem_alloc_size = 0;
>   		HsaUserContextSaveAreaHeader *header;
> +		HsaNodeProperties node;
> +		bool svm_api;
>   
>   		args->ctx_save_restore_size = q->ctx_save_restore_size;
>   		args->ctl_stack_size = q->ctl_stack_size;
> @@ -434,22 +471,60 @@ static int handle_concrete_asic(struct queue *q,
>   		 */
>   		total_mem_alloc_size = q->ctx_save_restore_size +
>   				       q->debug_memory_size;
> -		q->ctx_save_restore =
> -			allocate_exec_aligned_memory(total_mem_alloc_size,
> -					 q->use_ats, NodeId, false, false);
>   
> -		if (!q->ctx_save_restore)
> -			return HSAKMT_STATUS_NO_MEMORY;
> +		if (hsaKmtGetNodeProperties(NodeId, &node))
> +			svm_api = false;
> +		else
> +			svm_api = node.Capability.ui32.SVMAPISupported;
>   
> -		args->ctx_save_restore_address = (uintptr_t)q->ctx_save_restore;
> +		/* Allocate unified memory for context save restore
> +		 * area on dGPU.
> +		 */
> +		if (!q->use_ats && svm_api) {
> +			uint32_t size = PAGE_ALIGN_UP(total_mem_alloc_size);
> +			void *addr;
> +			HSAKMT_STATUS r = HSAKMT_STATUS_ERROR;
> +
> +			if (posix_memalign(&addr, GPU_HUGE_PAGE_SIZE, size))
> +				pr_err("[%s] posix_memalign failed:\n", __func__);
> +			else {
> +				header = (HsaUserContextSaveAreaHeader *)addr;
> +				header->ErrorEventId = 0;
> +				if (Event)
> +					header->ErrorEventId = Event->EventId;
> +				header->ErrorReason = ErrPayload;
> +				header->DebugOffset = q->ctx_save_restore_size;
> +				header->DebugSize = q->debug_memory_size;
> +
> +				r = register_svm_range(addr, size,
> +						NodeId, NodeId, 0, true);
> +
> +				if (r == HSAKMT_STATUS_SUCCESS) {
> +					q->ctx_save_restore = addr;
> +					q->unified_ctx_save_restore = true;
> +				} else
> +					free(addr);
> +			}
> +		}
>   
> -		header = (HsaUserContextSaveAreaHeader *)q->ctx_save_restore;
> -		header->ErrorEventId = 0;
> -		if (Event)
> -			header->ErrorEventId = Event->EventId;
> -		header->ErrorReason = ErrPayload;
> -		header->DebugOffset = q->ctx_save_restore_size;
> -		header->DebugSize = q->debug_memory_size;
> +		if (!q->unified_ctx_save_restore) {
> +			q->ctx_save_restore = allocate_exec_aligned_memory(
> +							total_mem_alloc_size,
> +							q->use_ats, NodeId, false, false);
> +
> +			if (!q->ctx_save_restore)
> +				return HSAKMT_STATUS_NO_MEMORY;
> +
> +			header = (HsaUserContextSaveAreaHeader *)q->ctx_save_restore;
> +			header->ErrorEventId = 0;
> +			if (Event)
> +				header->ErrorEventId = Event->EventId;
> +			header->ErrorReason = ErrPayload;
> +			header->DebugOffset = q->ctx_save_restore_size;
> +			header->DebugSize = q->debug_memory_size;
> +		}

Is there a way to refactor the code that avoids duplicating the header 
initialization? Maybe move it into a helper function.

Other than that, the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +
> +		args->ctx_save_restore_address = (uintptr_t)q->ctx_save_restore;
>   	}
>   
>   	return HSAKMT_STATUS_SUCCESS;
