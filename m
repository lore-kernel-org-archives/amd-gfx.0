Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBE3C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CECA1138E1;
	Wed, 24 Apr 2024 08:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rArWa93X";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B6181138E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9ohYSfHVMmWg0vGVD48B+RXCJ3n4OU96sokn4DXl6+g/NG/ZLNIRnvW0XuAUJog+3YMGjW/PeT3HtA0bciASv1/ltwbIlW0B5wqlEUm2oAPcTcgWLnTFnZjb+W5P1mDO/JrnR/yj7Yh2inZGtsIELT3oisdcFJ3pn7wPY6ezfTn3KpAtLA0b3Zr7BzmKHDOlcTyecdFTMUOTUBNX+HKufvdNLpRbpJNNUybUOxLSTYWaoPq2hAl8rvAE2pbegd6kGByY374G8vtUd6jcs7kn3YwiYzdkjn1xqwhaR2PoaESF4UROf1YxTcu6yOwp62TQ1YxSqGqe8lJzAxOrXs4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M7bKlCGCHSgIIZGjWt5EUm/bCUaNFLL3ia/DLdFgNA=;
 b=VTfTM8IvyF+uvB+gbbNCj2KViNkWZgWieCNVF3OZYaIQ/WMS57ycHsVtPiwBeDIyOTKtu8Mnp4qgSEEjRR9yP34uNJXiNDvnkaVeGhbe4yyEq5uAWC5D9jtlm44H4Vmo1EYnLcQVmT/cRZu/9DqnxAYQn86kggNUAddNFnnvJRwmk7bGqfRFics6FO0SXeWCjYs5CsnCR+nmV/dbUUfxSCX4TRpvWGlpd86G/wkcQjyCby8CcAgjQgB49gSM0isuUS4GtyCQU1Hd+/VGTkJa6EN08xBK/7caKCNERJ0hueBKztqpabLqvc0vwLqcLTYKaOwypwhmaFov5j0CNSZYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M7bKlCGCHSgIIZGjWt5EUm/bCUaNFLL3ia/DLdFgNA=;
 b=rArWa93X3VoIwlrHxjuvO8WrzIwQB5W1k4LOHiddBtoTNpbLd0fb3cr4wij5qPy9foAih0y0pPgMxUaYg0xRW9jfSGijAobiIN9yXDUzsKBlMyPYgKNMrChOORF51PIFzJ5koudgoIry2qAU2ZENjekY5QAD5HEozFYSTx3E4t4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:11:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 08:11:43 +0000
