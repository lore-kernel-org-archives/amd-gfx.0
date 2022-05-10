Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9B2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 15:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D4010E527;
	Tue, 10 May 2022 15:20:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA9E10E527
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 15:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlxoWWqb2Kg1dIkkW/XS2f8SXKg62s+hE3Mi83v7SRj27K4kqfGLImEiOUwB81gH/mSfZaJ6XIvLWK+t2PUhB+x5oZuCUKRa/RLqAKpmHdWxRtZ2GC/leY40IJEZkKnxFY8cbvRajmloh3upn7EgDyaET/lRk988dhPkFdcULvmkFtRV9oE068XYEUdefnflm3AGYKtJy+qRMK7heCS2vIZ6w2Kg6tzLjs56uS+7Robiv0ngUXzNlgl9INQig2d6700gJ5lhCppfpB6P1vyAC1s/wTLGm+1MZqkeSb0hCM+kD8SvUypQdi2ayFNAlpJNnLdMhz6bLvw0ZD5zhpfZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq5CQtuRFuYHf7fvYfB5aC0WPl8+8B7t6d0WgFW2/aE=;
 b=VcjLJcMs6ep58lJLUXXedcJrTN8wt7uqsH2E/BAB+epTDM3Findl8/hDQRoThPkq18z8lQ514zD/VTJvLjopz59GrzjCXiPu3pO4bjMT2sYjboWlQOiyuhFS70/u+d4SB2q+9KZjwYzFWsSwnnBGLkhOfGxjERPSIEkGfdWFIWdkyhauprBxVOamQOalhT+mjDnC4b0W0CBKylj0FH+b+df5umlWnEp88zM1V9rEkKghtN+2qe3GZjHojTirthYzwDZ0rupUWthrtB4Tl8u+/peab8lKAfcEhNowVS2v1XR88LpHCJjgkHWQR771C0YOz+2GhQ/qJ5tJBovtxIAk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq5CQtuRFuYHf7fvYfB5aC0WPl8+8B7t6d0WgFW2/aE=;
 b=JiUjX6WBjqnYnQQDtFwDnNpElUgxdszMI2nf0qrURpYENxGt33p8YnbZ/6cZe47Fc6Jx1mlJcqVmhEVstOu96h2pZH89iaJVL/eC8HDQ058mkLYiV4i0hurfnYLuNY+tZPaH8yizS1x+eB7VSzuuyRFtHn9jT4vyjR6GEZ4CHA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 15:20:44 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::812:88d6:77ae:1d87]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::812:88d6:77ae:1d87%8]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:20:44 +0000
