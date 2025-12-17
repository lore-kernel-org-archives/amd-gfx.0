Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC24D65C7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 16:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D8710E7E5;
	Wed, 17 Dec 2025 16:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bJNm57NU";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013018.outbound.protection.outlook.com
 [40.93.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669A710E8CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 16:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhkTCYVMXvrEb7PX/+VwTKrxhPsmUuNaker0zyEp2YTCHWqgQIzaO62+N/xR/SJPT/TKtp3IvY/R3W/wrP5DgIoOSStCNlEFYIBpBPb8geC6pmRej2+iNCK2xOj+8r2V/xLz5G8RkP7kx1iyL3fJ+LHs5+GRXlTlR9rPiqKXV59m3s9dg6ffAkVL7Y/MONRENFxdxtApTVgIMntXrQ2+rH7ftroW0NAMgvcWi2FTndRdYimuah6gQ5ozt9Treo7fQPueJkCLiUb4o8LJlRiSrOCxGWBC4Dex7BITliA00hJQcENW4vFvSbXW0UKn2IwpNroTS4ltreCzzDqfpU142w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6s5/LWy1Cv3M4n6qaIJGUuQUB1n7Z2daPEUFLp3tE0=;
 b=maJm87aluGlMjo/WHWun93fXYoZjH8gmgAa9On7hOlcgQT6whM9zOUH4k0mYgYruYVIdF2LjtWU4K2683cjVMTTlr4N7Wmrm+UxHtpmVJq4nAplq81+1Mqqt6vD4NuVSpki3gDRopl4Jv4Yenx3dNSuoheaWnVdjDeCFVswxMxghVFFv2ISrOZ25d/oXsY+L6ljlMfg6bhNskTM88XhuhEDo/IX4Ro/8Rx6sNLaVAJUJ7hfVbgRITzc9HyxbtTH4++wCEsrAetWcsWLCsTL+OmbYaRZ0Iudg9WIMXBUuSd4MB0Zyaqf+rigcRFxMXCWW5VPwRF46fZC/QBSXbGB3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6s5/LWy1Cv3M4n6qaIJGUuQUB1n7Z2daPEUFLp3tE0=;
 b=bJNm57NUrQ7IpMlIDc6qVolAvwZGMEql132DTlwBG6TRId1E2UsdgeySEqCajoTDRWmYLOGDiF5qZmcabHLYCq3zbYievHBgBnmGeFFgu0uCr3G/zsIKJgzncUJys0Rb3xQoBWo+fFAGH1yTJXW3s3BGhr5OYCEmKigirm0v0YY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 16:37:59 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:37:59 +0000
Message-ID: <85112e20-9a07-4537-ae1d-044179248758@amd.com>
Date: Wed, 17 Dec 2025 10:37:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-7-Philip.Yang@amd.com>
 <c3415b20-da51-4aac-acf7-841fe9621b3d@amd.com>
 <84a6dc2d-45bb-4f9f-a84d-47b8727485de@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <84a6dc2d-45bb-4f9f-a84d-47b8727485de@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0017.prod.exchangelabs.com (2603:10b6:805:b6::30)
 To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2821e5-318e-46fb-5a91-08de3d8aa383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N01INEd2UFpOUXN6Z1JudzFIMGpZSUNjR05CM3IvWVFWcUpONzd5UWduMnRE?=
 =?utf-8?B?KzdWN0kvZjkzT1N3aDR5N2Y3VUYyaStiWGpCM0tHQ3BJdVo3c0RJZ3had3J0?=
 =?utf-8?B?aE1qckYrY3MzcjZKSGE4UjJGeEF1UlhFWDBjR3FPZUFMMnNiSTFGSXpEczhB?=
 =?utf-8?B?cnBrV0dRR3hYaS81a0x1TkY3K2E3QnlOTUJyQmhtR0xJeElCRnRVRFp0Wk9q?=
 =?utf-8?B?VlZTY1VxVDVnMG83VHRRSDZGZllQYWx5QlgyRjZ2NEE4Nk1DaFVVdCtIU25B?=
 =?utf-8?B?N2UzWlFoTTRaRkZIR01vTHluQWRWQWs5VlhVOXFvR2NLdFl6MktCNHBEcmI4?=
 =?utf-8?B?aFgvOU9VL05tU1J2ckY4bE1TVU9sUXMvYlc1YW1venJucndKWUcweXNlNlZC?=
 =?utf-8?B?T2xSNmJNMlZoU1EwM3NzejEzT1lFWWlmby9Qc2lTOUJxQkk2bWRXaVMzd2dU?=
 =?utf-8?B?ZFMvM0xMOFNXaTNzZm9kbXcwTTFNV2xtY0FiQ200QlJMbFV6b0JVZVN0T1Zh?=
 =?utf-8?B?Skk1dUUvMmRyWFFqTFdIVWlRb05JSG1rOEVGZUJXbGhuTmRBcENycnlISUlU?=
 =?utf-8?B?VlpmRzAzS0dhN0o2U3FVSjFoeXlIYjZIc0lSN01EWDdPeldIQldaVkhmZktG?=
 =?utf-8?B?T0lsT1BiczQySnJLbGZhbko4czR4Uk1mOEpGZFdoUkF1K1FFRWZFdTVoeFNY?=
 =?utf-8?B?MW1OZ200RlhYek9HaXpNVmpLWEFnQitWT1RUSUZHWFMrOVVuNW9uNVFRbXp1?=
 =?utf-8?B?MUR6S0hPVUxYVU5OSWtBeGNBWk9FazE1djhxMnUrK04zb3pPUFFjemZ2SkMz?=
 =?utf-8?B?b2ZRSzNmck9NYm9udVVQM2t3Y2NnNWl4R2ltSW9xVXlTSDNTRWRzSFhhM0pz?=
 =?utf-8?B?TVUxZU1Hemt6YU1rY3cwSnEzUm5EOTJLQ1RRb2JpUFljSXRoL25rdFpiM3VX?=
 =?utf-8?B?T0pkajc0L0tGYkcvWjdnT2NZclErT08xMjV6Mzg4bSswZlNiUjE5c1lpUXlB?=
 =?utf-8?B?S21TdGNrN0RSa0pNNUlZRFlKcTVLaGJRNjZ2TVFKeVVKNzA0djR0M1lHUTNp?=
 =?utf-8?B?ejFNMlZpZjFYYVdtTHd1d3lvcEgwUUlxRG0vMFpZVituUFYxUWxBTzN0alg1?=
 =?utf-8?B?QkZQOExxM0dOK05KVGRRTVZNREFMTnJoWk9Udi9zWFluSmRtMHpjaWNpZ2ZP?=
 =?utf-8?B?RE9naVk1UnZIS29ES2dEMTBwVkVIK1RIOEhCQXFiOFVyVjVCdGx0R1JQZk8v?=
 =?utf-8?B?cjMrSGJ3ZEhpc2ZSWU1QMXJuZUdoTG5UZ3pvQnBJQXJ4Y0lsb2pxZmw1bGRN?=
 =?utf-8?B?YXpVR1crY0VhN3J6NDFnUEFUbFJobkdLQmRMNnhiNjd4OFZOR2pFbzMvTlRB?=
 =?utf-8?B?ZjMrazBuenNtVytzd0dNMTJleGlCbHlJTXdIbmRkMnJwN291QWp3ZWJnZFRl?=
 =?utf-8?B?NVRPK0k3VnlndlNFS1pyK045UXFlQ3g1dk1RT2cwdCthR01wdDhpL09ydUhm?=
 =?utf-8?B?T1o2dCt1MlhWOGYwbXkvZTUzcFpPcERaNWZmZEc0UjROaWNqaTJMUnpwVDk5?=
 =?utf-8?B?MVRzeFIyRG5HOXdiUkZTMWlDRlNYQ1Flc2tFR0hLdWFQYml5MHZzUmMwcEhr?=
 =?utf-8?B?ZHAzOWR6VUVxZzlTZjlJa0VZQmRmQ08zdnNwdFRrcWl1U1U5SUdKdFN5cHRj?=
 =?utf-8?B?d2dEQXVNUmJYamNPSXk0TjlkM0sxbDUybjcxWDBkbFZ6QlcxT2NEYzAwK2sz?=
 =?utf-8?B?WUtzWGpIYWo2d1NlTnVDRCtsZXgwb1FUQWVUbzh1NW92SWRFamg3MmZSMTg3?=
 =?utf-8?B?NWV6dTM0b3QrSGpuY0trSTZzZW13bWlXMTNkTnljSW5WREJ5YStWMktvd05T?=
 =?utf-8?B?RHI1Vnc1Q3owSUU5UGp4Y0lnNUZWUElkcmVjZTBXMjhmZkdXSXZ4S3hFMHVC?=
 =?utf-8?Q?rl0+sq7gNuPpMfRvpbVdUnCIZIUPNwSH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1lNVzBKRzU0NHgrb1Z0Ly95bUs2ZU9KWEIvYVE4eVViYzJ3OENrdWpPWjRn?=
 =?utf-8?B?ZFhJdWZNbnZMemtwNEd0UmdCNmQvWEhNWlJpWGQyaDNBUjA1M1JuSHFlMzRV?=
 =?utf-8?B?eVRQNkl6MnovNWFkbnZXZkZZUlZsUSttUGZxaVlHUG8rOWFVZzI4U0lkQlNH?=
 =?utf-8?B?cnpjOGVEYkx4ckNRd3BYSFZ3R0J2ZmRUUWQ3aFpIY05kdGRoYkowRkdOSVh3?=
 =?utf-8?B?NkJTWnlqREJ2ZDZ1dmxjNFd3OGsrbE0xdkpwcWVLMXliSUNyNzFWNk5DNDRK?=
 =?utf-8?B?djJVTDRYQlU3WTFkcHppaGlPd2hkdElOTjhhY1J1SGxMenMxWWJKcXpsdSsv?=
 =?utf-8?B?SEdmZlFDWnNla2pUaU5xanlvQlpicmZGZXNIWXV1dUQ0V2VVeTBkeSsrRmV4?=
 =?utf-8?B?SnhyV3JoM011dWFHekRiRlJWc3BaTStmenZBU0VPbjRWVEdJaUdBVXNrUUti?=
 =?utf-8?B?RjArcGFPUXZMRmRDdDNYZHRsSjQwd0pndU1ic1hLZkNObm93d0xtTnpCdG1r?=
 =?utf-8?B?Z1laazJmbVlpKzYyZ2F1d1NoajRjVFFVOEV4STB3QVpPaEtEeXI4MXhDU0pp?=
 =?utf-8?B?YjZIU01SYjdocWZLQTBhMTM0K1FTR3g1YzdQNWRFTGE3akErUzVLYnF4aDhU?=
 =?utf-8?B?WC9xT2tVTjI3ME1ZRWg2a2hKaXNEZ055OXFkbHk0YnQvSUZPR2F0OTJyYVNr?=
 =?utf-8?B?TW9ZVnVIQWpnK3NWWVpENThzVFdMMHpyZFh3TnBiN0ZvU2cvNmZJQmdXUWhz?=
 =?utf-8?B?dnZRTFB5aUdheDVsSTd5dEhia3lZWWtBdnp0UWFrWDJrd1ZFaDZwdjByNHVU?=
 =?utf-8?B?S2dtM2lFV3VMWWVvUTlLc0tlSVNQU0hCZCt3WUl2T2FQQS9FZ1EvNDB2ZnEy?=
 =?utf-8?B?UzNLVEpTWWgvQWt6ZkNQdjlXcUpOSXBGK1lORXZpeUNUdUlTeTJmTUs0UU04?=
 =?utf-8?B?aUxXM1BPZ3BBOXlNVU5rWklVem5QK1BHUFJHOGhPWXFkNzd3Ty9qRFJmeSt5?=
 =?utf-8?B?OTRySDVpa3dNaEJMUVkxSi8vSnlEUmx2ZkMwTDk5Zm40OFNEWm80LytLRjRa?=
 =?utf-8?B?MlBsMW80R282djczZEVOa0JZWjhtbUdhckV5b3FUREJuT3BocitKdWxDRUg3?=
 =?utf-8?B?b2p2QnoxaDE2ODJoRSs4aHFaNWU0djVvTGNwbFMwRUYxc0dFR0FkRTFSWjNY?=
 =?utf-8?B?YUtzalJiSGVFdUdmeHhyL25hZE1sZUdVTFhxV0dmdmh0eFhKb3JKRHpyMzhR?=
 =?utf-8?B?SU0wSk9xV0VNMnJuNEEzc2VBWW9hcFBCS1h4aTgyaWd4bHltN2xvbDc0dGtt?=
 =?utf-8?B?SFVaOGV2QzArblpham9BOWlkS242SDlhcUI5L3lCT2RjMVJPRjFyMlYyV25J?=
 =?utf-8?B?aElFN0JMMm9iUjh0WTIyeG9oNTk4YXk5SWVtWlY2bTVqQmw1dDYzZGlTSm9h?=
 =?utf-8?B?eXN2NWJSeGQ4bHdseFVqRERRcTVuY3FrbTYzQmJaTVFSODRlOGUwYW5nZXdN?=
 =?utf-8?B?N0FpcXJyVFMwWFM3dEpzSHdYYnUwOUhSTExkd29pVFRrSEtVY29OV0UzeFFk?=
 =?utf-8?B?dG55Sm9vdWx5ejkrR0FKMkJaMWY1U21ML1k2c3FFZEQrbDhuTFVoTVdjVmlz?=
 =?utf-8?B?dTcxTmJ5S3Y0U2J4dk94VXlHK0JoY1cyZ0JyeHVlREMzS1k1L1BIdlByVnhE?=
 =?utf-8?B?QlltcGpzalNlR1A1YWlOVk5MMElFUzRiNk9rOVBVc1E5dEJJV2ptOGNBbDQ3?=
 =?utf-8?B?VUl5d2x3K1BFNktoK3B3VTl1OE5XYnJCYVo4T2NkOVJjdGdkdUt0L3V0K1Vp?=
 =?utf-8?B?eDFJbWZJUzRxN1dIWjZPbkZlQ1ZnN3RnMjNYNmhsYVVSb3V1TDJyUk80cFpp?=
 =?utf-8?B?V2xqZmlhQWMwTlp3S1c1amlweHJhT0FDbXlLekM1YVE0QjZUclRobU5XelBh?=
 =?utf-8?B?K0RKY2lzTUVPaFBiQ3dXdzltUlpmQVIwdkk1MjlTRFNPaVJKOWgrR3N0K2R4?=
 =?utf-8?B?c25PUkZWZmRTM3NQMnhMbXVCbUVQNzNYWWZxaGVtNnZneWQ2MFJNYVhWWWFU?=
 =?utf-8?B?cUVBais3c29FcGEzSHJlN2Q2NVBuL1VJUVBkQURDY0hvWiswV09lbDhURU9v?=
 =?utf-8?Q?larc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2821e5-318e-46fb-5a91-08de3d8aa383
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:37:59.3161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoE2ayhgx8DCWYZ/oVwasDW4vzIUVuYKw/Ao7nZDjJlAIvWmGb0Fo75WZpd9qquV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579
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


On 12/17/2025 9:06 AM, Philip Yang wrote:
>
>
> On 2025-12-16 17:35, Chen, Xiaogang wrote:
>>
>>
>> On 12/15/2025 10:56 AM, Philip Yang wrote:
>>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
>>> to GART as mtype RW caching, to reduce queue switch latency
>>>
>>> Add GART mm_node to kfd mem obj to free the GART entries after
>>> MQD mem obj is freed.
>>>
>>> Use resource cursor to handle VRAM resource which maybe on multiple
>>> blocks and use cursor_gart to handle GART entries.
>>>
>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 94 
>>> +++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>>>   5 files changed, 109 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 4f8bc7f35cdc..d7bf96a7b6b2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -880,6 +880,67 @@ static void 
>>> amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>>       }
>>>   }
>>>   +/*
>>> + * Same function and MQD description from 
>>> amdgpu_ttm_gart_bind_gfx9_mqd,
>>> + * except this is for MQD on VRAM BO and use dynamic alloc GART 
>>> entries.
>>> + */
>>> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device 
>>> *adev,
>>> +                struct ttm_buffer_object *tbo,
>>> +                struct drm_mm_node *mm_node,
>>> +                uint64_t flags)
>>> +{
>>> +    uint64_t total_pages;
>>> +    int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>>> +    uint64_t page_idx, pages_per_xcc;
>>> +    struct amdgpu_res_cursor cursor_gart;
>>> +    struct amdgpu_res_cursor cursor;
>>> +    uint64_t ctrl_flags = flags;
>>> +    int i;
>>> +
>>> +    total_pages = tbo->base.size >> PAGE_SHIFT;
>>> +
>>> +    amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, 
>>> &ctrl_flags);
>>> +
>>> +    if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
>>> +        amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, 
>>> &flags);
>>> +
>>> +    pages_per_xcc = total_pages;
>>> +    do_div(pages_per_xcc, num_xcc);
>>> +
>>> +    amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
>> no need use cursor_gar. mm_node->start + n indicates where to update 
>> gart page table.
> yes, that is the last version, change to use resource cursor for both 
> gart entries and VRAM pages
>>> +    amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
>>> +
>>> +    for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += 
>>> pages_per_xcc) {
>>> +        u64 start_page;
>>> +        u64 npages, n;
>>> +        u64 pa;
>>> +
>>> +        start_page = cursor_gart.start;
>>> +        pa = cursor.start + adev->vm_manager.vram_base_offset;
>>> +        n = 1;
>>> +        amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>>> +                       flags, NULL);
>>> +
>>> +        npages = pages_per_xcc - 1;
>>> +        while (npages) {
>>> +            amdgpu_res_next(&cursor_gart, n);
>>> +            amdgpu_res_next(&cursor, n * PAGE_SIZE);
>>> +
>>> +            start_page = cursor_gart.start;
>>> +            pa = cursor.start + adev->vm_manager.vram_base_offset;
>>> +            n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, 
>>> npages);
>>> +
>>> +            amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>>> +                           ctrl_flags, NULL);
>>> +
>>> +            npages -= n;
>>> +        }
>>> +
>>> +        amdgpu_res_next(&cursor_gart, n);
>>> +        amdgpu_res_next(&cursor, n * PAGE_SIZE);
>>> +    }
>>> +}
>>> +
>>>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>                    struct ttm_buffer_object *tbo,
>>>                    uint64_t flags)
>>> @@ -1017,6 +1078,39 @@ int amdgpu_ttm_alloc_gart(struct 
>>> ttm_buffer_object *bo)
>>>       return 0;
>>>   }
>>>   +/*
>>> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
>>> + *
>>> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
>>> + */
>>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>>> +                  struct drm_mm_node *mm_node,
>>> +                  u64 *gpu_addr)
>>> +{
>>> +    struct ttm_buffer_object *bo = &abo->tbo;
>>> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>>> +    uint64_t flags;
>>> +    int r;
>>> +
>>> +    /* Only for valid VRAM bo resource */
>>> +    if (amdgpu_mem_type_to_domain(bo->resource->mem_type) !=
>>> +        AMDGPU_GEM_DOMAIN_VRAM)
>>> +        return 0;
>>> +
>>> +    r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
>>> +                     amdgpu_bo_ngpu_pages(abo), 0);
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    /* compute PTE flags for this buffer object */
>>> +    flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>>> +    amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
>>> +    amdgpu_gart_invalidate_tlb(adev);
>>> +
>>> +    *gpu_addr = mm_node->start << PAGE_SHIFT;
>>> +    return 0;
>>> +}
>>> +
>>>   /*
>>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>>    *
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 25640bed7dc9..9f07856433fd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device 
>>> *adev);
>>>     bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>> -
>>>   int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>>>                    struct drm_mm_node *node,
>>>                    u64 num_pages,
>>> @@ -191,6 +190,9 @@ int amdgpu_fill_buffer(struct 
>>> amdgpu_ttm_buffer_entity *entity,
>>>                  u64 k_job_id);
>>>     int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>>> +                  struct drm_mm_node *mm_node,
>>> +                  u64 *gpu_addr);
>>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, 
>>> uint32_t type);
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>> index f78b249e1a41..edb72f4ef82d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>> @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, 
>>> void *mqd,
>>>             struct kfd_mem_obj *mqd_mem_obj)
>>>   {
>>>       if (mqd_mem_obj->mem) {
>>> + amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
>>> +                        &mqd_mem_obj->mm_node);
>>>           amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, 
>>> &mqd_mem_obj->mem);
>>>           kfree(mqd_mem_obj);
>>>       } else {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> index 14123e1a9716..5828220056bd 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct 
>>> kfd_node *node,
>>>               kfree(mqd_mem_obj);
>>>               return NULL;
>>>           }
>>> +
>>> +        retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
>>> +                               &mqd_mem_obj->mm_node,
>>> + &(mqd_mem_obj->gpu_addr));
>>
>> Here you create new drm_mm_node for gart page table entries. Before 
>> that amdgpu_amdkfd_alloc_kernel_mem also creates gart page table 
>> entries and drm_mm_node. Is there duplication or how do you handle 
>> the entries/drm_mm_node from amdgpu_amdkfd_alloc_kernel_mem?
>>
> amdgpu_ttm_alloc_gart allocate GART entries for GTT domain only.

Why still need keep GART entries for GTT domain if use vram bo through 
GART here?

Regards

Xiaogang

>
> Regards,
> Philip
>>
>> Regards
>>
>> Xiaogang
>>
>>> +        if (retval) {
>>> +            amdgpu_amdkfd_free_kernel_mem(node->adev, 
>>> &(mqd_mem_obj->mem));
>>> +            kfree(mqd_mem_obj);
>>> +            return NULL;
>>> +        }
>>>       } else {
>>>           retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>>                   &mqd_mem_obj);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 06cd675c9e74..55738b30c2ec 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -253,6 +253,7 @@ struct kfd_mem_obj {
>>>       uint64_t gpu_addr;
>>>       uint32_t *cpu_ptr;
>>>       void *mem;
>>> +    struct drm_mm_node mm_node;
>>>   };
>>>     struct kfd_vmid_info {
>
