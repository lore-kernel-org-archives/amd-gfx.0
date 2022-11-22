Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC86BC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1020410E4C8;
	Wed, 23 Nov 2022 01:45:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFE710E4C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSXpYg14HgZB/DM+e1hD7jlPBBIgLD5J4+qD/hklLa89ULgyhfUIh1J2gM3p4eUB6wKW77aHk/BZR2Ymv9GXSA1zRRuPY/9x1Jlh1wR9/BeYXsSoXmYZHTijwsY+lbtMSlHZqmUHKDBMirFu3LFHGAQtwszWefX439zKn8Yt+WTaLGSLTII4+q2JbJFIicCxoN7EHeHE3oSGYx3cryC4Qhq1TDPPkZEUNEnB6uKkPccGNLaScLfFnXUqfZCnFDL+AA7hE0V9OktN1qIRIuGqRrr77++bqquRRG2WU/QEGO3S6tE8iXRR427J7Ne5DRdkD+BTnlMCcoKq4lrGVl58Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbAfJ+Z+byZSxpdvLRL7tQT4tt/CPmt5QNSkj0V0zyY=;
 b=UYwt+5kiQEGeJgdAjvSS9L8OTmie3LQJGduedSZAt1EPfgVfrAFnAEATGyFqxcUCATpu7dj/U9Cbfxe//+TMTT4j5t6PdAJt0frtDUn/u8m8sQ7EWJY3gtbtIOxg9DfXIYDCHYg7nxxY+lnQBBxkIsVTLOCbcHTat1kCS81OeCtC1C8K72yvXXGmQa9Al1s8YC4l2Goyx+nxvryRJ31bXEdlLYkGbRAeNqcnV8+Ivmgq97yonog7fq9dqtgHnUOkv7lg7QY8fO2MaEeGCK7qsFDXq9ITEYjP3aRSCjKWL+/Wgxg3zuMwU7sftnny4q/FAqpkbTMtDwm6wzOXvbv9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbAfJ+Z+byZSxpdvLRL7tQT4tt/CPmt5QNSkj0V0zyY=;
 b=p+GKythMY45y+I15NOCaqz6armYcG0SkJN7TbCzjsGTd2v2ge2Awfz8vQjY5g7EgnLr3XzAUykh+p4y4vo/DoAYHW69NgD4tPt5ongV11992L/YAYl2A9lhfFgLVAz3YuVgA34uT/PSUHpnnLhPAo47lvi3Adrp/xijvwSUiCgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:44:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 01:44:41 +0000
