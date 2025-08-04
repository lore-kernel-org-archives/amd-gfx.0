Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71540C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 12:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F174010E1A6;
	Mon,  4 Aug 2025 12:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jm4u6NDl";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5F010E1A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 12:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByAEuGyiFmDBMg8gKOS6+H+kShYEvrcEXXqXoYarMr6hsT2e7TISK+b1jlXPB+8ibpxhLghclJnA3kN3Lm0eUPUwEFwxZXhO/2qCHevPsse3eZOP537A4kAeVeC3t1nEaKQgANkjsWf6fQAGXb/4+qPMD0rYSxCc0u3szt5RShYXzW4EBIp+/i8KENKYth/Cp8SraOuKepgQPF7Bo8eagTv6ZkuxpPfQfRX5l6ZNhqULunUHaT3hh/iSxmW2lQSHWz5TMXvymSl0WGebua111KYjs+Z2yor7d17NKUZLDOYHIPIlqDWwDgGZfO8xV8qKWaTlt6l1xYK0H/+W8ad43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8NDjejK/PmrCDf+EhELNsedNXnjHfSKVB0za1ockhs=;
 b=Bsij6XEJl2nUBGsibsgKU78v74MrtRFXTwnKJWNKjwZ3v3mXKZy3teIpfHke4ry4pcBsllOpjnLAe5bKuzwhmRg5HXjU4+DAGrHq48xWSj+i0lEgRruR/2QQD4m+zhhVmDuYMhHDXn6enA2QNzh/P3Ul1turk/q3gZ1U4cPOrN2C1Z/qi91Qi0y/tQrxCfb4dJj22e7psBHh2JlJbo0mmEEgO1w8et95RpY82kzmJkX9A9ZTp0y1Mw45oZ9Up0cnKFRpOx8vq9N9WE4eDnAe9X3Q6hHvUg8qB0vXkwtcjPSXAwcSI9bjqSexNBcovcWNtFy2yDyAPrcWZkDy0fP+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8NDjejK/PmrCDf+EhELNsedNXnjHfSKVB0za1ockhs=;
 b=jm4u6NDlodHLHXS/5mCvZ2bJ5/1YMIY+/T8fpwCY9UFDaAPvUE2rp0r723yVFYaDY5YZ2Uv343/Y5Dx4+NR4LRt5zW4vyGcK7iBjf6bNGy/Yaw2f+JIGEQ5d1l0TX09K1nylF+EC40+7i4ToBGlxIYayy/q4YjTL5RVbg2SlgnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Mon, 4 Aug
 2025 12:22:39 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 12:22:39 +0000