Message-ID: <90f223dd-d6bc-3f98-a620-e61df3af6f5b@amd.com>
Date: Tue, 10 May 2022 20:50:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix start calculation in
 amdgpu_vram_mgr_new
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220510113649.879821-1-christian.koenig@amd.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20220510113649.879821-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::11) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3326fb7-708f-4492-899e-08da3298a6be
X-MS-TrafficTypeDiagnostic: SA0PR12MB4397:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4397CCC54D399761ED48C069E4C99@SA0PR12MB4397.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjUa+o6Xiezi50QrjCU6XSfy3igtzjs7fad1E2Tmt21o7MUIpTv0bt+mWIoOlxCccnJP0I6C5EY1dW1PRrqm7dajgjk+xB7QoqexketzH3H8vXFlPaTs/79wu8AmLjPL1IpEt9SLAPSqqAgG/N0AIqQb1kWklPlETCqNpVX9fKWzb+crXehEB5zjoM8pYw2Cw3jRtnB6VtxkCUMVdF4qw2PD27/TFx88p8sCChezEIRCVNPyniKK25H5jAElfS1ghbKtVJMCkUXb4NTwbqHfPPqbJZwg2GY+bx+l2En0DlhVPUvtQbJlg298BUrb8NuFTx05CF8aMlJIy3roX34pUuelsJNtOmKfILQ641cn3VfZP39ySHJnoYvDzYA/FJsLMMSwvYtry/tjIZMefC1/TKoz5O7/TXlQGDzafzO0AZWRRTp1G+HP7Kw7YCX0jQDRvvJXoKvJ81tI8Y4QUo7Asc2DMarz54kDD1kmznu7CBgAwlEwazSGe15zW6wWK3kp/bbv9PA3Av1IECcn6YZWtociAvMI4zoMP3V+cC+c/mMNDNDy+Pg5Wf0DJV+sfd7PK79Et6DpqDJEeiX5b6mqxu5ugCwM7qDPfpp6S1B7k1PCA/BrDI5welit4Gra/cD4wJW8vwf5Sv8un041si1E4PuHBHnbN+Fz2ci731wq0ab0LmnRvp0vgRFBZL3w2zxi5X9iaAW0zLbqNDLvZQSMf+oefO68BUYGa4fdDvFbOtNzYZonTkChhFL/e2w+l8pa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(6506007)(31696002)(6486002)(8936002)(53546011)(2906002)(6666004)(508600001)(5660300002)(83380400001)(26005)(6512007)(2616005)(38100700002)(66574015)(186003)(66476007)(66946007)(316002)(66556008)(31686004)(36756003)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJvN1FuZDFoS0VCTVdpSGNDQkdSaEhMZEhEdEE1RTJGYzBsblhScC9hbVB6?=
 =?utf-8?B?dldmWVM1VWhNVVhhVmk3MWttTmo1RWFrSWVadnFkYmF3anJ4RSt3Z09CUlFO?=
 =?utf-8?B?SEo5bldIZWo0MWluZXVNL1VoSjdqQjQ0cy9tRVl0YnhPQXozcVIwWnJHQW96?=
 =?utf-8?B?SjFob0hwb0FCNGtuUlR0TllOckxjRnlEZnY5RVpCSE03UUNRb3BDaGtUMS84?=
 =?utf-8?B?cnR2OFRZem5nL1UwSmRVNmVRRFBKOU5OUEQvUnlJNThJSWl3SGdpczFSMGRj?=
 =?utf-8?B?UlNLeXRVOW10dDRTV2RNRmpCQWtXL0V5R2gvTFp1K2FBL0t3dWVHeWcxSDRM?=
 =?utf-8?B?Zk1Gb1krRlZ3T3FzTUd4V3NuV3BqRDBoR3ZCNzJISWYxVE5DRWo0R0NoUFRj?=
 =?utf-8?B?OWNUZkFqYUJJV05QdHVkUGJob1lJSyt4UHpWVm1WRGRWQXJxL1ZQOVZ5YnNp?=
 =?utf-8?B?R0JjdGZTNTl4QVBoWG1pRWZyRzZmMXhKNk42S1RldnhuMndQemRGN3NWSDJL?=
 =?utf-8?B?eTVnK2lyb2prbnBmVUZXNDFkYW9OajR1QUh0OVRYaHd0MzlnVEhlN1dSQWw4?=
 =?utf-8?B?YURDcXo4TmRTNG4xVFlvNTJUTURiWk1EMVAvQWNTODRMQ0NWMDkvb3VFdEJH?=
 =?utf-8?B?K1dxdXBRbm1Qb3RsQW5HZkEwbnhZNVJEeStDWGd4WVV6ZE55WUNjbjJqbkoz?=
 =?utf-8?B?Uk5aUkYrVGZZUFN4YXZOcWxKZzE4U0lSWVZKQlNjcGwxVzF1Mk5YSUdnN1ZP?=
 =?utf-8?B?TDlUc2ZqUmNDMURTTWhrUmdWOGZuM2JYaFZQTTRHNGtmYi9VT2gwWGl0dnA2?=
 =?utf-8?B?RkZCTWdWaVJCTmxOV3VuZUFjSjZ5WEV2R3RCNzhERWRZcHBFZ3YvbUgzaW5X?=
 =?utf-8?B?aGdwZUNZaTN2b1l5bkNLdUFUTXE1aFFMV0ZualNjRi9lbmlhWktKMjY2WExv?=
 =?utf-8?B?anhtdXNFN0VTR0JPaXVOQ21YU3o2YU5LNEZkbzNlcnFBNDhGNWtpL3BTV085?=
 =?utf-8?B?aFNUQ1JtMEFOOVVOSmUrM3ZTMnVObzY3eUVIcGZtb2lST1BXSnBLOW5wcTlM?=
 =?utf-8?B?ZlMxV0FaWHBmTDgxdnZhdHNqeXJvOXRuQW41SXJGdjdSaWpyNFpjTHBkM0lm?=
 =?utf-8?B?MWYvcDVON2dneWJrV3Bubm5YY0NXalhFNkl2Z3F5SGFENHRVOVliOXRXSEhP?=
 =?utf-8?B?VUh5Ui9TMUJHS3VaY1dTdFF1Rm8vVlBBQUM4blpMRENFZ25sVHRCS0RoM2ls?=
 =?utf-8?B?aWo0T0FBZ0d0MjZoeEk4QTU4T3NLZ05KSi9sYlVISnhUd2pwUldUQnJBVWZG?=
 =?utf-8?B?QU5lamNUM2QwdDhCSmRwQ2M1YnJXRFFldGhLN0VlODJ5VVFBVUJYMThGSHR4?=
 =?utf-8?B?K3VBNnRIelFSOGgxZFRVRkw1eVMvc2tVWnRKN2JxQWprWHBPV1hsc3VxT2JZ?=
 =?utf-8?B?UmsxRXJRdGc2LzhrTUZ5VW9SQUd5YUxrUmdjTGx1UTlWbkYzYmpqQW9ueFpr?=
 =?utf-8?B?T3VaejllRkJ3Rkl5OGIvU0FQZlVlb0UzUlVMSFRJYlQ5MWxlcEdmN1dlVlZI?=
 =?utf-8?B?VmtNTlJ1NkJ2SkdYOXo5V1Z5MHhrdndKMk50QkMrNUFnTGU0TmRSWldQdHMv?=
 =?utf-8?B?UTlaT2lmQXorU3FZR1FTQ3B2UCtUa1U4cmtsVlJxNFkweW11akpkUWN3YTNk?=
 =?utf-8?B?T3pFMXhWUng4dFBQQjZZckcxUkZmNUFqek9JWU8wRmtKOVhMWStUWHNzanEx?=
 =?utf-8?B?MUZ1U1pNNnArUU4zcjNSSjJUYUErSGRUckRJampsRi93dGliYnF2ZkdPMUR5?=
 =?utf-8?B?ekhTQ05iKyt3cDNjQ3F4bkVlbUJ5V29WY3ZwcFk1cWRBNi9MT3ZqWDRWR1Bv?=
 =?utf-8?B?WFNGcm5LUTgxcXlvQ3pwajlMZ1ZpQ3E2a3RLS0RFNFlkOVpuUDZEQnNteU5i?=
 =?utf-8?B?WlF1YVZhQVNzK3FGbkFwTWo4dGR6Y3ZGLzNINDZ6eXhlT3BTa29xK1ROeklp?=
 =?utf-8?B?NXZUeU0zb0c4dDA1TDRldFIyQkkzSm1MeFNFZGhKU0E4aXlCTFQrelcyenln?=
 =?utf-8?B?ZVVFcmdUMEl6KzZseE0zOHlzbDdHRGl2SFY0NkNTdVUwakVDZG9qTk5ORm5J?=
 =?utf-8?B?aFYvQk5jazJoUTVidDk3R25Qc3pXRzJMZXFJcHdia3YrL1M4TFVEN2tiK3pK?=
 =?utf-8?B?ZHV2UUJ0MGs4R3hlOE9QT1Uwd2ZWS1pCKy9ib1BGc29RaURnOGdjNG5ObVZC?=
 =?utf-8?B?T0FJU3dsTXo4cEdFV3lMd09EWlZTRDFLN211bHpiY3daSjJpSHJOWXFEY00z?=
 =?utf-8?B?ME9lSGR5c1hadTR5MWxNQlU5Rml6SC80dnFHVjZWdHl2bTB0UUdwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3326fb7-708f-4492-899e-08da3298a6be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 15:20:44.3237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNgocxFEJt61OrGAC/Q2v7Ra/5X+Qyh3yT+upjS+gmlcbFJ6w6GAuzX39ryefwaIQb+O/IvmxtJvBOi6vlgRMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

