Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D517C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 14:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1C710E1F3;
	Thu, 16 May 2024 14:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vWZYO7/o";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317CD10E1F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 14:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADvTGousvHbXr2lpxAigZvfcN/3u0dRHK4qQQj8Zc9HO0eNjuxujXHn2c6TFx/dL8cq1Fj9ivMItxsojnB9XmllpnqQ+YFVtA7jZoHD46EdF8IdAjJfg+QytEIBIrWGjeuBqmtmTYJA7dS8zZcvi/0lxDQSNvkNvi77vO35jrJKR5JMhFznWBzVKWmVVz62P0C8Mb0QCjnz0h5Aj0Z3lch+IIgGincxKUEJRTKqx2KxikZqfPsSlYVNExutZhdBvHCBwbzmDQskJ1YfSMwsdCmFRnfwGlLDnJMCWni6/2tsQnLatpnjR3ZSx870n1VRLgmtjG5bzV2SZvryaorS6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KesyqtMrgZ2EPPEv9BN57PspuwY50Z5PyIioT71INvE=;
 b=LfaQioiDfKZmjXy+X7eTDVYAHOzC9tui9vi6S+6Fzv/x5k0iCmxVe05wYHrfiGVNo6yKd1LZtLmbNOW4SntnRaoZDvMw278StAGTp3QxZglI/nH+P0h7ZdvTihv90jg34cPzxSKMbUJXJuFqPI7YoTJrA2wiitrP4u1E6vgFtwwWbe/Cf+CXWr0NpPoT5UOue0oWV/Vkew5T9Li6UO1G0JWbjZCqq6kV8HP1v/GtVLyNSHVU1rFqev4mLTvK7PEhgLfkPYe0AM//Fw0a0xd7wJMXQ5erYkpNzvAn9V0nhWbyhVNpGHCken2MS4DDe4Y++FpTsG806ST3YoyN3qxnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KesyqtMrgZ2EPPEv9BN57PspuwY50Z5PyIioT71INvE=;
 b=vWZYO7/ofu1B2wy4/6p6EXuojvO2WosuGYNOEck7W+pO3mB4FuAnOOulRe9W7M4z05l/8fUpD5a/w6rwYrAo1tRCwL9rwb9Oplf026jeA+C8VztPALmGs4X7NCceH7SwsPnMLPQxiPDFwCIO/rCf+CfZ2TpzabEd9NkgMkDLDs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 14:43:36 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%4]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 14:43:35 +0000
