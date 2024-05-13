Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AFCC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 17:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB36110E8A9;
	Mon, 13 May 2024 17:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qIvcaTGq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B8510E8A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 17:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdOTbV4ZNALo2oVuWviV2FSANckWnkWVu4TgxD8GExeFLKFaSkIpw9QqbbDuvQbxAUYR96nifu2t/POaxoiy6F1tbVN0cbWHXmAwb25tiGB73EGRH9Ug9cAI75ExfBPv4WSTROsohsOCZpdzzwyTc/0NOKPMo/nm36OdRfq2mW9AEns1BBiAuLTqZMIVitwooEwByGr0Gzg98+MtEdF9nsNujM3Vk/TDR9f1/3bEBzKFydfJ7r70Z11UL4GRsbflvhiTOHtBR8e8g0wSjC2JGQXJgLEoEJENnDJTgEco0ILWA2gu/GI2QRMyOzeOkoHTE8dNd00wSSdZN3GSb7FNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU0nxqDaaUGmd0g3Zm7uwytRODD2uCadQ0X09v7T43o=;
 b=jL1iNFetkSFE6MLaRZQqZ9R5HE5VFFU/yzhX0yTF9tAtGdZeO1X+28LAVI3fmh68YBS4BcdHRFJ2BgDZnnlb3HlM+4xYcru+Op9GbSvZjIeWcZSdjdpke2HKnWdAtLSaAkdPJQ68AE6wVJs7AlJDYk2nDhyhs1nautcppdO6oWcd+kXTnS9AkTCVm/ERQOUEjf94jiy53pQr/lSGKHarqJHCyBup2pI4QyDjDZp4CiQWP5MkwEJmp7i9xbdNaWJg4GdlU+jqA45jAjmjBlQqS1CxGRBAK04jDVrmt6UiYr50fcHC1335VF2/3Y/kv+z5XJnJziunddDPfI5Pxphr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU0nxqDaaUGmd0g3Zm7uwytRODD2uCadQ0X09v7T43o=;
 b=qIvcaTGq95CC62VJDTpt/yGRVOpgn6QXH1JnQcDqP68arAQFGQrYnVz3NIfsz/FNQiKl/mbfKsezmgiLmxTee5FHC5VCbYQ6OWNYQI+bLBTETJp08qs3DRmUT5MxyyDicrVpAQVxl5GqrKfgnYRF42JUfvFABIF1WOvvA2p5HuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:47:39 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:47:39 +0000
