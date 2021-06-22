Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40045C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 07:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030A161107
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 07:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030A161107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B171589E5F;
	Tue, 22 Jun 2021 07:03:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A34089E5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 07:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgczHTCz6dr2QktBRGNb79uBP+ca8SSfgdyYYsoYopmKx8ucMGW5cVheU2eM19vkklbvhgV1Jz7DoMPW81DSYbgugd5R2kM40NjPfR4tAEHfLyTT38GRx4hlY7vMRmcTS3ogmvBF7PuyJvl+sqW34/60AvnAKS01wGiVs4S5zd0+6EfFj+auXCtgpG5LpiZuQSlTHO+3UwPQ6BHAwpNrprimY2q+S8zqEwYT63kk/RHkiUgB1yZZpryt6zBNfTRfTLy0ihOk9YcYn216BA+flHsr8DraCPR8i5mp6aIbD6wdf/3JI6IlZle7fY+TCY4WcQqnkA8Yml3BORlMynhHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR23141n9JZgGuWDPlxPCcmungquSkKqO2PXAv/J9vM=;
 b=c0w28Isqjf+G31OGz0aoRwKZYewAzW2RO+C2gVR1xHCdOZgvi3W89li6/+t0VdYI7HXnwkEjsHdfQa3+uGq9UrRNm4o0v5VX7zi9xMcWMiqiZC4g2PVoANGxPBhC/auy+QzcnYeHkHiO/gFeOzpHuSyfcnWaBsO7+FJ857/fmRhZZSyKK7x3iUnOAl3nAXropHZnZkYNx+7YIn+JakVKXQ0mPSdQhMDanPery0SFzltXIog/2i5GTWif+2tEzy1fZ4G3l52nmsgveKCOYiHpMmJwGykHuVZ++2iCRl9LNAvea9ezCbY6RFjyzJ+bftESi5SHEwYiAlKfYpbFP6LOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR23141n9JZgGuWDPlxPCcmungquSkKqO2PXAv/J9vM=;
 b=pj6ta2S9mLrHAfxF2YR5om/jyrxkduhGOueW73OHBSy1WoLTpGAbBjcFWDKqm18SmDuE4sBcxinpXHq18MSp/LzAS/WGWmOkXQC/K/enac4PgUG426C/VrCfNs9SSvvOvdGr8D2WKF1a1TuSF3bbo3RElm6fG31NN3uVvpxO1MU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 07:03:51 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 07:03:51 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: add helper function for vm pasid
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210622065711.4589-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e2a64dee-ca51-ab36-9255-8950e78c6190@amd.com>
Date: Tue, 22 Jun 2021 09:03:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210622065711.4589-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4]
X-ClientProxiedBy: PR0P264CA0086.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4]
 (2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4) by
 PR0P264CA0086.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 07:03:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9716cf0e-20cb-4ae1-e4eb-08d9354be3bf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4157BF75F25C59194AD18A5A83099@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SB9WZW/9sy8eKUF/GIs+Ue5R9LC929GJaRcGHFRE/7UfOxsogz5FWSCVrJlkZYyAZd9T6y3zGXA9FD3YG1zam0Nqho1VdQvYIRVAdj7g9XYZS1wAcXMHoDQNfxYIpIukkU6+NlsedOVNhT3eottl/8ElhPi3eok3zS+r9VA65bjmbOP+PWKPvXvZdxMAmHDGJpkwG2cviue3UVN74q0DkjE069cecX9EOvswWB3uq94TeFLRxeeLFwVlu7MqG0KRFbtqG21AqhDdmlyHZ26NQ3ZvWLBxbsLdRLcDERodZcv5HYmy4MZjPmNvP0fMA71tMtyuTOEvM+q1GDSFki26rAzfPM5uziKPdiXUmqY3HbJ0cwvYMCaq7i/EV2O3DcweVLohL3jCyXmJErOX4P+MbQNBsAlez6sYHg/b+Es5+73/LDmLeyMxV626CcTdTQt2aILSXJPyVcOvt6HH9gW08lpjA1G5jTiIgKEUo82gxDdtamFyzXQeyNG5jessDS25plvvf1OsfYDWZVXMbCBoQd8BQpTwQZj6daWeNnIckMewKgNfF/nxSydKK8+K/eNMLpmNR9DgIjmrP1gLD/u3wpvGSFaStH7KoR0O/pUG6GnbpAI2cqsndvnGEASoAXqShizttT7UBlAZu5rETaAeTFXQV4yHyP2tLAGHC4LYr9jVudNQirzUq1nA/7oBTXWf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(8676002)(6666004)(86362001)(36756003)(2906002)(498600001)(16526019)(186003)(38100700002)(6486002)(66476007)(31696002)(8936002)(31686004)(66946007)(83380400001)(2616005)(66556008)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzJaNnRXZWRPc0lKdlB0K2hwQTNpSWRxOTdQKytRR21kZzlkcUw2MlU2bXlx?=
 =?utf-8?B?aFVYWVFZKzVpMEJUcElvdEtnUThBNGFCSlk2aGNGRW1LOWlFVFF2UGlIc0ZV?=
 =?utf-8?B?VVVJeXVtdTZDNkVHMDdQQUE2VjNMK25KSk9oZzExT2xlRzF0TXhvQVd3Q0R5?=
 =?utf-8?B?SUJXZS92V28xdUZtQ0V4d2ZqME1UMjdPSDFoaVZCeVhjdWlIakdVMC94TUVP?=
 =?utf-8?B?b2JRNk9mVXhmWk5URFRmcXpDK0MyT004UEJUUEFjbmdpOW12V0lyZXZRK2gv?=
 =?utf-8?B?eXV3MlcvYXFlYldTUk10UE9BcWVJZmlNUGNxZldVSGdURW5PSklkY2pHQmE1?=
 =?utf-8?B?SCs5UEU2L0hFTVBPWkxQdXBHU3NxSEtPWWE1cnhlMmFZUWdlQ0p2YUZhTUJo?=
 =?utf-8?B?N1k3L2ovanpKblRxSXpqaEdZME9ubExwZjY3S01mSVFubU4zOXBQY2dKQTVN?=
 =?utf-8?B?TFVybStNUFpjYlBubVpLcCs0YTUxZHpxSm9yalhJVHN6ZWJJZGRpTGhLdW1W?=
 =?utf-8?B?ekFYdmdReHRlZXFZVk9TOFlXWElyczZsN0djNGR0Y2hva0gwM0Z4QnBnays4?=
 =?utf-8?B?R1N6RUlnQUtqQjdnTGdJeGlqeldLdFlxcTZmM3RQbnI3K0ZmSlowM3YzUU55?=
 =?utf-8?B?bzRQRmNJazVKRXNkTkg5eGlBY3JrMlk5TXFwTUxNMk9lNG5yN2ZuT1B3dWR6?=
 =?utf-8?B?ejJISDdpODRzbTM1Vmg3cVRRUnd1TVNuWmZKcC96ZHVxSlB1QXN0TDJlMFgr?=
 =?utf-8?B?NGd3TVhkdVc2YVAvRFdGaExlUXgzejIzVzZIZHV4aUhVVHQyQkh2NE9YT3Y3?=
 =?utf-8?B?KzhpYTVXQU1LcWtqVDJ4QjJhS2VhaElBSVpjNDY0dkJOeG5RSTB3NGZaNnlz?=
 =?utf-8?B?S3FDOVUrQVkzd2VqZUljOTFLa2hHUUo0VnRNRjN0M0NDcHhSRUpMVzZDMFFa?=
 =?utf-8?B?bDN5bnlyckNDaTVFVHYvU2xWTldLVUFWVWo0eFRDT0ptKzExVHNoSjlPMG05?=
 =?utf-8?B?d2FjWFlGSFRDdFhnS3FnSys2OTI3SjgvblQ1SjFld3hhWGpVOEtpalBVT1NG?=
 =?utf-8?B?QmFkN3hMYXpaNnRiRzBRRVgrWjFLMzgzUms5cVZNVFFjOC9ZN0IzRFpWamE5?=
 =?utf-8?B?U2FJcUUvU1lIUGJVaVpObVNra0gyeS9IQlYycU9rN3RPRE4xamY2R0JtWngv?=
 =?utf-8?B?Z1FHQis3V0F4SEJaT1VNeUMzRjlDSFpvYzZMZzJaZ2hsdkZQeFlXUm9BZTFm?=
 =?utf-8?B?OTJSb01oTkZNLzVzWThTZmFUNG4wSzZjWGUrVHZFL1F1MzJ1UUNjTUJEdzVu?=
 =?utf-8?B?Y1JZV21GNVcybUIxR1BYZGZjbUd0elUzZHhraW43NzQ1QkxpV3dORmFsdHJw?=
 =?utf-8?B?dGE3QXJLLzBlcW1NbU1penMzb3ExUmdiU0R1UHpkV1crS01ZT3ZyMittcE1j?=
 =?utf-8?B?U2dTVTF0ek9xQUY3Z1VhV2VrVlAvdEhWMUhjamkveG4xMThEa2tHcmIxeGlK?=
 =?utf-8?B?UUVFL1N1aFNxNTR0bjE2bWFNMmlOTHV0bGhxU3hUME11QkpWVlI5cXdza09F?=
 =?utf-8?B?VUxVekJnaHc2cDd0ZnJMVHhQektKd2R3VU5FclpOdFEzWTUzdVVqVG1mVHdE?=
 =?utf-8?B?YWViTi9IUVRUWG5jT056T01SRXhuVjZiMFNheHBielpGQ3hEbmI2cGtJWW1N?=
 =?utf-8?B?aDJmcEJqa1pTQUIyM21sNnkxbUFJV1ltMXgzdHJnRFozR0hEelhEOXBQd29a?=
 =?utf-8?B?Y1RrVEZja08wODhBUEk2V1JNMXZ5VmE3UmdlcWM4SHZVRzZwOWRLdER1V2xa?=
 =?utf-8?B?ZEdVVWlNKy93djNDdFhwWE05OTAyNlV1cnlkZXR0Q2pZTHhuODJCN1Z6MHBp?=
 =?utf-8?Q?yI1BmNYCy+dgD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9716cf0e-20cb-4ae1-e4eb-08d9354be3bf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 07:03:51.0978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKk++hZ7q4xyVdGm23TgIyDUpfyDj2SVyn476mLrf5zsHK7KwrKrLYR4AYaCWc1T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 22.06.21 um 08:57 schrieb Nirmoy Das:
> Cleanup code related to vm pasid by adding helper functions.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 105 ++++++++++++-------------
>   1 file changed, 50 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63975bda8e76..6e476b173cbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -87,6 +87,46 @@ struct amdgpu_prt_cb {
>   	struct dma_fence_cb cb;
>   };
>
> +static int amdgpu_vm_pasid_alloc(struct amdgpu_device *adev,
> +				 struct amdgpu_vm *vm,
> +				 unsigned int pasid,
> +				 unsigned int *vm_pasid)
> +{
> +	unsigned long flags;
> +	int r;
> +
> +	if (!pasid)
> +		return 0;
> +
> +	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +	r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> +		      GFP_ATOMIC);
> +	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	if (r < 0)
> +		return r;
> +	if (vm_pasid)
> +		*vm_pasid = pasid;
> +

Ok the more I read from this patch the less it makes sense.

We don't allocate the passid here, we just set it up in the idr.

What we could do is to replace the idr with an xarray, that would 
certainly make more sense than this here.

Christian.

> +	return 0;
> +}
> +
> +static void amdgpu_vm_pasid_remove(struct amdgpu_device *adev,
> +				   unsigned int pasid,
> +				   unsigned int *vm_pasid)
> +{
> +	unsigned long flags;
> +
> +	if (!pasid)
> +		return;
> +
> +	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +	idr_remove(&adev->vm_manager.pasid_idr, pasid);
> +	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +
> +	if (vm_pasid)
> +		*vm_pasid = 0;
> +}
> +
>   /*
>    * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
>    * happens while holding this lock anywhere to prevent deadlocks when
> @@ -2940,18 +2980,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>
>   	amdgpu_bo_unreserve(vm->root.bo);
>
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		if (r < 0)
> -			goto error_free_root;
> -
> -		vm->pasid = pasid;
> -	}
> +	if (amdgpu_vm_pasid_alloc(adev, vm, pasid, &vm->pasid))
> +		goto error_free_root;
>
>   	INIT_KFIFO(vm->faults);
>
> @@ -3038,19 +3068,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	r = amdgpu_vm_check_clean_reserved(adev, vm);
>   	if (r)
>   		goto unreserve_bo;
> +	r = amdgpu_vm_pasid_alloc(adev, vm, pasid, NULL);
> +	if (r ==  -ENOSPC)
> +		goto unreserve_bo;
>
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -
> -		if (r == -ENOSPC)
> -			goto unreserve_bo;
> -		r = 0;
> -	}
> +	r = 0;
>
>   	/* Check if PD needs to be reinitialized and do it before
>   	 * changing any other state, in case it fails.
> @@ -3089,35 +3111,23 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->is_compute_context = true;
>
>   	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -
>   		/* Free the original amdgpu allocated pasid
>   		 * Will be replaced with kfd allocated pasid
>   		 */
>   		amdgpu_pasid_free(vm->pasid);
> -		vm->pasid = 0;
> +		amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>   	}
>
>   	/* Free the shadow bo for compute VM */
>   	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
> -
>   	if (pasid)
>   		vm->pasid = pasid;
>
>   	goto unreserve_bo;
>
>   free_idr:
> -	if (pasid) {
> -		unsigned long flags;
> +	amdgpu_vm_pasid_remove(adev, pasid, NULL);
>
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
>   unreserve_bo:
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	return r;
> @@ -3133,14 +3143,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    */
>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
> -	vm->pasid = 0;
> +	amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>   	vm->is_compute_context = false;
>   }
>
> @@ -3164,15 +3167,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		vm->pasid = 0;
> -	}
> -
> +	amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
>
> --
> 2.32.0
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
