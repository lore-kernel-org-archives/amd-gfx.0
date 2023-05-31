Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71663C7EE2D
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE5910E4EC;
	Wed, 31 May 2023 14:43:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D0710E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqrIghfEi2icUkYGtGYL0IojgtzY2DoOG025DMf/BInWn2a+FzkrQpLKvFUywP5fvIs8j3NGsFh2PFZuIkc0/wTQeKNeKE0U4bQW92frTkZBMZm5j99fun/hZ5DVKXrV9z68Oh80SpxoOHvcD8kKKqesAzcSSV4hXHMU1Ey4GKQ8UXW+0bmrrzXPYfH1ZNwBRYAXZ9W88mTb9FCrOVUsjeGiwvxwnj7aJGxo5vJCWdHii7lTEh5zUdWVLchWe9B7Oy+ZOxDZLraSUmajEfd/rd2y4HkMl9o0HSS8goXnwXxmsNmI4QfYClG72nWMwm/auTbBjxfARoA0NQ8Y5Z79NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9gT1xAz0VuyVgx21oensRdN/dI8SagGR/xEAqlG8l8=;
 b=OZJnx/OQnG6N5YNAaIrmB+5RbEtu9fcoU2/dM/+5o7BQpos4VeAoG/CuogbG1DzKHdlc9LZvZdapN8PJNYuvo+6fv1aamdLUQXq69nxDNRfZX53b29GOyAWIof+Kl/M5j95rm6gZg1Smu79ul7X8MgqQuK2xd+ylB0Evh6rKdKv6eP2u8UL5QvndDZfPP95BvV7Ii9lG8PQDTNi0Co5dCgkXHx1bDLmg1Rt0MxsbcU/Zufofoez8T1W/7wEw/OMZWWctlAyV9mIngjj/VznkwMSVLObrENL+rQGxVSb4C8cJRGfDiRq4v7DVNy6S8ptI900B4eQV6k1DlypYIVPnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9gT1xAz0VuyVgx21oensRdN/dI8SagGR/xEAqlG8l8=;
 b=LcwULzoQ0sDJl8iJA/CDudUA+cES1bYopiU1gEU33S1QLfCoSluEZCrBMLl8XVfw8knxq0GmReRCiulP3zycz6F/CXITfQWAvo8is7AqE/GNKDK/qh3KNDv4pbBH/4N/2Sgyn9x0IzszxCQrwwqYB8SKSEO1Wz+Rte0r6gTrVlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 14:42:56 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 14:42:56 +0000
Message-ID: <01c40a98-bd12-2f9d-8325-394676ae5c64@amd.com>
Date: Wed, 31 May 2023 10:42:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amd/display: Fix up kdoc formatting in
 dcn32_resource_helpers.c
