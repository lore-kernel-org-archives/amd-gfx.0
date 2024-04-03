Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF697C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 08:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBC411275F;
	Wed,  3 Apr 2024 08:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jwd/Cjfl";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2116.outbound.protection.outlook.com [40.107.93.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3C3112764
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 08:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbW++s6V3/G2eL8GrnWz/qdhTbEJNjM1izZctCtPiP5vFd+Vkn+D/z6QsXSrNWB5eILuuYjiYOSpWV9L+TF1Or68nqIOt0Dl/jERu6q1h2+YCMS2BylqRpB2cgV+2+iLdyiK4Zk4ca70TzRUchRFsd8dQnxqb4glDDa3/vkTnWCYMJIMcwWrTXUAax1V+0gwcZ+Nxs9+fqi1mdlBfRZTR7hkwrYKhabIIEVhcVOxy8IvE1F10IuC90nBbYygVMwjdmjw5pY+gH7+9uejhYiXrHHIdtX5yNy5SOI0iYwmEbMbPuuOUEo/ClCgFTOA1TGCPSyr1/8OmEX1O1V6FWYa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3beXELyGTJ+smUy5+Lo5GWP6lJ6oPPMT9x8e9A72CqY=;
 b=Eg62M8Vv00zh0TLafKXK/St+wCn1dEdSXp5gnSz6t21v6IV7GtZ8TVyYZMzAUC+TkWR5LBEOXjDGsu04iB4CUgxP1LPL3MbIgh1zNLFW4C7kcL+bsRRlHR3UTTTb0jHkP0P0DV6F78mZaU3ftDYkR79pQ5plEUMjmNYdeK6sWzedDTUepXxtKBeeO20bTvUTrlNezXF2iM4HTZtqaxCmjiIrC5B5RrjUKBokgz31P/YXxVzOiYDPEBHnVpFsWv+EPpY0WdiniV/gZMC7HzGJynsFsAz2yRlRFbj5jyv31/hNsy29T5WSTLRHqoXZ6qkzwalKuCUOE0Dj4myrFQmSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3beXELyGTJ+smUy5+Lo5GWP6lJ6oPPMT9x8e9A72CqY=;
 b=jwd/CjflqeX8iAf+upeJYD+Ouv5uavGIa/RcyWS2E3/imLs0Wpif4eR3ieDb/Ja+9F/EwP9H1WanSglMXpyTeA48DQdj7y5NErZkPpOJLUjFhNUKcc8HoPIxoXq0tKHj1bimLiQcu1oBVADwuf5JJF+lpR7zoRXZmSp2cXQMWfM=
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 08:00:33 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::3f8e:6745:6de7:12b3]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::3f8e:6745:6de7:12b3%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 08:00:33 +0000
Message-ID: <b57f5ebc-8739-45fb-9be0-b105acf7bd4a@amd.com>
Date: Wed, 3 Apr 2024 16:00:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add missing parameter desc in
 dc_commit_streams
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Joshua Aberback <joshua.aberback@amd.com>, 
 Roman Li <roman.li@amd.com>
