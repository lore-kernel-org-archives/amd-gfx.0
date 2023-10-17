Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E85CCDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 17:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2AB10E307;
	Tue, 17 Oct 2023 17:59:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105F410E307
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 17:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYC088XrIZ4VmdPLsNIPtm7qTne7gOLleYISs217Jjl1FUHXhSse2wJXvjJ05rxylpsxjTziOcvrZmJ+NOWUb4lnnHdRm8GPct3f5SgCE5hZlWqOt93Jt1W08eFqExo8mDvIXKPs3BQ+Bjqn5gGFrcLESKiy00QVE9ponrRyCgPSjiR1QZPcN0t9Jp8TYEwmm2YaRsXuevtgqb3RRsnmvVsnH1Dbm5QaAun5Yh6VFmFRV/GDcSDkoP2B5RfEWX8Df1GaU3vYuNcwdo2cj2KSSfapdRqqFiikIlINP9nRX+vPwWFx3XGXU3Y0zaxb3lkWPEUfOvAf2KFF/FWIbHzgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox32VVUh53ktUusD8IcDSHta4UxA7LTtxEMx/Tfpbr0=;
 b=mie/8Qa+r8X97AuKuOPPJ+PVZPQtgvOGZQ2iK1EVrU9vk1mQEXXY40X/xZNDONrrODhhRBebfx7rFgtYMqz+vqhrdcI5poCnNxt62vNysGm4I8jVlHhB40dDWdmMirw2fdhE+opVKfCqWyvQtvRm2hE0SdN9Ib8AfjGwZ3cW6HPoCBePq6r/eF3i47odUnZuj3qV7vqZk1cN5TLo72Mzsk+kDe4Rb/w95m5UalegGUAh5f564WgYBHfV1ORfVtQE2b2+CZ0Snrb3QXsKLMLtyPuJmQdCOCBH3uLrNLYYWDCWaUff9AIspNJPRxeJ60LnU3+W/E/H1U4YCNdNP4wv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox32VVUh53ktUusD8IcDSHta4UxA7LTtxEMx/Tfpbr0=;
 b=LNJd3O642GcV6GPb19+bPUIuJA20KYgH9PHPoHj6HBVbjtYO3A5uVOs92OKKbe2F0vThOhJ3FMtkVhrONzeXXOiTccp6v+T9g/NhiulDvaSAjO8ItaA78AsAvV+lZ9O97Ugseost+j5Um+Z2EKclxdprcN+MQjr5Iq3A9HoCtCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 17:59:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 17:59:39 +0000
