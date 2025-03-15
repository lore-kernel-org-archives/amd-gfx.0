Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56602C282EC
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Mar 2025 02:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1344D10E382;
	Sat, 15 Mar 2025 02:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c3UrNqBn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1AD10E382
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 02:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGQWhgsg+QUlJRqCv62zQeT4n5SnFQ0ehLRtiPwL9cvqjthc5SlQLHw1qwYhEQ448S9dzOGTYGmYXigxGiCRiHwjEYWbNODirxkx7yQJ5G1s4vQBZJ2fu0+RxUZf1GwCSPZZSFolquvP5whi/OHOXK4E4vSHwuRdqmwbjPkXWQJ6YkMkSV3EeWrQN4EZG8iY4PpquOMfGv3KMN6zzc3vrUOqUa6fi8J2d6AXIU4fhC1b6iSg1bvWblVRPoF17z7kLCUyd96eo38qP8ihYsJJMmMiPoUZuLqyxuQgo6+56F3ExrX9+yt066rApcoN3S9LSTXTRq+VZj63opzn4Y1SrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVsUBR5KvrQeNHyZC07KvDdiRYdxjirxFaiF1TWGM+M=;
 b=Jg5mLcNeXXVpM5Nysr1H7hlqLEBJZodUCDPRRmiBqpAuem9G+uBM/8teCQwftoG5fVkJ5bPJADHS2perOrPDjuEIQT/JYtWi3YgwnBK2AiZK8fGF4yvTQjBkg2BD8keaiSpFlCfDnG7KS9uyFA9PcqMyYmWv19q4SdSPoYjCvZJlkqLIdLNf/uNMyGr0mJtHppBZMvtZbpNNu57IRgaO3ctCDpRpxVIA3+ftj+pZWFfE9DTBRYGtOgOQcw5xYVjbYNZvjX8naQApzGY6rEsOx1d1XlSbiO0pULffRKopfyP2/2xDFUqb4eDei/lODyT6/k6vEYh1DzWudnaZx4IFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVsUBR5KvrQeNHyZC07KvDdiRYdxjirxFaiF1TWGM+M=;
 b=c3UrNqBnqnxZ1MVX1N8kWDks86r98QHdZXHkZxiwYXiZN9GsvWRecTjn/96NeDyhWNpnyeRsQI6S5qIMi6Pkcv/lvResRgk26w1LxUSTFPhMLeiAQu1U9z4F3urtY8QFEFvj801FxCKu9qLGP8Ur6qJihZ2YRkbf0oLOPFZ8Mtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sat, 15 Mar
 2025 02:20:31 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8511.031; Sat, 15 Mar 2025
 02:20:30 +0000
