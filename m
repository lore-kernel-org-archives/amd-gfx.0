Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1ADCCFA0D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 19:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94F910E32E;
	Wed,  5 Nov 2025 19:20:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qYV1wB6r";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B72110E32E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 19:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb4Q2RdFp2awed37vwR18SolgYNWMh4q/ytKjJ4Tr9j/TbbA4BDU/Dy0Nb6D73b0vkI8Wa3ObL8lRd6cJxvUyaDNisHfH+1HS0Dn8rkscr3C4lr893qeUW9qH+kWRYurJp/TP9SSLQOO1K/G30lyZ0j0R0oi1lkpLvVAshvDS3xG0MHU+T0Ub6e7K1Fc6EFUwJRW4UftmgavlTlIUhJVv4qALYwfTvpc2NRwBm9+b3IcCM31HxJkQSSTjdeEqivwYfcf+yPuL3ZxSd4S20FEPYisIAIFvkmal3sP58ydCj9vo4/ZYwGy6FT6m7t40561IyX24PVEGJtyUQM+vxe8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Jnzd2o97/zMHSzPOx4lkbtBpRk/Q5fzha2PuvNFIG0=;
 b=kna2KG6nUbW2El1mwhIJsPnmjNjxaZcOJOmEM1PSuPNEr0SD1Ng0eAvP7M37fGKhRKXcGj1frz7fKwsn/xxhkn5maQY6iDSjZRPmYcS/xkXzvr8+ruUljoULqrRG/b1FZ/xYqIfCrYF8WhmsJNEs4y5R4SpCrSGKyDwisy3viuP9gF+LvcaSWPPAMH9AZD1ifV59WV3wDiRVH/amzEyHSoQiCoHuHBRsHXwADaYT08VHvReWIOmEA27pmVwG5ESeynDP81NK02zgrQKYjgfQFXmPExXP4utIeenAdMpADvb3NMrOBWHl49c+P6+garRXeQyN4q7bhyxd8Tm5TBr+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Jnzd2o97/zMHSzPOx4lkbtBpRk/Q5fzha2PuvNFIG0=;
 b=qYV1wB6re78dzS8s5SXnKo7wxEW/PaWzLcXddrPSd1gC0rHt+z+Grd3yDelIi3Uk5CfzP79GRKkCf5flmWXjSPENmi141U1wuqck8cR6UEnyLc4ove6qV6gX/pb7xjRweAMMGqjKmOTuFZKda3A5lhgEv3vbIFUy55piHb01zH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 19:20:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 19:20:33 +0000
