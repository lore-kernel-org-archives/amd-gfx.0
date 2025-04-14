Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D962BC369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6091210E268;
	Mon, 14 Apr 2025 17:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pv9ullH+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0C310E268
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEzbPsg64h2kRI3LC+hF1CYJAAHVg1me59Lhhu+3AC9U/m94xR7CqHH/mSh2dIBnRByOlWy/1Sn6VfoN1m+lwuoriEn5o7QNbYwis7tuvoBF4eR8PG4ApbEKrIQhfbgC4jiqn9l5L33XsCSAshoQXDqQfDBxlbE89L9r0nJVwSIktJImg3Uqmj4/9R9ODy/CsVzcKDSM7dq5cach8IzanXPzV1HFJAGzqahz/61/Iqng88569Ip3S67xYCFttK3+ggbGaJEahT1A8fhtu15iqis6G+G1jEQBHLRTtnavr8jjruntnLIDzHqQvKvYPCJO1skNx+tPuFNs4noMzi+PYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIzwZghAyRJ29MklbiAT7Upyfb72CQH0QU3Qa+x4uYE=;
 b=DnmACWQDIXu79n9XxbnXbcJ1po0hIAypR75+1CIBdIo7oyr39WEi8OnTDju0hixTfZ7fshgTkn8yftikN5wdYP2BEdWe3h7aRfzCXSVfgaMlR/jTkGpE/4HlTc/PymQ6hW1sZRXvHFp6PXcybX5kPsdzlARPQz8/O5Po59hcYHN4edi8g1cE4sfUiRnwi015uTqpcYLythzLDeJdDTUF27NmuvNVTZ40IrHoE3aIwO+KYsI/6142AECmrvwANC+AXqkTholLRI++lHh73q9ZJ1PtjQSSnidUpw6d1P+hH/9TgNEJ7DHFmdr7AqJresRXzOtdX56AfmdHQaBayeCWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIzwZghAyRJ29MklbiAT7Upyfb72CQH0QU3Qa+x4uYE=;
 b=Pv9ullH+UL3+OFX66KwPvt3+Tp5w3QsR5Ca683xP6OczEZodYRU0aJDtX+J/A1ALlX9anN8uMBsv/6m94yAyZ+0Ej1dAX2RqSd72dFBEqdFeo1yJurrKNImNrzPvoSyGHTztwlDqH37xh6b55u4H++FClEUPgjZoTeBlunG7JOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 17:51:40 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 17:51:39 +0000
Content-Type: multipart/alternative;
 boundary="------------5Qy0vEOsDaKFAjAWhlHE6EkZ"
Message-ID: <9b9af2dd-5c5e-4287-a458-fe1946bb9747@amd.com>
Date: Mon, 14 Apr 2025 23:21:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: rename enforce isolation variables
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250414171259.2996574-1-alexander.deucher@amd.com>
 <20250414171259.2996574-3-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250414171259.2996574-3-alexander.deucher@amd.com>
