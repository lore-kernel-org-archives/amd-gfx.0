Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A37CE79DF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 14:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B77410E50F;
	Wed, 20 Sep 2023 14:55:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EB310E50F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 14:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dalb3GzTdhQcjXbyWZ25FZlEp2cyPyvr32cmOFNeslWGBqhzPRckbRnGU1lrb3nWOQIW02gJavBWuupz8IukUqKXa2h8Nz33Jr9ndvLAZEVKVV+TJc2I623oLKVW4RNmKa4L4IUqmY7WJXI1CHf9/g1r3LSqYy9z2rdVjz+l3Y3qTS5RYAd5pQ1gyz9p8Gs69ahRhThD0InUM7YpEkGMKGfLHLqIP9ZBUU8mPhan5rG6pPPwTrISivVhwzWlFLXid9OxpG9CBDFnY9QeDpcQdnK28cWsMizTZnXn4JrrwfVEFovwG6ar/Qj2oysK/EIUg9AswB4/RhHSioVahHehOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWNfvsHkg2ckvh4octSt31hlZpu5yk83NeYrvG0j7gw=;
 b=XlYCIcuLnR3ci30G1y0wCmzSkSvvJ9JEDVQfrjwtq0sN/SO214bj1pA+P6OvRFt2j/tnLSZSEd0I3IgS+xEqslANx7AfUahV596cqGFpR6fGPMOJVZaSR2TGBJTIs2QIK+HyvEvr8X6+nSdnARLHm9qts4pAf1trpw3qORGfsvMwmPTvN30By2GD17Zd88oYOdBLyOK274plug/9BzqBwOJ9o1QUivoT2co/6V8yc3Inh/uLI796EwpInP2gjDAhX9MObj3YXIV8XfQnmANQ0a+dmMX1ULIbjsniKHA0PJQ0ajE4pQ/3/ORl4DcAT9ICmbD781yTwlaTOgUtCC65Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWNfvsHkg2ckvh4octSt31hlZpu5yk83NeYrvG0j7gw=;
 b=pmhPLf2RvMrQAmDFYrkzF8WB/0bcO7VEMxzSik8/fnJ1mZkkIRyNyjfiAmMunkhvsDrob3JE/xghzg+vMCvg68UE99vzewaTjAKPmS1r4luereeVBda2MeMFJ+XzCuIO49+5WSV2XmkNQH1nWyN92/o7pYtIi6QzuJwYEwQAc4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Wed, 20 Sep
 2023 14:55:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 14:55:41 +0000
