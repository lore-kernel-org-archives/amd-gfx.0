Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1027EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 17:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4908410E355;
	Wed, 21 Jun 2023 17:07:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4329D10E355
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 17:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2bgULYRz9doaOq2aIVCeEs3XUvVka8dKL9p5aS3lT2ViF5BfaQYbzrJLtmitTrNBKekgzgCgeTSj3Z61leaVTZ1158NyQWaSUtQHeRY75qW1mAbAMcKoDamPfdkysVhyNTLxUVAQQ8iuhtJ9++511ZKskk58hRjYcERSV9s3uuaP7pdIvEyYwKioVYxGRgxK4CFXgDHaE3RWsFbQ3QI7Lmktw1Yp5456ftm21x5JRDeoF/cWXH0ijKm0tGl8Uohhmj/Ze1nWHLsCLD+cgOJR3M1yVZG5ZYadUhKVbyERV0JMrc5tXmNSoWXN7Y5aHRJbDHiU4j70Rap56Un6achcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXsr2pkGTEwaW5ykUVED1W74EUre5n1uO7gqEUeWyRI=;
 b=No82I3mc5ATOLTiI/TSVUnKt62K4EN9RypXOMecZeV0gou1uogD9SxvsAmJhgrtn73YBr0zi+eC5UKGa5hIy+hE2TOwO535DgmQTEVSwoseNvnF+UStqrpQPKw5KjK/VoGS1nWlb/2sTM6/MOHdFyP7p1mEpF5J/VC+gAyoZQe3wyM1xfllHfvp6VcN9POBX6BXMdablfeOW4n2ufHTM5NDBcC/xa9SifdgQO8pVSzHFxZnIJpmtNFyzZW/an0s4c6CEYGJSe3xQMaJosApFygxF8ZnFmZcGqBc+6qH22ObqaaFDWNvNwPXAKpxJdARvcr9tN0hcxwSM5BTWL1X/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXsr2pkGTEwaW5ykUVED1W74EUre5n1uO7gqEUeWyRI=;
 b=hOqqAI7N7b1OZLtv+PMc6mQfH8buOeONwQ5xGSaSmWOcsXrwEUcV7KvXOJsBPWIWQbHdo0MdF9sQLcrEx7REOw8H+/Qitu6/40BPpttoqKXqxELFFTMfBJtYeVqcL0FAhFZwZZCcWaBa1id3xJ9sXt/ly7oGSJ7lv0mt3UyP1YI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 17:07:15 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 17:07:15 +0000
