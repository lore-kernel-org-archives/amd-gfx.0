Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC20EB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 15:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68B110E04E;
	Thu, 22 Jun 2023 15:06:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D0E10E04E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 15:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U600XuA6a7tCc6TsShaop8YuBEzXuKEtUUsnqHHPCWuwdX/+IAwHaK2xMRHD1BKOW3hnZcUSz7j5m0hLpt4ohqh3AOxFM8Mb3F787qIHK4PcJdsPCuUFfJv7kPQy/VduOQ0nEdnkUOd9/yxk7caUxwciCpQRAXlgNbgbLu2qLTxWbReVKch0mEBg4axdtAbfE2RYi5zGGNIrnywBclZizIf0DTxq918tdcKfJ7XfWLAEGwrtsbj4osM+kn8KFS/MUxmDUxLm+BrMJY55T3GuMlYmq80cEoqT7qw9q7McsMaWrf2EQ9XEBlN2rICBOOjUGAs6WgKWCnHUtno7vRnAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imNDGRG57RLPizBtdxdd0Twezvrv+wb9W4YaO3jWQNI=;
 b=GTPTMx4JLGTU3sIF/kZGgLKqENSk6KjYdq9DXcp+ZMIXk00+BTiQaTgkkXyPxo17PNXRNMa3kyNm6LLGVeC41PEAFtYOe955rYft76yDDAhiJsHfYshlQln/s/nHT/amOxSMa6AO6XgqATsHLlTG+FZGP565rxxhLETLtmn6iu5UU+y6+fvVDwKJtUqx0XuseFFdW9VLBwC9nnGk4Tvng4E07gFQdPUhfd8QDF+pPCHBbBACharhmntpx2aR8S8jOwKQeV5XR/f/WgH4Il1YAS6zJetT80NvG3OQyjhd6Eyi7V7VgxfS3g45N+JFJZJ8+pQmZ4MHlxRyRx3bc2IBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imNDGRG57RLPizBtdxdd0Twezvrv+wb9W4YaO3jWQNI=;
 b=rgZk138Bs6ykiI6Oa0svmtB5Ty63viZoJjxg2aCv0oYym/xDcHWuXnvd8zn1axk58BFv24QR6N5zN50C2JR4BQk6XlIel5yq5wZUfGozMKYBaGZAZ7Mnwcu9D3Mqcwn5I/SBDJ7A0CjWyXc9RXTJNq+j4hN5W+rFbJq+ZzYJt3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Thu, 22 Jun
 2023 15:06:21 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 15:06:21 +0000