Message-ID: <7ea5d8ba-0c2f-a521-889b-a26fba5802f3@amd.com>
Date: Tue, 22 Nov 2022 18:50:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 06/29] drm/amdgpu: add gfx9 hw debug mode enable and
 disable calls
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-6-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221031162359.445805-6-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: eed321f9-2632-4bac-48f7-08daccf44a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yn6OYx00A1AqEe9/Pn11Rhtdz64+L15FKs7lH9c4Tqee++1vpjTLFHdgVES2rJrWKDnxGS4eSHCN4sH0pJSlVW/s3JyxsQkiEsTCxHzDm2So7Fj/sUMwUPDwA76A+VWWT4u64p8+oGYNG13XY/TzDa3HYe+Yxd9TNLBiCUy/0fSxBBoEVIEl2g21jBUvDKn7wO3GtpaZvbFBuvd492UqF7OtwEoJ3IOVLcCLf2CtqCr19r84WpGs2WvKO1m8ieRiaFg/WBfKn/4MarMsjzxR5cll4B+xS4EZKxWHgQGAJbn76Ic0yAvaiMjrQkA3OkechW1TSH02rzcqibphxjUH1xKtqpQvzlx6qs9o1QIjSXHjg9l1aEomeKXuTkHa81JBY9i3cK93yh5xcfsYP1y2DclfqtBfd3/1gygcHRsANPCK9m4vlmwHXMDuVDMVBNF3twmEdkvQ5KH3EsVtrbwiOfuZl3KZ0kXYs/Ct4K0HKRbALH/rjvTiRkPQAWxVX4xlOcWRpyAApy0u1nOoiusWbqZed+uP/4UxPXSELJL1kSNb7fpgFD/2JBnVTMFfTavotdGdmQ0i6aQC6s8wYeudc6AE4fRv8Ypmt0L9UARYfSYd4SU5mFqTSGI0GYFvl5C6AMo7s+lxXmUgr54Aw0GO7yPtAziqmKk2/V6fknQ+zKssjNXNOQGFOTG8NTldbdIsL+pkyjLK7XCQybqPi9iLZPqIJPNCS6/jT+WWiz6pBfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(66946007)(83380400001)(36756003)(26005)(6512007)(66476007)(41300700001)(316002)(6506007)(2616005)(53546011)(66556008)(8676002)(6486002)(44832011)(38100700002)(2906002)(186003)(478600001)(4001150100001)(5660300002)(8936002)(31686004)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1F4Q3NnTTlNdW1zUGxrcDJyaHpLam5WU1ExZ2ZEUHRWL0k0Qk5oa2FLWUti?=
 =?utf-8?B?SXZEUlh2b25xbkFXK2dYU0NpMHg2ZzF3REFWZ2V0TXdKTVRldHE2R09xa2xS?=
 =?utf-8?B?dnRXYWplL3orUGNZSVNGcXJmSDVpdGxLSlFFRkVUM1graWdvZ1kxUFBXSWtR?=
 =?utf-8?B?NmdxeWZRcUF4ZGhJSU1kbFlUWFlFWDlVV0lBUWc5TDA2V0t4c3BhRnhvVU5q?=
 =?utf-8?B?VC90a2dhaW5BTVQwZkVRTnNUdU85WnVIYWd6WFBoRnkzRlFHYnFLZXNGVTZN?=
 =?utf-8?B?Wk5EYkJrVWc1U2NYR0xiWWZ1TzRuaExscDBxUEZIK0FpZHVPT2Fnb3dDV3hK?=
 =?utf-8?B?N09aa2l3YjhvcGpEa2U3WkpOWFZRamhsQUdBdkJVcCs1eUs2OTNyS2FnWUMx?=
 =?utf-8?B?OVM0ODVoNjZ1R1hMeG5sKzBrajJYYzhhTTVIUkxRYVExbmhPOWx1a3psVjAy?=
 =?utf-8?B?bE93dE8wQXpHQjRHVmZwRzVsY3dBKy9JZW1CYkxiRjlmM1FlVGp1VWF5Rll3?=
 =?utf-8?B?aEZlQnMzN1NmQy9Xc0REQWJhR1Q2S1ZzVldTdXd6ZU1CYzA3OEtwMlF1OW41?=
 =?utf-8?B?cWQyZEl0ZTVPTy9LUFZMRXljMlVyV2FucnVLcldwdHdCQWRqbEw4R0pmOUU1?=
 =?utf-8?B?Yi93QWUyaXVnK1pPV3ZGQ2tSVVE0K2R5anpQYVNqS0YrcEZGdjdMdXI4RnJr?=
 =?utf-8?B?WmFQOTZoeGdDVXBPUDh1SHkzb3NvZ3UybXZkNXluMCtOSS85VXhGTzlxbkV6?=
 =?utf-8?B?bFE5T2RmZ21WVW5tL2V5b3RDNzVCalI3a0ZqNy85QmQxOHVWbnBrRCs2dWg5?=
 =?utf-8?B?bzVFQ3JKMkdpWm9DekxpZzkzcEhPcjczL2t6d05FRk1OcGtjaG5hYzY4bXJj?=
 =?utf-8?B?aHpmYTBhQkNWVjk4S1lidlJyTE5nN01XemRKdCtVdDVXc0FPZTIrOFJyRTBV?=
 =?utf-8?B?NEVHN2VVZExTTFFaQXZ2WjdPc0pnNi9URnRzTTJpckUzWXlJajBRRktHY1NO?=
 =?utf-8?B?U3VabmdHUEJOSTNxNEo4Tmo5MHRWQmh4OGlqcXdBNjc2b0Vzcm4yd0xxMXlw?=
 =?utf-8?B?ME9ybTE5YVptTlA3VzlBSjJnZDArc1BWZStHWERlbGF1bVlXYmQ3SjJnNTEy?=
 =?utf-8?B?T0MwSTNZRlU2QmZjM2hBb1BzVUlQWmJVUEloc0dZWHo1eUR1akwyYStPbDB3?=
 =?utf-8?B?ZzZ5a2daZzBHSjk0a2Z1UjJKTVY0VnRFbEc3OXhlT1RyMm1CTjNHL2tyY3p0?=
 =?utf-8?B?OWxIZW9nSmtyUnBkZmZZYXJzcjZOOE1vVGxzZTRoTEppanJzcTNQLytYcndz?=
 =?utf-8?B?VlZXNnZ4VjRHUElWME9NUFQ0UStaRjVJU1liMjZMTlhFbWtYTmpLK3Bhb0k1?=
 =?utf-8?B?WmtERENjdVJHRU93VGlxMXdLdkNIMVFLN1RkNFVoQ2tHbVhpd2REb1RxTlg3?=
 =?utf-8?B?Nmc4R0J6TFM2VjlJd0syQmVlVDYyb3dDN2VDTmhGakdGTXQxU2pjeXdwVjNI?=
 =?utf-8?B?ZzlMSXN3V2N0MU5PZXQ3RWwzVWhJdVV2Ny9aWW91VUQ1VGd1blhUdmVXWjZ6?=
 =?utf-8?B?VHNOZ1pTYlpBbWNlRmdJSEQ1U0MraEtyV2tteU42NlNRcGdVeUpIMHlIcUdr?=
 =?utf-8?B?a0ZoQjkwaGVvMmwvRlNVdDNoc0c5WEFkb2NJSFEzY2tKRW5MYjh2SitvUnFN?=
 =?utf-8?B?UWVkWFE2bEY0UWFITnl2ZGw4SUxDWWlaQ0h6SURES0VPS3ZJcFNqNFh4dGsr?=
 =?utf-8?B?aTR1QzlXU2hvRk5EZzhYNUxVby9WYW9ONy8rWHVwMlJGcGNDZHF5aWRzM2pM?=
 =?utf-8?B?blpRVTN0QTdnemh3TnM2ZFAxMUIycjhFSlJCazVxM201THZCWkV4N21CSkNJ?=
 =?utf-8?B?TmVOSTNEYnZKWG40UkdTdkptOGxiMitXZHhjOURySUlYMXRTWnl0N1ZzWDgw?=
 =?utf-8?B?c3NrejFVdk55bkdWTWFTYi9DWTZUN2ZVNDZnMGFHbnBjbUNzZ011T3g4N2sz?=
 =?utf-8?B?RS9ISlU4VWx2WXhrZGRmOXpoRjltQjg3TWRxZWY3UUtqMG9qdEZTMXpUekVY?=
 =?utf-8?B?SEZpSHlIdDNody9BcTVzUGxybW5kTnAzUm40Y2NTSWQ1R2xCVit3ZUUrUTc3?=
 =?utf-8?Q?2vWc5w7njurzjY0my/4edQC7M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed321f9-2632-4bac-48f7-08daccf44a3f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:44:41.7344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZ9T5xGEV3tp3zyAYcAtqdRiOxdqGj+/LwKXQikVQa03CzwyhO66x4Y7bGCcoV8rIDW0qxLZAcWeXK0zgBFO8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> Implement the per-device calls to enable or disable HW debug mode for