Message-ID: <0a0868d8-ca36-4d18-a90c-90e6cff8bd00@amd.com>
Date: Wed, 24 Apr 2024 10:11:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix some uninitialized variables
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
References: <20240424011940.723906-1-jesse.zhang@amd.com>
 <CADnq5_MZeCg3dUnkCmKXu-m1Kp01yR0h1uz2htKoWaQdbj-+_A@mail.gmail.com>
 <DM4PR12MB5152BC1A6ECE3A5F86B55667E3102@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB5152BC1A6ECE3A5F86B55667E3102@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fc5142-77bf-4f01-e04a-08dc64362d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUpZaXdvOEhvU2RldlR3cU5pRHBvWUduYllEVzlJUndQNWJUMWtpKzZHREtr?=
 =?utf-8?B?OWRaazJQUWlSV2lXOStHcE56ckRBbW43Ym9tRjI5dWtobW1uOVgrZ0tTMWJt?=
 =?utf-8?B?SHdoS3MySVZXVXdyZVlyU0liYVh4RnlhTkNhS29zeTljdHJxSWpnMG9FMTZh?=
 =?utf-8?B?bUN1UitpendJc3VJRlFDMmhKQ2xoNUVncXFZRllzVWVwbWVKNjJqTEpKSjhL?=
 =?utf-8?B?aDhrMkw4QTR6R2xZc1lnNGM4YnllV1R2QnpSdHZqcm50aXoxanhHcEZ5aHB3?=
 =?utf-8?B?eWdiQXFaV2hwQnVzSzA3N1k3TFRHcUdWb1p1TG1YNDZzTkpuZXgvV1ZIT2VM?=
 =?utf-8?B?cmxvcUVCSEF1a0FubHE2UUp0ZG8yREloaHNaaitzcEdQd0V2OE1RcHd4ajZF?=
 =?utf-8?B?WE9HT0hPVEhCWEUxaDk0QW5saGNCVUdzY0l6RXhnbFlzTEp5eUh0MnNVam04?=
 =?utf-8?B?bzlub3ZXZ3l0M3lFYUxycm9KRHNLNU1LVGpBYWp3ejYyMUZTTlcxTDBpU0M4?=
 =?utf-8?B?cURBOTM5OHZMRTZtd3kvNUNMZTFiLzkyMGRuTnRBWklrWmxGS0tZLzd2VXor?=
 =?utf-8?B?a2s4Y3VDY0ZjU1JRTm5ldnQ1OFlDcWZvYmRWMUVyMEJtVVlVWkR6UWN0ak9I?=
 =?utf-8?B?dWtiVkFWNFlLZFZRY0hEU3FBOGFyTE10N3BLSVRwdTZ1OWpJYUxzQVVmQkk1?=
 =?utf-8?B?RDIxNDBoZmlTUFM5MWxzakFxTFJrTVpXUUxWak9hZmx2UElLQzV5eHF5c0FK?=
 =?utf-8?B?WkR5bjRVRU9PQVBUSHRZeE5iQVVjUXc1emZJYkZFYXFxczV5N3RiMlgwcHU3?=
 =?utf-8?B?WXlFVUdCYzhDZUVRWlZ4MzRNRkoxbXA2dE5sS3h0czhZbnlFRkVWamZ5YXFX?=
 =?utf-8?B?TnBhZytueVRCYVQzMmZEZ1lSemhUMTlwS2k2SllEZ2VKdFppcnJ5WS96NU01?=
 =?utf-8?B?YlpGVHlLMFZZcmtUdVozQlVHMk1WUzAycjVjaEVaWlBGdnJhc2dTY0lhVWlm?=
 =?utf-8?B?c0tOUmJFeVdxZDFla3BkRzBoRU9VdVEzaFNnL0hOVXptQWR2bmg5Vm1TYmhs?=
 =?utf-8?B?TEFkVTZFSkQwVFhtRGdaWkxRc25DakM3VG00Q1V6aEhTclV2NUhqeVdOVFpD?=
 =?utf-8?B?UUg4T0E3L3F5YWVYZGd6dGxFNkEremRDRU91SkwrYzBrTisxMWdaVHRmODAr?=
 =?utf-8?B?ZnVQMThsSVkrdStUOEhlZ3NIRTRWalM5dVltTFlJdGxSYUE0ZzdNVDVQdnRX?=
 =?utf-8?B?MlVlaWlrQTB5djlaYnJDenFkaUVNWWs5QlNvMHR5eG9ndXdQVk1wNlByaXJu?=
 =?utf-8?B?ajhJeHloQUV1NWZmaENycDBnRFNxSnVqYzdtYzlWKytPaEw2UEdjMlpNWXdT?=
 =?utf-8?B?ZHNkMkZjcE1DZEJIa0pqNUVPY2VlS0d3Snh2bjBURDBpdUNEbE13TEhjK20v?=
 =?utf-8?B?R2lOZHFHSVRPd0QrSHBZRDQ5QS9FVW4vZHkzN1BZelZWcmpEUHN4RFl0VW9s?=
 =?utf-8?B?U2JIZXFNMFRPSHdPb1FzVXJha2RYU1JLN1BTMFZYb2d0VTUvVmxYMDl3d3Fo?=
 =?utf-8?B?eHlKTzVXNVFaZ1A4Sk40dEtBTytFeldQblUySDdlSDIvRExTbWVuM25NNG5m?=
 =?utf-8?B?aGxIMWU5cGU0RFdKcktjQzVUY0FWZk16OFVFVVJDeWJjTCs3WTlxZDFWaktR?=
 =?utf-8?B?ZUl6anNtNmMyZVlYa0wyeW1HMEhFTjVUa0NIS1FQb2I1bUZoT0xIbmd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdMaGZDR1pGOG5aNHNKQVFZc1Z2SmVLYXd3Z1B5dnBvd3RZbStZRDR1QVF1?=
 =?utf-8?B?Y0pzTy95blBhbzRGMFZkWE5VUDdLZy96bnpURjVLVE51Z01zZU5CeVRBbmZj?=
 =?utf-8?B?NHVPUmc5VFhlZUJNa1JjdlpWRmdhMXVOZ1c4dWI5WDNIYnFXanZBT3VRelBY?=
 =?utf-8?B?bVZITS9jckxuaUZYaGJZWkl5ZmdkSnFRUXlmdThFR0FZeVZEMXI0WFVGWWEz?=
 =?utf-8?B?OThDK1lYa1QvV3B6QjFUWlRucHFlTVpNOU1qL0htSmZHRDVoNnB6aWxXTElT?=
 =?utf-8?B?OEN4blc1Zng0Y21aelREQVNTSERKZm94bUd6cW05S2o3SlFyVHBCU3BsMStY?=
 =?utf-8?B?eXdlUFhUZkdCbkN6RXlyWG9MUGdFYkJMTGRyd05maEFvWThkdUJjdndDamJS?=
 =?utf-8?B?TEswalFyYzI1VHJQRk9nbmowaTlCOXpmNW9Ba3FIek13NTlCNURSVUMzNFBY?=
 =?utf-8?B?d0krRGtqano2N3RPUGFqcmxBUWU0LytOWERwdXFzcEdyOWFTbnI4QmE2QUpz?=
 =?utf-8?B?R3Z5SWNmMVJ1bmRDTWlGTkJ4WnlUQzZNSTRvSUNoY3E4NUtwM0drSWY2Qm9I?=
 =?utf-8?B?ZllGZG9rYXpxVCsxKzBqYklBSXJkMzZzWWJyVy93emxBSFUwS24vUDNyRm9M?=
 =?utf-8?B?SXRRTHN2U1J3MGJnN01EQitTNkdHSitEb2ZJVkFyOVZDZzJLU3NaUUJZa2Z3?=
 =?utf-8?B?QUZRYnZQWUV6UFZXWWhiZFc5MVZzSnBxc3RxakMwa3pHSmQrdVdKRWZPTkdx?=
 =?utf-8?B?aGdpZFBIc2VJZW5BMWRJWlJvZVJNb1dtdjFqdDN4RUpHT2F6RGE2dUJRVnlj?=
 =?utf-8?B?a1p2MERxTDRoWUpWQlgyTjFMQUJJdXNRUnhOSlJDOG1DRUdwVi9PMFROTytS?=
 =?utf-8?B?YmZTQ1Z3S0Q0Sm5DZjQ5TFdpMG5WaU5va241SUlDTysrRlpqZFVsYVF6b3Nq?=
 =?utf-8?B?QUFZREdUNTFhWDJUblYyWWk3S2lsaUNCNzZjMndCUFFYcUttL01YdXprc3ZX?=
 =?utf-8?B?S094eXBkTjlvbkY4a0x4VzdKa1NWYzUvWjFwbkNtK3JLcnpqMVEyZHQ1WGMv?=
 =?utf-8?B?M0R0VWpUeW42T3VZNjRZMGppcU5SempkL00yUU9lNlV3Q01mYlVDb3JrM2Rp?=
 =?utf-8?B?L01TOEs1Sjk5dUhqdWRoaCtpcTNraU43MXhML0x4SU5FcTd2aTBxNWFFdlFO?=
 =?utf-8?B?ZTJ2cTM3TlNWTUhWb25sTUpOSHJZdUhaZHdaT0JyRlZSNEVrSzdRL2xPWmFo?=
 =?utf-8?B?K1MyUkpRcHhaMWJwZU1LQnpiYkNMZG1IUVFvWXI5TzhGUVFnRy9SQlo5QWt6?=
 =?utf-8?B?OVZJSDM1V1krcXluM2NnNGdiZTVQOHJjTEFxOUVWWTZLZkh1MmwvbVE3Mkdl?=
 =?utf-8?B?NlA3b0cxVmJVL0RRU3pXWlhFMU5vZUErcVJZeGtnZ2RrY0grVk54VkVNTUJL?=
 =?utf-8?B?a3JsTHNRb2xQNE92ZUJOTGR5ZDk5djF2TXFCUjFEV293OVZIZEZrcDRqRzBP?=
 =?utf-8?B?NGh6Zk5NZnJja242bzNLZ0VKZUVCNEdZR1RsSnE4RzV2OFZGdTNzVjdIL29q?=
 =?utf-8?B?V3BETFFiN2RQUE1hTkg1VWczMDJyMGVoVlQ0YklwUXV2OHE4Qm9QVjJUTFpJ?=
 =?utf-8?B?ZjB4YWtWZmZpRm1xa1NFV1NiZmllV3VYOWpyL0FDRVdvSDg3TjArbXBJcXA5?=
 =?utf-8?B?M0FjamdGMkFhOG5GTDhGc0pVL3F5TGFnWlQ0M3VkV0lhM0dlQmRqam9JLzZK?=
 =?utf-8?B?ajNhNlg0MjNFM0NYWDhDZVNMSnNabFVlbmtOdmFkUEp1T3BqbXNNYW43TjlW?=
 =?utf-8?B?Q282U1ZLTTVjeDg5ODdSc3JRTkF2blZtSGxuYTJuQ3VJQ1BGYndteEUzZFBP?=
 =?utf-8?B?cXFxQWJVcFgreFoyR3Y2VG9LaHA4T2RBVnJodTZLL1RyZXhLTURqS3M5WDdN?=
 =?utf-8?B?Y3J2ZVFqc2U2RFhBcDE5OUVaMTU1ejNSdlcxeG9XK2duc1JqcXVGNXhPZ0cy?=
 =?utf-8?B?YS9jTzg5UHkrcVUzajVXbWcxY1lacE1ETE5FMDlyQ1lPZWtENm9WUDBtaXlR?=
 =?utf-8?B?TExhV1lQTy9QTnZ6bjExTkJmdGdmemNScjdMRUJROGc0dE52anl1dDRDWEx3?=
 =?utf-8?Q?flEQM9ZaxJM68+yvNRE7c/Xhr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fc5142-77bf-4f01-e04a-08dc64362d26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:11:43.1043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alWtOYiVkYTs6HXy8ybD2COmBe3IV38IbS2nRD+J8wEn3r0pO9Yne6N7Hin1Fgqg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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

