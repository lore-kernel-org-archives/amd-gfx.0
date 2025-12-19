Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD3DD74965
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 08:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F1910ECB0;
	Fri, 19 Dec 2025 08:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b1Ez08cQ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010028.outbound.protection.outlook.com
 [40.93.198.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB7910ECB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 08:13:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+H5NnmXuYZmpGSIVq1Z1Gnu6cfzKMJBT7hyP9vByTV+wYVjbjDGj9svwteO53megfJjVZl75s4X2Zg0ycQiIGLdndpjLXvrbZdBu82aWQCk+PPvxMJgznxxE269CtZxX//UbYdo5WN5nLFz5GVyGNKuo67XikDnrsx+rF3L5paAJ/mS40Fb9GJCVQbYgk4LbLcOjRWf5vIDtgCt9NsEBnG/oBu+jVZWrlYrjYjPl54WjXFbdCvvCDZE9EvjlpTqUTOZyp0X5Yn/b7mGsdE+TGwhfzJNJUXG6zC/+D49ySwacCVhQ/rt75KA6z6lxQv/0sjhJX4vpFC66MNcszyFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUsd7xKoyic7EZmoEA2WlT0hBh0aAVG66K1Gbw9U7Sk=;
 b=H6fc3+ZVFt/Ir1a0nDhvXj1Zj/jkwE7qFhiNzcVvr//oapOtXh0CkwB88G57GATvGWl4ZFnrsjpeqdw/f2BpjiOdaC8u2cp6GRNDE6A7W2LO+3TNwYTbQfATz4I2A2DU1RQyBCSntcBkFO5crSOOfLoU02famekh3UZdsBLAfOAgbvT/og0LoSH9XD5gn0d6laG8BclVNB9CsC7hYXSZ9e5/tOOyM0D5CylZc/szoQouhqdDloC7sY+DGZ8AeBwnSlhdkvlV1+9UCHD4TJ3zUD8w4QLCpsFgfoB+cd/qlIJqxSn5JtTibCsDGbnbP9W0EoU90wn+UbKYG26H/gxvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUsd7xKoyic7EZmoEA2WlT0hBh0aAVG66K1Gbw9U7Sk=;
 b=b1Ez08cQFt8Y6mdaL4KBk2ORgTozhc9JVWCXJZUKpDBLrcWRZJUpIdKxW1yaClor6x3ASXd1umah0W8xnW1HTzHsd0dU6JQRellIWEn4iZ02+ZF6a809DpmFRDLuT6D6JgF/NoxX4Tu7MtVxLnYxt+LH2K+Lyu77ezIRyH3R9O0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 08:13:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 08:13:42 +0000
Message-ID: <46dde040-ad1e-4923-911d-2316e54e370a@amd.com>
Date: Fri, 19 Dec 2025 09:13:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/5] drm/amdgpu: Simplify sorting of the bo list
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-4-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251218150405.80502-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfd02d7-4ad1-49f0-7151-08de3ed685ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UENHdm5TUWFmRTFnZ2VFMlJndDBWZVRIRUtZOFczK0tlRG1nMUhwZHhpMHQ4?=
 =?utf-8?B?c2NkTzlFaW0xaVZORkVhNjBSbXl6a1Y1MnFJbWlwOW1ZVVo4Y2prRDR4TSty?=
 =?utf-8?B?SzlrNkQyM1JwQWtkc2h3Yzc0Zkk0QU1VdnBxNGtjTkhkWXV3dkJBNXRxSE5I?=
 =?utf-8?B?WWpyQ092dU12Qm9kOEpmZFE4TVVsREJLYUxoWUl3Nk1EQVBaZWt2NHI1Slc4?=
 =?utf-8?B?aHArdVRwZWJHczFGK3JNdW9KS1BrSVlJczBuRVRoS21HWWliRmF5NmtDSHVi?=
 =?utf-8?B?MHBORWRJKzlPd2UwZjVxMWtiUUI4QlkvTTJOVVZlQzRZdDhTazBGTWhHTy9k?=
 =?utf-8?B?eFhuN0hmakFlWFpsVzh0eVYxSVNDak1EVUhPWncwZWl4YzF2VExzWEdFcEps?=
 =?utf-8?B?VmJTNEV0L3VvRjJCZ3hlWjBiNjljbVJMWFVyVEVkN3QvU08xVDZ4ZW5nN20x?=
 =?utf-8?B?OWtCcVVKOVJHU2xzZXlLVGQwbkx5TWhiTWpIRHp0b3ppWVpMVzd3TjNpNnJj?=
 =?utf-8?B?M0xJN2IrbzRjNDRIY1gwd1hpSWsvbFMxd1JIY2NLbVIrdlV5TU15dmgwKyta?=
 =?utf-8?B?eGhSNkJGcitqRGhYb1VUY0g2T3hGNzNpV2dPTkhtNzgwam5lQndVc0ZPeU1S?=
 =?utf-8?B?Szhka0Z1czZPdlNxRzExMkZNSFllZyt3S3U3dG9vWTlmelFnem1nTXVyVUpV?=
 =?utf-8?B?RGFUUWZVaHdXV2lIODFzU2ZiOGcvUkpjOEo3S096QVRXZC96Ni95Q2lkVzlP?=
 =?utf-8?B?Z2craVBWQzlNRWNXUFFkM09hYTgvVXQrdTBJTjVmSFBVejBWTzltajdkNEVn?=
 =?utf-8?B?OFhDRTMzS2FLVWlTUlV6My80UU9PTGNZbUJuWmppR1lmeWZ4dC92NU92R3Fw?=
 =?utf-8?B?b3U3UXBEV2tzcnBvZnNKcHN6UG1aWVIxREhobDVrSmRPS1pkKzJ0Wld3b1JZ?=
 =?utf-8?B?M1JJOEhDWjNrRmx6VzhrM29PSnFLOHl2UEtQVm9jUGhrcFlrd01NeGhLdjZS?=
 =?utf-8?B?NS92ZGJ2Wk90bWxsR3kzak43ajJPVkZjMkkzV3hqSmIyR0l5S0wvaldwSnZl?=
 =?utf-8?B?R3dLeTdXaWd1N29xUnZlS0dHakZFSVViRXFuMGNzUUtnSEJzaHRvWVRIRStz?=
 =?utf-8?B?bXJQVTNXMGR3clhPMUgwWDR5Ty90WkNacHQ0elZIcWxDaEMzTkc3MEdsWlQx?=
 =?utf-8?B?Z1RVUVZGOFZGNHBwQjR3YVFDUUtpdFovNTl1Z1JJdHlkL05NbEx3bmZ4VWNG?=
 =?utf-8?B?QUc5eXBpUGYxWlBud3FTenBoeElUK3dhWTRsdlZTWFl4MDdOSkZGR3pqbGdo?=
 =?utf-8?B?c3o0dGlQSVNNNmRyQkRFbXEvdTJJQndNVU5IZlVYSlkxa3VOYTVmaWVoMy81?=
 =?utf-8?B?VnBkbUdOOGtSYWZHZFowbTEySFVjcU9tNmw2bzRCQkNyc082Q0dDZEhCMFUz?=
 =?utf-8?B?KzhDdjBwQ3ZpKzg4SUswejg0ODF5aEtsazl0azF0ZjRyNnpMc0tqS0draG1G?=
 =?utf-8?B?eHhIVThRSlFXZXU0cXQ0NzB3NExneGJjMHhycThGZ09MR1N6UjNEaFZMYmVy?=
 =?utf-8?B?U3dVeUx0S3AyV2dOUURsQ0pVOHpBUmhWeXArUnRUZW54U0NxbURNemJXbmhV?=
 =?utf-8?B?bGx3N1ZVR3EzSEl5M2VDOUM4bEFzVm1xQ3FlejRCcHZTaWdBU3JLa1BibXNE?=
 =?utf-8?B?T29VVTJTNFBKWWNTU1Nvb1pFYy9LNE1iOWtKWHJuQnFCVlA2dElyblRIUTd5?=
 =?utf-8?B?dW5qUm1yTXFUS0NqS1pDdEZyZG0xdnE5cTdveEZYaWhzaDBpdlI2cHE0QWNK?=
 =?utf-8?B?WXExZGhFYStpMGhqR3krbHJjbEFtQWc3TGN6d05YYWF1YVI4MW8rWUNvM25L?=
 =?utf-8?B?SEFzMk1hYlVSOGN0NC90Q213UkdHc2plQkFDb25TYnZ0TEhjQkZwUlZWNVVN?=
 =?utf-8?Q?3GLLdB+eoMVsN/Qv9Wy8mUFbFrXx+dGW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJiWmpNcmQyRjl4QjRnK0ZaZENzb0V3eVNiSUtsclJSNXc3MFhwZGExd3pP?=
 =?utf-8?B?SFM4ZFd2ZmlUYkRBUUtkeStiTGQ1VFpKQUQyQ0VrUU5VYW5md2lHZWVtdlp1?=
 =?utf-8?B?elVCMnkxRUwrRkJCVmwxdVhmQjNjSzc3VC9yMXg2djd0eWh5aEFjbGticFdX?=
 =?utf-8?B?OThqVVJsYUp6MnBxeXpMdDlGaUg4bFI3ZGliNXRCZHlQU0FHWEJ2endrRXRq?=
 =?utf-8?B?aXpSdmZ4M09mZ1M5Z3QzY1hrdE5NK2hKTWxlU2RUYWkyUzJadGdlbE9ZYmRU?=
 =?utf-8?B?MGYxNGZEL2NKazAzYm8xbUY2dllVeWxveE5DSEpncHpneDBiRFc4NWVuL1Zh?=
 =?utf-8?B?bTlBK2oxSzIvMUxHb0d5N0IzMWF0dk1VZG52aHFxZkNVamoxQjJGOGxSb3NQ?=
 =?utf-8?B?WkNVeWIrcytqUnB5dVJ4MHhVbVFXUTVSaHFSSWJxQnNaTDVYUGUwWWs0cXJ3?=
 =?utf-8?B?eUFKdDA1YzdPRGd2ZkFBWVZ0QVRMc2k1S0RKTmw1YUFiRExkNThBOFIvWnM4?=
 =?utf-8?B?blJyalBBbFA4WGtJUXUwUC83WEVyV29EdnlkOGxiRytpam5VbHZTSEpjZGlr?=
 =?utf-8?B?S1hmZ3Erd1hQRkRCSzBpSzJXN2Z6ZjJ1SXR5dFRFSENPZFJNYW9tVU14a3lI?=
 =?utf-8?B?ZUQwZ0tBTnhoL2RaQUJyUUF1UEtvRmlyOFFiaERnekNlQ0VKL2FPSXBxVkh1?=
 =?utf-8?B?MmR0elN3U3FZeHVZUm94TmZQYjF1N01DemVPcDRPVGR1R3M5SVdYQzZUb0cr?=
 =?utf-8?B?WEJnT0x5RkdPN2EzSUxMcE5kcFRheElZdUFpY3Jma0E3bUxBMytzZUxiRmth?=
 =?utf-8?B?NithR0s4Z0RPdC9xK01ncEw5UWZBa1k0Q0crTXljeHE1VFQvUHgxSjlYYnVj?=
 =?utf-8?B?aDQvMlAvRk9tN0lNQkFOTGRVL3RJZWczbGFSbXVHMXBmYWx6MnVOOERBam9W?=
 =?utf-8?B?WTVmcnYwWkw1OHRLTGxqSmk5TlZCMXNLY3lIaG9CcWFwUUt0TWEzNlNaU20y?=
 =?utf-8?B?alVUYWdnY1BqaGRZVThQQWh5SkR3b0dBWjltQ05qaWFZc1htOFU4RG00ckFh?=
 =?utf-8?B?TW16SjJiQTYza3hnMHlZcjhlMTFTTEZUUW5lTUM1UmQwUzFIL3I3dGR1YjVz?=
 =?utf-8?B?Zk1pSzhjYXN1NkJqSFJYazhjUi9vL2hSY1VVL0dVYlEwRG9uUkhwbGtudU9D?=
 =?utf-8?B?akk0STUwVVRTRVdWYVB3SzZJR0JYWEFuaHR3M04vb1pDSHJINzhoRTNTdEZv?=
 =?utf-8?B?TUtGdXh3ZUFsU3lud2xqS2lqSEFKSVFpUFBpTEFjTUgrMzVQa3liMzNCQkk4?=
 =?utf-8?B?V0EybEc0dUFmeUdQOWNMV2Q5UHMwQVQyanhDdnhydkw4NXREc0RuaFBzWFlY?=
 =?utf-8?B?MjZ6dzUxcVhzWnl0OEh2dkZXdkZoWHNFQkhHTDJTSTR0OCtvWVJ2K3N3Zy95?=
 =?utf-8?B?N3FndjUvUWN2ZnBncHFHK2hXOGJFdWZyK3RYSlFPcVhZYXR1QXowQkMxSXRC?=
 =?utf-8?B?TFFpWU8wUFVYTkZjVllTckNaTlZIaFNSdnZWU01qcys3aW1WV1JqV1hLYkls?=
 =?utf-8?B?a21yck4xV0Q0Sy9WbGl2eUF5dHBDWnpJVXk1ZGNUN1k5QUlxTnoyKzd2SnA0?=
 =?utf-8?B?YVVtK2pzKzVQTUdpbS81NURmU2RsRU11U3NseWZKckVSL2xFVitDME5tVkdr?=
 =?utf-8?B?eDVHV29jN3BvdHEvQkM5VjRXVCttR1VvdFZjMWg3aHhlZC9WemxtbUl4MWdl?=
 =?utf-8?B?M1ZaeDZMYmd6V1gwYmZtMUxOK3dIUC84T1F2dDFWb3gvalhhWmxKVnE1UHp1?=
 =?utf-8?B?a3dCNmNtTmMrdDFwT3VVVkQ4Y2JqenFESDJQaG9rWlZTVlhrN3N0ZWlmbGZO?=
 =?utf-8?B?ZzY3SjdqNXdzKzlPWFhVZnlkZ09sRUJyYWZzK2R3RXFZcEIvSmd1d0FLYnVt?=
 =?utf-8?B?d1pTNElpMGlKajhJbFQ2YVdSN3VjTU0xS2VBbEk1WjNXYktVYnpEM0NTY1I5?=
 =?utf-8?B?eDJhNFdMWWdzYkRFaFpuaTBWMXhVRlFtUXRTOW5ocW1tclo0dUtxZGE2c2lu?=
 =?utf-8?B?RERyUFg5TmlYMWNoSjVHRlJrVEZ2N0N1MzhjajRyNmV0b2VHaFZyZmh3ZnN1?=
 =?utf-8?Q?mWkGW1yD4k6IbqC7hp7/RanHT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfd02d7-4ad1-49f0-7151-08de3ed685ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 08:13:42.1827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmMBuqnSdRzUGaEps1hARM0JvNxuyAV96LLxTKnx5NZ2QPXQC1/M1bIlSjEqdKdd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
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

On 12/18/25 16:04, Tvrtko Ursulin wrote:
> Sort function only cares about the sign so we can replace the conditionals
> with a single subtraction.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 0ab307317145..16b647b42b0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -60,11 +60,9 @@ static int amdgpu_bo_list_entry_cmp(const void *_a, const void *_b)
>  {
>  	const struct amdgpu_bo_list_entry *a = _a, *b = _b;
>  
> -	if (a->priority > b->priority)
> -		return 1;
> -	if (a->priority < b->priority)
> -		return -1;
> -	return 0;
> +	BUILD_BUG_ON(AMDGPU_BO_LIST_MAX_PRIORITY >= INT_MAX);
> +
> +	return (int)a->priority - (int)b->priority;
>  }
>  
>  struct amdgpu_bo_list *

