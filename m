Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03F2C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 18:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735CD10E0B6;
	Mon, 14 Apr 2025 18:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AseaXOAe";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59B710E0B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 18:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDlRINf60V0dOba5JOGnXO/5qmcQsLlv1IuCWVXQ/nQ8ZNq4pL3cVGXKEc+J1yEqn87AHaYiZirpwkDeXvg3eS/cu7rygjHkrIlNSBxR7UHTpLcZal0nnd8SY6MKQN3QS279Ws3XomWONEbL6CsRW9o7D0JrEM7GkTC+LxL/gCFTrzdiNmTTspcFGB//liVSdIBU6Mvf19gCbg3rBzxca2XwI4OLzv8YTx+3u6HIQgkJzxf3hv0mrondgobtxiopVqImmGOHNmMz94tcaWuralo7p+XgOFJj+h7r1itAkTL6v9if623JgpskdtE3myP7/e0P9Co4n4aI3kKM+gHE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NiY826OLq22rlPNAfpy6D2Pe8PQuQOv5SZ8ko/DAbY=;
 b=usk83Z/XHTfD7RWRO3Ea7+ZGMg+zxjiPpmbcYSFgDkQ65Thy10kyPuvYn4SUNQIt7p2Azub/f4oBc7xa7+Pbr8PgBmpXlVVfSnkEsaunvSsD7RUtGN7dhcuTu6ngkdkSChocx9YUCr2PiDy4t3nd/ZcF12mr7g6CupLU3UT+JIAp+b3Lr5Lkxe5HSZA+ZfWZeavPjfOOMVovZG1/EqQ+o8l3E9s4B711fgEcZMBa4EybtBYc6AQNAwgmZJ4NuoOovHd8EaJsMyGO2ITDysmVX7GK8wiKckubIMhIUfQSwdsOxSD5pbZ8F20ZxFehds4O6zcophTX1Sbg/Ja8xqds4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NiY826OLq22rlPNAfpy6D2Pe8PQuQOv5SZ8ko/DAbY=;
 b=AseaXOAew8Tr/e8kuZ5G9gbaiXH2PjwMr2P7cFkC5ezN/WMYKlNOUVBDKZGROfy3qKnvfLgHqEZHRuZXG/ePhZ5HTCXXB7V4batFJcQdrEs8t5lFXCujGPHQz6fQh03Bv0iLO43eSms2t3jf8s3PHD0jX/LZnTQrMiLLiOn9kjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 18:23:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 18:23:49 +0000