> GFX9 prior to GFX9.4.1.
>
> GFX9.4.1 and onward will require their own enable/disable sequence as
> follow on patches.
>
> When hardware debug mode setting is requested, waves will inherit
> these settings in the Shader Processor Input's (SPI) Sequencer Global
> Block (SQG). This means that the KGD must drain all waves from the SPI
> into SQG (approximately 96 SPI clock cycles) prior to debug mode setting
> to ensure that the order of operations that the debugger expects with
> regards to debug mode setting transaction requests and wave inheritence
> of that mode is upheld.
>
> Also ensure that exception overrides are reset to their original state
> prior to debug enable or disable.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 100 ++++++++++++++++--
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   9 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |   3 +
>   3 files changed, 102 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 81e3b528bbc9..e1aac6f6d369 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -46,14 +46,14 @@ enum hqd_dequeue_request_type {
>   	SAVE_WAVES
>   };
>   
> -static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
> +static void kgd_gfx_v9_lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
>   			uint32_t queue, uint32_t vmid)

What's the reason for renaming these functions? It seems unnecessary and 
unrelated to the rest of the patch.


>   {
>   	mutex_lock(&adev->srbm_mutex);
>   	soc15_grbm_select(adev, mec, pipe, queue, vmid);
>   }
>   
> -static void unlock_srbm(struct amdgpu_device *adev)
> +static void kgd_gfx_v9_unlock_srbm(struct amdgpu_device *adev)
>   {
>   	soc15_grbm_select(adev, 0, 0, 0, 0);
>   	mutex_unlock(&adev->srbm_mutex);
> @@ -65,7 +65,7 @@ static void acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
>   	uint32_t mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
>   	uint32_t pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
>   
> -	lock_srbm(adev, mec, pipe, queue_id, 0);
> +	kgd_gfx_v9_lock_srbm(adev, mec, pipe, queue_id, 0);
>   }
>   
>   static uint64_t get_queue_mask(struct amdgpu_device *adev,
> @@ -79,7 +79,7 @@ static uint64_t get_queue_mask(struct amdgpu_device *adev,
>   
>   static void release_queue(struct amdgpu_device *adev)
>   {
> -	unlock_srbm(adev);
> +	kgd_gfx_v9_unlock_srbm(adev);
>   }
>   
>   void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmid,
> @@ -88,13 +88,13 @@ void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
>   					uint32_t sh_mem_ape1_limit,
>   					uint32_t sh_mem_bases)
>   {
> -	lock_srbm(adev, 0, 0, 0, vmid);
> +	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid);
>   
>   	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
>   	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
>   	/* APE1 no longer exists on GFX9 */
>   
> -	unlock_srbm(adev);
> +	kgd_gfx_v9_unlock_srbm(adev);
>   }
>   
>   int kgd_gfx_v9_set_pasid_vmid_mapping(struct amdgpu_device *adev, u32 pasid,
> @@ -164,13 +164,13 @@ int kgd_gfx_v9_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id)
>   	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
>   	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
>   
> -	lock_srbm(adev, mec, pipe, 0, 0);
> +	kgd_gfx_v9_lock_srbm(adev, mec, pipe, 0, 0);
>   
>   	WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
>   		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
>   		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
>   
> -	unlock_srbm(adev);
> +	kgd_gfx_v9_unlock_srbm(adev);
>   
>   	return 0;
>   }
> @@ -646,6 +646,84 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +/*
> + * GFX9 helper for wave launch stall requirements on debug trap setting.
> + *
> + * vmid:
> + *   Target VMID to stall/unstall.
> + *
> + * stall:
> + *   0-unstall wave launch (enable), 1-stall wave launch (disable).
> + *   After wavefront launch has been stalled, allocated waves must drain from
> + *   SPI in order for debug trap settings to take effect on those waves.
> + *   This is roughly a ~96 clock cycle wait on SPI where a read on
> + *   SPI_GDBG_WAVE_CNTL translates to ~32 clock cycles.
> + *   KGD_GFX_V9_WAVE_LAUNCH_SPI_DRAIN_LATENCY indicates the number of reads required.
> + *
> + *   NOTE: We can afford to clear the entire STALL_VMID field on unstall
> + *   because GFX9.4.1 cannot support multi-process debugging due to trap
> + *   configuration and masking being limited to global scope.  Always assume
> + *   single process conditions.
> +
> + */
> +#define KGD_GFX_V9_WAVE_LAUNCH_SPI_DRAIN_LATENCY	3
> +void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
> +					uint32_t vmid,
> +					bool stall)
> +{
> +	int i;
> +	uint32_t data = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
> +
> +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1))
> +		data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL, STALL_VMID,
> +							stall ? 1 << vmid : 0);
> +	else
> +		data = REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL, STALL_RA,
> +							stall ? 1 : 0);
> +
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL), data);
> +
> +	if (!stall)
> +		return;
> +
> +	for (i = 0; i < KGD_GFX_V9_WAVE_LAUNCH_SPI_DRAIN_LATENCY; i++)
> +		RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
> +}
> +
> +uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
> +				bool restore_dbg_registers,
> +				uint32_t vmid)
> +{
> +	mutex_lock(&adev->grbm_idx_mutex);
> +
> +	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> +
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
> +
> +	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
> +
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return 0;
> +}
> +
> +uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
> +					bool keep_trap_enabled,
> +					uint32_t vmid)
> +{
> +	mutex_lock(&adev->grbm_idx_mutex);
> +
> +	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> +
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
> +
> +	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, false);
> +
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return 0;
> +}

