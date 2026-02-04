Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF94BE8B39B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 05:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF06010E1D5;
	Wed,  4 Feb 2026 05:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p1OEMIGg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D7E10E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 05:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk9NmCBe2UvtBMHiH0Vkq3beEr+7LPSHgvv5kTsoSLXCBzEMqZNw0Vev5TTegRC1ioWCiGDVddDOAKScs6ib622apE6Ugzu0h549ERlp2cBE9Uz9s3GxkkWAu5Lujc6EzMonjnF2oWyjRG+5GCZmVlXxwNer2r1rx5vzXtT+2LyA99Wr4wZyxkH8wBEYLjEyL7+0M1h8CRxlIloga/DzXcfQV6PARLw/tu7NIajUzpFU/m+KRNgMDdsQkcpy6geL+hRyf970GScoGJ84Wicme/NfbuRwwSq55TiLwkUWYU6hEBFQYJmIXaBmffMor3+p2tq+Ag9z6qj0rhnunCyusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmFHdn+jNr8aPRYmuJ+eBXj40iGFn9CSc0fb4uub4FY=;
 b=iNef+4bO0p/+riDhDx1FQjsL1laWR1oqhlFMAfL8IeNimxKbkS7D21L573LTDERkrN7d6/RulH/54cHdp/orp61RX1EJ65QnkC8pKHVXTKCO5ulZJUaxdVRiBALO3zrEJuRM4DRVzHhCKbsxy5swuM466EjB9U0rXqqOLk6zR1lS1h9v8n2txMMzHkS5s9W/TwJZvzsjv72jLZWmQh7q7wTi3Exy1vvtlOC/kU+Qq92no08D9QOvc00z6m2u1RPNA73U09gdSL3cf5JcuJ3iUh4P2zSjXASVZSQX/ZNQXYSsuRMNIZfn7MIJeShPXGoj36UsBMt0iPD1vWID13w/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmFHdn+jNr8aPRYmuJ+eBXj40iGFn9CSc0fb4uub4FY=;
 b=p1OEMIGggY0SPaGSdmQFAsS19xrGq83IWLuZRGJNvN94db2p00Pxe0Ru6deyu1/i5VV6t3Vhx/FletmcDk7zkO/yeSFIOVuQOsoeNnCsWwIu4QjRXPGqGtt3h7tDtEA7j3KXFGPcK23WaxIDg/Z9Bxg5SrdBY8oeL1vYPEJhS/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 05:08:29 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 05:08:29 +0000
