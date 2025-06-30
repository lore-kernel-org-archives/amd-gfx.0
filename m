Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6854C8302D
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 08:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F4310E3CC;
	Mon, 30 Jun 2025 08:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4VJrqPf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1171E10E3CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 08:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsvHRkL0KSQwRmCF+/uKSsudfit8VMgk11l173qYGTdjOecHScdD6uNMNz4BnUhhNpMbP/6OJ/4zbzvVlpiPTUHHXwf+JyjRnRqSj4aJt96ke8TZh7LrdwNB9+mMp049zwsFW2i23J3nqLZoA6VlaUvovgiBWMhCsdqbPmkv+Z/j6AQ+090Y/RlfsSD6t37WnXS46lp0vE6zdizb/Ah+O2kM5RIa4K1/0t9jp/1KCHPmKLwtEDwP4D07K6PTNbUSgrVqw+T30d5hh3VOH5B0oKkS3t3kCUfcWVyEZtPuZ9+V3anF3O+uEnUZBFtYKG0aw935DVuXej0as5rl0/ldaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqfZUX3ZB67AuAxaEX/j7W4d23GN6gZqIueVEUUoo8c=;
 b=ZL1jOHjP2L3UUZAhUvjEUK6A4HjUQJwwg3YevieOmlRLD97IEVrE6ETJ8VKmN0pgv94Duk+24ucf6nqG0Z02360hsiJ8vF1AP4L7mN8Ev0lZKhuVf7T6LQPhRYVsm7zBxNxNS3p/So7J/NEoqNfAxXCi2SFAwvqBOmnxpdWq/G67Mxx7Ck6afPVQ9lotJ8iuf/icBjj92HQlUqVbNpBKipyt9XbBJ/BnJP7qFmrpB7b8JdNPV878D7lsxzVA8KMm7y7oCy4/630CTasG9OAanyqjwJ555s8YANzTa+K9AXQtnhpTqCWdtp1f1Bf+T9pgubPqCxzWUalos8ivWvFGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqfZUX3ZB67AuAxaEX/j7W4d23GN6gZqIueVEUUoo8c=;
 b=N4VJrqPfVZrFlU/J6NHuunIGMpVniY6uHUDwTOdu36deOmhdRlO6dUQc0jFjAGFIy/Erro1tu18Odteyp7aeZ2VY1pzhjYd/5w7ZxBX0wT0bCD2+ttsrsLuH6PUQ/zDOUMP0ZgUfcpepotFsKeJY3Pa+LlafoBBeRsSsIJwFE7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9597.namprd12.prod.outlook.com (2603:10b6:610:2ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 08:53:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 08:53:01 +0000
Message-ID: <6a71bcec-e38b-458e-b539-04ff7b8c2e93@amd.com>
Date: Mon, 30 Jun 2025 10:52:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] drm/amdgpu/sdma5: clean up resume code
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250627034002.5590-1-alexander.deucher@amd.com>
 <20250627034002.5590-5-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250627034002.5590-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0406.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: 1240b0e0-c7f4-419d-29c1-08ddb7b38499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHBPRTUyQmFod0w2MHRRTmM4L2tGeHBDRTlFajhPSG8zU3B2dFY0ek8yUldj?=
 =?utf-8?B?TnUvU0RvT3EwOWZNYnV2d1JKa3JlM3JKaXJzZXQxR1Fta002UzhTM1JBd1hN?=
 =?utf-8?B?ZXJqdTZkWHUvYWRHcWVqeStHRjgwOTFvSkJycXFJTWV6bVlJZVBjYytja2p1?=
 =?utf-8?B?UmRLWm45UU5PTU45M1JuYmx4NVVBdXYrWEwzejRQVW9xQkdORi9xbCtTYkZp?=
 =?utf-8?B?RXp5MU54Mk1BOUtoMENBRnZlM3BscmdONHBSdHp5RTg3ZjZxMVFnY1RudlJT?=
 =?utf-8?B?UTBreDRXTnJPUFlDZkEyZmtNRWJkUXg2ZE1wWlc2SDg3dFhPODdBS09qYXRs?=
 =?utf-8?B?b2hoMU1uVkFVSmI2NldkVUlFdWZESEVXK3pNbWxmZ2p4REx2L0IvdllvQU9F?=
 =?utf-8?B?RFo5MUU0NDUya0M5citjNHpBN3dyQXR6OU41VGZZek9ESG43SndaZGtQS2N1?=
 =?utf-8?B?YXpETnhZenRIUXVpVEFraTBTa1NwM0ljT1ZhSU9oU0g4SDhVcHI0ZDl2K2Vy?=
 =?utf-8?B?cUdjMDRCOXQ2OEM3MGFEYjBTNTQwMXJPMkhJQmM0V0gvM0R4QVRHMGhoMDhO?=
 =?utf-8?B?UGY4REE2REY3YnlFUmx2d1JvZW5qY0pPa0sycE56TDczdVRPelE0YURldDlS?=
 =?utf-8?B?YXZ1SVowYTZsdEVoN0ZwV29ldmdmM21yaUZYUUZCN0ZOVUNQOHFKQkpXWjJI?=
 =?utf-8?B?QWM3YU5qdC8wcGZoN0x1bmtUa2RrS2hucFhOcUpKajJXMUdCb25vb1NQUDVT?=
 =?utf-8?B?SkhWYnMzd3lNV1RLalhHV0ZacytKZnRYTVFWNW52ckYwelk4cDhMV1dXdTRj?=
 =?utf-8?B?UGx2ZE9rWG0veUpxMzBxQmRuYUU0SC8vMXYxc1hWbFNsNFhkK3hRQXB4Vlll?=
 =?utf-8?B?VEtGUDIzMmZEYWh0RXYrcWxScWV2OG93S1hyNlI1WmRnNk0zQ0RCeC9kNk53?=
 =?utf-8?B?THJJT2VZb0pyZWZWNWgyZ1Roa0tiRFhMOWt3MjVFTkdTQ0FGQTZFdjE4OXpR?=
 =?utf-8?B?cG82Mi9SSUwwUS9ONmF4Nm8wMVp2dUZoaW9CNWRxNFViOENpczFjSk1rQndY?=
 =?utf-8?B?UTlxUHU3MFJUWGxmT0x4QTdsYTlVL1YrSlJ0VDlvWFE2UXZPMGNmSVFIRUoz?=
 =?utf-8?B?K05MTFE1bDdaV1M1NlJDc3d1cy9qL3piS0NlU1ZTcGRSTXpUWCs2U0xWOWRI?=
 =?utf-8?B?UTllclZYWGkzYWovS2U0QzVSTzBvcHBGcTlsMDdkcFcxLzRjblRnRTIwZU1r?=
 =?utf-8?B?bmFZMFFPMlBZcVNES0JCeE9IM2VZQ2t1amRlRmFOb3B2eEZPeFkvTVExbEs1?=
 =?utf-8?B?SHNtdUJwZEt3bEZkcE9EU2FFK0E3QUxqUDhoOEtQaUZ3dWNNTzhtTURlL2wz?=
 =?utf-8?B?Smd3ZW9zazArbGFicHluWHlvbHhtVmpETEQwKzJtbXdxWVNCUDRtMUtjRENq?=
 =?utf-8?B?Q3FsMzRTVnZHMWdzMGJ3QXI4aHFyYVh2N0hlVTdkV1dIOXV1RmRpZElhbzU3?=
 =?utf-8?B?dm43c2NIcXpRZzY5R2lObnlyVENyZjRlWWRnWVFkUXU2MzNtbzVOeGNxdytI?=
 =?utf-8?B?OFFzZWpmMXdqVjNRTjcvbEpLcVJTbzhqTks2b0JHMXhNYktxV3NYOEMwT2JM?=
 =?utf-8?B?MXhIRzA3cXIya21hZkd0L2kvMHk1MkszaWhYaVgxeEwxbmFFNHNMZ3Y5Z2xu?=
 =?utf-8?B?UXB0amJNWWU1d0R1eVlUWjV0aWpLQmxmeXdOWTVDdkZNVHlrRi9QRzlHaHRL?=
 =?utf-8?B?bXVKM082TXl0clBvS3JFSVBBREg1cWdlZ2NvWEVxMnExZkRWcTVWY0tWZkhs?=
 =?utf-8?B?SCszR3lvRUpRS0tKY3JlUHJsMGlWN0VITEJzUFhDTUJwTHFSdWQzSDJLekhG?=
 =?utf-8?B?cThGN0Fsek1CZGpZaThkRTJoRkJUN25FWGZBbUYwUG5yaGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2pjbEU3d1hKQ2pjbEpaTnR1ZkpKRkRtZitDVm1nU0ZzVmhCMGlGZUkxRXN1?=
 =?utf-8?B?NXpRc05oa3JWTnF6RkF2MkR3TXdDcUhKM0FlQkhubXU2bExNMGpYdVlDcHcy?=
 =?utf-8?B?Ly9BcmhZL1hiM1hsWnFmRWcvRENHZ1FqOUtyb0pXN1RLR3VUeW5WUGpFUi80?=
 =?utf-8?B?WmYzNCtjSE00NUJRYlludlNnS3MraGNBeVBEd2ZYWGtGT2hVR0FiYjh5UkVW?=
 =?utf-8?B?dE1GTG5xblhmT2wycDFCMjdwODhDajZkVXRhNzQrTTNPTWo1VmZnckM0enNJ?=
 =?utf-8?B?TmgxQ3hreVRZM29ONldjdjRablR1VlR3dEk2aDhWWk9ob3l5d0xqZ01UaHBE?=
 =?utf-8?B?d3laL3N5UWl3cXZaMG9KcUl4TTNWck5mS3hLeEhNNndkTENLeVMxcjBCOE5H?=
 =?utf-8?B?WFZFdlN4TzVydXA3a1RjNDg0L2xkMmFVdDR1Wk5tOEFSRXhSNUJCNzZCZGFX?=
 =?utf-8?B?cFdaZjI5Q0ozeWtQOFVIUTRJV3RsUXJyejFaL2J5M2lmSFhiWW5GTTlwVW9y?=
 =?utf-8?B?c1lGajRZNFJBVys4ZndidGFrVzl6aW1TemVMaUt2UndKbjNpdGR3OTNvdTl0?=
 =?utf-8?B?RjRzY2xUbTNDeFFQRXBRb0pTaWszOGxibVpMbFUyb0FIZHc3RTJYaWcySHoy?=
 =?utf-8?B?QVNsU29lcWg3Z0xUYVg1TUZ6UTR2NllGYkNyRFAxWkZZQ0x2UWUrbjg2M05K?=
 =?utf-8?B?cVB4VWpmYmY5QVhibk9saDN5K25KdHZOSXNWK0FmYWJFTi9yTFhCc1hQRzdK?=
 =?utf-8?B?SU5TalBjandLVWxHNm1Oek1vL0ZpVkRqK0s3b1cvdjM2c0VYdHliNlNabFh4?=
 =?utf-8?B?SVA3azR3R1FpZDNNWHhOVzR1VnZtUnd5ZjIzd090VXg5YVVqSEtqQW5STmd4?=
 =?utf-8?B?bldERFFqa211a1ExWG5WTXJlWFdIbXYzYmp5ZWxYeWx4eUtLeE05RjhXbEor?=
 =?utf-8?B?VUtBQWJJYmhoYUVXRVRmQ0NyS1RENU53NHRCN3Q1TjRsRnNsQUc5RWF6T0sz?=
 =?utf-8?B?bjhER3lNVWgyWjl6UXdVWlhkemk4dngvN214bGlpSEIyZjNNWGE3eFA4L0pR?=
 =?utf-8?B?bGV1WVAwTkpQdWtBWGNZWDBLU2hkemJuR0VQMnlLeEVpWWQ1bHBWYnd1L0hS?=
 =?utf-8?B?aVRwU0MyVmJjVXVLd3d0U21BZFFPR1kyVXZFeEVGNzhnRGNnTDhKK0RlMkNu?=
 =?utf-8?B?Q0x6am9qa0xLeUlLRkNkZVRwYzhtQXdKYVp3U2RxKzJtT1ZEUENHQ3hiR2hr?=
 =?utf-8?B?SHhSWTY1cHlKdUNHVmFoNUhRT1pRNkVkd0c1d1NodGVqTXQ1WFp1cUpHUkNh?=
 =?utf-8?B?WXBGditCNnNRQnNMbDVJZVF0OEFQTEZlMldETm1DbENFTkxGVW5mNE1xSVZX?=
 =?utf-8?B?aC85cHhSMmQ1NDdoeW82S1lCVnJsQnEyaUw5S0lxZjBaMzlEQTVMdjgzYlpw?=
 =?utf-8?B?K1Z3QXZ6N3ZGUWF6akNteEJTSy9CandaSGl3SjdZVGRzS3BFY2ZYbVhYTXp3?=
 =?utf-8?B?cEIzWW9hM0hjRXowUHVqQ1lFcTZrT1JDNFY1Mk83WG9NYUlWcGQwdjZ1WFVy?=
 =?utf-8?B?NHh0YkpnY0ZRT0VnT2hlNWZidmNNbFJpOW81OTE1eFVHcHBIOEZlVllNU2ZI?=
 =?utf-8?B?OThOZytielEra050U0xTMDF3OTdjTk5saTkxMXptc1lDYXlpZ1Y3endndllh?=
 =?utf-8?B?RnNzTHpleFp5dTM4dWF5dk5lY0NNZ25sZ3pCNFkraE9iamhYa1c5cW1uNG13?=
 =?utf-8?B?MVVBL0pTOTVzeDBRMUMxQmtQVDBKNmJiV1k2dnBrbXBGMWFteDlQNnlLWEZH?=
 =?utf-8?B?N1c4UkR5cVNLVE9XNzM1cHIzanNobFoyL1NHa3lwVmhqNFEyY0piTWNiQVEr?=
 =?utf-8?B?dWFQUGVHbGRSNEZLTjd1WDJyRXhxZE9ON3V4WDIreEF2NFNNU1dpNFJjK1NQ?=
 =?utf-8?B?Y0RqSEFza2pRZ0VLMXYrNndjK1pzMWE0NFZJZGRVVzBtVmtxQ1ZKZE1PeFNo?=
 =?utf-8?B?SUpoUnQ5dkhrVFpLVFk2TmZFOU8yb2VjUnVGNGM2bVcvU21KTEQvS1B6ZWZE?=
 =?utf-8?B?dCtlRVlQRXdvUEJZZjdQV0tYRkM4czkyeGo4U2kvK2lQUUFBekV6Y2drVEZO?=
 =?utf-8?Q?3sjBr2FNgyytDWz171J9m5aWK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1240b0e0-c7f4-419d-29c1-08ddb7b38499
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:53:01.0986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T03Hq/jgtrlbloGEM1iYOE3uRQEwh6DIp77JUzdJSSlwPpBlcvRlN7IByI+dsX4e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597
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

