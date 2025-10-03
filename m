Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306B7CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 21:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2BAB10E97E;
	Fri,  3 Oct 2025 21:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g8XPCPtI";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA6210E97E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 21:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgG+uxhYdjOCVlgfmHebIK0uh6CXYqaIEkt/mM+ziz3FzVYnLSbtVENW/MOJRvlGA9gt4k0LKo0x4pitK8DHI68sDyRCvVUO8nR7H9cearOGGG9NnpGJgGq2NNN6Pbhj5VHv6Tt5RYWaUIGIAGgwgxpmtcFPsEEHfv/hHMKm9jbKd3ht/yRzoALAx56ZXpEhNMYXgTLS7ZPcyG0UzQBcAbw6ySEYlLos/d0aYgTkg5ppZjBh3N2uUl0y1hyTKRfbhvj1RpwJIWSTOjymVmGp31fVJ7FOTzLoSpUkky3dfpH3Pgz/VZ7CLkfIyv4c8mldwGRrXBAm1/rpfTz2gL1y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkBqsVPHCuP7vYj5Fxj4UXaQvG3fvI9fFctiTdooIZQ=;
 b=nuY8oGyPMbEUgdZy3eIbNIj5YgjZeB4xAG5F09kRjnhbtO1WG8If4iCpEe9TwnUibknMKQ4L/l8zyvGuPnb7xGX367CA4R2b1dq8HQE71c/G69syvklRpHM4+uTtYKY4tbPJL6JQFpM358aEVEn1EeycCdU2yk6Y+SPGpBslaheZbAsIg/UxrWgMNUeWXfs5AK5ijvI8kaq58GXDAqpIPY1o6yaL3zndk8vLvexiazCr2yz0cNmXdpFMpKOTlniQgi730HriULtr5yLqFQR1XrE0EOWxjdO0ZAGwnFryI7OWZ+CTxAhky7p6jiSg96LM1aRa3QGCQoWlm0Q5nZDubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkBqsVPHCuP7vYj5Fxj4UXaQvG3fvI9fFctiTdooIZQ=;
 b=g8XPCPtIdpSHcXtFeoDOyGzHinmqsvzKfTMIU7c9Y0WFOu4lnz9nkUr6HRnhjDdKBJiOLoMErsvIeGE/9vGSK9D656bPfxzlmvYLLxhdQI4nbDLVi0qlkM/g4EOOFMOF1d8qtqCUjzi0DMVebHNIPDfNv+7YGg3IkRY6y9yLtSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.17; Fri, 3 Oct
 2025 21:18:22 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9160.015; Fri, 3 Oct 2025
 21:18:22 +0000