Message-ID: <3a266b61-1893-465c-afd7-515147af747c@amd.com>
Date: Wed, 5 Nov 2025 14:20:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix GPU mappings for APU after prefetch
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, Philip Yang <yangp@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>
References: <20251103222127.3095970-1-Harish.Kasiviswanathan@amd.com>
 <d6a6ae67-6b7b-4cb0-83f2-d1f2624c2f4d@amd.com>
 <81e2acea-f45f-cda8-66a1-3c37f3aa2e9c@amd.com>
 <17b23439-8064-40b5-bf8f-b424bd087e63@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <17b23439-8064-40b5-bf8f-b424bd087e63@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec8406c-5484-4533-9bb2-08de1ca0641c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGhEbGZ6SFpjZnVXRHZwUFNMR3AveW1HOEd2UmRXZStSUWhMOVIzM1hrWjVY?=
 =?utf-8?B?K1B5Z0VvT3lZZ2VKS0h0UWZrTUM0VnVHUExoR1hYcHFxaGdrSlgwejBzY1hu?=
 =?utf-8?B?VDhYSVVDbXJsSVg2NkhyaTQ4NEx3NHZYc2FDb2Zta3hJanhmQlVrd3RWU01y?=
 =?utf-8?B?OUVsbVpTTXk3cGViaFZGWWUvbFFpNjhESzg1UEw0QkxFdHlGd0RON2pVS2ts?=
 =?utf-8?B?dk90eFdIaW9FZFNYc2xlUi9HMWhaaVhIeGZsSVVuRUhyeElYUWh5Y3NKV2tH?=
 =?utf-8?B?WkdROFMxdkhqcFRFM1FmdzU2N0I3WmQrOFZxSHd0cGRFaWhFZEZvL1JjbDRu?=
 =?utf-8?B?K3pacGF4UzQ2SzVxZkdRaDU4TGpTRzc4WExqbERhdWRyU0ROTmNCcEMxdHEr?=
 =?utf-8?B?SDR4TitkRzdicTNvL3JZZHc3Z1BNU2IwY2M3NHBOeTJ0RXdxTHFtckZYRVk2?=
 =?utf-8?B?TFIzZ21sTVFsNUhKQ285UTlLeG9HbHRVdW9GL1JlQ0Jkd1pLRTVnUHY2M1Ex?=
 =?utf-8?B?b1hvTTQwejVzbUZ4NHluVkR1ZnpFWU1zdVJ2OTRSQ0NKUzdsVnFZTUxPMndh?=
 =?utf-8?B?akdaQmUxQmRJTE5HeEJjZUNVV0pxbXZ5d3Q4eCtzVmFKNUE1SzhCYkJLK2Fv?=
 =?utf-8?B?Yk53NTR5amJEZ3lzNHJVWDk3TzlaWXl5VGNEUXJmeUh3S0g1Ym9EQlR0cWN2?=
 =?utf-8?B?WFJ3MUZ4U0FDMlJDdVVjN08yVHRKVHYwWGtWaElTYllXdXNIMlJPMGNTc0h4?=
 =?utf-8?B?bGQzWk1RMkR0OW0zL2krcU9meEQ5VlhYb3FwSCtWZTRGYlZLbjkzSmZaZys4?=
 =?utf-8?B?bDVTVm1meDZNYml3dnFMUkRBR2hQWkNZczJITUdReFVFNGQ4RWQ4NTNkOEgr?=
 =?utf-8?B?TnVlUWJGK0RDY3QyWkdtMW13YWpuN01VRVlTNVp4VGROTGZVVlNtM3M2RmpC?=
 =?utf-8?B?WFRpSjNpY3pWYVozRXk4TFJUWWtqdTFPd2d6eDNMeHZjS244ZDBjc0hJbWVi?=
 =?utf-8?B?UWtxQ1NyQzZSaXRXcGZNOWcrRjhYdm9sSU96cGFUM24vZDlTRUcyOFVyT1Jx?=
 =?utf-8?B?Wk9sMVhNUGpjQTNHTFFwdWNsQ0hqK2x1c0ZFTktzOU5WZy9iNHFHL3d1ODha?=
 =?utf-8?B?UlFxWTNBTDR1SnR6bktzYzJqQkF1VHZDUkYyNkcrWTRnUkc5NlBITytaa0VX?=
 =?utf-8?B?MUE1cmhaQ0FSb1lJZXh1NzZvQmZ2RzdDeUY0bXppbEZJeFRoL2puaCtyZnZS?=
 =?utf-8?B?SVdVSEdoQnR2UjFuRVFVUTU3T05sZ0RxVmhIc0FuMXQraEt4bm1Jck5Wem1X?=
 =?utf-8?B?SkU4M2h0T1MvTXNmUGRldUxYUVFDaEFtVDhvd2FMcWZuaERYQjE4WWkwOWEr?=
 =?utf-8?B?bHNyRTFnNGVjKzZha2R2QlhxRTFFNXNERmlXS3o3SmYzWHl0elRjTS95dzdQ?=
 =?utf-8?B?N0h4bVpyc2pnZ0kwNkVkYXp2c3hxQmdudWQ2Znc4c1VOeWc1WXRma1FFZXN0?=
 =?utf-8?B?am1KZGlNdEFOV29ZTGR3ZUlrUkVhSURUY0REbE9YUXhyL0lQdTdJNFoxWEdk?=
 =?utf-8?B?S3VQZDFrVFFIQ0hhRkdmTklRZ0lPaTRHUjVRWEZNempiWThBdXBSTkxNdEZM?=
 =?utf-8?B?UmRRbDdHM1E3aSsxbzJPWlVaR3o3VWc1QTdLZkR3a1VGY1dqdzl2TnFMR1Va?=
 =?utf-8?B?Y1lmOHpWRjdoZTQ3cFRvcnljb1FFcHdyc0JrYzdzYkdzaWl6QlF5eU9RUmdX?=
 =?utf-8?B?cG9jaytpYW9kOU5Cb1ZBZVdiUWMrRlp4Ulc2YWEwajAzenVxeGR2WHIzNDQy?=
 =?utf-8?B?OG1UcGplQnM4T3pPZVlmYktaejEzb2xYdEFWcWgwUGFFcC9nZ29TbndMSFdy?=
 =?utf-8?B?ckxCZFdwYkxZbnpYQTlnNDhuWGw2cVRDUVVNclE1QjJJOFI5elNCOW5reUtl?=
 =?utf-8?Q?j6JTJMKgyYSzt0bbs598RGxYknUvrXtV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M29RTkp0M1pXOGViaGU3MnpRc1o2UmNxQ25SSGtmeTFaMVlUMEI2ZkcwbWM2?=
 =?utf-8?B?SUh2L2pJK0lXL1lPWEhMYWMxWjZVMmxVQTBsNVpGZktCTW5XVHdmcGFUQWR3?=
 =?utf-8?B?SEdhaGc1SGRncXlpdWUxSm1ETDZvK0c1L05IczFBRUtObkR3KzV0Q3RHTXhz?=
 =?utf-8?B?TUVXRnJ3eG5qaHZ5WGg3OVB5MytDSVNtWkdSN3k3M2Zwc2V1MUxPL1Y3bnNE?=
 =?utf-8?B?VVFFWEtPeWVyamdmVCt2bWtOdU1oM3NiVVhRcXBoNnpnbkN1SHgvSytSamRH?=
 =?utf-8?B?dVBpU0dxR0dVU2FNS1ZVY2lzNXZ5eUFyUFR4a0E2dnBMSDNsMStOTlpiZ3NR?=
 =?utf-8?B?c0ZrTWFNcWh4QStkOFNIS2t6WklNQk9iR2pwZXEvallka3ZZQlVvK0U5TFQ3?=
 =?utf-8?B?QjlmRzYzZDNpUDhTZ3NyMHJWVnlhNXNwNWdUUkVpRXZNbDBudmFrRkpKR2s5?=
 =?utf-8?B?cis5S3RMRWQ4S3lFbTd3WkoyZzN3T3QvYUZxbjRDb2s3QjlHd2JPb0lmS2g1?=
 =?utf-8?B?c2luSFhXYlE5ekxxRlJSRzlSY3JJbHAySlZOMERmYlJQc29DUU1VNFhsUzE0?=
 =?utf-8?B?ZGlObGx4THd0Z25xZERzMi9samczSFhGT0hwdmUwQXN0SStBVnVabUtNaWI1?=
 =?utf-8?B?ekN4TTVXQTBTdEY0WklNcE1jM2lCbGw2VzY5blhaZjc1QXF5aUhWdkVMdVIr?=
 =?utf-8?B?N0xjaHFLT3BpcGFCYlFKMGNiYldjOHVoNzB1VlVYNHBZMVVOTHU3Z2xuVlhk?=
 =?utf-8?B?VTJpZHZoZFgxd3pFNDdFNzE0MXVyWmlvWnQ5aG1ncW9jdldtbkhhaVVXRE9Y?=
 =?utf-8?B?NWg0d3Y4blJveGpkbkgzUzJrcC9OeHNPVkhLN3Z3SkhHSnhTOUt6TzBYaG5C?=
 =?utf-8?B?SU84aE93TU8vOWpwMjR2bTRidUZDU3UvZTNFd2lvZ1pJbzFEWFNNS3NVTFVF?=
 =?utf-8?B?Z1ljSlZjakhyR2F3QW55d2JZaWJ2WkVZZDdGN2hwMnErS1ZvZ3Y3NGhvNXA1?=
 =?utf-8?B?VFNERGoybUExOEx0bUNGdTJ4VU0xVXJFWmltcFRWYXplTE9SS1E2blBKSHd6?=
 =?utf-8?B?YmNOSGxDbDVEMzdsTTBiV0JKamlzQ3NSWGgvYlRPVWF3bkI5Smh0anI4cGta?=
 =?utf-8?B?aEJhaU50bkpTTzE4NGNIZzlYOEFiZWFmNGsxc05kMTlUYzB3NHdDMThyTWpO?=
 =?utf-8?B?VmNDOFM4WjFHRDRoTTZlc3BoQ3BpNEdSb0lacGFxQjhKNmZvS015VkhwcVFQ?=
 =?utf-8?B?anpWa3NqM05yWm5jbTM0N0JxSUsvY05Kd2M1RG9ObjJzMXlrS0JENFI1Mk9n?=
 =?utf-8?B?UkovdjBZcTl0RXpxd3g4UjBvVEhBSlpUZzFmVGhpN09UMWNpU25UU2VZZXpm?=
 =?utf-8?B?T21TbkY2b3VLRTh1amhRODhBbHFEbVBKb3lOSDhVNnhTNnRaWHlJTStxc3ps?=
 =?utf-8?B?dW5EWWdoVFp1Q3h5R1V2UllGNWtPSjl1dGtFNDgwM2JOQVdiaGo4cllUN1Nm?=
 =?utf-8?B?U2VKWGtjRHZEUGxSMXY4V3pVTU02cHAxdGlsU2VJL2hzTWpnUnhycW9Hb1Z3?=
 =?utf-8?B?TUNqRTIzazA0cnlPTnBWS1pRWEFzNTZXWnBSWEM0YTVrNW45ek5JZE1YSys4?=
 =?utf-8?B?d1N0MHpnTG4yLzQrM1llR0VYNSt3UUdIM01TTHg0bGxDcGRkckEyVWR0Rml0?=
 =?utf-8?B?ZE1HZEFjd0pwNFZObi80QmgrUEx1YnZVOURrS21QK3I3bjBSblpVTldPWmxj?=
 =?utf-8?B?Tjc1dkF4Smx2ZFE3RkNUcm8vUTBkdG5CYlkzWUttcy9IcHNoSERRd0VKcTVT?=
 =?utf-8?B?S1NEVUk2NEpVVTg3eE44bmxSRHdUTGNOLzVNVVFneDdqSG4rMFBqMjUzR3hH?=
 =?utf-8?B?QnVmZVNLVkxuRmx5NlpNYXFuYUR5M2tod1cwNkE1SXFyMjZjTGIyengxcXRC?=
 =?utf-8?B?NEhsYitwNE91eldDakM0Mnc5MytvZHpmcHNDR25ISlBqUndYMlNtNUNwazI5?=
 =?utf-8?B?R2JRZG42c29zZVltMkNJUDRwTWJlbS9wTHRrSkhjcUpIZ3ByQ3NOSi9Td3dY?=
 =?utf-8?B?SFNLOFU0TTlxTjNmQkNXdkF3ek84ZTJuZmxKR29vR3EyY1l5Z0xCU3Y1RDZD?=
 =?utf-8?Q?QgqHxqvVrr6xAINxuQ3umvDzM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec8406c-5484-4533-9bb2-08de1ca0641c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:20:33.5731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1luPgLB5ZILjCpMYZZiNqqU96BOxT+GbowRe0eZ4Q6xBZebj0WCZLG3QbJX53Sho8nJttLKUeDAnLJy++8UgXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
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


