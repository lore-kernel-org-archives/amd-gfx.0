Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465DDCF6A88
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 09:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D907B10E6BD;
	Thu,  8 Jan 2026 09:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Av2vV4du";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206D610E6BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 09:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnfEcuPuA7KEmxnrJxyMrgOxgN037i4lmftP+Kuzl+KVfOZBvCaOFh1R/pkk7j5lOHmWtx8vgyT3MWGFOGH3DQoEegWRhoxT2RV449c5SBq7HLXAaDIxvYfzbAjQmSNaMSVzacWq/wdaqFPl+Y2cyHOQVfmmceEmBnJDN6qq/wmPWZMLe/hyxx7faxY3p+6dhvbs8dkFu2zXMnImL304NCt+qckuojtw2iLvzqrE/9r1/1FYj/f5rF7QRMRWD858C3h5Ynq7WvEyNzZ2IO1Rx8nAgA0DnNWmA0UgTa4hAyAj1H3itOwEZ7tGwlBrJgchEd2GjZJ43G90D2c65xEn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y3kOwmtR/8x8gKpdgMzJ7PGpjKhzAifLBvdot6A3LE=;
 b=yKQmjYrrfIPvrlS8CBfy+Ybq8lsvhpwR9+lY60oScZdHhaklUqphSxC+rrZKtuE4AGyZx6H32FaYrUbAcikqzzIjRikfjlIS5hXP3UdNTaeU6+5h7uxDgZ/gvBOwZiK6vfHkViVsju7sG9AE9f/iY515pHQxM32GpEsvnf73bT65I+ZMDkifRNKWsLgLFUg7D0FVK0OBG5WYberSS00z5uQRwuqHo/TUu++oALfctpW/867l4ySdRBccfbBGPPGNQR1sLZXUQmkZyfcMmDdsMM1Mvv1hsxEdGoT28p1izS2UXt0FvnhYrcVytfelZwIxPY17p5AqY+/4BhhG1wO/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y3kOwmtR/8x8gKpdgMzJ7PGpjKhzAifLBvdot6A3LE=;
 b=Av2vV4duG6sTDj0P83D/2HjHgevyToVGB43e04fsN+klxmFyzlUslha/6bJXWeuIV7stZO5p2/3NdxbcAMrNCkUNj5mCY+vU/YR8Fowb+ZKl7V0tTENN9fPtl47SJJyv91qvQYFhUn2/+rBOrDiLZ20jZ/TF3HYPI6EjeWemaK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:15:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:15:22 +0000