Message-ID: <6fe8d07b-64e9-cf13-f297-bd5def8fd8d7@amd.com>
Date: Wed, 21 Jun 2023 11:07:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] drm/amd/display: Remove else after return in
 'dm_crtc_get_scanoutpos()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20230621025109.391331-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230621025109.391331-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0478.namprd03.prod.outlook.com
 (2603:10b6:408:139::33) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bc7b13-5030-44d0-9fa6-08db7279f68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRzdiE9DYzfu73ywUmMDUiYJ36GdNIgeyQGoHffOeADKOh4DrXY1Zp+xLMU7R6+bM7HQ3GT6yMC9OItR7+Em5/ZXdLXWo7l0TqnX+WEAidZcSdwhZli4aQXr8LDZWqs0tLEPYs4SbVLyFc824leXF+1m87fgtVsGJ1IuBSGbOpjUB/X1bjEKiPAVLVpU7eGETl9SBKim45fpqQQWX59N9i+ztB2uKOd9SCv8ZD2BAFuRO1hXTvhSO7nor1pWgx5XUSqifpq7UqVIoWiwNoHPvuLGqOqEndEExFCLt3JA+AJysI+Fk6YTsIycvfm0j4gzvnBXW0UJaqc4xhkPqxyHAJys0deeT5y07TPnkzqcKk8b4tfeE2zjmsQVNkB2SQvrcKlr1qC8DCPVmlQBK4H9m9vVzhOuw4y9ihvLMR1DNOexQTYyw7TVs2RFSJDbKJtkvHtHAOwwk57qYFzEiN03ofSluKvYXNJfrWdI4xbDEHu/dRU0FhiWlRomJ87AtdlaFqi7QbxsCUNcIlpUP0uG5ZUNV3+bPqunPnqb5fQ29gUHS1JVebwVwlvh2S0iG8A2NF815m1pokKpXG2Ro69lTw7eD1ybNxg2jqjqouXxCU0e817o5Ma3jZAeI9rT0nNvXNckGt+UDBdY0tkgMaA4WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(6512007)(186003)(6506007)(53546011)(83380400001)(2616005)(38100700002)(110136005)(4326008)(6636002)(66476007)(66556008)(66946007)(478600001)(316002)(6666004)(5660300002)(41300700001)(31686004)(36756003)(8936002)(8676002)(2906002)(6486002)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak42akRySlNxYm14VllSYm44TWtKTCtHeW5seVdXM0JGWHZ1RFF4M28vbkFj?=
 =?utf-8?B?N1RWVHVkTVMwWlJoRXhCRWU3bFJmbjFKZDZQL2FPNnV0ZXlqcENLVFFyZVhB?=
 =?utf-8?B?dHd3K200SUIxRm04MlYwaHU5ZERIcGJwV0ZpY3ZjOFlGeE9zaU50VEU0SCtB?=
 =?utf-8?B?ZkFuZzdkalNwUFdxRmRiWFludnhEcEQzWVJBdG9FSC92VllTSE1Uc3g1Z2FD?=
 =?utf-8?B?cVM1V29ZVUJaNjFpZmMzUGdSTDBYTUFQZG5mOEZSejg3RFpTb1lDOXVTa3JU?=
 =?utf-8?B?Z1QxYVRjWURrSVAyUnpTeW1lZEl6MGRXYVJrWFJUclpOYzc2RGtZMzNWU2ho?=
 =?utf-8?B?UWJUb3dlS2RDUlBYTjFTZmhhZU4waGcydW1OTVFPNkkvb1Z6VmQ4S2pNU3la?=
 =?utf-8?B?b0dWZHZRaVIzc0FtZm5CVHAwL2lVdmxmZm0wUTdRNGRVYVFyc2ZMczR6ZXVh?=
 =?utf-8?B?VFdnR08xeldRSk1MZjBueEZmL2RyMGtNT1lna2lRYi9GTzdzS243ZEZyOE9h?=
 =?utf-8?B?NWF6Q0l1c1IwSGVJU1MxZXkzN2dHczZlRGZ3KzB1SmNuTjhocFBmMnMxbHhk?=
 =?utf-8?B?UWVZTktSRVI5MU1XL2sxSUh0bjlYZ2t4cDk1b2VOVHFUOFVqMGR2blFGUzNx?=
 =?utf-8?B?S2JwME1VTHcyZ28ybXl1STdJWktNZXhscHFpcGNxQXRRVk5Rbm42cmlRcERF?=
 =?utf-8?B?dWtJbVM1OUMxamluRUd1VXJBeGFielhOVmNSVFpQK095VlJDalVWYmg0VThY?=
 =?utf-8?B?bjJwczlMSlZmYlRrTXkvMXNhZmtZdW5lV3g0bTlQRzVDZHorM0FCWkk3eWp4?=
 =?utf-8?B?ZVdkaCtDZ2E0M3JtamVpdDg0dWh4dGd4cXhzQmZmWDU3dnpBcDUwcXo3V0hS?=
 =?utf-8?B?QWI0cnJidmZMVHk0SVNQVW1zbjhKeW1nVDZ0OGNxNkZ0VlkreSsxVnBqdzFp?=
 =?utf-8?B?dVNBRWozK2k3WnM0RmkxY3lGM2VOTk0rWjdreEtTZnlBLytrY0RVL2dIWmxO?=
 =?utf-8?B?TTJtVVU4Uyt0MXFma1N5d0s0N1QwSHZCUytJWS9pTU1kcWtyRU9LeG4rL2dS?=
 =?utf-8?B?MzlrY0xiOG8zblU3RTJSNWQ5UW5SaURxM1Bud0tYZFZ1b3NIdWh1Q0J0czVQ?=
 =?utf-8?B?dFI1Y0wyQk9iclI2UGtUYThxd0VZZExjSWEyei9jNk05bGxkY1BSRm1UckpJ?=
 =?utf-8?B?emFMM1dTa0FyL3A0cHQzUXhhSStQa2JXcStTbmFhcmJWSVVEN0E0ZDRZNVpR?=
 =?utf-8?B?SnkwRm00b3p2d2k0T3ZJdlF4YUZwbFl0Y3pkcU1tN0l5dGRHSVUzdjBHbmQ2?=
 =?utf-8?B?cGRuVTNJV3hVTGNKSWdrSktPWDFadnprT2Z1NGJPTDgzcVhqb1lob3RiYWUz?=
 =?utf-8?B?c2JHZXJjMXpXL2tKK2hPTHM0cmNGZGd3R3RNMG85Wm1DWmtTY056a21VZXpU?=
 =?utf-8?B?eC9CTllwVE4xYnUxY1pzYTVsa0cyc3A2ZEJQTDZPeG8rWnNwcm1XMVNMWGY0?=
 =?utf-8?B?blZNQlV5a0F5dkgvc1g1SzdLbTZTeGdSa016RlEwZjRKNHkvb1JWQjJMK3hN?=
 =?utf-8?B?d0pTV3U5TWM4c3o0Z0xvQksrWDBOQ24vNDBPanFEYktGYTJOQ2NHbHZwZHZt?=
 =?utf-8?B?eDFJSktKMGlCbzNMekRnMXorNEZCQVAvRE9qVjlCSmwrUHNDQ1l6RG5peEd3?=
 =?utf-8?B?OTJXUGhxOEFrSkE4YlREK0c1c2g4ZitWekhYSDNadW5wTWp5Mi96RmZFbThu?=
 =?utf-8?B?dzdBdkRvUnVyeGFOU0drY3VQN2hlMEJjVnpJYmdPWHNJMnpyQzRBLzRCWGxY?=
 =?utf-8?B?VTN1eUw4a2NSUGlMcEl0eVdXTXhjYVorK0h5VFRxWGRTUy85MndXclpwLzQ5?=
 =?utf-8?B?b3E5OThxdHdubFR4VzZzTEVuNnhVS052M3B6SU4rQ0JFSnBMSVQ1bXpBMCtl?=
 =?utf-8?B?dXJjNXRWcnhQZ29hT1BmTEJZdGdCT0VYMCtCOEhDSkNneXcySk1abDNNNDNX?=
 =?utf-8?B?bUVZNUFPcFUzTG1rTU5xcHBjaitjaDd2R3RIRnZtU3puOVJaaXJ2ZE1rS0xj?=
 =?utf-8?B?UU9OZHkxZVJvVzczeFZrNzRZUVQ0R1ZBaGFvMEl5dWVnQ1luZGpHTjE4eGZU?=
 =?utf-8?B?VHRvWk82WXdTWHFJVVBtQ1lZSEtYTkcvMmdWZjhiYSt2YlRvdTJmclVjTFdN?=
 =?utf-8?Q?a3lkSyAmpOAaOZUMgCYC1npCQO+tndESIa8zggRq3wpK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bc7b13-5030-44d0-9fa6-08db7279f68b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:07:15.7175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QySkHDu2drmxvWWfxJa7eiHqWdQQP2EJT6Zj7J/TNA5N6PCGPeG/d9zSZUMl9H7js5xIzgA/k7gZB4UNF20xiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
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



