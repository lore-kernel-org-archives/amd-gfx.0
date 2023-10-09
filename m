Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A46E81E18
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 22:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3A810E0F1;
	Mon,  9 Oct 2023 22:36:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743C710E0F1
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 22:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf9WvIXraEQoiie2QcOn41e6lcSNcZ5MwGWQ4Dki0/AtAOWbk7t4eNao21abZh9JhoErwoWcFzpdVW2CcJ2nMPhwrSd5zozhe7sR/n6mkbO+u6Ux/4XkUvS4E8bVDZ/mcGhDPJUDbCLAK04mRUCsDVrfVB1YyFQJGWBdri/t4yaN4Y4wj94pXPRhscf9kXwbHt2PewYj8QDfagI3iIKxzRtIuX99QdumH4bxbV2395ACCrkGVPzpSwt5ksMuJLm1g18KCK0ttRquWtvMGbNNfw4MNmEhVzmOdizNgA2v3/3kzZFQ2iDliCV6eeYpz5/nolkWQrypTLCoB49gOMEZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmLCzH6RFSvvKA6S5DfLI5jlvQCeYez2/JNXZqysWw0=;
 b=LgtBSQeAFoq4k9F2npLrZEN4A17W7VAAEhWHRbNZG1C5rxXdLdR17wAq4DQLtZVQ71Fe85sir8mhv/JU82nrvR95y+/rmUE456Fwx2BBL6Vr12w2gucuqMc1upV+D9cL12l7wkj+DjHxOM6XYjL0TFMpoRWivHpn2hpdoHrNdzTMrRI/9PIrtEHWzw27esS6N5TdHtZwpCRWVKvJyd38QtLNhyDF1sBUOVKTnehTVFXJiPcffZTGYXhSKYvgkj+nX/X2Et6lz18QJX04WQTpCutEEwsYzT6Lw76UpLqdq4Swt66HumuG+Gr1+XNZ4yiYB7ladP1JEHT0G+Q8UCoZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmLCzH6RFSvvKA6S5DfLI5jlvQCeYez2/JNXZqysWw0=;
 b=jdWRC8tSJ12Bu7epDcsgP27PoaBT6t/8HZUpmIr0vJjd7GYoWycJl5XA2REUVPygAqR2IpGe6Z5IcHSnCSVCsDFg9c6qfQzR9BzR/EsgPJjb7lkS41N3B8/zYZOLxg1xsGYm5Wr/Y7ViXMfCPPHHSfdz5Jb4cY3fgydk+WgkjQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 22:36:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 22:36:40 +0000
Message-ID: <56432038-4728-4dfb-b327-ea003a059907@amd.com>
Date: Mon, 9 Oct 2023 17:36:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Enable fast plane updates on DCN3.2 and
 above when state->allow_modeset = true