Message-ID: <921f0521-f0ac-3d9b-36c2-88b4c3bd8c3e@amd.com>
Date: Wed, 20 Sep 2023 10:55:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: fix some race conditions in vram buffer
 alloc/free of svm code
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230920061741.41382-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230920061741.41382-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: f845b47b-2a5a-4633-c2b6-08dbb9e9a8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIuRku478hGOw0oB31EU6uyUZ6D9Qkgt0Q7hWcpsnqVnin/gF4vHa2OKhiFIKzyw5+MwAFurjjdPerXAkNJrVFFEwwDVQI1vioqiP62oV65zBdHMjQXOtV9+TQFmS/keFJ6W/s0EebhLNu8v0sPSU5mL8QMViAY68rMd1KZQ9PS2QilvZ/8q9r+ef9E5dyLM+UGP7OgpJu6IRAUpBgATw5Q//b2Gks8prLHznle//jGq3dwHEcAUZN36CKR4keruqpfWf4XGxlhzvnX2khjkAHXhdN/Z5e3E8pU3K0AdwsR+ZIqXAzFJGfZQLrtCJNatx0rJvWWd/V4wNMZH1i1LoJ7n4gftJ+IP5kUMPmBDVxGgyFEJTkE62bTn0kXm9/mT40bXnfJwlc03ZVkioEf03ng/IrFiC/fpOMO/DZqkbnk1PxRk3jzC9O9RuKA9Wk2+qNIhHHMIMRpG66x3bCTDQ8v0Y537i/wH0eB8lOUmrDNGrU5iJvBPUlmYSjBYRBH8Nt3xILVeNgzcGU/dNf4gShbqh2rAoU9OWf08wvn3fIF/FBjD0WSe5IhjHBr2Xec7jO0+l9nWi19F1gZVTee5uqhNlFYlrj8NmZj0f/4uqqT//YrCUhTThrA9cWXS5d+NwEeN7U+Nq5VkmSjmJfMvbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(44832011)(5660300002)(6506007)(86362001)(53546011)(6486002)(6512007)(66946007)(41300700001)(38100700002)(66476007)(66556008)(6666004)(31686004)(478600001)(316002)(8936002)(8676002)(2616005)(26005)(2906002)(31696002)(36756003)(4326008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dytWUWlmaVEzK01IVExBRjBWMVo3UTJiQW5IUVRxY2t0RmROaGk0UzFEQzZr?=
 =?utf-8?B?Q09JNVIyZk9tOVZYWWc4L0xsOGcrYU5pNTZxa3dvWTFTVEJHOEQvVXhMdkx5?=
 =?utf-8?B?SFJGMnVEaW96QXpHM2Y4aHd6YVNUZkRwYlo0WGE0cEtkYWhkNXdnd2lndTA2?=
 =?utf-8?B?RHRSdy9wMzhNalZrTDBaa2NmcjY1MFFFWkJWZzBMdUNxSDNtd1ZkeEIvaFpS?=
 =?utf-8?B?cjZHYVZDMk00MFJYU1RiSXlYaUc1cXpNZ0c1bXB2Q2svd0poWnlja0RIUUJC?=
 =?utf-8?B?V3VIZVg5elgvbkFwVlM4MUIyQnJML1pacldXbU05bVpBalNDK2gwaTFZU0c4?=
 =?utf-8?B?aTdOeU9nb1B4NVAydjhXUDJsRllKY3hrLzFROGRIR2FzbWNjYmRoeEI2Q3Vh?=
 =?utf-8?B?dS9BQzlVK1BpbEtIUW5DVWVnRy95emRpMHY0VjBtZEIyb1dQNEt1Nmh3K3FU?=
 =?utf-8?B?UHlqNnRQRHdQdkxQdFZ0Umg0aXlmMCszM3ZqeGZHZ0ZBRTZmSVIreVFER0Yw?=
 =?utf-8?B?V1FMeGJSbFBNVGNOVlBOalkvTUpsd1B4UVNNb2s3OW9rSzh0eXYzOWI1VjJX?=
 =?utf-8?B?QUtxZmg2S3dpVi9sRlVMTjBjOEpEUUF2UmNsNEdBQUdDTHBVRS9KeWpCNUVG?=
 =?utf-8?B?Q2VtaWczUW9iSGhKQVdMRmxuNWZTbk9tV2V4TFo3RjBJRFVJRDkxQ3NlYnE0?=
 =?utf-8?B?S2pwZTlGWENtVW9SbmlSNXZCaFpkcyt4YmdlOW1BaWJ3U1V1cUZTa3c4VEYv?=
 =?utf-8?B?S0pCeHhESXAveGpQM1dwdklCcHFMQTIvSkpsSU9DL084U3czd21hNmFTQlJ6?=
 =?utf-8?B?cXIvdXgrNTdxWEloUDlsb1dlNHZmQmJUdTVNR2c4L2NiUERmOERldG14QSsr?=
 =?utf-8?B?L3Y1Mm92Q0x3Nld1RStENzV3VlI4ckJkTTVZUlZOakRkK2ZZc21UZjhjeml2?=
 =?utf-8?B?bjBUMkkyOGhpa2ZFcTJYVzQrNmEwTndpSVRoaFNIdWM1NjhZYkEzZ0U5L3RN?=
 =?utf-8?B?YjBJdm9vc0QwRGxjQXlNRktLalZRT1Q3SkE5SkRvUzAyQmhoUmM5WDBIM3o3?=
 =?utf-8?B?dXprMEJnWFk0dkNQbm9aRmNUUXZyQjNWY29oYXN4TWxZem13RzBLTDlPN2o4?=
 =?utf-8?B?NWN2VGRkMVNreDV4ZzNLS05ySTU4N2hDR2lGcTJ0aFBmeTQ4RHNmUU1JdHlw?=
 =?utf-8?B?Y2phZ3dId1VsM3RROWhGTDJnNHBlM3dBOGpBYTVRWndVRUxzUzNaUWZHdVRR?=
 =?utf-8?B?anFxS1c2OFBWQ21zOXJqOHg5Rk4yd1BkKzFHY0x0aUo3WUZMaWpwYkE0UkN1?=
 =?utf-8?B?NDhrUzlPY0IrWGpUbmpOeG9OWDE2T0g1U042RXFoTy9yQVJKTlkzUGdBYkdY?=
 =?utf-8?B?WThzTEVKZWMzcVcyUGtveERlWFdOOWt4TStXdytNb25SWTV4UFV3TnNDTWJT?=
 =?utf-8?B?RWFPRmhodUR6ajFDUWd4L1VsaWFwTHFzVjhWZVhjVy8ybVovOG4xeUZieEZ6?=
 =?utf-8?B?T2pZOWhlZHFYZW1PR0lxMnczR1l0bCt3SkxjWi9OeTBOQWdGdWcrQnl3VXRw?=
 =?utf-8?B?U1Z1aiszeFo3eSt3WWIyNnhqVXY4WERKa3lBbzEwcDVBTDRZVGZydE5kQzRK?=
 =?utf-8?B?SnMvZk9SZ3hvZG9EZkRtVlJVWVdJNUw1UU5LcEtBZUo4NVdYc0o4SEhWSTBD?=
 =?utf-8?B?ZHFIODZkY0NnbGdXblVxSjRIVlRGQkJ2dHhiY1lrU1JjaVI5aTMweHZWQ2JH?=
 =?utf-8?B?MkJZQS9VN1FPNTZtMkdHdE10R2VXM3ZONW54dC96ck01eFdQbVZFRjNSbE5E?=
 =?utf-8?B?U2plTTRkTndwYm13cWxsV3hZMFNpWjVpUk01ZDBiNlVRZHdtWkd1R2ozdGJV?=
 =?utf-8?B?UVZmZ0liRzA0Q2xHL0ZMaDRpQUhvaHp0NVE5RkYzY0QvSlp6NmpVU2pyWVNz?=
 =?utf-8?B?aVdzVjFjRVo0QUU3aWFjYkhSQWFIZHdrNW9DMTA3cXdiSHpBcXFZZ2hOSnQy?=
 =?utf-8?B?SFhqYUtrWGUwM2xEQVVvK3N0V2VrZmpmQVlVNzJPVFQrSUp3MWRXdDk4M1Vs?=
 =?utf-8?B?ZGpjM1lTV1BWSk5EQ3h1cFVUalF5YW9ES09rNzM3RzZxVTdjcFZJQTgxRlVu?=
 =?utf-8?Q?5K8wmtc7eGNl+apIRVmeBmFFZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f845b47b-2a5a-4633-c2b6-08dbb9e9a8d2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 14:55:41.6620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2l1YIlxB30FSJMjLD6P8D2v44FEvaGuJkDeYRiBDn/VVSDqVFcYaV7jE6QUOKq1Eobhag92SEUfOgnb4UpfHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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


On 2023-09-20 2:17, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> This patch fixes:
> 1: ref number of prange's svm_bo got decreased by an async call from hmm. When
> wait svm_bo of prange got released we shoul also wait prang->svm_bo become NULL,
> otherwise prange->svm_bo may be set to null after allocate new vram buffer.

I agree with this part.


>
> 2: During waiting svm_bo of prange got released in a while loop should schedule
> current task to give other tasks oppotunity to run, specially the the workque
> task that handles svm_bo ref release, otherwise we may enter to softlock.

We had a similar discussion a few weeks back for another soft lock and I 
pointed to  cond_reschedule, which seems to be the preferred way to 
avoid soft locks in the kernel. Does cond_reschedule work for this case?

Regards,
   Felix


>
> Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index bed0f8bf83c7..1074a4aedf57 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -502,11 +502,11 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
>   
>   	/* We need a new svm_bo. Spin-loop to wait for concurrent
>   	 * svm_range_bo_release to finish removing this range from
> -	 * its range list. After this, it is safe to reuse the
> -	 * svm_bo pointer and svm_bo_list head.
> +	 * its range list and set prange->svm_bo to null. After this,
> +	 * it is safe to reuse the svm_bo pointer and svm_bo_list head.
>   	 */
> -	while (!list_empty_careful(&prange->svm_bo_list))
> -		;
> +	while (!list_empty_careful(&prange->svm_bo_list) || prange->svm_bo)
> +		schedule();
>   
>   	return false;
>   }
