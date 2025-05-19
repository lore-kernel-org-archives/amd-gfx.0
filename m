Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C28C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 13:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9376F10E10F;
	Mon, 19 May 2025 13:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SSzuIoDu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8703610E10F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 13:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wde/k3hzu4vc4/IDSpV5CvL/CFhPYKiYDIO/clsBn492aBNf7QJfP7UB+jQ2HDgs9PTkvgIQ0jpaGgXb0D+oLRBrBMlHHVN+4mEArbqURUW0iT0rmrQMuib8V0ibdFxmini0MEHX7qVCOWmQn+B+ZZ8MXJs28IIU9gFY3W0ZKcFfGIT7xa7plkDt2oWNAnECLiX0TGKKwz6JpcR9ETVz8kdZac38B61msW3nqnjaR6wjT/k6RZpVRvZD9wWBWpOcKBRo0tZPbafOJpG5WDRp7wSFFLPcDS438DTe6/ejMpLMe552FvYKi0QwKMMKb3lgwMeZfiHtUPojiv9UfdqUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kPmWZo5gTCgrHoXXbwsbaTgG/ruFUxVrerSHa7fGAk=;
 b=aVHITaNDj01WtzALhDgjvxef6uhzqjKFEfgYdFM11VUgvH8/RzH0Ie+o/kb8puMjmrxP68IHdPeNYwrjs1sp5wYm5RFLk3GIU1o4/8ZE9uiqatKbYcxB6+qeYx379WOocBV6/mPmkhbsDXP4WLQSsZgMCjq5dp9XtdAQIldVq1vNYc3a/ed3qOfspQ1GL/YNH1pnX5tv2V8hJ1lHe+aVy/zKT8kK4KxFxTojdPfXsKRWdQxRVY5JrlyFu1FTHh5U4U4z3peA6ML/Gx4itUNS3Zw6hmlGDdP2KASNFHCBNsA+xRrmbUUxSDWMRKHRXx1dnFQJZrxDyLxL9ayx4ysnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kPmWZo5gTCgrHoXXbwsbaTgG/ruFUxVrerSHa7fGAk=;
 b=SSzuIoDuxoQN8stYpHWnC7/Opdi5opKOEAuXKOCoqT1Ge78Yyz8zOSsg9zcj9jHb0ydfN8gSR6foBSHt9XFewhDBnhHNOyTT2I8qNva7P6jGtJdMg9g3NxE/rxMl/3MNA+6kirOqte3BZkQGAtoQAheMScWOgHoIU8aFwPc15YE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 19 May
 2025 13:57:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 13:57:25 +0000