On 2025-11-05 12:02, Chen, Xiaogang wrote:
>
> On 11/4/2025 10:35 AM, Philip Yang wrote:
>>
>> On 2025-11-03 18:25, Chen, Xiaogang wrote:
>>>
>>>
>>> On 11/3/2025 4:21 PM, Harish Kasiviswanathan wrote:
>>>> Fix the following corner case:-
>>>>   Consider a 2M huge page SVM allocation, followed by prefetch call 
>>>> for
>>>> the first 4K page. The whole range is initially mapped with single 
>>>> PTE.
>>>> After the prefetch, this range gets split to first page + rest of the
>>>> pages. Currently, the first page mapping is not updated on MI300A 
>>>> (APU)
>>>> since page hasn't migrated. However, after range split PTE mapping 
>>>> it not
>>>> valid.
>>>>
>>>> Fix this by forcing page table update for the whole range when 
>>>> prefetch
>>>> is called.  Calling prefetch on APU doesn't improve performance. If 
>>>> all
>>>> it deteriotes. However, functionality has to be supported.
>>>>
>>>> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with 
>>>> carveout
>>>> VRAM
>>>>
>>>> v3: Simplify by setting the flag for all ASICs as it doesn't affect 
>>>> dGPU
>>>>
>>>> Suggested-by: Philip Yang<Philip.Yang@amd.com>
>>>> Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
>>>> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index c30dfb8ec236..26eac89c90a8 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -768,6 +768,9 @@ svm_range_apply_attrs(struct kfd_process *p, 
>>>> struct svm_range *prange,
>>>>       int gpuidx;
>>>>         for (i = 0; i < nattr; i++) {
>>>> +        if (!p->xnack_enabled)
>>>> +            *update_mapping = true;
>>>
>>> If you want always set update_mapping, set it outside loop, not need 
>>> set it during each attribution check.
>>>
>>> And I think the discussion is setting update_mapping when there is 
>>> split for prange. If change existing prange attributions without 
>>> split, not need update vm for 
>>> KFD_IOCTL_SVM_ATTR_PREFERRED_LOC/KFD_IOCTL_SVM_ATTR_PREFETCH_LOC.
>>>
>> Maybe change like this
>>
>> @@ -3800,6 +3800,9 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>                 svm_range_apply_attrs(p, prange, nattr, attrs, 
>> &update_mapping);
>>                 /* TODO: unmap ranges from GPU that lost access */
>>         }
>> +
>> +       update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
>> +
>>         list_for_each_entry_safe(prange, next, &remove_list, 
>> update_list) {
>>                 pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>>                          prange->svms, prange, prange->start,
>
> When prange got split the overlap sub-range is linked at insert_list, 
> not remap_list. Only when overlap sub-rang's start is not aligned with 
> prange->granularity it is put at remap_list.

insert_list and remap_list are not mutually exclusive. They use 
different list_heads in struct svm_range.

Regards,
   Felix


>
> The current logic is assuming overlap sub-range not need remapped 
> since it was already mapped. For huge page mapping it is not right. 
> Seems we need check insert_list: always map pranges at insert_list, 
> and prange at update_list if  insert_list or remap_list is not empty.
>
> Regards
>
> Xiaogang
>
>
>>
>> Regards,
>>
>> Philip
>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>> +
>>>>           switch (attrs[i].type) {
>>>>           case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>>>>               prange->preferred_loc = attrs[i].value;
>>>> @@ -778,8 +781,6 @@ svm_range_apply_attrs(struct kfd_process *p, 
>>>> struct svm_range *prange,
>>>>           case KFD_IOCTL_SVM_ATTR_ACCESS:
>>>>           case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>>>>           case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
>>>> -            if (!p->xnack_enabled)
>>>> -                *update_mapping = true;
>>>>                 gpuidx = kfd_process_gpuidx_from_gpuid(p,
>>>>                                      attrs[i].value);