On 6/20/23 20:51, Srinivasan Shanmugam wrote:
> Conform to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: else is not generally useful after a break or return
> 
> Expressions under 'else' branch in function 'dm_crtc_get_scanoutpos' are
> executed whenever the expression in 'if' is False. Otherwise, return
> from function occurs. Therefore, there is no need in 'else', and it has
> been removed.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 38 +++++++++----------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2446529c329a..a2048ffbbdb6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -264,32 +264,32 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
>   				  u32 *vbl, u32 *position)
>   {
>   	u32 v_blank_start, v_blank_end, h_position, v_position;
> +	struct amdgpu_crtc *acrtc = NULL;
>   
>   	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
>   		return -EINVAL;
> -	else {
> -		struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc];
> -
> -		if (acrtc->dm_irq_params.stream ==  NULL) {
> -			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
> -				  crtc);
> -			return 0;
> -		}
>   
> -		/*
> -		 * TODO rework base driver to use values directly.
> -		 * for now parse it back into reg-format
> -		 */
> -		dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
> -					 &v_blank_start,
> -					 &v_blank_end,
> -					 &h_position,
> -					 &v_position);
> +	acrtc = adev->mode_info.crtcs[crtc];
>   
> -		*position = v_position | (h_position << 16);
> -		*vbl = v_blank_start | (v_blank_end << 16);
> +	if (!acrtc->dm_irq_params.stream) {
> +		DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",
> +			  crtc);
> +		return 0;
>   	}
>   
> +	/*
> +	 * TODO rework base driver to use values directly.
> +	 * for now parse it back into reg-format
> +	 */
> +	dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
> +				 &v_blank_start,
> +				 &v_blank_end,
> +				 &h_position,
> +				 &v_position);
> +
> +	*position = v_position | (h_position << 16);
> +	*vbl = v_blank_start | (v_blank_end << 16);
> +
>   	return 0;
>   }
>   

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

