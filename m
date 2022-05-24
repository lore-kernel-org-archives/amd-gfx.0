Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F479C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 16:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C735C10E3CE;
	Tue, 24 May 2022 16:03:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51DF110E3CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 16:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUQfAIJKnd9uJQTpkekWq/xYppb7UDPSZ+0ZKWDjsRtGiSG/MOQMFVBKdUYfqa4ryYkqMX5c9vKpFPW0NTRXNb5NNgfD+UnevHywB1rUZrCsdJWYQIX47a9M/skxMSky+uudJ3L3IG1R3zRowhGalLQmiaJ/lJZz5/z/yv5MDfeq9SpEomg2RWozNO94tTzJwcCDoDCDcZ8Ys9gG+BidLb+ZlZyChtB2CCq3njYbuA9l5Urgpylti3fEao5Iy3iHOLN73i5OqzeLJbYmrRqjoq+51+GXuE+rEUJEFfAISG6IMM7lLbcZ5wdgcZ8BBk6lXQ4MbdrdP46tunn9XssWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLkPCUyI4FAxJ5iyrwoXz2DnCZiBSIYZ4pD7c0BIQZw=;
 b=cdqkGJPt6IquwKWEX9xklzzx90Tdm8TBhIIzzltmCrEFU19oAAIA6kScWAm8tArB+6OlV81hJ9IBH9S9831asv3oMnNy+HaSIfPEYyhNwHwM5ChfKEDFr/NLJwqAlfXI5KwdZ211Jn8MSr7SO+o9sEAVWZHSecc7X5Cb8API6d8CJAHftmFAZnqqH4/pdaSUBxZ2Rrg6W1hU+E5wPtkWdKYNhJhevph+GvSSqcU45NZRLZg4oEtgF/skCo8MnHzpOUFqGvGuikPfWtlljx+xezlA/oCpWvj3B4/pWE9X6ilvK/UUXLpKu/sj4BOcZ+Sp+ScDOjYTu4ha7UoD93008g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLkPCUyI4FAxJ5iyrwoXz2DnCZiBSIYZ4pD7c0BIQZw=;
 b=F2gjJFZnM2y6IXrMPm2tZUgv/uWy4TYTDJYY2QYJAPlxeq1BcRd14TxB5jj0uPd1xU7+FvUYHXQcA+BVvQ7n3EthmDwXgz8KRL7TO8CmnAlaoWrvw7Ez0wSVomVwhmAUz5kYnHFEsnGOkTFteevz1fCS7Erbo8mbBBuBQWdTM0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 16:03:23 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 16:03:23 +0000
Message-ID: <c597f953-fef7-e9f7-4b6f-c9fa3ae895cc@amd.com>
Date: Tue, 24 May 2022 21:33:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH Review v2 2/2] drm/amdgpu: print umc correctable error
 address
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, tao.zhou1@amd.com, evan.quan@amd.com
References: <20220524143055.11723-1-Stanley.Yang@amd.com>
 <20220524143055.11723-2-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220524143055.11723-2-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e31591b-df92-490f-83b8-08da3d9eedd9
