Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC942C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 08:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A66410E7CD;
	Thu, 15 May 2025 08:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qkz2nz+B";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301A810E7CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 08:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spemsGm4JSueqqmxKxE4qGRCfD8pkK0hntaL/BkKKMRbh33ZwCMD1Bij16MFhQKBQLYQqo48gkIwUhN8Rl01c15lrh4EovY4n4g8NedAfEiGN0lmW3+tWyCgvawgpBW7pglFoV/l5aj0RTwvt6eJ76wn45Kct3h3yDoGDjeZvXSus+dnEBpE04gfvozhuwZEfue+y4lqvKz1MqIAK2D9oJP39yY6YHizdVopvGIcM8cIMwh96d35Gp7+pi2hO72bDK6I1bgn8mZ6Xt8kO67CXi428xB9iFDslAJ/VlrOXCCSMlzmXQxGq30iUwQv0Ky/D9wFpVSMo8QFreLRhSMO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vi3uYWGdSwaQtxplpsgrf5hRa136v7Y0x+sU06LRXEs=;
 b=IUVgBwNfiKy2JpZO06BSoSEj0RPVLwHdXsZWbDDVEEUEZMcH+Mro4qFQloDo6WA96MNmHdUCulTONAzDiHnCcXJ5wm+nMNMJeRM9IkX3skoyihqaEZ207c2D8NfAXBtMRdiX0tLtygHgU2TqcXiPSlVTMkaS/KMFsQtFg2V02CPmi/4zRjVKXKUka72IzQH/cAuSa7oZ7/Jv50bto7HHNgbQY7nQfQvqBcG9qTVrMWsFwzFfveS5lt1dh9+1KDsXWGUa/jDGJFOZ2w8Prp1ao8GiH5P3LuMmzgfSQB4Hd7eVeDSEoTufcrQLYxIYLG2hwYjjmBnQBYhuTRimAZ2zcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vi3uYWGdSwaQtxplpsgrf5hRa136v7Y0x+sU06LRXEs=;
 b=Qkz2nz+BO+au/RozP1trEYC0YQ6LdAwBxk2EQpeq+bbDKw6CYzqrSV2XElLyUl/9ctheQvQHGVybKN1y6gyxZay6xQDCJ9PsMkUwE1Tp7s4J/zAHFGrhEVTwWtLfyxjRBS/PvmMa3DmxnOmdsYSj3c7VvY/yLwlgjFsx6hJxZ9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 08:59:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 08:59:49 +0000
