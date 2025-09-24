Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF7CCAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 17:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0A710E7A1;
	Wed, 24 Sep 2025 17:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BY/9aUnG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0293F10E7A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 17:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLcs5P/mGoircK/EGg9zMpTcJU8Q98/3Km9dTBkdBMe5VzdnQx0D3PjgL3MNU+ioIp9tI2/ZL35iA4Tl8f9MS+ozPaCf6BaKay8mQPbI0nw6na2iRXY5MtCYMNZWhtR4mz5YNHPhJCMldoB4fJth74bkaZCKMMQji66ezZWUFJJH00KeAzQJ2C+4ZoeBIMqYUlIiF5MzEs3L7/Oi9dEtYs5YwMNwR9zzIdUdAl67HCyxDBne3QksGxFDkuXEXD3OaY/N96Cpq2O3CyQtsntyE0ZNKU1qtval+oOBiELaETFMRaXH/w3s1lmoqI3hM37T8vQQzUUWjYw5ba41b9NJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4eb5TCXZqtIiadrzXnSqt8ZO6gprZosm2zzSQTp/rE=;
 b=W2Wj59JDL9xP/Ts5kgytDKCCfdHJrkeTd13xE9tG4RAij90bOS6H6yIgPmwuPxbwQYRA8csx1R6bTtNHHogDt1+BxwvlwkDXuq9uee1wCvuJA2tPkBjygCBOvx2mVMQaVJTgov6nFe2kSveawvBvX6k1VZ4Zae3QTajx0Eq85UUVyWc7xJEl0eq0ImmaqYGgOXNgrbp7d8kpVVpNzyzxdWxOk1KxHL/W5uZEyjmUnwTb8SPCLCgfSb0cHK8izi3lv7ZxiupvPU4mbBadzk6ywg+iCw4gQ4MoZJP6/ffznRh8sfXYQHplmZhvYR3MrJhVnPrROYs/OyySMz4OrVbnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4eb5TCXZqtIiadrzXnSqt8ZO6gprZosm2zzSQTp/rE=;
 b=BY/9aUnGKekFB1LTwlBqr/K2botux1JADMMl6V3xsmm8JyMQZJFMS5Et/feIfs2nQcwP+lB/31tCPE4uBv0pYAgfgYTZzGSMvNp1qk5PGvnaSh2Gm5GwPXGFkIPZ0nCtRq8m9+f6Uh5gZbPmKRqvYpLdsyX5Ifs7f8thPsoxyhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 17:50:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 17:50:24 +0000
Message-ID: <68bff33a-46ef-4518-8b1e-d9d1b3087f2a@amd.com>
Date: Wed, 24 Sep 2025 12:48:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Adjustments to common mode behavior
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, "Wentland, Harry" <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
 <cc2094c5-3cc2-476e-8d6f-72fc61ebab90@amd.com>
 <bebbe919-0c5d-4399-a211-c7cf744febdc@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <bebbe919-0c5d-4399-a211-c7cf744febdc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 02385b56-217d-4f81-8f9c-08ddfb92d6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFhRZDJsUjlRZDVlOHlmV1QzWGpxRmhwK3dyVTlRK3FZQVBhMWJBN0xkKzZT?=
 =?utf-8?B?OElGMWpxV0t3OVRtTlN6WDlmTU1Oclg1UVd3NlpQamg2ak1PZ1lyS1cwL1ow?=
 =?utf-8?B?Y2lhSzNoSHlVL1ZJNW82b0lqZUZyZFV3UklneVFNL1RsSGFoTE1ISVMwL0tW?=
 =?utf-8?B?a3p1bW5rbDhUb0lUZTB2R2lFaVF0aHZ1QkxvNUNKMXdGSGJVZ2hvSXpuWUJL?=
 =?utf-8?B?a2dMdDAxYlgyLy9OL1pkT3F0VTAxbnYveWpKOTR4Zm5hWEpjTm0xdHhackNt?=
 =?utf-8?B?TTZ0WDNZc0I1SmZwTFMrdTVhNFVaRVRyMnlWNUptKzd4aEJXbGZRWVl2OXFl?=
 =?utf-8?B?elVsVlg3ZHFrZHFsRWxONVJBUkpzcnVVOEhJWTBjMmJDRzVlYlpBSFlJRWFk?=
 =?utf-8?B?UElkYUQwNWxTSHpaYk1tZzkxeDA2Yi9ZR3pWclRKdDl4YWsrYXM4ekV0N0JP?=
 =?utf-8?B?T2RYSndyZ2JlOFAyWERqNFluUk90bGlzS1lvSUdGOWZiajdPd2hGTnNSYlZ3?=
 =?utf-8?B?VWIzTUh3MmQ1eGlrazh2TnFNZzFyVGs2WnhSVzRTVnVMdHdEMzd2eUVMbUp1?=
 =?utf-8?B?V2V2U2FOcUk3bXpQZEllVkpIVjRKc0lmelBxcittUDFOMU9rMEQwS2ROWWl5?=
 =?utf-8?B?RWw0VzNocCtMMnJiRHVtdXRHc21DWmpFOGx2d3V2K2hlc0I4dGlFdjh1WS9E?=
 =?utf-8?B?ZnV1T3VyTHc0akNZbzcxdmg5dkZSUGxRd3RML2hTL1crelZ5Ryt3QjdYOVl4?=
 =?utf-8?B?THBDUXRrS0RScFh6bXV3SDBXaE15OVBjODBiTU9qOUhqZUVqRkRhdkhzNlBR?=
 =?utf-8?B?RWJ5NGhzSjFYMlVkRXZoaGg1Q1pkSVM3TjdtY2Jtby9tc21FeDBvYkFPTTBJ?=
 =?utf-8?B?UzIvK1RsMkpubG1HNWtaTXlmS0tQeDJXeVZJT0xDbHhoWlhVby90Tk1rUHRx?=
 =?utf-8?B?cWxwaGF4UjVud3ZYV09VRUdybGpzOHNlcXZHbTg1bU1TOXZDRnNhVFpIVTVE?=
 =?utf-8?B?MkM3L3E0MVl6VE11UFlnT0N5RHRxS2JkVEc3dTdBc1BsQkpoWjhob3UraWVO?=
 =?utf-8?B?eUNZc0JWcEE0SnpDME16WWs0c3NpaVNUd3gvRGJvQWE3K2N1ajN3R3g2VjFI?=
 =?utf-8?B?VjBCREV6ZG80ZEZqbTFlSGhkTDl0VjlwanZIb3h6RW93eW85WVdHTWtXTEt3?=
 =?utf-8?B?UDd2dHdaU3pPYU5vTHJNMUNZaGRVTDAzRUpmZjU1Q1VFR0orUlVtK0pzTmVG?=
 =?utf-8?B?RG5uQUJFQnhvbnNVckNGanZNWE9adUxXRURqbkVFSWY5RzhmbUtnVlFyZHZW?=
 =?utf-8?B?Wk9TamlCUStVckNhakN6VGZjZXZQMnRWU0dKL3BHbWxVZjQvNFhieVhrMldt?=
 =?utf-8?B?KzVpNW5XNm1JaHExYXI3cTZFazBnZWg5dFJhMzFQa0NKa2llc0FveDYwb2FT?=
 =?utf-8?B?RHNJSXlLNUIzUVBFSTFQc0VicFd3UDlFU2VLSm5EZHNDb0ZucTNVZ0NTOVNk?=
 =?utf-8?B?QVJLUmZEQVlONGxIeW9iZ1pHMlM2SmhEQU9ZaEE3aDhzT0VacnJnSkVrQ0NE?=
 =?utf-8?B?NlIvMUdCQW9WOE1DNjNNT2d4L0Zwa2pGTHFWSWxQZ2ovb1pHY0YxOXczSDhp?=
 =?utf-8?B?bC9tZVRtTmp5N1YzdldjbVllTVV0SDJNNGoxUlNsRjhQcktWTWRhUEhOYWs2?=
 =?utf-8?B?a09ITXlkU3RFMHhueEM5dXBrcFkrZEpMNWZhanM5Q1ZPaDd1d0lKUTNoZ01j?=
 =?utf-8?B?VDhzcU5YWFhtVklPYmo0VEJVWjIvLy9pN0RuWTE0VHNJU2FnVzFqWnpJQ1li?=
 =?utf-8?B?UytwMHBndjJQb1VXS3dSaE9ETi9Gb3JNanNTV0N3T3BvNEFRR01NYnhhMXIz?=
 =?utf-8?Q?J37kBLIXuN52W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGIwcXpWZElFRHBmYnRPSzVKbDFQZU1VQ0prdWhsKzVOZmVGV2MxMzM0bWlC?=
 =?utf-8?B?dHBqSTA2c0hFMkthSXBLQTJhazVHUktKMUFKZE0xd2pXbW45SXhQT0N6clZw?=
 =?utf-8?B?a3FHMGpKQ2ZLMHU4OEdvdVA2OVpzV2VPaHlpZTFjdkVHMkIxbVFZNGUrR2d0?=
 =?utf-8?B?MUFDd3hsNDZqdjM5ZEVCaCs0V0NBaTFpWG41WHJwRWVLcWlyc3Rzc3VnODVr?=
 =?utf-8?B?bGZ2VndZZGhITFBNUGd2Y240eWtrUEdBTFFCOEQrSGVueUs1b0NuTndDUmJ0?=
 =?utf-8?B?OFBaRngrU1MvQmIvc1ptM1J5Y2NtbTg1eGxKZ1ppakhBclZRdzdab3BaaDBU?=
 =?utf-8?B?Yy8rUkoyU3NpVEd1WEFlR1RBTUJLbms1alVzK0ZhRlYzRTdYa09HWGo0Mlds?=
 =?utf-8?B?bGZDN2FkMmZld01DSHMzdFVJTExTYnZBM3o2U3JkUlUwNzhSWm9mNGdFaUhL?=
 =?utf-8?B?Q3RoMExPaWQ4bkloSVQzVXgxRHBiSVdQcUdSbS9XZVArSFlzZlFacVNUZWVl?=
 =?utf-8?B?anYxVDRRTURBbUZMZ211SDVYNC83TTlTQktqNTBPU2ZHVTFQSUppMEN4WFNM?=
 =?utf-8?B?ekduQlV6cHNrUCtweEE2czVNMUJPRVMycnRjdmZhbFZ4WmxOVXZUVWZpWmtk?=
 =?utf-8?B?NURvZ1ZiNjFZckxVK2JqZUE1MisvdFpaSWplelJ0aEd6MWdINjJFWlc1OEFq?=
 =?utf-8?B?OFBTSmVyRnFYUTl0dVlMclY4NG9uRVNkWExyNWRyWWNvOHBxbDh2cWpSQmgv?=
 =?utf-8?B?QjFRYkVHeU5CYUdOQk1sSHdVdTFrcVl6TkFlaC9Uam9EYjJ0Ty9ud3JQOGhu?=
 =?utf-8?B?NEw1c01kNG04Q0pPZmw5L3QzZXZjcUtycFRQRVlyRElhRXZRQ1RZMUp0Yzh4?=
 =?utf-8?B?Yjh4U1ZsMVU3bEdWamw1dUtFalJZREtYZ2FRWU5PWlY5aGNjSksxTkh0U1RZ?=
 =?utf-8?B?RDRYOW9pMS9lT3F4aGJGOWgxSXFzQ2hrOGJObEsxaHhLbVVZSENXWjFCemIz?=
 =?utf-8?B?R1EwMTFIa2w4VkVSUzdSVEYwUU9zUHNLSU9GcjhYOUVHY3AxVGxWUTdkMTIr?=
 =?utf-8?B?Y3NXQzJpd3JCckJjZE5XOG9CdTJPQTZHT2FJVjVJZkhCSVoyUzlWajB1NzAy?=
 =?utf-8?B?MSt1NkpSV0ZZR2FKbjRKUm9mUTZyUnNVS1dldlVsUWloM2RDanZRTWUyQVZr?=
 =?utf-8?B?SUk0VWVVUlF6VThaaU0yTlhqM0dDZStqVHloSUMwa2VzaWViRTVxWDhOS01k?=
 =?utf-8?B?YmovMlp0RFhNMWsxdW5veEwrT3lTcDM1ZW8wSlIvR0MwRXZ5aDJRRkllQ2g2?=
 =?utf-8?B?ekY3Y000OE13TnVZY2VWMUdKWEs0RDJFR210WHdVYkIwVjh1R3c5SGlISjZ3?=
 =?utf-8?B?L0RSTDAwdFJyc001cSsvcDFRaXo3YU9Wb0I2aFZqZWVra0hNbjZHODN2UmFp?=
 =?utf-8?B?SCsvQmZEV05JeXkzQmlPTEVyRnVCaTNvTVJGVi9qNlZnNWZkTFNlcmYwblFK?=
 =?utf-8?B?SjV6d0xBczhDaTFqcVI2VGljc01Ca1ZUbVJxRHdLRHByL0JFTTJVUVhXa3l2?=
 =?utf-8?B?eTFEQ096M0pBTFRuQjRDRytKWHZiQ1hqb1EzQ3BvUit6ZTBldFpjVzlIWnc1?=
 =?utf-8?B?SXQ1T1VycFFLREY3dHp2NmJNZnVsRlI5bVRVZmQ1bDZPTzVqajBiUE9iVmVl?=
 =?utf-8?B?UHY0eUFGTlVYbGJsN2Y2ajJTU2lRZW5QRnI3MXk3Vng5dW0rdHBQSUhFNy9I?=
 =?utf-8?B?RU9USmovMG8wSXFvS2J4d3UyM09IRkJiUXd3ZHRQWmE2aFBGdWdMT3RSNnF6?=
 =?utf-8?B?L2Y1WmxaWGh0VWJTeUhYaDdNMjFTdFlDakVlaUdlQmFKZ280bG5KQnVuTEwz?=
 =?utf-8?B?NTZVK1BpYkRaRjNqQVZ5K3VDWVNGZlNESThDRmNrRnlaTWZuNFY5RWE3RFBq?=
 =?utf-8?B?N1JkejVBcEhmOUZDZWppTENObzVqS1g5TXFqYWdkYW1jV2lRNkovSnBXN1ll?=
 =?utf-8?B?ZEE0dFlSVnQ5a2RILzVTSjZja3ZMdVZPTkhrUDZ6aXZ2MHh5WEVhaUV5bVll?=
 =?utf-8?B?dWY5bGV2c0ZBRnlEZUNybFJ1YXZmQ2phQTF6SUFBNmtCV2VQZEVQaXFYVnl3?=
 =?utf-8?Q?MFam7EEP+ExrILOPNmKNA6g1j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02385b56-217d-4f81-8f9c-08ddfb92d6f8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 17:50:24.8466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23zDos7qCUZLKCmyycl9kDdvy1UEP5/D4gp2ACCEROmMwNdb/8pHoCN0w8+a11iGtwDnUci+9+y/a4+VJmEKeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
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