Message-ID: <3eb190e3-dbde-4776-8a98-bbc02edab048@amd.com>
Date: Mon, 14 Apr 2025 13:23:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add documentation to some parts of the AMDGPU
 ring and wb
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250412203757.3026858-1-siqueira@igalia.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250412203757.3026858-1-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:806:d1::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e826ab-d6e3-46b8-6b68-08dd7b818076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkpXVjdna1FWQmJuRWNqZkhtRHBaU2wvT2ViY25lVTFCMmw0YUMyaUpKVU5Q?=
 =?utf-8?B?YnMvTERWeGJxMndBVUsyMEsraFhmWGYzTkU5WW05M0VXZnN3RHJPR2dkdTBK?=
 =?utf-8?B?V0ZtNHlDN1Z0SEMrVStVbVMvTFhjd25DWDFpMkhJZnFENFFnQjVnWWlLem1u?=
 =?utf-8?B?aWNmcEtIT0p0Y0s2ZmxIZE5WZFAvTG85WSsrWTlMbFFQZldzd2VHVTlQNkVu?=
 =?utf-8?B?Qm1nY2llOXBhSXFtc1REQzRNR1hkQmloZGxMWWNVOEhzSzlSUDI4TDNPbnc0?=
 =?utf-8?B?NkFxUForK0VyRjVXQk52bWs5VUozcnhLOWo4Qnd1bjZTbXRxdlZNU0x0U0VR?=
 =?utf-8?B?enozekhaNzlxVVBNK2JIeW9lWjlFdHVjMHpTNHBsRnFTN1dQRG0yOXkrU20v?=
 =?utf-8?B?dnNBN1gyOEJvcysxeGpXMTdJNHNoSm9TeWZlVVdicmx0MHVjOUowN3JvUkxE?=
 =?utf-8?B?Q2U0VlRRUis4MVdCRjBmMytHa3d3VWtuUm5yMnNmdjZKaW1iT2ZmQTN5VGdw?=
 =?utf-8?B?MzNEVnBMbWx1dGJ6SlhpL2RBaXo3K3VHYTBYdEQzbGRSUmhRcG8wVTlOTExV?=
 =?utf-8?B?dFZ4RkdQdG43aGhoK3Z1WkFCbEdqQ2Q3QmZMVVFMeTU1SzVKMHN0NlhGWnBz?=
 =?utf-8?B?TTlKeTQzNE5LbENyQ0lNeGo2bys3eVVtZ3V6dFJMLzFUYytGeEVRK2pvUzg1?=
 =?utf-8?B?MGFpeWI3YlBoR01Mc0RRS0VQeVBYMnRVS1ZhWTluTzBLbFV1RnAwdjdOVXQx?=
 =?utf-8?B?ZmJhVEVlNGhnVXZ5VjFnSkR3VUZra0Z6cXhlaEVHYWx5UnlvaEZISG1VdG1V?=
 =?utf-8?B?MlNKYzl5WFpwRDZ1WlZBaElXRzBoSjM5Q0lycUtTRVdYVUVEOHQ3cG9seGZv?=
 =?utf-8?B?cjBjQnhIakcvazB0OVFVK1FJaDF6cDhRRVhaNmRqQlprd0dBY1VtR2JXaGZZ?=
 =?utf-8?B?OWp6U01GOTJJZlNPYmlxdzh4OWtib0N2NFlOS1crZVBRbjNYdXNvT2NKaTU1?=
 =?utf-8?B?T3d2ZnFrVndIRUlCMVRkOHhsdi96QmdhdFdJMGdYZG41aDNhcVV6bWEzOGc3?=
 =?utf-8?B?R2NMc3gzU05NMTdRQnFMTmJKeWZZdXFxeUxoVXZHYUtiSUhsSTJKSy9yc3VJ?=
 =?utf-8?B?ZzZPaE4xcjFtbFk2cDFzdytXbUp0Z3AvUlJHQlQySjI3YVhxMjVkaFREd2JQ?=
 =?utf-8?B?UWJvSFEvTENHakJhTEJhQmRqcllndjRwVnIwSzNkaDIvYU1iaDZtRzhIMFlP?=
 =?utf-8?B?NFgyMHpRc1QzdXVVNHRMVGZOK0xzSTZoZXh5WHBteWp4L3gzN0t3SnE5Smk2?=
 =?utf-8?B?K1VtYzFYR2ZzVzlER1ArdFRUcWtpSmsvRWZwZVhnOGxxRDJ3NWhBV0pFMm1L?=
 =?utf-8?B?QmlVT3BqbW9mK29GcmdYcUExWEZtMEVkamdCdVJMa084TU1tSXBjTU5OR1B1?=
 =?utf-8?B?NFNHYXZSZXc1T293T0NKTmdYTWtvVDdOTDAyc2EvbDRpaW5KVy9ZdktFZUll?=
 =?utf-8?B?TGl1VUsvNmo2TEVIeGNxVE01ckJacE9mSk92U2orVFd0QndXQis1NHpwV29S?=
 =?utf-8?B?U3dCSEdHUGJ1bGpCSGJ1SytIais1ZkYxb2xldTQveEpTNFNPeFJqNS9WWHRx?=
 =?utf-8?B?RkN4ZFhZdVVCam92SUJseEZaWVYyYVFYcXplYVBhOTlDTXkzRzlEZE03MlJV?=
 =?utf-8?B?L3pUNldsUTE3dzZudExhenZYc0dNRFhiM1hWeHVYWHl2WlV4UEJPQ3RZei9R?=
 =?utf-8?B?b2RsbmJNalpaSmhCYUtWUW9VQmpQRlJNVGlMbk9VazlaSDVhbGFwWThyOEJZ?=
 =?utf-8?B?anp3QnJUcWtPZW03NEhtYlZ5Y3VRb1dGNVhnKzJ0MDVKR3JFUE9PemNWZm02?=
 =?utf-8?B?UmxIKzFmUGJFSHl0Q3FKSkdvTmtEMm0yU2NRNU9iRUQ2WWFaWnNJSDRlU29F?=
 =?utf-8?Q?Ekekc0tj030=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VElMblU1YU10bndjRGV5akRVYmhaWmpoNHZia2dMUXlmaUxyb0hBc2cwTjhE?=
 =?utf-8?B?WnVrb1E3RUkycU9sQVJWZEhYUjFETzNhRkE5dGZwR2tSZGtJVGlvTkxzNnZi?=
 =?utf-8?B?QTQ2cFl0bmZkSHU2T0pBVms4VjdtV3IwekNyZ2NWUDZZRUFTNTZVQXU0MU0v?=
 =?utf-8?B?eXFpWjNENHdJU0gzT1E1cExuV3NueXdLZFN1MUw3QWlCZmgvakljWlQ4Yy9G?=
 =?utf-8?B?ZFlYVForVDZyc3BTODNkVnovT0FGR0JtWnJFRGtGOGhoS25tTjJTRXRzTVZ3?=
 =?utf-8?B?bWtZWC8wOE5Oak9leWJwcWxXcWRYMW5KeHAxdHd4Q0pqb2RObC8vWThrNitJ?=
 =?utf-8?B?NVBsdkxwdzJPSmlmNVVFTVBEb2J4RWRyK1RIVFN3d3d5b3NxNldKOTFSTVhK?=
 =?utf-8?B?Z2ZKN0NwMWw0RjRPWE4vVGd3NElnMEh5MENYYWZlbW9EWWJPamxwYVhNS2JW?=
 =?utf-8?B?Q09yaTdWWjU2OExLMWxpRDkrVGR6SkFnZnZ3OUtOaUJtdGdhNWt1YjRuS3ZX?=
 =?utf-8?B?SXdrY21tZnhSR2lVUU4rUGNtUWt3U3VjRUFLYjVhSmhWMnJWTldwNGtzd3Vi?=
 =?utf-8?B?bWI0cXo3dWUzbHdDd0ZoYThzZG9yWnhzaU1UbTVYeHJ0TnhOVnBJbUxMSjBB?=
 =?utf-8?B?OU43NnN0T1hRSVdpZFc2UEVqMHgwcThFU3ZyQkg4SXd3QWRQVE9CdXlxMEtY?=
 =?utf-8?B?aTR6MzNMd0luT0xKN1lFd3FWMmo5QmJRazh6RGVreTh0ckNZUmIyemluNnlY?=
 =?utf-8?B?YlRhcXhGTFlhSVd0eGFpVXRGSEJQS1BleWxvTEc1dldJNjVXK2NTbDF2N3gw?=
 =?utf-8?B?SGplTVRZVEFlY1IrSjVlTy9MOUxTMkw4OTZraGx6UVYreEhZQTJFWm81S1N2?=
 =?utf-8?B?TVdNbDlBTlJWeklXNkZWVXRzNndacG9PQTBDOTBKcHVoY1ZtYWw0RGNCanJM?=
 =?utf-8?B?MkVJWC9FU204VHJpQ3ZmTjBXZG9lUmZTa2dxWjhCckIvMTFOQ3FJbnNySFNV?=
 =?utf-8?B?bGF3eWxEcmxHLzlIU0ZqOGh6OW5oTVludmlnbk1CN3ZHMldIOVFhS0V2dEd0?=
 =?utf-8?B?M2t3VzloQ2lIWUNkWEhuYitzTDFoWnpVQVNoYWpyQnVpRE9uNkd5V2pyMzZN?=
 =?utf-8?B?b2NuWTFsOWtsTEMzaEVNUUFqNVp6bGloTnNkUXdWUXBFUENjKzU3dFFPRjJp?=
 =?utf-8?B?cmRid2JjTzZkQVFEME9Rd0hVL2xsZWtxTlkrZVZWU2RSQXdZUFVRTkJQTjRG?=
 =?utf-8?B?bzVERStWcm8xWkQ3bEYxT3hxYnlhamZCS3lBTkV6OVZMZ0ZIb241U0xzLytx?=
 =?utf-8?B?MTJTZTNVUTNYMUVBbkt1NzdtZWN5c3EzeFpPTUdsZ2x5cXg2Q0FjZVRuZjBO?=
 =?utf-8?B?MEtCZjh4cFdzN3RBd295bnFWUGpkRTN5VzFEUlovdmc0a280SVlub2hNVm1N?=
 =?utf-8?B?L3E5OUJiblV0MERtZ0FtQ1ErSzFYM1pORXQ4THZXbk5VM1p0d0xBcGNvK3Nv?=
 =?utf-8?B?ZEtqenQ1b2R4TjhIRThFQUp3cGhEaEdYY09xRWFaMFQ4aUppVVpaN25JNCtN?=
 =?utf-8?B?eE1BaUxGK0pjSWNzcERjRmZHd0lqa1RYTGdwL1VxNVdjSm13b1BhaDhqalJk?=
 =?utf-8?B?d1BOMlBBaGV2L09Jd2ZLeXJ1eHJINy9XSWQrLzdhYmRGcHVlZ1pkUG1tUldY?=
 =?utf-8?B?OEEwU0FzM2E2TTdkMWdjUEdPNUUzQnh5b3FMRm1oL1ZJdTQzZjA1dklTQkI2?=
 =?utf-8?B?VG8zMkdFWU0wUnBQdVlVejh1UDB1Z0c5WVhRUU5UM2xnMUtNU0lya3A0VWxR?=
 =?utf-8?B?SjU1bE5wY3BDVHJYV1pIZmttbDFIV2hQSlNhemJFNzc3dVZydzBVZFJkVExW?=
 =?utf-8?B?NHo0QTNFaXJkRHpoNHdNMXlQODdpdTJDTTM0RHEyNnZKWGZYUzdtUnVIRFF6?=
 =?utf-8?B?ZkVSOHVLSG90bTJMVlQyNHdTaFhqTjliWnllRjBkdTRWV1FwVFJzajNsWjd2?=
 =?utf-8?B?andmbGx1c1pOWW10UThoeFBQd2oxZmdYZG16UkwwVytoRFBuYlpiMjAvZkw0?=
 =?utf-8?B?SXNmSDErVElWMUE4VUpHS2kxNHhsQkdEbVNWd3B4YmZmUXBMTktUVHlBbnYr?=
 =?utf-8?Q?Vv08sltSGFRYyvSwZsOLgaIBB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e826ab-d6e3-46b8-6b68-08dd7b818076
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:23:49.4812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceCsEcR9faA4M9/39smnntNSgVhZERjw0XoucyqHXAkayZsMKoY60E5ZvDj2gea9zLqkU+hxa27vYLy/25FXug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
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