Message-ID: <e75c26e4-8011-4e49-9e2d-d354dcf7358b@amd.com>
Date: Mon, 19 May 2025 15:57:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Lijo.Lazar@amd.com,
 Emily Deng <Emily.Deng@amd.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
 <20250519082038.21459-4-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250519082038.21459-4-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 5341281b-38f4-46fa-fe00-08dd96dd156c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjZZNENhdXRpVlRkT05vOER6akQzdW9GTC9iSmxDRS85ZkVsakxmZ2k3R2tG?=
 =?utf-8?B?eDZBc2c0eTJYSkpndm5TRklaWG1VVnE2ZG92OUdUM2VFWU1QVnlzWTJqeDJB?=
 =?utf-8?B?T1FyN09GUWl0ekg4cjFYRUdHbmRhVHEyN2p6QjVNZEQveXUrajcyUVVERTFa?=
 =?utf-8?B?YzVLODZvdHZxUldtb1FEVDBlWVpkUjZJcmpDVThGVFFUM1lndmdHQVM4QUFa?=
 =?utf-8?B?K0dJV2phYkV3WEJLU0VoZW55OGlKRkwwWXIzbkk0R1p0TE1BdkovY2NvUXV3?=
 =?utf-8?B?NzFIM09JTlFSRW9xTk5OQVBYam9ENUh4YVR2eUFoVEszQXFuWldKR3FES1FN?=
 =?utf-8?B?dTlCeGVIejBKZXpLUVZxVUVPV1ZtaGd3YWduT3hTU0tmcFVOUGNSL2hKc3Q3?=
 =?utf-8?B?UHFMQUFVOTRWd2wzc1d1Q0ltemxTRVROT1QxdEZZWmF5TWpUdUxvb1puZnJ6?=
 =?utf-8?B?SUtkTFpQVGFOUXg4aTIyS2RlckYzZ2x2SCttb1VGeEs4bFBHc3Q2RUtQV05h?=
 =?utf-8?B?M0oyb1NzMVlOVmx5ZlZnSzBrdVZGWW1nTFlsV1dkMC9jWFhDSVZ3WWRraVR6?=
 =?utf-8?B?SjBMLy9KRXByOXRUSCsvd2YvSnEyRFhlOFRPaWhtY2VscmxNZmVlcWs0Q1d2?=
 =?utf-8?B?QjNYcjRaei80bFJSWGFuL3pKYmFBOFJvcjltSDdtbkU4bDkyL0djS3ppaDdv?=
 =?utf-8?B?d3EwZzk1dHVRZnNMU0t0azFYVWZGTTltUHV0M0lrS2NsQzM0OGI2RDBOMDhl?=
 =?utf-8?B?bXgzdzBoNWNZamZuTksxQzZ5Ym5mam91K0w2bEh5d1J0bSt6N3BQaW9GOXQ3?=
 =?utf-8?B?UXkwSGZxRG9TWURNSGMzSDE5SndqOVZKci9NL1lWaUE5SXJ6NlZYd2kxNDFD?=
 =?utf-8?B?WHJQUktMamRQTXZ5VytoUUU3T0ZNMzBPVHFTaEVkWlA5M0ordE5mbWNwRitJ?=
 =?utf-8?B?Um1XbGVwcnBrQWREaHFEWHFpNmtnRHdlbkVuallWcmhRRk0zaDFuSm94cTB6?=
 =?utf-8?B?VUo1d3d6dmY5c1V3MEsvOHhxU2F1ZSthd0V3YkxrcWRIMzRnVFJTekNubnNC?=
 =?utf-8?B?NTJERE42NzF4akRBaUl4Mnc0czI3L05DSEhJRHBvakxSVXE0dGhQTGZjblpi?=
 =?utf-8?B?bnlVNUM0N1FUY0pkNXVsRkNkVnQ4WVRpZDJTYjlLcTVwZUE4SWlWV2E2UjJS?=
 =?utf-8?B?cXc4bHdkbkFYeEs0YmEzeUdMZHpXdlhseXpkN2xqemVRN2hwRGFSeHhtUnlh?=
 =?utf-8?B?Zi85cWdNRmFpM05pMFJBVDZreWl0VWpDNU8zU0JSMXZiNW1ORUJyZ3E4eVp4?=
 =?utf-8?B?NmwxaFhrcWZXbXAxOEpyWWZhUTlja0JaT1ErQlJlY0pvaXVJaUVEcEJnRnRZ?=
 =?utf-8?B?ZWdTOXZ4MEpSNGp2N0R6Ym1DWEZUNVVlQzFzZXI5RiszTHJrVE9DRzZHQm0y?=
 =?utf-8?B?Y1ZLNDYwNithbElNbTJjQ0Y0M0JWQ2RoZVJESWZJUEhIMUN3cWFsc1B3UmxR?=
 =?utf-8?B?eTdCNWwySkFuZ2tjTUczWEtVRTJVMWExcW1CdE9oaGpMNDRLbE9KVlNwdTNC?=
 =?utf-8?B?bmZpOGcxQlRsMEZ1VWpLVVUwcWQ1VThXK2NmaTNUazRIQUVVcjkwZ1dBK3k0?=
 =?utf-8?B?OS8rSVUydFp2RHVCSFQwSlBKS09PWnNQN0lWQXNoNFc5TC9Nb0YwZ3JqdEVz?=
 =?utf-8?B?c2d6cjdIZUdWczdMb1RwRHBQWFFyTkJITkI0RWVkNlhtNk5CMDRsWDdLUGhx?=
 =?utf-8?B?YnJxS0tQUzdxZU5BNnpZWUZjOEdXUUdma01yMlFzVFFLdCtkbXAwU2xsMnc5?=
 =?utf-8?B?cm8zVk1rNDdJeSt4U1VINDVHQUdNSk5icGRkNGZYQllQNEVRNDZFWUVtTVFG?=
 =?utf-8?B?RGRNejZTM1YraFVSdVQzZUZuQWZjQjBqcGxWL2hqdUpNMUZsb21QQWNJL3pM?=
 =?utf-8?Q?2xvW0xyBQxc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXVKU253VHFhQ0tNNnZTbXcrRFdBeGNiMlp0cmpoOHp5MCtwRitjeGR4SDY3?=
 =?utf-8?B?UFJLMUhCS2JUYlM0cTNEMFdmSkNSMDc3ZVI3c1hINThuZ05wNTBha1oyUVFx?=
 =?utf-8?B?V2xEU1FNZHNvTDl5REZDeDM1OHdjRjdNR2JnandVZk1JYkNLZVhhaVBGSTUr?=
 =?utf-8?B?cTF2ZEJVNHUvK2JsbzBxekJrbzhiOWtIMlBFOXRpZnM0Q1ZKZWJQR1lRSmlY?=
 =?utf-8?B?ejhyT3NIL05uK0dHbGNHQWdmQTdWNjhmalR0SDk4ZmhkSlZkL20yalI3bVp0?=
 =?utf-8?B?QlZBZFkxZHZ6dEw3aHltVHJJZy9tbmJRenUxL29idGpTdjBPd3Q1UUUra1ZX?=
 =?utf-8?B?a1hzYko4NFZIbk9KT3l2UTFDV1RGakZpZi9ldFZwQTRjUDhVd0VDdzVaenR1?=
 =?utf-8?B?VEtJak9QRUVVajBmQjlFOGxNUHZIZzJzTkFYaXZmTFRNYW9vMnBjK2lXa0hQ?=
 =?utf-8?B?NXgwSkdIT3NUWHZlZlRTYWtxOHROV2t6L245Vnd1L1cydFFzcmo4Q1RHVU1K?=
 =?utf-8?B?N1BxaG4xa0c1OERlSmFNMjlJVjFGclNQQzZSWlF4azJoQkVVRC9DZGlVN1pr?=
 =?utf-8?B?VUNLYm1PbEhnVmExTWNRa2Rhem5Fc2tvUFV5eU55UVFUMmI1aHdiU3NkYURH?=
 =?utf-8?B?eW53RUhzSkpFUHkxdUxjL00rY3gvRWpJcSsxcCtHZ2V5TzNyUysvZnBmK0Rw?=
 =?utf-8?B?WVpud1d3cE9KNTZ4REdyWktlL2lERDYyd2lEbXdrSmx2TEMxc1BLNzhOYWZ3?=
 =?utf-8?B?eW1sd1dpbFlqejhFd3hEbCtFTzl1blNuNVJzcmdWcFAzODBPbzZpUFA2cUZP?=
 =?utf-8?B?ODd1VDhpSytOdTFTTFdIRjhUZ2VaQTZrMnJLMVErQkhBZ0l3U2VhbmFOOU5q?=
 =?utf-8?B?aGhFV0pYZ1VjS0xkd0hUdWNqYXNYd216NFBYOFJ4UmNTblp4WGJOblRoQkxG?=
 =?utf-8?B?ZjJWU01ldWpnTTZzdVo2VXVhVk1oOUJkdVE1QUxoZGNwaENNbFRqV2NQZUs4?=
 =?utf-8?B?aEpNb3FWQzZNYldmQy9GcHdwQmdMTWlHam1SeEwvQjRZMzRWclk1ZHBYUytU?=
 =?utf-8?B?bzRsRnhKbDdsZVR1dTJCNTFHZnMwWk1QWDBGL2d3MndTWE5NWHhra1JiOVFh?=
 =?utf-8?B?Y3VtbGJQS0RIQWJvRDkxdlM1YndIT0NqTFlma1ZGYVQzT0VYVlVZTlRTK3dV?=
 =?utf-8?B?SzJUYWtRdlFmZzJ5Vml4Ujd3UGhiZFNQemVTNHUrTUhVcjFKRFJZdTdwMmx5?=
 =?utf-8?B?TFNkcUhsMTFtSzU3OHJtaU4zYzlSS09ncVB1UU1DcXhEUG9lT1JISnNaVjR5?=
 =?utf-8?B?ZG5iOGFoZmdES3F3d1RVd2l2cWtvQm83aTVRUWFiQXR5VTIzRVNveW52QkNz?=
 =?utf-8?B?VzBEZUo4SlNtMUhtWHY1VUhCYlUrTFl3K1FoMFppK3hQSVJyd3pLZGt5Yklj?=
 =?utf-8?B?dEgzZnZhTUdzQVVseXlzRjhyKys3aisxaU5iVjhoZ0VWM01lQlVuWlN4UGdm?=
 =?utf-8?B?UVYyZ212eUVPcjV1aWZ6RVlBVXBLcUxXZ3o3VDhVVkUwU056NlBPYmx6WlQ3?=
 =?utf-8?B?VXoyR2dZSWh0OXJwRHYwVkxnS2NlSXdqZmVyWHp3UGdrNnRoTmJkNHQ3U0w2?=
 =?utf-8?B?TWtnWC9nSnJuV09IdjhNNU1aWno1ZGRsQ21HT3prREgvNzRmam13aHk2YnVU?=
 =?utf-8?B?Y2pRMlhkT01SbzlwZmozSDNYSG5qZ2FERm5OZHBjemEwNENNLzJ4Wjh0RThE?=
 =?utf-8?B?VkJ3K2tzMVJrSGtlRXB4N0x1UnZqYXhLcG00c01TbGd0WmlYMlVuYnpaYUxw?=
 =?utf-8?B?TG5aT2c1ZmlibG9zN2pTZjBad0RzTnVYV1kwYUJ2SUU0WXE4T1VGK09xTUcv?=
 =?utf-8?B?ODhSSWhuTFRzbGdxQmVIZ3lUS1JCaWt4Ymw3N1R4TDVIZ2crM05SczM3RGpB?=
 =?utf-8?B?S3Z5akl0WXoybTl4bDRNZFB1SkZjSVE4bXpFK3NhZ2E2ZkdEempHaXVoNlJq?=
 =?utf-8?B?N2ZXZ0pXU2l4YVlYQUY1MEF2UXErVlBFTmN6ZjRKUWxrcnYvTzlBUDdMLzht?=
 =?utf-8?B?SUVLMGV5czFsd0dLVThNenRSSjJXNGtwd0ZPU3JkT2dLbmVUTkQ2cksydWsr?=
 =?utf-8?Q?hK7Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5341281b-38f4-46fa-fe00-08dd96dd156c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:57:25.0202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufdQOVFaWvV1vRHp5MWpf4thG9YMS5Uh8YObpKl6q03TxH1KEZyEOuFKu2D8UsIs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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

