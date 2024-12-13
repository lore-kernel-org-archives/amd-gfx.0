Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E8FE7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 11:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1DD10E02A;
	Fri, 13 Dec 2024 11:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZHtxPumO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7432C10E02A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 11:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igoJ5nI/OP9ME3OS63OdeISyquyK2ONvzX6QKRz5qPCyR9MONabo9BK9r4iqAuCalA9jU6Dzh+yQwtTDBla9lHthrn8ZX/rBEBNL/J8pcA/ABnlgiwDuTcRrLCNw9Y7XQRCSywnSKl923RIIsglrpTYzEAtGmgbxdAZUfvDQw/yHdarMrFO++mmtQP+hjVlN63wIJiq+KNSLMhteDAALnm8GV3nvp/6sbCRQl6EjoUYIVcUFDQYWDIuwP6Wo1l7C/NgJyA+4WQSfJ9u/+ZI6n3E2144Ydd/fF/xvrC/j6pXMYkHCc24P1B1byYfESrswC7cKrNf9bg6Tut1vo7P4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXjYMCbtcfTLD0CMFjtGb+XEdRSvWcLtIdqfQRRw2zs=;
 b=MEqSRyjANKK2fUc3OxlqgIEBxyqhVa2ROtJvPnQ58hPa82p5OKUeu/xvEYzsf2gzShr6E+Cl9TDWcAO0Q9t8t0iLDhLgkQjZJQDopx6BNQCJ/uElKQsdlKZ0GRuo8/61yEoMVOAQsHENYr5XEcoCi79UrAxG7QYcHq7OR25LeaAyapZMteHYQL/FDBYQXYD1PE6P1zJ/N3p6ABOeJa6Efn4tBY564uhFO28B3pVW1QsvD6u8TC5CfHLa6E3Eh2pgXWEbCoIXvAKjws9QlEBwKDXIXRNE+1JWgqs0euoM9CeU7I1gVed+6hjjD9JRWR+1FLUbRRKrWtWd582YbXth9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXjYMCbtcfTLD0CMFjtGb+XEdRSvWcLtIdqfQRRw2zs=;
 b=ZHtxPumOLP5PWbZZHKYT23wdyxO4z3rDIH9H7W3yT23vobftmVVWWVouD0LLmlARJ2ZVGYO7FMG8Ht78gZz+s1tUxm5RbVsvtsSjQUhLzLbNCdG8Sgz2VsetKwkeRu8TQ2n1cn5lH5m5HnVN8YaaWzAsy95Ty1srwRZZTsPWTH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 11:24:42 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 11:24:41 +0000
