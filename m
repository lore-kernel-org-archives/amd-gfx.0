Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F713C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 08:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B28613D0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 08:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B28613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7E36EB7E;
	Wed,  2 Jun 2021 08:33:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E79816EB7E
 for <amd-gfx@freedesktop.org>; Wed,  2 Jun 2021 08:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boDuFWKlmIqdAzawNuH7FlwM/ojbW7nvZ5Fo9ApTO0woXI1dHs4F9p6xzVq5eRLoByGU7mVdJDVcXTtibV4nsL9wncc1aVmQ2SWqhZJZJKkUUrOfvxfzeLg4ssX9ftL0P0GbRXeajIp/dOQzBSPLZarRsOIalUKg6jaaWERN0rv9O+X18RR0z8lgKDCD8lhMa8HjL5XsBoKElIkrxom2WglDoEgyNw3oiy82h1R5mJphA9/HDL0MWK8iNrbL0yLaxZ8abE8X/EvQu40IEaU/aF3srs4l366LhESzN8NHVAb0VLFJEZLZ8S0rr3IsxYCaLBaxxwz/oa95X7ojhTC5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00EINdWCauBZpnKhhgiDu/FLthu4+8U2Wd7Q5p9IMgA=;
 b=WSsMMDmsob8k9q4twI7XTeZ1CQhY5XgPQALwhMprpDMNldU99xA2GUZzjCIzhwQ5oOrUAimVFPehaprsXx1ekPSlMVfVy7vEDb7Wx7mTpCYLa1XAWjDPXsyvvrHNuQhdAHe5H8vu+hFwv7wtjI69ZwJ0emO7V2UgRYm5WT3DJuDjliQRcNzSvMvBEkqcpRwOPKEV2vc5za+OryjmJpqN/4A0Y82IbA5zjvvzSCJyEbn6OLoQH0nyEnuUzaDIHLSjndUdbZjcYNnoxXp2pCTfmP0jZU36mqbM08ZG7KdZVvBAVfXejs7yf163OdYAS+dP7PmmpvKSJIA+3qbin5/KdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00EINdWCauBZpnKhhgiDu/FLthu4+8U2Wd7Q5p9IMgA=;
 b=fJmGa+B1o37ELcHjQutnZRZAQgzqLUVJ7mX/T4BH774mUcIB/CUESyWRpsB0Hb+AUaNdw0VvZHD1WXUbcz0h6eivu5bWkq+b/tNqWuPSlqSAbfrP3sbweLcIPU3MH6ostHeK5Kv1gUgnr54f0liw83QvtWsHNYku+1njmOjbswU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 08:33:52 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.033; Wed, 2 Jun 2021
 08:33:52 +0000
Subject: Re: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc
 because of kzalloc memory limit
To: Changfeng <Changfeng.Zhu@amd.com>, Ray.Huang@amd.com,
 amd-gfx@freedesktop.org, Nirmoy.Das@amd.com
