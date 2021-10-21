Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E981FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E6C60FE8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1E6C60FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F83E6EC8C;
	Thu, 21 Oct 2021 14:27:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5B26EC8C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 14:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfUDJ/VR9hpKh7t8RGzdl7lryjhx58CbCcpO/DuR6EXHimdSi96Bb+ECEhpjwzTVXyQ8PQWiXbWOG/8KUjx21uOBc85zpBQTe9pEfZOS2ft4h0uSX7YwwpIBURZjo7OaPyN5c2Ii322+AdYe7tFtnn5xAs6LktxZGbQvIEDpG506iCzCznCpXjqoSa/mXfo0elia/dRle03gMNlfc7EF6tzB6kXAm9Z2JOw2fdHXrhsA2tqPJiGsBWdh9lMTuCXQ/dZhnE1vxp4SFgGxZNT6nVqwlcCButMMOX6z1xxQU63+ryE4CtzR6puv8DRy+hWWqZvTc/EDibmGiBbyItwfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIZ37wF4RWtGdUPkY3+C+h5nHrPbMQZVy4NGA5gI2Jo=;
 b=RB+6dyVZFnw0ObRUjA99R4KSuQLq5Fx/IkLDjcPG/8/yZFbz7njctHdlmG/yzMXzc1YrXUMbF3qErPQHYYDtjpyh1j86qgqkLlz5SXuhcpMAI+SvfM9nr9TXJFY3irjm3ttN2yFrqrEQWh7XMDq6WOUbNlJpHkFyUjGdP6OfK1VVi+YekOS+Bj1jBmtBHOJOUPPOuHL+THMwu4X+PhgHvxGDn4zZXmXJ4dMdCiHCuEQQrBgMG4FkRkP71hmPSVrC/EG52k/rktxUfxHYTBW54odHzBGDaH3LU+/rjXbAumuD5bwSrjZGJI4nWQx4AvCheibqldajzyV/cntsIJhO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIZ37wF4RWtGdUPkY3+C+h5nHrPbMQZVy4NGA5gI2Jo=;
 b=Dk2sKE6xL875zwHTjYW2LqHqqHW8aN+6Yp5a6RIYFTAPx8Cqa30AJRUUD35ryx8byFWquadYGwcLtJncQm14/mHvBSxi+Jqcxr7PAzrHW8+g+NRXv8e7gj7pWLnF+jX2YyxH8Y4RCXhBkgxz770N+Xj2YOYN7+A95TC96hL+YAQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 14:27:09 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.019; Thu, 21 Oct 2021
 14:27:09 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: debug message to count successfully
 migrated pages
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211021004719.15575-1-Philip.Yang@amd.com>
 <20211021004719.15575-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d3c418d1-a1e0-6fa6-58f8-8e9391b35be1@amd.com>
