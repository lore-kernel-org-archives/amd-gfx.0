Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1B6C83F1B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 06:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F17F10E6B0;
	Thu, 17 Jul 2025 06:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h0vZuWzu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD5310E6B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 06:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzreZTeGQCkCPxUOxsoijyAEMauv9wgtUWF80pdZvfpmfXRsuMxv5rPSJqcczkk8OBvmQI2wD80BEZ2j8TR8h1WfJ/x64Xudy51F63Cp2wJvIsNZQQx2KiGrto7AvISQjswZDD9sMxHEBVWK2aLOSnvRuWjDGUvcDm8v7GV7ZujyLxTkR0X7MhyOlBSOwCXOj6FgJwQQFlvBq+wb3QVI2Agu2PBG7zdEJtEVMJSzIft8//mcopZzBg9Q+WuVa6f5o/Rtxzl+aXmAflO60CZSF/2nlD6uQCthmlpAzz96bm/noZXRzseTA+xM7z4NbodIPYULt9TeQZN9CxNcJMsUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2tqWY0mYp70DpqQCHL/5fUMpn9a9mnnZvwuiiFzIDg=;
 b=yDU68V/V16HIBy0XdvTzjOxK2R24JMYdpxOQCIFt1Q0NsQraY9WMT2+B/+iVn87IwZ49B/VSN5PzoTRUXuKR05dpuajsxNXH1YrSS+/JKtC6ck+YW/GHMhX1G6Ey6PlM7Lb8eQy797E3Ae1rAqE71thRcN1Lg3BuDDgCuX1kw6TvtGhQxA8m08JprdqJ8S0GFnSztBmtwM0dlRFGneS3eyS9MBZM2iV8+5VrtJrT/t4BPRQ5yGgkEyxjcdccZ9j62WoVDVtktpuLchLZNSzfCQjhwlvVRhNSmbM6i/qk4DOp3ZBVYA9L0B41eKPXc+atqRF6BW046fNvsiA3WFiB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2tqWY0mYp70DpqQCHL/5fUMpn9a9mnnZvwuiiFzIDg=;
 b=h0vZuWzuDRXEtQzv3LjEJ7SBCpnSe1VNxnd5WyRY0Z+Wybf+VyirFZSnUbcjOucW5Zk88EZtFFMw+z0mmlM5XAxKs4iI5PqqEl/yP3j321pJUWM2dlgq4e3loGdjx8b6wzf8mdCm6zM87aoeBmDrCgqHuKaFFbgdMHeXdc7t0U8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 17 Jul
 2025 06:36:45 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8880.021; Thu, 17 Jul 2025
 06:36:45 +0000
