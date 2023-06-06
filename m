Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5299C7EE43
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 20:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E3F10E3D0;
	Tue,  6 Jun 2023 20:34:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5121310E3BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 20:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp5CLyrPMJ20G5ApDabRLGknE44qEMTfTqbDB165XEOz76zjvcflT7Kenew0vNqBG0LccVws1LdZcXpQGlOg+Dd1jXwerWe9RdC0cGbL050kBHYEDkSoPma0G6MBSUFzpq503TQWTF6sQ8ywF9Ts39Mb5Ar+R42RxAla9USjTjJw0iYKh48Dx59N2LvzSJcGxWmGAuxlBMQH5S4etouuE6zcDKc+hyHxi1G5GDKkQ0lrrng+J1BnLPMBqR+0smqplPnMKqwM0sULg3TkCn4ctRA0mDtse8a95XEjQihSZu/QedPsu4tgqPbCv0eCLRQg/4yNeWS4BqI6IOXHsja/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kglmSuoJjW+VNinm2llbTUU1hILv2u6IWQHQQK0+/gQ=;
 b=fuxjW+qTyZD8Gd/9aJuZMTQyeTmJvSfKeLBNdbOkKhH1tnv4Nlm+dRdXKeJz8gtrm/H6MteccHNb0waFIXHP0o1NvRg47z5JgaAEMh69ReZth+I7PGi/33/c/mgMxtB+7L7ZgTSgaml7h88cyknVeUAPMn4/h3D06SKmrO4qQsIywke6ZlfpbliwMd2iF0bPDq+1VqbIeZdAejxgggKXM7mq+JNQ/1uCkHaYgqtsYdXbmIVMaxpID9En3i68CJuiUJoXjvxeodMabw2IXDc52D1lOF+bTrYYQJ15TPMV1yLyslWHJKi/iG1cbg0x05kjyzH4TvtYE/KycRrEevdxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kglmSuoJjW+VNinm2llbTUU1hILv2u6IWQHQQK0+/gQ=;
 b=Y3zX2/McziQdCOQsea2RcQ1yXhjFN0/aFdRRHexJ8yJffgxHvfD//oP2h6sjqWGrV/Abju3TwF8u5vzKxg5RiD1KIkMZt8CwKApXYzWWuHO0m9SCaO6a5XnVRFgU8Lwc2r6LQNjp7cqvkegpqOpxW0OU9T8hCV4MnoMRn70grw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 20:34:21 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 20:34:21 +0000