Message-ID: <f3349a43-446f-f712-ac61-fa867cd74242@amd.com>
Date: Fri, 3 Oct 2025 17:18:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250926210331.17401-1-Philip.Yang@amd.com>
 <87ae1017-5990-4d6e-b42c-7a15f5663281@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <87ae1017-5990-4d6e-b42c-7a15f5663281@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 04da55bf-6a2e-4680-087a-08de02c261c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW42YjlMa2lzbHd4aFZJY3lQQjZVUW9HdkNmRUsvYlNUMWxMUTNTUTVJU3Z3?=
 =?utf-8?B?UzdJZHRubWx0Y2pxVmNvaTAzdW84cWd6VEpkSWJvOHh0UEdUZFIzczA5WHYr?=
 =?utf-8?B?NnoxTTNlcHlNbTF2anU5cEZqQUVOd2dpSEFUUWV5OHdSUGJRY2tLTTYvdDUr?=
 =?utf-8?B?dGdrMEFkTXN2WEFkbE5tMVViZitBMXN1b0NLYko3dmN3TjJKODVZZ01rVnE0?=
 =?utf-8?B?VGltdjY4dTJaWlpDMGhOOW5GVVNXM2ZhMGFjbFBPbllvaVk1aWJDTG5MaEFT?=
 =?utf-8?B?NGY2N2hKT0VwRTY1TmpYbEZ0TEZvbTY1eUZZR2RMWG0zTWtHQlNjd015c0I1?=
 =?utf-8?B?WkVNdGVlL3ovMVljZHdFY3pSV0M4WHUxYzlrMExIQk10WmpWU3BBK0JzQ0Yv?=
 =?utf-8?B?ZisyekcxQW9xVDkvM3JaOEc2cXhtQ01UdStvSmEzTDlFWWg3VGdLeC83MkRU?=
 =?utf-8?B?djcwUEpYdFNZY1ZqZ05yS09OZlMxdDRFWHZhYTRCNThyYlNGL05wamNoUWlo?=
 =?utf-8?B?WXdPKzdnbFBaYWJzUDRnaHJxYXlFeFZaWUVydjlOK1JXeVdhd3VDUG5QV2JX?=
 =?utf-8?B?TVhsR2FnbWJoRHNZK08yaDU0Q1FvWXZLeG1iU1FiSlh3Mkc0VmFrKzlDSVZy?=
 =?utf-8?B?dGZaTFpabHNzUm5DOFRCMnhha0FPM1B0T2tveEltWGNQRnVhU0Z0ZjR3V0Jn?=
 =?utf-8?B?VkdoMWhtaDBKQURMVVhKT1RSVGtUNWFtWkE2RFFQaHNoWENrTDNTMUsxL3FX?=
 =?utf-8?B?MUVqK01pczFEUTJBNklZMEc3ODdlL0Frb0d6UWwzWGpMbS9JM0g1TURsbVhL?=
 =?utf-8?B?T0dBMjBmQUZWK2VLT3l5QWViS1pPNVJLcFJPV24rZi9Kb0dyZ0wrb2xvbU9X?=
 =?utf-8?B?WW83ZU1LNUVjME8ycTRPMDNTSWw5YkFiRS9YeGZkQTB2RXFOMmVvSmEwWjJ4?=
 =?utf-8?B?ZHJuSjVOQm5zVWhEWjJUYjczdVRBOUtWU3JtTXIxa2VWS3R1cnBHT2hsT1pY?=
 =?utf-8?B?K0lLYzhKSmN6dmgwRUl1em9TOENoa3dJUEUxbS9rRXFVVThBOCt6Z1BOTkNh?=
 =?utf-8?B?TXpTRTlXcHoxc3FEZitvZ1hRbm1xd3JYSVowa1FPclk1UzZqT1NDdzZEWDRR?=
 =?utf-8?B?dXFsSm1id0hSclFWVkJlUGE0dWwyZm5OYloxcUc0N2pXdE9hT2JCVFQ0VGM4?=
 =?utf-8?B?ejU5RkE1TitHSkkvU3lDWGNWdHhndEtJWVowemViZklTSUFKS21ucjNZT1Bu?=
 =?utf-8?B?dFRBb09KbFE0dEdyanY1dndTWktGOG03SGhoZFplY3l3UHo5cjB4Mkhhai9S?=
 =?utf-8?B?akN1R29ZbnZCUzlYeVhlRGtLRVBZQzE5clZKRTRtVlVMYU96WVN6QmcrK3dW?=
 =?utf-8?B?YVl2UEFvMXpvTm5NSWU3MFV0Mmp3U3llZVNlYWVOd2grRnRBUThQczlYQWhO?=
 =?utf-8?B?V3RBRWdiZ0JMU0ROYXZxVE9lVE14cUNvYnJjTzZjcC80TmNaT0NnNlFWQjNw?=
 =?utf-8?B?Mk5LV2NMdHJwaEZTdFlURTNpeko2cWRBcTJxUFYvQlFoUjByT2JRbWxBV2FR?=
 =?utf-8?B?QjkyQjdQNld0ZHlWTlp2bXYwc0Y4YnZpTFBiVjJpWHpRWFlEZnA4QThJVDhK?=
 =?utf-8?B?YnplbzRvZ0o5OGlQVjVqcUl5UkllUHVEaGg2ZGdtamQxYUZGZXQ1U2J2cG1R?=
 =?utf-8?B?QnhoaFM4R3hqVVkyVlplalgyOXZKYk5CODVlSGFUdmJXd0duZDlUWDBreG1l?=
 =?utf-8?B?MXB5U0V5Y0lRaDV5MzdlSDNPZXBOMUM4ejNQMHgvMFJRTVVLcXNBZ1crRHVF?=
 =?utf-8?B?dmw1R3ZPY2pwRHRXSC82SjNMQ0hRd3E3alU2SG02UG1oa0EwMjhhZi9HYlpI?=
 =?utf-8?B?V3dqZnYxZHk4ODlnUGlhRjcwMkZhQnJidUFvMUV2dWg0RU9JR2FFY0dEb3JG?=
 =?utf-8?Q?XT//Y3qAI8VghvFSze59lHfsjj+MxBfR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzY3OHhvYXR1NGNNMVR0bGVlZVh0MVkrTk5zdHYzZC92cUdNbmtWQ3NMQmZy?=
 =?utf-8?B?RzlZWWQ4UEtDWCtBNHBnZlE1TWdaN1hvRFZSOG1yeDczSzgzL3Z5SkpIc3lC?=
 =?utf-8?B?ZnRiNStoQkNYYXJnQUJod3V5Rk9rNmNsamdsTDhEMVlnYnhGcXFCTVZGc0xq?=
 =?utf-8?B?TnNzNnZRYzhEV1QwZCtCam0zMm82WlFmNmd0aDNXdkVIeXFrcWtibnRtK0Vi?=
 =?utf-8?B?SXdOUlB6OEJ3T2d0NGRER3Qyb1gwKzJaK0RkY3Z3UU9HR3pieXNGVWhRNWh3?=
 =?utf-8?B?R0pDZHZGeGVNaWM5QW5ZNyt4cDI5aWF6NW9uOEovV1ZsajE5VVdnOUphVXZz?=
 =?utf-8?B?WFhYTHgrMmxJMm5LYXRmS2cyTkgwZlZYNmVYRml1TGRKS0RDL3FUc0dVengy?=
 =?utf-8?B?QVpNbDE5RFNIQzA4aVVwdGI4dExzdUpGb1UvOERhOHZCKytudnh0SDZva1Iv?=
 =?utf-8?B?ZFNFbEdJRElHMVN5a1FXT1JGZ3RmcWdnRG43Nm9BeEw1c0s2ZUwyVGdvbWZS?=
 =?utf-8?B?THVTYkl1aGNNbkhPQy9kOHg3YkZwQ3hIdEhkSjFQUlhVamNkWStZM1pNT3cv?=
 =?utf-8?B?Z0JUbDVxWUN5Um5OUUxPMEpGQWEyZm5oVWp3N3VGYjVOdEtDbENjVi9kNStq?=
 =?utf-8?B?cHFVM1ZrNDREd3BOd1JLQ29tUDdvWlhDUHg0dEIrZ1Myc3RnT3RYRHQvbXRv?=
 =?utf-8?B?aE4wTTJidkMrbXFqZUQ5cEZQdGxzL1V0VkNMNzJZU1VDdHZCZUxRc2MyL0JG?=
 =?utf-8?B?T3FWOE1zQVd2SmtmT09RcUZPV2pBTkJGODBPSWgxaHhGTkxVamJwRDlGaTZp?=
 =?utf-8?B?TEZSMU4xekpjREg0UnByQlZCa0xqUFc2bGxZekk1QVc2T1dkdlQ1TlZKY1NB?=
 =?utf-8?B?dTY2OEg0WXdaS2M0R2JWaGgxcFNBVDFYTHc3YTc3bWNocXNXMU1HdEhjWFYy?=
 =?utf-8?B?OVFTaFc3MDhESmp2M1hIOXFyWlBXUjk0dUZwKzZ4TDJ5NzJvdTl2M1ZINEph?=
 =?utf-8?B?RzQ1Z2NJSU1QaTVkYkFDY2sySlQwWng5WkJHeHFJOFA0VFVaZExZY3A2ZDdp?=
 =?utf-8?B?V2FHSHF3ZG54WGhWUU5UZlV2V21nb3dRbG9FUU51dkFScVZORXNkTzBIUUFR?=
 =?utf-8?B?c1pGWFI4V0t5TTAxMlZINHp6ejNBRTArR3htL1czMjV2UkgzZlN6QTJFZkpm?=
 =?utf-8?B?R0oyTVZONGN3ZXY0YWhzb0d0RmJaT0N5Zy9wT09wYjc0NlBLeDVuQnF0VUNY?=
 =?utf-8?B?MHZESjNtKzZxNmlQTGZOQ0Rza1BaSmFLOFVmT0hyOFpOZ2QxWXJsVTRpNm0r?=
 =?utf-8?B?RWdFd0NKdGE0MCttUG5Gdy9EM3dPK1drMFNOWjZVRnE2Ym4ydjhQTU43NTUr?=
 =?utf-8?B?b3ZwblZ6RGZOeTBxeVAvZ3o5SnhZVzZmLzd6aklYNmo5QUNTNmpPbHlXT0lv?=
 =?utf-8?B?YWYzRHRXQ0RHcUh5VVFDRExYcEx2MWZQNE5sWGI2VGJxN3ZJMXluV0tiQjgx?=
 =?utf-8?B?Q1R5NGF6WU1NOHYzRjVDT0k5ZFFzaytEckJ1ZzdTY0ZDdHJiNzRVSWtKUXgx?=
 =?utf-8?B?Z1NxQkM1SkFIN0VvSGFWaFBpRDNlZ3NQTkhBLzVQRytxTHpORG1Ob2RwL1E3?=
 =?utf-8?B?YUVPbCttNXhCT2N0bUxEdW9ibEhicTJEZUJvTHY1L2dMYURUbjB3d3RXOVlY?=
 =?utf-8?B?Z2ljV1YxaWc5VHpUMis3dWRvbUpkMXU2TjJSR01QeUY4b1RPYnZrOGhyalN3?=
 =?utf-8?B?UjZHcG5vVzRlOUczejVUVVNjT2tDOU90Y1BPYitsdUlkYTRLdTgva1YreTg1?=
 =?utf-8?B?NzhWcHdIeWZVL3RwNm5GYnQyYW1TSFFOTzdTR2RGTUF2N3JWS0lIM2dXRzQv?=
 =?utf-8?B?bmY3QWZQWTgwV21Gay8vUkN5S3N5VllmcWtlSzdEekEzeWdCRVpYVUQ5MlB6?=
 =?utf-8?B?cS9LREtwV2ZOT2Uva0pLMkhnY1JaTkdCOUlLeHNxZDBpZGtMN3gvaFdWWnEx?=
 =?utf-8?B?R2g2UXBXUWFRd2tsTUVhNXY5b1VKOVNkWFlHTGRpT0lWM3gwZVo0bXYwR3dD?=
 =?utf-8?B?cDUyb1ZIUmxNZ2dwZzY3eGtINVBhN2RiV1F0QzltOWNsYnMzU3QwcDdwRHlq?=
 =?utf-8?Q?8Aio=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04da55bf-6a2e-4680-087a-08de02c261c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 21:18:22.1954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnzWTs6MaB8jAXrEYlqnEW8OjBaZSd8v5IrFzsZxZcsfZ8zABOevoEoHb/if7Ihq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056
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