Message-ID: <7db09cab-8f94-4c53-80c1-d1e330151aca@amd.com>
Date: Wed, 4 Feb 2026 10:38:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] drm/amdgpu: Add support for update_table for
 SMU15
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
 <20260204044338.96093-3-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260204044338.96093-3-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4ead66-31c5-4dc7-fc96-08de63ab6f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTU1cmlLMXM0SlZ1M2RkRklXNUgxUXZPNnR1dHVDTVZySDQwcnlxQjNvQXJk?=
 =?utf-8?B?M2NlWUdNR0ZxVXphVzhrTHlDV1N4cXp5bkZUeFRvYW55VTRteEVrY3lkeTJQ?=
 =?utf-8?B?UDdhZTVTei8xQWg2bEZQdkJEQXVDekFXY3AxdmJSSmVKZFpkWkZXQWJQQy9V?=
 =?utf-8?B?b0pERFo5ajdHdVJKYnppZkd2cFRycy9UTXoxZXpESC9UVkd1NUhYOWlGTGw0?=
 =?utf-8?B?NVgvMzNKQlJSWWtSeTRSRnpZejVtR1lFWWRVWDBQYVlaZGF6ak1OckFJUzFF?=
 =?utf-8?B?dzN4SGd5L1M2a21uUzlmU2M5K3oxNHpNWGtIMHpXYzBFUEgyV0xPS1lnQmxO?=
 =?utf-8?B?YUw2L1RnanFkbFpLaTh0aDU4M2FjR0F4WXk4QmhoWXd1ZEpBZ2dndzYwbWpV?=
 =?utf-8?B?YUNESW9MdFkvM3k3WHdpUUo2dWFoYUlFbnVndURkWE13V1BWaDNWRTBaeElO?=
 =?utf-8?B?RGpwcHo4b0FKUHBKVFBkSmk5T21SMEZKZ0dyUEp4bFBDNFZtdElTTnJyV1pu?=
 =?utf-8?B?UXh3Z2dKWnM3UkZWWkh0bWQyS1o5eW1rSjkrYngvSlAzVmhKNUpUcS80aFJk?=
 =?utf-8?B?VFZLSlM0VzhtaXd1dFhyemRZS2VUS0pKeURHQTdtNEQ1YlN2MzhXVzlmYURO?=
 =?utf-8?B?TkROeWdPL1BaTHA4TCtKMW9kbWw4UExvZzNvbndpVWpJM1BVSno4NlBSQit5?=
 =?utf-8?B?VEJQQTcvalpVSHltZ0VKRkVGZ05vTkF4Ym1maUtOeVlhbEE4Z1ZoMThxN2Ji?=
 =?utf-8?B?RDdtaytpdVFhVUgzNWVFM09TNW1OVUpQbXR4MWlMWnRyZUVNRmlSb0U3WVJJ?=
 =?utf-8?B?cWNyRExrMDlFL1kzaTZTekN2dU93VDRCM2RkR0R0ZjBMem5hQkhlLzlzcDlV?=
 =?utf-8?B?MlI2d2R5d29qMHlaeE9tRzROSHVoc0tMRnJ2QmtWQkdkR2lwT3grYkNUM2xn?=
 =?utf-8?B?V0hrZjVobnBrWVBxdm5GUW1tc2FxQ2h6NDZvbnkvQlh5TU1GbDZqampoT0NJ?=
 =?utf-8?B?NEhZTjBoeWk3VWRmVUNuK20vOERjZ0NqU2dueWw0bVhQcjVtU214blRqaHdB?=
 =?utf-8?B?MEorNzhiVWtGanp2b2JtdjNWZ1h6MDIwZzI3cjk2WDZsckF4VWRPazRjYktR?=
 =?utf-8?B?UkxUK0p4MlZKWUwzZHF5SlJldzdULzloTzZSK25QTWpETElvdXdiVll0VExT?=
 =?utf-8?B?SUswRVJ6VlY2blVwZGp3TXRIaXBmM25vUWlOL3JQcjVuOUhSYll5ODZRRkI0?=
 =?utf-8?B?Q09ydUM1RmV5VWxiTkp3bWJHZ1JjbVE5WmtWVlBmakVmUTBGNENSYkxlbXhV?=
 =?utf-8?B?eU94Q2dZSVpxWlI1VC96MzlrWEJUNlUzWmJkZ3pnVURqUWg5WGRCRFBON3pG?=
 =?utf-8?B?VU1MQXBFVE15eTVWeDQvUTZtRVMrejQwNzVxcUUybUdhZDBmTDFBWGlnRUNm?=
 =?utf-8?B?SE1oY0V5cFhOUE9kSXNLV04rSGFFcGJtWG1aNHFhdm15TDUwdFYydHBnVFQ5?=
 =?utf-8?B?RXBkMWdYKy90dXlzbnNVRGdReGtlSGZEeDV6TTVudmUrbS83RC9zYXltaFZx?=
 =?utf-8?B?YVdYTHo4YUZxOFdYWkxwSXdjSERwdnBTK1pqZ3F3aGJkQjE3RTJQRkFMbHVQ?=
 =?utf-8?B?eW4zRlVQU21RUm9WbHM5bW4zTjVhVkJ0NFFKOStBWUk1aWNIRUJNS3R0d2tY?=
 =?utf-8?B?M3dOcmlTZ0VSdFJBRWxLNk9haGN5eTdVN2tnZ2w0NFBRTlRjcHdhSzlHNWlE?=
 =?utf-8?B?Q0ZKWkdHNnlDY2RTa05IS2pRTXJPaGErUi9EZGVUZUtmZ25IbjBkeWNVWU5O?=
 =?utf-8?B?TmxlYWYzZFFsWnNwNzlVY3ZxK2FCTkJUWnQ5K0NrbmNnaXN1T1F4dlhTWXhI?=
 =?utf-8?B?b2NLNEozb3NYSUR4dVBmQmd1b0pEbzNXY3NVMmlXOVBTa0dpV1J5QS95Nld5?=
 =?utf-8?B?RlJteGxFYWhTSmJoTnJrMi9iVTJHTDdCMkx2Y3QvNHl4VFlTbEUvMUhYbnhS?=
 =?utf-8?B?b25RRVlxcm5RaGRLeEFDY0tSZkFGc2p4elR0bHRhMjlyT1YvN2hSQm5NYVNv?=
 =?utf-8?B?QWFDOUlVeHFkQWxCbngzYk91RXlWRlM4cnFHVUdBME9XMVdKenUrNnVLQ2Vl?=
 =?utf-8?Q?syKs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXZPYjROd3JIWFhPL0pkR0h3S2gyRHNTaDVnWkZPRVZxcjkrOXowdUxFV05t?=
 =?utf-8?B?b3I3SjFWNXNTdU1weHRlNlcyWlNZSHlycml2RzJLNlJ0RDJYRENLUnVuNkJH?=
 =?utf-8?B?NmZOL0ZNdTJ1a0FPY0hhUVRUN1NBZ0tlL3Q1Zmc5b3VQcGgrRzNuWFg3QlM4?=
 =?utf-8?B?Q3RBTkhJTlZHTjFHenozSG1MUmw1RC83cUFnL25vUHFadFJIZUdmNE8zNDg0?=
 =?utf-8?B?T3YxdnVCUjBkSG1zR1QxNms0WHBoRG5uei9lMVN2R244ZHowbm5CNWk1Vk9l?=
 =?utf-8?B?WFZVRGpYWFl2RUNsSkxlR0lNWDUyamRKY01Xd3ltWWZaZkpxOHdwS1JDczk4?=
 =?utf-8?B?NUFxZDYzQ09YZnNEcUROUjVibDhEK1I4aTFIRWY4RndyUERweGxrUWswT3lL?=
 =?utf-8?B?UmZLWTVGNk8yaEUyYW5QNEM4WE5zR1NsQ3QvaXBEMDRVb1FWYUpYVzgreXdX?=
 =?utf-8?B?M0VWRG5Ka0RsSEFyRy9aenQ2QmhyVWoxS2kwekZuc3pmYS9jNWMvNm9OQ2ts?=
 =?utf-8?B?WXR6TDRVOWcrK0hlSEN6NWRFN0w4VlBCTmx4Q3krMVVDSi9SZ0c5YlRvam91?=
 =?utf-8?B?YmxZNzhDNEJrZHBHVmdGSDRZbHJQTmE1TGNkaGFlTE4xRmcyRE82by9oUHh0?=
 =?utf-8?B?Z2RsSkFxejluTHM4Z2xIZGV3UlQ1V25vanZmT0ZTbVpmeitSMkpyYXo3Uzc1?=
 =?utf-8?B?Z2VvMFcwVlRBNUNBZ2p2T1U0ODNaNS9KdjZPN25pYjlnRnZrRzI0eFpUY0o5?=
 =?utf-8?B?MEdUNEw5aUxDaDlsMnd0SExLWG5QdTIxM0V5RWVhV290aDRjWHZFYVhQV0Va?=
 =?utf-8?B?N09wMjR0V3ZHK3ZKeXpNM2o3TVJUUFJEQTlyclg2aEY4L2NPbmoySWJPU1o0?=
 =?utf-8?B?c0JnY3d1aVc0Zm5QZlJyNmJpVUgwOW95Q01CNHRiQjNGbmhtMU1LRzcwYklD?=
 =?utf-8?B?Qk9EUFIzdkFEcUFvUEFvcTR5MUlnalJoaEMvNlNod0VkWHI2c2dHUmxLT1g0?=
 =?utf-8?B?ZHByS1V6SXllZFBHakZSdkRQZm1DQWJZV1RyRmkrRXF3RmY2T2V4L2VUaGRo?=
 =?utf-8?B?ZWtxOHRUWnErM0xUU0JlT2NXUXZJQXVpZWxaak1tV1IvQ3hISlkzRXhvTXBz?=
 =?utf-8?B?TjRqSnBMWEEwL3NxcTJseXR4K3JDNk1McFUySit6U2RIQ0FhOStWZUVkb0k5?=
 =?utf-8?B?MEdTQTgwWWFCVDE2YWZPeWtWYWhlOHN1Z1hRaHF2MXVkdFNtWGZFVjN3K3B3?=
 =?utf-8?B?aTVGaSt1aW9vWGRqWlBZZzEzTjRxT0ZwU2xuTWhtbjFnT2cvMlZyVUg5R3pQ?=
 =?utf-8?B?TG9qUnpBRklkbk5SalJBZkRlTmZLcFJDQ2ZOTklhU2pJbTlNZWNpbTVzeXM5?=
 =?utf-8?B?MlI1cWdIS2ZidHdNWUpGMEtQTlBIbEVNVmVWbkdRS0dHYldZWExSUW51bzZq?=
 =?utf-8?B?SXgxSlhOWkRmSkRxd3VUZmRNZ29uZTF4bVZuZnZXQ2lnMG5nQTZFNFZ0V0dI?=
 =?utf-8?B?SXl2UEE5cThuNXVpeXdOS0dSa1h6QXFXam04L2hFTitBWXA0bndBcnkzSVdW?=
 =?utf-8?B?QTJoL1ZJOTJCWHlncXAzbW52cllUSER6Vm01eXFoK09zbmI4SnJXakZCWTk3?=
 =?utf-8?B?WVdzbjltMEh1NnZUb3NkSEcrV2w0eVZzSGxnbzN0RlkvaUZQZ1dJWHh2dlB4?=
 =?utf-8?B?dmN3UlNHSTlXbXpWSlpZbkZsM2k4aFlESGZHazJRSmlBZzF3a0xvKys1OWlo?=
 =?utf-8?B?SHpndDdub0J3dXZZWjB6aTU5WDBUeitySnQ2eUoyd2JNdjNadVZKazFxZlAw?=
 =?utf-8?B?RDF2SnA1bERINXFMQ28xVTJ4Q1pVTGt5ZjQzOGFuU1J3KzVCTHBFTkp0ZkRn?=
 =?utf-8?B?ZDBZSGdzbTJrc05tYUtyWllhRFQwMXhBWjdWMnY1Z1NzMGVZODV0ZS9wdW5I?=
 =?utf-8?B?WnR0NGdLWlB1a3NVdGw0ZXpmZXIxQ1UveTZNWGxMSUNhRmx2Ly9MREI3QUh6?=
 =?utf-8?B?R1g1Y2c1aXNRWElGakxhTkhGUmJGeEgzYVZyMXNaMklwZzlieGVEZ3UzSmx3?=
 =?utf-8?B?cS9EaUxxQmQxaHE3NVN2WEZyYnNNYzE1ZEs2OE5TdGN0bjRBai8wL2xNVm1Z?=
 =?utf-8?B?TkJVUkJJbG1RMXcxMTB3VnNvVWVoYjFzQTM3aTllQ3AxRzNxVDFuUUd5T1hw?=
 =?utf-8?B?WHgwOHBlQXNXWkRIR0dtdGJybDNyTmNOOWxVZmpYMkkrdVpEcm9YcDlvMXp2?=
 =?utf-8?B?MFlib29VN0RQRmcrMXlld2k4OEU5bjRtSjNKbCtNL3h6ckZzWXhOVi9JQXNN?=
 =?utf-8?B?bG0rRE9kOEFIZm1GdnhTNUtmaFFtU0NXdWFMajZpejhvbUVDOXg0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4ead66-31c5-4dc7-fc96-08de63ab6f61
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 05:08:29.6035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtOpCTN2mP0c1tIQbReIXQEKAfiHfIVV0icP3Pg5eVzYMSuXOz5X7KNl+UUNyLPx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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



