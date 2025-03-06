Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF71C19F32
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 00:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DF210E87D;
	Thu,  6 Mar 2025 00:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u1LhOrmV";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B1010E87D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 00:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aECeM+ojDsbKvcOUWVd0F4Lb3evb0H7iJ5vvHDva0ZwJbC0sZKiJrQLREDJUQD1CTdHrRT05ax+oNbsreJ14kmTGMnDN5oJcy3IyJKBjxEf6oHCI5SUrRlThnsiDpMQmnvNFiyxNGSXHKfsM5+BLS3aoe6hSdsf8eFBfGOB9wwy2LlhgMauxDQJb1ArituxFlybYTcZF6HBKK+P/q/ISZ2Z3poUHduTqE9+oe1jNGMd4SMfOCeuD8xjZLwpo4JABUNsUCv7wGAxAinxljyqqK65/ySZNjYQvr0aBbFMYLwIOI97XNp/Z9GdIHPcAjcn1jsns7feMs+uuCHIa/zhUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWDgq/0B8arKqbY+ODBz0A5/5OMLFWpcat23zVmHUE8=;
 b=ZP+up0zuRTiyIFhmEdjHEgt6iNRIHDbZ2lgXkKg1KpKtluM6lgDrce6C43tdJ0PKJ7m95amJCt/uTWQSR5J7dlFq2eO9CTAp8bDu6MRFArHa5LSE7JIzEan9tRm2TBUddADqXz9OCtI2MWbbua5GIKTJPqXdyMHvrFEOvUrk3s42bwIOI/Tg/tpjCKWNnV5l+XxkP0EeKUQBoXn2ac+gHKGd5je70o47EVGyey/grNl/tr9I6yXtqQF8gqZbFE5+mHF6VFX31P2KRRTYzaGdjkr4yfgvIQHyh6Agfx1P6YJbp40CNo2ftvf4NA+D4lu8BQg2LCgH49AVe2hBcj4aig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWDgq/0B8arKqbY+ODBz0A5/5OMLFWpcat23zVmHUE8=;
 b=u1LhOrmVhwgXkOcGD7DiodMHglxdLPm6UXbRQunOrBGnnexuVX9G/E6NNkXlfpMTlfghKJMd42O4Dx5DxCz3tv6mSO6olXA2thUAEyXYfZcZSjrkVqay6aoVpFcu2Y4RmHEDVHJHHyVpyjo27X63WF0WlV1wzLN+ozr0Bd74Nqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 00:50:38 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 00:50:38 +0000
Message-ID: <73fec175-42bd-4c78-a7af-b3ab1f46d51b@amd.com>
Date: Wed, 5 Mar 2025 19:50:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix missing drain retry fault the last
 entry