On 27.06.25 05:39, Alex Deucher wrote:
> There no need to save the ring ptrs.  Just reset them.
> This cleans up a conditional in the resume code.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 27 +++++++++-----------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 5a1098bdd8256..5f4c6a99b06dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -680,12 +680,11 @@ static void sdma_v5_0_enable(struct amdgpu_device *adev, bool enable)
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance
> - * @restore: used to restore wptr when restart
>   *
> - * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
> + * Set up the gfx DMA ring buffers and enable them.
>   * Return 0 for success.
>   */
> -static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
> +static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i)
>  {
>  	struct amdgpu_ring *ring;
>  	u32 rb_cntl, ib_cntl;
> @@ -713,17 +712,10 @@ static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>  	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
>  
>  	/* Initialize the ring buffer's read and write pointers */
> -	if (restore) {
> -		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
> -	} else {
> -		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
> -		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
> -		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
> -		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
> -	}
> +	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
> +	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
> +	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
> +	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
>  	/* setup the wptr shadow polling */
>  	wptr_gpu_addr = ring->wptr_gpu_addr;
>  	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
> @@ -751,8 +743,7 @@ static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>  	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI),
>  	       ring->gpu_addr >> 40);
>  
> -	if (!restore)
> -		ring->wptr = 0;
> +	ring->wptr = 0;
>  
>  	/* before programing wptr to a less value, need set minor_ptr_update first */
>  	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
> @@ -851,7 +842,7 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
>  	int i, r;
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		r = sdma_v5_0_gfx_resume_instance(adev, i, false);
> +		r = sdma_v5_0_gfx_resume_instance(adev, i);
>  		if (r)
>  			return r;
>  	}
> @@ -1616,7 +1607,7 @@ static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
>  	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
>  	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
>  
> -	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
> +	r = sdma_v5_0_gfx_resume_instance(adev, inst_id);
>  	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  
>  	return r;