On 5/19/25 10:20, Samuel Zhang wrote:
> When switching to new GPU index after hibernation and then resume,
> VRAM offset of each VRAM BO will be changed, and the cached gpu
> addresses needed to updated.
> 
> This is to enable pdb0 and switch to use pdb0-based virtual gpu
> address by default in amdgpu_bo_create_reserved(). since the virtual
> addresses do not change, this can avoid the need to update all
> cached gpu addresses all over the codebase.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 32 ++++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 10 +++++---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
>  5 files changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d1fa5e8e3937..265d6c777af5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -38,6 +38,8 @@
>  #include <drm/drm_drv.h>
>  #include <drm/ttm/ttm_tt.h>
>  
> +static const u64 four_gb = 0x100000000ULL;
> +
>  /**
>   * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>   *
> @@ -249,15 +251,24 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  {
>  	u64 hive_vram_start = 0;
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
> -	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
> -	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> -	mc->gart_start = hive_vram_end + 1;
> +
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		/* set mc->vram_start to 0 to switch the returned GPU address of
> +		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
> +		 */
> +		amdgpu_gmc_vram_location(adev, mc, 0);

This function does a lot more than just setting mc->vram_start and mc->vram_end.

You should probably just update the two setting and not call amdgpu_gmc_vram_location() at all.