Message-ID: <ffc712f6-1038-139c-2227-766367ff7ac1@amd.com>
Date: Thu, 22 Jun 2023 09:06:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/display: Use seq_puts() in
 'amdgpu_current_colorspace_show()' & 'edp_ilr_show()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230622085816.1087357-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230622085816.1087357-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:408:20::49) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: bc33e453-5abc-4adc-f291-08db73323d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcT6BJH38zdGddhTnL5I40r3iuzV8oU8/qXMDVuzfy4HAsWpBdXNp8Qqgs5DR5ZsRJZjcv6Sn4CQLmZAzST2VnfyNMfluB6ASljGo9RbYmMuppWKinqczgdjX1j6qCjwbdrMp4fFNTseHqUgG2CQ3rPRqDFuEO/fnVPD6oW2QLmVSDaK0X8fN/uydMK/9RCR3OhFXFXu1j4tMvZhg2p7l5P7KbCiPfFxwVMSS9zWtyisNLpVMt0yHQr19prul5HBx3Tl097j2uKz+5/vGHEX5QvReIAnOYPllfgBLrcwjIGrUcf3xqTAEpxWTpRm3BcK7BENy28xdbaj7nMgOM56saAuMYDM2Ch/0KCRBxgfQuHSv0QN8zcOKK9McX8tJtbxYaNHDJiElxSkTmskMAXnFOd8/FwXaxhBo33Uh0XHsM2pjj7IYJLkTMiOnzuUPdGEzztN+WyRbPO6bdjLNdX5MzPkLI4FFpwLqAgOpSem7a0O+PLzFZLQibH3qK3elU5YlCRVo1o810XkYkUt/I+LaKCtX9lMAFoQKVd/KKdHAXVKo4kyUl79KiFGgZmoKuMus8Wr97w2tE4wfgeNJPCaUaQw54O60w4tH+XAOGOpCIO5InAX1WjL0Omzi0P/i8oVx1juxRLLP5RB/vdp3YyeIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(2906002)(8676002)(5660300002)(8936002)(36756003)(41300700001)(31696002)(86362001)(31686004)(478600001)(6486002)(83380400001)(6512007)(6506007)(53546011)(2616005)(54906003)(110136005)(186003)(6636002)(316002)(38100700002)(66476007)(66946007)(66556008)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2I2eVZrbnFaSWZQWUwrT0xOMHlnUHp6L24xbUdzUlMvR052UzV0U0dIdlc1?=
 =?utf-8?B?QjlzTHdOaC9vUCtyeENHR0FjNG5GTWE4bnpJYW44d2JaeEc5dGJFdXA2L3J3?=
 =?utf-8?B?OWRTZDF4b3NCbVJGREltcU9HdUwwY1d6YU4zcG9nTDRWR2pMV3NYTVNxbmJE?=
 =?utf-8?B?WitWekVwbjFka0ZLbTh2N3JpTENsRm5tK0s4ZDNuZzRjQ1YzQjAvRHllS2pn?=
 =?utf-8?B?TElOeExrZmpQYjhidFF1Wm9EWjZHOUF6Rmc1VkxoS2ZYMlRxb044Q0RNTHNh?=
 =?utf-8?B?NmVqMnRYN09ieFcvbVB0c3lXeFhWUzZLOVFJaEJKT2lNcmgvbmp6Zmk1MHFU?=
 =?utf-8?B?UDd4TWFYVlNQcFFDc1ppQXhIM2NJS293ZHRkWlB6MkE0OTI5Y3dDQ1F5U2tt?=
 =?utf-8?B?QTFueU1XMndwUnpqamtrYkxwYlhoamkzK295czNmamp6TE5Ka21DbEtnUFI1?=
 =?utf-8?B?RDN4bm9JMk5rMVFvelZCWnV4cVF1c3h4c0w5VFBoZ0E1ZnBBVVhqa3hZQ2dP?=
 =?utf-8?B?QVVZMnFjeVN1RkIvc1RQemE2MVI0bVloWlJyMWVlY1gyWE5sWWFiU0xSWkVI?=
 =?utf-8?B?THBlTm5nWDRKWU4xMVlDNFhvVU1TV2htbWoyS29VYktJQ0VSSWQ1anMrUFN5?=
 =?utf-8?B?Zk02KzZRNm5pejlHcTVjb3VmMXVWZyt4b1N5RzFZSE1JZ1AxUWRaVkt5NUxk?=
 =?utf-8?B?R2xyRzJHOFZvTUJ2cmplMVFzckJNWWUwQy8vUTducE42V25wbVlicWNBQmhT?=
 =?utf-8?B?WGJtRG9Zc0xGeEw4bXhaeXBSeDQzNmpjNGdhckNtLzFSb01yMlZTaWFKZ21H?=
 =?utf-8?B?bUsvNWNYekhaMlM2MWg1OUpGUTV5eUJpU3N3TDBuRU9idmZrRFk1WHQvSWF0?=
 =?utf-8?B?RmhESGo3V2xZdlMzTHdtcDVqZDVxVEdGN2pVSWdPd00wU3oyNWxYNituUVZs?=
 =?utf-8?B?TmlKdWtTR0crY2p2d0MxTGQ4SEp0OGZGVFdVNWlGOUpKNlQ2WFRQYndrcm5y?=
 =?utf-8?B?NGtlYUs1Z0dlYzZkNGpRSDZxbm9hU2ZjWWk5dzRlOWdHWmZmTHllTXFDNW5q?=
 =?utf-8?B?aVdibHd1OTNza1hyVU5jQmo0djliejdERE5rNDZEYUJwRWd5VWdCUGE2ZGhH?=
 =?utf-8?B?RkUvb1lWZ1hqS1NHZFBMTTUwTUNORDRVWmZ5eWZiQS9EWXNXbEhwQXZxWHRU?=
 =?utf-8?B?RytHanh0VG84MnJiNGl1WTgxeHFrUVErNFVENDBMY1VqbFI2bHN3V1J6Mi81?=
 =?utf-8?B?b2hNUnlYMU4wSnN1NlhKMy9KWXRZeFFhWWw3M1VHU1d3Rmd4ZEZ1MTVOTVVH?=
 =?utf-8?B?NklIL3RqczhPb1NpU2I5SGdvSitwMWwxL2h2eTVQeFlLRCtSR0s2eTBkWWRv?=
 =?utf-8?B?VVhRUDAzTm44Z3h2bk00V1ovVHd3NUorL1ZsZFRIWmRIa1VpbGZEVWtZbFVC?=
 =?utf-8?B?WGxTM0YwaWJON3BhbWlMZk5wdThjMkhsMHFTMG5OTEFzZU5kbEdHV3lzRno3?=
 =?utf-8?B?N0ZFM1JaOXNBemx4dUtUaVlEdXc2cW9zQnBhNXNhTXczUHZySTJvYUs1SHFu?=
 =?utf-8?B?YThURnoyeVY5VTdNd3FiUnBhV1FWY2RhNXNnMzRFVUNKczJDS0c3YjAvQVpm?=
 =?utf-8?B?MG1YUkMwSjc3RWs5ZkZpcERBaVZ4VXQrWE9neHkrSlFBNmVPd0pTSDBJTUFy?=
 =?utf-8?B?YlVINGhDUG1EZ2ZRZGQ1L05HanM4MktndnhMbGFwWkc0V1kzOEpmRTVORzQv?=
 =?utf-8?B?TkVxTEF6UllRRzcyM25Ga3o0bkxwK01wT0hobnBDQWlERE5GdjNBbTB1U1Q5?=
 =?utf-8?B?eCtYUHBzYjdhU2J1dk9HZDU3MHFueHV0YWgrRGZUMzA5NWlJdDZpTDdieGRy?=
 =?utf-8?B?TDN5WVpHdW1tczhOS3lkMUZmWkV5T245YWNndVVsTzVTaElkeG94UG5pcW5O?=
 =?utf-8?B?Smx5WCt0YWl4RXYvcW41QVB0amlxV1k0a3c4MFd4Wm9mc0xsMmh5a0JSNW9r?=
 =?utf-8?B?RDh5UEtXYy95aWt1ekhJbFlkYm9sdnNXRy9TcTUvVUhCZExwUzZmbjA5enVi?=
 =?utf-8?B?dTdjamU4SktGeEd6U2tnL2ZFemlOcTJUUUxCK1Vua1JDYjNTQS8yY3A0emhB?=
 =?utf-8?B?N0JYcTR6WUpVWUZseThSYjY2MU9ka2ZzTzF6aThZc0R2YkJwZE5rK1RoMlNV?=
 =?utf-8?Q?aYBBVaIs1Q0d0j7DyNIz7Pl5MZRZcIViGGWM6Edrsfte?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc33e453-5abc-4adc-f291-08db73323d22
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:06:21.7183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbgNBIoN9uo0tDTdfhKHQiWlLZ0z5ZhnDHBubIjDC5dcvmaPwjPODflfJmZyk/4n8FxFO3H4815plY6E4tfX4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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
Cc: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/22/23 02:58, Srinivasan Shanmugam wrote:
> Replace seq_printf with seq_puts when there is no argument list.
> 
> Fix the checkpatch warning:
> WARNING: Prefer seq_puts to seq_printf
> 
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index d63ee636483b..7c21e21bcc51 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -1075,24 +1075,24 @@ static int amdgpu_current_colorspace_show(struct seq_file *m, void *data)
>   
>   	switch (dm_crtc_state->stream->output_color_space) {
>   	case COLOR_SPACE_SRGB:
> -		seq_printf(m, "sRGB");
> +		seq_puts(m, "sRGB");
>   		break;
>   	case COLOR_SPACE_YCBCR601:
>   	case COLOR_SPACE_YCBCR601_LIMITED:
> -		seq_printf(m, "BT601_YCC");
> +		seq_puts(m, "BT601_YCC");
>   		break;
>   	case COLOR_SPACE_YCBCR709:
>   	case COLOR_SPACE_YCBCR709_LIMITED:
> -		seq_printf(m, "BT709_YCC");
> +		seq_puts(m, "BT709_YCC");
>   		break;
>   	case COLOR_SPACE_ADOBERGB:
> -		seq_printf(m, "opRGB");
> +		seq_puts(m, "opRGB");
>   		break;
>   	case COLOR_SPACE_2020_RGB_FULLRANGE:
> -		seq_printf(m, "BT2020_RGB");
> +		seq_puts(m, "BT2020_RGB");
>   		break;
>   	case COLOR_SPACE_2020_YCBCR:
> -		seq_printf(m, "BT2020_YCC");
> +		seq_puts(m, "BT2020_YCC");
>   		break;
>   	default:
>   		goto unlock;
> @@ -3022,7 +3022,7 @@ static int edp_ilr_show(struct seq_file *m, void *unused)
>   			seq_printf(m, "[%d] %d kHz\n", entry/2, link_rate_in_khz);
>   		}
>   	} else {
> -		seq_printf(m, "ILR is not supported by this eDP panel.\n");
> +		seq_puts(m, "ILR is not supported by this eDP panel.\n");
>   	}
>   
>   	return 0;

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
