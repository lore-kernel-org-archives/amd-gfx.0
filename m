Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD0BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 11:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF0F61BB6
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 11:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3CF0F61BB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD083892B5;
	Wed, 17 Nov 2021 11:35:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B46E3892B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 11:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECxcSfG//Dmo7pV+hfXOIDMQ4uIqwUP34xk5y84pk3+9j9yS0Gab2k3l+Mi+J/k6KNNu4PZdKASnTnHP5Mh6geLtsL3NTFHQTuXG3AdTQ0TjJQ8vVApTb+jYVaPG2Eol4ah270LpvECcRqnqdkFQDDFE4ATDxGe2NkbrFNopQYGADbWnP7ZAGL5VbA3AsA0mzaZpzpY6YLjTAEJVNlm0eqtE+hhZSVW5hSkA2z5NPywp3x3o5miJgkY2HdVPdIh3ZLNwNsdhLYsnGpc5JMi3m1SDMaUHmDdVoq3q6aISsQ6LZlbAZulVVoWcr2NTywxnzMZ16X0Qmninwyjw0qZWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1QFhgLSvHNDzYCSKWIWp/VlQf5sbSDOpzn3IEkuYCs=;
 b=NrAxu+PgpVJQ+KzaRHlU5E9vMFm7ZYz/sH4lj8262cJqWRfN3feeMnGdRrlp1d/UmqI6JAqoWZ3mCjpGDyXxofB0ZVZliNif/E4BTzga8LB//WormTOrVT30JsBOFyBzN5XkPsZsp6wUvUKHMSah0LG46w3BNgfV4iGmvknS6uoLe81qht+pC8KZ7tkHtxvpAWH+rOHY1GaJKANEk3UJib+OYXDvghLAyzXbqAtIalNG6FzEr8s+GVtDlfBLu5vNHPTEnghcMVRfZtmvHdIv/Mqfd63V83+bg0spLJNvkopzstsTLxhgTevBbvpLqehwdoCmD0O0rCCg8uJ6tKIJUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1QFhgLSvHNDzYCSKWIWp/VlQf5sbSDOpzn3IEkuYCs=;
 b=yeKI3fPQd/sXwT3VZcrmiqkNEhZJcmd2y8glOeVtIsIRccqFsRzhG0TZyytYfFkWahcO16xkss9h8G+gOtaIjkt2zlVo35XHBwRw3PpqsAdr+qs/VZytyhnz9x7bmJ6PwkFVjS7rqL/DFw9pfpfrYfSiDn+P+y3eWnZ+4mX/NKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 11:35:50 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 11:35:50 +0000
Message-ID: <4c818bdf-772a-0a78-a729-8e17f3e81cd1@amd.com>
Date: Wed, 17 Nov 2021 17:05:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH Review 2/4] drm/amdgpu: add new query interface for umc
 block
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, John.Clements@amd.com, Evan.Quan@amd.com,
 KevinYang.Wang@amd.com