Message-ID: <0f87ebbc-0980-48ab-88d9-a21a2207d56b@amd.com>
Date: Mon, 13 May 2024 13:47:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: remove irq disabling in vcn 5 suspend
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com
References: <20240509184032.1463021-1-David.Wu3@amd.com>
 <ee168145-3baa-4d87-b92a-b0f696a7d3d6@amd.com>
 <51404285-759f-44f5-9e38-2144206e7c0c@amd.com>
 <f49c9171-bed8-47ce-a2e7-0a91a4f231cf@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <f49c9171-bed8-47ce-a2e7-0a91a4f231cf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::23) To CY8PR12MB7195.namprd12.prod.outlook.com
 (2603:10b6:930:59::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7195:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 7528cbb0-4b34-40b8-bfd6-08dc7374c825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmZ1NnlMejF0Ni93djVkUGdjSWJwOEd4YXlRMkIwMmtGdSt2b25qWnBIYkoz?=
 =?utf-8?B?Q29DVndzNWozTWFpOVkzTVEyTWdDMHE0QUwxYW9tL2MyYWpHMnIxTDhSSlVn?=
 =?utf-8?B?azVYcDVHVHZ3VDIzNFkyenVYZlp6bEVJaiszTThRRnJkZWpYNnhjZHNDL1FW?=
 =?utf-8?B?WTJOSzhDNlZvR2V2dVVZbi9iTDRhbEk0U0tmWXh4Vkw4RUNMWWlyL1poN2ll?=
 =?utf-8?B?MWFkRTg1R3ZYZHFRczFEVDcwU0pvRWJaODI4VDF5enQyN3g2SDduSEpSbWh5?=
 =?utf-8?B?aHhJUUJhRXZoaitSZHdUTEhYYkMrYWtEQWNQd3NTNmlPN0FZZTFDNy9iQldu?=
 =?utf-8?B?U0RBSFNzZ3lLV1ZML1NTRVpNbUFqdEZkQnVReGE0WXRiRUczZUYyY0swK292?=
 =?utf-8?B?aVpWWWFCM1pHYTdrbkpPNDVuRUZVUGFHZ1RQc216aUhuTkFLd01vWXEwN1dZ?=
 =?utf-8?B?T3FQelEyZ1Zqcy9ETDhBd0YvUFJIb1lZc0tKNU1PQllNSE9yUzduWENmRlhx?=
 =?utf-8?B?L2lpYWVXTkxpUVJ2cUFWdXBuMnNqanRnNlNGOVBxODgralNhampLZmJmQlJq?=
 =?utf-8?B?cU5vNGJsTEQxK0IyRU9uMzgvWUNRd2FCSHRiNFhrUk1FbWhIVDRyMElsd0FL?=
 =?utf-8?B?SjhsdERkZXYvUmJDbk5Lc0ViUzNuSzhobkROY3lyU0t0SVRaWEVPNXBKdi9h?=
 =?utf-8?B?cXEyZnNTYlNCZGZnM0hMUVZxSkNaN2lnK3JRYUE1cDVHVWplWWNpMjJCMlRh?=
 =?utf-8?B?UENVUXhlWUYyYTlVdnNQTWlzbmpyc3UwR1phVjV4Z1J3Rks0R3FnNi92d2hs?=
 =?utf-8?B?SnIxNzBOVUlwTVZyVFdZblB0aEo2UnRhcjNXVDNzYVM1ZkQxS1lKM1pBTHZH?=
 =?utf-8?B?cGtOYmNaWjJUUEY4NHo3RldlVjNja0taT2VGVUt4bzlCeURacmc1L3VoUjd6?=
 =?utf-8?B?ekRoYkYyY3lMdmpQeEdaTSttelNuWjROajI4MWhkMWVwWFhTR2NnZTllUWVi?=
 =?utf-8?B?OEcrUHgvaE03TU9lYmtjZzNXMkNCZ0Ewd1dGVTB6QVl5d0hsRDJ1cE5SNGt3?=
 =?utf-8?B?dm9jQVdvV0Ribm5ab0lGZ0Y1SS9yUVJnaEx6cXEwNmt3c1huQWlBeEs0bFZO?=
 =?utf-8?B?RzB5T05Ia0xmNFNiYi9OM2NLaVRHOVJVNGNxcGkzbDUwSUlGZ3NGTk80QVlW?=
 =?utf-8?B?YlEyaGk4dHc3QlBKOTBjMjBUMHB3WTlONkdLNVFyVXZUQVAxNklzckNqb1Bz?=
 =?utf-8?B?TW4xY2JIWFFCTUJ0V25QMTZsNkVRTysxbkovaXpXUW52YldIRjZSTkZBRDgy?=
 =?utf-8?B?c0tjREZ1NmtNU0ZDcmVvK0NwbEhjL2V1bURKZWVtbFhreU5CT05yV2VFNEpU?=
 =?utf-8?B?Z0hUWHM1bUVFR3hNUklLRWtRemx6OTNnY0hNT0xhblhybTZNaVR6ZkQzdmxl?=
 =?utf-8?B?T2ZBWjI1MWZWelhlZW9MN1hKcS9MQ25TUjF3VVdNUGtrWmZ3VGVMT1BYZXlY?=
 =?utf-8?B?cVRrSXRLVStvR0YzaXZRTnZpMGE5TzZMUDl3K3FLSVNpYTNkNTVhdmJwYnl1?=
 =?utf-8?B?eVJsMjR3WHl3bDRycUF6Qlh4a1hLRUw2eFFUWVlEOGxTczM1ZUV3NFBrUjRa?=
 =?utf-8?B?ZmlQYkE4T3BpMnhtYUxZNW9vbmQrRzlOb3lqRVMxQW5Janc5SnJkUi8rQ2Vr?=
 =?utf-8?Q?+lN4VLIy1nCNvCHTOZtt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7195.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BObWJJakZwajRPZFJ4ZU9qSTZLeERZbDFXRkJ3SDVyaENtWTlhcXpVcXpk?=
 =?utf-8?B?S3k5ZjZoOHppbkl2cXVRRFhiOW90b284WFZtQ1czMXNvd1VITnFTMkprK2pF?=
 =?utf-8?B?RzNCQXRZbGMzNE9jQnZPaGxXSzNFQVRaZXcydmFKSDN5b05SVGNldU5iKytD?=
 =?utf-8?B?K1RxV0Vib2R5ODMzeGIwbHB5eXVvdG1iK3YyaFp3enVEVHNiRlNEYmcvcHNL?=
 =?utf-8?B?cy95am56M0g3KzNsNmhnZkNRNW96eVFWMFJ5VW5RaHNwZnU4d09HTlFKSDhv?=
 =?utf-8?B?elpveGx6VmNCaEhMWWJ0Um5PYitub2pORVA5NjFVZmFOenRXcytmaU5DdWlo?=
 =?utf-8?B?WTFUTmtWQWtWd2tqS1c1Z0JLVU5zSUhOTWQ4bysyenZZbmJRNFFqNHRseXkw?=
 =?utf-8?B?ZkZlQ3RHR2tFTk1id1V3enFMMVpONFl0R2dvcmZ1Qi9JNzBma3dlU1JHaVR2?=
 =?utf-8?B?aWpXRWVsZ2lvcnFzVDBqQUtudEFxcVBFMmxQVzF1QWtpR3VsckFaM2NmMjdz?=
 =?utf-8?B?U0ZOdXFkbmdRbzZLNjZVSE1OWUxDUndVNzArcWFxY2dxK0QxVUZpTGY1WHF2?=
 =?utf-8?B?dFpMbm5qS2JtcTdWYWVQOVJvaFZoaFhDcGI2cEh4NDJRclU3NllVSGdUNGZl?=
 =?utf-8?B?bkg2R1lEaTQ1K3VXbVdNeHRYdjFpT1J1eFl4Y3V5VUZ6UkZtTEE3ZHJkcHR6?=
 =?utf-8?B?YU1SaGdlNHlaeEtMTGJWYy8vRkNRUHlNVHhFYmV1d0h6MnVmSUFvUmhoYXhF?=
 =?utf-8?B?NDVncVlZN2hpSXhNMm9hTHdZTExTRExEdkFSU0d6OUJ2UTd2TzNlSUJkVFYr?=
 =?utf-8?B?VkREN2JNb01mNmlqdkFpR3h0bkFTUUlSSi83ZWJEREJiV010L1ExM3ZrZExG?=
 =?utf-8?B?R01tM0xRWnY2cHNRd2JGOTZHd2loU2VpaE53aTF2RkRiZWNJbGs2d3MvcVpS?=
 =?utf-8?B?K1hMTEZIVXhEd1FGUzY4K1pSQXBWVkRGa2lVTmF5Y3NLMHgvM1NpYUQ1MG9y?=
 =?utf-8?B?VHgyOEdzck5PeUVTSzVKRFpkY0pZNXZPZ0JyR1VQT1dRRUVIYjFUd3BKVHdO?=
 =?utf-8?B?eVFRUSsza0ViaTFidENXdTZ1MWFiRTlCTXdrMUVGYm9wV2FoSWZrUEtIa2k4?=
 =?utf-8?B?Zkg5U0ladzh0RVBsOTF6S21FNlh1Vm5nR1R3cjlEOUJBZHVUTkdIOVNMM3FN?=
 =?utf-8?B?czhQY212TmtQOUVQY1RyVkwvblJFUENRZ2pQWFpWV3pjMjdud0lDbFJUUHRK?=
 =?utf-8?B?L1pycjFKeVFVbGFMc3RoSnQ2cGp1ZXlad0FRUWYwUzl5UEtGMG1hclZUNGhh?=
 =?utf-8?B?Ylg1MFlmMWczdjRERHF5cllyelJoemJ3U1lCL3JES1I1ZWliYUpiQmxJMnl2?=
 =?utf-8?B?aThJdTljeWtoOGE2dXlYaUc0N012eVdRVUYzOVRmR3lpa0hhZU96Uy9pTWpV?=
 =?utf-8?B?ajFWSTF2M3kxVnEzZzBsT3pvNXlocEJzUmdNczlDbjIyWUxsdThETktITHFy?=
 =?utf-8?B?ZUNtTnJFNzRpUUdiZ29YQzFHdGZONTkya3hKRUhVbC9WWCtqRElxZ3BGS1c1?=
 =?utf-8?B?eHg0aXJvUDNONDN5aTdqVjQzTEJlRlQzY0I2ZnI4aGkzQ1JlUVRzZFZrU1Zx?=
 =?utf-8?B?VjhlaFlQTlp4cVY0cGRHSXpXOUpWYUtUZkVoRVE3eEdhd2tFS1k4c1hDM3c5?=
 =?utf-8?B?enQ3ci9pTjdXMXlPd3dLKy9xWFZnaVdYU2VkMG43WGJDaEg4M25nQUpUYXBB?=
 =?utf-8?B?STZiUFNzM01wenAzVkVNR2FvdnNxdktndXJiWm1CSlFFS1B2TzZCSGxnSDRR?=
 =?utf-8?B?dlh6RCtwMmVMNzBYZHFCbVp1bkpFd2p4Yk5EeGtPRFpxVmlTRmFTdTlOOWlm?=
 =?utf-8?B?Wlg3QTZ1NFpUZS9SdkpjYUp6MnBWYkk4THlDWWpIa2ZOWElOTUJDTWZZNkwx?=
 =?utf-8?B?VERXd2llVWgySUZvdWtIM3htaENCdEJTSjZVMytscnVsR1VPWHlDZUtSRlNt?=
 =?utf-8?B?bGowalR1RFNzS2paR1lzSWlNTlN0dEJUQ3RmclNFclp0UG45cnUwdHVFMkdk?=
 =?utf-8?B?b2krWGR3QjBDK2o3UlVuVkZnSEN6M0JDb1lNTURrQmdmaDdLRzZjZk5VdWZm?=
 =?utf-8?Q?TvvJEVBKJgPLBBwYuzDGQJmNr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7528cbb0-4b34-40b8-bfd6-08dc7374c825
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:47:39.2213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPN4tS2KnqGZ02/VnFPMKCLnlYMM/6959kZSeG6MHU9dQcRk5Sd3UaETwb908yyhltdBe27+PwGf7sahMHXEgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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


On 2024-05-13 13:43, Christian König wrote:
> Am 13.05.24 um 19:41 schrieb David Wu:
>>
>> On 2024-05-13 13:11, Christian König wrote:
>>>
>>>
>>> Am 09.05.24 um 20:40 schrieb David (Ming Qiang) Wu:
>>>> We do not directly enable/disable VCN IRQ in vcn 5.0.0.
>>>> And we do not handle the IRQ state as well. So the calls to
>>>> disable IRQ and set state are removed. This effectively gets
>>>> rid of the warining of
>>>>        "WARN_ON(!amdgpu_irq_enabled(adev, src, type))"
>>>> in amdgpu_irq_put().
>>>>
>>>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 19 -------------------
>>>>   1 file changed, 19 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>> index 851975b5ce29..9b87d6a49b39 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>> @@ -229,8 +229,6 @@ static int vcn_v5_0_0_hw_fini(void *handle)
>>>>       for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>           if (adev->vcn.harvest_config & (1 << i))
>>>>               continue;
>>>> -
>>>> -        amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
>>>>       }
>>>
>>> Looks like you can now remove the whole for loop.
>> I realized that but there is a new patch added inside this loop to 
>> cover the suspend/resume issue.
>
> Is that added in a later patch or did you rebased your patch ontop of it?
>
> If it's added in a later patch then it's better to remove and re-add 
> the lines. Otherwise you can get a mail from automated scripts that 
> you have dead code.
>
> Bit annoying but the documented way of doing things in the kernel.
understood - it is added in the next patch right after this one - so far 
I have not got an email for the dead code yet. If it raises an issue I 
will  work on it.
>
> Regards,
> Christian.
>
>>>
>>> Apart from that looks good to me,
>>> Christian.
>>>
>>>>         return 0;
>>>> @@ -1226,22 +1224,6 @@ static int 
>>>> vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_s
>>>>       return ret;
>>>>   }
>>>>   -/**
>>>> - * vcn_v5_0_0_set_interrupt_state - set VCN block interrupt state
>>>> - *
>>>> - * @adev: amdgpu_device pointer
>>>> - * @source: interrupt sources
>>>> - * @type: interrupt types
>>>> - * @state: interrupt states
>>>> - *
>>>> - * Set VCN block interrupt state
>>>> - */
>>>> -static int vcn_v5_0_0_set_interrupt_state(struct amdgpu_device 
>>>> *adev, struct amdgpu_irq_src *source,
>>>> -    unsigned type, enum amdgpu_interrupt_state state)
>>>> -{
>>>> -    return 0;
>>>> -}
>>>> -
>>>>   /**
>>>>    * vcn_v5_0_0_process_interrupt - process VCN block interrupt
>>>>    *
>>>> @@ -1287,7 +1269,6 @@ static int 
>>>> vcn_v5_0_0_process_interrupt(struct amdgpu_device *adev, struct amdgp
>>>>   }
>>>>     static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
>>>> -    .set = vcn_v5_0_0_set_interrupt_state,
>>>>       .process = vcn_v5_0_0_process_interrupt,
>>>>   };
>>>
>