Message-ID: <6ba51f02-766a-895d-0304-d047d0c7b63d@amd.com>
Date: Tue, 6 Jun 2023 14:34:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Only use ODM2:1 policy for high pixel
 rate displays
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230606154703.407753-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230606154703.407753-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|BN9PR12MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 04afb265-7fa5-431c-af42-08db66cd68ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbWZoEfvM/pkvR/wSwOE/DqyQKCCGnBWHU8T+4IpobFmdXgNezdyvWh3ybw/CLyFO6TfAjIj463gHAE6IuHi/jJdNHMrUZsa8nEt6zoVoYPHoPLz8mv/Zedl9Tt/88NYpQl8UGWXQITYrdEc02XfCs1pPHFDRXCHuRliQq5uW8lozjUu9BdDbVdZykwl3eqO60lyhHMPOR51GyarryQ8RjM4SYmN4WUAw4NBIp0sLa4xChXOy7NP+0Q858JBOny/9FHI2D59XBEAvRTlhX4CKTL5YPB3fYuYks4fvQ1Hl4JExei739GxJ+fPMP0r5CJDASWKB8kPAd8HHiVANATC+RcCOUDpTL0e4faJ4FWg6wfZeKdsY1hEFNaHDQ839G5Yv5HZM6BP+f23wFvSccOu02u6n96B9OhJSKbgizd6QmwInbflCzIw8E9+Pzt6op2hSuNBh8OP7iM7E2PR2AbB/Fm27u00p0P52o6Mt5/LdGnYjBaXEDuRvOvco+2QzM+CuZdyYxiVYu55CWMZAt0xdKXZ3AzZxFyE2dTjsD4tDuK1075XTa2HyyZTdJ8uWNheoh9TnP1sNo2yzX+E22IeE9TN2LlW8AosntTQof+ut8M4yu5g3dI+j5XOLXGRHu8vBA9yz6BNmNIiIGniXBeToA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(6506007)(53546011)(6512007)(31686004)(83380400001)(86362001)(2906002)(36756003)(186003)(31696002)(316002)(8676002)(2616005)(5660300002)(8936002)(41300700001)(38100700002)(6666004)(66556008)(66476007)(66946007)(54906003)(4326008)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3RIaDErQVAvUXMyZi9Pd2c4TWI3WWliaVdDbDA1SVZNeE03VStESW82eXdV?=
 =?utf-8?B?QUx2R3BxTU9Ya2RaRStPRklsUVRFUVZVRXl3NiszZ1ZwUDVRL2NDSVp0S3h6?=
 =?utf-8?B?M0g5K1ZtN0tHRlhwOS9ZdW1hMWpaTmZuNzF5bnhlWWpWcWxzQUZ1WFdpRnlB?=
 =?utf-8?B?SkkrZjdsdnFybG4vTVdzRTJXR2JBaE9vTnA5aXdLVWs5NE1LaktZN3YxWXVr?=
 =?utf-8?B?SjlBMWxNUUhZMDBMcDUrbkdnMk1qc0lIRjRMWTVBaGR5SWtVTk5oeThlS1FH?=
 =?utf-8?B?dmVJM21EZE91b3JDSXprbWFDMytKN1B4TnJEejV1WFpXTWNJYVMvUHNuOStO?=
 =?utf-8?B?Z3FoeXp4ZTY0TDk2WmVHQ1FlUG5qbExQQ3ljWGQ5RXBIM24vK1M5alZHcFRp?=
 =?utf-8?B?STJFaXR1SlZ1cWtLV1NwSHFSSkNOM2pFZk5wUTR5WFNjcnAzaXVtRTJHNk5s?=
 =?utf-8?B?V3Bzdm41K0o5NjRJemh3RWtLQTZJcDIwZnNaRVEvNTZPK1dFY0g2ZGplSkVl?=
 =?utf-8?B?WWpOelY1bDNCRmRQLys4K2VTRG9FaldmY2t5cEF3RlNjUDNxcWNqVjNCUk1U?=
 =?utf-8?B?L1hLZkUxTDVFd0UzK2F5LzZWSjF6UXA5ckk4ZkNYMFNIbWlPTDU2Qmo5L1lC?=
 =?utf-8?B?SDhMcmhtS3E5RlJLZThPQU5tY052dk9Gck9pSWpiYjJ1ZHdjWGk5MEtLSDhh?=
 =?utf-8?B?VTJPc0Zvbi9SdGgzbEdoVXN3THk4YWNISGhHbkFGTDhxN1pqclkwdVZ5eVN0?=
 =?utf-8?B?L1ZuTHBvREsxMmlxZkx2c1ZBTWwya3JoT05Ta01rQ2ZiY3dzZVNyMnBoVFov?=
 =?utf-8?B?NThrZjNPMVRva2pINXdJaVVvQnZhT2ZWVCtkL21kSVVoVmpFcHZqMm52Q1dr?=
 =?utf-8?B?MnBZZ0hMK0NBWWF4Y2U2aEp6UGFyY3FSZVRwb2xZcmRLek84UXNwdTNzNzk0?=
 =?utf-8?B?SDNwYjRBb0hlV3dwVFhrbUNmcjFpU0taMHdvWng5b24rZVhMd25aWC9TeFZk?=
 =?utf-8?B?OVVkOU1HVnUzT2dGRkZGMWxXOTNkY2Y5MEo4R2U0NkhMVFY2RE9ST2szNFBC?=
 =?utf-8?B?Yjg0Ny9ETGFEdU5DZktZWFBsdlVVU1RJVzY1ZnpPeWZYeTJGWVZGVUsvTEw4?=
 =?utf-8?B?dXB2M0dLYkdLVHNGYXpYUFI2R3o0WXJlN2VWSmduVW5tbnl4d2F1d1ptT1NP?=
 =?utf-8?B?dUhVcVFyQURBcFlESVVrQnA0RVBNQnRPS3lNbEoxdjV5cWt4QWZrVDVoVHBT?=
 =?utf-8?B?SllJaURyamMrOFN5Q2lZcE9uMEFZSmxQTFhPdUpsZHVpcENVVTlRV0k4M1Vx?=
 =?utf-8?B?eUYwRDNiMlhOa2tKL2tMbFI0YXh2TVR1MWJsdU5ZeVc4RmtiWGRkT1VuakdO?=
 =?utf-8?B?NHBPb0Z2N2pROE1MclQva3JxU3dYSVdreUZUbXkwWVdCU1A5aGVqRFNpZHAx?=
 =?utf-8?B?VXpoWVZ3T2dVYkQzNHhqKzRheDlqSXFWOGZGbGFlNnBOVll2MTZlMENyYTNu?=
 =?utf-8?B?NnlTMTg3ZTVMdk9ER3E2M2VKOVZBWWRndzJLSkJ3b3R0TjhWbVAxYlkvdkMx?=
 =?utf-8?B?emVoNG41cFBWREwxMXNBOWtMdFRULzQ0dWhxb2IvK2xabVUrdkIvTXcyb3Iw?=
 =?utf-8?B?RzF1ejBmbTZKKzBhNkJpWE9DQkJYTjRBZEhkdkJ0MEFiTERVRFYzenJKMWRN?=
 =?utf-8?B?MzVIQU5sejFNL25KdnpMUDZ5UnZpODd5aVdQRUhHM05Pb1ZPb0N6YlgycGQv?=
 =?utf-8?B?RWtOUFRTZTNqdnVUSVRSa3d0ZWRNWGt1UWl2eExhTmI3c0NEc3FDUnJoMStO?=
 =?utf-8?B?SmNrRmI2bVdKaDIxb3dxWE5qS0Q1d3o4UkRTK2twaHNMVVFZbGFTTzJZYk9P?=
 =?utf-8?B?aWpZNnNkczZqTWt3YktWYTgrVlhCRGlJU1ZIVVVhM0V5T3psRGtkcWhJSDFV?=
 =?utf-8?B?VWF5a2VUbXBPR0dEWGc4VUpDWFpId3lGbHNveGE3dGJ0VjZvT01zU25Wc0Vl?=
 =?utf-8?B?MGtEdnBiODZWYWNWYUZld2ZScWtSY21jQlNRNlJDMHNkTitKNytwM2FqK2V2?=
 =?utf-8?B?M1BYVXErZEc4ZktXbXlKdTJHdDFUMmlBdm8yMmNaYVpMUllQak80Mk9CWVVY?=
 =?utf-8?B?cHVONlR3YXRmZ2UvMStKcTQwOUx6MDZJbk56ZDNnWmlmSGhWdk94TmZZUjQv?=
 =?utf-8?Q?9E5m1aiO43pcROVEv2r0A31vcV0xnCDEoOJ3cia3T7Fp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04afb265-7fa5-431c-af42-08db66cd68ca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 20:34:21.7081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyhIbg34FfMh2bSkCrNm8ZhKtQfaDFjK3OKN4Cs2KwkjjeVXvk/3mT2Ij4Uk1qJUiekxaqwG/cfiAXhIo9F3aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/6/23 09:47, Aurabindo Pillai wrote:
> We only gain a benefit of using the ODM2:1 dynamic policy if it allow us
> to decrease DISPCLK to use the VMIN freq.  If the display config can
> already achieve VMIN DISPCLK freq without ODM2:1, don't apply the
> policy.
> 
> This patch was reverted but that causes some IGT regressions. To
> unblock, the patch is being applied again until IGT failures are
> fixed.
> 
> Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 1 +
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index 8d68f02f5147..2e6b39fe2613 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -1918,6 +1918,7 @@ int dcn32_populate_dml_pipes_from_context(
>   				context->stream_status[0].plane_count == 1 &&
>   				!dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
>   				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream) &&
> +				pipe->stream->timing.pix_clk_100hz * 100 > DCN3_2_VMIN_DISPCLK_HZ &&
>   				dc->debug.enable_single_display_2to1_odm_policy &&
>   				!vsr_odm_support) { //excluding 2to1 ODM combine on >= 5k vsr
>   			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> index 80bebdf43eca..2f34f01b3ea1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> @@ -40,6 +40,7 @@
>   #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
>   #define SUBVP_HIGH_REFRESH_LIST_LEN 3
>   #define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800
> +#define DCN3_2_VMIN_DISPCLK_HZ 717000000
>   
>   #define TO_DCN32_RES_POOL(pool)\
>   	container_of(pool, struct dcn32_resource_pool, base)

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