References: <20211117101132.6568-1-Stanley.Yang@amd.com>
 <20211117101132.6568-2-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211117101132.6568-2-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16 via Frontend Transport; Wed, 17 Nov 2021 11:35:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ebb0aad-b427-4e05-ec59-08d9a9be677d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42351CD8AF7014143D83D7E6979A9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8uqUJzkm/Smk1Pe6p6W57nHnRb+rAr89IYe15dy8vgGidCbOaQQ+kzpRQSm0nPwrnD+UEIbCRhQ/EAJlWMz5dXjGb52dXB4NfzF6WTMYo0Y4yWjJ85GvRojSFrDC7dAXpmOkVpigWGh0Vhl4quM3x8JRZ5KCGvCD+O2amC7VWkbqorZdgJDht0ZYmfsH+Z64FPAe1OuU+q6vYYjlmfzvBAxG6z3EeZ+zys72bcYqn2BndVyhuMJGnOd4HUrxQDJwynkfVrI+eRRurEIrqrXgC7cQWV/wZN40dqX6Hwp0jHsLLhj2iHAPUs+07XJgdjUiTBEtW0FcUNJMDs42uOc15e8B8BI+TvA9HwoJlC35Rnskzz255704vqCP2urv3a0LWv1lwvvbiVGDWOwmpWiah+LsI+ihmL807ItaRLswCVo8MTd3aX45Nr+ujgH7sEctecjXPaFPStGoc027vwHa8In2fkTCmau5iZ0Zy6RAmMrdpiNHM7jrZN8FpHGDyiR1MSdj5RHhGK8tuAeYg7X7KmOigm30lx7uLlSo9SHvPk4wHj/HFCbjLDtnsuZUbBxCm+rUu7oGPYesnMNtL7Y6DVF46dcm1o34W/F04YCsQCiA01NU27VmKE3d0ZhD9eZi/MIvsg4g8/jjabtDjL6B+MdlEcDRZZHrm1TtLXphQCS0O8C1+FG25i5KiZxLlRpSnlxFzEb3XQZBCBcuesft3vmqAWIKMKz0X7Skea/QBWLyxk0FhCz7SS5HevnwipuB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(956004)(66946007)(508600001)(6666004)(8936002)(6636002)(316002)(6486002)(26005)(86362001)(16576012)(31686004)(66476007)(66556008)(83380400001)(53546011)(38100700002)(36756003)(31696002)(186003)(5660300002)(8676002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ArdExhZXFpNmkxa2FUK3gzajZmOHJDanVQTnMvV256WmorQkM1S1dDZWJa?=
 =?utf-8?B?c2Q4RW0vZTl5NlFDa2xVN3VvWlNuZllkOHFMRHg1NURMbUpmbVNyelFSWjJw?=
 =?utf-8?B?TFRCcEE0VlJ3R1dVcEM4NTZoVG9KZmNkR3YycHQ2K0dnd0JPcGl2STk4NnZB?=
 =?utf-8?B?UDZTc0NoZHg2dkh2Yy8vVFNzSUpmOTZUY0U0dFJPbDVXVEdnd1JONEZ6SEVE?=
 =?utf-8?B?Z0hRVnUxaVd1NkVxdG0vQjRMZkRzeUdzOUN1VEEzYXdicVhCMy85blpITEVz?=
 =?utf-8?B?bWtnc2hxeTR6UCtRc2Z5cThwSDdHQzdQWDA4RlRqbE5CRmFhN1p3UmVORjRP?=
 =?utf-8?B?ek5kMHdRQTFveGxFQ0pCbThxTzBvTzhxNXRGMEQ1WWZsczU2K1dvMkZXNWZ6?=
 =?utf-8?B?M00xc01xMmpQTldEWHdNUm5JMDVqSWw2NndJR1JwdzEvd1dHd1VyUGRrbnJG?=
 =?utf-8?B?Y1Fka0cxQTJ4czdJWXNCT2V0RHNpVHE2S21RZXBLZk9ubXhnalhxSXg1OTdS?=
 =?utf-8?B?Z2tnbWZDS0I5MFdnVUNCaFFzak9TbU9rcDdCTXhUeG1WNEZzQS9LbUJMQ0p0?=
 =?utf-8?B?Vzc5MXowZ3Jjcm9lVm15aTBaekdmbW4zeWtkaFRKaWwyNnFqTWhuUmZ4VVVP?=
 =?utf-8?B?ekx6SEFudGo2VlVJR0dyVDViMGR4NDdkZUdva1hSMndyUmFnVGlvbUtCV0Zx?=
 =?utf-8?B?NE95RFA5UVBvVVZhYzhwa1dISHNnYWt4YWlJd3lsOHltbFpLR2NCSVl2UVNs?=
 =?utf-8?B?RXZGNW5Ia3JCOVVoOGk5TFd6VnFxdlJ5bWdyRjB2bGRPSE9hbldmNkhLRVJt?=
 =?utf-8?B?bVlXc0R2UHY1Mk82MWZ6aDJ6V25NQVNydGl4S1Mvd281ZUZybEhRbXg3dFRn?=
 =?utf-8?B?VVlUb0NlOVhBZ0pKMkdBVHlXKyt1ZnIreDZDZ01LY2ovNU9CRDQ2cmxuMGNi?=
 =?utf-8?B?azhUMGlzRG5uYkt4UlVkQWV1TmVNaXJsT29NcElMc3pMU0pReW4rNXhGNzNZ?=
 =?utf-8?B?Sk41YU1FRnNVbmZCWldKdHd5RXMxM2hsSUt6NWlNaVhVOUczaG9SS3JPNHZJ?=
 =?utf-8?B?Tm4xU1FzUEpWQ3o3Nkk5OEttMjk5ZDcyd2E3Szh4NUNzWmJjYnkzZHFrOEhW?=
 =?utf-8?B?eVVOcEJzTEpGTW9hTWVyWTBSbXAyeTJRMUZVZ2h2WWIzdFpJM25qQlVjVTQ4?=
 =?utf-8?B?ZVJlalBKcnpwcUU2MnZGdkZJOW9WQklPWlBuV0F2SFU4OUtqRWJrMWNiSk1M?=
 =?utf-8?B?MHg2K3pCTW5VMk9hdGczSStUdXpsMTJuY0ljWW8vb0kvNElZcUJUNVFLRktT?=
 =?utf-8?B?U3U2d3M5ZlNqYWVKUjFrS3ZDS2lsYXViSFUxblJjT0JKVFdDalJmalpMZTY5?=
 =?utf-8?B?cFNxWnBnQnRwVzljTmRKUk0waWs3K1VOaTdsS3RYK3orR0dCdVljeERQa2dn?=
 =?utf-8?B?bEI2L1lkWGpYYXpaUlpGQkxJSk5aOE9YUGs4ZlFsK0pBeXRhaGpLNDlocWUw?=
 =?utf-8?B?TFIzT2FHRHIyUTlyVGcwRDFSU3E2Z3pzSEJKRFI5K3U5bWwxK092amI1b2hn?=
 =?utf-8?B?V3N6RTNjT0JsbUF6TWhOZi9XRHdDL1MzY2krMmo4ZURuS1dOSjhlbEdra0hF?=
 =?utf-8?B?ZFVxNzhpSmZVQzVwazk0UmpLSThVUHYrT1g0MHlmeXNicWMrakNMQ21oZlIz?=
 =?utf-8?B?ektMSWlFWUllREp4T093NDZVdUp1emRkWDF0akYxN3R4WnF3V1puMEt6aFFR?=
 =?utf-8?B?THhObmw5SW5vRmpOUkdQbmNLRE1zV1djZ3p5UWVCSjNBcXBzUlQrbEJpSy9w?=
 =?utf-8?B?bCtOQ0xRSnRMMGYwOGx4VzhNaTFYZ2hVdHBLTDdidElGUTg5UDBmaUFPMDBL?=
 =?utf-8?B?c2ZySVRRNEk1ZFh5V0xDdUVSRmx6TVVaS3NrSkllcEJtRTdReFVmMlVqS1cx?=
 =?utf-8?B?K3MyTGptN0hYSkptWFJMRDFUdXloVmtXQ1NvYkw1d1BBdUdnWlQ5TC9jRFZQ?=
 =?utf-8?B?dDRTNE12L3dFaUQ0SkpaVHUya01XcHhYT0hXRm1ZQWdwSU5sZndwMWxyYzNZ?=
 =?utf-8?B?NEdubVduSk94NUJKSVlTQ1hsT1ZTMXIwK2NrT2svdXpDdFJGZndFU2JVdDJW?=
 =?utf-8?Q?moxk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebb0aad-b427-4e05-ec59-08d9a9be677d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 11:35:49.9569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRd5ocy/V4sbfRQh1fHe+2JySB0MsTXUToXoZnOkxiA7Q79CMo0Xd77Cl6QWzB2s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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



On 11/17/2021 3:41 PM, Stanley.Yang wrote:
> add message smu to query error information
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  16 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   4 +
>   drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 161 ++++++++++++++++++++++++
>   3 files changed, 181 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index cdd0010a5389..bcbf3264d92f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -320,6 +320,19 @@ struct ras_common_if {
>   	char name[32];
>   };
>   
> +#define MAX_UMC_CHANNEL_NUM 32
> +
> +struct ecc_info_per_ch {
> +	uint16_t ce_count_lo_chip;
> +	uint16_t ce_count_hi_chip;
> +	uint64_t mca_umc_status;
> +	uint64_t mca_umc_addr;
> +};
> +
> +struct umc_ecc_info {
> +	struct ecc_info_per_ch ecc[MAX_UMC_CHANNEL_NUM];
> +};
> +
>   struct amdgpu_ras {
>   	/* ras infrastructure */
>   	/* for ras itself. */
> @@ -359,6 +372,9 @@ struct amdgpu_ras {
>   	struct delayed_work ras_counte_delay_work;
>   	atomic_t ras_ue_count;
>   	atomic_t ras_ce_count;
> +
> +	/* record umc error info queried from smu */
> +	struct umc_ecc_info umc_ecc;
>   };
>   
>   struct ras_fs_data {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 1f5fe2315236..7aa9b21eb906 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -49,6 +49,10 @@ struct amdgpu_umc_ras_funcs {
>   	void (*query_ras_error_address)(struct amdgpu_device *adev,
>   					void *ras_error_status);
>   	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
> +	void (*message_smu_query_ras_error_count)(struct amdgpu_device *adev,
> +				      void *ras_error_status);
> +	void (*message_smu_query_ras_error_address)(struct amdgpu_device *adev,
> +					void *ras_error_status);

Maybe rename message_smu to ecc_info. These methods fetch the error from 
umc_ecc_info table. They don't deal with smu or care about how the 
information gets filled. As long as ecc_info_table is filled, they could 
get the info.

Thanks,
Lijo

>   };
>   
>   struct amdgpu_umc_funcs {
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index f7ec3fe134e5..cd96e8b734cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -50,6 +50,165 @@ static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
>   	return adev->umc.channel_offs * ch_inst + UMC_V6_7_INST_DIST * umc_inst;
>   }
>   
> +static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *adev,
> +					      uint32_t umc_inst,
> +					      uint32_t ch_inst)
> +{
> +	return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
> +}
> +
> +static void umc_v6_7_message_smu_query_correctable_error_count(struct amdgpu_device *adev,
> +						   uint32_t channel_index,
> +						   unsigned long *error_count)
> +{
> +	uint32_t ecc_err_cnt;
> +	uint64_t mc_umc_status;
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +
> +	/*
> +	 * select the lower chip and check the error count
> +	 * skip add error count, calc error counter only from mca_umc_status
> +	 */
> +	ecc_err_cnt = ras->umc_ecc.ecc[channel_index].ce_count_lo_chip;
> +
> +	/*
> +	 * select the higher chip and check the err counter
> +	 * skip add error count, calc error counter only from mca_umc_status
> +	 */
> +	ecc_err_cnt = ras->umc_ecc.ecc[channel_index].ce_count_hi_chip;
> +
> +	/* check for SRAM correctable error
> +	  MCUMC_STATUS is a 64 bit register */
> +	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
> +	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
> +	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
> +		*error_count += 1;
> +}
> +
> +static void umc_v6_7_message_smu_querry_uncorrectable_error_count(struct amdgpu_device *adev,
> +						      uint32_t channel_index,
> +						      unsigned long *error_count)
> +{
> +	uint64_t mc_umc_status;
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +
> +	/* check the MCUMC_STATUS */
> +	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
> +	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
> +	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
> +	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
> +	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
> +	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
> +	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1))
> +		*error_count += 1;
> +}
> +
> +static void umc_v6_7_message_smu_query_ras_error_count(struct amdgpu_device *adev,
> +					   void *ras_error_status)
> +{
> +	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
> +
> +	uint32_t umc_inst        = 0;
> +	uint32_t ch_inst         = 0;
> +	uint32_t umc_reg_offset  = 0;
> +	uint32_t channel_index	 = 0;
> +
> +	/*TODO: driver needs to toggle DF Cstate to ensure
> +	 * safe access of UMC registers. Will add the protection */
> +	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
> +		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
> +							 umc_inst,
> +							 ch_inst);
> +		channel_index = get_umc_v6_7_channel_index(adev,
> +							 umc_inst,
> +							 ch_inst);
> +		umc_v6_7_message_smu_query_correctable_error_count(adev,
> +						      channel_index,
> +						      &(err_data->ce_count));
> +		umc_v6_7_message_smu_querry_uncorrectable_error_count(adev,
> +							  channel_index,
> +							  &(err_data->ue_count));
> +	}
> +}
> +
> +static void umc_v6_7_message_smu_query_error_address(struct amdgpu_device *adev,
> +					 struct ras_err_data *err_data,
> +					 uint32_t umc_reg_offset,
> +					 uint32_t ch_inst,
> +					 uint32_t umc_inst)
> +{
> +	uint64_t mc_umc_status, err_addr, retired_page;
> +	struct eeprom_table_record *err_rec;
> +	uint32_t channel_index;
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +
> +	channel_index =
> +		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
> +
> +	mc_umc_status = ras->umc_ecc.ecc[channel_index].mca_umc_status;
> +
> +	if (mc_umc_status == 0)
> +		return;
> +
> +	if (!err_data->err_addr)
> +		return;
> +
> +	err_rec = &err_data->err_addr[err_data->err_addr_cnt];
> +
> +	/* calculate error address if ue/ce error is detected */
> +	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
> +	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
> +	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
> +
> +		err_addr = ras->umc_ecc.ecc[channel_index].mca_umc_addr;
> +		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> +
> +		/* translate umc channel address to soc pa, 3 parts are included */
> +		retired_page = ADDR_OF_8KB_BLOCK(err_addr) |
> +				ADDR_OF_256B_BLOCK(channel_index) |
> +				OFFSET_IN_256B_BLOCK(err_addr);
> +
> +		/* we only save ue error information currently, ce is skipped */
> +		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
> +				== 1) {
> +			err_rec->address = err_addr;
> +			/* page frame address is saved */
> +			err_rec->retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
> +			err_rec->ts = (uint64_t)ktime_get_real_seconds();
> +			err_rec->err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
> +			err_rec->cu = 0;
> +			err_rec->mem_channel = channel_index;
> +			err_rec->mcumc_id = umc_inst;
> +
> +			err_data->err_addr_cnt++;
> +		}
> +	}
> +}
> +
> +static void umc_v6_7_message_smu_query_ras_error_address(struct amdgpu_device *adev,
> +					     void *ras_error_status)
> +{
> +	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
> +
> +	uint32_t umc_inst        = 0;
> +	uint32_t ch_inst         = 0;
> +	uint32_t umc_reg_offset  = 0;
> +
> +	/*TODO: driver needs to toggle DF Cstate to ensure
> +	 * safe access of UMC resgisters. Will add the protection
> +	 * when firmware interface is ready */
> +	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
> +		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
> +							 umc_inst,
> +							 ch_inst);
> +		umc_v6_7_message_smu_query_error_address(adev,
> +					     err_data,
> +					     umc_reg_offset,
> +					     ch_inst,
> +					     umc_inst);
> +	}
> +}
> +
>   static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>   						   uint32_t umc_reg_offset,
>   						   unsigned long *error_count)
> @@ -327,4 +486,6 @@ const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs = {
>   	.query_ras_error_count = umc_v6_7_query_ras_error_count,
>   	.query_ras_error_address = umc_v6_7_query_ras_error_address,
>   	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
> +	.message_smu_query_ras_error_count = umc_v6_7_message_smu_query_ras_error_count,
> +	.message_smu_query_ras_error_address = umc_v6_7_message_smu_query_ras_error_address,
>   };
> 