X-MS-TrafficTypeDiagnostic: DS7PR12MB6239:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6239116EBEF34278D233DD2497D79@DS7PR12MB6239.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wG2cXljD7F2X0NJMheBc+v6ZrwbNB0aJoejl8mfcFV7i4jo93iKf4blHQhsBvHBuoc5rPxrBqvW5rOVlp79OkwOI7IT3DaS5twWMCG/PchIKy4Wv7zdEVcDijAgvtYQhHCKHgIxM4z+RhtYUCaMIhIIW70s8RIkYzAHKKjKizm3sIOvSIuCcXS++OJmFhnyHsE3w/xT5EgPcV1xKWk900eUIsd2ZkVOoB0Ay14FTUz7k2PeM0ckkKKjdOEFNHiQklHf5vIHL3pamQVwDl97d117B7ENfygAifJxe+ON8FPZDuuwh36wseUE4Wl8Ge45XfSgwzZrF9XHtqKlcU/NAjSH7APSaDMJJvZO0qiB7DgonofxuHpT4waA4BIm5FdY55EM+n435pgIgJCl+yAr1XNrnTKhvmDv34hDS6tajsINOW7h4YeBdVa5eJWANKo/yiImudoH0fLQhfnDFdBzGpfF3Ka/nZlmfnqM0+Ugqp4kvT1c7565srPJFmppwLH2UaaAfd+i7YqPlUmGBDV1Z4wyzbIjKntoO+sJSEC+ZQM0hI8qLoyONQ9dPPW2bk/itHX0oQLahHruGQZ4DTgsOHOwSnyptUAb087Kzr3TryFBi40NWpWVsoARtG3Hfwu5aZDExf3qGuIRTFNCNPS2GzUv0rtZ0mAdR29+mJK5bjFPP8c04s2n57isVdL10iJLkD+BOjL8VD1Y3MaREH/VWKxT95Y4iPf61NTxrNeWxWz+Skm7QD6FYve9WzushftA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(31686004)(6506007)(26005)(6666004)(6636002)(6512007)(316002)(186003)(53546011)(2616005)(83380400001)(5660300002)(2906002)(6486002)(508600001)(8936002)(38100700002)(66556008)(31696002)(66476007)(8676002)(86362001)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDFNcGdZN1Q0QWEyaytxRjVWK1U3RDZ3eGRCVzB2dUNUVm9McXUwN0EvTUtr?=
 =?utf-8?B?REZ0d3JvSTloOXJQcmc1RHpDd2ltaGU1RkNMN2lCRU8zdC9ORXVMUVR2RDJD?=
 =?utf-8?B?aHlPTWJJRDVhNk94UkM5R2lSbHhNQnFlZ29tdWxKTUl4K0grYzlQRWoyQzBp?=
 =?utf-8?B?b0M0aGhVa0NaZE9Kb29FdElvalE3VjVKMnI4YU9BTFk3ck5EdlpmMDBxQjI4?=
 =?utf-8?B?eHVRbVZqa29Xc1RrVWY3TEY4VENBVUNDeDNCTU9EekdoWkFJNkhDcmpCRTVC?=
 =?utf-8?B?cUQ2ZWtxN0YvcGwrUTl6NnhFaWJVdXk2b2VucmtHc1IzUnFCTUhoYU5YaXky?=
 =?utf-8?B?U0pNUVN5eDEwNExKRms4RlovbEM5S0NEU3JPZE5zNDB3dkJTYU5PUi9HRG9G?=
 =?utf-8?B?QnptTkkxWWszTkQ3T2gyVklYd2FibThsOGMvblJvcEdTWVd3MGFaV0JYMml3?=
 =?utf-8?B?TE4xVmhUZ2p5T2pGWkFBUVNWVmlpc0VzTGc3aVBNWklRdmhJbkhlckFHN0or?=
 =?utf-8?B?ZTRTb3FUUHgzb0dMRjlmRU54elA0K3lPazRGMHdXbVBzSTRZK2Q3b09Oa3ll?=
 =?utf-8?B?RXFKdVRaZHJGb2xnMHhvUjlzdU5BbXZPQ1J6TXBob3RLSCtreEVLN3ZPZ1A1?=
 =?utf-8?B?cjFiNjdsNWR2QnBxbXJqeEFIUHhxNXV0a0pMMFRsQnFiVThYdWRENTZsTzV4?=
 =?utf-8?B?WnZyTEFEd3NtcXpWdjJxdFpmM1hOOHVnb3FqWWpudFN5cTg1OGRQbURrbDRR?=
 =?utf-8?B?QWdYMmo4QjFtaDYvaStNcDhJdEtRQWtHSVdrL0ZkU3l3Z3FvOEFXYllrUktT?=
 =?utf-8?B?cVRzV3I3ZFJTdFBHZzlMVEU4RjJzd2pUUm5naTQ4aTI2YkV5bmhMUU13QXY0?=
 =?utf-8?B?MjluNC91bjllK3RtS3d4MmVsYVJIakYramtaNUF0b2pvdVlYdXdLN1kzUGlR?=
 =?utf-8?B?K2RYMVBkWXlmQldQeXN2VEJWU2JBdmRrMjhGdFVPRmhhZkJVQUpmNGlFNzVx?=
 =?utf-8?B?MWtHdEVRU1pSSDJIV0tlMnNIaEJRakljY3J5R3liRjYzWSttZ01CV3hoTmxV?=
 =?utf-8?B?TUNOdnd5cmE1eDUzTEZidFgyeGxtQVRoS3dWLzJWd0V5R29JeUl5WU9YQTY0?=
 =?utf-8?B?UVc2ZElBRXg3bkhQUjdpMUUxV0FsZGlnNVdMQ0s0ZDVtbmxMYUxMVGl3YXBo?=
 =?utf-8?B?eTdIanJEUUFRZGkwR3pCMFFKRkg3VDBZZnJZTW9NRUU1cG9Pa2N0V0VIMnBI?=
 =?utf-8?B?MFhSc3ZDc21zN25ieXRRN0ZuSDFDMUE0RDVkV1pGNzdqQjFmZ1hQZExoNC83?=
 =?utf-8?B?TzRteTFEUlRQVTNsenk0ejdyZzcrVFhQSisxWUF4S3RXeXFXbHcrNG80M0VT?=
 =?utf-8?B?MnNnSSsvR24yUlh5WTUvaGlNZWRsdVZNNTNGZE90WkorK2wySXNqQ083V2JW?=
 =?utf-8?B?eTd3WFZXK0VRcTkzcHFwdTFmQ3lPTnR1UUU2U085UkEwQ3Naclo0NUg0cmEz?=
 =?utf-8?B?QkJQcW11WlpmUnNHOFg4TEpiMjdwVjRsRzRNcUZCWUxFRkNsUTR4TXZSS3JL?=
 =?utf-8?B?dnhkTEt2SnowQzBwSjByZmFDTmxjcjNWZjExZVZnclRlcmxiblpVS2F6NlRP?=
 =?utf-8?B?NWdQZXR5SndBeVI3eDIxRWlRRlNNUExzczNQaUVmSnRWczhJNU9pMll6NzBm?=
 =?utf-8?B?SnVOWHBJM1BIRE5jKzlxaUd4REJQeTk3eVgydVBBR0tUOFYyVEw1V053cHdx?=
 =?utf-8?B?WDk5ZUNJUkZZOVRSTUZOQkhRUG5VSWxPaFljcHpvRHpTWmtSNlBkbmFYbGY5?=
 =?utf-8?B?UkhST2Z1cG5NK0RPRXRRbHMrUWtxRWdnb2xRQVNxUHhqYU1qS3daN3hqUUhk?=
 =?utf-8?B?R0d1UkxXSGJiQjhkWEJuV29XWE1Qa2dZbVN6OVdiTjhtTzhJd3NsQ2pnN1Rs?=
 =?utf-8?B?TlFZQ0xkbFRCMmNHMklmcjZKQlZqdWJYVkFNaVE3NHJ3R21aNFpBbGNxSTlj?=
 =?utf-8?B?TjA2b21wdFBqNlFMYlp4bGl0SDhXR2FnN1JWYkcyb3hpKzgyaWp0R3NWS1By?=
 =?utf-8?B?WExnTkhkeFRaVzMxNzJyYVg2azkxU2FPSGR3bmZvdWFrU2ZmZFFMN09RWTda?=
 =?utf-8?B?VlA3OURWZ3hZbTJPMUQxc2hSTWZpOWRnZWwzM29rRWJYb0F1YlByalh2K2R1?=
 =?utf-8?B?YUV2S2s3OUppYmdNYlA2dHFXWWJCa0I5ZVVrbkYzZ0UvVXU5aDd3ZlZsaHYz?=
 =?utf-8?B?MXRvUGloak1uM1ZrU1ZLN2lmSDB4MnlHd2ZDRk1aTDdtZ2tNWGVORVZxTi9B?=
 =?utf-8?B?VVNMdnlxS0l3ZGZvempQQWVOdi84VnhGUUFOVGZwMzgwZFlBams0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e31591b-df92-490f-83b8-08da3d9eedd9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 16:03:23.4991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNvoZ8ogcz9V4IOZ94v0CkaXbbFi5m1/wQstQ+DiCCM3QM9jgYZy7zT9hR/4nT1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
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



On 5/24/2022 8:00 PM, Stanley.Yang wrote:
> Changed from V1:
> 	remove unnecessary same row physical address calculation
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
>   drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         | 52 ++++++++++++++++++-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 +
>   3 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3f23f9ad3249..985b8cddb5a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1108,6 +1108,11 @@ struct amdgpu_device {
>   
>   	bool                            scpm_enabled;
>   	uint32_t                        scpm_status;
> +
> +	/* Determine smu ecctable whether support
> +	 * record correctable error address
> +	 */
> +	int record_ce_addr_supported;

Why not keep this in umc_ecc_info passed back from FW?

Thanks,
Lijo

>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index 606892dbea1c..91bdc5e048c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -119,6 +119,24 @@ static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device
>   		*error_count += 1;
>   
>   		umc_v6_7_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
> +
> +		if (adev->record_ce_addr_supported)	{
> +			uint64_t err_addr, soc_pa;
> +			uint32_t channel_index =
> +				adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
> +
> +			err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_ceumc_addr;
> +			err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> +			/* translate umc channel address to soc pa, 3 parts are included */
> +			soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
> +					ADDR_OF_256B_BLOCK(channel_index) |
> +					OFFSET_IN_256B_BLOCK(err_addr);
> +
> +			/* The umc channel bits are not original values, they are hashed */
> +			SET_CHANNEL_HASH(channel_index, soc_pa);
> +
> +			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", soc_pa);
> +		}
>   	}
>   }
>   
> @@ -251,7 +269,9 @@ static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev
>   
>   static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>   						   uint32_t umc_reg_offset,
> -						   unsigned long *error_count)
> +						   unsigned long *error_count,
> +						   uint32_t ch_inst,
> +						   uint32_t umc_inst)
>   {
>   	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
>   	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
> @@ -295,6 +315,33 @@ static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>   		*error_count += 1;
>   
>   		umc_v6_7_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
> +
> +		{
> +			uint64_t err_addr, soc_pa;
> +			uint32_t mc_umc_addrt0;
> +			uint32_t channel_index;
> +
> +			mc_umc_addrt0 =
> +				SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
> +
> +			channel_index =
> +				adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
> +
> +			err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
> +			err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> +
> +			/* translate umc channel address to soc pa, 3 parts are included */
> +			soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
> +					ADDR_OF_256B_BLOCK(channel_index) |
> +					OFFSET_IN_256B_BLOCK(err_addr);
> +
> +			/* The umc channel bits are not original values, they are hashed */
> +			SET_CHANNEL_HASH(channel_index, soc_pa);
> +
> +			/* clear [C4 C3 C2] in soc physical address */
> +			soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
> +			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", soc_pa);
> +		}
>   	}
>   }
>   
> @@ -395,7 +442,8 @@ static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,
>   							 ch_inst);
>   		umc_v6_7_query_correctable_error_count(adev,
>   						       umc_reg_offset,
> -						       &(err_data->ce_count));
> +						       &(err_data->ce_count),
> +						       ch_inst, umc_inst);
>   		umc_v6_7_querry_uncorrectable_error_count(adev,
>   							  umc_reg_offset,
>   							  &(err_data->ue_count));
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 9cdfeea58085..e41a5b6fc64b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1882,6 +1882,7 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
>   				ecc_table->EccInfo_V2[i].mca_umc_addr;
>   			ecc_info_per_channel->mca_ceumc_addr =
>   				ecc_table->EccInfo_V2[i].mca_ceumc_addr;
> +			smu->adev->record_ce_addr_supported =1;
>   		}
>   	}
>   
> 