Date: Thu, 21 Oct 2021 10:27:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211021004719.15575-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::10) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT3PR01CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 14:27:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e35c759-9963-45d5-7ef9-08d9949edd74
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882C12E626A04A0C8A810DD92BF9@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIiALtMfiIL4chFVa8orEoRME8YPVZbICkz0IrElsK68qtysIbGM1V33mgDgNoXIjpCjKcuu1KdUylNFLhRsJWNfvVABwHH2LAecWmP4RbWLIsAiTtyZfyKvbZO8OmkPKFDcN0PL2P49+KYtTctW8w04N66ARy+GB36oAOc/hXmerIsWdnao5HzCzczHUgbQE/7b1ykurOc2YOBDr/m0O6qEDyfuy1C+i4KI4bkIc8ygsULnjUYif16yGrNu9hZ0YNS49TkJuUqx56PRCBFBk4xg3vs4eO0Drxf0zfU8HlS3aKScG/wpoc7OjZ1GJng6QzweGnEuTukCsaQB56ymNWZw64u2tsR+JKNtjbJlANDMMN80wKSRGgbQHmpYY5p7OCrNCEzB2OAWYGqPdbgLDKQOgb92J//evKJW5DlkfdRMntvcC2QGnRwz/EvxpNnfZTt73ANnORHvxJGoM2xWytMoNzPAr7Ala4ve/rFqkkrVsCYBhvefcSmUKZO9TCDbh2nWPyp6cwrIfo1wEF+KBXUl6F6pUTbIYyw0sWiDmOJxlJjoH1RNQ9ofo4ZFLj75px9JAd9tgPedp4GVbG4U6HtSldNuzb8Ig3m8QMJK0v+sNEGNT0RFhPOsmCKwdfRj7aPE9kZPyOHg5sL7rYpL2AQHjUz9Epxu+CvDrqda2oIqVBFQnxeKFKzpCRTcZ/PppEC5ksvewvroOE2CiHZ6UmPEGLaAEWj8sreWtTho1ChKHWC/DiQm/C4LlLhIhp7y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(316002)(8936002)(36756003)(16576012)(38100700002)(186003)(8676002)(86362001)(15650500001)(31696002)(5660300002)(66946007)(6486002)(44832011)(66476007)(83380400001)(2906002)(508600001)(4001150100001)(66556008)(26005)(956004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERXckFwVllWeUZmZE50RkV3S0VJaitSWjAxamRiUzZING9SWGJsV2tjMmNF?=
 =?utf-8?B?dkt1Qnd2VGxSU1MxVHozM1ZvNGtDR3JXRVl5aUtIcE5vQkorK0hxQUVPWTdQ?=
 =?utf-8?B?VnpjS2RtYmd1M0k2V2dERTcvZDFKOWhyUG5YbW8vN2wrcU9EcUhXdHZTNDJD?=
 =?utf-8?B?c3V2NkVEazBYamc1bEFlaVR3U2JDZENFQ0tvczBLVVcxc0c0amNZSlBaYUdr?=
 =?utf-8?B?Z1ZCYUJhaXhmYU5WOFZNNWdTZDBSNmpsNUptUWladzE3WTFWTU0vN0tSSm5D?=
 =?utf-8?B?RGoxdTJvOXV0NnlyeHhIOGh5YWtHeU9JMUFycmR6eDZueXZDR1F2SmtMYXA3?=
 =?utf-8?B?R0tVdzV1S3Avb3JENG1ubDZBb1FVbnc2U2JOWmRRU21qY3VHY2FJOExVaEZz?=
 =?utf-8?B?ZHdlcHRCZURJb3ZLN3dEa3NsenVWWE9IU09BckllaTc0c0VWWGYvQU12cnZ1?=
 =?utf-8?B?T0hBUzlBYzNLRFg5WVFkekdPakdtUTNYa3ZoM2c4dEpJMnRWWWNCeEEyc1Fr?=
 =?utf-8?B?bVpMUTRYUnU5TFVZTDNvZys0bHFBMzN4eHE0M2NjM21kaTFwMGkwMTBkSzJj?=
 =?utf-8?B?OGVHZC9RUE9kQjlBSlp1STZxT01TWkpHN1N5clpJcWxnZTMxREt2WUlNYnJs?=
 =?utf-8?B?anRHcERBbU9na0xCemVXR1FPWXFFU2pwbjhxN0lpVTdQVjdzSUNtSFZNYTM2?=
 =?utf-8?B?MFZtN0x5YkJHU0pzVjRrSXM4OWlqTXRPNzZBcXZhMWpVQ3NTNzlKdklYVjlM?=
 =?utf-8?B?bHlHTjFxQ1U4ejUvUVhxYVRkYU13bmRhZDBoSzMraUFudGRXb1l3dWtxWC9u?=
 =?utf-8?B?b1VyOWkxdmJvWWhKb0k0QmxWRnRaNlpaNWV3cUcwRkRZNk02cFdHcFJRVXNI?=
 =?utf-8?B?Z2pSS3ZOVks5Q1llc2JNTGZCWm8zN0o5TThlbldNT05TNnZKb3ZrQ3o0UGF2?=
 =?utf-8?B?TEMxa2pGVDNOeVBibkU4MlczbGpFWTlWTDVNdUswM3BpcmpNeWYzQThzWTh4?=
 =?utf-8?B?aU5sZEhiZU0vTUpXQUFjUURUSkYxRHFrVEowSFQ4VCtZbjVMclovbVc1emNB?=
 =?utf-8?B?a2pKd1F3WXh0WVlyTUZ5RVMrSm10aFRMUTQycnN1b3dqb1c5OThmYThxanFN?=
 =?utf-8?B?UmlJUGJuZitIL3lIYmd2Qno0a1IwdWo4QzRES3JST2NqZTYxczhBbTNwdVI2?=
 =?utf-8?B?cHZxNGY2MHRaaVdBYnljRlBiL2k4TVNTb3pBdXZBZXVndEQwQmxYQklRTFJq?=
 =?utf-8?B?T2t0THNqbjZnVmhrVGZlM0c0YWs5OCtsU01zd2xRMStjSngyaVlhVmV1S09W?=
 =?utf-8?B?WHdWeEVWVVRnL3VtYVl0Vjc1TVZFTXkrMzArSkp0SXd0RXhXUnAzRGdkczB4?=
 =?utf-8?B?d1dsa1BjYVNWWWlOZVBSQmRWcEF6bHVwU3ZkejBHVmJtNWk0VnZNOGNJWjhl?=
 =?utf-8?B?Z0tkelJLQmZoSHFnMVpYTHk5cnZmb094MWRqSGYrbVhpTG92Nk9oVTdGQ3N4?=
 =?utf-8?B?UlV3L3VEMjdVRHFlT1p6OTNFem5qU2hQb084aVQ5T3MvV2dvWU9hR284SkRt?=
 =?utf-8?B?YU42QjkvWkhjS2pPZGM1M1ZUK2JlLy9HL1lMQVY4K25aUmRORHpMTTdNbGZv?=
 =?utf-8?B?ZVRIcmlnYWhranAzSU1sV1NBaTc3czVGNWxxaSs3Vy9UbHR1U3AwcmV1dkl0?=
 =?utf-8?B?QkdWQy9KR3JKSkVnWXRNV1lHNnFFd3o4eHd3QzZnUDBEVGhaOEtybjlpcTc5?=
 =?utf-8?B?dU4zdTh0VXBoMzdHS1U1TEZESGIxVDZTdCtYbWxMT0lNVDN2KyszUEZmUE1L?=
 =?utf-8?B?RURsUE0zYTlJSE1RM3ZldVBNb01mSmdweDQrTnBBQTBRcktYUDRtNXJ1d2di?=
 =?utf-8?B?Z3B5Q2RLMmpTOEYrTkdReG9kdThXdUJjSTFnbnRzSHNnRVgwWHdMZVlkQi8y?=
 =?utf-8?Q?guKzDFDM/wo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e35c759-9963-45d5-7ef9-08d9949edd74
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 14:27:09.4057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkuehlin@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-10-20 um 8:47 p.m. schrieb Philip Yang:
> Not all migrate.cpages returned from migrate_vma_setup can be migrated,
> for example non anonymous page, or out of device memory. So after
> migrate_vma_pages returns, add debug message to count pages are
> successfully migrated which has MIGRATE_PFN_VALID and
> MIGRATE_PFN_MIGRATE flag set.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index a14d0077e262..6d8634e40b3b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -268,6 +268,19 @@ static void svm_migrate_put_sys_page(unsigned long addr)
>  	put_page(page);
>  }
>  
> +static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
> +{
> +	unsigned long cpages = 0;
> +	unsigned long i;
> +
> +	for (i = 0; i < migrate->npages; i++) {
> +		if (migrate->src[i] & MIGRATE_PFN_VALID &&
> +		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
> +			cpages++;
> +	}
> +	return cpages;
> +}
> +
>  static int
>  svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  			 struct migrate_vma *migrate, struct dma_fence **mfence,
> @@ -429,6 +442,10 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
>  	migrate_vma_pages(&migrate);
> +
> +	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> +		svm_migrate_successful_pages(&migrate), cpages, migrate.npages);
> +
>  	svm_migrate_copy_done(adev, mfence);
>  	migrate_vma_finalize(&migrate);
>  
> @@ -665,6 +682,10 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>  				    scratch, npages);
>  	migrate_vma_pages(&migrate);
> +
> +	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> +		svm_migrate_successful_pages(&migrate), cpages, migrate.npages);
> +
>  	svm_migrate_copy_done(adev, mfence);
>  	migrate_vma_finalize(&migrate);
>  	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