> +	} else {
> +		mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
> +		mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> +		dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
> +				mc->mc_vram_size >> 20, mc->vram_start,
> +				mc->vram_end, mc->real_vram_size >> 20);
> +	}
> +	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
> +	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>  	mc->fb_start = hive_vram_start;
>  	mc->fb_end = hive_vram_end;
> -	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
> -			mc->mc_vram_size >> 20, mc->vram_start,
> -			mc->vram_end, mc->real_vram_size >> 20);
>  	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
>  			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
>  }
> @@ -276,7 +287,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  			      enum amdgpu_gart_placement gart_placement)
>  {
> -	const uint64_t four_gb = 0x100000000ULL;
>  	u64 size_af, size_bf;
>  	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
>  	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
> @@ -1068,6 +1078,14 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		/* always start from current device so that the GART address can keep
> +		 * consistent when hibernate-resume with different GPUs.
> +		 */
> +		vram_addr = adev->vm_manager.vram_base_offset;
> +		vram_end = vram_addr + vram_size;
> +	}
> +
>  	/* The first n PDE0 entries are used as PTE,
>  	 * pointing to vram
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index bd7fc123b8f9..46fac7ca7dfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -307,6 +307,7 @@ struct amdgpu_gmc {
>  	struct amdgpu_bo		*pdb0_bo;
>  	/* CPU kmapped address of pdb0*/
>  	void				*ptr_pdb0;
> +	bool pdb0_enabled;

