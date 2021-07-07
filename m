Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD44C07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 18:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B6661CAA
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 18:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B6661CAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C932F6E1A5;
	Wed,  7 Jul 2021 18:50:56 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217A06E1A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 18:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9j8/Vs2c5WkVM/2TaNqtF9kDqPc8PL3CIDjbKz9swmHx9Y5H/wX6HhlvwiJbEMkiGRB4KwWv/WS8T2uqCoSDbkkXZNO21yekpI6B+y2+M1SDEppnDY8C9JqcGftaLVPHwOf5Zys7gvCsliigAXPVnL+AbtX/PjtZRVEInmf0tZqf7fcb8HEjptrQ6tLCohQWLqBIMaMHapXxmvrGpljFzaBh5JgceIwPIRQqTZMQiJ46vGCES2E25ODq+6aCEW1rMgQjUHdyOEYRmrSXapB/Nr/dtS2JCssTdihBo0p5I/trOMo5juHWNhwMLs6qO60MNyg04/lhMgAcIg6VjKnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQAHCvaT2YHnYf6gh68aCG57BYeD7wxuMz7l3QdNjEE=;
 b=feeJ+Msa7Zi5xaFvvJ9kFVJ3Lm3pmry/pFdZlZO5fC5a8nunU7rbGtADt8T4gqxznG8jStLdn6TZQOuRKeJcOvjcN9uzUoWwQbhL2VQ0Qdwmio1yifi/2cmkXm9H1sJN5Jgt5P1xXrpQqkJ9FDSCKAotCdLjzxtqIWy+Mlr54nRhyEvOSNE9/8nYkY0Xosim3pjxKUd744fZve7UNfwSUkAx2FZXB89jxEbS9qqobmY735GK26W8Zyo/CAAidBQ2WrktNs9OvrQXRXwur8q/6rOn5ksLP9WTXq/Y9BAJP36cqqTQuJGlsA0JnfsQnts6AxN4ZJOfrJeWD4UaK/KNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQAHCvaT2YHnYf6gh68aCG57BYeD7wxuMz7l3QdNjEE=;
 b=12Ell+klUsaxwXXL7Yehd6EMe1fuACB5DjMmnCQF8h/5DanSOFJ5BH3GEPTwTmLaSrQghvc6fGWh1YzyVb1U/e6DkRlcG0z6ZXRZeuwOEKIyl8B9ZuPC1ndcFljfEIMGUGehkKWa5Jw3t+AjTBqimK1ejl4CzQep/mpatVBsis8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:50:53 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:50:53 +0000