Message-ID: <97232757-8c0a-45b7-af2e-d61e0622cd73@amd.com>
Date: Thu, 17 Jul 2025 12:06:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/jpeg: clean up reset type handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250715160051.533747-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250715160051.533747-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::20) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: a93bf9f5-e4ed-40df-07c8-08ddc4fc4c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXRoVmRtUmdYOHozU21MVlVRTmxSYkRIYkNpa3EyaWdVTzQ1Z3lPdDFweVRE?=
 =?utf-8?B?K3BlV3RxTmhNVHArZDhKSXFjWllyWkJGT1Q3SW9INmxxMXpZa0d6QjdMTlQy?=
 =?utf-8?B?ZUVyYWFTbXVacWdsZGtoK1JwTmNmR0RXUzJ4R0VIbU9vNXJQV2dUb2YrWUJm?=
 =?utf-8?B?NkdDbnZuc0dINVVrcEN5R3dtOFhpUzU4VCtMT2JwMkw4YWdoL0xTZktDSzlx?=
 =?utf-8?B?U0EwNnk3R1dQN28xb1dBbnZUYXpSa3RUTDVVSThkUkdNR25KRy9JdXAvcDFI?=
 =?utf-8?B?aXZhcG9qLzRRdmYyVnVWTklPSGxmdWs0Rjh3TGQyai92b2NPbVM0eUliNFlV?=
 =?utf-8?B?S212MWllSlRad3lDVnEwWUl2R0w1R2g0YUNONk5EQkRLRWVZUTVkYTM4Q3dJ?=
 =?utf-8?B?M09aYllFRzhmemxJMmZRTHRNUHE1OTJBNmlFamo3VUpXUEEzMVZXLzFpUDc4?=
 =?utf-8?B?QU51Sk9ZY3VhbzFNbjhPcjJxd25ISTNHc09nLzM2RXZvUHFiZm9nTnhia2h1?=
 =?utf-8?B?dGZyTEZRbzlGa0c3SlVpQkxJa3o0Q25XWEQ0ZVZVVEl6YUdkdVpCQ2x3SXFO?=
 =?utf-8?B?bisyMm1NaW1Mc25rZmI1ZkFFUmE3VUh4a0c3clpwdUh0b0JGT1I1c1drUE51?=
 =?utf-8?B?OThCWlJBRnlmVDVFLzc1UnVBTnRIcTVpY1dJY2g4TmlrOWhlT0NKTmhYVnhu?=
 =?utf-8?B?cmprazFETWJyRy9vVnFIb0Zldkk0bGFNRkpuckdyTUVWanIyNVRXWW5zdmZH?=
 =?utf-8?B?ejJ4eEVSaS9IVHBJRG5HWitLb0Y1bTIxaU1SWXRTQmYwYnFuQVBUcG1HQlND?=
 =?utf-8?B?Ump1ZzhwTEQwZHFWdGkzZVNhVklRMEpDQ1Axd0NaU3BhTFdpWUtaWVkyeW1Q?=
 =?utf-8?B?aHhQRXZJcFJPUU9RdkdWMmoyQnZNOG05K0hWZWRHTExwanRJZjVsemdVT1lV?=
 =?utf-8?B?eHFpSUpWZHNldTRabkNsdzl4c3ord1E3Q3dQRzJIUzNWZzYreDg5VE9HUW1Z?=
 =?utf-8?B?RkVpSjNiOTJ4UDA1S3l2ejR3NnNyZklTMG1hTm1XMkY0TFJob0pHNC81OURj?=
 =?utf-8?B?UlhWWFBIVDF3RnVRdTRFeE52UVJ5QTF4bFRzS0tMVVZDeTBNUGdGRFVXbHQ1?=
 =?utf-8?B?NUxTVmVsc3N5Si9jVlhtS2NjWVAyRk04Q3N1SjNZYUl5d1hLR1RzYnRkM2VT?=
 =?utf-8?B?RkJqcUtsODE1M2pOdzh4SG1BTHZIanVOWEduMGVyK3UzNUwyRzUvSy9YZ3U2?=
 =?utf-8?B?UHBQZDdsc1JzekZDNUx3QW1kUFhWdXlLblF4VVczbFk2UmxKY3dpQUwyNkVl?=
 =?utf-8?B?TWhYU21YNCt1bFluL3U0dEM2NEJQOGZxNlNabXBPSm81RG1ib2RaZjJBUkNX?=
 =?utf-8?B?ZXpZRDMzUWhvd2dhSGhpUTFsQU1QWEdQMURPQi9JNjluTWorMVBMK3NvTWh2?=
 =?utf-8?B?RFBISDVIOVFoYlliZ3pJRVVzR1g3a0pGck1XanhJZVJPNHZZR0IvZXdodVFx?=
 =?utf-8?B?anhjbkxqSWZIS1Avc21YcHZKZWUyTXY0RzVDUTlnS1FlK0pQajJ6WjcwS0py?=
 =?utf-8?B?d25wbWRTeTNLZjZOYU0xWEdabzFqdUVHK1ExK2RhY2lBQldsb25OTDFyai9a?=
 =?utf-8?B?eVFQSmJ1SWRvYndvb0lvSDdNT2lNWmM5MGRoRTMxaXhzVFM3YUV4VXpVUVY0?=
 =?utf-8?B?WElPTW9SbFowUWtJcWFzZWM5b1I3TGh6b2tkN1FWRDJKdDh5UzI0OEd2MUE5?=
 =?utf-8?B?ckZoKzFKUFJNWStnNUk3KzJWVGpHWlJEMG5kNmdIL00rMlFzZEpSTE1IZEpp?=
 =?utf-8?B?QTUxNGYySjFrckZFQi9MOERWeFBlUjJkS09UL0g5NzRzQlRpTkhJREsrUVZW?=
 =?utf-8?B?dEZORi9iZG1SZTR0ZWxBR0dqaTNXTzRPc2QrVDJOVDRhajVlSDJ5bW1aaHJy?=
 =?utf-8?Q?dUlENFR64Fo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW5pbWJXeDdsbE5rUGFYci82LzhPREZ6b1VUaTFGM3F2Y1U2VFVMczFiME5D?=
 =?utf-8?B?eDFESlNybVVtQUZBRzlsK1pvNkhhM2dGT3hhZWp4a012dGtiTXhrSUhuNlNY?=
 =?utf-8?B?NkZnMmhOak9zUWpDOG1QS0x6OTVWZFRLMCtVVWdTSWtpQ2sraVJ1RUVEazRR?=
 =?utf-8?B?ZXp4RG0ydVJqSklwWTRiRGRwWUZCa1RuL0VqWG00L3JJSlNFVjU3TG5XdGwx?=
 =?utf-8?B?ZU9BVHcrRDA5ZmU1K056emIrTWJTNTB0dGoybFdJbTMzU09pWkt4UktFSk9S?=
 =?utf-8?B?dEF6UFR4SGVpZDBtdWhtQm1Pc2JmRFZzNVBnbEF5Q3VPcXhkRHFzc1pCMkJY?=
 =?utf-8?B?cjR0c1MxWFIrcVBhektmeFJmNDBVKy9ESnJwMTNtOE1Wcms4bHlHWVp3NkdG?=
 =?utf-8?B?ODdMeDJwUFdJOU8vcFZUdXo0YW4zaVhOM3p2d1FGaEZxbzF5NVM5MWc4aURj?=
 =?utf-8?B?YkRjWHpTMm5OSHBIWWp2TGUrMU1mZnFnZVZ6QlM4ckVuUmg3U2luZTBKcFIy?=
 =?utf-8?B?YVk0d1hyOG9oQkhiSzBwSCt5TXlpSTZhVm13VkozQWFkMG1rZTN3RTBIOSto?=
 =?utf-8?B?ZXB3Um4rRDVEQmhUb3U0NitBeXVodG5DSDZZcGFGTnh3azdQRytqVVp5aHYz?=
 =?utf-8?B?NERsSGlSRTA5RVV2dG9KK2VyVGZsQTNLTENWODk0b3k3THJwdDlOdVZjYng2?=
 =?utf-8?B?WXF4TWNZOXFENVg3Rnd2RlZpbDVHV1ROWFFtSVBQU3Z6UzZBalJrT3BCTFF3?=
 =?utf-8?B?VnZGN1EwQmF3Q0crZ0NhSDRvMzRXdlpJT0hlVnRUb0ZqenU1T1VFZ0dUODZ0?=
 =?utf-8?B?bnhMSk9VRloyL2FxY1Uxa3hvdXZXbm5wbjgwVmlkbXdoMXYzWjlzVVp1ekJ6?=
 =?utf-8?B?Wk41V2syVUpURlJKQm9YZFZZcFd0eExJQ0VYTDNqOWJlKzRCNWdFNmhjUGM1?=
 =?utf-8?B?bUVOT3lPTGVTWFg5QitjNTdmTHBWUXQwSDV5MDQ3cGREVWg5ZlphL1VROUUw?=
 =?utf-8?B?emgxeDFQeDE2MmJ2dldFNFRlU0lOWmtSWWJuSXB5b0pFRzV3U1c1cTk0alhY?=
 =?utf-8?B?ZkNFNWw2Zm5BQ0g2UkRnWTZQTlM2bEdGT1pjbjQwUFArS3FzR1dYZFhmZGE0?=
 =?utf-8?B?Ty9KYnRQYjhETnEyT3JIRzlLbW91R1ZJY3JjeFpNUUQwZy82VDlZVWhLU2RS?=
 =?utf-8?B?U2U1cVliMVVzRFJlaU9VNHZ6NFJzSk5CbUdCUFBzMkk2bmV4WnJ1Wk13UXNm?=
 =?utf-8?B?c0ZXOURBUnU5QmhtdDZTZnNSeFRBZ0srYXNCNTBQZ2pObUY1STBBQzhYR25Q?=
 =?utf-8?B?Z2w5NW1kMzRCZEdCZ1RiTjA5UzErOGJVaC8zRzQwVUJXQ0ZGcUFWcmtoREhV?=
 =?utf-8?B?dXdwT3poVkxhb0NUelAwQWpwY3d0R2NaNHJzNXV6OE5ETjlpRWpyekFOVk84?=
 =?utf-8?B?UzdWSENRUFlwdW1JT0kzVlJhQklzYks1QVE3RldzdTB3a3QvOXJ4Z0lLdWV0?=
 =?utf-8?B?ZmIwYUxBZzlFZ0ZtTTlCY3ozZzNheE45UXp6OGxlQjltbnNWSFFqZzM2eUJz?=
 =?utf-8?B?WEJpRUtidkd0NTdCMTB1ZVFvL2VZT1ZIeTgvUk9OU3Z2anQ5Uyt3Uzl3S3Fh?=
 =?utf-8?B?TU1ob25YK1ZSRXlRTEw2dVJrTERlckFnZW9IUzA0bFRya0Q3eTZoZk12SURu?=
 =?utf-8?B?aVpRaGdqVlc5YUZ2NlhFOStLdnIyeG9YS1I3YU9jRFZka1JNZWpnamwvR3Zi?=
 =?utf-8?B?aitEbXF0KzJBZFo0NWpxRkk0bW4yamR5eDkvM1JZa2RHVk5qUVNjZnlMekpj?=
 =?utf-8?B?dytTNWZ2TTNqTmVaM1VRMTczZ2JXZklQNlJibzlSSjJKQ2Z1YnBUMnAzZitt?=
 =?utf-8?B?OFE1Q0JPTXRUU0hjcUd6cFBqNCtLTkhPZklubzhsWDVqTEkzMjNZbHd0aFBl?=
 =?utf-8?B?VTdkZ0JLdmFxRFc1Rm42NGNUYWhIM0NCU0g4VzdEbGIxbXZsWU4yaHVsVTY2?=
 =?utf-8?B?eWFFbXg1MStSTVJCdlVhMTN3S3dINldDd2pSQlRJNjc3UkhqcDQyM3Q4bmxy?=
 =?utf-8?B?Wi8yZjI5ZG40MDU4dWtRdnByYWdDNjlHQ2ZaZHhYZ0dEZUpyZHBGaDdJSVpk?=
 =?utf-8?Q?o6b0UQr18JxgQ994rRe+296Un?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93bf9f5-e4ed-40df-07c8-08ddc4fc4c86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:36:45.5152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4RvuXoKQWQsUzQsZ6DgIVmFER+iChEHhj5hKOzQqbetxFCMogCm4J2lnUqeDhDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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



On 7/15/2025 9:30 PM, Alex Deucher wrote:
> Make the handling consistent with other IPs and across
> JPEG versions.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 14 ++++++--------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  7 +++----
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 16 +++++++---------
>  8 files changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 554af4b9930e3..b93d6af8f6e54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -118,8 +118,10 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
>  	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 4e489a7e21157..b6d5ba0bdc143 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -167,8 +167,10 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
>  	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index d4bc4fca460c8..a229d7eb900c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -132,8 +132,10 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
>  	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index ca3debe371c5a..f3a9073b8b243 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -143,8 +143,10 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
>  	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index c3f73a2a911b4..b86288a69e7b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -216,12 +216,11 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	if (!amdgpu_sriov_vf(adev)) {
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> -		r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
> -		if (r)
> -			return r;
> -	}
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  

Looks like most places above/below can be shortened to -
	return amdgpu_jpeg_sysfs_reset_mask_init(adev);

Not sure if 4.0.3 alone needs an exception.

Thanks,
Lijo

>  	return 0;
>  }
> @@ -242,8 +241,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	if (!amdgpu_sriov_vf(adev))
> -		amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> +	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>  
>  	r = amdgpu_jpeg_sw_fini(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 5a69a44e0f855..1892c278ea3c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -177,7 +177,7 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>  	adev->jpeg.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>  	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index d6b565c29b4b2..0b4de0c6476ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -123,11 +123,10 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	adev->jpeg.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>  	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
> -	if (r)
> -		return r;
> -	return 0;
> +
> +	return r;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index 5473cbaa5c0e8..e622db1f818bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -200,14 +200,13 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	if (!amdgpu_sriov_vf(adev)) {
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> -		r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
> -		if (r)
> -			return r;
> -	}
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>  
> -	return 0;
> +	return r;
>  }
>  
>  /**
> @@ -226,8 +225,7 @@ static int jpeg_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	if (!amdgpu_sriov_vf(adev))
> -		amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> +	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>  
>  	r = amdgpu_jpeg_sw_fini(adev);
>  