X-ClientProxiedBy: PN4PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c1e68f-b4b0-4964-d589-08dd7b7d023d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3Z2U2R2dEZGaGhFZjhKVFVPWlZXSlNFSk50VklhaXZoWGNaTkROVmYwTmhL?=
 =?utf-8?B?WkJwN2drRkhLNFc0djhCcWsrOE1OOVRWLzM4L3RoL3JBT0JJWEJaZW95SGIz?=
 =?utf-8?B?M1FWSTc3U3JlbWtYbUpEaTlrcXRidnArUTZLUHcvMGxzREthSENHM3d5czZy?=
 =?utf-8?B?MGNCQ2d0TXNiSkpPMGYvTmdyd1k1RThDOUp5U0s1eVpaWjFObm94MDJMRTRk?=
 =?utf-8?B?NGd1bDRJMkcxSlN5Sy9RMUVZSjRaTTFCazltQTJYNEVmNXdnL1dhVmlIcnNn?=
 =?utf-8?B?SjRiVVJZU0xsb1BEYWl5L2tFN2JCOEJwWGhzbHNIK2drYkFjNDN2TXRSQnA3?=
 =?utf-8?B?Q1JyM3IvNVpkcm5nNEcwa3c4RnhmZzAwRFRWUXZKVmw5NnBienFiaWRTd0pE?=
 =?utf-8?B?cysrdDgySnhMbjVxSmt6UzdmU3VGTmxhRHBSZ2JkZDIzSmhQMVNWYkowUWVL?=
 =?utf-8?B?a1pGeVk1bG1sWHZ5TWs3R2p6cm1RSjYzY25rM1hkcjhZZDF5eG1wUVNjTkl6?=
 =?utf-8?B?enRTcmJZM3hXYVVBdHhyTnZpK1ZLR1htT2d3ZHc2RHpRWGJVcU1ZUS9XVmlT?=
 =?utf-8?B?cHZvNGdMRE1PR2g1b1loakpjZlFmYmlybFVlTmczTnV0R04zblJaQnQrN3dF?=
 =?utf-8?B?WiszUlVYVWFZamt5SUhPS3gwRVp0aGlrNXcyZXBlc1VDVmhQTGRBcG5UZ2Nu?=
 =?utf-8?B?ZngzREpKQjF4OWlNMnJYZnBlRjJ3RDdVUlp1c09IdXlielBsM1o3WHRwSWZj?=
 =?utf-8?B?QTN4VGJlWlRWRUd5RWl5V29EQlNJRWoyREQ4aFZkb0cyckh3MGRuWllsUmFT?=
 =?utf-8?B?Rmt4L1k4eDhPN05rQUVkWWtHYkFORVY1Mlc2SGFyY096cGJ5M1VEK01IU1A1?=
 =?utf-8?B?N1VudHRWUE1qajVOME4wWHA4ejJ6L3VmUkp3TDJUOVBIZ3pRaURRdVBQU3JK?=
 =?utf-8?B?YkxvY2N5cTE2RmJqQUhVdTUxaWF1QVZFSkNDeHFIcUdnZFMxVm1FNnIwd0Nr?=
 =?utf-8?B?aWZ4RUhMeThJWEFzNi8vY0xuYkpQTi8reHNnY0g0a0FLOVpQMkFLejEyTlBm?=
 =?utf-8?B?YU02WTBFeG9jSjM0VTZSWlMzTVhPTHdYbFdEVmhJUzRIbFE5dmhFZ21yVHI1?=
 =?utf-8?B?a0dTT1NaemczeUwwdkVBZzF2UmVQY0dFMmhFdVVaUnorM200MHlQaFVobmtR?=
 =?utf-8?B?R0NRKzFNWllOUTRZbW91cnhJMDhJb2RjQWdxdk5FOVhyNlNzR3pHd05zbTdV?=
 =?utf-8?B?WXN6eXczWGl6WTBrS1dwZWtyNHYvMGl4TnpzK0REeVQ3RGpxYnlPUElTemdm?=
 =?utf-8?B?SzVGZEx1R21lMlAyVFdSSnE3U3pSbHVSM2FUMVJCVjBWajJDc1ZGVFdOL244?=
 =?utf-8?B?eGtBcXFncXVQV2NRSTJXNE1sa3lMWURrdEpMV0pDMDVsc2t3VnZTWklCZTZz?=
 =?utf-8?B?NU5GVlAwOVFCUXBlSmh3aGNxSU1ZMnZMZ25EaDVidDJxZml6Mm1tL2ovbEda?=
 =?utf-8?B?U3U5QWF3cGNJaTlsUHFtdFl4THZwVVdBUGdxMHNtMTZPN2NBb0hVUGovVzhi?=
 =?utf-8?B?RjBBQzVDUk1jUU82aUFoTmxKMHNKTnozM1VaSkVoZFNZdHE5WnQvMXhZQW5N?=
 =?utf-8?B?Mkl1MjY0NHNTTVFuWmNpR1hsMWZqT3RyTUMyZkMvM0xHTXh5dGJud2R0aW1a?=
 =?utf-8?B?SzhjamY2dXp5YVl2T2xWNUV3VUEzckZqRWwyMzdLenB2S01MRk5qNXJPQmND?=
 =?utf-8?B?R3gvNUVteVgzWWFCbUFVUytLLzBVaGZocE1MUGVlbkVRUDZlQmxZNDJRTFBz?=
 =?utf-8?B?eUFncE12cjRZR2VLaXBSYk1nUnJlRllzNm9VVWNHVnRLYW9vOFhwOFh1SjFS?=
 =?utf-8?B?SXNPZUFLcVArbit4UFlKTVZXNGZrcU9qN3BDaXpwWmlNWm5tQ29OVDJvanJE?=
 =?utf-8?Q?z83VDr7uxOI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXhuanE3ZDZ6Vk5sMGY3VkNQK1N4WTcvcU9MSjdvZ2pROVFlbWpJaHpHdHQy?=
 =?utf-8?B?ZkZ3RDhvQTEybGhHT1p6Q0dZMFZnWFc4LzNyWkJuZXJ3cUdMQ0ZWK3pXaFdF?=
 =?utf-8?B?bXJNVXIwNkk0MFVlOStyYXNVdDFLcDBKSy9uWWFqNUEvNWFPTE1CYUFZdXUv?=
 =?utf-8?B?a2crMitFeUxVZnZsOUREYThwSWRsWnU0RVQvQnZEdTNFZWM2cTQxVXFOYlY0?=
 =?utf-8?B?Q2xMVGNuZm1mRktQYmZVUWtYSWhEQkxiZDA1eDlSY0poYVdiTTVveEkzY3Jj?=
 =?utf-8?B?VTR3NHI5SnpvdTlqaGwyR01nREYxalIra0JuM2xyai9KdTJrb0xBVnEvUEd5?=
 =?utf-8?B?UDFCY2RaZysvUXJYdU5PMHBPNHlFZzdHeXdoT1NTay9CbllHYlJzQmlsbnpn?=
 =?utf-8?B?ZjNMeldRVU02SUNwY0p5VW9tZTljbm5pbWUwSWYwcXRMR0FLZE9XRGxDN01H?=
 =?utf-8?B?b3dSVkV4ZU45YWR2aGNZWHl1RFRad09mQldTUzF6bmFjRDBlMi95L3QwVFIy?=
 =?utf-8?B?cEpkbktVeFlXNzZoQXloeENJSTVBTU5USG9SM2ZEQkE1clJ2cHRzWTA5cnBj?=
 =?utf-8?B?RWZwU0VwTm1WK25KQjRIdXprWWFic3VweElacDRwaUhvUUxjeWRrSFBFT0M4?=
 =?utf-8?B?VWpGb1hYOUMwdmtraFZhTjU4eHNWUjUxODZnQWlUOVRLd1NVd2N0OHpnaDh0?=
 =?utf-8?B?M2VmVTdDYlFvMU9hMWk4ZkgxKzZpZHpKU1FNWTZnOVRZZnRKZkNKYUtOeG9h?=
 =?utf-8?B?bHYzUk96ckhkdzhVa0ozS1EzT0FyTlZHVlFFSU14bldhWDJaNzNNTEFmbXhS?=
 =?utf-8?B?VUprZHRIZGwxNXo5WFZzNHZqRTJISFJVY2FNa2pEdkY2aWRISHNZZTA3WDlL?=
 =?utf-8?B?djRlTUI5ZEUvYWRlZm01ekxwdU9nRUJjTm45aFloUWhNYWZJVUNNQ21hYWxX?=
 =?utf-8?B?bnlzR1lwR01rUUs1T1VudCtXOVZRS0o4elEyMkpzRndOZFVQN0Nsblg4K0lx?=
 =?utf-8?B?R1FtSXRKbDRTUmFnYXdkWGFML2VaWEl0dmRQUmJJcGxpZm9iNENRNFNGYURM?=
 =?utf-8?B?M0M0aUNudDZIWjNxa1VVcUVkbC9CSEpnWjYrVC9ybGVCbHg0aHZ0R0tyRTgr?=
 =?utf-8?B?VC9iQ0dqcDRqN2U0UXIvZDBHUjFCZzNqbkNSRW1KMi9xRjdWVUZSelg0eUsv?=
 =?utf-8?B?RTJ2WEpUMk8wUForYU9BMTdOVjVIcGVBM1ZMenRyd05VaVpBdk1vRUhRZ3R6?=
 =?utf-8?B?SmRqUjBZb0I5My80cVV3RGpVZCtPdHVPQ1RrTXJtK1BiM21GaGNpcXpXa3p6?=
 =?utf-8?B?L0dxemMrT2RsSFBFQjM4ZzdScnFPRnJCNkhwTThuTHJ3N3EzTldsTXhxV0s2?=
 =?utf-8?B?WDJVR08va2g4bmw0cERtSjlJY2hXd3IrN3pBVFpaa2loUkhucmlSemtiRVZD?=
 =?utf-8?B?NURnb0xHM2J5QmJMZk9raUlnaU1IM1Z2eEFpa0Z2RDhnTmthQmdGdk95Umx1?=
 =?utf-8?B?UUFYcGhCSHp6anBxeW54WGlLWVNBQnlBTkx0S0lvbm5VYkYvQkkvR3dWNlUv?=
 =?utf-8?B?dnBYajFUZzloeEdoZFNWemtmbzExaGRCSitGWE5SVGFDVmRyVlNvNnZsSERv?=
 =?utf-8?B?VEdSTzZaSFVrVU8rM1M2TDhndHowZGUyZXVUZmdOdlF0anFLNTNnbkhyOVVQ?=
 =?utf-8?B?c1laY244bk5FaVdMTmFpYXBodUs0UWs3bk9JMFFUTTgxVXkvZXZXYWt1NWpz?=
 =?utf-8?B?STlMc2VoZGZEOWZsNExSY2NIUmNtWmtkWjk5cEtzcUxuZ0lZUkdTZjlGL0RC?=
 =?utf-8?B?TVl0N25xMmk0VGlEaDNOWjJZbUtXRjlDSkJtZFBnRFRjVXI5L1lmbHJrcFNX?=
 =?utf-8?B?cVd5cnNINXBGeVpkV2l1MUJiWkZKS3RsU3RCeG1ma3V6aDZOb3FDeVVlRHVw?=
 =?utf-8?B?VUN5NDd2Zm5ORytyeXZlYUJJNXNSWDdsM3ZDMTZJVGxDYjQyM3ptTVFJb3V0?=
 =?utf-8?B?dEtpL3VnRUtCN09SM1orUGtNU1RyemlBdzlNclNVNXoyeDRTQ0NHdTNoT1ZD?=
 =?utf-8?B?QTJIMkdXaWhtV3NPQ0R2M2R0SFhOS0MxN0ltcHl4TFp3MWZtVDJ0SmV2eTlk?=
 =?utf-8?Q?jCNQSw2qhidCzoUzfDP/JN9Bt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c1e68f-b4b0-4964-d589-08dd7b7d023d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:51:39.8031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAUAhqEyedhpqp8drbuEgY14g47N3bTbqO9T7+AnJUPmeLBIdB0ecMJGpVHeJ/1lQxEq2SpygE40rRJJ/RNwvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
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