Subject: Re: [PATCH] drm/amdkfd: handle fault counters on invalid address
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210707183409.23316-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <96eaa05e-984b-9489-7c17-82a754479a7d@amd.com>
Date: Wed, 7 Jul 2021 14:50:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210707183409.23316-1-Philip.Yang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:50:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ad957f1-677e-4d7b-ac6e-08d941782579
X-MS-TrafficTypeDiagnostic: BN9PR12MB5244:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52446B8642463545B576A8D0921A9@BN9PR12MB5244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chFWOJe+BlbRyweCI0BqkTD+RwQQp7GqkyaEJQIwTtSibnnRFp+rgznD5MVjj6Jnk7dERaKALIZakEGNhQMn8LDnn4Wa0lRgAOGiOWBv1KJDDnB+d/F+QrElic8+1mFdoDeW//C2U1PXQAuzot+XzfQ1wVhD9eASybH5SXP+YJWBeDp9A4ez9tGJBqLMxLz5LN7FwPzQfsca0rjO7JslqB7WRJgdPmvgjKUquqX8Bvgtb/IoFeiSr/I5pJj+R5PX3mUXd39O2lpizg5zLrXFiMHek4LqAnnWner9LAjgqx7In1XgM1tSAlOSgJ41wxVG6j5APG7bVEKEcMe06sBQyR/aJjwmqBcjYnhR2v95oPh0EwW2p0wsUXHF79FfkcxA8F6cIe8W2XSsr62uzDQQf085uf1svC4pahKKwE5qeQkxeyIPN7yi29eniL846VA1Hwmhfs/QEvmUjMT4yS1wwb3UOQ1sdvlqw/4piyr3h0tuhYG9xyWUleI3chXsO3plFTMATnEGq5UnDo2J5ST/v8uewmbFXh61HsrWfwhmItwc5biPf7bvSLsC7r9rlcwkqIT6RX8Loj6EaDSqHJ/KDO/TF2lw+OKrIHzCgiMt+eKxN/MD0jyNFWT/r9fdnXgd/tfL5bz9l30ewVVeAr9FvFZHVjypXsvitwDDVkrv8ikmTqI/3dDrno2ldrU5CCxrge3SogsFCKiskJW0HSlyPXrt1SgO3nxFqtVGJZ1aLuomJ/P4/s6ID6K28PHYevCt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(316002)(86362001)(83380400001)(44832011)(8676002)(26005)(478600001)(2616005)(31686004)(36756003)(16576012)(2906002)(5660300002)(31696002)(66476007)(6486002)(36916002)(53546011)(66556008)(956004)(8936002)(66946007)(38100700002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1FSZ010MUl6OVl0c0tVZEZtOVpqdHF4MEwxcUxmYjBFTjd3ZXJ0Q25zVG5o?=
 =?utf-8?B?cnI3YnF6UDhBazVGVFFlUTlCWHY4Y1dHVi9tbHRlUEV2ZmVGRUJpL1lBejNO?=
 =?utf-8?B?aWIydFVzR2NENmpkTTgybzgza2MzcVlYMm00TVlkNWxESndXbUx2eTRBTXY2?=
 =?utf-8?B?b2dkZ1grdisydENORk9ZTDY2a2hyZUFzMFBuMzJOK0hleXdHdGN5dDhBMmZj?=
 =?utf-8?B?dHJDTVZreUNJTDMrazBDdk9rd0YzcXRJbmV5ekdWMWVSaiswb1pzWmJSZk02?=
 =?utf-8?B?MENXL0o5Zm5mbHJlQlp6SG5rbDA2cU9QbDFnZkZyWnVJc04zSW5rMlFJcDdI?=
 =?utf-8?B?dDlxOHpXN1Jrb1A1RHJTdlFEcWw3ekdKbVJUOTlyNVdUWjl3d1ZmS2dGbkJ6?=
 =?utf-8?B?Nm00dGJ0YjY4QmJlbEQvK2dSU1JlVGpRTTZmTWVCZGxHMUtsYWNFQjBnMG0y?=
 =?utf-8?B?OHYydnk0d1dqWG1STTRnVmpZRkRaRWoyYS9rVjNpUVRrQUdWYTJWbEQwNGZY?=
 =?utf-8?B?V2JMeFdhMkF1V0FUOGZmaDgrQy9oUE1weGdBT2xBOFpsRHN2NlRjSW1pY3ZC?=
 =?utf-8?B?L283dzZKbnlBcTJ6OUo1bEpUZFNucVJqT2ZQRHZyK3BkakdpQmVTcVQ0SVh1?=
 =?utf-8?B?RVhKRmY4MStKcXgvU2ZGRUhoTHBnUUcvMGRobnZiWEQxd09WdGFGRjNLK2xN?=
 =?utf-8?B?L252bEdBb001T2xGSTFWZHV0R1FxSjV5UWNzeWR3VW0zbEpPZ0JrVDJ1ZWZB?=
 =?utf-8?B?YTRjRWRNclZFbFFQUTFlUEx4ZE40V3FkZkZveElFYURoT1c3S0htV0dLcWc2?=
 =?utf-8?B?MTExQWwrRWJMK1VrbnU4N09YdE5aMDJ2NU9XSWpGMXZsVGNCUzQ5QUw2eUQ2?=
 =?utf-8?B?ank3Zkt5MWllRUVTdkJxd1RQZkVqTERZS3NySDJaVC9Ec3E2bHBrWlVBWjc3?=
 =?utf-8?B?WEVWZStJbUMyQnEybld4MGJLbE5CdXRwczEvVWRNVzMyWUtIdmZsQVd1d2JH?=
 =?utf-8?B?NlYzeHVCQnlEYVVJcU9CNVp0TEdGSG1VQzNrOGp2Y3VMYkxKN1pRME9hcUo4?=
 =?utf-8?B?ZTJhSjFwNkVSTU82UG1ub1lJUWtVQ09obkx6V2V5L05FUy9hdUM3aDhMRWc4?=
 =?utf-8?B?bXNodndUais3emNUM3NKOHdkY3NPN3FwQy9KVHhZbTFKWm9ZY3M3d1dQK3k4?=
 =?utf-8?B?dXVWWGM3Z1hvdytmbHMxL3hSWlhJM0FReDMzTUh1WWxPNW5rQlRPK0hESmVG?=
 =?utf-8?B?VWpOVWFYdUVqWFlKR2NjUWJreHJ6QWZqenBzZHBXK09EeGU1WVZvV05LYk9q?=
 =?utf-8?B?bEJZSnFQOGl5ZE40eTdRT0ZveThQaE1wTzU5ZDBFbUZLRnhxQXJSTFVPemww?=
 =?utf-8?B?WHFVbWdKR1BOTUpCcm1kQ1FpcjdrbDEwaVRKaUo1TTA5R1ZTWkMzWEZUQWhx?=
 =?utf-8?B?WERSTFhqZEpJaEtlQUQ4VzMxSy9RdjRMaW9GUGI2S01WN1hod3llcnNEclow?=
 =?utf-8?B?bktTb0M1ZisvTlgzcGJRODFQa1dUQU9iQzJITERqVVpWcDJ2ejIzVXNjZ1ly?=
 =?utf-8?B?MHZsbldoa3VRamQxL0hPNEJMYmJjOXd6UG5JTXpsZ2xNdE9TQnRNNXZVU0Zp?=
 =?utf-8?B?dmxDekFEUnNlVm1wMUpzV05qTXVFTVJzbUd5SzBucCtvdG5PRWhJdjFjb3VJ?=
 =?utf-8?B?R3BKSklCeEs0SWpPUG5MdnJ5MlI4RXdycUtuY0VDME91NkphbXp6aG1meUFx?=
 =?utf-8?Q?39kkNUg8rdIWO93mj4cXcWBOc/Su/cij/pQLNNc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad957f1-677e-4d7b-ac6e-08d941782579
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:50:53.1502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiYPZAZ38ps2hXQGmaDlkjpVfLMJbOUg3Ut15sjD2q5d4RIBHvWu4lM838vwJZ/I89kSS4Kq8T34tsXd/2G4PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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