Message-ID: <6e9e9593-c638-4654-939a-b6261acea874@amd.com>
Date: Thu, 8 Jan 2026 10:15:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] drm/amdgpu: Remove duplicate struct member
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-7-tvrtko.ursulin@igalia.com>
 <f56064d0-ecf2-45d7-9ba2-15501454fc06@amd.com>
 <4d14863f-89af-418d-b151-0d3f97b26ebf@igalia.com>
 <9cd26795-5ae6-4737-b829-fa90fac9ad68@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9cd26795-5ae6-4737-b829-fa90fac9ad68@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0731.namprd03.prod.outlook.com
 (2603:10b6:408:110::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 035317e9-2ac8-40ab-11f5-08de4e96733e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlFET0FOcHJuNlhnUm1WdFlVRCt3UkovL1llalhzNTBFNDhZVGZUQVl0MWhP?=
 =?utf-8?B?bkdYN3FQdGY2ZTNNUExVM1RNZ2hqQ0VTbUZwWXJGVmVoL1ZzQm9PNlc4QWhL?=
 =?utf-8?B?cmNMYUNUZ2M4VXBVU25tZkJTWllOTWVnQXJmcHkwWHlUeFZQbUJFbTFoWFVv?=
 =?utf-8?B?Q3ZvUjlnaWhoN01ucnJQL1dHVFYweWd3b2F1UkNzTHpBOHBEcENraGpzV0Fy?=
 =?utf-8?B?bzJWbHJmcTd5cmZpa013TldJQ081NGprdUIzMm9xS2R3Vkx6RWlQSHdHeUJn?=
 =?utf-8?B?K3J1SmVwMWhQTzg2SitpYkZFaWVjNUlJSEFUbnJwMk4ySTJLYUN3eHVYTlVH?=
 =?utf-8?B?UzNETUtFSmw2ZHRHdUF5YXArc21vaVQwOTZobWUxWjdrKzdrVDNTL0lKczJn?=
 =?utf-8?B?cGY5czJ2SG8yVHNua3ZkZVFndjFRTTUvUllRU3l4emlIYzVUcThzVFVmc01w?=
 =?utf-8?B?bnZJMVhabjNBVGNOK3E3QmN5RzFLNnpWQ2VGY2RIK2lQZWdxQThXTHFBZS9B?=
 =?utf-8?B?MlJJWUk1Ti9kVUg1QUVJVzB1OW8yYm9mV2Y1WlVOSDNlREhhSVZqRGhtY21H?=
 =?utf-8?B?MkNXMjJBK0RGWFdzNDNjS2tQNWZmanYzZWxBSkcyTjVMMXRqaWtHZGZKZmZR?=
 =?utf-8?B?dG9WTDJLeWFKbVM2RUtxNFN0bHc4VGt2TDVRbGZwRm9LcnV3NTV4WW5yL05q?=
 =?utf-8?B?QzJoZmZPSGgyUWVoSEdDM0hramtMcjN3aDlYTTZ6aEMvODU4OHVMVXNnSXpC?=
 =?utf-8?B?Szg1eVlmSFdaVU45UkpmcUpTdmg4UjNZUUJ3MVUvdWRiZ21Oc0JUcitPeVpm?=
 =?utf-8?B?cmhWWVhBbE13UWp4czFDOUFvSWhydit6RTc3ejQxZGhSNEFGZE83K0VHUDB6?=
 =?utf-8?B?LzVHMzBIWVZaQXUwekZtWVZsdDNBL3N5ZEhjQ09aVVBGbmkvSkh4NitJd0RS?=
 =?utf-8?B?bnBkMi9PMitzMG1PQjRmaXp6OWQ4d3N6bUgwTmxYMVJmWCt6aUhjckhhT09p?=
 =?utf-8?B?eDY2UHBhU0xmSkM1a2ZtYzhkWkpSU2hqOHBVcGFSMWlYdEtJc21wRllpTzBU?=
 =?utf-8?B?aFl4M09KS0ZSWklRaEtZY2xLUHpqWHlOd1UyL2ZwRDl4QUhuT1BpTDQ5Q2cz?=
 =?utf-8?B?bFJtbGFoYUp2U05oMHZiK2xRMTN2NisxWmduMmFGeFhDR3hCOEN3My9tUGdK?=
 =?utf-8?B?TnlkVzljRGgyclYyZTc1QXdIUkdNRmlhUWVtUGc5andQVjVqd3pUZjVDTG5W?=
 =?utf-8?B?V2hWME9qaWxqUytQbk9ReHphNlhYL2doVWRpM2JsS3k3d0craTZySjZUSHVZ?=
 =?utf-8?B?cGtOY3NycjdHYzgyVzg3NzlJNnRrQzR3WEp4ZXd6QUlLbURzaDNLWi8rVFEv?=
 =?utf-8?B?Z09WUVAyR3UvMlNwQ1MzWXQrYVcyQTdURCtsQmJjUlJ0amdjWEExUmEzbzQy?=
 =?utf-8?B?RmM2TFdvTWxndkNiQUVvRmtJNERSWWllai9GQllkOFNTVHdxSzM1VStsbDdP?=
 =?utf-8?B?eFcxWTlQb2NTRDA5VDZpcXl6MW1PeStKWUJmR3pUU2l6aytTdzdEd1UveVcw?=
 =?utf-8?B?ZVY1ZW5uOStTWlpsbnJKOWk3M2U0dHc2RDd4QjNybTdDWWRmWjBsNGRCRUVr?=
 =?utf-8?B?aTVDWm9sblRkU0tlcTNVK3VqU01BN0gwbSs3OExFd0VjOUhQOEo1TE9uNENr?=
 =?utf-8?B?bWtzdlhhaE1NMmppQmlQZGZJV2Y3aHhwa3hWVzFXeStyZlh1S1Y0OWtMMjFF?=
 =?utf-8?B?RitqckRCbVlhd1JBQUVhM2RuQ1pueHZuL04relJTYUhkTG9kTExMdHIyeWxQ?=
 =?utf-8?B?SG9GRk1aVkFobWVBSHh1QWpneGxLZEk2T2tCVE1kZmdSZ1QwUUlaTlp2M1Yw?=
 =?utf-8?B?SUpPZ1Y4aTZWV3U5aFQ1ekUrTTFYbUczaSs2WUNvWGwxRXBWUmZ3MUVMOFdh?=
 =?utf-8?Q?5vBIcxM9OFeNxjdp2yfsSLLRZlKI734N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFd2Uzl4anJzdTBGNTFNelZkb2Fpb1NQeldNWGltZEtnb2xVMjlNNnZHWU5p?=
 =?utf-8?B?cDVMTm0yZGdRU0RncHRNNVlaTEVLSXJZbFpBSE9lQWlFTTBsOVd0VFVyV1Ra?=
 =?utf-8?B?RHY3Lzl1QkZNQktJZTdxK1JFTEJ1M1d0MWdIU3V0T0dUQVJpbUo2T1NBVW12?=
 =?utf-8?B?RFhROWZ6dkJpT0JPZk9QbkZ5cUdZRGxIOE52eEczemRneDhFbUFNRFFibCtV?=
 =?utf-8?B?ZkV4My9VdFJJYS9odVpETlV0Tzk2THdldHNZWUFYRlA2WkUyeUg4R0JlYjJT?=
 =?utf-8?B?ZnE3aUpXblV6dUcwRXQ5NXBqMG9vcWZKME1kQUs3M1lKSW0zMEpmNHFVSnZv?=
 =?utf-8?B?V1hReVBXcEk5c2N3Zk84TEhrSDhjWXJzbGJWMUE5NXY1N2ZhdWlaZHZlL0lJ?=
 =?utf-8?B?QTJxMU92b3krWU01WmZIak9lWjl1Z2NoMExDUjJqV3ZSZ205cVRDNkxpbHZ4?=
 =?utf-8?B?YlY0dm0zV0lCaDNONGZESVNpcVhkamlvZ1NYSjY4S3FYVHJBRkhmVnN0VjhK?=
 =?utf-8?B?Y2V4MVVuVU1TTDFuc092TG1BNnJFbmROUkFRVThFZEV3NDZpcUg2N0RvY1pX?=
 =?utf-8?B?UTdlelJQMkthbFhRSHlEVEkxOXVqdjdnb0xSM3J3YVFVbWxBcDQwRXFBMGJJ?=
 =?utf-8?B?VmxDNzZ1Z29MSXRQb2hiL0JLaFVyU015bmJjRFMySEZiM2FPMEhBMlVoK3Zv?=
 =?utf-8?B?c01WVkZYREw5dWJpalpjZEgraHR6RmdYU3J5dnJydUNRMVRjSi9wc2x5MHlZ?=
 =?utf-8?B?QjF5VGN0V3FJL2ZMT0o1VlNQZkY5Rjk2aDI5K3duZ2cwOUYwUlh5bkxxVnZN?=
 =?utf-8?B?Z21jZFhJUHIyNS94QjlGTzlFWCs2VE1NZk1EbWt4UHhYQng4VE5GNHQ5dVZ3?=
 =?utf-8?B?UlBPL1ZuVFRoOWt1NmZnYzFrRWVJd1dKTC9qcThxVkNidDdVUWR0cWgvclVj?=
 =?utf-8?B?YW9yQ2hkL0tYcVhjbTRnc2Z4TmVUcTRjWHBEN0p3QlBzQkF5QTNQRkxqb25y?=
 =?utf-8?B?T2xUaGsxY2lsS0RlemtKc2xXMFFCeDlXZC9vQmVDRVRjQUUyWFQwK3ZOM21V?=
 =?utf-8?B?aEpRRzJhaThRMTVBMHJMMjlFbU95ZHBPc0kvLzRkaHhlOHBrWlpUbzByUVd1?=
 =?utf-8?B?eXFhRk51M3BMWG9xS3RleXZrRG1nUGtweDVPQWlsTzJyRldFeURDYXJDVkZu?=
 =?utf-8?B?SlVJaUhRQXFkNFZ6cUg1ZzBMaUMvWCtjQWo5bThpRkpZTFJxOGNZdk5ZZ3Jr?=
 =?utf-8?B?UERkdEE2UkcvWm10R2pqajhwZmNldVNsQmtUZ081d2FrMkJtTjNwd0ZvMkVQ?=
 =?utf-8?B?dkJPZjR1aGlzeTJtdDVnQnNiYWFiZTZ6RHpnUUV0enhWYUlmcHpNK0pVVkc2?=
 =?utf-8?B?YXFkZUtBcWxRc2p4WmZpcnE3NEpzRDBZYXFmMjVudDI0TEtlN0k3YmhRRXBi?=
 =?utf-8?B?ZXcyTzRMZDZGenFlU0lKVnIxQkJ3aSt5Zy9pQ0x3djVOZ3hpQnpPVk5UajVB?=
 =?utf-8?B?aGR1ZXlzZWtRTURleHhHWTFsc3VrVGQvMWNMaGtES2lBdFVWTnVKWDVIVkw1?=
 =?utf-8?B?QUEvcTc2NDZpZ1ZOeloxVXRaa21ycnljZTZqeUczM0IwZ1NQeC95UGVvZzFF?=
 =?utf-8?B?TkU5czkzVWZGcC8yemxVc0RSM1IzcDA1S0NzM2lFaFErZVAyMEtmT2M1Yk5D?=
 =?utf-8?B?RExYUTd5aENwcjUzUDdDUU55MWFhRGFXaUIwMnVHTFo5cytUeDRFR0hOUVBL?=
 =?utf-8?B?RXltRWhtcXQ0b3JLUHZjN1o5RHFPTFRIU2FWNmJ0VjRDT1p2c0Y3aUZZNDc5?=
 =?utf-8?B?UzFDVGJUZEtBTDFWNGtyZ3NPYWJjQlNjenhoQ0lYbUZCdUFBbkxCMGhnaUFI?=
 =?utf-8?B?N1paU1ltaW1kbnEwWmFjOXFLOVVqZkRlaXlxcmxkcmpwVEdCdkJpS2hmMGp1?=
 =?utf-8?B?YzcxNlpkSXhRY0VWaXpoaGZNeFlOeGJ3ZHRLMzgwa0E5UjEvbkwvN3I2YmJM?=
 =?utf-8?B?L1BNdDhDLzRTYStyNk1IalZTUGxLVkhVdVhGVGk4QmowSlRSb09DMVlqQWZR?=
 =?utf-8?B?aXo5QVZLOElHQi9rN2JOdkJHL0twWGZYMTdkcERYNk51cHBRSUwyTHFGLzcx?=
 =?utf-8?B?L2J2c3J2SWFoblFnR1VkYXVlWVlwdEhmVXpTRzZLMHNqZzlzYzJnUXNCbzVK?=
 =?utf-8?B?YXdGbzUyWW5FUEk0OEQ0OEFnK2dYOEJzRWoxK0VrbHErRzJpdy94ZnQyNW82?=
 =?utf-8?B?b29JMDhQYndJWCtWMUx5VUZqWE1WbFFSeEI4ZFZPWm1uOVRCRGlBNEhrVDRz?=
 =?utf-8?Q?2XyO7jOdYvsQjh8x6o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035317e9-2ac8-40ab-11f5-08de4e96733e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:15:22.0069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPV+96z/pFMIFPASnxIHglsNmvCb/uK4mpDrr0ZDy99V5wl8r1QyIMHb/eHJ0hPg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

On 1/8/26 10:05, Tvrtko Ursulin wrote:
> 
> On 07/01/2026 14:46, Tvrtko Ursulin wrote:
>>
>> On 07/01/2026 09:01, Christian König wrote:
>>> On 12/19/25 14:41, Tvrtko Ursulin wrote:
>>>> Struct amdgpu_ctx contains two copies of the pointer to the context
>>>> manager. Remove one.
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 +--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 -
>>>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/ drm/amd/amdgpu/amdgpu_ctx.c
>>>> index afedea02188d..41c05358d86d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> @@ -232,7 +232,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>>>       } else {
>>>>           struct amdgpu_fpriv *fpriv;
>>>> -        fpriv = container_of(ctx->ctx_mgr, struct amdgpu_fpriv, ctx_mgr);
>>>> +        fpriv = container_of(ctx->mgr, struct amdgpu_fpriv, ctx_mgr);
>>>>           r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>>>>                           &num_scheds, &scheds);
>>>
>>> Well that code is utterly nonsense to begin with. amdgpu_xcp_select_scheds() needs the xcp id to select from and not fpriv.
>>>
>>> Can you look into re-structuring this so that we don't need that cast?
>>
>> I had a look and so far only cleanup it up visually a bit so there is fewer long array subscript dereferences and confusion between sel_xcp_id and priv->xcp_id.
>>
>> But on a more fundamental level, since it needs to write to fpriv, the caller will need to have it one way or the other, no?
>>
>> And then I noticed not only the atomic_read/inc usage is dodgy, but the fpriv->xcp_id assignment itself is racy. Two threads submitting to the same new entity appears can end up with a refcount imbalance and probably worse.
>>
>> Shall I replace the ref_cnt atomic with a mutex and protect the whole selection?
> 
> Or maybe there is no race?
> 
> fpriv->xcp_id is first assigned in amdgpu_driver_open_kms() and there it looks it can mostly fail or succeed. I say mostly because the one silent failure path (not failing the device open) I see if xcp->ddev would be NULL. I am not sure if/when that can happen? If it can happen and that is the reason ctx init needs to retry the xcp_id selection? In which case it is racy.

xcp_id selection can only happen in amdgpu_driver_open_kms(), anytime later and you have completely messed up page tables.

So no xcp code should ever overwrite fpriv->xcp_id. If we have stuff like that then that is clearly a bug as well.

Thanks for pointing that out,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>>           if (r)
>>>> @@ -349,7 +349,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
>>>>       else
>>>>           ctx->stable_pstate = current_stable_pstate;
>>>> -    ctx->ctx_mgr = &(fpriv->ctx_mgr);
>>>>       return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/ drm/amd/amdgpu/amdgpu_ctx.h
>>>> index aed758d0acaa..cf8d700a22fe 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>>> @@ -56,7 +56,6 @@ struct amdgpu_ctx {
>>>>       unsigned long            ras_counter_ce;
>>>>       unsigned long            ras_counter_ue;
>>>>       struct amdgpu_ctx_mgr        *mgr;
>>>> -    struct amdgpu_ctx_mgr        *ctx_mgr;
>>>>       struct amdgpu_ctx_entity    *entities[AMDGPU_HW_IP_NUM] [AMDGPU_MAX_ENTITY_NUM];
>>>>   };
>>>
>>
> 

