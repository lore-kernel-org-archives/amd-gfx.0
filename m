Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C6EC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 17:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC41165215
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 17:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC41165215
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A20C6E91B;
	Tue,  9 Mar 2021 17:43:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66AC56E91B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 17:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiLVPyzG1dAtdQmr4gV4nLO3+6ozhXFFs11bXp6FoyXMIZOjkorlr6tPEp9nGSFOxifqJqWAeoDL0dj59v+1t25cti4MqZIAaDEI60WJnJimSifIEvVJlACr8oj4gWnf5jpgzZpWaPo29CHtPfYVMFztxDguTRgCURVPSyt70a1TCGXXwJf6K2xJE1EI0EPtEGT+4QDTIeHFExlepds4QO0EES5e/fgn4PFaIelA05j1v6lG8Kmoyb4Y2IYmlWHR/kd0m7CVQeQ9jWhgGlzmgKBOODw5OJ0kzY3ZS4W71KOH8NnVOSQ8zzapHffgFjW3829MrvswJVthkkz5WgN+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GdCH0kI6ULDq2RlrN8nB7k7bFL8VuRBENopkjvCe8E=;
 b=KUQLOg7b+oOkt+8VwBsz1XPykmhpB7Dnbe8BKky7ZmCYxwgEfrOVnduxAYBbffjgx88TAOqLmNJOkTTpl4CCWuAXjbAgyWg7doqWZqM1fti/fn1klL0IIk8E+jul/2bRVIWSGAxTdDbYyqkGKkw/HhszCM9xcGnl6iv+8uEZDkhC3w9tNCM986f8BfjxGpUbhjiN4CfuDC2hbvW0s3mz6GglPFjTEPDsBEvPjbqq88NCKtnA36B9rzJqzg4lAdAFZXniKEQUDK6RS+xY+9lsZE9sifEkbIgUfd4sfH2dct/8CqCN0raxAfCp1+qvsPENYOJl0VC9afLlXrLDhGM8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GdCH0kI6ULDq2RlrN8nB7k7bFL8VuRBENopkjvCe8E=;
 b=d+BxtDkX7m9zjkFitd0WW76bhJVKouSLFcYANbr+K1NvRo1a3ZT5ZVm6arbeSsg/GVDbreYq1p+6Oz1jxa2i+c1UeOWV6BSfmhPcfanV2okM+yYIw0JoWaswdCF/TpFtFMDCNDptafRHSfYNmnyLON2MGanQINN+DHbWR58/s2g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 17:43:35 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 17:43:35 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: add amdgpu_bo_destroy_user helper function
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210309165518.7721-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9fdbd2cc-59d0-c776-2681-5adecc2f229c@amd.com>
Date: Tue, 9 Mar 2021 18:43:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210309165518.7721-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:6863:34a9:e041:cda6]
X-ClientProxiedBy: AM0PR07CA0015.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:6863:34a9:e041:cda6]
 (2a02:908:1252:fb60:6863:34a9:e041:cda6) by
 AM0PR07CA0015.eurprd07.prod.outlook.com (2603:10a6:208:ac::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.13 via Frontend Transport; Tue, 9 Mar 2021 17:43:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a56bde5a-d7f9-4872-5ebb-08d8e322dd0e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4301C33E37E6A67DAC5702BD83929@MN2PR12MB4301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clzjex0TK9vgPboKhgbDn5tTiCn0DxKLTG/InHKI0U8r7TTcoEzf1Ohplf+uA6i57iHEG7+8Idz+ZS9rzKNeLzD88/z1hIsdAa3nek8CruEdElIx9xKQFEUTgFTGU7VyCTf8BCpj++1mWhwXa30gCeskBMfMnKgoMQ5Q0N3OicOA+DlpiJ6Mj3n4MzePVGN9wJX5a1m4x8Ie6XxZ9/UoEhxHzs0/ouErxMK7/tIBD0oEcJiWXWb52hSsPchEAYpzPhyB8WFsVF6Gvs6//4LpnlVfFBdgZOsIoplC6mTGN41XNMXGX46kvBHAPmOm6jWD8CwutqIrnb4BU4k2L8fvsB7dAbq48vS0HYS3XFirixg6S+53Li1rToz0yOlWbZZ+sYoxYKEtuBmyl57u+iaVLRm6w5RtZqSFc5IcEmqz96AgqJrKziN7uA54Ois7W2KzhZHRHVTx+Uf6DM7iHgS4j82hi5nSGav4nA1vnNFeasvk702MlTqJP3kPsGIvlMnF3M62yM7BwlZ5nKjCCoHl2w8IxxsOaIG9/ZJo7Ygm5iPvFG5XLIpHTHb/4Am3HzOzd8bLiRkvhfUpQ/SipSwOGFtIIO1o8tqo8DHVvd4Ikns=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(31686004)(2616005)(36756003)(6862004)(86362001)(31696002)(8936002)(16526019)(186003)(6636002)(4326008)(8676002)(83380400001)(6486002)(316002)(6666004)(66946007)(5660300002)(66556008)(66476007)(37006003)(478600001)(2906002)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cndNTmF4dGlMOExkOTE0dk5qOUpwQURWbkpEUk04SXBxRms4S3V5bmhoUE44?=
 =?utf-8?B?WnBQOVVrTVlGY2luT2Z1NGFBeHVxeHh0U0ZXVTBjekwxdC8rdjh2Nm1yMmow?=
 =?utf-8?B?Ri9tZjZ3dmVZM1R3ZVlBR2pWZFA5elNVWWxMN0k2ODhuOTlXeFFmM0tHTXQ2?=
 =?utf-8?B?VWFUNXNuY29rRElOanZGaUV2cVVLME1laWZPdk1rbCtYRUxPQnpXLzJyUGpI?=
 =?utf-8?B?anIyM2ZkSXEvaERvcGFNTmpEMGFGellZVVUxaERpVE5QZFF4VUxpaHlNQXJj?=
 =?utf-8?B?bEpYbGFuSDJvL29oZ09jZTlMRytEVlMzZ2hYT21Xd0ovN3kxWE9ocit4MzNn?=
 =?utf-8?B?YXhPbVR1cCtTMGxxaDdDa2t0STloQ0N0SUFNM2lkdTRUMVl2S0pOTWZCRWhq?=
 =?utf-8?B?aERpd1I2UWRFaFBhK2Iwb1FwbDNxcVJ0WTQ1djQ5em5TY3VROFFaOFhtTVVT?=
 =?utf-8?B?QnNUcnIwYXp6Z2JRT2dyd0J3K1pNTlVZMzNaSFFHNC9yOCtLdWRiNHdnOC9w?=
 =?utf-8?B?VDVDV0M5TmJpQUxyTU9XVWdrK0tPNkhEWnZRU1A5TVVKMmxzalQxTFJyRHRC?=
 =?utf-8?B?WXFMVWFDekZGaG1Fd2Q3K0ZkTk5RK3dnczByUFVlUGx4UU9ZamNZZnYvcVVR?=
 =?utf-8?B?ZTNJbFIyVW1zbDN4dFEwQnYzYkdqejFBM2UrWS91OExEVmNJYkY2MUIwemFY?=
 =?utf-8?B?ZktpVDZZMmYzNnZPUVhkVUMrUkQ1bFFyNHNTQmZzejdsMkllOEZveWhTU2gv?=
 =?utf-8?B?VHRhWGdSOHIxMk96S0VUQ056Z3pQQlFwMnRtR2JMWFdRaWlxeWZrMWZNL0lN?=
 =?utf-8?B?RXZaQkxvOSt5Z3UybUNtaEtQYytPN3BrUStTaDdaZk5CVFU5a0VUOU4zbml3?=
 =?utf-8?B?NzVkVjdPZmdML3YzS3dvWVB2NmpNbmttZzFrRU9YbnhlM1NIaXErUTM0bk1J?=
 =?utf-8?B?c1B2ajdtQUxPRUszYmxHWk1DVGdmOWlKMURVNzFiOFhhZGZlcm9GaUczazR0?=
 =?utf-8?B?dVdxQkltaHNCK2dLdUw1d1ZTSHFPVFY3WnM2OTRkTUVKckdhTktuSTFKT2lw?=
 =?utf-8?B?bTBlNytjLzQ1QTN6L2F3TCtYalQ3aEloNWJTdEhXcm5za2JKbWF2RDJXcEIv?=
 =?utf-8?B?V2g4dGxWRE4xUS9FSFF0dzZpTEx4WFBqT2txMFVyMDF1RDN1cEhYa1dmbmlv?=
 =?utf-8?B?NDBOSTF5L1Z3NEljQjJUS0orRm5nSURrT1lsU1FmK1FvZWJqYzhzSGM1eEt2?=
 =?utf-8?B?ZlE0MUIyemdkQllDSTBOZ0pqRjEzNWo1allNRnp1UGlKS05lYnpzVXJPenpj?=
 =?utf-8?B?MW5YTGNpcDVjTitSbHpLQjJmOS9CVlNsMjRQMWdENGNnajVsZ3FidFhNQWZh?=
 =?utf-8?B?RUhTRTV2RmIyeCszT3JLRDZ1VzdiaHlLaTRkSTE4TDFrdWl6U0JNZUhNaHpk?=
 =?utf-8?B?YXo3RHF0QXM1Lzh1UE50aFNUNEVzb3c4V0JsbUdMOGxTSDZrZmliU09tZmxr?=
 =?utf-8?B?b2RRejlIUG40QVk2YnNlQXBVbmhvbk9YZlpKVGJIeDB0RjN5TUVzcG9BMU44?=
 =?utf-8?B?SzEybmNYTTVzcUFtajFxa0NEWDNGdU5CMzRZLzZZWlBCeS94WkNCYjU5NXJi?=
 =?utf-8?B?cTAybjl6ek5RazExS1NTTndCcEJaTituaWt3bTFLcHErQUdZZktGMFFUN0ov?=
 =?utf-8?B?TUQ4K2o5NWhYejZaV0V0bHIvNy9XTFlmRzBlbjU3ZlB0MlhZWGF4eXZONlFT?=
 =?utf-8?B?b3dOaElYS3lsTzAybEhkRTIvaDVuRjFROXhRZjJRa3h2WkNmUkpqdWdmcUxN?=
 =?utf-8?B?d3IvZzQxaUtXWTlrb25nZGd0Q0J4Q09lTjd2RGpya2E2Q0grZmVodjhiYi9B?=
 =?utf-8?Q?MyIZ/K3JJWk+s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56bde5a-d7f9-4872-5ebb-08d8e322dd0e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 17:43:35.1484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rA2AcApa/g71/xtBCSwUMFzxoNZkuki9dJr0m0mOghnm4GmAg/eqyNx/Zbz56vox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.03.21 um 17:55 schrieb Nirmoy Das:
> Implement amdgpu_bo_destroy_user() helper function to simplify
> amdgpu_bo_user cleanup.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ac0e1cd83858..cdd5d02e7b26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -73,11 +73,22 @@ static void amdgpu_bo_subtract_pin_size(struct amdgpu_bo *bo)
>   	}
>   }
>   
> +static void amdgpu_bo_destroy_user(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_bo_user *ubo;
> +
> +	if (bo->tbo.type != ttm_bo_type_device)
> +		return;
> +
> +	ubo = to_amdgpu_bo_user(bo);
> +	kfree(ubo->metadata);
> +
> +}

That was not what I meant.

My thinking was that the user TTM BOs have a separate destroy function.

But this can come later on when we really need this for the VM subsystem.

Christian.

> +
>   static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> -	struct amdgpu_bo_user *ubo;
>   
>   	if (bo->tbo.pin_count > 0)
>   		amdgpu_bo_subtract_pin_size(bo);
> @@ -94,11 +105,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   		mutex_unlock(&adev->shadow_list_lock);
>   	}
>   	amdgpu_bo_unref(&bo->parent);
> -
> -	if (bo->tbo.type == ttm_bo_type_device) {
> -		ubo = to_amdgpu_bo_user(bo);
> -		kfree(ubo->metadata);
> -	}
> +	amdgpu_bo_destroy_user(bo);
>   
>   	kfree(bo);
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