On 2025-10-03 17:05, Felix Kuehling wrote:
> On 2025-09-26 17:03, Philip Yang wrote:
>> zone_device_page_init uses set_page_count to set vram page refcount to
>> 1, there is race if step 2 happens between step 1 and 3.
>>
>> 1. CPU page fault handler get vram page, migrate the vram page to
>> system page
>> 2. GPU page fault migrate to the vram page, set page refcount to 1
>> 3. CPU page fault handler put vram page, the vram page refcount is
>> 0 and reduce the vram_bo refcount
>> 4. vram_bo refcount is 1 off because the vram page is still used.
>>
>> Afterwards, this causes use-after-free bug and page refcount warning.
>
> This implies that migration to RAM and to VRAM of the same range are 
> happening at the same time. Isn't that a bigger problem? It means 
> someone doing a migration is not holding the prange->migrate_mutex.

Migration hold prange->migrate_mutex so we don't have migration to RAM 
and VRAM of same range at same time, the issue is in step 3, CPU page 
fault handler do_swap_page put_page after pgmap->ops->migrate_to_ram() 
returns and during migate_to_vram.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>>
>> zone_device_page_init should not use in page migration, change to
>> get_page fix the race bug.
>>
>> Add WARN_ONCE to report this issue early because the refcount bug is
>> hard to investigate.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index d10c6673f4de..15ab2db4af1d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -217,7 +217,8 @@ svm_migrate_get_vram_page(struct svm_range 
>> *prange, unsigned long pfn)
>>       page = pfn_to_page(pfn);
>>       svm_range_bo_ref(prange->svm_bo);
>>       page->zone_device_data = prange->svm_bo;
>> -    zone_device_page_init(page);
>> +    get_page(page);
>> +    lock_page(page);
>>   }
>>     static void
>> @@ -552,6 +553,17 @@ svm_migrate_ram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>       if (mpages) {
>>           prange->actual_loc = best_loc;
>>           prange->vram_pages += mpages;
>> +        /*
>> +         * To guarent we hold correct page refcount for all prange vram
>> +         * pages and svm_bo refcount.
>> +         * After prange migrated to VRAM, each vram page refcount hold
>> +         * one svm_bo refcount, and vram node hold one refcount.
>> +         * After page migrated to system memory, vram page refcount
>> +         * reduced to 0, svm_migrate_page_free reduce svm_bo refcount.
>> +         * svm_range_vram_node_free will free the svm_bo.
>> +         */
>> +        WARN_ONCE(prange->vram_pages == 
>> kref_read(&prange->svm_bo->kref),
>> +              "svm_bo refcount leaking\n");
>>       } else if (!prange->actual_loc) {
>>           /* if no page migrated and all pages from prange are at
>>            * sys ram drop svm_bo got from svm_range_vram_node_new
