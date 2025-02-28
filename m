Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211A2C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 15:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F36010ECCF;
	Fri, 28 Feb 2025 15:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2BzyvRfU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB7F10ECCF
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 15:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj/EqIVUXSJ7Lcix23bTFtJDq8iHzdm2yufmU2f4a4Xhuvb8BjvTVvbnqPEbjYKx+znP3wxs8DErHaS0F1n5la5Vzfwd7BaBqnxgeGXBk1c4dHad98XanTVQoTmE64ANWv7Wahj7y7jQHJmhyPMobq+yrVvCGr65i983vgNabvlvXYVyaVQti//jv6Jab4BY1UYPfCN6wBYHPKqE8wK0hySWFp5d8O7yUKBGIqzGMRSoqwYQlTBhaMgYKPXA+BKlASBoWcOgo0UXVrvV8ux4iO0YLFCdkuiJO9lWPzkb95i1bh6ivspQclHvhoNPoUUcQ2vOaPQ/qkVhpE8kV4/PhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTz8gKJWBwGedVoE593rxs9RYq5zsqHDxZMD0ywG1P8=;
 b=bCmz2nf2Ig2SRhPfMQt87Fja1DjP1wVMHJ58Fr2QbHLzOmwWHw+SENIVWMDDQ17XDaILU2zco6CQgQpZwPRSgD1nWQUBtotBA7bdEor/2Epawl1vwCNRo1ESiz/Yl4H5sxT4qse7e9uHoTTfgGyq91ZgayNZQw5dixDsT0epTxQmU4k04LBX7axmohNymZ5J71nTTWUMoMyIPJ94w9zOAHEBsBEVoW2DN8CaQp5nZi3xOOMQuu/llg+x+uwVo+RErb8AsWPgU8cmCsWJIoBVOwO2tLRCA9QtNCp4lW4fqptdWW2JbI//ijgqn8Xid7afrDe4I45+qs6Mvd0kvWnO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTz8gKJWBwGedVoE593rxs9RYq5zsqHDxZMD0ywG1P8=;
 b=2BzyvRfUTjEFV65577HKyyS8nlNEwSq/RbbYTX5FqkTgm9ifopLfsKMzqP0tWgcE5Nab57vFIH8fEjZ/Oh3/0qnZCAKgp5QybzxOqWtLl9Ti1GDIOYCFfjzO1pv/nNdDbVaThGXuWh+wHH4DqIUlI/m/Jbpbq2h9/d8z0R3T5NY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 15:09:47 +0000
Received: from PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c]) by PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c%5]) with mapi id 15.20.8422.015; Fri, 28 Feb 2025
 15:09:46 +0000
