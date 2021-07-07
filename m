Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9722FC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5486761CAC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5486761CAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2366E852;
	Wed,  7 Jul 2021 09:05:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FDE16E852
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 09:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+ChCIByjpGPwNhOXOL6K6ZRyg8p/9ut8f9LfM/v80RewquUagpxG6Ku2JAahOVMFqAWANT2aFbupk8oGwL/2hv9fWhBFlw290MkPV1y0RS92KaJh309LnbN4zuAoMq7mrJMGhJRIYVskVBipl5pGQkUGz2WzyBvsh2Me6E+ACFz99pdQzSvVI+6xlxXL90dERlxC6PyPnJMXKnXcRh/lYhQngnWyaHUR3k5FLh7RAZeLDHcCuFhHwj7ov2JUH+Asb//rO4cwf0PHNW568xDj5JKpLLUFt2u99jxUVOSNw4PVwcU8JmjD/J7UJ1nlOwAQNn7dgtgQYfmC1PCJUhVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/ac5wtd17WVLQmH8jKFryU+9VguzEs2mZ6q2b3dgTE=;
 b=OZAYCY9ERdkzu0qRbXj8QI9tgKVuhF2dETm2EU32cKd9KxU3NkBcM0I6Rmk8PExRxJFS2KFST/D+i5aXf2/wRYeE0rhbP+bFQ6Dahpi/aowfIxCj1GP3VEPwq695bmqinszVAF1AoJVvlgwK9gVPgmgCg5e24QTZkKEWOmG5qQx/2kSCVSs/lZ8x6OWTheUoBLdidID7unGYEBPyQMSA1wjcW9p9VIMNj+ZwfC66r3DqKitZhUoL7svaPh95q+qXaOBtEFgPNhhGJ/7sbhHcUUsx8Su5N5nWcqQwnaA/EMf5uoo3vpj6Bc510h3EKHcPsfHAM/44LNlMo1uRL60k9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/ac5wtd17WVLQmH8jKFryU+9VguzEs2mZ6q2b3dgTE=;
 b=snuHtKkPig79n/edSOglB4OGDRvzUL0FLaWGSszONTbIOyRzR/UItQCKp0f5NzX452IF9JOP+7ciW1ba4o5q8bfyoVzX1yHRZAObVAgZsJg2lZ/LXj60KrCzmnLCsGKHYGiLn/nBmGRt1LeMHKpxlVZDjl6IuQussn+zk6lMz1Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 09:05:55 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%9]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 09:05:55 +0000
Subject: Re: [PATCH 4/7] drm/amd/pm: correct the fan speed RPM retrieving
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210707015647.139127-1-evan.quan@amd.com>
 <20210707015647.139127-4-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <810e05bc-ac5b-3333-60b2-7809943625b0@amd.com>
Date: Wed, 7 Jul 2021 14:35:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210707015647.139127-4-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 09:05:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ade9c3c-92f0-4926-c568-08d941266d8f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB50745290FF57286CD2EBC2DD971A9@CH0PR12MB5074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaAGxdHWhDj0D1GOnLVPtDqM7VQGvsxhRn18kS3lsOy+2t/0AGcJBQbSQ8O8NlWcNaYqgUb68Fjlle06fpe3lwKhXQAQfFt1DVhkl1uVhZWC/4zpe1sS2BcZtGEroQGnnFNZB2t6ZOlwU0NC2130FQv3KRIQoFg32LpMrHWRWfuev8zcIxvzM3eRSFhH4TPs79bljytADcV0j8m3gioKNR0LBNeM9n21u+Ov06TbglR7rQ5F/T+bH7dAUIc+FSmf9gHvBesytxQsmtA3QXKvicgs2593gSHA6mB2ecTtJknldG7tUiQ4srq8gsLsHH6PZ2t8pzV/AzN/kVkwogQUmrvxtHoaes5zwhU01hxJDI80C6dREaGjjFD3aPAMV49EVpXTRzHeqMT/3nYtGDHPWKCqkq/h5qOlZk+NwV6qOUOaCb4EHLgFoVvu1LaNc5V5pQoTXrE0k/gKKt2e9bzTUu8eDtCZVvzOVYvOvnabdXxSMlBtwZi6s1NJCctyBNXaG56oS/3wAxu40ZISWRsKPXzBmLuY/iC5yANyN9RKZz3WJXNBkpG5zKTUV2UNGZYHPoRfX03zrcCo0NcxaJ+60RlpKV2Pf35p9r7Jjj3AycGLCo6+Hlw6P7ybU8nqNVxqwdF02nruqJzjAxJAxxuigQ/GZ/0RwbbA/V6HzzmD2gUjXx2D2iGuCqErmURNCupE5YRxBSHrLtK9F9o9ztWBmCXt6fXoOrYIColy3iJWE6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(31696002)(26005)(31686004)(8936002)(2616005)(8676002)(956004)(38100700002)(6666004)(66476007)(83380400001)(2906002)(186003)(478600001)(6486002)(53546011)(4326008)(5660300002)(36756003)(66556008)(316002)(16576012)(66946007)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0kxK2d0SlRjWGg2VHMra2QyNU9RM2diQ0pndWlZRU0vdFR1MmFnMmYrdnp3?=
 =?utf-8?B?TWluMWlqRHlsMVFkNHBxQXFYTTIxdk9FL0RkTnFkV0NuSlNROTEwakdZQ1Vx?=
 =?utf-8?B?U1NxbDRqRldBTXBybDE3QWFPZEVvWERscHBpa2x6eVlZVjZtVmlRR05DMFlF?=
 =?utf-8?B?MlVkYTJIaUFXTWFJYmI1UW1BSThDM0dWclhZdkNXNWZjRDA2a3lGckZyL250?=
 =?utf-8?B?bGl5WnpXV2RnUU13MElXaWZzLzdqRWdpU3lhRVVjMmJuQnV6L2k1VldsaitU?=
 =?utf-8?B?dWt3M2tZNFBaN1RjS1Q5akp5ajU4SnY5T3VPQmJDWW9MeUR2ak5GaTBOcTZ2?=
 =?utf-8?B?L0VZa2hjMnpQbE5BbFBEUVBLeHppV25pb2N0UjI4a1ZEOGxEQmI5WGc2ZnB3?=
 =?utf-8?B?WWlMOTNSdm8rZmFMK3ZJUGZlU1BJNm1ZYzE3ekpRNTNtcmQ3Zk5OeXBtOVhZ?=
 =?utf-8?B?cVJKdXdTdk1obGNQbVNRcDNnTDljbFB0dUdLT1BpNTdEdENuNStMZDBJYjNO?=
 =?utf-8?B?eCtwMkcwd3BjbU9Wc3N2YWJndUlxU013NW5IMjZDcDlZNW5tamFmeE93aFVP?=
 =?utf-8?B?cDFLL3k0V1UzMGJzMEZoeFhWWGdDS21KeTFTbk1UWFpmeWlZYXJhTWVnMHN3?=
 =?utf-8?B?d3Q3TCtoSlU3NVVDUnNvVDhRT3kvWDNvaXR1a1d2NmRjWWRZc2prRkxtaXVu?=
 =?utf-8?B?aDNVR1FOOHZBYlBQSDVmbnV5MWxVVm55c29BSUo1NFNyVHpUbk5sdGQzT3NM?=
 =?utf-8?B?OWwraHV0dllmZzZBQWxKQlFNSkdjZzJrOUpDYTVHMWVONkgxNnRuUzZ3VmEr?=
 =?utf-8?B?aTNiMkV1NnovbVRmQ1JxN3dBVU54S2I0LzhBeE01V3JmeWYzL2FmYm52ZlBR?=
 =?utf-8?B?TmtJcWlyWEJiSTBUdmdJdVc3UlM4bkd4MGFJMFhxanpMeDNWWW5GMVk4VDhT?=
 =?utf-8?B?b2pqUCtsSjdXd1VnZlNKUHJIeFJlaUluOGN2QVlEZ3BkeUtzR2JYMW9RS3Zp?=
 =?utf-8?B?bUJFc2ROSExGeHp4ZG9MaHQzOFhBUXRZaStSdUJuUlMzZWJNMnJ6c0k0elc4?=
 =?utf-8?B?QUZWTlpNbXF3RmtUSTQwZjZCZDlJNmZtQnZYVW9hVUQxWUdDeDRBbmZ5TDVX?=
 =?utf-8?B?U0ZkWlN1MmtQVlgrdmJQT1VXb1RKMGhURkpta0RtMitma0Y1WWNTTE1wbWw1?=
 =?utf-8?B?UC9Ba3VxWnd6WFNnNERQOVBDbkQwTXFGeWRMSndha3hadEVteEJSc1pRRm5K?=
 =?utf-8?B?QVVsQSs1a3h0OHI0SmcrdW4vb3p5YTBFQ0Q3cDdwYVMwalZSd1NzdU9PZVYw?=
 =?utf-8?B?d29Bd291c01jUnRZanNUQ0wzSlB2dFFUbzRRZG9YZEZPcjJ6Q21NMHJyRFBp?=
 =?utf-8?B?MS9lTVorU0R3NWNzbWxuQzZuTnNVdmw2d2JLak4yTWhhUDkrMDdlMGtjbVY5?=
 =?utf-8?B?d00wQ3dEWExJdExLdUM1V2tvbjFKUm4zazJuU1NBQWkvc0gwT29jczg3Ty9o?=
 =?utf-8?B?dnRWcm5Xa09HNE4yTVFmYkRkc2NZNUNFUGJweFFHNzZBaDBQL1M1YTZENSt4?=
 =?utf-8?B?SXQwVU5CUFhzeEIxNG9TOXpmUTJ6MUJmK0xEeEFNT1NzTzJVU3dtUWhDeDBN?=
 =?utf-8?B?SGE1MzNZNjhheU9ITlUwSTVmM2R6NFBtenhQREU4VnI0VnY3ekdXSWthSkxa?=
 =?utf-8?B?VFpkYUhqMk51b2luNURmTy9yejRGVEFzRittYlVIOGcxVUcrbFp4elRNZEJt?=
 =?utf-8?Q?2SRsOCdTv4vfEUeIWFaecZFIox6hPNorj0zcrP1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ade9c3c-92f0-4926-c568-08d941266d8f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 09:05:55.3970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RHhzFDq/TCe8R3WGhrS4vNCg0ihugDCvBI/CE3zzbKWOIVLiXFSMJznxXVUsWRm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/7/2021 7:26 AM, Evan Quan wrote:
> The relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
> PWM and RPM is not true for SMU11 ASICs. So, we need a new way to
> retrieving the fan speed RPM.
> 
> Change-Id: Ife4298c8b7ec93ef023a7da27d59654e0444e044
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   .../include/asic_reg/thm/thm_11_0_2_offset.h  |  3 ++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 ++++
>   drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 ++---
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 24 ++++++++++++++++
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 24 ++++++++++++++++
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 21 ++++++++++++++
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 28 +++++++++++++++++++
>   8 files changed, 110 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
> index eca96abef445..8474f419caa5 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/thm/thm_11_0_2_offset.h
> @@ -38,6 +38,9 @@
>   #define mmCG_TACH_CTRL                                                                                 0x006a
>   #define mmCG_TACH_CTRL_BASE_IDX                                                                        0
>   
> +#define mmCG_TACH_STATUS                                                                               0x006b
> +#define mmCG_TACH_STATUS_BASE_IDX                                                                      0
> +
>   #define mmTHM_THERMAL_INT_ENA                                                                          0x000a
>   #define mmTHM_THERMAL_INT_ENA_BASE_IDX                                                                 0
>   #define mmTHM_THERMAL_INT_CTRL                                                                         0x000b
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index fa585f0be530..db5123fc6042 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -726,6 +726,11 @@ struct pptable_funcs {
>   	 */
>   	int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);
>   
> +	/**
> +	 * @get_fan_speed_rpm: Get the current fan speed in rpm.
> +	 */
> +	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
> +
>   	/**
>   	 * @set_watermarks_table: Configure and upload the watermarks tables to
>   	 *                        the SMU.
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 8e0f8e9a1665..05c8fc8fc3f9 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -229,6 +229,9 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>   int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
>   				    uint32_t *speed);
>   
> +int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
> +				uint32_t *speed);
> +
>   int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
>   				     uint32_t pstate);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 9a25443988e3..54fb3d7d23ee 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2614,17 +2614,14 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
>   {
>   	struct smu_context *smu = handle;
>   	int ret = 0;
> -	u32 percent;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->get_fan_speed_percent) {
> -		ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
> -		*speed = percent * smu->fan_max_rpm / 100;
> -	}
> +	if (smu->ppt_funcs->get_fan_speed_rpm)
> +		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
>   
>   	mutex_unlock(&smu->mutex);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 4a6544b8e05e..e3303c8dcaca 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1162,6 +1162,29 @@ static int arcturus_read_sensor(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
> +				      uint32_t *speed)
> +{
> +	int ret = 0;
> +
> +	if (!speed)
> +		return -EINVAL;
> +
> +	switch (smu_v11_0_get_fan_control_mode(smu)) {
> +	case AMD_FAN_CTRL_AUTO:
> +		ret = arcturus_get_smu_metrics_data(smu,
> +						    METRICS_CURR_FANSPEED,
> +						    speed);
> +		break;
> +	default:
> +		ret = smu_v11_0_get_fan_speed_rpm(smu,
> +						  speed);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>   static int arcturus_get_fan_parameters(struct smu_context *smu)
>   {
>   	PPTable_t *pptable = smu->smu_table.driver_pptable;
> @@ -2246,6 +2269,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>   	.force_clk_levels = arcturus_force_clk_levels,
>   	.read_sensor = arcturus_read_sensor,
>   	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
> +	.get_fan_speed_rpm = arcturus_get_fan_speed_rpm,
>   	.get_power_profile_mode = arcturus_get_power_profile_mode,
>   	.set_power_profile_mode = arcturus_set_power_profile_mode,
>   	.set_performance_level = arcturus_set_performance_level,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 2ddf35788672..7dce5ea7c1a0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1668,6 +1668,29 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
>   	return !!(feature_enabled & SMC_DPM_FEATURE);
>   }
>   
> +static int navi10_get_fan_speed_rpm(struct smu_context *smu,
> +				    uint32_t *speed)
> +{
> +	int ret = 0;
> +
> +	if (!speed)
> +		return -EINVAL;
> +
> +	switch (smu_v11_0_get_fan_control_mode(smu)) {
> +	case AMD_FAN_CTRL_AUTO:
> +		ret = navi10_get_smu_metrics_data(smu,
> +						  METRICS_CURR_FANSPEED,
> +						  speed);
> +		break;
> +	default:
> +		ret = smu_v11_0_get_fan_speed_rpm(smu,
> +						  speed);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>   static int navi10_get_fan_parameters(struct smu_context *smu)
>   {
>   	PPTable_t *pptable = smu->smu_table.driver_pptable;
> @@ -3182,6 +3205,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   	.notify_smc_display_config = navi10_notify_smc_display_config,
>   	.is_dpm_running = navi10_is_dpm_running,
>   	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
> +	.get_fan_speed_rpm = navi10_get_fan_speed_rpm,
>   	.get_power_profile_mode = navi10_get_power_profile_mode,
>   	.set_power_profile_mode = navi10_set_power_profile_mode,
>   	.set_watermarks_table = navi10_set_watermarks_table,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index e7686ce6744b..2f93dc4b5968 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1355,6 +1355,26 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
>   	return !!(feature_enabled & SMC_DPM_FEATURE);
>   }
>   
> +static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
> +					    uint32_t *speed)
> +{
> +	int ret = 0;
> +
> +	if (!speed)
> +		return -EINVAL;
> +
> +	/*
> +	 * For Sienna_Cichlid and later, the fan speed(rpm) reported
> +	 * by pmfw is always trustable(even when the fan control feature
> +	 * disabled or 0 RPM kicked in).
> +	 */
> +	ret = sienna_cichlid_get_smu_metrics_data(smu,
> +						  METRICS_CURR_FANSPEED,
> +						  speed);
> +
> +	return ret;
> +}
> +
>   static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
>   {
>   	uint16_t *table_member;
> @@ -3820,6 +3840,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
>   	.is_dpm_running = sienna_cichlid_is_dpm_running,
>   	.get_fan_speed_percent = smu_v11_0_get_fan_speed_percent,
> +	.get_fan_speed_rpm = sienna_cichlid_get_fan_speed_rpm,
>   	.get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
>   	.set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
>   	.set_watermarks_table = sienna_cichlid_set_watermarks_table,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index c49683b07076..0cdf55a0dba2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1284,6 +1284,34 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
>   	return 0;
>   }
>   
> +int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
> +				uint32_t *speed)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	uint32_t tach_status, crystal_clock_freq;
> +	uint64_t tmp64;
> +
> +	/*
> +	 * For pre Sienna Cichlid ASICs, the 0 RPM may be not correctly
> +	 * detected via register retrieving. To workaround this, we will
> +	 * report the fan speed as 0 RPM if user just requested such.
> +	 */
> +	if ((smu->user_dpm_profile.custom_fan_speed & SMU_CUSTOM_FAN_SPEED_RPM)
> +	     && !smu->user_dpm_profile.fan_speed_rpm) {
> +		*speed = 0;
> +		return 0;
> +	}
> +
> +	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;

Same frequency comment - no need to related to ASIC refclk, define and 
use fan control crystal clock.

Thanks,
Lijo

> +	tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
> +
> +	tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS);
> +	do_div(tmp64, tach_status);
> +	*speed = (uint32_t)tmp64;
> +
> +	return 0;
> +}
> +
>   int
>   smu_v11_0_set_fan_control_mode(struct smu_context *smu,
>   			       uint32_t mode)
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