Message-ID: <d26ca6d5-e715-473c-b808-c6fb149ca8c7@amd.com>
Date: Mon, 4 Aug 2025 17:52:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] drm/amd/pm: Fetch and fill temperature metrics
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250804110539.637463-1-asad.kamal@amd.com>
 <20250804110539.637463-4-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250804110539.637463-4-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::13) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed7a9d2-0efc-49d4-4de9-08ddd3519a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2hKRmI1N2dudU14ZmxZeUhzQjRmdjhVWDBnTzJ3aFVYZHNRUi8veDVERmZQ?=
 =?utf-8?B?YUdXWElZd2kwNEJJZERHU3NNRVdkY2V4QnNZUDJRR09iZkcvanpCMVlsb0ty?=
 =?utf-8?B?bEoyK1o4SndJcmc5WW9HWU5wN2JhVzZjZXNTb1ovcjYvYXhETXNpQ2tMY0dS?=
 =?utf-8?B?cXEzK1BEV1QxenJlYTRGY2pOOHY5aEhjRHhQVVJBV042WWVrTk9iQUdwRHQ1?=
 =?utf-8?B?cDJ4SnBtbE9mTEJ4bW5NWGRwS3ZmSWdvUWVGSWs0VE1VVlQ4VW1mVGU0bjRC?=
 =?utf-8?B?OUZDMStCUW1JOWk0ZlhLRitnb01nV0h5eTdRaTZMODZ3Z0IwSko2M241b2Ey?=
 =?utf-8?B?SzJkdzFDVWQvNTVMbVRjdmtXZUloaDcycWZaSzk4RlRiYmFvSmJ4MW9HV1Ax?=
 =?utf-8?B?ZnI0cTJRcE1Bd3h5Ly9waEJhUmE0VEFRWjF4NFZ0NklONUJZOEZLSWdQcWNz?=
 =?utf-8?B?VGhGT21oNTRVdllSbzd6akxrZFQzRmtOTVNPbmVsRndhYU5zRlhlNGI1d0hN?=
 =?utf-8?B?WUMyWHRZc2pyaEZWcEZBN1NxN0Nad0N0Um9BNTZWSlEwcUNaV2J4UEJMQk1s?=
 =?utf-8?B?V3U4dE9TeDM4aWxLOXFnUUE3L2J4M3dzWnE5dzBXZFNaaGMwbythTjB4S0Ur?=
 =?utf-8?B?bk80VFJ2bFV2ZmExSDdwLzlUVWxaRFZMUFBrbzBxTHJHbmRSQ3Y4dVlrMjJj?=
 =?utf-8?B?SXh1cDNuc1l2dC8yRzdkSlEvc28yN0dBalFVb1V4bjdFeUUxZjBKY0NRdG1G?=
 =?utf-8?B?MGt4WEZyVkJvMEtjc1dqVG5QcEdvd0o4MGhaSHR3Z0VFa1VWanEzdktrbmtQ?=
 =?utf-8?B?bGZZY0VoRjVqQm5zWXVLa254amNkeE1RcS9xYWh6Qi9xSlYrdmRGbjBzeEk1?=
 =?utf-8?B?OWRmb1pyckl4YTZhOTYzNHVIWXczK2RrdVNTdi84YWZlTHpCTTA1enZzUTlV?=
 =?utf-8?B?SzlNODhlSHFla1k0MkhST3B0cE9hTWJEaWRWSEUxbVpjMDRGRzFvQjVRSFlX?=
 =?utf-8?B?cFFUVi9jS1RNLytLYnVVVzNnakRVRy9nbm10U3Z1SGV1alFDYzBJZkpQdmRY?=
 =?utf-8?B?dERJRjc3THM0c0JvMWNkTUpFZDhVQXhHVFBHSzhjYzljWTdBVDFlNTcwS1V0?=
 =?utf-8?B?eVc0ZHZiQ1F1eHo4Q1RxaXh5bE9UMEdXVkxJTVVCR1EzekFIemVpNzcwa1RG?=
 =?utf-8?B?OTM2SVZsMWZFMC82WEx5UjNQdmlNeDNaZGtDSXBxNzJIdEhGT3pCVkVtbDdo?=
 =?utf-8?B?YWZ3cTJ3Q2ZlWHNIaGhkWVFOTnVaK0NnaDAvUDVURXdNMjMrVHZsVXREaHFQ?=
 =?utf-8?B?VEtXQWkzYUxGcTN3dFg0VmE4S1loOUpHdUpaRVFOeFZndGE1WjUrdTZIQndp?=
 =?utf-8?B?c2pWRXRMaHI5K2ZtK2IvcE9zOXNSeUdhUzB1WW80MXFNQjViU09maldyZ0Ew?=
 =?utf-8?B?Z3pxclhWTFVlcHoyN2FoM0d5VjZFZUtHQ0lKUE9JemRZQldJUTJuWVByWGVY?=
 =?utf-8?B?RXovVHY5ODdndWZEVDJ0WHJJRE9xdmxVSFA1a0U2NllxVjNJZnBsUWRtWmZP?=
 =?utf-8?B?eVo1M0EycDJ0T2t1R0w1UVBxdnRJZDYwVVJWTnYvUG5ESGxrZWpsZWMvRkNh?=
 =?utf-8?B?ZU5ER0J1Yy9rZzhncG1BZ2RKbkZzdTNCY0hTdFJ5MzMxNnpWbUlmNWNVNldS?=
 =?utf-8?B?em5zZVVwUEc3YWI4cEgxVHh2WktiMU5XOFlicXEwNS9FTkJ5cHNHWGp0UnVY?=
 =?utf-8?B?U2wvN3ROelM5dVB1UGNBK3FqajgwNDVVZjRsME45YnR0RXNmanoxaGJPaklM?=
 =?utf-8?B?c203QStXM3hYdXhZQnFKTERKeW8zVUpUTmJTK2I4SEwvUzhvbXVmUGdIU2FH?=
 =?utf-8?B?L0VwaUdxckxZTXV1eTdjNFlJVFVWdVV0dFB2ZGwrblpQUVNISHFTb3pua0VR?=
 =?utf-8?Q?6TegOhCZRSs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmpLYkVxK2Z5Wkh5Vmo5RUZMQlNKRkdMbzdPZDl6S0ZZeE52eGRZREtDV3VD?=
 =?utf-8?B?cFN3aHorSWFNVW96UVAyTGd4c2F4NWVESjNHUFVBaGxmWHpNRUxYV05tcXNu?=
 =?utf-8?B?Z0p5TkdSSWQ0ZWYveGVBd1ZJUFR4TjB0dW1xTHVYTnZXdkpOVnhkbDJPT0RK?=
 =?utf-8?B?VVcwOXFIZ1lhSkxOdytkTEhaR2pBbnlvSktRS3lxK2hLejFOeEg5N0U0UGM1?=
 =?utf-8?B?Mk12U0l4U3doc1dZWVQ4SmI0SFdJNE1JWDJTQVlBbDZUWFRYV2JGOTFWQU1m?=
 =?utf-8?B?ZXpGZHdEY0NNMy9wTnppZGpTcHkzVXd5VndsRnJDSzI3SzJkNDVRZkpEYUdj?=
 =?utf-8?B?dDhZU3d1VUhvMXRuTU9BWkdubHNEMUFIaHo0bU9MTnQ0QlFMYUpXOXBwenJ2?=
 =?utf-8?B?TjNYbFBYWXJPSVQ0TkFUNTB1K3ZCdG40TXFXZ09kWnM2bnprdGpOTCtRWXFI?=
 =?utf-8?B?YVY4UGN1SloxWlFlNnprQmpJeHJrVWprMm9hd3plNGdaMVVTc2xuV1lTSExK?=
 =?utf-8?B?UzhXdVAwV3c0cnB4ZlhDOVR5S0Fkc0FxSU50bStpcWtjK09uY1ZndThsUHhZ?=
 =?utf-8?B?eldocHZ0d1RweFYyQmhONlRuTWZUbFVJZUFjejdna2hrdURycDZDazByTDAz?=
 =?utf-8?B?eEE1b1Vsbms4UnFiLzZXcjEyRE5JY0w4c3RvVUhFbEpxQlN0MFpTSm0zWStC?=
 =?utf-8?B?dnRQS0V6VnhvZFkvb1cwTUFGWGtPaXMzQzBjMU8wQW5meks4dGdCQTl1QVZw?=
 =?utf-8?B?TWpKQW9LdFl2VWRyUWNFSmN2Sk1CaDBENDlTUFc5VEloaGl5VlZPY2t4NEov?=
 =?utf-8?B?blZtVVNKWXdWeEpLa2NiVi9mWDFqNTdJc3l3MThDVkFEMWU1ZExiaGRGaEtE?=
 =?utf-8?B?eDQ3bjZibXgybFVDR0piN1I2c2tid3JKTHlDc3AzazRzcXA4RjFWQVY5OExt?=
 =?utf-8?B?WkdvY2ZjNlpuUkFvK1M4WkZrTlFLbkk0NDRLYVZzUUloREh5S3diV1BRRmJW?=
 =?utf-8?B?KzQyR3pvMVpaQXpIZ1p0REl2Ti81Z2tzOWRHZW84N0dnSXNmWmhrSjVSOHJh?=
 =?utf-8?B?aHVXcG90T3IwS1UyM3FMY1BwRlBUUkdibFNaWEJtY2xmVFBpVXJ2M0VoQ2hu?=
 =?utf-8?B?SXlhTFg4ZTI1d24rTVpVWmY3OGcxRW42S3M3Zk8rY2ExS2U2RWVCbnFGTDU2?=
 =?utf-8?B?RHkvRWF2OWtXRnZhSXBReG41RmgxcDgyQ08yWDExN1kvNEY5MXJsY0kwTmEz?=
 =?utf-8?B?RW9EODg5ZVhENDJwcmFWS3c1Nkl4ZTZsbkg5Q3h5clVaZXdwMUZ6dkJWQUUy?=
 =?utf-8?B?L1NPQ2UvUkQrS3NDWHB1bURSdWNoaU5vLzVoeFJwMFVxbWt5UkdoSGNyRUs3?=
 =?utf-8?B?eEIwdGlVMXpzUGNwTVhzSG50cFdmQUhxa3ZqclE0VVcyZndTUmRKVUxqaGdy?=
 =?utf-8?B?MnBtaWk3c0pPL2ZwSWRzMUUrcUdnR2FmT2FUTW1JRE9pM1RIM2E2YzdNTXIy?=
 =?utf-8?B?RkRtVlhsV2JNY1JZcE5YR3ArelFFUmVGOEtvRUp0NlFub1JtbDBZZ1c5ZGdw?=
 =?utf-8?B?TDNMWFAwUFpHWUNraTRWM242ZTBMamcxYTRRV0hseGJacis3d1plWG9nRTRq?=
 =?utf-8?B?ZERaRlI4ODVCOGxMYVRkQkUwVGY3STFibmRublZWUHBqR0l2MFR6U2tqMUZn?=
 =?utf-8?B?RURORXlwOVVCaFhkdkc1TUpiTVVreUlKeE1RbVkxa0NMM21pbEdWa0VIMnhJ?=
 =?utf-8?B?bFR0Mlp4ejlxYndkY2FObUtKWHBuOGNxMmhoMnkwNlU2a0o4bnpBR0NLM3h2?=
 =?utf-8?B?d0JvbFR2UStpWWZaN0h4M3d5Z1lRNVVxN1I4U216dXNxZmk0ay9kVHVaMkVs?=
 =?utf-8?B?REVCSGQvUHBoa010RXQwQkZreWlKMGVpdEhqNkdEU3NSb1lSYk9rcHc2Ym5F?=
 =?utf-8?B?ZnBHTXA1bnZxbGIwUUxCVUZLV3Z3Z0dkUXlPV1JDRDZHN3o1a2VxQ2d5bnlJ?=
 =?utf-8?B?aU5zVm85SW5DS2k3Q2NOb2Q0L0NuQUhoRDZkTGYycC9EUTEyZzVtY1h3NEdv?=
 =?utf-8?B?L2JFSndRZEZCNTdrQkkyczJVcTQrcXRIMkxWczQ2U2xCb0pDREl5WEc0Ullm?=
 =?utf-8?Q?WA+valOc3aXmhLdToluoPQh5T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed7a9d2-0efc-49d4-4de9-08ddd3519a6b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:22:39.5012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5kUhDKjXgBHoHEJB/BVGIEm1jMtX7jr4xZhX6FGlaTpPvJf0Z8aCgbpCz5nZtNu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
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