--------------5Qy0vEOsDaKFAjAWhlHE6EkZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/14/2025 10:42 PM, Alex Deucher wrote:
> Since they will be used for both KFD and KGD user queues,
> rename them from kfd to userq.  No intended functional
> change.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 32 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  6 ++--
>   3 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e966aefc2b0f3..b96e0613ea7e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4368,7 +4368,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		amdgpu_sync_create(&adev->isolation[i].active);
>   		amdgpu_sync_create(&adev->isolation[i].prev);
>   	}
> -	mutex_init(&adev->gfx.kfd_sch_mutex);
> +	mutex_init(&adev->gfx.userq_sch_mutex);
>   	mutex_init(&adev->gfx.workload_profile_mutex);
>   	mutex_init(&adev->vcn.workload_profile_mutex);
>   	mutex_init(&adev->userq_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 2c933d436e564..c58d32983c45e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1947,39 +1947,40 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>   static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
>   				    bool enable)
>   {
> -	mutex_lock(&adev->gfx.kfd_sch_mutex);
> +	mutex_lock(&adev->gfx.userq_sch_mutex);
>   
>   	if (enable) {
>   		/* If the count is already 0, it means there's an imbalance bug somewhere.
>   		 * Note that the bug may be in a different caller than the one which triggers the
>   		 * WARN_ON_ONCE.
>   		 */
> -		if (WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx] == 0)) {
> +		if (WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx] == 0)) {
>   			dev_err(adev->dev, "Attempted to enable KFD scheduler when reference count is already zero\n");
>   			goto unlock;
>   		}
>   
> -		adev->gfx.kfd_sch_req_count[idx]--;
> +		adev->gfx.userq_sch_req_count[idx]--;
>   
> -		if (adev->gfx.kfd_sch_req_count[idx] == 0 &&
> -		    adev->gfx.kfd_sch_inactive[idx]) {
> +		if (adev->gfx.userq_sch_req_count[idx] == 0 &&
> +		    adev->gfx.userq_sch_inactive[idx]) {
>   			schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
>   					      msecs_to_jiffies(adev->gfx.enforce_isolation_time[idx]));
>   		}
>   	} else {
> -		if (adev->gfx.kfd_sch_req_count[idx] == 0) {
> +		if (adev->gfx.userq_sch_req_count[idx] == 0) {
>   			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
> -			if (!adev->gfx.kfd_sch_inactive[idx]) {
> -				amdgpu_amdkfd_stop_sched(adev, idx);
> -				adev->gfx.kfd_sch_inactive[idx] = true;
> +			if (!adev->gfx.userq_sch_inactive[idx]) {
> +				if (adev->kfd.init_complete)
> +					amdgpu_amdkfd_stop_sched(adev, idx);
> +				adev->gfx.userq_sch_inactive[idx] = true;
>   			}
>   		}
>   
> -		adev->gfx.kfd_sch_req_count[idx]++;
> +		adev->gfx.userq_sch_req_count[idx]++;
>   	}
>   
>   unlock:
> -	mutex_unlock(&adev->gfx.kfd_sch_mutex);
> +	mutex_unlock(&adev->gfx.userq_sch_mutex);
>   }
>   
>   /**
> @@ -2024,12 +2025,11 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
>   				      msecs_to_jiffies(1));
>   	} else {
>   		/* Tell KFD to resume the runqueue */
> -		if (adev->kfd.init_complete) {
> -			WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
> -			WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
> +		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
> +		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
> +		if (adev->kfd.init_complete)
>   			amdgpu_amdkfd_start_sched(adev, idx);
> -			adev->gfx.kfd_sch_inactive[idx] = false;
> -		}
> +		adev->gfx.userq_sch_inactive[idx] = false;
>   	}
>   	mutex_unlock(&adev->enforce_isolation_mutex);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index caaddab31023f..70b64bb1847c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -475,9 +475,9 @@ struct amdgpu_gfx {
>   	bool				enable_cleaner_shader;
>   	struct amdgpu_isolation_work	enforce_isolation[MAX_XCP];
>   	/* Mutex for synchronizing KFD scheduler operations */
> -	struct mutex                    kfd_sch_mutex;
> -	u64				kfd_sch_req_count[MAX_XCP];
> -	bool				kfd_sch_inactive[MAX_XCP];
> +	struct mutex                    userq_sch_mutex;
> +	u64				userq_sch_req_count[MAX_XCP];
> +	bool				userq_sch_inactive[MAX_XCP];
>   	unsigned long			enforce_isolation_jiffies[MAX_XCP];
>   	unsigned long			enforce_isolation_time[MAX_XCP];
>   
--------------5Qy0vEOsDaKFAjAWhlHE6EkZ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">&nbsp;</p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Acked-by:
      Sunil
      Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></p>
    <div class="moz-cite-prefix">On 4/14/2025 10:42 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250414171259.2996574-3-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Since they will be used for both KFD and KGD user queues,
rename them from kfd to userq.  No intended functional
change.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 32 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  6 ++--
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e966aefc2b0f3..b96e0613ea7e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4368,7 +4368,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		amdgpu_sync_create(&amp;adev-&gt;isolation[i].active);
 		amdgpu_sync_create(&amp;adev-&gt;isolation[i].prev);
 	}