Am 24.04.24 um 04:04 schrieb Zhang, Jesse(Jie):
> [AMD Official Use Only - General]
>
> Hi Alex,
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, April 24, 2024 9:46 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix some uninitialized variables
>
> On Tue, Apr 23, 2024 at 9:27 PM Jesse Zhang <jesse.zhang@amd.com> wrote:
>> Fix some variables not initialized before use.
>> Scan them out using Synopsys tools.
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++++
>>   drivers/gpu/drm/amd/amdgpu/atom.c       | 1 +
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 3 ++-
>> drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c  | 3 ++-
>> drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c  | 3 ++-
> Please split out the SDMA changes into a separate patch.
>
> More comments below on the other hunks.
>
>>   6 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> index 59acf424a078..60d97cd14855 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> @@ -742,7 +742,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
>>          uint32_t destroyed = 0;
>>          uint32_t created = 0;
>>          uint32_t allocated = 0;
>> -       uint32_t tmp, handle = 0;
>> +       uint32_t tmp = 0, handle = 0;
> Can you elaborate on what the issue is here?  Presumably it's warning about size being passed as a parameter in the function?
> [Zhang, Jesse(Jie)]  Using uninitialized value *size when calling amdgpu_vce_cs_reloc for case 0x03000001. Because uint32_t *size = &tmp;
>                  I'm not sure if other commands initialize the size before running case 0x03000001.