Message-ID: <48295677-5471-4780-9dc8-c8184c3802f5@amd.com>
Date: Thu, 15 May 2025 10:59:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix use-after-unlock in eviction fence destroy
To: Arvind Yadav <Arvind.Yadav@amd.com>, alexander.deucher@amd.com,
 sunil.khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250515074957.2830-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250515074957.2830-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0382.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b048cc9-8c83-4d85-e732-08dd938ed8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkErNDd4UEI1UTd1M0lvcTB2dm9MTUFxTnhhZCtQM2oxOHJyS08vS2tUM1ZW?=
 =?utf-8?B?c2Jxbi9rc2p0SktSWUhQU1VNMmlvZUV0KzJZM1c0SVRMR0xJOXlzb28vQTY4?=
 =?utf-8?B?Q2ltVyt2dmhScGVWYnVFRlFXUkZDSUtURVZLdUsyVEpEak5GdERMUzQxZXZs?=
 =?utf-8?B?bGhJYmN0NG9Cc3dIc2JTWFdscGxtVTRFNjh0Y1BXUTBVajM0dCsxYWpJa2tU?=
 =?utf-8?B?bERJenRCcHRrcW5wZmVqdmNjc251bDlkMXk5TVFBRGlpMk9RTDVHRGZ2b3gz?=
 =?utf-8?B?NUg0UHlOdGhPYlk4eWptLy9STVN5L1FnMlVFTlJlOHo3S0cvWHFOSEoxVUZm?=
 =?utf-8?B?RlBvRzc0bDlqbGNkeGhocERDMnVOVG5HbTVIMlVBRVhPRm9GZEtkakJIMGR6?=
 =?utf-8?B?KzVWRXdhMFRWQVZjUVZtZ0p1ZVFHUFJjS2NyUG9laXplWkpLQVVBVXUrc1Bo?=
 =?utf-8?B?cW9MT0lQYmUxdG9VZUtQRmxRaDZaT1IxSUxZUzZnSC80V0EwZXlBVjZvdEFt?=
 =?utf-8?B?dFJpbFNCdGQyMVl3U3AwWFY5eFdKbWVyTGcrSS92YzlmSzNQc3pnNFNZYlZl?=
 =?utf-8?B?ZERZU2J0aU80RHRyWjd6b2hUU0xEUUpGZm9PajdzUEUrU21aR3JkWitSL25G?=
 =?utf-8?B?OGw1dU9qdzlMVGJadVFKT01sQWl2dUU5NzcybThjWnlSR3ZXVlhkYVgwRGQr?=
 =?utf-8?B?TjJjYTlHQmE4T3hwTmI5RVZGZzFhL21zZjVyZkViWDUzVlV0MTVmbzQ3czZX?=
 =?utf-8?B?WDZQNmhZWGlvN3E4cUV0U1lRTzRTTmFoejB5T29XdStWV3lnNDlxUjNuSDJu?=
 =?utf-8?B?VlE3dk9tUGJWLy9pVG5BV0JPK2d0MXVSckdHQWIzc2NyY0FsdHd0ZHVsSG82?=
 =?utf-8?B?RzRrY3A1QWNhSGkydUFQSm82Wm41c1UyZkpVVm1OVm5DMS8wTHl1R0hHR2pr?=
 =?utf-8?B?Nm1scGlNdXpQR0p5ZW1pbmxEdDFuQUp2bFJCWHdKV1o3ZENmb01Xbm9aeGF2?=
 =?utf-8?B?WnQ1L0EzUzNjZEVkV0p4RUJTeVhzRFhZa2h2WkNaSkFWMjByUkZVTU1salpo?=
 =?utf-8?B?Z1RsdGdLSXdxb25WSWJCcTZQa3RyZ0xhaERCZTkySVZOWGl1Ym1QT3pGdW8r?=
 =?utf-8?B?TzAzcURpbGlyWGt2TXY1UkJ3Z2RHRlBQVmVRcVlmbzFPR3VDd3FHb0JSUll0?=
 =?utf-8?B?dGpIenprUDRNZEswbVVYeXJyb3JkODU1K2IrbzVQQ0d5Z3NyWG5VU0pSKzEx?=
 =?utf-8?B?bWNRRnRJS1RDc1NScHBrc3hHOTJuZEFYZ2xzU1RyWXdtVUlZSk5yRHRRazhR?=
 =?utf-8?B?RkdRTGdOZVBLbGdxRGd0ZHN0NjF5aFMrd2xIcWlOMzBuMDg4c28zckpDN090?=
 =?utf-8?B?Ym5NY3QydUtXd2pBakFQZmRVWUhHUHZGSUNyRllzQThCakpUeENhODByL3BH?=
 =?utf-8?B?MUFWRThYWVRMeVlnRURtZ3JvSnBGVkYreW5rRkpEeGFENlBQejVhOVlaOHk1?=
 =?utf-8?B?TmIyRmdqYk1waEo0cGNUWjFzd3QxSTd2dFdqYTdMSWZnZHd4VUlsR24wQUlq?=
 =?utf-8?B?OCtSV1Y3OFBML0k1VThrekJmZi82bTdxYmxDcDl4VStNMWlCaENCUUZ3Ukh5?=
 =?utf-8?B?b0UzRGdXYSt3RVNCMFR3UTl0RHJzTUh5SDY0bjliTldnM2tPZ3NSRHIreERX?=
 =?utf-8?B?M2twUVRFMi9ZSkJTUnR3TEx3Uk50V1daQ2RGTUFkek8yajkrcDIyKzl3NzZN?=
 =?utf-8?B?RCtyLzg3UDVRMTVPYk9ob2xWNEV5OFloTHRobmd3RnBXS1dUS3hnODdjNW1X?=
 =?utf-8?B?bTVDVFIvWE1vQ2dNbVF3YzdpRkRxVkd4aUFuTEpZcUVvZWQ1a1VZTnk0VW8z?=
 =?utf-8?B?dXNndzFTNENYeWNhMTI4eXlhOGhJVFoySFI3K016ZE0zTWtQdnlUcE1sdzR4?=
 =?utf-8?Q?D7kBKFPUrCM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGdZR1VVMEcyZG5RTzhhNjF5ZXZmM1ErR1hQUUNVY1A3QVhHU0RBYzlzQUpG?=
 =?utf-8?B?Yld6QzZoUVJyQS9xd2RLeWM3N01nd2hOcHUwTkFwdi8xVUZxeStBMFdyNUd4?=
 =?utf-8?B?UDBhYlNFdUdDY2FPOVlwYUZGdWxSS3F5VEorRnY4OW1rY1pSaldLM0ExR2Zx?=
 =?utf-8?B?RFg2eUdua29id3hKbjVQK0JPWHRiZkdtY1lmRitiTnkxOXhyRUViQ04rK3Z5?=
 =?utf-8?B?VDZGdzd0aVdZSzlJRTYwNm5NbklwWVNDS1JHaWtpR1ZmVEFncGF4cDdmb213?=
 =?utf-8?B?STlrS3JYZnpMTUtQQkhaVUNpazlZdWIyTEY1a1Ztc3Y5b2UvSmV0bFhiSlhC?=
 =?utf-8?B?aEFoVi90WEIyT1dGMGlEQmRFM1N4Q3NWRFFITVVvZC9malRGZ2EyK2ZlK0tH?=
 =?utf-8?B?aW5OeWc1L2R4MUFBUTJKdEFTSEVZMzBuWVJ0am5HTFdMQ1N2NTdMSTc1azZM?=
 =?utf-8?B?MlJ0T2lrTWFHaTdDaFdLVzNpZktHVlpvaUVndEtnL2NJb1JibU8xWlVVQmdk?=
 =?utf-8?B?bGdSQ3VKUlJqSkttTCs4SjlzUU11c1BLSDFwNUszZGFxQXdKenZhRitYNk9Z?=
 =?utf-8?B?KzlGVUowdFFJRHlRK3hKTmxWZlN5RWljM2E1TnhZeFY1N3ZrZmlsMld3WE9q?=
 =?utf-8?B?dTFIVjdxS09sS2pTRXg1b3hrU0tUenRybUxwS2FqOHc3L0U5WmFsYWJKQ0VT?=
 =?utf-8?B?TWVYWmFMejJKZSsyT2EyOURYc2Z2L0cwdzhGUTN5cnVjYnhlNVIzdWdoZiti?=
 =?utf-8?B?VGJZem15SFRveHRjc29CMC9LTnpsRHdOclk3SkxaRFN5TDZRZkhGVkl3T0Nx?=
 =?utf-8?B?bFIzckFoV1BnS0VFRG9qc3NuK3NJYitlMnFWWFRKTmZZUGxkVXFmbVpvV1h1?=
 =?utf-8?B?cXh3RWw5VVFTWUN5ZWlSM3RiN01OYVd1dk0xNlB0R2xyV0UvVFBEUVJ3bzRR?=
 =?utf-8?B?UnF1SEUwTFV1djgyc0d5MVJDSzYrTnQvb0RrUmZLK0ViQUJBa0xMWVovTmtP?=
 =?utf-8?B?dWl1N00rSzNMajBZTTlrUWZrUHAveDN4S1N5N2p3K2ttS1VQcUZFRi9rcjBu?=
 =?utf-8?B?My9qNjEzR3pnaWpHekNwa1ZoZndVaHZVazk3WlhQcGF3OHNOKzVwRERSdHQ4?=
 =?utf-8?B?R3JxRFN6WTNwOUV5bEZPdGNHRGpXczhyZEdiNURWOFFKTmhtVlcxeHVOVDZL?=
 =?utf-8?B?SXV4ZTFVRTdCYkxKcUxUSWhYZWNlZzNqQU5paEUyK29BdGR6bzVvcFFlU1Ez?=
 =?utf-8?B?aTl4d1lhTjFwTXAzOTJMMkhqSjBXOUsrTTdvYXJ1d0VhcDdJRnNmMzhnMnVh?=
 =?utf-8?B?d0pPWnFSZ3FxYmF4WEwxQkgrblBodXEreitWdGgrSkNGYktpTkt6VVVnaVhz?=
 =?utf-8?B?T2ZOeS9KY090U1NxdnJEaC9mY2w0dWozWXpYVk5xWUxzZ3pzSGN6WEdWSHpX?=
 =?utf-8?B?RGVpaGhpVGlHVkhkMVpEV1F4anhKcWFLZ1ZrcUcxOWNSbmlVRWJPdytXS01T?=
 =?utf-8?B?NmFoYXNPUE1PZk5ETkwyRzQxTkdBNmgyNm1FQTJicnNaQXo1VndZVmxjamRF?=
 =?utf-8?B?RzBObVBMc0ZyM1NkbjFmUmNsZDlRa2dCVlRnTHIzZHY1S0grbnRNZlFJM0cr?=
 =?utf-8?B?blZ1T2d5ekpUYXVNb2xlaXZ6S0VuNExmKytzSThDekEzbUtMUiszVTgzVzFn?=
 =?utf-8?B?YjVaNlFvRm51dFlhTTN1STgyaXpBV3o2WmhIMENFdjYxVkJ0K2lJZnpEY3JR?=
 =?utf-8?B?bU5yU1JhOVM5YWxRZnpQYVJBaVBrM0JsVEdndVFtYkt2VnBPSk1ISERCMmJt?=
 =?utf-8?B?OEZodkJpenk1aUtRYTBFZ1FwdWs4R1R6d2xuN2pEWWpad3lrYURmR3FFbVNQ?=
 =?utf-8?B?OGRXUVhGRXJ1KzVLWEY5NmtKZXpTSUEzMlIwcUQ3SW9ZY0Y0S1pjRmJUaS9p?=
 =?utf-8?B?eEFsNGN0QWVXWTNDcjgwOTkyTHJUNTBnRTh2aDc3Z3ZOaTVBSTJUVWxYTGx0?=
 =?utf-8?B?UFdDcTdDSEF3TnlYTFJ1UDJQSWwvcUtCck9UbkpLQlZNdTgwaVFBTFBQOXZN?=
 =?utf-8?B?clNGUTdiUXVqdHNacS9tSGxtdmQxQjFpYW1DOHFYeWt5eWtua1VuY2xxbEV1?=
 =?utf-8?Q?iVGMzKyW8k/Y76DwxkagDxAAD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b048cc9-8c83-4d85-e732-08dd938ed8da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 08:59:49.1046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTWNVX9GZ7eFab/2JUvl3+R+Db97SFPu6Oj0NklhzPR30uuEkCiK5SnZZQNvec3A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562
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

On 5/15/25 09:49, Arvind Yadav wrote:
> The eviction fence destroy path incorrectly calls dma_fence_put() on
> evf_mgr->ev_fence after releasing the ev_fence_lock. This introduces a
> potential use-after-unlock or race because another thread concurrently
> modifies evf_mgr->ev_fence.
> 
> Fix this by grabbing a local reference to evf_mgr->ev_fence under the
> lock and using that for dma_fence_put() after waiting.
> 
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 1a7469543db5..73b629b5f56f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -183,7 +183,7 @@ void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  	dma_fence_wait(&ev_fence->base, false);
>  
>  	/* Last unref of ev_fence */
> -	dma_fence_put(&evf_mgr->ev_fence->base);
> +	dma_fence_put(&ev_fence->base);
>  }
>  
>  int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,