Message-ID: <9dca5cf4-876f-44dc-9295-1242ca2e390e@amd.com>
Date: Fri, 28 Feb 2025 16:09:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: Fix MPEG2, MPEG4 and VC1 video caps max
 size
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250228132429.4842-4-david.rosca@amd.com>
 <CADnq5_PP7CE0-Jowq8c4GZQaQ81Ldm98Oo4maeSbKwA=v4KF8g@mail.gmail.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <CADnq5_PP7CE0-Jowq8c4GZQaQ81Ldm98Oo4maeSbKwA=v4KF8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::33) To PH8PR12MB6770.namprd12.prod.outlook.com
 (2603:10b6:510:1c5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6770:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eaf3dfd-17e3-4ce0-f966-08dd5809f038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzJ4cXlCMUp6ZWVZM3laaHlFR0N6UUFsdkxVZVRQNU5JaDhxdENOTXZVNUli?=
 =?utf-8?B?ZlpWT1cwRk9xSEp6eDRQY05UU0VhaHNjTzMxZXA5VDZJdVJRQU1GZFFqL094?=
 =?utf-8?B?c0kwU3YvSFN4OGF6NkVqMGZwc1p6SCtMbkozTEhWNFQ3WG1FRHNoWStVV05N?=
 =?utf-8?B?dCtweXdCODJ5eVM5M29saFJtRW92VDZudkQxMW5LK1BCU2ZVbTVaTTBiUkZt?=
 =?utf-8?B?eUVpZXorQ3pzRDdEZzZJbzkrdDFXYmFSbUZ1UjQ0NWZVYkFvVjBvVUozOE5Y?=
 =?utf-8?B?RTY3Y0VMQXJrRTFHbFpjRW5NTjhRTDR4Rk9xYW5xeG5EV3ZkOGRRZnhTT2RH?=
 =?utf-8?B?U0NpWTFJS2xzbEJrb2dLT0hXdWhmalk4aUJFMjduUUFyM2Q4RUZEM296N1VO?=
 =?utf-8?B?VlVIZE5ZZDZHZ29TSDRjM3lpR3F4aGhBekM5YUNIZ2U5NW9QZGtlclJ6NS9G?=
 =?utf-8?B?cjV6cEdUeWV1Y1c0RDlkSVhZWk9ib2VpQnVweTQzeXpMOHkyNXBlSjBvNkRz?=
 =?utf-8?B?OTJUTjBrbCswNWVJLy92cTVuMTYyaHlPSzhLUXBZODFPYkxubzJZMnJxVHl1?=
 =?utf-8?B?QWo2NzVGY1dMOEdkZXByWEFWQVNCbW1vNVNFdURWV09UTlRHaWh4TzJtVTRm?=
 =?utf-8?B?VXRNYnRpQnp3Mm9GMkxGNWxERHlMZ0FjWVZNaUIyek9IQ3I3STlRWXBkZjBB?=
 =?utf-8?B?YzFMQTlTZkROZ1RvajhuOTZuT0NQSWRITklpYmJ6Z3VWekxSMzg2dWQzT1Jn?=
 =?utf-8?B?d1FNa1djYnVjcDZmNGtLRU1HOWJESHFyT1A2S202NjNHMmxEZ0xEd3VZU25x?=
 =?utf-8?B?c09POTR5R3BwRW5YSFN5ZmhVUmhzN0tZaG1yNEU5dnBYaWNWVGtqdDFSeTRr?=
 =?utf-8?B?MUltOTdiZElJcmxlY0lCSnk2ZFdOeHE0Q214c2lLUUdmNzZxUVkxZTU4OVV1?=
 =?utf-8?B?QXZJVWgycmVWaGRWbVRXWldVSEN4MS9HbDBxRFJrMEZGdnVJTkRJUWlvc1dS?=
 =?utf-8?B?TUNha3p1MEpId3lmNFJJVy9pV2t3TldpN3J5VlAwTWJOT3ZqUlNXbk1DNXl2?=
 =?utf-8?B?WVNsRkF2TFk4VFh2azNDd1prSlZHRUs4WGZTdHc5eFJtQnV2Sys4S3orTDVt?=
 =?utf-8?B?cC9xaE9OVmRjYUxZOVhiMnVMN1dzNi9yMFk5aXdIOUgvM0dzb2J6Q2pUQVU3?=
 =?utf-8?B?OWN1eWM3NlM1bUVnakxnSE9FU0Y5dnJ0b2g1S2ZxV3loOUlEQ0FYTVoyNkd2?=
 =?utf-8?B?dHpUSWpPUHB3UlBRK2RTclAwWWFVVGdJUHg0WWJvaUttODBpVnJSL2NKanJG?=
 =?utf-8?B?d3Ruc3p1S1RBbDRuMmd3ZHZjYkZ6UmMzNkJybkpmeWpqUnJiUlZKbTV0OUJ5?=
 =?utf-8?B?UGdFNXBYalUzaXJwWC9jMGFKRmRwNGNnSlV3dGRLZ1pON3VWNUFiRmFCbFJF?=
 =?utf-8?B?OVVubmYzNjdraXQzRzFndnVmcVJ4dEdJQ3p2SGdFYWhBTzBoS1VQWlZQc2Y5?=
 =?utf-8?B?a25nTXlMN0F0aUtlaCtKbkhoM1ZJVmh5QmZaQ1JuZUs4d240SW12WDRvRnRm?=
 =?utf-8?B?TGxHYzlRN3c2SllYdWZtME1VdjdnR3BId0FVOGFhQWxCV1p1cllXYm85Ukg0?=
 =?utf-8?B?UkIwQWRJSVNrUWN6ZXN0RTZCVnludC92d3RoZ1RZS3FORnpINEZxem1oNEFr?=
 =?utf-8?B?eThMT1dyTDI4T0JWTzdOQll1b2RtSXh4dkJhM1JpZkU1dHZ1TE1zVUZxbVkr?=
 =?utf-8?B?QzJNOEV1OFdXb2M0QjJwVDJIOWdkZUVzTWFYK2VxbEpWOXZKT2hQenZXckk5?=
 =?utf-8?B?RVU0VmRtN3R5SFJyRTVJc3psYXBaWk1lYnlRQzFGS0JjYU5JbGVoa25YRzU2?=
 =?utf-8?Q?WpvrbvkG9OHK+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2l4NHVkOU9hQ1VJenZzYzFKL1BLR2drV2hFclF5NzY5NG5OZEt3a1VuMk9I?=
 =?utf-8?B?MVBmUDFFM1dTOUtTZDZaU09TTE0wYmVkYUN1SlQxTW45clVLZkFKWUhzQ05n?=
 =?utf-8?B?OC9oQlg0Z3Rha1c5YjBiRmNuWFBuV1IzR0U0d0lZc3VmNGQyclRsQ1VCNWVY?=
 =?utf-8?B?OS82U1p0MzJsTm1MWE5OU29ib0l0RmJvQkdIM2hFQ0pxdlVvM1JWcE1vT29v?=
 =?utf-8?B?dXpJUk8rZHFQWFpJTTRGOFJpbFdtNnhoZGVzTXIrVFB2TVN4TnJRS0hYa2Iz?=
 =?utf-8?B?TC9JekJmRGpMQVAwdllnMzdkdVlsQ0NjM2pZRHNmcmpQOUkyRXN4cXpIRDFi?=
 =?utf-8?B?UTNJSGFMNTBMZ3BjdHI5YTB3djlpemJFRkhidCsyczdMRHZlVnhqSkxnWlMx?=
 =?utf-8?B?eGVia1QwVjdMOWQyanBmYU1WTVEwUG1PMUd6MmR5VmtJZFU2L21WYmRneThQ?=
 =?utf-8?B?MmhxVVhzNWM5UWMvSGpiVFcxMnd3VE1ha2FxZXhNZWsvWkxxWG1uVWtycDlB?=
 =?utf-8?B?czRUKytiZ2l6NFgvNnkyT1N2bm1Ia1dRL0xVaFBETFFKRE9BRWU5Qk5iTE5z?=
 =?utf-8?B?OFo2a0FNNW1yeW04UWFoL3pIV0U1RGx2T3hXc280aStDVzFSSTh5QUdCOU1v?=
 =?utf-8?B?Rkh1Kzc0enFMUHRuV2hjYlFtQUpZNWxPRm5OcDFRbHR0YXZQSTJUOUJyNkJv?=
 =?utf-8?B?SDRnN3pxdnZuR1lEOGorRXkzbGhKdGVWZjZYVVhpQXVXL3pGQzVlQTJhdjE1?=
 =?utf-8?B?YUVyWnVrQ2VGTXdNcDVBeFFwakR5V1JubXI3amZHclVTWmdpd3VCZlQzcmpv?=
 =?utf-8?B?QUpKRTc3SVVMbG9xU1RlZGY3MWxSRGlVaEdUazFVRXdwV0dvc0hTaXpTVkdX?=
 =?utf-8?B?UGJmVXNib2tOalB3bXdNdjhsUENCRFNub3JBNnpjVDlRS2dWUnVQUTJBUXVt?=
 =?utf-8?B?YlI3dWFDZkV2YVhnQllRUDB6bHNRaFovM2VMd3E0cklxUE55MjFQUlBYRjkx?=
 =?utf-8?B?dm5mRzQ5Y2luei9HSHR5aTVFTysxckZUbE5GSmlGeS9VWTZMNEt3VE13VjdE?=
 =?utf-8?B?NlI1NW9uT1RiVTkxSVgzZWNFSitsbjVOQ2lNRXYycUxCcXNNdlo5djhvMzRs?=
 =?utf-8?B?Ykx5emtXWWhRNWoweDNlM1JzWkdhNkRYSDdhQmJDYUIvUUVmWlJZQ0hQUzNj?=
 =?utf-8?B?WUYvK0VMMzZaeEtaZG5zcTZWQVh5QlVvcGNwbXFhQzRFamkvY1lFNFg4aTJ4?=
 =?utf-8?B?UEpzbkpJRUw1RDRidEEzd1pHdFp5MmwrS3N5VjkwcnVPa3RROEluWmVQQWRl?=
 =?utf-8?B?Z0lZQyswbThmRy9NTE1LeEZGSTY0SmJ1TzlTdVZaRCs4cG9zb2w3QTF0UWdX?=
 =?utf-8?B?eVh3cTU1emVzWnN5d1MwNTJIU2Rab0hzcXZxOFA1b3VESHdOWFRrazBJQlF3?=
 =?utf-8?B?TkpDMFZiRlZkdnBMaXcvZjBDVHlKZnh4SU1SYytVVUh0aVQ2RlB3cm5TWUU3?=
 =?utf-8?B?K2xSNmtRanhaZ1Z0OUR6WldQWlkyb1NTVllhQU1CR1E2T0JiQ0FhQTBBbnRL?=
 =?utf-8?B?UEdici9XbklYTnlyYXJsVlJSeG9tMlNRUVFYV0dCQ1FxWnZsc20yNHVtNUdI?=
 =?utf-8?B?emM3eGhqekwwUzlkc2NVZXZqREczTzQ5MVZ3Y0g1R05kVm5iMTRrOEJoUUhJ?=
 =?utf-8?B?RzhianprVWJmTnhXQlVRUWRHcVF1QUQ1SXJOS05wS0xVVGFpOHJoa2ZYcXY2?=
 =?utf-8?B?aUMzQWtqL250ZytncHovUDhyVnJmMGNCdlM3V1RWWHgrT01zRG1Hc0d1UGNh?=
 =?utf-8?B?cS9DalRISFY4MlV2a0F2SzJwcDBsTWxmVjVKZittdlV4dTRPNFZZTmJTU0M1?=
 =?utf-8?B?SGZySjMrTXBxMVlUQkY3d3hWT29CZ05LU2dJNVZ6V3FTeVlYeXhST3FFUi9Y?=
 =?utf-8?B?SSs5akVyVHMxMjhDQzR2SFlWdWxQVUpYamtZNnhwQ2xZZFp2K2Z5aU9vbk02?=
 =?utf-8?B?YlcvRGpHM1NwQjdWaUZrRndaWHFWTm1zbE5RTEFBa1VPeHlvQ0p6Z09tekVT?=
 =?utf-8?B?UnJYeFVQWlFiOHdzUWhGZEFCVG0xS3BBY2hLVmY2QkloWHIxMEh0RWNuRWFt?=
 =?utf-8?Q?FpqJ5BFeayx525zcdDMeNMUWj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eaf3dfd-17e3-4ce0-f966-08dd5809f038
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:09:46.6264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q07IZB6fpas0EiNUZISbiD0vlmwbabgmJzASlgmEL/Glkg1Qqi6El2bfkvRPYGZP7j7z9t70ztrxJfZgxf81YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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

On 28. 02. 25 15:21, Alex Deucher wrote:
> On Fri, Feb 28, 2025 at 8:34 AM David Rosca <david.rosca@amd.com> wrote:
>> 1920x1088 is the maximum supported resolution.
>>
>> Signed-off-by: David Rosca <david.rosca@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/nv.c | 18 ++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/vi.c | 36 ++++++++++++++++-----------------
> I think soc15.c needs similar fixes?
Fixed in v2.
>    Also, I think we need to bump
> the driver version so mesa knows what kernel version has the proper
> limits.

I think for now we can ignore the kernel caps in Mesa for these codecs 
as the maximum size is the same for all asics. We can later switch to 
kernel caps again, no need to bump the version just for this.

David

>
> Alex
>
>>   2 files changed, 27 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index 8068f384f56c..a18e6fb9fa3f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -78,10 +78,10 @@ static const struct amdgpu_video_codecs nv_video_codecs_encode = {
>>
>>   /* Navi1x */
>>   static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] = {
>> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
>> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
>> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
>> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
>> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
>> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
>> @@ -104,10 +104,10 @@ static const struct amdgpu_video_codecs sc_video_codecs_encode = {
>>   };
>>
>>   static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[] = {
>> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
>> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
>> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
>> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
>> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
>> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
>> @@ -115,10 +115,10 @@ static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[]
>>   };
>>
>>   static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn1[] = {
>> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
>> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
>> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
>> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
>> -       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
>> +       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
>>          {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
>> index 3bbbb75242d9..9b3510e53112 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
>> @@ -167,16 +167,16 @@ static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
>>   {
>>          {
>>                  .codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
>> -               .max_width = 4096,
>> -               .max_height = 4096,
>> -               .max_pixels_per_frame = 4096 * 4096,
>> +               .max_width = 1920,
>> +               .max_height = 1088,
>> +               .max_pixels_per_frame = 1920 * 1088,
>>                  .max_level = 3,
>>          },
>>          {
>>                  .codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
>> -               .max_width = 4096,
>> -               .max_height = 4096,
>> -               .max_pixels_per_frame = 4096 * 4096,
>> +               .max_width = 1920,
>> +               .max_height = 1088,
>> +               .max_pixels_per_frame = 1920 * 1088,
>>                  .max_level = 5,
>>          },
>>          {
>> @@ -188,9 +188,9 @@ static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
>>          },
>>          {
>>                  .codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
>> -               .max_width = 4096,
>> -               .max_height = 4096,
>> -               .max_pixels_per_frame = 4096 * 4096,
>> +               .max_width = 1920,
>> +               .max_height = 1088,
>> +               .max_pixels_per_frame = 1920 * 1088,
>>                  .max_level = 4,
>>          },
>>   };
>> @@ -206,16 +206,16 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
>>   {
>>          {
>>                  .codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
>> -               .max_width = 4096,
>> -               .max_height = 4096,
>> -               .max_pixels_per_frame = 4096 * 4096,
>> +               .max_width = 1920,
>> +               .max_height = 1088,
>> +               .max_pixels_per_frame = 1920 * 1088,
>>                  .max_level = 3,
>>          },
>>          {
>>                  .codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
>> -               .max_width = 4096,
>> -               .max_height = 4096,
>> -               .max_pixels_per_frame = 4096 * 4096,
>> +               .max_width = 1920,
>> +               .max_height = 1088,
>> +               .max_pixels_per_frame = 1920 * 1088,
>>                  .max_level = 5,
>>          },
>>          {
>> @@ -227,9 +227,9 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
>>          },
>>          {
>>                  .codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
>> -               .max_width = 4096,
>> -               .max_height = 4096,
>> -               .max_pixels_per_frame = 4096 * 4096,
>> +               .max_width = 1920,
>> +               .max_height = 1088,
>> +               .max_pixels_per_frame = 1920 * 1088,
>>                  .max_level = 4,
>>          },
>>          {
>> --
>> 2.43.0
>>