On 8/4/2025 4:35 PM, Asad Kamal wrote:
> Fetch system metrics table to fill gpuboard/baseboard temperature
> metrics data for smu_v13_0_12
> 
> v2: Remove unnecessary checks, used separate metrics time for
> temperature metrics table(Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 248 +++++++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   6 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   3 +
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  26 ++
>  7 files changed, 287 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8b015107f761..dc48a1dd8be4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -766,6 +766,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>  	case IP_VERSION(13, 0, 14):
>  	case IP_VERSION(13, 0, 12):
>  		smu_v13_0_6_set_ppt_funcs(smu);
> +		smu_v13_0_6_set_temp_funcs(smu);
>  		/* Enable pp_od_clk_voltage node */
>  		smu->od_enabled = true;
>  		break;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index b490c39e313e..611b381b9147 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -257,6 +257,7 @@ struct smu_table {
>  	void *cpu_addr;
>  	struct amdgpu_bo *bo;
>  	uint32_t version;
> +	unsigned long  metrics_time;
>  };
>  
>  enum smu_perf_level_designation {
> @@ -322,6 +323,7 @@ enum smu_table_id {
>  	SMU_TABLE_ECCINFO,
>  	SMU_TABLE_COMBO_PPTABLE,
>  	SMU_TABLE_WIFIBAND,
> +	SMU_TABLE_TEMP_METRICS,
>  	SMU_TABLE_COUNT,
>  };
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index d7a9e41820fa..458c4ac2dfbc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -278,7 +278,8 @@
>  	__SMU_DUMMY_MAP(MALLPowerState), \
>  	__SMU_DUMMY_MAP(ResetSDMA), \
>  	__SMU_DUMMY_MAP(ResetVCN), \
> -	__SMU_DUMMY_MAP(GetStaticMetricsTable),
> +	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
> +	__SMU_DUMMY_MAP(GetSystemMetricsTable),
>  
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 02a455a31c25..d0dd84670361 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -138,6 +138,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
>  	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
>  	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
>  	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
> +	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           0),
>  };
>  
>  static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
> @@ -184,7 +185,8 @@ static int smu_v13_0_12_fru_get_product_info(struct smu_context *smu,
>  
>  int smu_v13_0_12_get_max_metrics_size(void)
>  {
> -	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
> +	return max3(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t),
> +		   sizeof(SystemMetricsTable_t));
>  }
>  
>  static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu,
> @@ -359,6 +361,245 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
>  	return 0;
>  }
>  
> +static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, void *metrics_table,
> +						 bool bypass_cache)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
> +	struct smu_table *table = &smu_table->driver_table;
> +	int ret;
> +
> +	if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
> +	    time_after(jiffies,
> +		       smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time +
> +		       msecs_to_jiffies(1))) {
> +		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
> +		if (ret) {
> +			dev_info(smu->adev->dev,
> +				 "Failed to export system metrics table!\n");
> +			return ret;
> +		}
> +
> +		amdgpu_asic_invalidate_hdp(smu->adev, NULL);
> +		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
> +
> +		smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time = jiffies;
> +	}
> +
> +	if (metrics_table)
> +		memcpy(metrics_table, smu_table->metrics_table, sizeof(SystemMetricsTable_t));
> +
> +	return 0;
> +}
> +
> +static enum amdgpu_node_temp smu_v13_0_12_get_node_sensor_type(NODE_TEMP_e type)
> +{
> +	switch (type) {
> +	case NODE_TEMP_RETIMER:
> +		return AMDGPU_RETIMER_X_TEMP;
> +	case NODE_TEMP_IBC_TEMP:
> +		return AMDGPU_OAM_X_IBC_TEMP;
> +	case NODE_TEMP_IBC_2_TEMP:
> +		return AMDGPU_OAM_X_IBC_2_TEMP;
> +	case NODE_TEMP_VDD18_VR_TEMP:
> +		return AMDGPU_OAM_X_VDD18_VR_TEMP;
> +	case NODE_TEMP_04_HBM_B_VR_TEMP:
> +		return AMDGPU_OAM_X_04_HBM_B_VR_TEMP;
> +	case NODE_TEMP_04_HBM_D_VR_TEMP:
> +		return AMDGPU_OAM_X_04_HBM_D_VR_TEMP;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum amdgpu_vr_temp smu_v13_0_12_get_vr_sensor_type(SVI_TEMP_e type)
> +{
> +	switch (type) {
> +	case SVI_VDDCR_VDD0_TEMP:
> +		return AMDGPU_VDDCR_VDD0_TEMP;
> +	case SVI_VDDCR_VDD1_TEMP:
> +		return AMDGPU_VDDCR_VDD1_TEMP;
> +	case SVI_VDDCR_VDD2_TEMP:
> +		return AMDGPU_VDDCR_VDD2_TEMP;
> +	case SVI_VDDCR_VDD3_TEMP:
> +		return AMDGPU_VDDCR_VDD3_TEMP;
> +	case SVI_VDDCR_SOC_A_TEMP:
> +		return AMDGPU_VDDCR_SOC_A_TEMP;
> +	case SVI_VDDCR_SOC_C_TEMP:
> +		return AMDGPU_VDDCR_SOC_C_TEMP;
> +	case SVI_VDDCR_SOCIO_A_TEMP:
> +		return AMDGPU_VDDCR_SOCIO_A_TEMP;
> +	case SVI_VDDCR_SOCIO_C_TEMP:
> +		return AMDGPU_VDDCR_SOCIO_C_TEMP;
> +	case SVI_VDD_085_HBM_TEMP:
> +		return AMDGPU_VDD_085_HBM_TEMP;
> +	case SVI_VDDCR_11_HBM_B_TEMP:
> +		return AMDGPU_VDDCR_11_HBM_B_TEMP;
> +	case SVI_VDDCR_11_HBM_D_TEMP:
> +		return AMDGPU_VDDCR_11_HBM_D_TEMP;
> +	case SVI_VDD_USR_TEMP:
> +		return AMDGPU_VDD_USR_TEMP;
> +	case SVI_VDDIO_11_E32_TEMP:
> +		return AMDGPU_VDDIO_11_E32_TEMP;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum amdgpu_system_temp smu_v13_0_12_get_system_sensor_type(SYSTEM_TEMP_e type)
> +{
> +	switch (type) {
> +	case SYSTEM_TEMP_UBB_FPGA:
> +		return AMDGPU_UBB_FPGA_TEMP;
> +	case SYSTEM_TEMP_UBB_FRONT:
> +		return AMDGPU_UBB_FRONT_TEMP;
> +	case SYSTEM_TEMP_UBB_BACK:
> +		return AMDGPU_UBB_BACK_TEMP;
> +	case SYSTEM_TEMP_UBB_OAM7:
> +		return AMDGPU_UBB_OAM7_TEMP;
> +	case SYSTEM_TEMP_UBB_IBC:
> +		return AMDGPU_UBB_IBC_TEMP;
> +	case SYSTEM_TEMP_UBB_UFPGA:
> +		return AMDGPU_UBB_UFPGA_TEMP;
> +	case SYSTEM_TEMP_UBB_OAM1:
> +		return AMDGPU_UBB_OAM1_TEMP;
> +	case SYSTEM_TEMP_OAM_0_1_HSC:
> +		return AMDGPU_OAM_0_1_HSC_TEMP;
> +	case SYSTEM_TEMP_OAM_2_3_HSC:
> +		return AMDGPU_OAM_2_3_HSC_TEMP;
> +	case SYSTEM_TEMP_OAM_4_5_HSC:
> +		return AMDGPU_OAM_4_5_HSC_TEMP;
> +	case SYSTEM_TEMP_OAM_6_7_HSC:
> +		return AMDGPU_OAM_6_7_HSC_TEMP;
> +	case SYSTEM_TEMP_UBB_FPGA_0V72_VR:
> +		return AMDGPU_UBB_FPGA_0V72_VR_TEMP;
> +	case SYSTEM_TEMP_UBB_FPGA_3V3_VR:
> +		return AMDGPU_UBB_FPGA_3V3_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_0_1_2_3_1V2_VR:
> +		return AMDGPU_RETIMER_0_1_2_3_1V2_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_4_5_6_7_1V2_VR:
> +		return AMDGPU_RETIMER_4_5_6_7_1V2_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_0_1_0V9_VR:
> +		return AMDGPU_RETIMER_0_1_0V9_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_4_5_0V9_VR:
> +		return AMDGPU_RETIMER_4_5_0V9_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_2_3_0V9_VR:
> +		return AMDGPU_RETIMER_2_3_0V9_VR_TEMP;
> +	case SYSTEM_TEMP_RETIMER_6_7_0V9_VR:
> +		return AMDGPU_RETIMER_6_7_0V9_VR_TEMP;
> +	case SYSTEM_TEMP_OAM_0_1_2_3_3V3_VR:
> +		return AMDGPU_OAM_0_1_2_3_3V3_VR_TEMP;
> +	case SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR:
> +		return AMDGPU_OAM_4_5_6_7_3V3_VR_TEMP;
> +	case SYSTEM_TEMP_IBC_HSC:
> +		return AMDGPU_IBC_HSC_TEMP;
> +	case SYSTEM_TEMP_IBC:
> +		return AMDGPU_IBC_TEMP;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static bool smu_v13_0_12_is_temp_metrics_supported(struct smu_context *smu,
> +						   enum smu_temp_metric_type type)
> +{
> +	switch (type) {
> +	case SMU_TEMP_METRIC_BASEBOARD:
> +		if (smu->adev->gmc.xgmi.physical_node_id == 0 &&
> +		    smu->adev->gmc.xgmi.num_physical_nodes > 1 &&
> +		    smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS)))
> +			return true;
> +		break;
> +	case SMU_TEMP_METRIC_GPUBOARD:
> +		return smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS));
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
> +static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
> +					     enum smu_temp_metric_type type, void *table)
> +{
> +	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
> +	struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
> +	SystemMetricsTable_t *metrics;
> +	u32 idx, sensors;
> +	int ret, sensor_type;
> +	ssize_t size = 0;
> +
> +	size = (type == SMU_TEMP_METRIC_GPUBOARD) ?
> +		sizeof(*gpuboard_temp_metrics) : sizeof(*baseboard_temp_metrics);
> +
> +	if (!table)
> +		goto out;

This returns a valid size on failure instead of error code. Better
return from here directly with -EINVAL. Size assignment may be clubbed
with the type checks below.

> +	metrics = kzalloc(sizeof(SystemMetricsTable_t), GFP_KERNEL);
> +	if (!metrics)
> +		return -ENOMEM;
> +	gpuboard_temp_metrics = (struct amdgpu_gpuboard_temp_metrics_v1_0 *)table;
> +	baseboard_temp_metrics = (struct amdgpu_baseboard_temp_metrics_v1_0 *)table;
> +	if (type  == SMU_TEMP_METRIC_GPUBOARD)
> +		smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0);
> +	else if (type  == SMU_TEMP_METRIC_BASEBOARD)
> +		smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
> +
> +	ret = smu_v13_0_12_get_system_metrics_table(smu, metrics, true);

Suggest to pass false so that cached values are used for back to back
baseboard/gpuboard queries.

Thanks,
Lijo

> +	if (ret) {
> +		kfree(metrics);
> +		return ret;
> +	}
> +
> +	if (type == SMU_TEMP_METRIC_GPUBOARD) {
> +		gpuboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
> +		gpuboard_temp_metrics->label_version = metrics->LabelVersion;
> +		gpuboard_temp_metrics->node_id = metrics->NodeIdentifier;
> +
> +		idx = 0;
> +		for (sensors = 0; sensors < NODE_TEMP_MAX_TEMP_ENTRIES; sensors++) {
> +			if (metrics->NodeTemperatures[sensors] != -1) {
> +				sensor_type = smu_v13_0_12_get_node_sensor_type(sensors);
> +				gpuboard_temp_metrics->node_temp[idx] =
> +					((int)metrics->NodeTemperatures[sensors])  & 0xFFFFFF;
> +				gpuboard_temp_metrics->node_temp[idx] |= (sensor_type << 24);
> +				idx++;
> +			}
> +		}
> +
> +		idx = 0;
> +
> +		for (sensors = 0; sensors < SVI_MAX_TEMP_ENTRIES; sensors++) {
> +			if (metrics->VrTemperatures[sensors] != -1) {
> +				sensor_type = smu_v13_0_12_get_vr_sensor_type(sensors);
> +				gpuboard_temp_metrics->vr_temp[idx] =
> +					((int)metrics->VrTemperatures[sensors])  & 0xFFFFFF;
> +				gpuboard_temp_metrics->vr_temp[idx] |= (sensor_type << 24);
> +				idx++;
> +			}
> +		}
> +	} else if (type == SMU_TEMP_METRIC_BASEBOARD) {
> +		baseboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
> +		baseboard_temp_metrics->label_version = metrics->LabelVersion;
> +		baseboard_temp_metrics->node_id = metrics->NodeIdentifier;
> +
> +		idx = 0;
> +		for (sensors = 0; sensors < SYSTEM_TEMP_MAX_ENTRIES; sensors++) {
> +			if (metrics->SystemTemperatures[sensors] != -1) {
> +				sensor_type = smu_v13_0_12_get_system_sensor_type(sensors);
> +				baseboard_temp_metrics->system_temp[idx] =
> +					((int)metrics->SystemTemperatures[sensors])  & 0xFFFFFF;
> +				baseboard_temp_metrics->system_temp[idx] |= (sensor_type << 24);
> +				idx++;
> +			}
> +		}
> +	}
> +
> +	kfree(metrics);
> +
> +out:
> +	return size;
> +}
> +
>  ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)
>  {
>  	const u8 num_jpeg_rings = NUM_JPEG_RINGS_FW;
> @@ -572,3 +813,8 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void
>  
>  	return sizeof(*gpu_metrics);
>  }
> +
> +const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
> +	.temp_metrics_is_supported = smu_v13_0_12_is_temp_metrics_supported,
> +	.get_temp_metrics = smu_v13_0_12_get_temp_metrics,
> +};
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 9cc294f4708b..c777c0e4ea11 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -3857,3 +3857,9 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
>  	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
>  	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
>  }
> +
> +void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
> +{
> +	smu->smu_temp.temp_funcs = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
> +			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index 67b30674fd31..ece04ad724fb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -68,10 +68,12 @@ enum smu_v13_0_6_caps {
>  	SMU_CAP(HST_LIMIT_METRICS),
>  	SMU_CAP(BOARD_VOLTAGE),
>  	SMU_CAP(PLDM_VERSION),
> +	SMU_CAP(TEMP_METRICS),
>  	SMU_CAP(ALL),
>  };
>  
>  extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
> +extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);
>  bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
>  int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
>  int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
> @@ -88,4 +90,5 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu,
>  				     void *smu_metrics);
>  extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
>  extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
> +extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index a608cdbdada4..d588f74b98de 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -65,6 +65,32 @@
>  		header->structure_size = sizeof(*tmp);                     \
>  	} while (0)
>  
> +#define smu_cmn_init_baseboard_temp_metrics(ptr, fr, cr)                        \
> +	do {                                                                    \
> +		typecheck(struct amdgpu_baseboard_temp_metrics_v##fr##_##cr *,  \
> +			  (ptr));                                               \
> +		struct amdgpu_baseboard_temp_metrics_v##fr##_##cr *tmp = (ptr); \
> +		struct metrics_table_header *header =                           \
> +			(struct metrics_table_header *)tmp;                     \
> +		memset(header, 0xFF, sizeof(*tmp));                             \
> +		header->format_revision = fr;                                   \
> +		header->content_revision = cr;                                  \
> +		header->structure_size = sizeof(*tmp);                          \
> +	} while (0)
> +
> +#define smu_cmn_init_gpuboard_temp_metrics(ptr, fr, cr)                         \
> +	do {                                                                    \
> +		typecheck(struct amdgpu_gpuboard_temp_metrics_v##fr##_##cr *,   \
> +			  (ptr));                                               \
> +		struct amdgpu_gpuboard_temp_metrics_v##fr##_##cr *tmp = (ptr);  \
> +		struct metrics_table_header *header =                           \
> +			(struct metrics_table_header *)tmp;                     \
> +		memset(header, 0xFF, sizeof(*tmp));                             \
> +		header->format_revision = fr;                                   \
> +		header->content_revision = cr;                                  \
> +		header->structure_size = sizeof(*tmp);                          \
> +	} while (0)
> +
>  extern const int link_speed[];
>  
>  /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */

