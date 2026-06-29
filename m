Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F119BC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 14:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85CBE10E945;
	Mon, 29 Jun 2026 14:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zmNB5vZ/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA0610E922
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 14:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJFSxAHyP4ievOB6ZF4kgcQ1cboiL1qB4uncB8kUb8iArxzGGI9htYDc7m1Me8EWjFcvNWP5jObYiXjF2nJ3EttyjGZDliylXJFyfRAkJZkDk79DvkUaWjTkVrNx9oNFqtsYZN94QW4ATqZcoY9rr6IWTWmszzXzAMD5Z0MmDhlPExrehRi/GAh53nrNtFV1+tQgnSP/gfaJRbU+j5YRqjWb0O02xEbduVp3PrfYH+sXH4uoUgiiWRscAx/OhYW9L55sQrsHmoou5ukyPHd3SYRhsQTcqf6+3A46c4L1uR951Bn8/WSUmdfWmV/zKZD3DxqIVJPj+ln5+83Rxl4wlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF3wMzDjGjLF3W9HDARz2cQQzjUxtcwWBgQZInOureE=;
 b=DZTI5Hsn/gcOZ17yRcEUwViWPZXF/iURNoGMgjf2rrKI0jJHt423QOe7WqQbYSZrXo+lvXUNSekS1MNL0nnanfpAmIDwR01dTMPFkxmXgrzHogtj6G/b/oHYhAFy9cq220Rk8qE5P7uWpEqORxK0+xc4FyO1ZgSJwUd4a1/6gY/9mqLWkqYoSxJIKfzfkdQeIfG3NHtdWbWxGnwKmoDjnI6KXHoJpbuq+qOi1nTUgx7QT9q4iYQdidaI6hJVJxUYn4tVxHSgENYD1h0fDXxWMl1taG9pETkzsUc+ny+K3PuPOSXMmu4P5YZ4thNR2D+2jH4JKyQ2TrAP4w90m29RUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF3wMzDjGjLF3W9HDARz2cQQzjUxtcwWBgQZInOureE=;
 b=zmNB5vZ/hiDM+sb/Yocmg9J4hJ7ZqVKEDXpzwRpYiUXRIuKeNZgLEd3harOi+hh3lIlQUoA1ypp4eYEY6hWbQxZlOBgJZTEqRtKK2TgAkHiXU5CpzPdm918eE3ZTqNYJu1ZmhPdyFOyyXbYoTgmA4kmyjmQAGwTwLicI5/uHLuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:33:27 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:33:27 +0000
Message-ID: <ba973155-8942-4e4b-97d5-486b3410d5ab@amd.com>
Date: Mon, 29 Jun 2026 10:33:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes: Fix hung_queue_db_array loop limit for
 multi-XCC
To: Geoffrey McRae <geoffrey.mcrae@amd.com>, alexander.deucher@amd.com
Cc: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20260628055701.1561570-1-geoffrey.mcrae@amd.com>
Content-Language: en-US
From: Amber Lin <amber.lin@amd.com>
In-Reply-To: <20260628055701.1561570-1-geoffrey.mcrae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0328.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::18) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f97bb8-4772-4f2f-43e7-08ded5eb61bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3cRFFD+OsscpDlT/2dL+xTA6wPdJ8HBkzFQ09VFsQOt4dT4uCw+aCIDbFheN+HkO9P6KgBD1iFTOUR7nXqr4k5khW3ZobIAPIqKe3nCnLKT6ewlLL8rV19FjnVjWwcRhPRnt8k9dvZA4FA1WV04XO2BywpgNaeGx80sjR/ashyulgSX08/VrSdSJq2oVazZqm/oSRAGVMcC/tbVBUuBrUWxxXJF8hafxXFO604ys5JcB8mOmu55mSIOa2BBJWbnWu3O1l1BdIJsvamu5SazGRXz6uLmAM3uu6v5OqYJRbAjTw05R5lRjglM4r8O4c+tcnRfJ40Q0kXHrHRmSYKFQwwrwpPN4y+QDRZSWK+DGyLte5c1kcEXHerT625Ep7FfX8FFmXx4wA/oP5sOO6p5SrQ3iNn6olMvex//GEnP6ruofeRMbqC66WRQPND5VMA/SvU5fYHu/h9ncAR84B/6uU+16y3ONAFY72O6ZCx6TxxzBwTIi07HmorBuKO3ZC5Yb+H/W+Gvetmt6bPyFwhZ+X7KHuQKkV9LKjoEkN4soabcw14eJdwEG+AFUME2FhOOvDngd17dFbzSGooLzfUSaUBGh8tVLyOCJocZEyusOJp822MH36CFZiKWN6XKdUDoXAXoRi1ZZenLisAkoZ9a+hZ5arj21UqbgvNlYx5NPHC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJRZTJFYlZqK3pPUUJaNjlDTzJYcXhxOHB0SGE0RmhSMjBSZ2xDK09yekFy?=
 =?utf-8?B?Sjc3bzd4dmtOTWo2UVZmQmZ6eERRZ3htaDRueWRFdlRPSGFtMFRodVUyRlRI?=
 =?utf-8?B?bi92N2VENmhZY2ROMWlvYnBBYURmZUNFelhhcTRyczVmUmNqYWF3MStQR1pF?=
 =?utf-8?B?YUJxU1k3dTE0cElvWDMzd3lsc0I1UHpDKzBpeWxzRGtKZU16VElJV2hTbVdt?=
 =?utf-8?B?NGxHbGpyUmR2eEVGQ091YmhTK2duajBza0IvZ241VHdBUFpXUmo4blJsRStT?=
 =?utf-8?B?WHVPTlBvMG9EZVI4TE1sb0VNN2ZDZmIrWXNPQ3dYeVhCbVdWVllnVjlKVlhl?=
 =?utf-8?B?cU5SOW8zRDJjTFBlcmt0SzlqcnBaQ0twUWVaK1diTmltTzBoRkFsaHRib2lo?=
 =?utf-8?B?cC90OUY3MURKa0lUZ2lxNG1KeHNmL0N5Tm8ydHR0SnYzc0hkb1k1KzBQaUZF?=
 =?utf-8?B?MElXWkRwcW1HbFpsbTl6U3hZN3kxcktXbEMwa1FlNmFVNWpEY3NxejF2QUR3?=
 =?utf-8?B?UE15VzZyMlR2UDFTamNOdENCQ29pcWFGOG4vU2htYkZlbTAwalZHOGplbjJV?=
 =?utf-8?B?UWozS3M0VzJPblorc1lHMENDOE5BYmE4azFwOWprb0hDZlZmV3VsdTRhclJa?=
 =?utf-8?B?OGNwcW5PZXM1a012N2syQXNoNUpKb0o3OG1JOFMzOHBvK2FWamY2SGNZTE53?=
 =?utf-8?B?MWdRWi9Qbys3S3lLaEdSeUNGcVByT3NrRm03R2Y3U2thV1BpZnZJdFVRc3Mv?=
 =?utf-8?B?bUpvMVNVYmprR3hQbElqb05ScUwzUWZ2RnJydkNaZVdwRFFNMWZKSCtkWXBV?=
 =?utf-8?B?WlVRQUFPVS9DRy9kVFdaZUdJaGpWZFExOXZ2Z2gyRVd3dXFDY1NjV1orY0Np?=
 =?utf-8?B?akJZenJrTkJ1bjRxTFNUeFZBb3lGbFp3cUxpSVdseDJVbWNrUTZ5cUVVYVBS?=
 =?utf-8?B?Nnk0OE5jWXFRS2ZINEVxejc3dzZEN1JZL1dUNnZkS2NaZmtCSDd4OG51TTJC?=
 =?utf-8?B?MkJHeUowcnNSSEJMRWlqUHFpRlRyS0FOWTFHRzVpVUk3Rm1aZEU2cjkrbWZZ?=
 =?utf-8?B?d1UxbmFLQTNDUkVKaFViemxFK1UxbjhqZUhyZ1pPQlBpeVQreFo4TWs4dEFP?=
 =?utf-8?B?RzMyQnpmUkt2aTNHbHlYQk13WFpGMjNFSkJWOUJsanZDaWNtTWlJVW9KNjNi?=
 =?utf-8?B?dmVtZ1kwdlRMU1JWMERxcDZTTnhiYURCalJjVkxKKzRYZzhBWHFPOFFOK2Vw?=
 =?utf-8?B?YkVjYU9LN0JSMG9qcUdzZ1BlY2piR1gwUHJZVUV3WFB6dkxESkhwZVJ2bjlT?=
 =?utf-8?B?ZFNPNzJkbk5mYlVRWEpIZ3RsUVB5NGljcU9IS2pVWnpBV0s2WE1WbDJWR1RN?=
 =?utf-8?B?TENGbFVLTzRRT1dhL1B1TzU1dkJSRGVCbTZkV0N1TGc3MWRqTnRMVE9EWlBC?=
 =?utf-8?B?dFp1dmw2bVRRcGpBMytCMlQ1SnpZTmU0dzZrUE9GdlVKR3dzbUxDWHBQMERL?=
 =?utf-8?B?U1REdExDd01YU0VaN1lHY01uMzg2VDlGemxOTzY0aUFzYjB6K0RBTDBkUWFh?=
 =?utf-8?B?VG9UQ0xRakFGRGE4TTNRNjlTd0xNN1dyc3J3b0NYcThuZmoxcWFER3FmTnZR?=
 =?utf-8?B?Szg3T2l5cjN2dGRvOUdJd2dvTzVqZjFGZGhHU1hSNlVMdjMydkRsRmM1ZklM?=
 =?utf-8?B?VWo4RGRpaGNvMlNFM1dyc29GbGphRzA5YllIZi9STm1OYzF3YVdieGxJcGVo?=
 =?utf-8?B?aGRiV2g5cG5hdFpRYkpGcTVoNWU5U2lJZUtBbWZNVVVBemlKRkE2TmVscE0r?=
 =?utf-8?B?TUJqQWY2RkRWSjZObG1kUENyK3JLdW1haW9hNWQ1SWNNdFp3Yjlza1h4SE1z?=
 =?utf-8?B?Z2ZoS3FEWEZaa3NxSG5BVkJQZXVtNVlKT2JERkc5WDZJeHV3ZnVpMTNmZUpE?=
 =?utf-8?B?Z3pMdVhkM2wyYTdnOFdjdHQ4MnZuZ1BXYU9YN2lpLzYzSWFzWUhtaXZDUDZx?=
 =?utf-8?B?V05aQTdoR3lTNzZvU09QYWhoZ3hudGZvVkRseHcvZjVJWmxnQUlDcVYvajZ1?=
 =?utf-8?B?UFoyRUhUTHdCOVlhUGpaS0pMdXpLVkpvVFRmN20rbzBjVUhHU2Y4R3RFR2Ju?=
 =?utf-8?B?bGY2aEpONk5wWmYvdytZaTU4Q01qalV5MmlvSGEyUmVTdEFIaWoyTGxBaTV2?=
 =?utf-8?B?YXJEbjY5N1BndStrdzRRb2F2NTN5SkpGbW1sQmdsS2JEa0dYVU96a2pFNXk0?=
 =?utf-8?B?T2lLSDZST01nbmZxMUNBREgvdTUrWW9FNGVUcituZG85b0lTb05jTVNMcnBl?=
 =?utf-8?Q?PWh3vlz2MrmSqLGcNH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f97bb8-4772-4f2f-43e7-08ded5eb61bc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:33:26.9473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTfv5BAwQOzZhtvdY9tGu92yGss9kIXKfCiT0PnfblW8n0JDA9lSuL6HI+eVH8I4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
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

Reviewed-by: Amber Lin <amber.lin@amd.com>

On 6/28/26 01:57, Geoffrey McRae wrote:
> The loop iterated only AMDGPU_MAX_MES_PIPES times, leaving entries
> uninitialized for multi-XCC GPUs. This causes null pointer dereferences
> when accessing arrays indexed by XCC ID >= 2. Extend the loop to cover
> all XCCs (AMDGPU_MAX_MES_PIPES * num_xcc), matching other per-XCC
> arrays.
>
> Fixes: 723b3bc87afb ("drm/amdgpu: Fixup boost mes detect hang array size")
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Amber Lin <Amber.Lin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 6c0dde3786e3..6ec4f1d537d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -237,7 +237,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   	}
>   
>   	if (adev->mes.hung_queue_db_array_size) {
> -		for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
> +		for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
>   			r = amdgpu_bo_create_kernel(adev,
>   						    adev->mes.hung_queue_db_array_size * sizeof(u32),
>   						    PAGE_SIZE,