Message-ID: <6043a16e-24e1-4b1a-980e-f65b278f5f12@amd.com>
Date: Tue, 17 Oct 2023 13:59:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/amdkfd: Add helper function
 svm_range_need_access_gpus
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231010144024.3016-1-Philip.Yang@amd.com>
 <20231010144024.3016-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231010144024.3016-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e39fc6d-46e4-44e5-1d29-08dbcf3ad506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7A+tdicW+iMxEPx4MC028Kb1QQmviNxRTOmNhqZk2eIzUT46asZrZ8FkY0eVJdbijvUV/ak03/E9cVMkL3ubsMWFDCio7j33IAGk9z5hqT/Z/IcMBZQx3kAVQ7LgGTth1Bo2w3dupZn7WW/xNpqDsbBkyz0zXHIpirCx1DbFOpCR3pQiJcVMF7ObC0kSmmZp2tbLecXb3n8BNGtkdqlydUsJRhgsp7NPmiwkL8gaLDynzHWMSxUKRWwiSOmDzztkOGnagv1J0Rwzhuir+yUgNR+V7Vwo6VKLERrxyXokMhClAwVTJZ6iIQx9ECMsAqBuIr95IEy3veAvGMk+H2p13ocUAUU3mfyOSe7jbUwKYrhWUXsJe+NdjOCF8wvd88YdfmiPK9G7BfJCpsAuiYYsu5hCkvUyU578ZaSUcrWblbVfGe+n9+akY8GnXJ2QD/i3j22dapIjWETBDODssZ7lkHwBvrI1WfL8X2phV0flJB5CYXfsedO4ImmzjlFX6Ow1ibK1zEZqfeKTR+1VDl9YMVPz4OqTD3T0PNnT8SZBZBtLcqwRqaz4o34mtZ//FlG9XP6LGUGS9eQZbePS+xqUdAcXr0zdaEvk6rwfZypTqtpsn3q2iCUzS21WO/fz6b5d1y/xy5aPPMsLwYzx8tsPwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(478600001)(2616005)(316002)(66946007)(31696002)(6506007)(36916002)(66556008)(66476007)(2906002)(8676002)(5660300002)(4001150100001)(44832011)(41300700001)(8936002)(6512007)(86362001)(26005)(83380400001)(38100700002)(36756003)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXRkai9HSFdiWWIxZDJVUWh4ekhUMTlQZ1FrZ3Yrcmp6SWtncjhvakdvTEJP?=
 =?utf-8?B?UWRKV2NYNjMrT3I1Q0pYZFRVOWVNbmRpZkFhMm40NCtIZUtTL2NQWlZTQ29a?=
 =?utf-8?B?elA2dDYySXhDOEhyU1RsWmtsTVFqSHFvR3o0dVFUcHN1T0t2N0dJeklzQ3ZR?=
 =?utf-8?B?QTVCWUNlbzc0RXVoOVJTYkpiQk02RzlGRUFqWURFazBkeDQzUWhLeCt1U3Q0?=
 =?utf-8?B?SG5UZzFXZVJJN09TMHhMSCtzNzRvakJiYmxqMkh3RkhlemdYYjU2UUVWWFo2?=
 =?utf-8?B?TjNrMDRpNTNrN0Rlb3F1Vm1rQ1Y3cjNHRjVwd1pNZDJJN0pxRitnNi82dXlX?=
 =?utf-8?B?byttTlEwU2RKc1Z3MFdsWGNhVXBaVU9abzgza0xZMTBBRGdqSGVvOXVLQTdS?=
 =?utf-8?B?WGFsQUw2ZVpKdjBCTGcrRXJPbERTa2RqbmRBZGZBMUdqN1RzNnNTb0RwTU1L?=
 =?utf-8?B?akhBWm9DLzA0cmdNd1kzUE9ZUW9nZFBhZ29UbDFqTGlaTEhIUGxremp6TUlS?=
 =?utf-8?B?Q3psSHZBakszMGtpTllBQVZBdWUvUzllaERkRm41aVltY25acVRVTXZiOEsx?=
 =?utf-8?B?T1FxRlowcHhVOW5SYURlSk9VQU4rWVA4T29BWWZwYWJZa2FsQlJQeEZqOTJ5?=
 =?utf-8?B?Q2JCTjhtV3ZRUVNNUTQrR2h5OE1jSDFFQ0hNTndZMzZ4RW1hck9WVFV5Q0Rv?=
 =?utf-8?B?SUtJcEtKQjFPbnVEbGVjeHlCVlpiOWdVelpXR3hOMldCRzF5VWlCVVZOTjVM?=
 =?utf-8?B?Nk0vUVJ0V0hnc1FXUjI0d1hNUzVZVEtZb2FqZXZkcjdFWHIrczR1N042Z0Zx?=
 =?utf-8?B?Z1hIaGU3TEE2dzRCdWRkQzF2bERReUd6ZHQzYUh6Z1pBWXk1d0JROWRBR0Y5?=
 =?utf-8?B?ay9OUUhXOEJRZ3pCWGhLcDJrNmlLUFl0ZEJ2M2orMWhxWmd3KzFWT3NPOEkx?=
 =?utf-8?B?SCtwMFNFc0RRYlJrNHcvanovM2xtemowYXI0ZmtwWDY5eEt0WDlkYU1TZldJ?=
 =?utf-8?B?ZzNaSWcrc1dYSFU0YWNuckJSNmpLTDRBR3paQmxmM2JmWW9mOFI2WGdOQzNM?=
 =?utf-8?B?dUVTNnIyWlBqTitDbFVrUUhkUmtwdUplWnVrZVNjSHREVHIyWlhvTGxVWVYr?=
 =?utf-8?B?MlFJSUpCS0hyRVRtYzhsQ1BZUFNhZWZDNlVQMGgzV2tjQzF6QXhQTE9UTzRn?=
 =?utf-8?B?eHdXaFJtOStQUkIzSmY5azVDYUpnSitHSEp2Ymtzc2tLREpCcEExVDJ2bnJ2?=
 =?utf-8?B?dk1ma3RyUDgybCs1bDNpakI1dzB4blNvZFh5dEoxZk5sRmZDaHlUUFJvZlhH?=
 =?utf-8?B?OUpjT3RFOXRicHFSSUpsYVFSR0JUVSt6bnR6ZU9ZMXI4cmJ1N3AzWVV6aVl4?=
 =?utf-8?B?SEtNL3N3K3U5OUxQTmNtTUk5OUoyNFd3cHFRaW5KSHA2NFU2clJwcHlHa0gv?=
 =?utf-8?B?WjZpeHI3akhVc09xUHpsUTNaRC9aMDRDM2x0Y1hWZENsb1BndFE0NUw1a3pR?=
 =?utf-8?B?bWN5aDU3a2RnNldvdHVFL3diZlU2dmtsTHNQZjBYMU00alQ3dDNsVG1DYlFj?=
 =?utf-8?B?dGNROVZtakRTMDBraStMckhvaTZBZW9HOGZTMW9kZ0QzNW4zN1NLKzYzazlY?=
 =?utf-8?B?ZEQ0ZzUrb2dEeXk3M1dlSEp6M1JSVm0xYVpJanI2bWM1OXI5a2tPUjRhc0RE?=
 =?utf-8?B?d01mcy9RQmVXeUkvYnN2OGYrT2I2N3pqTXRiU1Exc0hOSkZkbVdoMEFOQlFm?=
 =?utf-8?B?R3QwamV1dGxqUk1EU2IvZ09FQ09VN1NOMHNKUnlJUGtiRmFXdHY2T0N2aE1q?=
 =?utf-8?B?Wkh1U3RiK2ZBNUNFc0Ftb00wOTRQNE5TZUNiWFFkZ1AxeUZucDZmQjVmZTlZ?=
 =?utf-8?B?OVh2SHdaU1NaVnAxZVBkeG5oeDRJaWp1QzdINm9yc0NUVkxYQW9CdmJwaUQ0?=
 =?utf-8?B?czFsaXZiUURWc3VsRldPTldYM2J0WWtrWUxxMVZXVlVQdHFzM090MGZhaTlF?=
 =?utf-8?B?U3IwUkl0d1FIYW9CVFU1Wks1SzdETVMxeHFZUnR5Q3h4QVZwb2JPcVBpQnJr?=
 =?utf-8?B?U2F2enBBbjZKTGhoSjN5SFprWTRkUnNEUmpPdEJUWkhKVUFSNjV5bTRmNHlU?=
 =?utf-8?Q?2vPme12vA3gzakL2PFWPmCczK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e39fc6d-46e4-44e5-1d29-08dbcf3ad506
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 17:59:39.3232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsFiGxeOYDxoeNuuyddCx9KOt4M9Vd7GYaM+iiQ9o98RS4+H2YzEwfN6552mo9rDHIUJEct0wBCyjrew1O69DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