The enable and disable functions do exactly the same thing. And they 
ignore the restore_dbg_registers and keep_trap_enabled arguments. Maybe 
add a comment why that is.

Regards,
   Felix


> +
>   void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
>   			uint32_t vmid, uint64_t page_table_base)
>   {
> @@ -833,7 +911,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
>   void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
>                           uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
>   {
> -	lock_srbm(adev, 0, 0, 0, vmid);
> +	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid);
>   
>   	/*
>   	 * Program TBA registers
> @@ -851,7 +929,7 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
>   	WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
>   			upper_32_bits(tma_addr >> 8));
>   
> -	unlock_srbm(adev);
> +	kgd_gfx_v9_unlock_srbm(adev);
>   }
>   
>   const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
> @@ -871,6 +949,8 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   	.get_atc_vmid_pasid_mapping_info =
>   			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>   	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
> +	.enable_debug_trap = kgd_gfx_v9_enable_debug_trap,
> +	.disable_debug_trap = kgd_gfx_v9_disable_debug_trap,
>   	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index c7ed3bc9053c..d39256162616 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -58,3 +58,12 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
>   		int *pasid_wave_cnt, int *max_waves_per_cu);
>   void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
>   		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
> +void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
> +					uint32_t vmid,
> +					bool stall);
> +uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
> +				      bool restore_dbg_registers,
> +				      uint32_t vmid);
> +uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
> +					bool keep_trap_enabled,
> +					uint32_t vmid);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index b2217eb1399c..8aa7a3ad4e97 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -25,6 +25,9 @@
>   
>   #include "kfd_priv.h"
>   
> +void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
> +					uint32_t vmid,
> +					bool stall);
>   int kfd_dbg_trap_disable(struct kfd_process *target);
>   int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
>   			void __user *runtime_info,
