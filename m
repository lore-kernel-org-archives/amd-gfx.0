Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F05CCCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 18:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C565910E82C;
	Wed, 22 Oct 2025 18:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w+gUCo/l";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CFF10E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 18:13:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwUUvBYbQLepggjIIkKrYwDIjCV6f6zY7mTh9FWLWHt/DpyJuEBBQXTpZ/Vveoc9u+43SNbFwFK1176cOAvpcSWICpEKVu6mmYpC8X9AoAKQZmnkU9XYaQr+ReAXmwbf670VGTb6ZUwL2i3+WVdVlcHGfXDG2BBc+CjzocYyPVITpk7UCm8qpHwLkDenDuk1gPP8IDUChp8cCeSNMlMjJP1pwZm9goXDgqAkov0gaSHVECiq4gT1++FAQx4mdTeT5qZVJ26rbpIgAnfQqE8befbPWToGQ1iiAIPq7nnxJsfUWr7Q3IKUhQxTCN3R02eTIc0EqocRp+h14ShVFH813A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AllFvw4QLoSBTHCxLqUo6rx96HTeHEq/qf2Qwvok1gI=;
 b=OJTuOHeBZb/w4lv6+klX5age5fshUl1D9nBs3D/S1xChCeN4tbhV/GkurhwvccYz1A7QfaeXd9zU4MkWwO2R/Bu0Fhh8RXsQzL5RWx+0OQRkqxXCSEkNlyuQ2nJCkNehbEjmV7on2lbqKQr/yCKXjnps2EvINwO2fdU9C+d1qAMb3XFjqs4KPfBr3uOkNExFoHuM2T/xBHeziVjXXy5W9kg+V3KGSQjbz+0QsLYlBDKpM0pJqYgt+4QLo7RmunRJjpnNi/BpjOlc+WA5t4gm19Fb+djYBrW9cdgfjAWBjY0iktisbI5EQV8Q9SjGPoJYPcAT29h6PDIzvXqa+ynw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AllFvw4QLoSBTHCxLqUo6rx96HTeHEq/qf2Qwvok1gI=;
 b=w+gUCo/l9lxPSB1jDePNcN8ju75PIzvBShPBuHz8d2S7fupHQqptOVJRiEDneed3t+yuyBfst7ekbwtvRJqiGId/GNs4noEn3gXddBlbOubJd04X1K0dacnqjblz40ycESyKrlBCTpcw+wFF4rrJBM4h94mSBAarQcUT1TdCDKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 18:13:24 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9228.014; Wed, 22 Oct 2025
 18:13:24 +0000