Message-ID: <c3d5f85e-31f0-45d9-9119-5ea810ab51e1@amd.com>
Date: Sat, 15 Mar 2025 07:50:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: grab an additional reference on the gang
 fence v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250307134816.1422-1-christian.koenig@amd.com>
 <de0e6edc-c3a8-4c9f-b0f3-37cfd8776db5@amd.com>
 <ff0378be-671c-4c60-8086-03fb4c21bc0b@gmail.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <ff0378be-671c-4c60-8086-03fb4c21bc0b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: 9889e9b4-27a3-4f97-dbc0-08dd6367f53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzVoNTA5Um5OS0FGcVhCNTB0ZmkrdnVua3UwenI1cXE5ZmxqRWcwSFpaUFg1?=
 =?utf-8?B?NGlpZFdZNGFORGRGS0ZqWDE4UGpWTDVCUXRuVXFZME1MWmJuR2xtRGlDSXdQ?=
 =?utf-8?B?SFVqVU9ic3VkR1hIeVFiMWNlYk9mcEk0TkFSTEZLaVE1L3FPeUd6eFFqSHpi?=
 =?utf-8?B?cmwyMlVZSnExQWloVGdYdCtwZ1M3aHlHMmlVb29tY0Y2T0IybHNhMlpaY3VX?=
 =?utf-8?B?SFhVMzc3ZFRzdHp5RGw0MkhQQmdwM0F1bTN5TWRiRnpOdS9JQU9RLzNYY3pn?=
 =?utf-8?B?UWU0YjRZWk80b2k0WVRvT2hOK09pM1R6dDBqU0FTYkw3N21EWFV6ZGhxdURQ?=
 =?utf-8?B?MjNZRk1kMVlUdHlibnBBMTFvSmNRclg0bDcwa0RvYWhGVERaTm9oNDg4Wkxv?=
 =?utf-8?B?eTRVd2Z5WkNaOFB6VERIcGtEU1lKSU9ybUppSnVHU05yaDBzSlJVeDlPUDhP?=
 =?utf-8?B?ZkFORXhtSXBCY2MvYlZaTkg3akZjdDdEK2xiNjRmVnZLWDIzb2w5VnRNMkdJ?=
 =?utf-8?B?bnZzTTNrRVpya3ZuOTRuR0g3QUZjTmN4aGsrSW0rNWc1aTdrblF6VzBxV01W?=
 =?utf-8?B?L2xtekxJMWk5U053RlFmSW5qdGhzaFhpT2lnenJxa010ZTRmZUtYbklvTFBn?=
 =?utf-8?B?eEpyTjd3VytCZ1BVSmV2SSs4a3VwcUl5VEx2OWo4VDZEUGRMSDUwOFVMdDJK?=
 =?utf-8?B?TzJmZWVsbnlLT2FldHk4NXgwTFpWZ1BsTTBsMW8vRU1vK2Y2WC9WZFhDYjB0?=
 =?utf-8?B?TENWTldBL3UvUDBJQmd4cUtiZi9rei9QS2daSTJYRDcxZS9TdEVmY0JLSVhV?=
 =?utf-8?B?TDc5Sk90T2s2d3dST0pGcktReGpnTTdRcEdxU3dEaUg2cVZNbFhxQVJFOCs0?=
 =?utf-8?B?ZW1UOEpsNW84RUNrWDRScDFack41TEpDRDBYaUd3R05FMWFWZXpWRHlObjFu?=
 =?utf-8?B?b3V5ajBJMEk5NnhYS295N0Jxdm1oaVlPbWhuVFI2dW11bzBhbEZjNE1TKzhT?=
 =?utf-8?B?OGMwelJQQzJiOTZtdFRMSmo4KzVVOVQwS0QxL2VXL1hsME1SbDdQSXlVTDlY?=
 =?utf-8?B?dzdzMDBYN3FoQjNzeVhCaERGNm8xQTlUbDN1Q1IwaDRHQitzVUtVZmtSUTFz?=
 =?utf-8?B?Wi8yWUFlWVl3VEhuNEFmMkI4SHJPcjltVEVnS3R0NnZyWUlVVFNHVHhtRmg3?=
 =?utf-8?B?YUVOa0QxSzc2bHBvUStlY1BDVUN5RlN6djE4NXRvdUpMR2p0a0x6Mi9VS2xy?=
 =?utf-8?B?dnRrZUVLMlM5ZnBVaWlSaDZKWHk5WGluaDY3UFJ1bExtYm9VQmpsSzRMMmZX?=
 =?utf-8?B?UUlQWXJNZ3B0c0gzQU1FcXI4SjRGcXRyQk9NWGFXdEpZdXE1SDRJdXdFWWdM?=
 =?utf-8?B?Yi8xU3ZwQkxGKzZ1MEp2UWFWcFo0dkNjYWs3eVYrSzFxL2dBdG5hYzRTS3FR?=
 =?utf-8?B?SW9EQmZXMXZsVWhIbFUyYWRma0E3N2NVZ1lab1BVd3pyQmp3cEo2U1JjdWxI?=
 =?utf-8?B?QXpqeXBOUSt4UUl2UEluMWJHKzZGMzZmMUJCRlY4M3hQeXZDS1NsUHExeTBE?=
 =?utf-8?B?emRlWTFPOGpSamlTRUhLcjlZZGpzSXBHdXltZVY5U3E1VW00VjY1aG94N1NM?=
 =?utf-8?B?SFRQcU15QVZxSXJFTjFJTWduT2orZit1bjY2d0J6NVIxejFVZjlDM1FUaG0v?=
 =?utf-8?B?Q1NrUXlrRzBvcHc0bm5GTGo0N0R5eCtYRUl3ZEh4Rm5aeXIxUmNOVTV2TEcw?=
 =?utf-8?B?QzNmTkxpQmZXT3VBWXhTK1JiNkpuOVJTeEhjTmp3RnR6cFY5OEEyaDZ1WUxa?=
 =?utf-8?B?eGJrV1dydU1ER3FRSTMvOWl1NkRDVklrTHFhSitYSHV5K0M2SG0wYU4raGY5?=
 =?utf-8?Q?C1nh8A9/4VyPC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1gwWTRsc2lhNW53K0hTZ3RmM0crdzdYWjgzbDQ3TzNEL05iRXJXbm1mMmc1?=
 =?utf-8?B?cXUxMVZRTzFZV3RqVXlRU2FYV0xadkZXdEd6aGRvSVlNNm51RndWK2J1bXho?=
 =?utf-8?B?YSt1Ujc3bzNGckFiZWZ1SW1VYVI5MmxudG5qNWFDOGkvTXNuaDQ1aUZSVTg4?=
 =?utf-8?B?N0hqZ2Fkc2QzdGZDZHRtZWhjbEVBNDlJSFV3b2xiZjY3d1lXTWRGcWdoZmU2?=
 =?utf-8?B?RzRRVTJUMWo4QWV4U0NERm5tZXM2WElpUWh0NytRd3l1WkxXcUFxblZRcThr?=
 =?utf-8?B?cGMzZmEzSWpTL2cwbkxEOG1kcllBRGhwLytwdkxvRXowR0RZOGFNakpOaDNJ?=
 =?utf-8?B?K1ZUc2FLTDFxeXRvbDliajZxblhkZHoyR2JpaTllcHNvOXRxckRFNk9DWTFM?=
 =?utf-8?B?TzYvSEtXdGc3MStBemVvWlhYVVJXSlBUK1llOHN2NEg1a0drRkpFRnFQSktw?=
 =?utf-8?B?WmM2RGhURXZEL0U5TzUyaUhHTjdTYy9WZ0N3TzNKclJhQzRPdW0xWEJtdmxZ?=
 =?utf-8?B?NVJZblpLKzZXcGp2R1hoZFdXOUpSMDYrOUp5NjdzTU9yYnZxRlhDc0FKS0Fj?=
 =?utf-8?B?V3RxUThTdEpqSEI2TVBsTzB3dlhKdExHci9VNzJLNStZVkI1Y1Mva2Y4T0FG?=
 =?utf-8?B?YjFOZ096cGZpNEE5c25pL3QzOWExRDBqUlpZVi9hc0wrTlNuNlBncEdjUGd0?=
 =?utf-8?B?WnZFSHpOcHFya29Td2tMWU9ob1pubElXNERUOWhvRSt5bmR3bFlTMlBFTURI?=
 =?utf-8?B?SnN4UHNUcDZCWjdzaFhpaDMzU0VXRkRCYUxsV3NTS3VzVXBkaXVCMHVwMXFq?=
 =?utf-8?B?SlpjdlVOaEZ1S2tBYU1IUyttSjBONEtieDNxV2QySkhLeW9QZE5GQnFLVGdl?=
 =?utf-8?B?S0RiOWNqYkZ3Vk83TXFmLzRLd0JwK0txblB3K1o5cWE2VEJLNlRKbEg5eElN?=
 =?utf-8?B?dmp6Z0J5UkswZm9iOXZTTlp6SEJaNEhpb251VlFWS2JpaktTcXpRZS85ZS9F?=
 =?utf-8?B?emV2RWxxYkNjdkdQNVE4SEhjUTlONDJnMFJuNEdDRGRHRDFHR01XREdVdFJ5?=
 =?utf-8?B?TVRSaDZBemgvTkFYQ0F1SXlJTGNmNXJFck1yRnhhdzNCbXhlS3E1YkpUYmZ1?=
 =?utf-8?B?T2VjYjZSQkN4Ull5UVN2SEpDN0h6N2lmbmVLM2pZemsxeXJyVFNCOFBwNGh5?=
 =?utf-8?B?S3VpWGhrakszZkJZQjR0eHZKd0cyQ2htejdlMThSU0d1ZGc5anFvK0hnY2s5?=
 =?utf-8?B?TURwbVRoYjJwcG5od0RodktGc3NnRkRIenBYVFF4K1gxZHNqcVdTZFM4TlNC?=
 =?utf-8?B?L3ZBeGZUcUdINUlZNDhrYmF5QllBU3JjODRUU2Vza1Z2NTEyRWZibjEvVE9v?=
 =?utf-8?B?Y2o4SlI0NUw3QldZT0h4azlPZWI0N2JTakhJZmRLT3IzbFZLTDBEOUdUK2xW?=
 =?utf-8?B?WGZML1JHVWxPVTUvcHE2ZHE2WU9vZ3d5aWhZUjRmUWVIN0cvUFZNaCs3SkVm?=
 =?utf-8?B?T3VtTUU0Q0dvTHNrN2RwQUhWb0VPc2N3Q1VQb1F2NGh4Ykxoc3lFVDlHRmw2?=
 =?utf-8?B?RGxSZnhXUlZkcGt2Y1VUV0lYdERacWpUNVloSnQ3dG9GUjY4OEFLY3Y2cFRC?=
 =?utf-8?B?Yk9FalJhbzJLUlNPRkNsNGpVZDRudlI0Y05IeDdraUpoblo5akFRWVdqTDRq?=
 =?utf-8?B?bTk2cXAxbFB4QzdUYTVIN1UxdzRqUDM1T1F1TDVvNFZqRERYZHVIczdQVUpL?=
 =?utf-8?B?TnJPQ1huSUFSY3haNFI5KzBoeGd1VFJkVlgrcURYQTQ2ZFlqMkJtRmNaRVIy?=
 =?utf-8?B?bUI0U3ljbDBqdjVzRGVRbG1hcm0yT1pCbUNBK2hWTnEwWkdLZ01tNDc1WTM5?=
 =?utf-8?B?eE5pbERDc0pOSnBjSzhXdWIxMTJCaWhWeGJDM2ZBTUdJMmRFbDRhUWNUQjJ1?=
 =?utf-8?B?VSs2K0NOQUNtcmJmbWZIZWRsRTdoQmZsYVRXcFl3ajJrTjZmV2hveXNYbDNK?=
 =?utf-8?B?emI5d213WkxaWDF2YWFhZjhvcnZjanFWOW40NWNNV1pSQTd0TGFlcHhoeTRT?=
 =?utf-8?B?cGZHWEpIZHNQcTYveHRTdEZpZVk3SkRQS3dJZVl5bFU1OStOaGZhM2gxc09o?=
 =?utf-8?Q?VFslvlOh5jEU97sV5s3CkAbn2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9889e9b4-27a3-4f97-dbc0-08dd6367f53d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 02:20:30.7559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UYPhyaMyKpvxDjc4EeCFyBOi1mN6uamQqWQj8bG2/3Ev3N4/9no71sxLUMHMLZuc47gCp8neJ3y3A988rwLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637
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