On 2021-07-07 2:34 p.m., Philip Yang wrote:
> prange is NULL if vm fault retry on invalid address, for this case, can
> not use prange to get pdd, use adev to get gpuidx and then get pdd
> instead, then increase pdd vm fault counter.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 +++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 31f3f24cef6a..e7e99c5070b9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2375,21 +2375,27 @@ static bool svm_range_skip_recover(struct svm_range *prange)
>   
>   static void
>   svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
> -		      struct svm_range *prange, int32_t gpuidx)
> +		      int32_t gpuidx)
>   {
>   	struct kfd_process_device *pdd;
>   
> -	if (gpuidx == MAX_GPU_INSTANCE)
> -		/* fault is on different page of same range
> -		 * or fault is skipped to recover later
> -		 */
> -		pdd = svm_range_get_pdd_by_adev(prange, adev);
> -	else
> -		/* fault recovered
> -		 * or fault cannot recover because GPU no access on the range
> -		 */
> -		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
> +	/* fault is on different page of same range
> +	 * or fault is skipped to recover later
> +	 * or fault is on invalid virtual address
> +	 */
> +	if (gpuidx == MAX_GPU_INSTANCE) {
> +		uint32_t gpuid;
> +		int r;
>   
> +		r = kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx);
> +		if (r < 0)
> +			return;
> +	}
> +
> +	/* fault is recovered
> +	 * or fault cannot recover because GPU no access on the range
> +	 */
> +	pdd = kfd_process_device_from_gpuidx(p, gpuidx);
>   	if (pdd)
>   		WRITE_ONCE(pdd->faults, pdd->faults + 1);
>   }
> @@ -2525,7 +2531,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mutex_unlock(&svms->lock);
>   	mmap_read_unlock(mm);
>   
> -	svm_range_count_fault(adev, p, prange, gpuidx);
> +	svm_range_count_fault(adev, p, gpuidx);
>   
>   	mmput(mm);
>   out:
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