Content-Language: en-US
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231007054127.229441-1-tianci.yin@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231007054127.229441-1-tianci.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0185.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: f8609117-6692-4516-e722-08dbc91834bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6d3WgqZJxoxPrRrKOpMdplhNoj7VkPa8WFmBcePNlY3HoajXBmUZ/AW64znvOQB7NOGL7FvLS4lYX/u/H2PW5eER+J0/o7udmlgLC6ZScyn+Dq1aZ6LH4wkhGyheQAN40KVGbmaV/RDL3LkqAuyX95gV2BmlEta9BzqHlQcy7TRjZdV8GDpa3zjsSTdV7FnUWwYc0iqKnTxs1REIHnMk9Btbxg8oQUVVgJ2INzhnFcbIZit+NMNhpRiwFDzQMJW9gs1OktqP87p2yCF39lFaxbtjp4OMdL6YriVAj+7RlRjoaiTY7NoYH+g6+nnwRMBjnbIPcGY2SPeMM79tO6bfFUKjbAeQxKMCpp167Xk54MRjl6eg4SSXHA/VLktBQGv+FeLXBFI9/M7HyhB3dk2EQYRIx6KCVRs0wIgrwU55mfFKcwfkN1Ss+RI5OrB1U+t72M4alhE6mKXUUqquhZoJMb0Q9cLb3z9tRR8j1DuskjSt1Q9Uc4DFK5+3w5xt94NjcrihRqquORpaxJww1ZuY+cpy8Gdn8UeksgbNoMofjjjyjKq58BI7sM7yiqy1qFuRMqJZ39H+wOd07eChR0ABm4W00qMXvHUKDWp4im8OphQI0UkqnBEzeTmNYbjhfAiROUW3osZkLNTbscLqneJSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(53546011)(66476007)(2616005)(6506007)(66556008)(26005)(54906003)(316002)(66946007)(6512007)(8936002)(4326008)(6666004)(8676002)(44832011)(6486002)(2906002)(478600001)(15650500001)(41300700001)(5660300002)(83380400001)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG02MXFINHNGc1VFck0vT052OXV1QThFKy9aSUUxUEtMQmhNV0tlclFsYVJJ?=
 =?utf-8?B?R3dkUmVBOVNBaDd4SWxDYUh6cWV4WVQ4bHo4QldBL2RPNm0xTzAycC9NNDRh?=
 =?utf-8?B?ZjlkRHdlK3BIdHcvTUc0UGhlZEZIOWFtZmVsUEU0RXBmZDYyYjlwMnJ2cDVF?=
 =?utf-8?B?bnlMMjd2ZFRnT3JSZUlqY3RzYVpuYmVwb2FsUytWbTI1SE9BanVOQWxTSGpP?=
 =?utf-8?B?OVFGdkI3WFIyY0E0R285SStyR1hKNlV2MStZSGtxZ3oyRHEwTjIzVEhkVFY3?=
 =?utf-8?B?OFpLcUZSdDBMOFRLYkJtWUJ5MUNjS0YwMjVQOUhFaURsK2NVeG5BdldoKzRS?=
 =?utf-8?B?WnVKNnNrNnBHdytPeExVQ3I5ZlVLZjhnZmZJUDZlanRIZ2FZRnVYMUN0U09s?=
 =?utf-8?B?SGVUZUFITUwxWnJZbTdoR3VVb0RPckFNSDlKOFg5NWZEREJGc2FCM3A2dGRK?=
 =?utf-8?B?Vkc3K3BJVjZKa2NsaHpPanNlMXdkcmp2YVhVNnhDaWFnOFdVQUZ6UFRLOHpD?=
 =?utf-8?B?c0Y3bDNRbWF0Ty8rNlltUnJxTnN3RUpreWFnRVRmUjZBSEdHVnVseksvSTJW?=
 =?utf-8?B?S2lYR0dGUTF0WGJrM2VsUlRUQzQyZjk0WHZBNmFDTTdTdW80STFOL1EyVE81?=
 =?utf-8?B?d05IeTZxMkdGVEU3ZnNYTnlHTTFYNXRjd28zYUxGYjlBZDU4RGpkWG9NUWRY?=
 =?utf-8?B?cTV1aGFROGZYRDgxbHFVLzRvZC8wMTBCcm1aL2FDaXBVSGhsd2EzRFZSd3Z4?=
 =?utf-8?B?bC9QeFliMWI3ZCtmR2ozV2YyQTlMRE9LeWFYQ1ZYdUwvelZ4RkZHQWxGNHNp?=
 =?utf-8?B?Y0VDR1Q4TVJ3UThmd0NLSW9kZ3Irc1BYdFcxS3dOWnlWVTJreC9QS09Wa09n?=
 =?utf-8?B?VTVRK0hoRDFDTVdyVHdVb2k5UDYwOVpXZ3ZqT0dTMG94cnZyRUJuZ0JCRnV0?=
 =?utf-8?B?SGxNMS9YeHQ5cysvVTgwOTlFWnlLMkY5K1cvRlR2QWlhZ2FVdXZnNHA2cjRs?=
 =?utf-8?B?TzRRei9oZmJ0SGtGaWQ5dC9CTXpMWjU0ZHlxMlY4T2dTTk4vL0x5K1RqeGZQ?=
 =?utf-8?B?eDYvUEY0eFdXSWQzL2kvMEQ3SkNrMUJIZ1lPcmpyNEErV2tXVkliZllTYVZi?=
 =?utf-8?B?amEwT3F3aStyOXFQSkNvL2ZRMWJHMUJyUnJVTmI4TDJrTFhFUjVFSmVxZWlR?=
 =?utf-8?B?bzg2ejlOR1BkaVNYZExHK2tFU0FlOUlyT1FTTUNla01FSVZ3ZGszNFZ4aS8y?=
 =?utf-8?B?dm5tSUlwVldoRDY3RmF6emJNenZsWDJLbWM2dytwTmdQR0REMkdwTzNMamQr?=
 =?utf-8?B?MEZwb3pQdENoVjgvZXdBanRIaEYrM1lDekRsRmsyS1RCRlVCQThRK1lDM2hJ?=
 =?utf-8?B?RXJOOWNnZ1hsSlkxN2loN1dXdjZlZHd3ajdDdnlzcHhBbnFyelI5WXdwZmNy?=
 =?utf-8?B?dXdpd3N1VGJqaVVuWCtvbEpBeG1xMkRNVDQrUGpyS3IydHlONDFMU0tsVHZi?=
 =?utf-8?B?MnFpbGNKZWFkL0krV2JPWW5oR2lPMlV0dHRQVjg1WDhBbHJxZTdqdG1DZENm?=
 =?utf-8?B?T3JUSjExNTJJRlRnM3NEamMzWitqSy9NNFh3R0ROMHVFaDhhbUplUndpbExU?=
 =?utf-8?B?N1M1dXAxRVBEOVlscU1uOUVheldCMWdwVnJMMkNtR2c2aEVXRE5lZUtVWVpQ?=
 =?utf-8?B?UTdiWll5Tm83VGpaTzRZWkxiL0N6K24wTDhaRnVDeFhBTDdTQWZUR0ZSSk5M?=
 =?utf-8?B?cjdON2ZsY1FDN2oraEM4OHpGekQvdE1oZThKU1dhUzhVZEJ2clBrN2ZXR2N0?=
 =?utf-8?B?UWovVGt0R0E3RE1FMFd6Y1ZFVWJRVVNiRDR1d0hweWg3Z1NaTXdTNlVoU3B6?=
 =?utf-8?B?cW9OdXdsbStpdlpFTlZJOXJ4dk5PcEtsT3dqdDhHOStodU5xM2w3WDhHYWFi?=
 =?utf-8?B?NmRJS01wQStMelhZNENmTVovN05qK21zR3ZXeS9Wb0JCSFZJOFd2b1Q1dUxR?=
 =?utf-8?B?T21VZ2dKYm9CQW92bGpMMXdQaTNwNHBnWnZtY0ZxWG45ZnJIbUhKbGJ0bVdt?=
 =?utf-8?B?bE9QaG85c3A1d0dXN25pNVVCWkNWSllWNEo1elVXdlptZWhPZnQzWmhCRHNQ?=
 =?utf-8?Q?+bzFEKMXu0/1lO4+z1Q1vKymh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8609117-6692-4516-e722-08dbc91834bc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:36:40.6001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JpjuDN/6FwW2zBKJlYuJ2W4vFaXCiwdZF2ceNUy5eQxyIwagpgLDSNE/w2IpEo0d1qBgQ1XN7JBXTpsdwGDrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>,
 Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/7/2023 00:41, Tianci Yin wrote:
> From: tiancyin <tianci.yin@amd.com>
> 
> [why]
> When cursor moves across screen boarder, lag cursor observed,
> since subvp settings need to sync up with vblank, that cause
> cursor updates being delayed.
> 
> [how]
> Enable fast plane updates on DCN3.2 to fix it.
> 
> Signed-off-by: tiancyin <tianci.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c21726bdbca2..25a0bd314fe5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9879,6 +9879,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
>   	struct drm_plane *other;
>   	struct drm_plane_state *old_other_state, *new_other_state;
>   	struct drm_crtc_state *new_crtc_state;
> +	struct amdgpu_device *adev = drm_to_adev(plane->dev);
>   	int i;
>   
>   	/*
> @@ -9886,7 +9887,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
>   	 * enough to determine when we need to reset all the planes on
>   	 * the stream.
>   	 */
> -	if (state->allow_modeset)
> +	if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && state->allow_modeset)
>   		return true;
>   
>   	/* Exit early if we know that we're adding or removing the plane. */

The comment associated with this says that this hack should go when 
there are sufficient checks.

If there are enough checks for DCN3.2, isn't it likely there are enough 
for earlier products too?  None of the rest of the code checks a 
specific IP version.

Maybe the whole commit/block should go?