Message-ID: <31165306-71d1-46a8-94ba-1ca435c7160e@amd.com>
Date: Thu, 16 May 2024 10:43:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: update vcn5 enc/dec capabilities
To: amd-gfx@lists.freedesktop.org
References: <20240515191954.2605211-1-ruijing.dong@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20240515191954.2605211-1-ruijing.dong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::20) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: ec35d00d-023a-4c75-ab00-08dc75b690fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b09LaldTa2FTMC9tM3pzeXRhYlUwejZXd0FDU3JkSXF5d2xqVHc5cE5Jc09a?=
 =?utf-8?B?RDFLYjNZeDNJV0xQRkJ4WklYZnh2djArcjkyYWFSTFlXRWFnTVhkNmZXcExO?=
 =?utf-8?B?Mmprb1FrY1VmelNzL1A1dWUrcGNlWWE2TnhYT2sxQTA4UlJUb3NESUJvM0la?=
 =?utf-8?B?R2FMZFVxeVlYRWNaMklQRytxQWtsZVlnSTVsOW5IRzVvaCszc1BFRFJtM0tq?=
 =?utf-8?B?NTAwSStYS2x1YkU0cmlpejNJUXkxUUtSZkQ1VDVpOWhteTZ0YlZIWnZyNGV3?=
 =?utf-8?B?b250KzhKTXdqSmRiaGN5TGNKVDJNd0NzTHcvYUdwSmJDUWtUT1dTQVhrR25Y?=
 =?utf-8?B?Z2JaUXplYkJNcmlLbERUVkYxNFNkVDQyeFBnRjRzT2hNTWxLaThaR1F1d3M3?=
 =?utf-8?B?czArZWxTdlFBclgxNmdPMUQyeWE0Wm8wRmpVbXFIT1dDaURjcTNEL2E0RHV4?=
 =?utf-8?B?T3p6NElUNmI0TDlFUHdML2laenJSTzgvOERzTE5jWTBCcVhrcjIrcEhVQ1dy?=
 =?utf-8?B?cWVkSzlkVU9ZUjhYb1FiYzVIUDBFa0JWN1ZZODdYd2tNM3c3aHpkS1pLMm13?=
 =?utf-8?B?NGJXMGttRTJ5T3dONmROUnNSK2V3cU9LM0FtRnh5bWtUVERuWTkvVFdqdWhM?=
 =?utf-8?B?RjRZR0RYVnYvR2FXckFEUlRVRDBlK05CNzhxdlZaRDZnenJ5a21JWVZYd1Rn?=
 =?utf-8?B?TVlqQ1B2eGxBVjFxd1RORllaVk1PaTVkdjM1ZCtUTSs5YzRyNW40NEoyWDNn?=
 =?utf-8?B?NG1yODBISGhIVkhqajF3eXRzbXBWWlZ4VFB5ZnFCVFIzREw1REZ0dEp2UURY?=
 =?utf-8?B?ZG5sV3dNOVNjN0JYcUZKa3I0UFZUcDBJQ0pjU3VOcVh4Q2RSazN4cXhnR2J2?=
 =?utf-8?B?UmN1SFdWUjUwcFBwYWlia0tObmozbGI1RjY0cVJPQVk4TkFsUDJBQThGOXQr?=
 =?utf-8?B?cFFGYjVFbnFPQUZkTGJtYmRTYVU3c0QvNmZXUk5OM25qZWkvUFo2SG5lanZL?=
 =?utf-8?B?MStJbW9SaTRFdFU4SFhpSEwybGdxQ05HLzhDUEdpdTEwMXdwSVkvczFlOHU2?=
 =?utf-8?B?L2dJNE4zOU8zS1laWWFEbmJCZERHWHBGZGd3YkhrY04rRFNKeE9WR0JJTC9Y?=
 =?utf-8?B?ZTZNT21CdGJ3SGFZaTRoZzM4QlRaalM5TTFwbzZkNmN2ZlM2dzhqaHUrWjlI?=
 =?utf-8?B?enFnRER1cVVYZkZwK09IMUlpUlN6d3N1SkV2UTRIQ05hekh6a0JvYjJtNWow?=
 =?utf-8?B?Ti9jUnlCSWFJcUZEMVhEOVVyU1VQeVFBKzdIeThrNktiem1nS2g5ZEZTeFlm?=
 =?utf-8?B?eDRzOFFmN0xmOEt2Tmg4ems5S2lOK1VZSmMwR2dXOS90OVpYSThOT2QvdHpP?=
 =?utf-8?B?M205ZVQwWmthRGtWODEyYUVFb082MUdqMGV4OUVhYUpyMVZocnRJa3lhM2dC?=
 =?utf-8?B?bkd3cFErc0FwRFUxTGRXUW1uSnZKV2crbjM5ZlFTc3BJV0tYVjBzYlV1ZzNa?=
 =?utf-8?B?UjJvYVdob2N4RUdMbDNvTHB6OTVOT2twdWx4UHNyc0dBbU1OeDBTZ2lXbTNk?=
 =?utf-8?B?eTJOSHhuZEVnMEFGeTNZT0pRenFDSXZidzhBYXhrekd2WktIMzlpVjZYeElR?=
 =?utf-8?B?OVRnYTFwL1RETEI2VDRBazQ0UlFXNUlvUFBTS3E0ejRrUlNScnpUTm5JekJJ?=
 =?utf-8?B?akJ5Mzc0bytXeDl3ZVBoMytGZ04zbHRjSnU4ZFB4YTBVNjhJeWxWVzRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0k2T1IrQmltc1IzZ2ZlVFBTUTdZR3ZMM0E4UnlyMG0ySVd3dzRLNmR3Sm5r?=
 =?utf-8?B?RG9TQkYxdzE2c0xJUFFzbXkvdTFaMC9nUThzbHN4S216QUg4d3ByWWpOeFFV?=
 =?utf-8?B?VnRiZGxNS0ErOUZNczJpbGNvdlk1dy9CRUFoaWFuNStwSldPNVFUWU5SVUhI?=
 =?utf-8?B?dnczR0tVRWRlY1grekpwbHVLcS9yclV3bnRsQ2hYMzI2TDJUUG5VZ0tTYXEy?=
 =?utf-8?B?NmVHY2lHMWpZNUY5WW1lN2hqMDgrN2JDMkRCM2c5ZkJEWDhuUDhOUTBqNkNT?=
 =?utf-8?B?eURnaUlHYzU3VENIU0tJTEJIcU5oN05SSC9YeVJqaS8xN1pOc1NHZmtNZ0hK?=
 =?utf-8?B?V0VkVFNsZ0RvSStkTkFTek8wTlpLRVNTWUZhZXk0K3ZrdHJ2TDVWbkR5dXE0?=
 =?utf-8?B?dVZjcjg0MXEzTGkrV1VDaHpydW9RSkxyU05UWkJEdmNwL0lHUE1vU0tWRUF6?=
 =?utf-8?B?Z09wWllIN2x5cnIzeVNlVFRNVXVyTFJ5NS8ramx5czE2VEl6UVJmRTNiQ3lS?=
 =?utf-8?B?eEN5VUpVV05sNXVmaUZqMkpGZkZwL0JpMEl6T2VGV2dDd3dXRjdBaDR2bGFH?=
 =?utf-8?B?Q0oxTUNzOHJWOWNqR05YUDBIOW9UNXZVWWhQRVdHTmhJWjFxS1lvRWRvdHlO?=
 =?utf-8?B?QUtGaC9wVk5WOTNCZllBd3ZjK1FOcEJVaTRDdTR2TjBoRElleGhWOE5kRVZ2?=
 =?utf-8?B?QSsyYUtidGNqczNXcTl3S0hJSmkzZzhRWjYyWnpyQXhHajFVTDNiU3lPcStJ?=
 =?utf-8?B?MDBRWmg1TGcyV3JjaDBrSHd0ci94bmRWeTZyQ1lKazgrUVhxMkxnMEUrNzN0?=
 =?utf-8?B?QmhvWGZUOUw0dGc3c2pubXNlVExGNTJLT3p3NUUvak9sTEk4ZEtSYmdER1lI?=
 =?utf-8?B?M3FQUWFzWTh3SlRhT0hndyt4UTZwQUZNZ056Y3RNdnRlSk53emJlSkdMOHVR?=
 =?utf-8?B?T3lwd0h0TVVReThRdUN1TUtsaGsrL0s4aGY1enJpTW82TmV0Vzd4bHlIQjdO?=
 =?utf-8?B?YUpWQzJRWkJSYytuM2tPWFJUTlp6cExPNVBDRExkSWU1MFo4NG9yVElBN0hI?=
 =?utf-8?B?eDBBTU0yQ3ZDUDY3aE9yRHhQTGVuLzgyRWQ2VytTMm1Ta3pPSzh2aFJTcTg3?=
 =?utf-8?B?elFZZjV4VzNTZUYycDRyd1VYTVlRWHlNN1Nrc0YzUFRiQlNPa0FiajhqTnZK?=
 =?utf-8?B?SmE0WEwrZVZ1S2IzSmduM1N0azBFbjBoQ0x2OGxod1dyOFFjMjEyZWR3UXpV?=
 =?utf-8?B?R2tzTzhjcnlveFNVdXZQMjRHM0w4dU1DbUcrdEQ0bEFOZ01xUDIwT21HRko2?=
 =?utf-8?B?RTRiY0s0dnJKSUt6Z1RDS29tUFNpdi9kcTIzWE9uTlhVZlI4ZjBxWDh6Vmdx?=
 =?utf-8?B?NWx0dzMyVUlrWXpxcldDYXhpSDBoaG51QlAzbmd3ZXV6cTJ1VXNTd1BQYUVZ?=
 =?utf-8?B?YUJjWHhCUmg0bm55WFlvdW1XZDlMNVpFZXJzdlpKalRvZGowUmdWU0xvNk1v?=
 =?utf-8?B?SDM0MmtST050ejRiNHRiNHZWZ1JjMlUxT0pLS3h4eUpIRklVLzh3VE01NDJR?=
 =?utf-8?B?S05aM3d1M3RUVnZKZzhGTU85UXFXU2lXZHFRY1BSQ0VaY0JWdnhIcEVINk9w?=
 =?utf-8?B?aURLWUlxUndwSEdlL3IxVnZhN21KZUxTRTZJWi82djFod0p0Q0VSRnFDcU5I?=
 =?utf-8?B?SmhUUmpsL0I4YjJ6aDFXeUxxdDJta3MzZGJJQ2tlRUc1dnFCNzFFdHVTWENO?=
 =?utf-8?B?NzB2Q2QxSUZNQUpaY2hsZFAxU1A5NDlyRVZ1ZC9LNU55L2pUaEVadFBFUTgw?=
 =?utf-8?B?Y3A2YzdiRzIwK3p3RmRmWlRZZlp0L0hGZUNKdHNUUHMwS2tNdytZVU83ZWtm?=
 =?utf-8?B?WTJubThNTXAzTlI5VE5GeHZINVhsTnBIU3lDMXl1M3ZSNWgxZTYxekQrakpw?=
 =?utf-8?B?aFYzTkNJNll2WXAwOFZSMk1EdVU2MFF3Rk9TWDBlRzR2MWJJR2gxWVZmcTh0?=
 =?utf-8?B?NG84cCsyUkMzNE1HMG13YnpyMXV0Wnh4TnNJWWZVdHFzL05HK0NZOTA4MzNa?=
 =?utf-8?B?dTk0c0ZYdEdzcE5QazAxK1AvNDdPYS9uVU1ETEJyRXREbHR5R2I2MHlObzly?=
 =?utf-8?Q?Bqs2lLyLQjjXNvpDv88Q5KaNa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec35d00d-023a-4c75-ab00-08dc75b690fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 14:43:35.8590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPi44a6Iym8BHFMn7qIzGABZOYeh2GAlazvUMt4UEquKmwA+al6Apj6phUQkC/fkR72wscsYU4KV4Vgmw6wU1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
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

Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

On 2024-05-15 15:19, Ruijing Dong wrote:
> Update the capabilities for supporting 8k encoding/decoding.
>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/soc24.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index b2b9e0f83bdf..d065649c7c78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -48,9 +48,9 @@
>   static const struct amd_ip_funcs soc24_common_ip_funcs;
>   
>   static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_encode_array_vcn0[] = {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 3840, 2160, 0)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 7680, 4320, 0)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 7680, 4320, 0)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
>   };
>   
>   static const struct amdgpu_video_codecs vcn_5_0_0_video_codecs_encode_vcn0 = {
> @@ -59,8 +59,8 @@ static const struct amdgpu_video_codecs vcn_5_0_0_video_codecs_encode_vcn0 = {
>   };
>   
>   static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_decode_array_vcn0[] = {
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2160, 52)},
> -	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4320, 183)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
> +	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>   	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
>   	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
>   	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
