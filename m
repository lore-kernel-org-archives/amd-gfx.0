Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B88CA0FFA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 18:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 517EF10E2FE;
	Tue,  5 Sep 2023 18:47:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1CF10E2FE
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 18:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNQLdg9WTuYMt9GHU0XEkgG4WyNHnRkPjmOZ5GuFF5fETiWuvJqR+XivcdctdgJgZEw4ifHI7lMB/StFna3jvfrdJjqX+eKWJK40e2SxO7aTqZdppgCet20FltO8v6VnYCmKzn2l3raJ24CczJXqWElXS/fL5/EMgM1WD3OMP4u8qTXJ6h5sngjEE143f45WTE9/iosEhAf3gVJq2HGcKgVlAzLu9tOIl0mgWQnsVP6iwS0LjcGN0ugD3SzS9MyLY31Z7g5/nDthCr0QJQrgpJMXEuSoA/pMoW+kr4wiivgFfVJV4aednZBa4G5m6cZdgFH46/dS1h48U/KRwgW/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV9XEOogzuvgtkHoy3qwRA+H0qm7EYgBzLfFxMJ5sZg=;
 b=URLYJdPLixivqR0xnf9aXK0oa17qOfkDWHqsihb5/9+uR8MFaD1qsPF7/o3RRk33B+/kzDoa03cpnm9WMZTdoK32zplaeoFncTQ7pYUr/4IBuMyRDIa2Y4DaJbT85kLk011Z2QONb5xPw2rQMwOrfPJ6ToyECZTB0lg22TpautEl+xWllS9eHXgENmQvnY/xQF7oTVSlhLXVz62OkMRwr6EfamfJrK1iHgCKcBZz8aCClpnHHo3rEoHCDlP7pqEJCEziHKc+ufuRQ1GNgHON7J/EQNfzGX9h8rylmtEI1UzUec/Z3O7Jh8VZ5pjRjVht/bW0gQRzci6UBGVUllinZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV9XEOogzuvgtkHoy3qwRA+H0qm7EYgBzLfFxMJ5sZg=;
 b=liPkOBf04RCvFkxpcinNb4ig26x9GYlgfYF1z1p289cpZwAieBcVJr4+H7vvDcNyqxW5BR2OwdO0zMgDcl2cY0y23ejOrJQgWKiAGc6nbkyZGxQRhQmkbLlpuH1miyX9fbOMQkqA42JY0ZgfDiWMr+OV7YUQ+dWeQVxnm8Tu/5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:47:09 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:47:09 +0000