Message-ID: <072f72e5-0ed1-2f85-b285-a0d1dc1c8ceb@amd.com>
Date: Wed, 22 Oct 2025 14:13:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20251020143016.23409-1-Philip.Yang@amd.com>
 <f82491c6-c6f5-449e-89e1-1735606f60d0@amd.com>
 <1d60c36a-523b-5bf0-bea9-7d5fbdecf93e@amd.com>
 <97a3c5de-3a66-435e-8b4c-72c87473d88f@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <97a3c5de-3a66-435e-8b4c-72c87473d88f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::44) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b61c96-ae75-4602-0358-08de1196b0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2NjR1JKd1Vuc2pMMUVyWGtxcjE3d0kyL3BNVjB4OFdlK3NZU3Z0MFlJRVFC?=
 =?utf-8?B?cjltNVdYY01OdDRkSHlpSGw1OE9NTjZVSjRrUW05MHc0c2Rzek5Va0NLSkxw?=
 =?utf-8?B?V2MxbXRCbFhqc2VQVU43YnA3bmdpaDdVa2FRQ1o2L0o1TlBQR2hpWSsxd2xD?=
 =?utf-8?B?L3crbDJuKzVMbzF1NFVNcllvNXNuMmN4aG9vK0RUeGdHamljY1pmTTh2eUor?=
 =?utf-8?B?UlNMS1I0WkhKMWtqd0pWVC8xYzVFeG5qSEZ4cFNCbGp4akprSW5rR0wrZlhJ?=
 =?utf-8?B?UDFHNjIxUVpUeDEwUWJOOUhzK0R5emNUNnJYb2x6b0w3d0R3eUxFblNMSWdy?=
 =?utf-8?B?ajRnRlFXWG1FeC9mVzBlTGkwYVpHK2FQMEl1a0NHSUNCVWRXV2U3NnRuVjNE?=
 =?utf-8?B?Ny8vTHBiMllId0tyWlV4Vkc4emJZQ1drNjEwRi9qRms0Q3lSamlDWUpGMHhq?=
 =?utf-8?B?M2lTV0NQWkJ1d1ZGT3pKbStJYlMwbElBbDd5U0ZyWlF4QW9iWmsxOVNwV0dx?=
 =?utf-8?B?eFBwUWJXWjFQU2h6QXo4R2hvcmpaVFZwMHZIcFY3Rjh1VEFUb244REZYL2lx?=
 =?utf-8?B?K2FYNkFmblpFeEJEd1ZacENGcGFQQk04eFMyMFZRT1gzYTVDLzh1T0ZERklw?=
 =?utf-8?B?VEwwU2ZKbXNKMlBYZGIveU1hOGVnRlRUdlRra3IyYW1zM3hxb2dsWlduUUk5?=
 =?utf-8?B?OGk3L3JBUWdKQzh2VWE1QS9lNENMb21ueDljTWVCa0xEenQxbHVINUxJWnVx?=
 =?utf-8?B?WFJuczNDK003azZlTU5saTB0dExrN0VBdExLUUl3VGZCZFdmRnBEaEJEQlZk?=
 =?utf-8?B?SmY0Wm9JVDhzOUM3amczK1Y3eENNSU41WC9hRWJjQVFiSUZoTU1XYXV1Tmdw?=
 =?utf-8?B?Q1RKM3BUSVZDVzVidURmWjg2NkNCK0hxcFZ0V0RqTDFLSGdDejRyN3YzT25S?=
 =?utf-8?B?Qmt2S1lOSno0N21xT3RNOCt0ZGY5QjhMSmxFNUtJbDdGUlVSNEhpQ2hZODhS?=
 =?utf-8?B?YWhHZHlaNzJkV3B5d0kxR0VKdVJwMC9aNlowSWYzQ3QyYXRLQU5TMWhidkdl?=
 =?utf-8?B?YUtRS3J0bTRCRlZ6STJWaUNCeEZmRHdjbG1oTnY4QlN1djRkU0gzU3VxWUtw?=
 =?utf-8?B?enV5akpIZnhNZTY2UFNzek1lcjZ4MTZBUlF2N1ZjbjZvR3h0TFRad3QrZ0tR?=
 =?utf-8?B?Ym1PMjR5M21TYWd3OTMrYjBNbjZvMjBlQy9JLzhtM3M3VU5GbXlYbzBTMU5O?=
 =?utf-8?B?Q3YzUTFhVHhyVkJPWUM5L05EejNQVHpZb0hORVJyMzFxdWF1MkpDbFBsYnlr?=
 =?utf-8?B?a2RjNHg1VEdKQlNvTnRYNWVUVkJteU1DKzg0V3E1UnhYYXdSRHpFRmZhcU9Q?=
 =?utf-8?B?dm9hUmFsR0NRQ3FaMWh1cXdXNDFhT2ZwNXBObDhRcWtObW0zbnpzcG42OGFs?=
 =?utf-8?B?Qi8zR0pTZS80eW5KQzk1aGJRZ2VMV3NCM2M5Vmh6MzJaeERaWlRPNFRaNmdV?=
 =?utf-8?B?d3drRW1HVWpjeVAyN3FJUjk2ekZqNkJYOHphUVJwelZlUUIzaWVUNDN0cG5G?=
 =?utf-8?B?SlAxQ285OC81R1J5ZzNBZjZRYXE4MG9wNFBvK2t6SmpJeUlybndLcG5VMGVJ?=
 =?utf-8?B?WFY0NGZzQS9oUFJuZndVeXNZdHpCdloxdGNLTkxrbDBoZlRYeHhhR2VDWDVH?=
 =?utf-8?B?eSszU3BOQ3pwLzlnUGprbUZRU0xpeS9uRm1PcktjK3cwbzZjNjcxeFczaHFh?=
 =?utf-8?B?NFo4UVhYY2JJRno5UG1IWFFDSWZHa1hxbk9hbldyYnJYT2J0b2ZXczlYVERw?=
 =?utf-8?B?eldTSGFqN3RKVzZzcHVaTXhiU0t6R0VSckZsMmxWMTUxcndmbjJJcW5wYW1Z?=
 =?utf-8?B?NU1Cb0ZLRGtJRnJzZExlZldZenZFSVhxS25TY0I0UUp5UjI0eElxa2JNQ1VF?=
 =?utf-8?Q?ZlDM1gJSx501f0UTRC2iiXSRkXATFFUa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJHVy95L2RFc1kyMnNQelBvNXdBTXZOTE12NFpmQlJraHMwSWhtelM2TGYr?=
 =?utf-8?B?Z1MwQmI4Sk14KzNScUprYkxMZFhYVTlXd2xINTZjZ0tmTkNXeWlIdmJQL1h6?=
 =?utf-8?B?VzZZbEZrSCs3Sld4M1ZKNThlWjJTNmdhdDlnTU1HZ21JbWZpTTdTYWFoV3F4?=
 =?utf-8?B?eGl6V1BueW53RUp3RVNNdFprbGlFWFlkNE8wVy9obXVqOVdsaTJCUU51QzN5?=
 =?utf-8?B?dVpZY1JOdm5ORVdyOUhhYmx3VVNUMkNOUlFOc3FZM1Arb2t4OGJlRnpVSmRE?=
 =?utf-8?B?Z1RPMEhhSUx2YmhrMWpzKzZZSHNwOTJsL1ZUd3VPL2Y4Z1RTcUdUMjJOMHhX?=
 =?utf-8?B?bjFQOHp4MWMweE1aRnQwY1l6ZHRISnE1c0Z2d2E0NlVhZzVsaTZheitvTXRy?=
 =?utf-8?B?aEk1MytqNGk5eHdsb2x0R3NLdng1NnFWd1cvRTdBZEE1dGhGVmtWT25rZGc4?=
 =?utf-8?B?ZWZvRkQ4UGphL1pQUERkR05QOFczQThqbXRWdWF5Y1hPTVVqMkRCbi8yUmhv?=
 =?utf-8?B?SGgzTGVMcnRtaUZ2T3BwWkZ2dm4yanNubEJoUThNVi84NHl6SUpFNGZEYnZI?=
 =?utf-8?B?Tlo2TzVpNVFVQUlxRUI3NzJGKy9nc1J5RzdyZHF5bHRRRmswYisrMjBlK0lr?=
 =?utf-8?B?N1lmK1ZvQkZNMkdYWUpsTXJhM2VhS3IzNjlwVjlpamk5MGFwL1BLS2hocWdR?=
 =?utf-8?B?WVA5T1E2ME00SXhHZWJnMUtxWkhvZmdMNW9QTFlVYlhTbzdsVjVvWk40UitI?=
 =?utf-8?B?TU4zS09CZS80MnFZTUJXQVZjTEVxdzRsR3diZVBrVGd1UGNqbzg2VjFlbytW?=
 =?utf-8?B?ck9tMWlOcFM2ZmNnd1FCT1d3c2dZa1dUdGN2RTgrMlFyQk5zaTU0Wk1xb3d4?=
 =?utf-8?B?Q0dSZUtXeWtmQlY0b1hnOWhuUFV5cG01NVJONkdRaEFhV1ZTb3REd0hBRTJU?=
 =?utf-8?B?UkZicmVMVUViRFYvU2VKVGVXeHFJS3lxeGxNT25HMXA4T3lEd1V1RG4ya0RL?=
 =?utf-8?B?a015RmlkekVUMGc5dzBKZXdaem1zQm9pWHJ0QXhNS1pmNGxxV01XRWFXSkli?=
 =?utf-8?B?dlN4Q1N4cTZYVktmVnVpcmdMamxBT0VQOWVJTFVTWWtVVDRyczFxN0kxNkN6?=
 =?utf-8?B?UWFLWGFaUjZJVW1HMThNWDFVVW5hd0dyOHRTU0l2S0xHMzc0Y09CYWFYeVlO?=
 =?utf-8?B?Qko0U3poM0xyT3lvOU8yenZtMy9TelpUN3NmbnVpbStOOWtMSnorV2pNOExZ?=
 =?utf-8?B?dlNTSkJpS3ZUenJ5NTBFWUV1VDJESmk5dHB5YlhpRFpSdXVRc1diWDgvWXBi?=
 =?utf-8?B?U1lpZkdJZjh2aW1LVGEzM04rcHc4Qzd4KzNKZzNVZmVFa3RMVVNvY3NpeDFL?=
 =?utf-8?B?RmVmUnhTZXdmQ1lFYm1SbWdIMVVpZzNMaGx0Zkl0QUViNElmV0ptV1NDZjlO?=
 =?utf-8?B?VzdwcDRxNGhkY2hlVkl6TTFIWWxJVlBma29GM1dKbXBNSDUvVldHRkN0bEs2?=
 =?utf-8?B?VSt2V1dGR0tId3ZQWVRDbXM4djRhVWFXeURua1AwOUxnaS9KRlVsdUFuR2k2?=
 =?utf-8?B?WHg1QUdiYmpIRHZwR1pwRWpwR2k4cjdMZjZIMVV0bktqdEYzUmltWmxRQjZF?=
 =?utf-8?B?Um9UbWFuRVd1a2pLQ3c0anVPWEJhVzRpUjBCcGV5QXNEVFp3TG1YRTRNRnIx?=
 =?utf-8?B?bVMvaHFhUnpocyszbUlxOVh6UG96Ymd0ZDF0OFl0Uk05QmhSRm9mRnRiM2x6?=
 =?utf-8?B?ZEh0cjVlWFNDZTRtVzE1ODJxVXUySFN0TkNUNWVzN1ZvOWFCQ3BTVkNzdS8w?=
 =?utf-8?B?d1k5K0U5dU9RRlpxTmlhMjUvWVRKeEp4TWdXelcwYmxFSTZyT0QyY1ZmTFlC?=
 =?utf-8?B?RCtvNjY0akY3SW1WcE9qNUFsSUM2TU5EU3NpMm1GZGR0blV2eUxEdmVnSTRr?=
 =?utf-8?B?WElRRU8xaXBMQXdZbHhTL3FLMjZGSEhPZnBxMlNSN1k5Yzg0dVpZSlgyQTlr?=
 =?utf-8?B?SlEzVVpvVjRQTDRaVTlhWkw3K3VKY1F5cDdOZDE1U1pQaGhmS0tQSkh0V1BN?=
 =?utf-8?B?U1FiOC9uL0F2YzZQaHZiUXF4WVNZeG4wMWVERDA3K0Q3VE5yWE1hdEZTQURH?=
 =?utf-8?Q?at+w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b61c96-ae75-4602-0358-08de1196b0e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 18:13:24.5545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7KR52Kf0JTWAPksPdAmorsLWinbKh4z6xZNCb83a8h3ebtn8AvRwo+6B5vaXo31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902
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


