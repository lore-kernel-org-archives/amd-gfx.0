Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F515C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 19:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAB210ED29;
	Thu,  2 Jun 2022 19:15:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEDF10ED29
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 19:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS3F1KdsYKTJzhT16L04bqlCLGrsFEX9jwUKSZ8/yeyMVJeFJVeSodS4eojWAUG6LjuC36xxxHbM72lzjysmTL6IFTMqq9ld0lJmjrFSIqoV+4sPQL/73pzIP5Q11eW0umNRavWf4c8+nqbe9ni9GVZ0aHSk1dTtB0RPOAe0QQRMmgZyb91m6BYV3woKELLl4CbNapdIlO0+PxC+VuHmth+FMDt3/NF185AY06RYvDNlrw2vi/7tmexKbf0GdazRAeS0ACLXwtyJgMU7dKUuZ+bpPLNjsIaNrO5DJ3FwoT1MPDwE64e57Ux4+LHvZjYFF0PsqFNH3WejPVzPrPhxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU8m8eFqbPf4sg2obmvCcNBufe3G3WgmtlZsR+VYoMQ=;
 b=CRSrYP+32qvO4rX2e2BcMofwQBHar68hrVTAQM7KSbCckL6jAKH1s1itPUDRtaACRJdPQzIf8a+FM6l4/nYoGjOUjK733sbAVPC/bViucBGVR2hh3sYoSWwqENRLr0RM2WBVHKERTLJIKOpckXpV9LdgMPzFhERZGOklnYAG1QXg84r/svY9mNq4OXGUSKi8G8qt+qKcW+RPRwBl+GIo2T/nE3O9vF1JWgDVe7aDg4MaoSYK4WAif5BJYwbIh11gYyIWrvj4l8Ljq3TrBu45h9QxXZub0W0GFXGGzTpGm3Pl61Bh1aq/CM+05itnOH6UOx0AMinf4QgszizDCNP1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU8m8eFqbPf4sg2obmvCcNBufe3G3WgmtlZsR+VYoMQ=;
 b=Q8FQEFv4hSiHUtne5Z5hg/RzwK41F37Wdkhc15E3gSXgcwSRyVf62etm6Ixk08gDXJtR5XkkfKCV8pT1DBtCNgznlcFJ98onZ/nBowdja6W0PTPLqa+mZuUcCfWMnPRnmTQsVOwDgWHUwXFovKpDwoJHqijen1/5h6672OfpHlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 19:15:21 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::2d9d:f26a:77a4:c19]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::2d9d:f26a:77a4:c19%5]) with mapi id 15.20.5314.012; Thu, 2 Jun 2022
 19:15:21 +0000