References: <20240401135031.1406290-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240401135031.1406290-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SA3PR12MB8812:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GazJkfwiF/tqO0NkKfvQx06+pBKugLOha9032nBPIKq19wNiGlH3j5OprztLAxic7Na0uBdG1uanyx8J8YEzyQ88WfzMFB6QR91wxGxVT5+IsKXN+7BTEUvBpmEIH/JpPUazDJzwXTDAVdLl2lNWsPnXtbo5uzIPnDTKgOS5LxZo7rrHIBGKlJQ/nC1+cB1WIVCHEf/m0ZcIYwKO10FDsPLmM+y9pUbQhjjQ96v2CLcSJaZAza8cyMbr5ff18P8ABvkSQHxGG09LT2G7TNIub4cHQ0rywPeDpovUlmt+x4c6oGEPt+Zm0eqyGkWenBnZUL+hXmh0PDwMEH43vRKxgKhD5MgLzItJF0iV2nMBYHbtNeO5C3GoZ8pzo4Vsoyc4wWvjHwKJymqiMemIT8JjXLGDGV1V1J7kq3TO9E8+jDoe32oloYj83dNqXK95uMgE0vDtIzYiu91VlJbN93ItNVYMYzRey6I6oTy5/ctWGJxL0JNqbwTqXN9PGCASsJ/MQfdLRerDV/2AUIiD0JrWK7ZmGdkNvqHXHqZdd9D7Oxavcbv+rpBzCz89JKva3CuYfGtxlJxuZKDKtFpeGP3y1kGR3nRTdhZ52K5Fskj2fwOuFPwAFgvQ9BjBK36DaVhTqNGZkifrBz896f0zNjigQzKu8Vo4IQjkIyFRAIqOUDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkU1N0Nmd241R2ZKamVaMVg4SDdoQmR1VVFnSVRGOGFPYjZWNEVUd1VVSjFz?=
 =?utf-8?B?MUJOYWRSaEphbVNybW5oTTlBbzJQanFuRmRwQzMxaVhOOCtkVzdsaUc3dGM1?=
 =?utf-8?B?SnFCREcwUTI3OVVKNkcwRzRSbHV6TldZL0Y3dXh6ZDlVOElMY3lWMkxpczJD?=
 =?utf-8?B?QlBrUFlKdHFiVWlwV2dTZmlkRDZGM1hJczZaY1ROcTI0Q2pEUFZ5VTNhTkZs?=
 =?utf-8?B?M2xQVlR3T1p6NDM0YnY2L0RrL2lmS0hBTlMxeWRrdGRmbHJLTjhMcWZOU090?=
 =?utf-8?B?Y2IzdnhIUlBvQW5qbCtjeXl3SklnS3RqMFJvcWZwK1JDb0g2NTVicWYvUVNz?=
 =?utf-8?B?RGF2amEyb1I2WVkrd0x4aG1SL3hpME91NzhFZjM3dHBvMFlYTno2NkVNcjNB?=
 =?utf-8?B?NFpwQ1I0K3hEYkg2ZTNGdzVjNGZVTWxVbTRNdlBMRUVBSDh2WWFtZkxpc2lZ?=
 =?utf-8?B?ajIyTmR6T0dLNlZBZm1ObVJnVUxkNW96NEhkSEFjejAzaG83OFhXb3VWMlVL?=
 =?utf-8?B?K1VORmp2d1pOUWwzVktIUXpKV0pnL0JyVjc3Skw2KytzT0lQV3dITnVBZG52?=
 =?utf-8?B?ejN2bkxaVnJRdmxYMUxPcEJaaGF5c3pZTThQODY3M1hnNTZKVkVhZDdnT2NI?=
 =?utf-8?B?RDlaaHpSaGpQRnorUmxVOVZDdGVVYzdkblllQmk3YkIzblg0K1UzKysxQ29B?=
 =?utf-8?B?eEthNysrTE5XMTBkdS9vYVFOZkU0cUd0S1M2Umd4Y1RUOUs1RGxoeG9GV0ZC?=
 =?utf-8?B?cmFRVm5UdVY0Z1lEd0ZzL2liMldDTmFhMHl0NFpoTDdSK0VKSE5NaUR5cGcy?=
 =?utf-8?B?bEo4WTRyK1QyWjhGTDZiR1pKNW5TUDhtRWhLcTFKNFhZT0I3MW5oM0xJVEN6?=
 =?utf-8?B?VjZUSFFlN3cxbnZKaXBXcDRiMkpLUDh2YURDMXRXc2xlSTRXUmJHYTBTdkty?=
 =?utf-8?B?ckp2bllZVkw2cy9PQ2dFaWdtMkRTeEpBNVN4S2ZwTXhiU2M1YzBwVm1uZUtN?=
 =?utf-8?B?NzVZRDJSUThycDJ6OUEzTy93bDRQcEVxNjVFd3ZjbWFieUFwdUpEUFFUYTJG?=
 =?utf-8?B?WkhiMVR3blBEcFRSWmZ4T0ZQK0d4aldjbjg4dzdFbGg3VlNBVmFKVnF2bHlZ?=
 =?utf-8?B?RmEveDQ5dkVOdDZrU0x6UXcyblhyZkpGNldDVWZYQkNkRWFadk1wYWM4K202?=
 =?utf-8?B?MWZKVnVRS2xyMzM0Y2duaGY2bnJ1VDRzbHFid1RiUVRUQmRXbU0yb3V6bGdr?=
 =?utf-8?B?clFmaWRqZTVtL1A2QUg2bzBiTXM5MEg1RlRNbkRMRW1jUkJBWnhGSVFuS3Vz?=
 =?utf-8?B?U2tkZm9PenlPQzZldGczOTB6czhBY3k2c3lpb0VaOTd3MDJiQUNiemxTM3J2?=
 =?utf-8?B?am9QODFWQmpFMkdiWVI0ZFhKaUVpSEp3akl5clF1OFBSeG44SG5KbkJkc1Zx?=
 =?utf-8?B?MDAxY2ovWE9NQ3R6bmg1cTRIRlpXSGk2VG14QXdXQnNaSkRYcWdBcGhTdmhN?=
 =?utf-8?B?bWNSaGMraUdGbVRPTW85dEt3clBhakMvcCtKaFBscmpsSEVFaTF3S3JscmMr?=
 =?utf-8?B?Ulp3bk5NUTFwb0dmczN6WlluSGNvaGVNNHk3ME8xU3FOUllkRy9TZjNUM2l3?=
 =?utf-8?B?eFVTYW8zMmJ4RHNocTZ2MVFMN25xOFdKRW12d3VHdFFYcVE5Q2xTdE5teGNN?=
 =?utf-8?B?OWdGNktjZ0kyWGVaWE54RmZ5TEVzZk1xV2thSGJ4V1g4eUlwbXR4RnliZS9n?=
 =?utf-8?B?OW5pZUJCbTE3aFg2c1J0enpaREowQ1U4czVEbWk0ZkNJSEZWdlVab3FBZkVp?=
 =?utf-8?B?M05KSUZkTi9YL2NKaGFtR0g5RHhmczZOMFNOeXg4MTRmNjRPMkdYQVQ0UExL?=
 =?utf-8?B?SlV5Si84dGtGZlV5Q3puWExYUlk2Z2J0Mm9LL1B0VFZzdWJ2VWNLTGR0aklU?=
 =?utf-8?B?WWVUeXlCdU1ZQ3N0dFJ2bGVrbEdsK1d3a1Y1d08xWjlpdnZmN0xuZ1B2Y3Fm?=
 =?utf-8?B?ZExJMnpmVHZIMWp5cWdLY3ZwcEZJODhGbUlEZXVyaEtaMUl2ZGJIVXZYVjFp?=
 =?utf-8?B?cGFwMTI1QjlxY0ZFbFJvSktyQ00vdVZSd3ZhcDU2bW12b0JYRWxsTFE2UXVl?=
 =?utf-8?Q?9d0xdztNc7BdKwc2U0vEYNLqr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce624781-4dfb-422c-ed52-08dc53b4233f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 08:00:33.3316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tw4eWBrHiYFWVvVtwFgxR6sixapp7Cl/XrCOMgZXigHQhZjk2kJhcGHZ1O+NUXQUfLXiT9QWgAUOrdVNR/8J/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 4/1/2024 9:50 PM, Srinivasan Shanmugam wrote:
> This commit removes the lines that describe the 'streams'
> and 'stream_count' parameters and adds a line to describe the 'params'
> parameter, which was missing from the original comment block.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2138: warning: Function parameter or member 'params' not described in 'dc_commit_streams'
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2138: warning: Excess function parameter 'streams' description in 'dc_commit_streams'
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2138: warning: Excess function parameter 'stream_count' description in 'dc_commit_streams'
>
> Fixes: 515023b2ce5f ("drm/amd/display: Add handling for DC power mode")
> Cc: Joshua Aberback <joshua.aberback@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 5a93278fa246..0ffa79d83bc7 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2125,8 +2125,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
>    * dc_commit_streams - Commit current stream state
>    *
>    * @dc: DC object with the commit state to be configured in the hardware
> - * @streams: Array with a list of stream state
> - * @stream_count: Total of streams
> + * @params: Parameters for the commit, including the streams to be committed
>    *
>    * Function responsible for commit streams change to the hardware.
>    *