Message-ID: <e4766f68-a377-42f5-a166-50493bcccd83@amd.com>
Date: Fri, 13 Dec 2024 16:54:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/amdgpu: Fix out-of-bounds issue in user fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
 <20241212142533.2164946-4-Arunpravin.PaneerSelvam@amd.com>
 <7699531d-31eb-4716-bcde-3b0c41707ee4@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <7699531d-31eb-4716-bcde-3b0c41707ee4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::15) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 08efcdf6-c4a1-4a1b-5243-08dd1b68bcdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OG8vZDJ4ampHWFJkNUpCY1NxOTFTNEgzOTBUa0pxRTJpdEJPdUhPZXRmZDVS?=
 =?utf-8?B?UkMyVFlhSzlMZFRYT1o2N0RTNzJTbkJNSVl3VldzbFA4bFJqeE1CUkNUUzRI?=
 =?utf-8?B?SGhsV3lINXRTM2FNSXAvS24xejFjcFRBYVFhejBKUEJkR0dyeHpIa1BWNkJp?=
 =?utf-8?B?TUIwQUNZVkVXbWFnTnB1WjUzbVd2L0tNRGY3MjNraTlnb1o4RHpjWlFhZTl5?=
 =?utf-8?B?VVBKNmR5TklXd2Yya0RwSHU5ZHozTW1Tck9FYnBBeW1TZEtFcGhTRWxEc3Vi?=
 =?utf-8?B?ZVNnU3JzRmRsclNSa3c2TlI4cmVsK25Zd2hxOU5GZG1iWkpEcFZ0WURXSStE?=
 =?utf-8?B?eUErMGljY1RPakJWc3RJTWZYaWNObmpLaTFxaDYrQVM0MkRRYkorRmdlY21m?=
 =?utf-8?B?aUJFTElVSG82QWIvNmlxQmlwOG5EdFNQU2FzS1U3QVJoZFk0bTQ0cGZsNy9k?=
 =?utf-8?B?Z0VjL1lGTGhKR0ZadjZRd29KVXAwcVRkc3lsb0pwcWF2N0dxc1hTYXJNSXRK?=
 =?utf-8?B?YkhTRklmTzkraHBGOFF1NTNGVFB1UE1Tdm8wRk45K09Eb2VZcjk3YWkzc2RU?=
 =?utf-8?B?MDgvblI1cDRZb3lWUFZ6WE5PbERaVjBRNldvbklwSFVXamFaMXl5NE9ndDFu?=
 =?utf-8?B?RGtsZWtsT1ExWVlqOGFYNkZUU05FdmZPQ2hiaFUvekxDQVZLSC9jeUdINzhW?=
 =?utf-8?B?bTdGdXVBUG1wQTRtSTdxOWpCbmc2Q1FYS0hGTm5Gazl3eUt0VU52dVVGR1E0?=
 =?utf-8?B?MGNJZ1FpSXJaVFQ0NTFyZkpqcXFpSG1XOFNQMlY3T2JRZlgwbkh2SXY4VUt6?=
 =?utf-8?B?SEpDalcrZ2cyZzJTdXYwd2tsOURyUlE2eXoyd1Evck9uTEl1NWtMckxlY0Y0?=
 =?utf-8?B?eDc2M3BrRDkvZ1JnVFVkYm1FY1VleG85R3RDR1FZejdTbEV5N085VjJra29P?=
 =?utf-8?B?YXgwTkprQlBBMUw2V2cvTXhDYUFPRk1DREVYWEpZdVJXZFpGUVJhSjRzc3ZU?=
 =?utf-8?B?THBrOW5FR3hOaURFOS9wUEhESm1wdTE1REhJTit4bkVBbTRqeXUvMlBwRk9r?=
 =?utf-8?B?ZzhOemNFb3ZtSFFMTyswa1cwb1U4K1dSZy9FTFlIcnlxaU9CK29BS1BYU2ZV?=
 =?utf-8?B?WlR0NDIyZnhEeENLcjI0M20yMDRNU21Nc2hhTkQvR25JdEdHYjlMQjlyekFH?=
 =?utf-8?B?YW0xMkpYbS8rWjIrUWRLdm1STVcxaHdwWGRML3hCZmF4SlVkY2FDYTRaNllC?=
 =?utf-8?B?OGhqQVR0d3MrVjQzMU1YY1FSaWFOOVZtZEprdGV5RDdjM1dlMjhta2ZMVnBx?=
 =?utf-8?B?cXpIN1BLYVVMa2tLVi9MMVIvVFN3cTdpRm4rSjNDNXlFNVNxdTJ0S0xDRnha?=
 =?utf-8?B?dXFqeStGT0oxMDVTRVZIKys5elUwdlFiOW1xUHJIQ2ZTdlhFa1dNMGlMSnVk?=
 =?utf-8?B?YkwwM3FOcm4vR3IvaU9qVGlXSkU3NWg4d0lKclJ2VWpFWnhRcDQzT2tIQmhN?=
 =?utf-8?B?SGwxMWkwYnVIVVA0eTBZV2NBNDhvNEhhRTdta2owM0dVR2hqU0JwcHZGSG12?=
 =?utf-8?B?VC8yKzhHRU14TWRFYlc1elJkQXZlc0FjZmdZNEg2ZGxLUW9ZN3lnQ3ZTNk00?=
 =?utf-8?B?MFlEczRxT2Y5bldYR3QxZXh4MGtGVjFaTVA0amtZbTRmd3lBTWRIMk1qSmlM?=
 =?utf-8?B?U25INCsxeXVIdG9PeUZ1OUJMR0pCLzlSVGkxNDhPbk44SlRsMXJwZkUrazJF?=
 =?utf-8?B?c3RRcVpNWVhQYUpadEhaWm5Pc1ZSVmZpNlpVL2lPM1hyeE15bkdUeW9qVlRt?=
 =?utf-8?Q?Hiv+WBSm3s7zAwBwBp8m4hluHUvJoa57W5DKE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnlGUzU2QVVEZWJrSlVsMEtvWWV2REhlbDhJZGQ5SmpUZHNNL3pkY0RDYkdq?=
 =?utf-8?B?YnNaRVNWK1VjV0d1UDErZGpvQXNiM1IwaW04em9MdzVJQ0Z2OEY4ZHhPWExU?=
 =?utf-8?B?ak5zdmtwTmdKdXR6TDE5Q2JYV2ZzK0w1ZEN4dUgwWGErVUpjVWxUSUliVE54?=
 =?utf-8?B?ZUJFOFd4Yks5bDd6UFYzMnRKOUR1TDkxZlhaaDlWZ29BZEZzTzArMHU0eHFS?=
 =?utf-8?B?MzlhUzRkUDQraEtubGg3NzY3OE9oSFRpcGw3akhoblN1ZHJGVEZCVXFZb3ZN?=
 =?utf-8?B?dzYzYnpweVBqU1lvaGpFUWFmMEpRSHdCVnA2UU90Mkd1OXErUnU3V1B5K0tX?=
 =?utf-8?B?N05lbVl3bHIrOGJOM2hZcXBrNXEwSnpFR2Z0WUdoZmhROTNaNndqWVF6VGZj?=
 =?utf-8?B?WGoyWkZlOUdLU050QU1IL3ZzNU4vVGxJY01hSnFiTFkrbCsvcTVtd2c1Y2l3?=
 =?utf-8?B?Q0xiSlpKeW1IYWZ0d1ozZUZJdUk0U29VbzRTZHg1SFVxbXhWVHlOdzI4Qmll?=
 =?utf-8?B?dktJV2lMRDVTcWJzRWFZSDJ5dGRKYTgzMTlJV1oxZ21jVk5IQnV0aE9rbVZT?=
 =?utf-8?B?NGJBUFhQSEl3SlZSVllsTUNFZVBCNElFQlY1Rk5TLzU2OW00R1VQcWQzc2xl?=
 =?utf-8?B?TWFHeUxRWm9rYXNjYzZteCtWanY3TE9ZRXJGTklJa256bUJqRUJZUHNpTFpk?=
 =?utf-8?B?TTA3bWJaZXpFRi94SzU4WnUzK25wSFhUbGpLRnY5RktyWkZSeS9kQy9rWlht?=
 =?utf-8?B?bnJoWXRxNmRSZFpnTWpXbzg0c3BKbUl2UjRLUGhtdUxtQk1YTDZ1d2lyVzlQ?=
 =?utf-8?B?c3FBb1VmL0Q2Qkw5TTNYZDNoMnp0TVVPZ1FRb2dVSmcxd010bWFVVlhmSTI5?=
 =?utf-8?B?NXY4SkpLcllla3VXZVRnZ3ZKOGw2VUNmNTk5QVh4NWpPQ1BjRmtuTXF1cnIx?=
 =?utf-8?B?SjNiZmZxSHd1SS9McUs0dE5sNy9FWVVpNFBhUGN5ZExHTFh6eWxpeTR1V2lO?=
 =?utf-8?B?R3RMSlRGbEJRS0M3OGhneVZoU2Z4M3BmTUtIdkVUcW5YM1JydlRKMGRBRlVn?=
 =?utf-8?B?dE1ZYXhkRFNUVWVWWFlzY3l6akdQKzkzQjN2L2NxaXVJTkRlMW53Z0ZRWUp6?=
 =?utf-8?B?a3k3UDdaR1dLVVBubUZRVm82emRwUVBKcGFCdDRwcVUyQlRnMEU2eDEvRDBm?=
 =?utf-8?B?YVdyME8zZjR0TDdtbDRtRmU0QTIwZXhiQVZ5ZGp3ZjdmakowTGp4VXRnemZj?=
 =?utf-8?B?TzFXTjJCZGlHZlFyYlpJbW5jaGYya2k2UUFyelFsaEl3ckJQQ1FZdDRzR1hv?=
 =?utf-8?B?U3JJKytUaHhqblYrdFhIUWJFVVA2ckpqUkhKZ1owMDk2QitQUUw1aTY3SFp4?=
 =?utf-8?B?dktqVU1PZ2hUSnJNTjk4a1pnZDd0TnMvbHd1a3U3Y3hqeThYY242ak4vUnR2?=
 =?utf-8?B?ZS95SmdxalFDOGZxNXdxYk5HaXJNS2x3R2VFMFFXeDY5OERSMklKZitzVHhW?=
 =?utf-8?B?SnhCWlRreks1WTdhRnA1OEc2NU43Y2lXNjlVR1o5WEZsNThtUmlwaW9wcWw1?=
 =?utf-8?B?Q3QyMmVLV09xdDRPRTZTbjBleGMzU2xkdGF5MExCcmM3RnQxWmtQemQvdStj?=
 =?utf-8?B?czNZNk9Pc1lhcU5EQlBTYUNBVEZhUnpJbzdVL0Y0MzZIZmhJSHllbVJxTFlx?=
 =?utf-8?B?aDI4emt3TmFDaTdoU3Ayd3Z6RnFLbVBxUDMyZ3BZVGhLN1gyQWZSNk9iWU8x?=
 =?utf-8?B?UjE4ZjgzeDluT1E0YXZqenY5YzdCbEVkU004TzR5YzczbHFJZmN1cHFBQ0R1?=
 =?utf-8?B?VlRDUjNSMS9tZUFtTVhuNUN5OC9pckhjS0lYSmF5c1JmSVhkS3VBTVJ4Tms5?=
 =?utf-8?B?eFB6UFZxeDh0NWxJZk9sN2taY1Vob2YxdEQ4amxtUHJtM3pQVmV4aDdUQzBx?=
 =?utf-8?B?bVVxbk1LU1JUcUtkanJ0VXh4eFZONXdWRExDamwvZzVCb1hlQTVmZ2UwOUU0?=
 =?utf-8?B?bHdzaWF0RUVlZzdYaVZ1QVdVVzk4MjdlZUtQcnBGTG52SkJFNDlGOVhyWlFZ?=
 =?utf-8?B?MG12QTROSjlWbDhtYUNkUDNKN3oya3RiRVlqb3VJQWU1c1IreGozckNFaDUz?=
 =?utf-8?Q?jNMkyUkb1u3kdZaSM9i1/5k9e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08efcdf6-c4a1-4a1b-5243-08dd1b68bcdc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:24:41.9148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRoiwEe5YcRmHrHKmJjp0u0jo6fkrPtXg2SUBtIwCvuuZyaUamuy9VEEIlscxciTOLjcXY3jHfgQpUQxlFVKlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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