Message-ID: <577bd14c-9c61-d233-9872-8ae28dd7a071@amd.com>
Date: Thu, 2 Jun 2022 15:15:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Update PDEs flush TLB if PTB/PDB moved
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220602132029.6225-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220602132029.6225-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::10) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 652bdcb6-7564-48d1-f653-08da44cc3cc7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5330:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5330DC9D7E9EFE604ED5F5F592DE9@CH0PR12MB5330.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvUnY1CwLfGz5VYrriv05qrQ4ApJb6egKrkmxuBwZYxdtr1U6A+78aQVfa5ak/HVmP2J+Px5f3L5JbcBJYQIbZIOPfWTE2jS0jRZS6S+8gEl9hxXlFnvH/5dUHmL3zLNXeHwHtUupx9L/fcZ9DJy8OszlL7t8Dovud4kFKH4YV2wxdapCArBTb2VBYRRYlQsjYYpK6o3+u7sPHRwyov8oF4rFecEYBzWgeLqJLSjjXm6zQRn0sZvPSXHOru0p75KPDfSQUqS8x/BIdKBh1Dg1lcCSzdyX1smq3cWngRgDdkYfGsJTh9OYljlNxo9ZRB2YLkNm0RzIBVU5CBg5M7zEfjuFr41SvcNRffJveP1XwS3RbLCzfLIFlQDvUuUhkDVlK8a6trgxrQRJnu6XLuk20yyytpu21N6M7q6/RFWCuPxeJSTsjeuDngjXmOyPmzlU/COhpdg5qNn9urNqYiQGu8nBqJb4cCyWm5qvq//3hOPR9MrsrNvliHhFfgoWZDaXUQye2m4jF2sow6xMAz8AMQuKA38Rxp9XIKEgCwN8BKH9Mg+1LmMJIwzVfSbtOzFmy4HWxNXJnWzegI4+AuDA2xHtNp25KjKWmSBVvOaSpkovbzvta5K/GMBc74G5mQlLKrTMIAFiEoHxQl93z+yJ+Bs+ikhOtnR39OOtyKpFToVE2/UbFR5OS+NuX+iY+c/9pI/vtoVGU7bUuSIlbQeT96lgcpa4tNVmob2zGWZLT2WQfQb4kQekQ4B9b1uvNni
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6512007)(6506007)(66946007)(66476007)(26005)(8676002)(66556008)(6486002)(86362001)(31696002)(508600001)(38100700002)(316002)(83380400001)(186003)(66574015)(8936002)(5660300002)(44832011)(15650500001)(36756003)(31686004)(2906002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9jNWMxSjlCQlVZZmFmVEJZamNyV3kzdktWb1h2eHhXTW9OL2RqUmhaWFM0?=
 =?utf-8?B?TC81SGVpaVhRRUp3V1hFbWpwclBTOUpLUVc1MWd4N0VZSFBQYzBFVEdtbUNE?=
 =?utf-8?B?Nnh1blc4bWN3c25LcE1rTW5BYnNGMEtyanZybk5jTnRkYkFLOTJpemhuOXJh?=
 =?utf-8?B?Y1lrYmN4T0ZWTVRVb201UzVQRTluTkY0czJzMkVmOC9iSldGK25FL2JMZGxt?=
 =?utf-8?B?b1o5L1orZjdCa2pQNVRhQTB4eHJPdzhaS3pCUzhVaFFSV2pNamJUL3dFYW5n?=
 =?utf-8?B?cThwMWpTeFJobGo0Z0xkVUJOT2J3QStKSm9yS3lOSzZ1MjVOcWJGVUw4YURW?=
 =?utf-8?B?RnZQa3ZadjVvMHV0RzhZVlUxZGRxVGJIVGlUbkIvd1FQM09Lcisxbjl4ZEJS?=
 =?utf-8?B?Rktob1praWlNamZBcTR0OFFESDkzamNKeGlhQ3BtZ2hiTkEwVVBjcWNOdUlI?=
 =?utf-8?B?cjVkbGJWTjFlM0s3Q1c2Qno0c1g4dldGazVvbzBNbnM4N0IwV1pwaWlhd0RJ?=
 =?utf-8?B?Y3MzbUcrVWY5OS9WN3JWejd5aUR1elgvamwzUnl6c2JMam05S0l6S3JjZENO?=
 =?utf-8?B?dFpIOExTQVdGZ2p1cEo0TjVhSyt2QUF3bnZLcFRJcHo4ejA2MFMvSHVaaTZG?=
 =?utf-8?B?V2UvUExEZCtoOUNvWUdJZFJiVWozR1hYdk0rajdnN2dua3l3RW9IK01SYy83?=
 =?utf-8?B?MStwR2RmelFkMnl0WXJncU91aHhITWtBNnZqM21pUWMxZUc1bXVPRUIwUWp0?=
 =?utf-8?B?RGR3cGdtaWQrNWgrVVJZY0hJY2c3ZFlsOGNtdllEK1hTM2R6bFJJMHFYNEt4?=
 =?utf-8?B?MTRYeFZxZEhlQkpJVTQwdUxKRzRGdlAxek5VWUFTU1pvbmdISkJBbm1aMDc5?=
 =?utf-8?B?ZG5iOTNFUmJjUzR5bFhucFUzSU95T2ZpSUR4Y3hsYVRmMm1XZXZ1aG9vc1I1?=
 =?utf-8?B?T3h6bDlLa0xZRWwxNHAxWE94MXBpem9ndjA3MjVIb0pMT1ZiNkZZem9Zb0Vt?=
 =?utf-8?B?SzVQa0M5anJQQk42SWd5UnVEU1B3cVFkcFNodFltVWNxL0RpalNjOStLa0ZT?=
 =?utf-8?B?QmZMTmVoSFI3bG05bWRWSlAreFdDTUM4bDFSR1lOZ2RYOHdFRTNsV01EWXhp?=
 =?utf-8?B?MVRxK0VUY25nekpBNm9LWFFpTWpLcTErSzZSQUdtYWpKMWZjQmVTeHdGdlVm?=
 =?utf-8?B?SGZuWUQvNzkwbFk2d0RiSlQxUnp2NG1VeHd0aVMxOHUzV2ZuSFVLSC9yazRT?=
 =?utf-8?B?TjgvcUVqSTNJbGx2dkwxYWNFNnFkWndTUEtnRUc1R2FzWnovYk9ZWDdmVGRo?=
 =?utf-8?B?SmNBT1krd1E5SGtGeHprNHlENVh0alR2ZHM2enl2eENETzZyUDl1dTdpcENs?=
 =?utf-8?B?bGpuYWU2WjVqVkVaQ0NQbDlDbkxUVGs2QW9qVXNJVitRZ3VhMGhPZEp4N25M?=
 =?utf-8?B?UmkwVWNPZW9BSjhmNVYzWW9qNldCWTRqOW9yM0dpYU55c2NsYmxaempBZllY?=
 =?utf-8?B?OGZUeEFQNXovVUJ6dTBkdVo1cXVZaGhxMGE1ai9PbHFyUHhkWEYxb3pTYzRo?=
 =?utf-8?B?WCt4M1Q0T2NjN0tDbDFEOFJtaFdTS0dVc2hNenpISkpPeWhRSkg2RUhkdVRZ?=
 =?utf-8?B?MTE3clFLeStVN1lRdjBQektRODFsUFFIVnRFd292dEhkaUhLYndORjdnTVVM?=
 =?utf-8?B?VHpHOFYrQ2RaY0JqUGNJTGhiSFhubXNNaWE5cGZvZVZOQ0pwdWhQS0lLRGV2?=
 =?utf-8?B?NXJFRnVpMEZnYWJveUxsTHY2bVFDN2EyOW5QbHBJWm41NnRKZnNJc1B1bjhG?=
 =?utf-8?B?RGdxdkhjMWNWR3V1NWRtZGdBZXZjcnltT040RkduWHJFMTFVMXlyVXFuRUVI?=
 =?utf-8?B?cWY1K3JVdlZPVnhOVXgwVGtnMjNjTTBmbkVnK0dzckRMTUtEYnAvQlMyUVNT?=
 =?utf-8?B?Z0Y3dTlGR3dSdHMrMWJBV2htcitiWlB2M3VLZHdlcUYyQnBLNzhJdUNoKzNu?=
 =?utf-8?B?UG5rNGhzdkxqQVNkRnU0TytRMFUvY3lPUk9hL3hzcUcwNGxIbisxa1VrWGdl?=
 =?utf-8?B?UHJkSjVqeUJDSHlhTWVEVG5XeFYyc0c3d3FGVW1vSWl6UnZlTDg5OG9Nbnll?=
 =?utf-8?B?OTJLNjMrMHFtZUt3UXFTY0lxQmVxb2ppbFVyd1FDd3RMSVZQaWVjQ1NyOGd4?=
 =?utf-8?B?TTJrdnNFZmJGQXJIdzhpSFBCMWJ4Qm4wcWNlMU1KcWd6MHJyWTcyWU5ZWE1w?=
 =?utf-8?B?UitRRTh4WCtaNU9uMWNKTUNscXBMamxFR2o4Vkp1R3Z4dnNaOW43WVJxODR5?=
 =?utf-8?B?S0pNeWl6Ui9VQjB3QkZwdXhvSmt1Tlk3eVVHMnJzbVFCUVFRZHhFZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652bdcb6-7564-48d1-f653-08da44cc3cc7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 19:15:21.3225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/XDNIP7KFcpCI7nI8evZ/28CqgEJekX7Fvq4iRcxPBCLDr5vcppQInY4Rnmc+1qkZOw6s3p+Sgl0VsEjZ30KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-06-02 um 09:20 schrieb Philip Yang:
> Flush TLBs when existing PDEs are updated because a PTB or PDB moved,
> but avoids unnecessary TLB flushes when new PDBs or PTBs are added to
> the page table, which commonly happens when memory is mapped for the
> first time.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9596c22fded6..1ea204218903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -737,6 +737,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_vm_bo_base *entry;
> +	bool flush_tlb_needed = false;
>   	int r, idx;
>   
>   	if (list_empty(&vm->relocated))
> @@ -755,6 +756,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   		goto error;
>   
>   	list_for_each_entry(entry, &vm->relocated, vm_status) {
> +		/* vm_flush_needed after updating moved PDEs */
> +		flush_tlb_needed |= entry->moved;
> +
>   		r = amdgpu_vm_pde_update(&params, entry);
>   		if (r)
>   			goto error;
> @@ -764,8 +768,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	/* vm_flush_needed after updating PDEs */
> -	atomic64_inc(&vm->tlb_seq);
> +	if (flush_tlb_needed)
> +		atomic64_inc(&vm->tlb_seq);
>   
>   	while (!list_empty(&vm->relocated)) {
>   		entry = list_first_entry(&vm->relocated,