Thanks for these patches and feedback's.

The series is:
Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

On 3/14/2025 7:50 PM, Christian König wrote:
> Am 14.03.25 um 05:09 schrieb SRINIVASAN SHANMUGAM:
>> On 3/7/2025 7:18 PM, Christian König wrote:
>>> We keep the gang submission fence around in adev, make sure that it
>>> stays alive.
>>>
>>> v2: fix memory leak on retry
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 198d29faa754..337543ec615c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -6889,18 +6889,26 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>>>    {
>>>        struct dma_fence *old = NULL;
>>>    +    dma_fence_get(gang);
>>>        do {
>>>            dma_fence_put(old);
>>>            old = amdgpu_device_get_gang(adev);
>>>            if (old == gang)
>>>                break;
>>>    -        if (!dma_fence_is_signaled(old))
>>> +        if (!dma_fence_is_signaled(old)) {
>> Here, should we need to check ?
> The gang is initialized to a dummy fence on bootup. So even when there is never any gang submission the old value is never NULL.
>
> Regards,
> Christian.
>
>>      // Check if old fence isn't signaled
>>      if (old && !dma_fence_is_signaled(old)) {
>>
>>> +            dma_fence_put(gang);
>>>                return old;
>>> +        }
>>>          } while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
>>>                 old, gang) != old);
>>>    +    /*
>>> +     * Drop it once for the exchanged reference in adev and once for the
>>> +     * thread local reference acquired in amdgpu_device_get_gang().
>>> +     */
>>> +    dma_fence_put(old);
>> if (old)
>>      dma_fence_put(old); // Ensure to release old reference  only if it is valid?
>>
>>
>>>        dma_fence_put(old);
>>>        return NULL;
>>>    }