On 4/12/2025 3:37 PM, Rodrigo Siqueira wrote:
> Add some random documentation associated with the ring buffer
> manipulations and writeback.
> 
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 29 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 37 ++++++++++++++++++++++++
>   2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 804d37703709..a8206ad210b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -522,9 +522,36 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>   
>   struct amdgpu_wb {
>   	struct amdgpu_bo	*wb_obj;
> +
> +	/**
> +	 * @wb:
> +	 *
> +	 * Pointer to the first writeback slot. In terms of CPU address
> +	 * this value can be access directly by using the offset as an

'accessed' not 'access '

right?

> +	 * index. For the GPU address, it is necessary to use gpu_addr and
> +	 * the offset.
> +	 */
>   	volatile uint32_t	*wb;
> +
> +	/**
> +	 * @gpu_addr:
> +	 *
> +	 * Writeback base address in the GPU.
> +	 */
>   	uint64_t		gpu_addr;
> -	u32			num_wb;	/* Number of wb slots actually reserved for amdgpu. */
> +
> +	/**
> +	 * @num_wb:
> +	 *
> +	 * Number of writeback slots actually reserved for amdgpu.

I don't think you need the word actually

> +	 */
> +	u32			num_wb;
> +
> +	/**
> +	 * @used:
> +	 *
> +	 * Track the writeback slot already used.
> +	 */
>   	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
>   	spinlock_t		lock;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index ec4de8df34e7..82972978c546 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -241,6 +241,9 @@ struct amdgpu_ring_funcs {
>   	bool (*is_guilty)(struct amdgpu_ring *ring);
>   };
>   
> +/**
> + * amdgpu_ring - Holds ring information
> + */
>   struct amdgpu_ring {
>   	struct amdgpu_device		*adev;
>   	const struct amdgpu_ring_funcs	*funcs;
> @@ -255,10 +258,44 @@ struct amdgpu_ring {
>   	u64			wptr;
>   	u64			wptr_old;
>   	unsigned		ring_size;
> +
> +	/**
> +	 * @max_dw:
> +	 *
> +	 * Maximum number of DWord for ring allocation. This information is

DWords

> +	 * provided at the ring initialization time, and each IP block can
> +	 * specify a specific value.
> +	 */
>   	unsigned		max_dw;
> +
> +	/**
> +	 * @count_dw:
> +	 *
> +	 * Count DWords: this value starts with the maximum amount of DWords
> +	 * supported by the ring. This value is updated based on the ring
> +	 * manipulation.
> +	 */
>   	int			count_dw;
>   	uint64_t		gpu_addr;
> +
> +	/**
> +	 * @ptr_mask:
> +	 *
> +	 * Some IPs provide support for 64-bit pointers and others for 32-bit
> +	 * only; this behavior is component-specific and defined by the field
> +	 * support_64bit_ptr. If the IP block supports 64-bits, the mask
> +	 * 0xffffffffffffffff is set; otherwise, this value assumes buf_mask.
> +	 * Notice that this field is used to keep wptr under a valid range.
> +	 */
>   	uint64_t		ptr_mask;
> +
> +	/**
> +	 * @buf_mask:
> +	 *
> +	 * Buffer mask is a value used to keep wptr count under its
> +	 * thresholding. Buffer mask initialized during the ring buffer
> +	 * initialization time, and it is defined as (ring_size / 4) -1.
> +	 */
>   	uint32_t		buf_mask;
>   	u32			idx;
>   	u32			xcc_id;