On 2025-10-20 13:29, Chen, Xiaogang wrote:
>
>
> On 10/20/2025 11:34 AM, Philip Yang wrote:
>>
>> On 2025-10-20 11:59, Chen, Xiaogang wrote:
>>>
>>>
>>> On 10/20/2025 9:30 AM, Philip Yang wrote:
>>>> Only show warning message if process mm is still alive when queue
>>>> buffer is freed.
>>>>
>>>> If kfd_lookup_process_by_mm return NULL, means the process is already
>>>> exited and mm is gone, it is fine to free queue buffer.
>>>>
>>>> Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory 
>>>> residency")
>>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 4d4a47313f5b..d1b2f8525f80 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct 
>>>> *mm, struct svm_range *prange,
>>>>       bool unmap_parent;
>>>>       uint32_t i;
>>>>   -    if (atomic_read(&prange->queue_refcount)) {
>>>> +    p = kfd_lookup_process_by_mm(mm);
>>>
>>> p->mm is null, not p  because driver set p->mm to null. But still 
>>> prange->queue_refcount is ref of queues from this prange. If app 
>>> unmap this prange app should have destroyed the queues associated 
>>> with this prange already. If not, it is not driver issue.
>>>
>> right, we still pr_warn if app unmap the prange with queue_refcount 
>> not zero, p is not NULL for this case.
>>>
>>> I think driver should send this warning anyway to indicate there are 
>>> queues not destroyed by app before app unmap the prange.
>>>
>> if app killed or segmentation fault, mm is gone first, then queue is 
>> destroyed in scheduled release wq, then exit_mmap unmap the prange 
>> with queue_refcount not zero, p is NULL, should not pr_warn, because 
>> warning message "Freeing queue vital buffer...." is not related to 
>> app segmentation fault or killed.
>
> Then can we put pqm_uninit at kfd_process_notifier_release_internal as 
> you did at second patch with kfd_process_dequeue_from_all_devices: 
> destroy queue when mm is gone?
>
This is good idea,I didn't try because it seems not safe to destroy user 
queues inside mmu release notifier callback, which free and clean queue 
resource, BOs.

After testing on HWS, MES, with SDMA updating page table, no circular 
locking warning (have to fix one circular locking warning to be sure), 
and the warning message "Freeing queue vital buffer..." is gone too. I 
will send out v4 patch.

Regards,

Philip

>
> And if this is for the cases "app got killed or segment fault" how 
> important user should not see this warning message? Something was 
> wrong already anyway.
>
> My thought is that prange->queue_refcount means queue number 
> associated with prange. If it got unmap the queues should be destroyed 
> already, if not, something was wrong somewhere, then need send this 
> warning message.
>
> Regards
>
> Xiaogang
>
>>
>> Regards,
>>
>> Philip
>>
>>> It is an app race condition, not driver.
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>> +
>>>> +    if (p && atomic_read(&prange->queue_refcount)) {
>>>>           int r;
>>>>             pr_warn("Freeing queue vital buffer 0x%lx, queue 
>>>> evicted\n",
>>>> @@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct 
>>>> *mm, struct svm_range *prange,
>>>>               pr_debug("failed %d to quiesce KFD queues\n", r);
>>>>       }
>>>>   -    p = kfd_lookup_process_by_mm(mm);
>>>>       if (!p)
>>>>           return;
>>>>       svms = &p->svms;