To: amd-gfx@lists.freedesktop.org, Emily Deng <Emily.Deng@amd.com>,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
References: <20250305035409.3204812-1-Emily.Deng@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250305035409.3204812-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::10) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: a767e4a4-779b-498e-d976-08dd5c48e979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDYvTmJGYmJWR1BhcmpEeU5MK0p1UDhSb0tqdWgwZkQ5NjEvRm9aL3RreWN2?=
 =?utf-8?B?dmdMMTRiK0d3VTNPYXZOYy9Ecit3dHlUQ0l6RHVpZDIwVHlsVmlMS0lOWUgx?=
 =?utf-8?B?STRaNEJXMXVDeXoxL3pLRVdXTmUrQ280dnhSTFFjRzREMkU5amNHejBUVllG?=
 =?utf-8?B?Y2F4bkdzUFVIMHFpY1FNbXNpV1FTcjMyZUh5b3d5b1FLVVZmaUUvbXJNZ2hO?=
 =?utf-8?B?aWJXY1BkMGZMclFDc0pXQUVFaEhldUgzc0JkQ2NOUUZXcGtNSkhxQWtDSzhL?=
 =?utf-8?B?MTdmNi80VGIwdW1peGN1Q2VOTVh5THowL1Z0eEtYS2d0clI0VTQ4YThHUEtJ?=
 =?utf-8?B?UXNHSFg5emt5cEZ4N2cyZ3dSWVFJbk00MGNidnhUcyt2THliY01NOUppQVRC?=
 =?utf-8?B?UDJwL1ZYeU5BYmx1OURONFZmWEpEUmptUnBmb2NZdGFiSHNGc3hSOEkvZ01B?=
 =?utf-8?B?U3BpUGJWVktOY3NYWmdadEJKOU5yT1JYRS9sMGtMUnB1eHlXTnFiMDA3UnZS?=
 =?utf-8?B?WnVpc3hRMGdnbEsrWm0rMnlkNjNOYWtmRTRIL2dHVGs5NHdCdGd4VFZqc0Qz?=
 =?utf-8?B?OEdjYVJSVXlvM3paYnFwdUh5VmMwQ21iRDFFc0VwNmtUVXZaNEpFMkY2dFMr?=
 =?utf-8?B?ZUwxWHdSMkkyT1FwZWNWRmFwNjdXUGhUajBrM2x2ZXNIZk5mK1crQkxoM0dP?=
 =?utf-8?B?VEY3TnhqYmp4Y2ZYeXhYTEN6c3RrMlBBYWlhTmhRMEQzRUtzT3l2bWpOb0F4?=
 =?utf-8?B?aHNjclowcHRQdVBHY3lzT3dxSGtmTFVMT1QyNnJqdlpoOTlSTEdEODVhell5?=
 =?utf-8?B?bnUrS3pRMVExTGVTc0VsWkJiSGRhQzdQYW5ZRk5PMTFrelZPSzExdDMxdElL?=
 =?utf-8?B?Y1c4OXhvKzcxWVdZK2VINFVEeDdvalovdEVmZkVwTlFlZ3VJYTVEZ3QzQ0ZD?=
 =?utf-8?B?R0JKU1ZWeDBvTzhXYVh5RUVYUWZEOUxqU2pyUVJFazJOQlhPQW5ERkwrNVQw?=
 =?utf-8?B?NHpXUHc4bi9iTXc2Zm01bVc3ekpNNGlWZExXU2RORUptMDJrZUdLU0w0dVNW?=
 =?utf-8?B?VEx6b2wwMTE0TDNQZ2ZZZDcvT2hmdmh6ZjJUbksrVy92NnZGWmViSTlZaUlL?=
 =?utf-8?B?T1JQaVkyWklqSlorOFlKc3ZiemY2R2ZZYU9pcVNnQWZqREkvNmRRb0ZHQjFU?=
 =?utf-8?B?UzkrUlAzVTQ4UTlTZjNQZmxqd1c1bEpMZEQwZzg4NWhzL3ZxSC8vT0ZZcjFF?=
 =?utf-8?B?Zy8xaVdCOFpYU2xRclpGOWhzaTM1d2RtTUhncGZVdGRHcWwzL2tQL3NZblJI?=
 =?utf-8?B?QWFTYU05M2QvbHpJQ3hlVGNmMTdvYUVVWlB2VnNFRjRGVDY4dnNoRUF5ZmRC?=
 =?utf-8?B?Z3hxelhvSGR3cCtaNVduTjhiOStRTG93MWtKWlNaVVUyeTY5MUJHOWpUNFFW?=
 =?utf-8?B?RW9MTUo4RENjbkhxakwwOTdTMlpqQVYvMjBhbXpDZFhUZysxWllWVXV2aU0w?=
 =?utf-8?B?UnBrWTVOSGhkay94VFc5c2Y2aTE4QWFZZUtCKzFPOHBHdzRyREdTck5hckxY?=
 =?utf-8?B?S0N2UTJORGRNSzRDenNNQXdNT3JxYzA5N3JnR0RKUkJhcTR4SE4vME1NdGls?=
 =?utf-8?B?Sjh2ZHMybHE0Tms0dGVPY1JKWjZwUUZDWkkrclQ2ay9Tb0k5Y2tjRW4zazhu?=
 =?utf-8?B?VmE1dTZYLzFreHlEUVY5WkRieThDS0FxeGN3VU5yWTFNK21HcElnQlVZTnR1?=
 =?utf-8?B?K1d1aDRwLzBweG9JYTNhc0hIOUNHQ3lPSWxJRERIZmx6L1lzZjZjZEJ6c2N2?=
 =?utf-8?B?MEtDNW5zQ2FHNmt4cG90WVZHUFNQb1JxUS9kWlJ5VEtKMDZGWUdHQy8zanZG?=
 =?utf-8?Q?bToSFKowNXZ5H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWRmcHlIazhPS2hiL0RJYkMzcG43UnJQK2N5NFlaZS9aR1EzL1hIMlJNYVBj?=
 =?utf-8?B?THVsOUpXQWRsYzVxV2hqNk9EY1duVDI1WkQzbnI1cjUvdTlCb0dKQkY4bzlL?=
 =?utf-8?B?SENCcGZoZ2JvRVlEemVpa0U1akVmQTZlazkrc1B2OFRtakNBSitaKzVLVmFv?=
 =?utf-8?B?WTFzOUpOTGkzNUdyMnI3N29iUVhKSkxyRi9nYTltTW10TzJYTjlxdWZhK0hO?=
 =?utf-8?B?VnFiQnA3OGtDWlhrQlpJdDc1dFd2M2ZoVndCZUJ6RkZxTFd4VGdBbXpkU0or?=
 =?utf-8?B?VHJieEFzVE1tSk1RcktVTjlpOFZ4d0wwdXFSL1V4bDJMSG0ydXdNZmc2RnZ0?=
 =?utf-8?B?NkN5RWpkMllxSGo2QnVUbSt2Z01mMjJxQUFyZVRHRnFvVE1pUVpPd2ZTbDIy?=
 =?utf-8?B?UGxhL0ZVYkhYaC8rZDhxVjVTeUc2YkYrWUUxbVJNWUhHa0d0MW1ncjNVdHJL?=
 =?utf-8?B?ZW8yZGhlSFcyRTlLUTFyR05MaGF6Mmw3WGpyTXhkaDNsd2ErcjlpN1lkZlU2?=
 =?utf-8?B?Sno4UkNXNlU5a21DVkFFcHVpZUZkbmpoTlNZMVM1SHZQYnJBakllaUlDYWtY?=
 =?utf-8?B?MmRqRVRldEdQV2NuKzM4emE0V3A2VDBpRllGbUxEcDd1Q1p0NVdrZnhiOS96?=
 =?utf-8?B?RzUvMWlBaDBaNm4yZC9YQnF1dXVFNnJzQ1J1ZStZZTIzSG1odEMvczFaZmhx?=
 =?utf-8?B?L0tLSE9yN0FCV0NsNE1LM0U3OHkxcnhWbkJHMFh3b0lHcDhVaDIrcnhnZ3pT?=
 =?utf-8?B?UXFaQmZFckVRd1plNEMzQVo1MUNXQi9VcEk4cEx6aXhrLy9IWU5taGJkWStH?=
 =?utf-8?B?cUU4b2N2Z25RaDFvV1RjNnVSdU0wWkRYVks2ZzhEeFRabWl2Y3l0dDhWS0RG?=
 =?utf-8?B?eTRqMmU3dm9HSElNNi85ZExscGF2d2F1N0x4dlU5OUgvaXhYejAybUJQNjhS?=
 =?utf-8?B?RXVuNUc4ak83WVZGNUNLcUVrMjRwTVduWGd4Nm11WmR6eXVONElLczRoT0w0?=
 =?utf-8?B?ajA0V0JIaVZQcFAxVmZGdE9yT0V0RWNXSTBZcU1PWFFTbWNTbUdPRnNoci9G?=
 =?utf-8?B?MzV0WGNOUThuTzVZTys1cGRSWEVZS3ZZdHBKbkJnbGszRjI1bFNFYnU1Mmt3?=
 =?utf-8?B?VzdOUWZEVEkvRFhpZUQ3NkZ0NXNPckdPbjBFVzM4WityNWRFWFpRdGk1KzVU?=
 =?utf-8?B?MW1OSFRQOGxEMzZ3WnJUdVRZRVU0VGJROS9zYURqcFJrM3g1Vm1xMm5KU2M5?=
 =?utf-8?B?VjVveFgzV3lhM1EvRDRXOEdNVFpXSHQwT3JQQmNQTzk3TmdFUWx6WHVNVy9z?=
 =?utf-8?B?Ukd0SmZsSnlOdzNTblFoTFMzdkx1elZyb3YzaUZ2azZkU1lUZDkzYWEvZUNt?=
 =?utf-8?B?aFl5bG5HSXlrV1EvMm5FVnFDbkRPWkFMWnhtZG9IVFJQSHhvZ3VmWEJ0dkM2?=
 =?utf-8?B?cEhITkxzczZWZ2Q3OXlVOVFsNEZld045ZGkweXdQMDJEUWoySHlMTzgzZlFa?=
 =?utf-8?B?TFZudzMxVnNTQUVwNURnODNOUlRNVFdEdXR5K253T211akVzRkpOU055V2xZ?=
 =?utf-8?B?UlVHaEd1cEQ4clZkY2g1TExTcUVnZUl3eGtCeXFUb1JzV2JZbnlrZUJ3MDNn?=
 =?utf-8?B?SjVhR2Jvbkt5WURpNHArakZLUW1mY2F4c0NYZ28waDhqcURkczAxbzJCN2FU?=
 =?utf-8?B?Y1RReUxRRDVENk5CSTNZYWUzZUI1b09QeGlHS0IvMmp4eUYreWwxZGVXZWZz?=
 =?utf-8?B?MVJXYUJxaHlJTUExV1RMUnJpM3lYdGxoTnNmUlhzUGhGVjN1Z3hiU3JSVzBy?=
 =?utf-8?B?bWVmUmI2T1U1b0hXaEQ3NlNUTkVoSUt5L05aTVlUb1Q1ZGVTbDkzZ0NNTmQr?=
 =?utf-8?B?cUtGQjZPMXdrREtTbWNUdVNpekFBeUZyRVd6V25FRjB0dmNpcVF6Z0RFQ3By?=
 =?utf-8?B?cy96eGdEQ0lKVGFnODdmdFI2djM3engyZlZUQUd5dzRBcnpYRmt6QXoydlZq?=
 =?utf-8?B?eSthbk42MGhZYStWMjAxc0R1NmxveEFsMTZYZkIxVXpBN0FBV1l0K0ZRODRa?=
 =?utf-8?B?c1E1dDkrUVZvN3FSTzhkUTNtUXV5b09GQnRRaDZrQzkxUG1xNW5XSnZUaHVa?=
 =?utf-8?Q?EuCTEsyfam9c7KlGKjmlycjIL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a767e4a4-779b-498e-d976-08dd5c48e979
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 00:50:38.2395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NecVky4ne2KkkNoRIkBfiBUcxZFFY953vy5ACCEIMJ34tPnbkteF4MfP0NZv24qkbpChFjGSm8fdTV6Qzq5TMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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