-	mutex_init(&amp;adev-&gt;gfx.kfd_sch_mutex);
+	mutex_init(&amp;adev-&gt;gfx.userq_sch_mutex);
 	mutex_init(&amp;adev-&gt;gfx.workload_profile_mutex);
 	mutex_init(&amp;adev-&gt;vcn.workload_profile_mutex);
 	mutex_init(&amp;adev-&gt;userq_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2c933d436e564..c58d32983c45e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1947,39 +1947,40 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
 				    bool enable)
 {
-	mutex_lock(&amp;adev-&gt;gfx.kfd_sch_mutex);
+	mutex_lock(&amp;adev-&gt;gfx.userq_sch_mutex);
 
 	if (enable) {
 		/* If the count is already 0, it means there's an imbalance bug somewhere.
 		 * Note that the bug may be in a different caller than the one which triggers the
 		 * WARN_ON_ONCE.
 		 */
-		if (WARN_ON_ONCE(adev-&gt;gfx.kfd_sch_req_count[idx] == 0)) {
+		if (WARN_ON_ONCE(adev-&gt;gfx.userq_sch_req_count[idx] == 0)) {
 			dev_err(adev-&gt;dev, &quot;Attempted to enable KFD scheduler when reference count is already zero\n&quot;);
 			goto unlock;
 		}
 
-		adev-&gt;gfx.kfd_sch_req_count[idx]--;
+		adev-&gt;gfx.userq_sch_req_count[idx]--;
 
-		if (adev-&gt;gfx.kfd_sch_req_count[idx] == 0 &amp;&amp;
-		    adev-&gt;gfx.kfd_sch_inactive[idx]) {
+		if (adev-&gt;gfx.userq_sch_req_count[idx] == 0 &amp;&amp;
+		    adev-&gt;gfx.userq_sch_inactive[idx]) {
 			schedule_delayed_work(&amp;adev-&gt;gfx.enforce_isolation[idx].work,
 					      msecs_to_jiffies(adev-&gt;gfx.enforce_isolation_time[idx]));
 		}
 	} else {
-		if (adev-&gt;gfx.kfd_sch_req_count[idx] == 0) {
+		if (adev-&gt;gfx.userq_sch_req_count[idx] == 0) {
 			cancel_delayed_work_sync(&amp;adev-&gt;gfx.enforce_isolation[idx].work);
-			if (!adev-&gt;gfx.kfd_sch_inactive[idx]) {
-				amdgpu_amdkfd_stop_sched(adev, idx);
-				adev-&gt;gfx.kfd_sch_inactive[idx] = true;
+			if (!adev-&gt;gfx.userq_sch_inactive[idx]) {
+				if (adev-&gt;kfd.init_complete)
+					amdgpu_amdkfd_stop_sched(adev, idx);
+				adev-&gt;gfx.userq_sch_inactive[idx] = true;
 			}
 		}
 
-		adev-&gt;gfx.kfd_sch_req_count[idx]++;
+		adev-&gt;gfx.userq_sch_req_count[idx]++;
 	}
 
 unlock:
-	mutex_unlock(&amp;adev-&gt;gfx.kfd_sch_mutex);
+	mutex_unlock(&amp;adev-&gt;gfx.userq_sch_mutex);
 }
 
 /**
@@ -2024,12 +2025,11 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 				      msecs_to_jiffies(1));
 	} else {
 		/* Tell KFD to resume the runqueue */
-		if (adev-&gt;kfd.init_complete) {
-			WARN_ON_ONCE(!adev-&gt;gfx.kfd_sch_inactive[idx]);
-			WARN_ON_ONCE(adev-&gt;gfx.kfd_sch_req_count[idx]);
+		WARN_ON_ONCE(!adev-&gt;gfx.userq_sch_inactive[idx]);
+		WARN_ON_ONCE(adev-&gt;gfx.userq_sch_req_count[idx]);
+		if (adev-&gt;kfd.init_complete)
 			amdgpu_amdkfd_start_sched(adev, idx);
-			adev-&gt;gfx.kfd_sch_inactive[idx] = false;
-		}
+		adev-&gt;gfx.userq_sch_inactive[idx] = false;
 	}
 	mutex_unlock(&amp;adev-&gt;enforce_isolation_mutex);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index caaddab31023f..70b64bb1847c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -475,9 +475,9 @@ struct amdgpu_gfx {
 	bool				enable_cleaner_shader;
 	struct amdgpu_isolation_work	enforce_isolation[MAX_XCP];
 	/* Mutex for synchronizing KFD scheduler operations */
-	struct mutex                    kfd_sch_mutex;
-	u64				kfd_sch_req_count[MAX_XCP];
-	bool				kfd_sch_inactive[MAX_XCP];
+	struct mutex                    userq_sch_mutex;
+	u64				userq_sch_req_count[MAX_XCP];
+	bool				userq_sch_inactive[MAX_XCP];
 	unsigned long			enforce_isolation_jiffies[MAX_XCP];
 	unsigned long			enforce_isolation_time[MAX_XCP];
 
</pre>
    </blockquote>
  </body>
</html>

--------------5Qy0vEOsDaKFAjAWhlHE6EkZ--
