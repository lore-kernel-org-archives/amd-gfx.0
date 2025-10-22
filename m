Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89222CCD1BE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 06:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E0210E6BC;
	Wed, 22 Oct 2025 06:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xo9yiKmC";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013022.outbound.protection.outlook.com
 [40.93.196.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21B110E6BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 06:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7UBMSha6MoEygT0l1xgTtzNqF13omNfuIzl7seo+n//VRhye4Jt2N24ZsTnbZfWNipz7v45B0IpowSzm3XEKM2Oh+fvdp6VPsLhiDxmZBadYFqbcSbyGtzJXvGBlc+iykPsQ3ZsKjC9terLWaXOYHy0D2+vSlAC9AIwkgWe8MsyWzEoKjnUFCf121oTDIPJCWPwnWBDP4K5tezZWeQRaSF8vSMFXKLDc+p645uinDaGoLqpyVMrinQdYkK/przh9worZFZVhZOe3F04yhOgg+rKwqZvCSMWMZhalPlq5jwiSZ5G2yoKzE2JH+8Q/ybctIUfXWwcnjPBLLfcAo/U0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqzmdHPwbVkIHbQMxlruuLuf92ZvsX5xzOrXV+y3ZFM=;
 b=MvKIV9pE0gT8b77zQWLOaUhwy4U6VTKy2pIaGyc1O3uVdzjjYgWOKEZ5lUL4f6GGeXRZfgBnkwX1IoI2aWgc9b2QIsoEqiwi7aTaVLLQM8oMawIMa5Z3VvMZWZwArd6Qwp29IFbNbQN5VDv0TKxC/L5C9RYMZmKBLcZpEH+0NuZn0/uFo+Vy6B20FIlZm59nRWYlvxPG0JWdwK1dyILuO1zzWnMT6eo2Zo8D3PzRSjnTzLPn/Y6lUSCuMCHZ5lViWL6iG4MuP8oF8XAiHdpsb+C6j8ttsTwcB4gjvwM4H79GlcyACYGGplrJSQbTlblUV5VTyrrblFU1tQNNFxnQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqzmdHPwbVkIHbQMxlruuLuf92ZvsX5xzOrXV+y3ZFM=;
 b=Xo9yiKmC9sm5t4IAEFDuHW3zO8OBvgJUABCFWaObXghaHMeXbXi/ZNYCOFwXxmK05o0K8VkwN2Mfj9lfEi1pIz/oZd55S1W3o9L9s4NovjkqT8yC601z5rZdA29H+fy/1KuWEDb0V2/BXcCz32tLe/J1TfGr09+CKHZ9uyPEBbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:55:50 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 06:55:49 +0000
Content-Type: multipart/alternative;
 boundary="------------Jjeh4h80Abe2KvOhlIrfeIx6"
Message-ID: <a1697059-f3cc-4a0a-b6b9-fb8bb1b3498f@amd.com>
Date: Wed, 22 Oct 2025 14:55:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 17/18] amdkfd: process debug trap ioctl only on a
 primary context
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
 <20251017084222.54721-18-lingshan.zhu@amd.com>
 <e3069b92-cf6d-4d31-9030-813e5ae8b8f3@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <e3069b92-cf6d-4d31-9030-813e5ae8b8f3@amd.com>
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c853269-87e4-4e37-e1a7-08de1138089b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmNoQzU3Szk0d3RhUkxQQWxMVFZNN2ptTjdnSUcwZUFpc2VHdEcrbmdOR0dy?=
 =?utf-8?B?N0Z2ZjI0T2hodnNLNnVGanovY0Jxamo2dTZ5SGZaVFZZZ2NzdnJ2a0JWemEr?=
 =?utf-8?B?SWd6M296aFdXdU5MUFZaWTlHNFhOa3Q5NkhLN0NCMVd1N3FkWUI0TWlyNzhu?=
 =?utf-8?B?TzlqVUJLTTJaOUdOMm1EajFvMlZPQXp2ZTl2ZTloaTN6bUNqcTJOcnROYlJV?=
 =?utf-8?B?ZWgzcVdlMVF1YWhwRmMyRnhGOEpQTERCM0IvZitJYmsxNWZPb21Ud0dnZ1V3?=
 =?utf-8?B?ZHlONzJydlpiVmdPWVd6TWNCcUFHclh1cHlLUjEvTkxyWWpIaFNWZmd3TEFY?=
 =?utf-8?B?d1ZUYzN0SWZHYUVNQzNGM2s4Y3NEMUtHUGhWalR1NXMzNVYraDFKNzcxcmtn?=
 =?utf-8?B?bENsclkwNnVLazNPL3A1UzBzYWZqYmQraFdWVUdEZ0RyWDlxemFteUFPbnox?=
 =?utf-8?B?M1NRakFrNU5ETFJtK2Fvck5pZUVLUUEya1F6aXlmRWJpbWJiSVZOSEJMKzRH?=
 =?utf-8?B?dlcxa2trdGs0OE9wRkpSSCtMbTdJQXI5cksrSFdLUmJaMTZsenpFVk9xMWpa?=
 =?utf-8?B?aTAyZzN1UXBNZ0kySTFQbDhYMmZmT2tLSnhiVm9FbCtZaGxMRkJVc0QwOHNB?=
 =?utf-8?B?ODhGM0dBZEZpVHBSaGkxaVg4ekc3Q3B3TzIxVWI3U2VOODNUd1hpZVoxYTN5?=
 =?utf-8?B?ZGVlOFY5Y1lTOFMyTVNNTzdwVE9ZOTljUlQydGU3U3gzVE5aRnhlSFRDQnVu?=
 =?utf-8?B?Rmo1K09mY0hTZFM3anhmTlVnV0locFloZSt3eTA1RXk5RmcrVU8xODlpc2J0?=
 =?utf-8?B?TjUrZDNmV0dBbG1sNHM4V1FCQTBIMTkxd3AwdHVyOFREWEhiNERrNUM2aTlE?=
 =?utf-8?B?bTNrV0ZaaEhESUN4N0VudWhUT2RoZ1ZRUnE1SFJuajMzL3YralNVcjIxK3l1?=
 =?utf-8?B?eE12NER3ZFd6RkdidCtMdzV5WFZMWGxDNVdVYWcydXZna2RmeUkzNWlybzhY?=
 =?utf-8?B?Y1psakUrZERVS3RzZWFka2NEREtvNytVTHNlZXhESytqWmJ0VU5ybG4wWEFt?=
 =?utf-8?B?SDhOUTNaVHpJbjRqelF3aEQ0N2EwUWw5bWZ6dWg2MWdsQzVJUk8vdHk0QWRj?=
 =?utf-8?B?NHFEQzhvZWhyOGNiVWRNS3FaU1lLWUF2UytHd25qbkdOV1k4QWkzWmhmSVZP?=
 =?utf-8?B?NDRuT0pvM2pvQnpNd21yekVVdWNaT3gyRWpCM3I1SndhR1dCMHF4MGJzUFdm?=
 =?utf-8?B?RllhV0lvR1phbHVvbEpQTUw1ZkwrRklSU3Q3eWRnT2doRVEzRk54WTJXN29p?=
 =?utf-8?B?NTc2ZnN2d1VSMU11MFl2bTcwWFJraFFNRHRUNGF0aTRKZjdENWFzTk5Pc0pS?=
 =?utf-8?B?WkNWYkl6dzNOKzg2SCswK3Y4ZnNkdS9aOEVsYXRsejFTK2Z5bjVsa2VRZm4y?=
 =?utf-8?B?YWR0c1cxYml5dXRHY3lKcUhwWG1zRlhZVXUyeFVhZmw4eVZiN05peVQ4Ym5I?=
 =?utf-8?B?UmxJT2YrM3lEMDdWQ1prKzlwUExhWjVjaktDVlpsdjN0VTlycEQxbmFQMUV4?=
 =?utf-8?B?d3NpNEh4Q0JZbW0wZUlrTG51RWV0dUVPdHlnRG5RZVgwRkhuME5zME5tcjdX?=
 =?utf-8?B?UnBCR1dCc3A1WEVyeGttZVNxd2VXd3hLbjcwL1NyRnU1Y2JKbFZnbERBSVpz?=
 =?utf-8?B?ZlZPY0tReE1QVEt6dDlZZnM5K2ZnZXNGV3RINzBoTWxCS2hwQUNFazcxd1Ju?=
 =?utf-8?B?YzVQZ0NObU1KTGc5eFJwaTVWTE51TmZlM09VbnZaMzNtdE5hbVd4ZElMWjFn?=
 =?utf-8?B?VVRQMTRLZEx4dnAvWVU1bmNCN2J4bzdTaU51cHFTZmVaT2tORHhUcWRUeklm?=
 =?utf-8?B?eklpWTN5UUdGVWk1cDl5N1B5N1d6Mzc0eVpBdkF0MmQxTnlDRkNFdFNkaGZ0?=
 =?utf-8?Q?eWFiRlttbBY8YktggVKZtmsu3wvPhUJ0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZUb0F0dzlxVDdJMCtPUTduRTF5bm9CK0NrT3IxVTdlalo3Z0EzREpTL3pz?=
 =?utf-8?B?RXJhbGVOenJZdXQrV1lIdmIwTWlxZXEyOGVITjlKbFJSaGVnTExVUmhyZzIy?=
 =?utf-8?B?M00ydExpM29XbTBCdGlZaFp5S0crekJwT2Nua0RvbUpzV0YzRE5SWlUxM3FH?=
 =?utf-8?B?THNhazZzN0dnZmprOGx0NWFTdXJyS2F6dHZPUFRLOXFlOHp1OUxUQ0dqWlZs?=
 =?utf-8?B?bnAyeWtXcGM5RUl1WXdBakd6SnhoWENDSERNMGphNjNPcytpWE9hL3JiTkJQ?=
 =?utf-8?B?Q0FINk1YUndVbHFOYjVDamo3VjRpMWcxK01paTBUeXhrRnJxSS9YRWlPTkpm?=
 =?utf-8?B?THltaEpjWmt5V1hCYWhUTk51RXU1WHc1V244YUt4TzJ5Wk1xRVlUSDQ5djRs?=
 =?utf-8?B?enNBclA3OVF6L0NjdStFNkJkeTh0bDZ0NithY3BJUU91ZEI4Z2IxUnRLakVj?=
 =?utf-8?B?Vldic05ZVHd3eU9VTER5bEFPZWxFYTN1RUloZTUyc2QvelVuTGtkUjFmQ0NF?=
 =?utf-8?B?U1g5VGxSQ3JnRThGS0VhcTgvZG05LzVwRHhCbjdpR1FtUlVobUpNZjU4OTVI?=
 =?utf-8?B?em1YbFErZ1ZkVGFPeWlkeGdkeEtqazFiRzN0Vnp3Q2ZucWJoeTEwdVp4UzBW?=
 =?utf-8?B?UWtqWWNsYVFvV1owUnBrSjVpUkc1TmZoNFpTSkZTKzNuM0hBbFUzVHl0S3lG?=
 =?utf-8?B?ZWQ0dFJlb1hNQXNrUDM3UkxIdmlZNy9jOC9YOU9SbEYzdXFCOFd1R3VGQjJM?=
 =?utf-8?B?aC9SMEZTUHB2enlxZzJ4TkVGNnpNaW45WHlZZnlwekx5cGl0bGpZSU5ERWR2?=
 =?utf-8?B?V3VsOHE4N0pWRVk4WGx5b0VjalViamZVbVNrZURJMHA0SGZuK3VZcFdJNE82?=
 =?utf-8?B?MTNWWUpwNE9mNG4rMVN3ak1Lck95alNXV2lOQWk0Qm5VQ01NdUxkbzJ4MXE2?=
 =?utf-8?B?WHVTWVBJZ0tWRzU4VDQ2ZG12VVROc3ZIdVQwbnN2ajZHUyt5QWluenNTTWo4?=
 =?utf-8?B?RFppS0VvR0JCbmlNVE1BaGY2M0JJVktkYklYNmZPOU5aakxpRWNBQUZpOExk?=
 =?utf-8?B?clE5NWppbEd4OVBLem95U0sxTURxUkRLWU1GTEVyWDY5WVprL20zckUvcDRS?=
 =?utf-8?B?cGkwd20zbkxsL1B3dGVTbTd1NEdvaStFWVZ1b1AyOFRQb1NMNFRIOVd2TGIz?=
 =?utf-8?B?OVorNHpzTFpDbXVKZWV6R1JISlN1UFdlRUVRZndIZ0c5aDdUVGNHRVJ6Y3hv?=
 =?utf-8?B?Slk0TE1KczZPNVJPMXNEYkJnUG55OUhkOWxpVmJSdTJoS2VJeThlRDJCZmoy?=
 =?utf-8?B?OTJrZWdCTkRtRUlLU1RRZU4rbk9nR20zWS9kSUFueWRoYlVKNjhoOXNNTkNu?=
 =?utf-8?B?UnBUN2ZqdnlyVFRYdE9od0dFeTlnVTdzeUdGT1crb1BER3QrSkNpb3ArbVVX?=
 =?utf-8?B?ei9QSm1qOXpSL25TbWczZGR3Yk5kWGVKTmZ6YktUMFNtK2V6cVZ6NTEyNVQy?=
 =?utf-8?B?aUdOaUZFYW00MHllZFRjQ3BsN0pSSGtuMWlwKy9QS3hiSVpPRTBiTUhhbUxY?=
 =?utf-8?B?TjJGL1IzVGNHL2lBOURucGNwdlBKMzRQaXV6ZXFNQ0lVUUdZYVU0QUFmTE5W?=
 =?utf-8?B?S0ErV1dKamFaUlVKQUxyTWU0VzFqYTRsT1Z2d0lORE11bFZjSkFrWjNISmxJ?=
 =?utf-8?B?Vnh1ZWVYSWRkdGZtdTU1VjFyb25pSGJ4N2J0b2daRGc5RmRmenVMM0ViZkp2?=
 =?utf-8?B?aXBsY2ZZN3RRRDhndGp6YmVhZFkwYllreStOTk5Sc2d4NmlpVFl5akk5VjlG?=
 =?utf-8?B?a0VkKzVGNm50cVIzV3pFbXlUS3JJOHNrM2Z1OWVDNTNNWkF2Z2U5bUptb0NI?=
 =?utf-8?B?c0RVQ2dzZUMwQ3g4VGZFMWhZVmZEbUpvNjc0OU1JdFNOaEVEUjZBZlQ2bWlj?=
 =?utf-8?B?MW00eWY1RmhTU1pwMnhBNzM2WUxZVTRLRk5HL2pNbFNybFdRanFoamo0TURq?=
 =?utf-8?B?Y1JuQU5jbC8vcEtUSFI3TEM5TjFkaWsyaHpUZHprUm1zdlJZNHRIZlZXMUlO?=
 =?utf-8?B?SFhLSi9nQk9sakZSRUhpcnc0NnZ5anZJUjlpaTZ0VTR3Ui94clBjczZIa0di?=
 =?utf-8?Q?cure24vDd0JAdA+0Cpxj+UZb1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c853269-87e4-4e37-e1a7-08de1138089b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:55:49.7449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4r+KY6RCCUKinIpgCGrP8bc0wyFaiWHoAaYjsmaDkVdmnEIxThwTAjsyFutmy06FfCs1iDQdnvTLx87q8olpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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