Message-ID: <2e21ae08-5bad-8016-a406-f253c33755df@amd.com>
Date: Tue, 5 Sep 2023 12:47:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 02/18] drm/amd/display: Create one virtual connector in DC
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230816212626.987519-1-alex.hung@amd.com>
 <20230816212626.987519-3-alex.hung@amd.com>
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20230816212626.987519-3-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: dd02e2d2-2abb-4ca9-31db-08dbae408268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AKkzO7cUT9DurL2fKPR2oQcyq0nJvMhMoaJIsqo7m6pbQ2rbmUi+bwd7uwhdBOBR7IIuigDJaYHso3pxgNoCoQJn3/O3zeW+sWvtlyOt+nieUodIvjUsPwj+Lsy6EDHMzxsoi4RGo2dPBmp054jtWNPP/0O6qsFO4ZJlHR56Z01Wt07bhqGo/TpBX0TgTlZMx8EXNW55AKuDyD9gXtLz3WfDxlBvdmjm4K6vkt/q7LCpz0XvWYquRrR5OoMoVn83JY4V5sZ1OUG39ksyT85NgWPFN2RSbh+c7Lr4WYqMo+NDCGNLuyIlai2BJbs23LEXPFf7/09JoG8OCa2mF2lAhF0Usb9N4+n7d/B7yujuhsq7yvmKNYZmQYWMwg4CzCjaCkgvozHu+dgQcVlLFH00a5glVe8w8lZNZ/muMTh/bqql66w2cGmxHE4p9DVhvr8jMsfHVdV7VUqkbpOJjT6iK2XviOfUjsLnCWqOGmhE3H4AI4qgYanxHsEvzN5mvDFjDD2qlpCCFCMx+kOzo0NIWspwcDiPxyOSYqmZspCbaRA6vd3VQJnTfUd3/LiJx/5LZT/l53Hi5idYRrZnYYTBGQk1wCaugJvQq1lXYDilrpkFkLQ3jMo8uCtRZT1WAoRymjGIwhh91+96xA0IZ1ZTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(186009)(451199024)(1800799009)(31686004)(36756003)(53546011)(83380400001)(8936002)(31696002)(5660300002)(4326008)(44832011)(8676002)(6506007)(2616005)(6666004)(26005)(86362001)(41300700001)(6512007)(6486002)(478600001)(38100700002)(2906002)(316002)(66476007)(6916009)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVJlWjhhZFpUdzc1aVZTeTk5aFNHNHJRVjhJZDZmZ3NWd1FmRE1SbWRyZ1BJ?=
 =?utf-8?B?ZmhISjNvdHJ0REVwbm1lWUkvOStlc0pydkhoMFR5TVdGZEwzdWRnMHRjRUVP?=
 =?utf-8?B?WEJYTVljYkVoczc0a0VzMEpEMnBMZWNUVFNLQU52cWNmRmxBMDFNb0ZJcEZ4?=
 =?utf-8?B?SWVqS3RPK3ZlU04yMnBoMEZkTXUxUkIvV1JpNzJ5Q1U4V1NyTE01OUFENUlz?=
 =?utf-8?B?V2dQRjBsZjFGSm9mQXJGRTlrQ2YvUE1lODN5dk5IQUk5TWpib1Fhdlh5Mzlu?=
 =?utf-8?B?UW04Ty9HSmhwMFFIZHRnWUxkQzhUQXNlM05Sb0V5M20vUjB2TWFZRVNQaHlW?=
 =?utf-8?B?Zm95STV1MXdWSjdVajVLQWYyM0RIYWtkRk5HKytiM0ZMNGNPZVptYzlSU3Bm?=
 =?utf-8?B?MkhXVEFsV3FsLzNOVEtnWGJlNzhtdndCclEwb3Q0VE9jMFpES1NzR3JGS1ZZ?=
 =?utf-8?B?RHZOdVJWeHZlVHdLNTJlNERuaUNOTlJZMUY5bUVRNjVHdHk0anlndWE3SFI5?=
 =?utf-8?B?eW90Rk1FS3M0b25mWkVLcmlsTnNGTCtRM1ZxWGFzeHJzU3libXJKMUM5dEdX?=
 =?utf-8?B?ejZ0M0JJSVA2YjNqUkc3UWFjbW40U1NYRDladVE1T3E5M2tBcnM5NUkyUzRh?=
 =?utf-8?B?VElwa3RtVEg0bjhYZVFoMFJacm1pSGY2TzlCaUVPL0g1QTJWV0N3T091YzVq?=
 =?utf-8?B?UU1uYklQZGd5OFhaSE52c3dOTGlOQmt6d2c2bmQzUGdlMCtoOXBVeUxOYk8x?=
 =?utf-8?B?SzNXOVlrcFNGQmxkVWhUcEttdCs4Y01KSHR0aldON3Rzd3VkUXl5TGxodkJk?=
 =?utf-8?B?em42WTRIQVF2b3JLbTd5MU5QNi9hWm5xZFJtVm5OVTdacGpRalBReUtvMlpj?=
 =?utf-8?B?azh6eSs0S2s2azZlalp3QlhNbjNPeTBtaldEM0tZWjk1SEdyK2ZPSTBDb1JC?=
 =?utf-8?B?MXdYanNQSHdoUjJTVmVtWnN4Um5LOXVYQXdWYTNTQlhkSHB4U0VqRm95NTVM?=
 =?utf-8?B?UlFpRGpYTzdVcWo5VEdVcmlvYnFyN3pGK0NoeWxUajlySUNMaFNNWmtRQnda?=
 =?utf-8?B?OGxoTVIzdk1RTHZqR1FmZkZIS09salkxdzVOTSt6RTYyUFBUOFRmYm1OdlV5?=
 =?utf-8?B?Vkkvc3FwZExKV2QvclVReEZrWFUvc1lMNE1ONDZMbkIvVUYxQUhsTCt3UVVn?=
 =?utf-8?B?UndFalkrYXkvazk5a2tzNmFzUk1aTzF2azhxRW8yUEN1UWlrWk5iOGZDUUdF?=
 =?utf-8?B?allySWVzaHNWSFNvT1VyUDFkS0dKKzFjM0ptanVTTDlHR1lmeXVhbHAvRkVh?=
 =?utf-8?B?RE9GM0VMMXlHdVVhQm1UcFl3QVE5SU0vRFNTdEg2alp0KzF3VDZQN0xlNkVw?=
 =?utf-8?B?ZjFyUG4xL25YZmQ2SndGSVdzeUhlYkZNYWJlREZjNWlNMjBXN2dXL2ZBS2dI?=
 =?utf-8?B?Q3d0S3M0RjMrZG9aanVDWUlBZnpScVQ0cTRvMG1sZkdRbVByWmErdWcxS1Fs?=
 =?utf-8?B?M0Y2TDJjY2IwQWhPNlBidDZXcWFDMlNXZDhETTdHN3h0OXFkTHF4bDhkT0x4?=
 =?utf-8?B?OGc0RlJLeW9OVjZqWXhhQzRCd0cvOUt4ZC9NbjJON0laeWVGWGNTSTAxNGJH?=
 =?utf-8?B?dWFIMFVXa1J0NFJJNkVqMmZkQU9BbURncHpkczQ1ZFRnaXRyc01KZHpoWEhh?=
 =?utf-8?B?RTdCUS85YitRanlNQm9ScVBEays4MFVaRmVGSjlxLzlEdjhobjNsWVN6U25L?=
 =?utf-8?B?ekloSWZaakhnRGJqeVYzcWU0TzhLK1RXQWhZUXZxZG5KRDNxVlNidUlydEdM?=
 =?utf-8?B?WktXZFZFZjZuVHRqa2QzRy9wekNIdHdjdGp4dzI1S1IwcnBNSlZnSmJueGtx?=
 =?utf-8?B?KzBBdmp2L2x3RHJ6TkVzcm5OdkU3Z2toODJBN2MxRzNrZnJQaXFTcnZNYXFa?=
 =?utf-8?B?QWlMd21ZOExkV2pxTUsyMndHSUlpbit4K0I5M3BFS2NNMndrbHVEVlRkODl2?=
 =?utf-8?B?em5mZ1A1US9GWk5RNmxoeU1Zb0xtaUY1aGJVcXdscFNEUkdBaU42NXhVSVM2?=
 =?utf-8?B?LytEN0tuTGk4ckt2d0hrR09KakNzaFV0QVh3Y0tPVis3SVl6cDhva0laSFFN?=
 =?utf-8?Q?9DsPnExvicxdghEcZV5qyxhrO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd02e2d2-2abb-4ca9-31db-08dbae408268
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:47:09.3494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4wde5BiyD7XYAbKaFtIhWlx/8wAYK285z+0WXJV67/mI7koWJZSdnwOIxGKWXfMqjsuzmwL6jbhchZBOLUXRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2023-08-16 15:26, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> [WHAT]
> Prepare a virtual connector for writeback.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 11 +++++++++--
>   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |  3 ++-
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b1245b732cc9..00254fdfa1f7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1675,6 +1675,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	init_data.dcn_reg_offsets = adev->reg_offset[DCE_HWIP][0];
>   	init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
>   
> +	/* Enable DWB for tested platforms only */
> +	if (adev->ip_versions[DCE_HWIP][0] >= IP_VERSION(3, 0, 0))
> +		init_data.num_virtual_links = 1;
> +
>   	INIT_LIST_HEAD(&adev->dm.da_list);
>   
>   	retrieve_dmi_info(&adev->dm);
> @@ -4385,6 +4389,11 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   			continue;
>   		}
>   
> +		link = dc_get_link_at_index(dm->dc, i);
> +
> +		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL)
> +			continue;
> +
>   		aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
>   		if (!aconnector)
>   			goto fail;
> @@ -4403,8 +4412,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   			goto fail;
>   		}
>   
> -		link = dc_get_link_at_index(dm->dc, i);
> -
>   		if (!dc_link_detect_connection_type(link, &new_connection_type))
>   			DRM_ERROR("KMS: Failed to detect connector\n");
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> index 2a7f47642a44..65e8504e6063 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> @@ -96,7 +96,8 @@ static void enable_memory_low_power(struct dc *dc)
>   	if (dc->debug.enable_mem_low_power.bits.vpg && dc->res_pool->stream_enc[0]->vpg->funcs->vpg_powerdown) {
>   		// Power down VPGs
>   		for (i = 0; i < dc->res_pool->stream_enc_count; i++)
> -			dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
> +			if (dc->res_pool->stream_enc[i]->vpg)
> +				dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
>   #if defined(CONFIG_DRM_AMD_DC_FP)
>   		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
>   			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