On 2025-03-04 22:54, Emily Deng wrote:
> While the entry get in svm_range_unmap_from_cpu is the last entry, and
> the entry is page fault, it also need to be dropped. So for equal case,
> it also need to be dropped.
>
> v2:
> Only modify the svm_range_restore_pages.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 7d4395a5d8ac..b0a88f92cd82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -78,6 +78,9 @@ struct amdgpu_ih_ring {
>   #define amdgpu_ih_ts_after(t1, t2) \
>   		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) > 0LL)
>   
> +#define amdgpu_ih_ts_after_or_equal(t1, t2) \
> +		(((int64_t)((t2) << 16) - (int64_t)((t1) << 16)) >= 0LL)
> +
>   /* provided by the ih block */
>   struct amdgpu_ih_funcs {
>   	/* ring read/write ptr handling, called from interrupt context */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index bd3e20d981e0..d04725583f19 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3010,7 +3010,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   
>   	/* check if this page fault time stamp is before svms->checkpoint_ts */
>   	if (svms->checkpoint_ts[gpuidx] != 0) {
> -		if (amdgpu_ih_ts_after(ts,  svms->checkpoint_ts[gpuidx])) {
> +		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
>   			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>   			r = 0;

Looks reasonable. Should we also set r = -EAGAIN, so that the next fault 
for this address doesn't get rejected by the SW filter? See the code at 
the end of svm_range_restore_pages that handles -EAGAIN and calls 
amdgpu_gmc_filter_faults_remove. I guess that only matters on chips 
where the CAM is not enabled.

Regards,
   Felix

>   			goto out;
