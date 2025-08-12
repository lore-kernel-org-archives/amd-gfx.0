Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381F5C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 09:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D598810E09F;
	Tue, 12 Aug 2025 09:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3QTDN/MM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BABE610E09F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 09:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsQFpnn+lN0wkHCg0yZEI9pun4RSqXzge5mTZIi2KXL7u96TAWu3fZehnZix0NruyA6C4BdcCJRzxKFii4RCv/SoYEZmROOgo2KvXj0rSu/1QJVFYtUkixVe7R2g2hfIFi7hX/tpMe+P/lqztjXW1NUY90mHaVPKzaCaQ836H53WYTzfbcKW9fGy6aIXPwBwPtuQHz2+pYqqfZrPQIeFuf+IPOnOgXrQHRS+WZyFa2Ec23PXHYyaCh2JpDtgKmsY6zSrf1mAGTe/KYvmmqSnC2fWIbnat11IjfFUdwAN3/XkDYF7ykxDiZr2ODiFxevLvKL4VViM2UUnCPDa7P9omA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viBiNn6umddMI9y5NYP6rGxcCf8U/fe0FSR5QF/Px4M=;
 b=SUQqM4ly21lR8LuEco8jglNVSCNgjV+NFcziYXtaWH/dnpJnes1fVKPoN77qowORIFkUG/TA4Jclo7An2xmd2HBi/1nuVAPBAmV8DC0OQvBjGk3MePagn0CXqrT08ROrRFopgQhI6I/tCR0zUQVYYdY6Z1Zttxfo0WETlkr8alRxzwC4HwX8FnQMI1soLPZZ94gR7OK7ztQH94XE1K7n0uCCOD/HOHdONasg2Ju+Y0APB5u/kAfS3YQAv6AwPnbLTk+H5X8Idu1ysy+sfT3VY1Tw31jVQnVW0Ls92GiQvmsojBxrzZ9E9cjHxJkG3o6nI3LbPcLvysstk4hqWVNhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viBiNn6umddMI9y5NYP6rGxcCf8U/fe0FSR5QF/Px4M=;
 b=3QTDN/MMlL3YHMwihQlZl86r+AtFOjz26eP3M64nKU5KMFyv3zc2YFW016GO1pvSwolZNpNiNfRhzCX8oJCpEm3gXevBu+HwN989bAgmzkuxjYiL1WUXEEfTmzXakSoQuObSq2Zy453KOJn20h4ZrTtzcyi74Q+81oShZ7YvvD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 12 Aug
 2025 09:36:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 09:36:44 +0000