--------------Jjeh4h80Abe2KvOhlIrfeIx6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/18/2025 7:32 AM, Felix Kuehling wrote:

> On 2025-10-17 04:42, Zhu Lingshan wrote:
>> Set_debug_trap ioctl should work on a specific kfd_process
>> even when multiple contexts feature is implemented.
>>
>> For consistency, this commit allow set_debug_trap ioctl only work on the
>> primary kfd process of a user space program
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 73de2de8be0f..7c02e8473622 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -2964,6 +2964,12 @@ static int kfd_ioctl_set_debug_trap(struct
>> file *filep, struct kfd_process *p, v
>>           target = kfd_lookup_process_by_pid(pid);
>>       }
>>   +    if (target->context_id != KFD_CONTEXT_ID_PRIMARY) {
>> +        pr_debug("Set debug trap ioctl not supported on non-primary
>> kfd process\n");
>> +        r = -EOPNOTSUPP;
>> +        goto out;
>> +    }
>> +
>
> This check should be after the IS_ERR_OR_NULL(target) check below.
> Otherwise you dereference a bogus pointer.
>
> We should also check that the process calling the ioctl is a primary
> context (p->context_id == KFD_CONTEXT_ID_PRIMARY). You don't want to
> allow a guest process (using a secondary context) to debug another
> process running on the host, using any ptrace the privileges of the
> QEMU host process. 

will fix, thanks!

>
> Regards,
>   Felix
>
>
>>       if (IS_ERR_OR_NULL(target)) {
>>           pr_debug("Cannot find process PID %i to debug\n", args->pid);
>>           r = target ? PTR_ERR(target) : -ESRCH;
--------------Jjeh4h80Abe2KvOhlIrfeIx6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>On 10/18/2025 7:32 AM, Felix Kuehling wrote:</p>
    <blockquote type="cite" cite="mid:e3069b92-cf6d-4d31-9030-813e5ae8b8f3@amd.com">On
      2025-10-17 04:42, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">Set_debug_trap ioctl should work on a
        specific kfd_process
        <br>
        even when multiple contexts feature is implemented.
        <br>
        <br>
        For consistency, this commit allow set_debug_trap ioctl only
        work on the
        <br>
        primary kfd process of a user space program
        <br>
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
        <br>
        &nbsp; 1 file changed, 6 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        index 73de2de8be0f..7c02e8473622 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        @@ -2964,6 +2964,12 @@ static int
        kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process
        *p, v
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; target = kfd_lookup_process_by_pid(pid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; if (target-&gt;context_id != KFD_CONTEXT_ID_PRIMARY) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Set debug trap ioctl not supported on
        non-primary kfd process\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EOPNOTSUPP;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
      </blockquote>
      <br>
      This check should be after the IS_ERR_OR_NULL(target) check below.
      Otherwise you dereference a bogus pointer.
      <br>
      <br>
      We should also check that the process calling the ioctl is a
      primary context (p-&gt;context_id == KFD_CONTEXT_ID_PRIMARY). You
      don't want to allow a guest process (using a secondary context) to
      debug another process running on the host, using any ptrace the
      privileges of the QEMU host process.&nbsp;<br>
    </blockquote>
    <pre>will fix, thanks!</pre>
    <blockquote type="cite" cite="mid:e3069b92-cf6d-4d31-9030-813e5ae8b8f3@amd.com"><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR_OR_NULL(target)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Cannot find process PID %i to debug\n&quot;,
        args-&gt;pid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = target ? PTR_ERR(target) : -ESRCH;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------Jjeh4h80Abe2KvOhlIrfeIx6--