On 04-Feb-26 10:13 AM, Pratik Vishwakarma wrote:
> Add update_table for SMU 15_0_0
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  5 ++
>   .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 68 +++++++++++++++++++
>   2 files changed, 73 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> index 14e8d8c7a80a..af87c31ca9a4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> @@ -241,5 +241,10 @@ int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
>   
>   int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
>   
> +int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument, void *table_data,
> +			 bool drv2smu);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index a2854d528bab..d3dc7583ce4d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -1726,6 +1726,74 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
>   	return ret;
>   }
>   
> +int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument,
> +			 void *table_data,
> +			 bool drv2smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct amdgpu_device *adev = smu->adev;
> +	struct smu_table *table = &smu_table->driver_table;
> +	int table_id = smu_cmn_to_asic_specific_index(smu,
> +						      CMN2ASIC_MAPPING_TABLE,
> +						      table_index);
> +	struct smu_table *memory_pool = &smu_table->memory_pool;
> +	uint64_t address;
> +	uint32_t table_size;
> +	int ret = 0;
> +	u32 param[SMU_MSG_MAX_ARGS] = {};
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +
> +	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
> +		return -EINVAL;
> +
> +	table_size = smu_table->tables[table_index].size;
> +
> +	if (drv2smu) {
> +		memcpy(table->cpu_addr, table_data, table_size);
> +		/*
> +		 * Flush hdp cache: to guard the content seen by
> +		 * GPU is consitent with CPU.
> +		 */
> +		amdgpu_hdp_flush(adev, NULL);
> +	}
> +
> +	if (memory_pool->size == 0 || memory_pool->cpu_addr == NULL)
> +		return ret;
> +
> +	param[0] = table_id;
> +	address = memory_pool->mc_address;

This assignment doesn't look correct, could you confirm again? For 
example for drv2smu, this logic copies the data to table cpu address and 
what is passed here looks like a different one altogether.

> +	param[1] = (uint32_t)lower_32_bits(address);
> +	param[2] = (uint32_t)upper_32_bits(address);
> +
Looks like these param assignments are no longer needed.

Thanks,
Lijo

> +	struct smu_msg_args args = {
> +		.msg = drv2smu ?
> +				SMU_MSG_TransferTableDram2Smu :
> +				SMU_MSG_TransferTableSmu2Dram,
> +		.num_args = 3,
> +		.num_out_args = 0,
> +		.flags = SMU_MSG_FLAG_ASYNC | SMU_MSG_FLAG_LOCK_HELD,
> +		.timeout = 0,
> +	};
> +
> +	args.args[0] = table_id;
> +	args.args[1] = (uint32_t)lower_32_bits(address);
> +	args.args[2] = (uint32_t)upper_32_bits(address);
> +
> +	ctl->ops->send_msg(ctl, &args);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!drv2smu) {
> +		amdgpu_hdp_invalidate(adev, NULL);
> +		memcpy(table_data, table->cpu_addr, table_size);
> +	}
> +
> +	return 0;
> +}
> +
>   int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;