On 2023-10-10 10:40, Philip Yang wrote:
> Refactor svm_range_validate_and_map to add and use the helper function
> to get all GPUs bitmap that need access the svm range. No functional
> change. This helper will be used in the following patch.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 55 +++++++++++++++++-----------
>   1 file changed, 34 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e195106a77cb..fb22b857adbc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1191,6 +1191,34 @@ svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
>   	}
>   	return 0;
>   }
> +
> +static int
> +svm_range_need_access_gpus(unsigned long *bitmap, struct svm_range *prange)
> +{
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +	uint32_t gpuidx;
> +
> +	if (p->xnack_enabled) {
> +		bitmap_copy(bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
> +
> +		/* If prefetch range to GPU, or GPU retry fault migrate range to
> +		 * GPU, which has ACCESS attribute to the range, create mapping
> +		 * on that GPU.
> +		 */
> +		if (prange->actual_loc) {
> +			gpuidx = kfd_process_gpuidx_from_gpuid(p, prange->actual_loc);
> +			if (gpuidx < 0)
> +				return -EINVAL;
> +			if (test_bit(gpuidx, prange->bitmap_access))
> +				bitmap_set(bitmap, gpuidx, 1);
> +		}
> +	} else {
> +		bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
> +			  MAX_GPU_INSTANCE);
> +	}
> +	return 0;
> +}
> +
>   static bool
>   svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
>   {
> @@ -1631,28 +1659,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	if (gpuidx < MAX_GPU_INSTANCE) {
>   		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
>   		bitmap_set(ctx->bitmap, gpuidx, 1);
> -	} else if (ctx->process->xnack_enabled) {
> -		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
> -
> -		/* If prefetch range to GPU, or GPU retry fault migrate range to
> -		 * GPU, which has ACCESS attribute to the range, create mapping
> -		 * on that GPU.
> -		 */
> -		if (prange->actual_loc) {
> -			gpuidx = kfd_process_gpuidx_from_gpuid(ctx->process,
> -							prange->actual_loc);
> -			if (gpuidx < 0) {
> -				WARN_ONCE(1, "failed get device by id 0x%x\n",
> -					 prange->actual_loc);
> -				r = -EINVAL;
> -				goto free_ctx;
> -			}
> -			if (test_bit(gpuidx, prange->bitmap_access))
> -				bitmap_set(ctx->bitmap, gpuidx, 1);
> -		}
>   	} else {
> -		bitmap_or(ctx->bitmap, prange->bitmap_access,
> -			  prange->bitmap_aip, MAX_GPU_INSTANCE);
> +		r = svm_range_need_access_gpus(ctx->bitmap, prange);
> +		if (r) {
> +			WARN_ONCE(1, "failed get device by id 0x%x\n",
> +				 prange->actual_loc);
> +			goto free_ctx;
> +		}
>   	}
>   
>   	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