Message-ID: <cc7d180c-fab0-41f0-926c-ba757b3e01f2@amd.com>
Date: Tue, 12 Aug 2025 11:36:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/3] drm/amdgpu: Add ioctl to get all gem handles for
 a process
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, David.YatSin@amd.com, Chris.Freehill@amd.com,
 dcostantino@meta.com, sruffell@meta.com, mripard@kernel.org,
 tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250811150536.3394262-1-David.Francis@amd.com>
 <20250811150536.3394262-2-David.Francis@amd.com>
 <5e3de4f0-b529-4b18-a99d-5c2d592cbb73@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5e3de4f0-b529-4b18-a99d-5c2d592cbb73@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:208:e8::40) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fb4cdd-3d3b-46e2-c220-08ddd983bfd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0FVTXhHZGtqNVJNQlZ4cjVSL29ieFVZRHVYSE04Q3FoTmE5MzJvUEJPejRZ?=
 =?utf-8?B?b1NsWlNsVnhISmlyRTY3ejVPT2c2Qnc2a3ZPSXJIOFZqb1ZWT2UxVG1FdmR2?=
 =?utf-8?B?dktOdXJyc0JMQU5ZL21DWURwOHhZS0g4UHZ5ZnF1SDhMenVZS2FEQTRWMEFD?=
 =?utf-8?B?b2d2YWovMDR5SnhudC80ZXY4SWZUNDlYcUNMbTQ3ZXBOSEVDRmdYc1JJbFp6?=
 =?utf-8?B?K3hKUFVmZStBYVFLbzBxYzVJcDc1ckFQcGkwdHRlbjNrVWpwYmYrUmNhSWR5?=
 =?utf-8?B?SXR2TnFBbEFGYzd1cDBmVnRUb2U3VHRuQ3p5MjhrckUvTlQweVlzc1QwOEFl?=
 =?utf-8?B?b3lUYUxpUUVkc09YdnhZOThhOUs5SHBxRUI2N2hjY3dkcHVlaXVvajJoblBL?=
 =?utf-8?B?bWhaaU9CdGxIb2xwNEdCdGFzVnVkbmdaVkIwQTB4S2JGck9kQ2lqc1VMYVVz?=
 =?utf-8?B?MUFUZlR4MWlDVGpJNE8yTVlzRWFHcmJhb0NZb0ttZUZiT3NLSUFzMm5ZL0Nl?=
 =?utf-8?B?VUFCaENNQkdpbTdOOTRTclloY2dvbUJUYkZpOFZ0blY5K1RuRmRBZGoyckp4?=
 =?utf-8?B?MzY4Q1VRNzdvQXBYMi9CMHFFcjZianVaT1NsaCtYdmlRZjN3bzllckxYS2M0?=
 =?utf-8?B?Y1RxcmNacUVUSUVXd0hlZzltaG9kMWI0eVdPZjhsUi9VdDk5VzYrdlg5b3A2?=
 =?utf-8?B?V3owN2hxOGQzSUl1dS9hQ3VaYy9rV0RBTGdGOTBHdEtxVG9hazZNMlZudE4z?=
 =?utf-8?B?SWN3L25VZFl1SDFlVkttd25ONGR3bjQ4bHMwanU5OGNMNzZaUnRBNE90UGdk?=
 =?utf-8?B?aitpWHRZaEQ4YndOSjFoQWlvaXpTQk04ZlNicDFnRVBSUC9KZmp4YnJoSXpx?=
 =?utf-8?B?cmZHcjdlM1lFWXFtV3RMVG5vRG4xSkJ4bVhoOWdaR3NFd3Q0VVFUWVNHYmJV?=
 =?utf-8?B?aHVpUTFzNEVuSmFZOEtOeXFVcHh6WGRUMk5wUHk3UXIrRlN2dVBndlA1YlUr?=
 =?utf-8?B?TjVSUjRSTGx1TVJFcjl3MWtvREF2SHZ2Mlp2NkJlNnY3R2J1d3I5Q0NIa0M2?=
 =?utf-8?B?U292QTVpRXVOVDhWK1NQK1pWN3ZBZWJsOU9ScFRKRXNNYzJEZlcwcTFlaDRP?=
 =?utf-8?B?QytKbWcwZUNRcUhvM3R1TkQrZ1NGb3llUkNGVm1aczdkdjlKYXowN0xwQ01K?=
 =?utf-8?B?NzltQjFyQmJ0RElsTFZWWkFXbjNjVjB3TGloTGtZaXBCalRaT2FoeE1Leldl?=
 =?utf-8?B?Qk9ReTNUcDdJQ0t2bi9pNDlDM041Z0dycDdyQncweVVGQ25paE5scmwwRitO?=
 =?utf-8?B?RW5XeHJlbUZ2MGhJbCthMVliUXcvMHlwTFdDTm1saUx6K1RpREFzOHBVZkcz?=
 =?utf-8?B?QjFjRW1xTFlqZnVteFZBYXk2TFZXa2ZoOFI1dWtrK0JzeEYxNWJWUGJIREtz?=
 =?utf-8?B?WVZBZHlGOFEyT2FZTmdRNDRadzFtaUdFblpySnlyd2dKSjM5cnkvckpESUVp?=
 =?utf-8?B?LzZlaTB6cTBFeWxsOHo3L3UvUzFkYjNXTjc1a2g0M3JWWHZGV0k4NDh0c1RN?=
 =?utf-8?B?eEZFVkhSMWdnbC9LS3lLcXdPNElXVkJSeTA2MWZNZzZWMXVQZ2JMODQ3Skdv?=
 =?utf-8?B?a2d0anFYd1NqZnpRUDAwQkVTQTNySVkxT21hVi9FWjZWcXBQK0JIa2xVV2Fz?=
 =?utf-8?B?ZUNCa1lMVFlYUWJqRWp0ZjVFWFZENzhaUG5pdnU5aUk3bU16VTl6Nk5zLy83?=
 =?utf-8?B?MnVxdmJpTldnVHk1anlTNW1abHdSNGJRRW5Ba3A3ZmkvWDBtVHFVQlZlZDhh?=
 =?utf-8?B?WjBON0gwODNYNWJBdVBCWUFJSzdQK1NRbEdrdVErZ1VhTzZ2ZzQxT1NROUVW?=
 =?utf-8?B?bWNscEMrc1pkcTFOVVRkMmQ3SU4rN1NudkhQc2txQnEyOTU1aFFiRzFrcGho?=
 =?utf-8?Q?mcAXanfVCq0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJuSlVld21ESiszUTB0RXFqMDc2OVptSkh6UHJNdXJESXNDMjdmTzhCZXg2?=
 =?utf-8?B?cURDaFdhMld5clhNTXgva1ZiYUVGMUZkK0NjZzNaMmVHZU5jVlBxUUgzd2hZ?=
 =?utf-8?B?eDlyNWVJVjZORy9JM1Zpdlh1UG04M2Z0UFZZR0d3aGRHKzVldFB0NXprRE5C?=
 =?utf-8?B?Y1M2Rm4rUnI3eFNoRzhWSVB1NmtnT1pLMU1nTzFSY3B2aS9DUzRZOXBRWHNE?=
 =?utf-8?B?cERvK1lZdlJYUDBsa1I0NEJmWVlhUWxKK3g1RVJMYlJYbFFwY29ubHc2Zkk4?=
 =?utf-8?B?NUNCSHFEcm8rblBDK095STAxelNWb3lHdFl2akYrQkpVbzFRQUpBS2J1SnpW?=
 =?utf-8?B?bTQ5ZStKSnY3OEEyci8zaGoyRlV1L3IrR2gvMlRFdExoOGxOY2QwTSsrSThK?=
 =?utf-8?B?cUlCdVdRVFEyNXVlZGtJckpYdDFUYkNJcDBCVmZyM0lLTjNDaVdKTm95eG9n?=
 =?utf-8?B?V0xUb2JLd1QyUnl2TStTeDIzejlBSTROYWlmbGVmT0Jla3ZqZ2JqdHFHVFZL?=
 =?utf-8?B?TlhOc29NK1F3dERlTHg0TW9wK05JS21JTXBEaDhyWGR1cGF3dEkwQ1RWNWpT?=
 =?utf-8?B?c0pRWVFBVCtmSk9wb1E2Q1p6c3lCclN6ZlR1Z1NCQ2lRVkpRMVJtN09vbjVs?=
 =?utf-8?B?S2Q1aUVLa2lzR2RGQk1zSUN6NitUTUQwQVZ0bDluWkFraGs1dFB2eVoxZUV4?=
 =?utf-8?B?c3FyRDhaWitwMTlLK3Z3WWtpaTFoYlFRVndMd0JyU2lDeTRMTjd4QlE0alNY?=
 =?utf-8?B?SlR4d09lYWI1d3FJQVM3eUFKeVZFTTl5UHAzb2ZNODhxcElIRGxOWkdkU00x?=
 =?utf-8?B?Mk50cm14YXhaaHlmbjZhdkdHSU40NGpJWW5obkZ5bDZPaGMzeEl5Mll6ZXdq?=
 =?utf-8?B?ZDV5azNUVnd3TTNWQU1LUjQxZ1lQeEh4OWlGSE1JYTZWM0tXdCtFVnZKaUZG?=
 =?utf-8?B?cmlHdi9xN0dpZXArSjQzT0t3MXVFdnUwQVZLbWdoOE5McFdlQm5lNUo5ZWlW?=
 =?utf-8?B?aVNkQ0hlWHhkbjJ5ZHVyZVpEa2podkwwT1NwdjlrNHh0eTJxc2hyS0VjeSsy?=
 =?utf-8?B?M0ZHYjFoMit5NG5QL05BUWNySzJaNHluK2t5Y1VUdXFsTThLZmR0YTBGYkNU?=
 =?utf-8?B?NENFc0h3Uzh2RUJwRm9TSXhoTUhZL3d6b0hsTFd3aGZtTndtN3o1dGFDdWpj?=
 =?utf-8?B?ZEFHSXVJZkFWWHY5NTQ2SmNBeDlwSWZrUlJqZXdWUk9RdDczOVRXR2hZWlBt?=
 =?utf-8?B?ZHZJZWxJbFg1NTh6c0Vja0RVWksxd25QMFlrRHFwb3FpK2tDK1hlelhneml3?=
 =?utf-8?B?ZjRFTVlseXlCSnVWQzRkUmRKcWlLRmo5ejMyYjZGaUx4TTBQMFFKdWp1Ykg0?=
 =?utf-8?B?TjNFRnd6S01uNHBzc0hOd2RBQzJQQjgwRHYxMVJhaGVhNVRSY0RPc2pyZmN3?=
 =?utf-8?B?ZGlYNWRjOUMwZUxmZCtVSmZCaFlBQmhQZEtQMnhqWnR6cko1NUlodGpuZ2V0?=
 =?utf-8?B?bjc5MWVMV3hLdTlGMjdjRjBMbmhjdDkxNmUrUTRXNS8rdVcyOElDTFAxRzRr?=
 =?utf-8?B?bC8rd3owMW9wWVlyME5GZUNZTGdReU1mZExweVpRcVJGbjZYRUdzNFRTaVFm?=
 =?utf-8?B?aFlkRVUrQmdleG9hYmxrNU5BaHBTUytpOUxwZEF0Ky9ueGdvVGlpbmlXdE9T?=
 =?utf-8?B?OHRoN2pSZWxDSVl3Sm1seXhSbWJVWjZIRFdmWGl4UVdobG4zaG5JSWo2a09W?=
 =?utf-8?B?UVhvSjNxSjNKcUt0YXZiY29sTE5iQ0Njc25XUzNoTjd5Ujh0NHZGeStNT2xY?=
 =?utf-8?B?TTJvbVVlTzZoVWRNRE9CVlJrc0pOTVJJKzUvVkMxTWlnTFZmb0VsUzlsOXN2?=
 =?utf-8?B?cTBsdGVxcm82ZzdPVjUvdEtycnFvVkV0QTRFYWNubTE3TS8zaDhEMHUvVjdx?=
 =?utf-8?B?UVV6dmhpVDI5MXNiTUVxbmRRWkZjTFNEOG9qN3hFdDJQUmNFM1JSWHc4SjZI?=
 =?utf-8?B?dmExMEZaamFMQ0hCWi9VamRFU3ZIVVBXTTNwbGs0YVlCUWhySFhrdlBiaUdX?=
 =?utf-8?B?TDJoVXQvWWJaT0F6MGQ4WEo5NU1LZ3pkekhxaFFZcTd5eGJPVjIxTERqTHBO?=
 =?utf-8?Q?TtzzgSqPAsyZX7u/ungm+SeRs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fb4cdd-3d3b-46e2-c220-08ddd983bfd0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:36:44.0789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTVSkipe2ass6L+V9FDA1Af47KKALMrqcxAe4RsX1Uw51p96q01NiV22kk2Qya9Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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