On 9/24/25 12:33 PM, Timur Kristóf wrote:
> 
> 
> On 9/24/25 19:21, Mario Limonciello wrote:
>>
>> On 9/24/25 12:13 PM, Timur Kristóf wrote:
>>>
>>>
>>> On 9/24/25 18:16, Mario Limonciello wrote:
>>>> As part of enablement for SI and CIK in DC Timur pointed out some
>>>> differences in behavior for common mode handling for DC vs non DC
>>>> code paths. This series lines up the behavior between the two
>>>> implementations.
>>>>
>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>>
>>> Thank you Mario, this series makes good sense to me.
>>> My only worry is this: is it possible that removing the common modes 
>>> from connectors like DP, HDMI, etc. will regress somebody's setup?
>>
>> Possibly.  We're not going to know until we try.  I generally prefer 
>> not to add common modes (hence why I tried to drop them before until 
>> we hit the Xorg bug report).
>>
>> If someone complains about this then I see two other directions we can 
>> go.
> 
> Sounds good.
> 
> Considering the non-DC code already didn't add those common modes, I 
> think it's reasonable to assume that we would have already heard about 
> it if somebody had issues with it.
> 
>>
>> 1) to make both DC and non-DC paths apply common modes to eDP,LVDS, 
>> DP, HDMI.  Make them not apply common modes to VGA and DVI
>>
>> 2) Enabling common modes /across the board/ but anything not in the 
>> EDID gets the GPU scalar turned on.
> 
> I guess we'll see if any of those are necessary. For now, I'd propose to 
> just consider adding the common modes if there are 0 modes probed. But 
> I'm also OK with leaving that for later if you feel it isn't necessary.
> 

Yeah if something comes up and we need to weight it out we have this 
thread to refer back to for our ideas on what to do.

> A slightly related question, would you be OK with changing the link 
> detection code to return dc_connection_none when DDC cannot read an EDID 
> header on digital signals, similar to how the non-DC code does it?
> 

I personally think lining up all these nuances that are different 
between the two is a good idea.e e

But for that specific question that's probably more of a Harry/Alex Hung 
question.

>>>
>>> Two possible cases come to mind:
>>> 1. When we are unable to read the EDID for some reason
>>> 2. When the EDID is buggy and/or doesn't contain any modes
>>> Are these issues real or am I overthinking it?
>>>
>>> Thanks & best regards,
>>> Timur
>>
>> Failing to read EDID has happened in the past, but I think with the 
>> deferred aux message handling that should be cleared up now.
> 
> I was actually curious about that. I saw that issue while I was working 
> on something else. How is it deferred now? Can you point me to the 
> series that fixed it?
> 

There's more patches than this one, but I believe this was the 💰 patch.

https://lore.kernel.org/amd-gfx/20250428135514.20775-27-ray.wu@amd.com/