Hi Christian,


On 12/13/2024 4:13 PM, Christian König wrote:
> Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
>> Fix out-of-bounds issue in userq fence create when
>> accessing the userq xa structure. Added a lock to
>> protect the race condition.
>>
>> BUG: KASAN: slab-out-of-bounds in 
>> amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>> [  +0.000006] Call Trace:
>> [  +0.000005]  <TASK>
>> [  +0.000005]  dump_stack_lvl+0x6c/0x90
>> [  +0.000011]  print_report+0xc4/0x5e0
>> [  +0.000009]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
>> [  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>> [  +0.000405]  kasan_report+0xdf/0x120
>> [  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>> [  +0.000405]  __asan_report_store8_noabort+0x17/0x20
>> [  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>> [  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
>> [  +0.000408]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
>> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
>> [  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>> [  +0.000404]  ? try_to_wake_up+0x165/0x1840
>> [  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
>> [  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
>> [  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>> [  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
>> [  +0.000043]  ? __kasan_check_read+0x11/0x20
>> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000007]  ? __kasan_check_write+0x14/0x20
>> [  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
>> [  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>> [  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
>> [  +0.000044]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
>> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>> [  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
>> [  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
>> [  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
>> [  +0.000009]  x64_sys_call+0x1205/0x20d0
>> [  +0.000007]  do_syscall_64+0x4d/0x120
>> [  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  +0.000007] RIP: 0033:0x7f7c3d31a94f
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 3a88f754a395..49dc78c2f0d7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -229,6 +229,7 @@ int amdgpu_userq_fence_create(struct 
>> amdgpu_usermode_queue *userq,
>>           unsigned long index, count = 0;
>>           int i = 0;
>>   +        xa_lock(&userq->fence_drv_xa);
>
> Don't you allocate the userq->fence_drv_xa after counting the number 
> of objects?
>
> If yes then you need to drop the lock again for that.
We are allocating  memory for userq_fence->fence_drv_array using the 
kvmalloc_array(),
should we drop the lock for this memory allocation and again acquire the 
lock for
moving the fence_drv references from userq->fence_drv_xa to 
userq_fence->fence_drv_array
code block. Is this correct?
>
>> xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>>               count++;
>>   @@ -240,12 +241,13 @@ int amdgpu_userq_fence_create(struct 
>> amdgpu_usermode_queue *userq,
>>           if (userq_fence->fence_drv_array) {
>>               xa_for_each(&userq->fence_drv_xa, index, 
>> stored_fence_drv) {
>>                   userq_fence->fence_drv_array[i] = stored_fence_drv;
>> -                xa_erase(&userq->fence_drv_xa, index);
>> +                __xa_erase(&userq->fence_drv_xa, index);
>
> It's *much* more efficient to release all entries at once by calling 
> xa_destroy() after the loop I think.
sure, I will try with xa_destroy().

Thanks,
Arun.
>
> Regards,
> Christian.
>
>>                   i++;
>>               }
>>           }
>>             userq_fence->fence_drv_array_count = i;
>> +        xa_unlock(&userq->fence_drv_xa);
>>       } else {
>>           userq_fence->fence_drv_array = NULL;
>>           userq_fence->fence_drv_array_count = 0;
>