This isn't needed, just always check (adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev)), make a function for that if necessary.

>  
>  	/* MALL size */
>  	u64 mall_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index cb25f7f0dfc1..e6165f6d0763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>  		/* In the case squeezing vram into GART aperture, we don't use
>  		 * FB aperture and AGP aperture. Disable them.
>  		 */
> -		if (adev->gmc.pdb0_bo) {
> +		if (adev->gmc.pdb0_bo && !amdgpu_virt_xgmi_migrate_enabled(adev)) {
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..04fb99c64b37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1682,6 +1682,8 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>  		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>  	adev->gmc.noretry_flags = AMDGPU_VM_NORETRY_FLAGS_TF;
>  
> +	adev->gmc.pdb0_enabled = adev->gmc.xgmi.connected_to_cpu ||
> +		amdgpu_virt_xgmi_migrate_enabled(adev);
>  	return 0;
>  }
>  
> @@ -1726,7 +1728,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>  
>  	/* add the xgmi offset of the physical node */
>  	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (adev->gmc.pdb0_enabled) {
>  		amdgpu_gmc_sysvm_location(adev, mc);
>  	} else {
>  		amdgpu_gmc_vram_location(adev, mc, base);
> @@ -1841,7 +1843,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (adev->gmc.pdb0_enabled) {
>  		adev->gmc.vmid0_page_table_depth = 1;
>  		adev->gmc.vmid0_page_table_block_size = 12;
>  	} else {
> @@ -1867,7 +1869,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		if (r)
>  			return r;
>  
> -		if (adev->gmc.xgmi.connected_to_cpu)
> +		if (adev->gmc.pdb0_enabled)
>  			r = amdgpu_gmc_pdb0_alloc(adev);
>  	}
>  
> @@ -2372,7 +2374,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> -	if (adev->gmc.xgmi.connected_to_cpu)
> +	if (adev->gmc.pdb0_enabled)
>  		amdgpu_gmc_init_pdb0(adev);
>  
>  	if (adev->gart.bo == NULL) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index 84cde1239ee4..18e80aa78aff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -45,8 +45,10 @@ static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)
>  	top &= MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
>  	top <<= 24;
>  
> -	adev->gmc.fb_start = base;
> -	adev->gmc.fb_end = top;
> +	if (!amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		adev->gmc.fb_start = base;
> +		adev->gmc.fb_end = top;
> +	}

We should probably avoid calling this in the first place.

The function gmc_v9_0_vram_gtt_location() should probably be adjusted.

Regards,
Christian.

>  
>  	return base;
>  }