Content-Language: en-US, en-CA
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20230531092202.3352796-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230531092202.3352796-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::14) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: b89d1af2-1356-4a0c-c76f-08db61e55272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2joXZMO0sfRw9Lll4G4/pwoFiJNvSRLH3c7hNJdavpKulbXv10q32Hbf9YKXieYyl+qDRY5/sCT2JMsiohQTGilk1Eht0IUVeN55c3XjgQ0E3whkDEUrTPTj1DHTgqcoOpF2raWOg0WNDYOz8a/VGl0L5Z+l+7n5fb0s6uJIR0HmzJrm+yrA+PkpVii+aKj0x9a+gX8bFTxlDA3L3KZcadWIgY41HpoO49584JjE8r920FvIeP9Os+nB2g2rwklnLmPLM1KZBrF1bdUOp7HTT4Tv8VLSQId9ar0eIa+r8SVdqFAwGNsH+HQ+Vp+iD3Gh7MaJQHctH3WeAtd8Hibe65afnlQR31x0sR2v/UCl4K5RAwGUH9YnGe3MezGOdwTDiujKSvxqbPa13wQSKRlHAs3IlTtLTBF3jWIbwsnQTxnvoCBeqMl8P1S3l0WE7fJ0qlu2IVwQYVpyDMLVDcDaaqWPvOBFTsjkByLdq4ICWxNyd/+9K5Pk+dWyreM0T0mSNNrnJiKvuZnVas9dTqbLJzEgE6BUAtRn1Oz1hqDG6vEU2/C0AHiQWkTpmJ6nquRc3q2hNYeDQH+RLYoBv1Z8//6UKlkyxsPCN3sXQ+B9IopVP3ML4QM+TXtaBTL+JFnodLL7YR7xLTxaLovYkUn6Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(186003)(41300700001)(38100700002)(2616005)(31686004)(83380400001)(53546011)(6512007)(6486002)(26005)(6506007)(478600001)(110136005)(66476007)(6636002)(4326008)(66946007)(66556008)(316002)(5660300002)(8936002)(8676002)(44832011)(2906002)(31696002)(36756003)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dncxdWtVSmNQc2wxdkFmMWt3VXdIc0ZNcjYzNkVTcFQ5SUZjaVJFeHI5UGNr?=
 =?utf-8?B?U05OWjJJV2pzRlhwVmJ0VmdPYXdqMmNYQlhuWlRsanBQZTdIR3VZMmR3c2Js?=
 =?utf-8?B?dDNHcW9TZG1oU0M2cmF4RkNsdHJvVUZZclFnejNLNFpTVVQxZ2pyTERlK0tr?=
 =?utf-8?B?WlZYSGNtZ1dJVVBRUjlRS0tXeFI3aWRjVU4yTjJWKytrUEI3Nk8yVzN0V0k5?=
 =?utf-8?B?N0V0UitHdzZDWTA4dWVwcjA4UERhVm1FSkFrelhNVm1nUHVyK3ZxYWJvUkdR?=
 =?utf-8?B?RXlseGF1RmpFTzUvM08yb1VnckR4Y3dBSnR0NnoxQ2xJeFJ1RmpsdkROVFZ5?=
 =?utf-8?B?SXc1T1p2ZzBudjQxcEtxUDZTdVFpRlVzQzk5VTZENk9CczRJTlpEeFc0bzV4?=
 =?utf-8?B?WEJaQlg2SGJiemY3TVFscFFWSXdDdzEzVEk0VGd2UFpmV05ScWVuanF0T21X?=
 =?utf-8?B?aGxaMXhpd01VN0hkRStWbllxK243alBqUitTVHlkakdsd0llRG9aS0x1QU9D?=
 =?utf-8?B?YWo5MEd2WlNKT2Z4SnJieVBBb1lyM3FnRkFzR1lNL3M0NVVJVE9oYnZnTytn?=
 =?utf-8?B?ZVc1dFdmTDI3NXJqS3FEUm5LWGZTQjFLTnYxSGNLcHJEQVIzVGtqMGpGWE51?=
 =?utf-8?B?ZStGaUdZRkdHQjFRNWhsU3BGLzF2RGJxKzc2QWZnVFJWcG5heFJ5VS9NN1po?=
 =?utf-8?B?Y0VoMTlydm9FblBDeGczeFcyMUNxVDQ3ZVBVcG1hNnpDN2hkc1cwRVN3UFhn?=
 =?utf-8?B?UmpvdkVjZjJCdEloZmg2eGpkZk1sODJUZFArYXRlbTFacTdlT0tKb3hCVXhZ?=
 =?utf-8?B?LzM4YndUZEJVYzBuL3hlQzkvMjRDUWhtdnFCQXh5Qmkya01jVnNPSFJZT2Jr?=
 =?utf-8?B?dlVBN2d5dVVPQ1NPOEQ5ODJUK08zM2JoMG93cGRSVnFWWDdRSUVjNXFQY2xG?=
 =?utf-8?B?dnRtWmZtQkZzbjNnclYyUlpRK05xS2lhaURaUVZRRVRMZitvVGV2MlVzQzl4?=
 =?utf-8?B?MForZ1hzUGFtWkJma3Q4cjFiZTdPaXc0NGtMRzlDS1IrZ05jZlNWRnpjcE5a?=
 =?utf-8?B?Q1NEbzgydzdCazdWeHJremRodzJLNVJ2Z3o0b0wxcnNYTytuSVY0eThqeVVk?=
 =?utf-8?B?WStnb1k1MHRUSC9VeG5RRG1NcFdDcExRMnl1YTB0V0hHRmFDa0c4bXZOMnRq?=
 =?utf-8?B?eE5ZaXUzV25SUUdRdUNoU1MxQ1VOd0NjV2ZNRUVNR2lDdTk2NkJ0N1J2RWtx?=
 =?utf-8?B?OFpnaVF4bkRubWkzZ3hrbzdCREIrZ3Q2MkRWMzF1ZDFWdVd4MWVEaThvUnRu?=
 =?utf-8?B?Z1F4d0JQMS9MY3gwUWI5RDFMdG5SUnppUm9RN0VETlNTYjJqeXYvSnBUUm9u?=
 =?utf-8?B?TWFGZTZRcUovUzJYSWZ0ZkxKQjZmTU9VMHRGb2ZIbSs3RkUveEdJYmFWeXph?=
 =?utf-8?B?R0dhUndJRG5Ea1pYZ2lrV1pPdTQvU1hjYW01dmhwSG5aZ1JVNzFHZTkvVERJ?=
 =?utf-8?B?Q0p0MFJLQzNTRjliY2xqNms0SXNOcTF6a1c5MUowcVZjbkNFRFJLVGgwSDlG?=
 =?utf-8?B?M0VqSWZpQ2J4WWlWZHdLKzZnOGJOczZDanJCYWdhUmtMc3Bsb1o0bjVnN3ZB?=
 =?utf-8?B?cXlzVFVpOE1ZMW8zR2d4aG5NTUVsa0VNQWtqZi9yaTRTeXBOdkljQU9lZE1j?=
 =?utf-8?B?T2prZkdRUWJJOGxubDF1UTdRaGUydmFFNFJSZHVybEQ2aFZHVkFQYzVRMjJm?=
 =?utf-8?B?NlFVUGc5SWl3bFNZSFZRRytDSElRL1ZIL0xYczVNL2I0MFBLczhSMzNyQnNE?=
 =?utf-8?B?MkpFUUNYbXdUaS9aamNkZWo5YzZCbWJMUXgrLzlCcG5pdmRlMUMxS1pRYm1E?=
 =?utf-8?B?NU1oU3I1ZHhiRVY5R0poZnVFYmM3N2Y5dkpKb0hlTUV4dlNyVGprdFJkckNa?=
 =?utf-8?B?OXRUWmYrR05pK29raHVIVFphbzRacDZ0Rm0vcHdrREVPSFdJa3N1UW5ERXBy?=
 =?utf-8?B?eUhRREhpeUFWRXFteEt0aWpKMndweTNjTmp4T250d0RLOWdKNFBzMmNQNjU2?=
 =?utf-8?B?Qlc3RnFReEM3cXJuUW9telR2dXZIWXVPU1M1eVErd1hIR3Q2SjQrdzdjVW9l?=
 =?utf-8?Q?v2egfbpblg4wR1em6ayq/gJhD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89d1af2-1356-4a0c-c76f-08db61e55272
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:42:56.3528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biGus9x4uoou23WUtai9X9v+SNdi5iM5bNaKQzduypUwG+0K3hH/UXu7KNmg7ZGYp4pLjEvwKIFm1kpYeeHYfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 5/31/23 05:22, Srinivasan Shanmugam wrote:
> Fixes the following W=1 kernel build warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:97: warning: Cannot understand  * **************************************************************************
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:264: warning: Cannot understand  * *************************************************************************
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:435: warning: Cannot understand  * *************************************************************************
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:475: warning: Cannot understand  * *************************************************************************
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:599:
> warning: Function parameter or member 'dc' not described in
> 'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:599:
> warning: Function parameter or member 'context' not described in
> 'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:587:
> warning: Function parameter or member 'dc' not described in
> 'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:587:
> warning: Function parameter or member 'context' not described in
> 'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'
> 
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> 
> v2: 
>  - Fixes added for line no. 587 also.
> 
>  .../display/dc/dcn32/dcn32_resource_helpers.c | 57 ++++++++-----------
>  1 file changed, 23 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
> index a8082580df92..1d13fd797212 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
> @@ -94,18 +94,15 @@ uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(
>  }
>  
>  /**
> - * ********************************************************************************************
> - * dcn32_helper_calculate_num_ways_for_subvp: Calculate number of ways needed for SubVP
> + * dcn32_helper_calculate_num_ways_for_subvp(): Calculate number of ways needed for SubVP
>   *
>   * Gets total allocation required for the phantom viewport calculated by DML in bytes and
>   * converts to number of cache ways.
>   *
> - * @param [in] dc: current dc state
> - * @param [in] context: new dc state
> + * @dc: current dc state
> + * @context: new dc state
>   *
> - * @return: number of ways required for SubVP
> - *
> - * ********************************************************************************************
> + * Return: number of ways required for SubVP
>   */
>  uint32_t dcn32_helper_calculate_num_ways_for_subvp(
>  		struct dc *dc,
> @@ -261,8 +258,7 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
>  #define DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER 7
>  
>  /**
> - * *******************************************************************************************
> - * dcn32_determine_det_override: Determine DET allocation for each pipe
> + * dcn32_determine_det_override(): Determine DET allocation for each pipe
>   *
>   * This function determines how much DET to allocate for each pipe. The total number of
>   * DET segments will be split equally among each of the streams, and after that the DET
> @@ -290,13 +286,11 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
>   * 3. Assign smaller DET size for lower pixel display and higher DET size for
>   *    higher pixel display
>   *
> - * @param [in]: dc: Current DC state
> - * @param [in]: context: New DC state to be programmed
> - * @param [in]: pipes: Array of DML pipes
> - *
> - * @return: void
> + * @dc: Current DC state
> + * @context: New DC state to be programmed
> + * @pipes: Array of DML pipes
>   *
> - * *******************************************************************************************
> + * Return: void
>   */
>  void dcn32_determine_det_override(struct dc *dc,
>  		struct dc_state *context,
> @@ -432,8 +426,7 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
>  }
>  
>  /**
> - * *******************************************************************************************
> - * dcn32_save_mall_state: Save MALL (SubVP) state for fast validation cases
> + * dcn32_save_mall_state(): Save MALL (SubVP) state for fast validation cases
>   *
>   * This function saves the MALL (SubVP) case for fast validation cases. For fast validation,
>   * there are situations where a shallow copy of the dc->current_state is created for the
> @@ -446,13 +439,11 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
>   * NOTE: This function ONLY works if the streams are not moved to a different pipe in the
>   *       validation. We don't expect this to happen in fast_validation=1 cases.
>   *
> - * @param [in]: dc: Current DC state
> - * @param [in]: context: New DC state to be programmed
> - * @param [out]: temp_config: struct used to cache the existing MALL state
> + * @dc: Current DC state
> + * @context: New DC state to be programmed
> + * @temp_config: struct used to cache the existing MALL state
>   *
> - * @return: void
> - *
> - * *******************************************************************************************
> + * Return: void
>   */
>  void dcn32_save_mall_state(struct dc *dc,
>  		struct dc_state *context,
> @@ -472,18 +463,15 @@ void dcn32_save_mall_state(struct dc *dc,
>  }
>  
>  /**
> - * *******************************************************************************************
> - * dcn32_restore_mall_state: Restore MALL (SubVP) state for fast validation cases
> + * dcn32_restore_mall_state(): Restore MALL (SubVP) state for fast validation cases
>   *
>   * Restore the MALL state based on the previously saved state from dcn32_save_mall_state
>   *
> - * @param [in]: dc: Current DC state
> - * @param [in/out]: context: New DC state to be programmed, restore MALL state into here
> - * @param [in]: temp_config: struct that has the cached MALL state
> - *
> - * @return: void
> + * @dc: Current DC state
> + * @context: New DC state to be programmed, restore MALL state into here
> + * @temp_config: struct that has the cached MALL state
>   *
> - * *******************************************************************************************
> + * Return: void
>   */
>  void dcn32_restore_mall_state(struct dc *dc,
>  		struct dc_state *context,
> @@ -588,10 +576,11 @@ static int get_refresh_rate(struct dc_stream_state *fpo_candidate_stream)
>  }
>  
>  /**
> - * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch - Determines if config can support FPO
> + * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch() - Determines if config can
> + *								    support FPO
>   *
> - * @param [in]: dc - current dc state
> - * @param [in]: context - new dc state
> + * @dc: current dc state
> + * @context: new dc state
>   *
>   * Return: Pointer to FPO stream candidate if config can support FPO, otherwise NULL
>   */