References: <20210602083017.2335-1-Changfeng.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6c569716-1953-697b-f032-c521a38c10e7@amd.com>
Date: Wed, 2 Jun 2021 10:33:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210602083017.2335-1-Changfeng.Zhu@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:cd07:2759:3eec:1d00]
X-ClientProxiedBy: PR3P189CA0090.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::35) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:cd07:2759:3eec:1d00]
 (2a02:908:1252:fb60:cd07:2759:3eec:1d00) by
 PR3P189CA0090.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 08:33:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4fba5a5-e074-4dca-f37c-08d925a126aa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4094834201FE58354E22BC87833D9@MN2PR12MB4094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JX4PMEuZaI2P++YbMIZZWz5vncV8BvQTZsp5Pn81G91A3yN2e6tjQAh28uzm+iGPEUy3pY3/xT9VVPPu392MB6QN/7PrNTHvt/h35E0CGt/PrZIdGqkuXrhbYW/WrNY8avg+BMJg9QEwFPLZNlfP+8KuchxmWygWvKakmfX1t5ufVXwdaNYuKCvwPCTnjORK47jUyRm0i3oU+VB0sulxxl0EvcIPeryh6nj1wGpE+fWxOqd8IzfjqQ3DqU6SW312LK7W1dg1Usvchff6DoYDLhXdPxa9E6cAnfwsrvUb8r/GgPuxf/UUkRBY8bqMjiohccw6yh5n6wUo0qtlmNfyyjae78QrrIOskqtdIlrWZTWX+a320GOFKFlH05M8GNVmZJQDuLpfqKn5TEPYzobNwVHTGsfvfFpPi9T1eFYcUxi2CUH5Kry2N3Cxh7+xZqydNKX/ypr2navcqaK7FL6Z8DkcYVwxL/tXSjp5pwmX9CZTuaGIppHqAcjWsQbzKJH2GypkybmmBwsuwINIZFB+K+pFR6lZ+du/8j8OvuVQ4gaPDJvOHUriQX2SMQtx4Hr6m9IeVGm84dqolAEMKaFPZeU0hujczKCZju4snntWG4zehOjNkhj4Yn7gLnzKya2cAGsyXNdATxfg8lADEa8ETMHsoaDAZKOFyldgYFOe0Pb3Aw3gIOzXZqNc0irlJJcL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(36756003)(6486002)(66946007)(478600001)(316002)(16526019)(6666004)(31696002)(31686004)(2906002)(86362001)(6636002)(66556008)(66476007)(5660300002)(8936002)(2616005)(38100700002)(8676002)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VWdWeUl4QmVvbWdCUVcxMW04ckZmZ1FUY0tJYmNjc3dHSENpWFNpV1g2VmUr?=
 =?utf-8?B?S2RVVGRRSnJBOUt3RTRkNTFMRU9jRWtLcUpFZzlqNlZzaVlqcjhTZXJ2YmRD?=
 =?utf-8?B?cTBnaXRNaVBHd25NSWlwYzV1YlRYNXBpajYyRzl2TjJLdC9wa1kycjJkWWR0?=
 =?utf-8?B?OE1Sc1FEazNLTElyYmNjNDV5Uk1zUXpnemVUNnE5ZlZ2cGEzYjJvdjBYSkc5?=
 =?utf-8?B?UzNjRTZlbE84TEVDTmxxcGkwVE9QaFV6VW9yVG1ibjcvODNCSHZYMEN4VCtw?=
 =?utf-8?B?NXJQMnFnZ0RqeW1ycFlubnBQUUYxWlRnOEdjMnU5Uzg0WVdkdzc3TFBERkc5?=
 =?utf-8?B?OVpFdWNmUGJxRGszQ2dUcjhyZDR0M0lsVURuOU43NEpTQUlnZXlPTVp5R0NL?=
 =?utf-8?B?cHNuNkJHVDNtdXBCQTl4eVoyYkt1VklGVHh1dWFNcHoxdkxwWjgwcFNMd3BL?=
 =?utf-8?B?TllFTDRHelFmSHhKeGdnU2crMFo4SkRKaGJESWR4dldMVEJ3SWkwS2lTbnZL?=
 =?utf-8?B?WUlLMzlHKzVOeFZGeGZHMUlrd2prUEd6OVQzZE42R3JDNnM5ZTVlcFExc0tP?=
 =?utf-8?B?Wkd6SGFOOXUwSnNBK216ZW5aQi9USUNZb2NsMUIxMU96bjJuRjZTV0wxTlY1?=
 =?utf-8?B?OFdjYmlkaHg3RlRtbnVJOElTc3FzVHRyUmEycjBESW5aUCtGZUVTNm5td2VQ?=
 =?utf-8?B?MGZSY24waUJoaUcxSjVNdTZERHFMSGxsOWJVNlpGdFZYanRKSHFQSjJzZVRh?=
 =?utf-8?B?RlpKNDdJYU5SRGFUT1ppTDRnZCs4eXM2S1paNjBoWE9BMlNDZlVKSmNLTnl0?=
 =?utf-8?B?d1QzTlhwZ0tjbW9mSXB0NytBNmdQWW5sL0RYS1NkMCtVUWVFQ3VEOWozRnhi?=
 =?utf-8?B?QWw3Q1FiRmZYYzFPLzhvcGRDS0hNUWRuQlBKUCtFN09XcGNlZ1JRQ3JsMzNs?=
 =?utf-8?B?SDBhM2s1K1ExNldtOTlNVzR6ZkVBeHdQZHZUcjdrS3hwdjdYSjhmVDNiRDlp?=
 =?utf-8?B?NElkOEw3SWtXY3NUVnZzSUpuejhSR3BzR0FvcTRJMXBpdjJ1bGI1eXRlQk5T?=
 =?utf-8?B?L1lTeTZUUGZzS0JoVXM3VXc0M08xSWxDR2Y0TmwwMG1lQ1NlcnVQTjNZQU9a?=
 =?utf-8?B?QnZoL0tURjJnTjFYTmZyR2NTMTQ0ZXcrYjJUNkdZU2JOU2wwWEJtUTB5c1VC?=
 =?utf-8?B?MHRhUDdxYmZTbE1hVlJOemFvQ2Y0WitVZHlQQjVUNDV1UWQ5TVZVL2l1bzA3?=
 =?utf-8?B?U043SUkwd3VzeXd2aXpocWJta1paY1ZXdXNwTlRFSlMvTWtjM3RoNVlUS1V6?=
 =?utf-8?B?SXNkb0hMdk91N1RlZXMrUC9LUEZOYndkb2lFRVlkTGhMRlhWMlljc090TGF2?=
 =?utf-8?B?T2draGIvYXc5OEVDZmtyQkhydWlnNnNpUVhNaW1Nb0F6eEw5TkZDUUh4dHRS?=
 =?utf-8?B?cWJLR05mU1JwWnRGWE4zR0FhR2Z3UHNmVHRUZjRhRkV4ZjcrNXdWa0RPV3hQ?=
 =?utf-8?B?ajVBOVVUdmpnbThsNlVuNm1FMEJzWWU2bzlVQ3BKOTFvL016Y1puajJSQzlv?=
 =?utf-8?B?bjk5SFRPSGJtSEJZa0YvNEVKenRqeERhb29WNmFPTks5dVFoRUpROWl1RUpE?=
 =?utf-8?B?QitHK2RRSGRFSGl5bElJVzNFMW9YRHRwL25kSEZoejhGQytiRW5KMi81c3Ja?=
 =?utf-8?B?WjZOcjZGOWJxNlQxbTNVWkY5cEY2Q3Q1QS9peEpSWDVxU1dRajkrQ1UxTGNM?=
 =?utf-8?B?UzhPMW4zUEhtVE02MG9WaVlzRHJhL2F0cENTa3huazBzeXVGd3JMQ05QS3lZ?=
 =?utf-8?B?QWJjOGJTOTNpK1B0MlFmMGxxUlhrNUVjRjlYUjJpRmZSM25HZXVRVkN6UmZR?=
 =?utf-8?Q?MHrot//lWImwW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fba5a5-e074-4dca-f37c-08d925a126aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:33:52.0104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjyBbmiAyTOpRqh7IZOp/aHXiYNlJWXM1YLf2SE1uMSavksrvToYf+81vfSMdvrQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.06.21 um 10:30 schrieb Changfeng:
> From: changzhu <Changfeng.Zhu@amd.com>
>
> From: Changfeng <Changfeng.Zhu@amd.com>
>
> It will cause error when alloc memory larger than 128KB in
> amdgpu_bo_create->kzalloc.

Well NAK, in that case we should just switch to kvmalloc here.

Christian.

>
> Call Trace:
>     alloc_pages_current+0x6a/0xe0
>     kmalloc_order+0x32/0xb0
>     kmalloc_order_trace+0x1e/0x80
>     __kmalloc+0x249/0x2d0
>     amdgpu_bo_create+0x102/0x500 [amdgpu]
>     ? xas_create+0x264/0x3e0
>     amdgpu_bo_create_vm+0x32/0x60 [amdgpu]
>     amdgpu_vm_pt_create+0xf5/0x260 [amdgpu]
>     amdgpu_vm_init+0x1fd/0x4d0 [amdgpu]
>
> Change-Id: I29e479db45ead37c39449e856599fd4f6a0e34ce
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 +++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 1923f035713a..714d613d020b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -894,6 +894,10 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   		num_entries = 0;
>   
>   	bp.bo_ptr_size = struct_size((*vmbo), entries, num_entries);
> +	if (bp.bo_ptr_size > 32*AMDGPU_GPU_PAGE_SIZE) {
> +		DRM_INFO("Can't alloc memory larger than 128KB by using kzalloc in amdgpu_bo_create\n");
> +		bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
> +	}
>   
>   	if (vm->use_cpu_for_update)
>   		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> @@ -965,15 +969,19 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   	struct amdgpu_bo_vm *pt;
>   	int r;
>   
> -	if (entry->base.bo) {
> -		if (cursor->level < AMDGPU_VM_PTB)
> -			entry->entries =
> -				to_amdgpu_bo_vm(entry->base.bo)->entries;
> -		else
> -			entry->entries = NULL;
> -		return 0;
> +	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
> +		unsigned num_entries;
> +		num_entries = amdgpu_vm_num_entries(adev, cursor->level);
> +		entry->entries = kvmalloc_array(num_entries,
> +						sizeof(*entry->entries),
> +						GFP_KERNEL | __GFP_ZERO);
> +		if (!entry->entries)
> +			return -ENOMEM;
>   	}
>   
> +	if (entry->base.bo)
> +		return 0;
> +
>   	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
>   	if (r)
>   		return r;
> @@ -984,10 +992,6 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   	pt_bo = &pt->bo;
>   	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
>   	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
> -	if (cursor->level < AMDGPU_VM_PTB)
> -		entry->entries = pt->entries;
> -	else
> -		entry->entries = NULL;
>   
>   	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
>   	if (r)
> @@ -1017,6 +1021,7 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
>   		amdgpu_bo_unref(&shadow);
>   		amdgpu_bo_unref(&entry->base.bo);
>   	}
> +	kvfree(entry->entries);
>   	entry->entries = NULL;
>   }
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