On 5/10/2022 5:06 PM, Christian König wrote:
> We still need to calculate a virtual start address for the resource to
> aid checking of it is visible or not.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 22 +++++++++++++-------
>   1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 49e4092f447f..51d9d3a4456c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -496,16 +496,22 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   			list_splice_tail(trim_list, &vres->blocks);
>   	}
>   
> -	list_for_each_entry(block, &vres->blocks, link)
> -		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
> +	vres->base.start = 0;
> +	list_for_each_entry(block, &vres->blocks, link) {
> +		unsigned long start;
>   
> -	block = amdgpu_vram_mgr_first_block(&vres->blocks);
> -	if (!block) {
> -		r = -EINVAL;
> -		goto error_fini;
> -	}
> +		start = amdgpu_vram_mgr_block_start(block) +
> +			amdgpu_vram_mgr_block_size(block);
> +		start >>= PAGE_SHIFT;
>   
> -	vres->base.start = amdgpu_vram_mgr_block_start(block) >> PAGE_SHIFT;
> +		if (start > vres->base.num_pages)
> +			start -= vres->base.num_pages;
I think this works for continuous blocks of addresses, but for a non 
continuous blocks allocated at different
locations and linked together using list, this might fetch an invalid 
address. I will check this patch on my
setup and inform you.

Regards,
Arun
> +		else
> +			start = 0;
> +		vres->base.start = max(vres->base.start, start);
> +
> +		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
> +	}
>   
>   	if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
>   		vres->base.placement |= TTM_PL_FLAG_CONTIGUOUS;