On 12.08.25 11:28, Tvrtko Ursulin wrote:
> 
> On 11/08/2025 16:05, David Francis wrote:
>> Add new ioctl DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES.
>>
>> This ioctl returns a list of bos with their handles, sizes,
>> and flags and domains.
>>
>> This ioctl is meant to be used during CRIU checkpoint and
>> provide information needed to reconstruct the bos
>> in CRIU restore.
>>
>> Signed-off-by: David Francis <David.Francis@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 83 +++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
>>   include/uapi/drm/amdgpu_drm.h           | 31 +++++++++
>>   4 files changed, 117 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 4ff3a2eaaf55..f19795dddf9d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +    DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>     static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index e3f65977eeee..3873d2c19b4b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -1032,6 +1032,89 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>>       return r;
>>   }
>>   +/**
>> + * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
>> + *
>> + * @dev: drm device pointer
>> + * @data: drm_amdgpu_gem_list_handles
>> + * @filp: drm file pointer
>> + *
>> + * num_bos is set as an input to the size of the bo_buckets array.
>> + * num_bos is sent back as output as the number of bos in the process.
>> + * If that number is larger than the size of the array, the ioctl must
>> + * be retried.
>> + *
>> + * Returns:
>> + * 0 for success, -errno for errors.
>> + */
>> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>> +                  struct drm_file *filp)
>> +{
>> +    struct drm_amdgpu_gem_list_handles *args = data;
>> +    struct drm_amdgpu_gem_list_handles_entry *bo_entries;
>> +    struct drm_gem_object *gobj;
>> +    int id, ret = 0;
>> +    int bo_index = 0;
>> +    int num_bos = 0;
>> +
>> +    spin_lock(&filp->table_lock);
>> +    idr_for_each_entry(&filp->object_idr, gobj, id)
>> +        num_bos += 1;
>> +    spin_unlock(&filp->table_lock);
>> +
>> +    if (args->num_entries < num_bos) {
>> +        args->num_entries = num_bos;
>> +        return 0;
>> +    }
>> +
>> +    if (num_bos == 0) {
>> +        args->num_entries = 0;
>> +        return 0;
>> +    }
>> +
>> +    bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
>> +    if (!bo_entries)
>> +        return -ENOMEM;
>> +
>> +    spin_lock(&filp->table_lock);
>> +    idr_for_each_entry(&filp->object_idr, gobj, id) {
>> +        struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
>> +        struct drm_amdgpu_gem_list_handles_entry *bo_entry;
>> +
>> +        if (bo_index >= num_bos) {
>> +            ret = -EAGAIN;
>> +            break;
>> +        }
>> +
>> +        bo_entry = &bo_entries[bo_index];
>> +
>> +        bo_entry->size = amdgpu_bo_size(bo);
>> +        bo_entry->alloc_flags = bo->flags & (~AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
>> +        /* WIPE_ON_RELEASE is set automatically in the driver; it is not permitted in
>> +         * BO creation. In the interest of giving the user exactly the flags they need
>> +         * to recreate the BO, clear it.
>> +         */
> 
> Ha, curious. What is the reason flags userspace cannot use are specified in the uapi header?

The comment isn't correct. AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE is perfectly allowed in the create IOCTL.

Regards,
Christian.

> 
>> +        bo_entry->preferred_domains = bo->preferred_domains;
>> +        bo_entry->gem_handle = id;
>> +
>> +        if (bo->tbo.base.import_attach)
>> +            bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
> 
> I had a question regarding this part in v11. Any comment on that?
> 
> Anyway, thanks for implementing the other changes I suggested, this one LGTM now.
> 
> Regards,
> 
> Tvrtko
> 
>> +
>> +        bo_index += 1;
>> +    }
>> +    spin_unlock(&filp->table_lock);
>> +
>> +    args->num_entries = bo_index;
>> +
>> +    if (!ret)
>> +        ret = copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries));
>> +
>> +    kvfree(bo_entries);
>> +
>> +    return ret;
>> +}
>> +
>> +
>>   static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>>                     int width,
>>                     int cpp,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>> index b51e8f95ee86..7cdb6237bb92 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>> @@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>                 struct drm_file *filp);
>>   int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>>               struct drm_file *filp);
>> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>> +                  struct drm_file *filp);
>>     int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>>                   struct drm_file *filp);
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index bdedbaccf776..59b423883e91 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -57,6 +57,7 @@ extern "C" {
>>   #define DRM_AMDGPU_USERQ        0x16
>>   #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>   #define DRM_AMDGPU_USERQ_WAIT        0x18
>> +#define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -77,6 +78,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_USERQ        DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>> +#define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>     /**
>>    * DOC: memory domains
>> @@ -811,6 +813,35 @@ struct drm_amdgpu_gem_op {
>>       __u64    value;
>>   };
>>   +#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT    (1 << 0)
>> +
>> +struct drm_amdgpu_gem_list_handles {
>> +    /* User pointer to array of drm_amdgpu_gem_bo_info_entry */
>> +    __u64   entries;
>> +
>> +    /* IN: Size of entries buffer. OUT: Number of handles in process (if larger than size of buffer, must retry) */
>> +    __u32   num_entries;
>> +
>> +    __u32 padding;
>> +};
>> +
>> +struct drm_amdgpu_gem_list_handles_entry {
>> +    /* gem handle of buffer object */
>> +    __u32 gem_handle;
>> +
>> +    /* Currently just one flag: IS_IMPORT */
>> +    __u32 flags;
>> +
>> +    /* Size of bo */
>> +    __u64 size;
>> +
>> +    /* Preferred domains for GEM_CREATE */
>> +    __u64 preferred_domains;
>> +
>> +    /* GEM_CREATE flags for re-creation of buffer */
>> +    __u64 alloc_flags;
>> +};
>> +
>>   #define AMDGPU_VA_OP_MAP            1
>>   #define AMDGPU_VA_OP_UNMAP            2
>>   #define AMDGPU_VA_OP_CLEAR            3
> 

