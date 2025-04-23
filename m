Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD6BC369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 14:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E1E10E081;
	Wed, 23 Apr 2025 14:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mVCq3YMe";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5729110E081
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 14:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY+I8+mSMzrtwMO+s7MsvOwY9bqgyfbyBC5bWPqghATIFTkJhacgfPbBVYiWXRFqIJu4gBJUPo+8uhSiLfXiYyxslvZlgQbaducbZyepJEh5h6/3iJpCctH62gidySgRrS4MgpHy27MFyLJrz9EZkwHfHepNACvIoDUtGrN/SlFfeaCn6vqE6y73KdJWORsH52ESS/xXkhLFanyvRFppsuOxaFeGhVnHozrlzWQiH5LX3G/HyonmYmtfdZ0lt3CBB7uORNC2fcc7m1g8jYmIVEOReNIRbhD2UR4DzfaZ0ivFoCjRn5KTiIUGF7zdlCiCedwy3K3UdhmTDWetcXwCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxPfxGCi8rAiEA7MxSUa745/i+54Skv/1+Zp1H+nibM=;
 b=G3cLz0G3oLp69BU0vS5HPT/cz08Du0nBVrw3gRs87uK5uiQNV+B677uMVmwF74Jlur59GV1wXGoArteaUB9kUWpH0DZ5UdQl001IaYZvSq6/SxhyjADVb82CVmjjQgxTCUfuLUSIy7Dx7JjYPYHIZz1g8yTetdQNUOO28qK78xrx+oqHjnkKVDQnJHrIXNzE0hB2S15epx0nACLv0aMR9eWTKZQBceT9Y502t90cp4qqkZhC8QCCizg1sdbU8qQMvYpBIUdDxtWXZCU6afs3v2wbzWIXW2PJEHYC5Glzclbkitff583bkwuanTTB5fnI2wxMGaV9VhQ7iNMnqwQRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxPfxGCi8rAiEA7MxSUa745/i+54Skv/1+Zp1H+nibM=;
 b=mVCq3YMee56B0wCPR03ZUZGtk1RQq5uDSd/gSNANaAjlLZQCjzs6uSxf8cMLRjHH3ZWvOkE7nBMDpwyKwc8uHCsGeL26nSI5dLKvOS1iHZnjSywRSg9R+2tS8e+MUnpmKcblBl9VhIgrSmd7Lvw/LBOBlOYQQv4AL2+0xS+tipE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 23 Apr
 2025 14:16:48 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 14:16:48 +0000
Message-ID: <5d91cf87-a509-4302-89b1-960c5da72c5d@amd.com>
Date: Wed, 23 Apr 2025 19:46:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereference for
 program_lut_mode in dcn401_populate_mcm_luts
To: "Zhu, Yihan" <Yihan.Zhu@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250423133156.3877781-1-srinivasan.shanmugam@amd.com>
 <DS7PR12MB6046CAF8F49C38AD3C08A03DE3BA2@DS7PR12MB6046.namprd12.prod.outlook.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <DS7PR12MB6046CAF8F49C38AD3C08A03DE3BA2@DS7PR12MB6046.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: f50c9e30-dc59-4601-532c-08dd82717bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVdSZnI0UkxyeXhEOXBkZFNtSmRIVVZWNkdRRlFIS2ZnblE5bXU4OEl0Ykcx?=
 =?utf-8?B?WGpzTmhYTnZ0U255WXRMNTk5WjJnN3kwMnp6WFlBT1hXbVc2b0tDNWFVTXRj?=
 =?utf-8?B?ZFR6ZFB1L0U0dWR6cWdMVWJFemIyQTlTQXVsVDcxcXdDUTMwWUROQUYvcVJW?=
 =?utf-8?B?b0M3MWIxREI5NmdYTVBydzdvQjhOOEpheGw2eStUNlE0Y2FCUTRBa0xVYUIy?=
 =?utf-8?B?dHBXaks5bDZwZnhsVXQ2dW9FZU1abzBnaGpxSlBieDc1Y3RmVThPYWMvbllw?=
 =?utf-8?B?TGdBRGM2K2toYk85L01Ga0Q5dGI4ZHJVVWRIZlp3cmhHVUIxZkdId04xcmRh?=
 =?utf-8?B?V25KRXJGWk1wUDFnZ1pTM3llSjdoZWloQWhsOWJzYjhMMHhUdHZxbGFmL2RG?=
 =?utf-8?B?L1lkWFA4alpudmhtdWNCQ0sxZk85bGdUaUFaczNXelNrdk1Rb3diU0szQWlU?=
 =?utf-8?B?SThCbm9kNndoM0RsZVQ0bWMyVW9tZXFtb1llQjZuOXdpY0VzSnNBWWswK2dp?=
 =?utf-8?B?QlVMM3NyVUJjMWtBK2YyZEM2NC9tQUdBVU54YWFIdWw0ZFJoNy8wcG9oQ0dp?=
 =?utf-8?B?eENDbStaWlVvNm9YVXFpcHRSRzQzODREK0NQTm9SVWd0dGdoVkRQWStLbjFm?=
 =?utf-8?B?NkkzQms3RW53Qk9ZUlZIczBxR1RCVk1iYkZBd3BBM3FscVc0RlhGMTZuVmk2?=
 =?utf-8?B?NXMycURhNXZLSGFpWWRaZXFnVFllR3p1SWdzSWJpQXBteGxNS08zOGFIQ0FE?=
 =?utf-8?B?M01rQk9lMXhERWE0cnhwajNZbEt0bGJvemJLemJ1dkZnSXRlY0hQNTU4TEtQ?=
 =?utf-8?B?UXR5OHFSRzBCWWIzanRwdjk0MlpiSlBhcUFCSXJhOGI2ZERjeFRTYWZBRWVi?=
 =?utf-8?B?UlY0Z3MvWFRPajZvRTRCUVNjdkVPMjRvRS84aEQ4UGNJdjNhbXpJZjU1RklC?=
 =?utf-8?B?ekJsak5QcTRGb3pHTEZSYW9xMUtHaEtXZjJtS21KbHlMN3FkT1hvbHkxZitz?=
 =?utf-8?B?N0N5UHB6S2ZUNWwrZVhoaHhKWXdUM0dzVmE3ZTF5SmFac29neUxKQ2w1b3E5?=
 =?utf-8?B?bHBpOXBOcHBOd2Q3NlV4Z0VqUkhkRU9jcHFyUzhHV2crUy9LVHVGbjJEYUxo?=
 =?utf-8?B?UGFDY0tDUDJ6K2JlWDhuNGNhcTU3VUNhSzB0SnJaWkVaZ3dVaWx6MC8rSTFp?=
 =?utf-8?B?MUl1YW1rT3Fla2hvUVFXaGJwYUJkeG15MTFiN3MyYStPb3NkUjBQM1RxV3Bh?=
 =?utf-8?B?em15eDluRS9lY3ZSL1BlaHhLRDRiaE9Hay9ydzBXNGNWZG5rcGNkRFZGK29n?=
 =?utf-8?B?eGlnTS9IMEwvRG9VVmUrNTVydnpFb1BSeFZ0aEE2b0Y1OUNwODhKdG41cTRr?=
 =?utf-8?B?Mlk5dExSUFA1YjBxbGtJUzUvVE9EaGJ3dXRiTGVHcXZTeklHRGZxbElwWFR2?=
 =?utf-8?B?WFh5eStlUFluQmY5d1dmYnVGTGhkY2hzNmFxa3RlZ2h4dkRUZFlxc3pMbS9j?=
 =?utf-8?B?c2NYYzVMZ083RG5yUnFoUjhCd00xMGZ1WUdpbHpNa0tMeU5kRFR0eGVVYSt4?=
 =?utf-8?B?SkZJUGhJVHd6dHcrZ3JJeElWOTd1R3Z4TXltUVhBVGFkRUU0MVcydlZaOGw0?=
 =?utf-8?B?a3VqZFVCaXlXbHZxYVVKa1VvQ205dVZ1V3ZSdGdHOGZ0V1lCRGd5S0ZDYVZC?=
 =?utf-8?B?b09uYmEva2t1MWl5NjFyQVc1L2tSWUVDRDdWUkhKdnMybGIrVVpaS3lWZDk5?=
 =?utf-8?B?TVNBRFpxVXZpejhGbnYzcUFpV3ZMNGlQU1lZUmlRUksvbUdEZE9malNHa1Mx?=
 =?utf-8?B?OTRnbHd2d3hLSndCQnZzbHZPV3U4VG5NRjF5V1BwMGJaSGhOc0JFTFFNcDJl?=
 =?utf-8?B?WWprM08zSDlKV0I1bk96Qm55NmVRa2p2R0k3ZWxRS1BMcVpSTDBUYUlSU3Vp?=
 =?utf-8?Q?kU5r5OeBoL0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGsxQmFJOGwvV21hUkZCSDU2cVFMWVM5UVVuNzczVnJvMUU1cCs2aHQwOXg1?=
 =?utf-8?B?NVE1YXQvSDRnT2VhTkI4UXpFVGk3U0kwbGZwemRDb2VhOEZBSUU2NmRVYkk2?=
 =?utf-8?B?TmZ4L21rSVRzQ2JLWTFjYzdES0hvaUpOQ0d1N3NUK0g5N01VRHNpZXNTQlZv?=
 =?utf-8?B?NVVPZmFEanZpQmtWODZkczA0YXA2Z2pPTnpLTnExS1R0M2J4c3hhZ082cVor?=
 =?utf-8?B?TURrQVhkb3VWMUZ2WTh6aGh3Y3o3QTA3d0RFQjBxK05ucmQrUmhyV2Y4WDJw?=
 =?utf-8?B?em02R3NWUlNIMUNYT01MSkRRT1VQaE1odmRLcVR5bGJNMDZXTGhob3puVjB1?=
 =?utf-8?B?aFdlOTNoK1MzbDhYalFWclhEMUZQdTIwb0cvOXRNV3lTbEIxZ3ZpV2Jrc0VU?=
 =?utf-8?B?emx5NFVkREJaa3JQalVqOWd4aGhlanpMaE8wRldTd0VERkx4bmcwMExXWWpl?=
 =?utf-8?B?a28rMW0zWUVuZ0p0ekNCZUNnaTZ0M3FmbDNqNkt5aWJGbnlZSGY4dmV5eDdH?=
 =?utf-8?B?T2hpL2dZQmpLUXZiVm50dDBScmxYWkV5SUgwakVNeHlCMXAxbmd6TVlQaFNv?=
 =?utf-8?B?NVhjeWIxNURyNE1uMHl5cytQMzVjTlIrUDBYNm5Zd2JkL2FMemdpZ01MQVJn?=
 =?utf-8?B?b0pYa3k0clJsSHllTG54SnVyRUN4WlBpb2FXa1dDZ29vY1VjcHpXMFJBRUZM?=
 =?utf-8?B?L3d6T0Y0RDFmZjMwRUlEaTJQYjVObnEvV3J2ZWtTU2RzQzQxWnhOMDRZa01J?=
 =?utf-8?B?dzFtUkRUYnJMTTYzWnA1TUNuZ3p2S1dicEVneTZHRGlCZTc3U2E0TWR6OHkx?=
 =?utf-8?B?K2MzYmU1SWNEQzUvSFRMUmprM1drQmUyVCt5MmNmNlZJTXBWcnB1M3cwNlds?=
 =?utf-8?B?NzJwWW5ZNXJ6Rjc4TCsyVlBiK0pRMjhTSWNVbStQV25qN3NBN2diTk9adGdW?=
 =?utf-8?B?RDB5bzhIbFBuUjM5NGNDUTJzSG9scjgvS3N2R3VycG9ZbU9hL3hoaGdiYXl5?=
 =?utf-8?B?bHJ0TEFwZ0NISFpnYjA4NUdpT3VyQUxOcHR3emE0bFlnWlFKVW1uck1ZcVIz?=
 =?utf-8?B?N2UyVGhNclc0V2tOVStNclgyN3JCZ3NLakVHQ09rUFZ0eE9pdi9paXJCVzds?=
 =?utf-8?B?eEtMTTlMalRXYkwzTGt2WVVWWk9VK2phRndZZ3dpV0lhYmVLNlF3dzhLZElQ?=
 =?utf-8?B?NXB6U0xCSGhyUGVYK0E4bjlGRkF5SjZvVHVkNEN4SDZTREVWWHI0SnNvdUdu?=
 =?utf-8?B?VnRwMlNyVnRqNE5YVmNuTGMxcFR1OGtmWUdueE16eG5WMTIreGZ3cmJNWnJz?=
 =?utf-8?B?SCtzaU9QQk0zZkE4Zld4ZVdwUGxmZU44M3JZSjQ1N3I1dE5sd3F4STBkVEYr?=
 =?utf-8?B?UENFdk5rcGdzVnRsc1pKUzZwVkMxc216ekJXRlBjUGcwcUduTkhWNHFxZTAw?=
 =?utf-8?B?dEt1UDdYMERPUUhSbStOSk1OT1pOSVZoWWZla2VSdk9kTWFCc3lVVE5JbDZ5?=
 =?utf-8?B?enJvenZNTms4bU9ISTVnSU93eHdaN09QTHpsQit3Y1hDcjBaNFFIYW96Q09Z?=
 =?utf-8?B?Tm1XZUZzOXZuTktIN0d3SGhWQllpeVBIbjRCdGtwRFllZ2RiQUhFc1BFSkdR?=
 =?utf-8?B?Vmh0dGU1OVJ4OWF2WXZxOEF6aUUrMnpLOUt3dUxhZ2ZvenBhTG9PUmlYVC85?=
 =?utf-8?B?UHg0MjJBU3BGczZVKzZmSjdadTZiOXg1UnNZOHc3cGpWbE0wTGhuK3pjcHJK?=
 =?utf-8?B?RVBxWkxrTTEyN2NXVE93MUNhZ2xXWnN5QlRhOXJvQUFKWEdCZEZ5NFNmMG9j?=
 =?utf-8?B?L2Y0eWgvTVF0d0doVzNodURWQnpNVXA5V3JodDBiK003bEJRMUIxMk5DZ09T?=
 =?utf-8?B?T3ZtcVFpZTNwMlhOWkV5bXFIdzdBQUdYUjZadjB0MlhtTmt4S29mT3N6ZVpR?=
 =?utf-8?B?ZUdMKzd4RHRIMDdVVlN2Q3lYSlArQjh0L3JVdUFVQzg0Q0dSTm5wR0xETEoy?=
 =?utf-8?B?NTJ4MmNDTENxc0drUTh6eEgrZm5ZTy9BbnkzNk9LME1FM1RZTW5JZmpnQm1J?=
 =?utf-8?B?dnNja1BaWkh4UmQxRVBZQVM2QUo1amVFMnp0aXZuQ05pbzZ4N2lFa3ZwUmJt?=
 =?utf-8?Q?r0arisNcKVIRLJIUoSXPHB2eO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50c9e30-dc59-4601-532c-08dd82717bdc
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:16:48.0951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Px3d+LqaSSSYVmARLCfn/jOHN5TwSaRWrJdSYOO9aA0/eqzCpIFmLzAjnGerlyI8NgYpCIkiNFdhXyCd6hGcWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
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


On 4/23/2025 7:36 PM, Zhu, Yihan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Srini,
>
> Thanks for helping add missing NULL pointer check in the Linux side. Is there any further actions needed from me?


Hi Yihan,

Thanks for your quick review.

No further action is needed from your side at this point. Appreciate 
your support!

Best regards,
Srini


>
> This fix looks good to me, approved.
> Reviewed-by: Yihan Zhu <yihanzhu@amd.com>
>
>
> Regards,
> Yihan Z
>
> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Wednesday, April 23, 2025 9:32 AM
> To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Zhu, Yihan <Yihan.Zhu@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Dan Carpenter <dan.carpenter@linaro.org>
> Subject: [PATCH] drm/amd/display: Fix NULL pointer dereference for program_lut_mode in dcn401_populate_mcm_luts
>
> This commit introduces a NULL pointer check for
> mpc->funcs->program_lut_mode in the dcn401_populate_mcm_luts function.
> The previous implementation directly called program_lut_mode without validating its existence, which could lead to a NULL pointer dereference.
>
> With this change, the function is now only invoked if
> mpc->funcs->program_lut_mode is not NULL
>
> Fixes the below:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c:720 dcn401_populate_mcm_luts()
> error: we previously assumed 'mpc->funcs->program_lut_mode' could be null (see line 701)
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c
>      642 void dcn401_populate_mcm_luts(struct dc *dc,
>      643                 struct pipe_ctx *pipe_ctx,
>      644                 struct dc_cm2_func_luts mcm_luts,
>      645                 bool lut_bank_a)
>      646 {
>          ...
>      716                 }
>      717                 if (m_lut_params.pwl) {
>      718                         if (mpc->funcs->mcm.populate_lut)
>      719                                 mpc->funcs->mcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
> --> 720                         mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_ENABLE, lut_bank_a, mpcc_id);
>
> Cc: Yihan Zhu <yihanzhu@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> index 8611eb9607df..ae7194da5987 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> @@ -717,7 +717,8 @@ void dcn401_populate_mcm_luts(struct dc *dc,
>                  if (m_lut_params.pwl) {
>                          if (mpc->funcs->mcm.populate_lut)
>                                  mpc->funcs->mcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
> -                       mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_ENABLE, lut_bank_a, mpcc_id);
> +                       if (mpc->funcs->program_lut_mode)
> +                               mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_ENABLE,
> +lut_bank_a, mpcc_id);
>                  }
>          }
>
> --
> 2.34.1
>