Ah! Yeah, that handling is actually correct. The size might be 
uninitialized in this function when the command stream isn't valid.

We could instead set size to NULL and check that everywhere, but that 
would probably be overkill.

Well we could silence the warning by setting tmp to zero, but that 
actually doesn't improve anything.

Regards,
Christian.

>
>>          uint32_t *size = &tmp;
>>          unsigned int idx;
>>          int i, r = 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 677eb141554e..13125ddd5e86 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -410,6 +410,11 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>                          else
>>                                  new_state.fw_based =
>> VCN_DPG_STATE__UNPAUSE;
>>
>> +                       if (amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec))
>> +                               new_state.jpeg = VCN_DPG_STATE__PAUSE;
>> +                       else
>> +                               new_state.jpeg =
>> + VCN_DPG_STATE__UNPAUSE;
>> +
>>                          adev->vcn.pause_dpg_mode(adev, j, &new_state);
>>                  }
>>
> This should be a separate patch as well.
>   Thanks for your reminder, Alex, I will.
>
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
>> b/drivers/gpu/drm/amd/amdgpu/atom.c
>> index 72362df352f6..d552e013354c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
>> @@ -1243,6 +1243,7 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
>>          ectx.ps_size = params_size;
>>          ectx.abort = false;
>>          ectx.last_jump = 0;
>> +       ectx.last_jump_jiffies = 0;
>>          if (ws) {
>>                  ectx.ws = kcalloc(4, ws, GFP_KERNEL);
>>                  ectx.ws_size = ws;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> index 45a2d0a5a2d7..b7d33d78bce0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> @@ -999,7 +999,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
>>          r = amdgpu_ring_alloc(ring, 20);
>>          if (r) {
>>                  DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
>> -               amdgpu_device_wb_free(adev, index);
>> +               if (!ring->is_mes_queue)
>> +                       amdgpu_device_wb_free(adev, index);
>>                  return r;
>>          }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index 43e64b2da575..cc9e961f0078 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -839,7 +839,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
>>          r = amdgpu_ring_alloc(ring, 20);
>>          if (r) {
>>                  DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
>> -               amdgpu_device_wb_free(adev, index);
>> +               if (!ring->is_mes_queue)
>> +                       amdgpu_device_wb_free(adev, index);
>>                  return r;
>>          }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index 1f4877195213..c833b6b8373b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -861,7 +861,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>>          r = amdgpu_ring_alloc(ring, 5);
>>          if (r) {
>>                  DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
>> -               amdgpu_device_wb_free(adev, index);
>> +               if (!ring->is_mes_queue)
>> +                       amdgpu_device_wb_free(adev, index);
>>                  return r;
>>          }
>>
>> --
>> 2.25.1
>>

