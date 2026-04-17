Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A978F8E4B4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 07:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403FA10E97E;
	Fri, 17 Apr 2026 07:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sL0nU2av";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012057.outbound.protection.outlook.com [52.101.48.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E777510E97E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 07:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyaNfdZ8v6itV4YWHgCAnoAPCLgwzeqmUCIz3T6TiqC7Op1FYd7BXbevBuNj7Ak2E0ktuZaKKkwjla7QobldciQsbbpFKQEtuZnipfpRlyxRTq2N8yOHV0iEpJqtVbA80PsOv299eni2DWEuDf8TZVN1zs+q1pw7Ai63n33VMXecZdN4EYGIs2HSe08dPleHv091hcd43/WmWffyTUnrfdd9nTsUvokTTGmp0GxNzspmTIIaDozLOY7JOhT7eD2ibK5FS7Ha/VUstzIbtdlI0kFhQ2KV/7X/X5sDj8vLDf5fUUU0uxC19gycO9nJBgh8y2LCLv5SP+0HSLI61wqcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lo5E2jr5WTQEyeeLRF52XQ+i2Pm/XA52uLvwJIXSl8Y=;
 b=J+277CLExzEjQQFGTa2QSPPOLAarVrK+OiDw3FJ4BujrMWaDkb58stckHiOYzYVu+tLFnM4igTza/nVUb1rylJf5mRuuFbo0qe3Qh0609Y+T4sp8u6o9Grxzof/RxPV2O05iLNUmkJp2srQAUCfpKHRHb34+moMJW661ZNpg8oyDbvdh+HJRylLfAzqoFCYHftym8kKsh7zlELlloMFWqkC/cvTBoCL0ZvjMUVOMmgF7c7ePcilrfr0U2k763W00AwjQNY8t+i70sDuqAPpNwBVVvs5undV2RpsKBrJXP5SK3kZvYkJOjK82QGRCbuHHGmNB5eJGVW3RmP/tR/6rAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo5E2jr5WTQEyeeLRF52XQ+i2Pm/XA52uLvwJIXSl8Y=;
 b=sL0nU2avJd5/1SmYk6Lp16rrI0yNLg5GzOFKXqAmUWUqTLeg8qEs0vAFNoAA82imo5ohggnBBXGhanvF/GnDBZx1yoMry1ylBIH1yXWGOY7SEL+ISlqQQCcb+UbcnFw2cxzZPZ97MFCjL3fDUCrKS3KH5UB8JOV1m3AFcRzRIJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 17 Apr
 2026 07:08:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 07:08:25 +0000
Message-ID: <f03f1e3b-8356-4438-84e8-29d968550959@amd.com>
Date: Fri, 17 Apr 2026 09:08:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu/vce: Align VCPU BO to a power of two
 address
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260416202643.25350-1-timur.kristof@gmail.com>
 <20260416202643.25350-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260416202643.25350-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0394.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e92f39-aa5a-40f2-d2de-08de9c501e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: aB5v8PGaSsvICbh4Jpuk7LRW1wJKrLFSUCXHAPQp6L3u63HFfZQBdUZiwOJ5ddMuXDWfG8UR3saF6jJIleeEHV5gq/Y6STFbJykEH1U6KKQi4DaJ4K7Txd+V4uNY+GrbNTR0kPhrE0F4JskUCm+HHuwAyAO3lTnaEW8jUpI+ry+k7olI3noQZy8SY64g7nRhBOhEtStmwXASGaljgW8XP3/NYjF0UdPWhSD8kZxeGMlXXWvyWlQxnhyG5AHh7voPpFUwDazbuekTJ6HXQT0wocBrGNVVQPv+TN0fokINVJQTO7/TS8R8IRl6qbW69Hmj3xNM71OuvNEMXr7ZL4HmyTZ3ug7Ee0lyd0ME0Aml3ozNYD7NJ1qphoicmGPYgflQ++uTSS1rjzoORsx7mHMAzo6wNpqaWhoCgnZC6rYCniOueyLOapIK4QRugQqpsErC7VtGymOYWdRdHt/a5uX7TdcfrO1H46jJEQ259r7phU9fZBLuklQFqSsUIT8Z+Rmhgd3bETMlS06IDQ5yimsmTvao0gnIcBLa3+L8JJhFKUKg5T1/rXvDj12SGsvJDME1xMF+swhvyZPuuGHQVSEjupO8Gr3LAwIyacRN+rmBODnfka/hR5EBuEltHcoTt+QQi3vv3ivEfAM4TsjJNzW1In93mlSGVenA2nZ1FnnNYvb8yiE57cXG6cJLy72maweqP7WUWWByQvrrpXx4vdDLj0gHhh/VWa5NeaKf7f+HGis=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnA0YXBuK3BRaEIvR2oyQUhxbUdnb2ViZ0RLc08xTVZFVEZKbWxKRENKMXF4?=
 =?utf-8?B?WXN3QWFyWVNyazZ2STlTT2UwN1JuUENwSEh0NGxVRWlxUU0vV0VuY2JJWDN1?=
 =?utf-8?B?emVBdklBemx2eEU2NDJXN3dIeFk0UWo4dzhaa2phNUk4Y2ozcUg1T0NWd3ps?=
 =?utf-8?B?NGo3Zi9lWkNmWkxHRi9kNmFEWUlMZy92Zk5ETFZZWDBXQUFvSHNLRFJockRi?=
 =?utf-8?B?VTBIUVl3ZnRienRNc3BnemozS1UrM3BwS1FVQ3hTY2dSakdMZmFvTGROMmwv?=
 =?utf-8?B?OGxZNGJyWEF3eUZnY3NyaithMnNLVTliWkNuQWFNVVB6TjNJUUJKV0FQZ1Fs?=
 =?utf-8?B?d1B3akRHY1FuOGJsdHhQSDZJUVhQV2lMS1VEQ2lSbmhNMUJFN1ZucnM5QTQw?=
 =?utf-8?B?YVZiVTYvVTlXSk9Ja0VpaGU3OWtvekwwTlZqWWM2bGRVVy9lWk5TbVpWelBj?=
 =?utf-8?B?N3Iwc0lONDNCZ2FLVU5YY1VDRjBIVVdjcFNZMHVzUVZTQ2NYWmg1OUhoZ2or?=
 =?utf-8?B?ZmxkVFlBZ3lNRFlKaHZvQU5EczVkb25YVXdFb3ZaNU5KQnBLZHdIRjRYL3Z6?=
 =?utf-8?B?RDlxVDl1UzRzMEpIMjdVV2wxNUdFZE01SVVIbWZRdXBKQnRvcnZuRTdsNjk1?=
 =?utf-8?B?em1uNVpVVmlPZGJhcjVwL2RqZnlmRWRSdjlIc09ZTDllalpCbzFzNksvRFNS?=
 =?utf-8?B?YXZqM2VqMzI4T0gxUTJDdU5aYkVJYklQWGNpZEZFZDJjclNMVTdHR2VLRUFm?=
 =?utf-8?B?SHhXWkxNNVVQY090eFByaWliYzJ6U2t6R2hDMGVEUllxSmlMSWV3QVdmcncy?=
 =?utf-8?B?UUdUeFkvd3NUOFQ1L29JYnp5UXlmZGFFTkNBM1pKdnNWY2ZRUm1YN1RGVFlT?=
 =?utf-8?B?QzNUSnUzV2YwZnl6cDdRbmw4ZFh4VUxPYmx0ZGZ0WEdoWmpPWERnWDVSeGp1?=
 =?utf-8?B?ZlcxTk9oekJ4WHMwVS9ZTHliLzVncUtjbmgwR3k1V2ZaTmRNaXd5c2hYK29m?=
 =?utf-8?B?azhMVmc5MVFqcU5IaC8wKzJ5TSsvanZMRmdFTE9ib1FyZnNiWkxRM0IwSkNZ?=
 =?utf-8?B?L1B1Njg0bW1mWDJ5cTlmSTROa1hGcEp6UFF0SFN1TkRIZ0VTei93Nk5HUzl0?=
 =?utf-8?B?OG0wMm5qdHdGM1E3YTFpWVpuaE14eTlwdzZRN2RqVnE1clNjV0pRZDh1bjdS?=
 =?utf-8?B?WnlJMnNpNHFmMGEwUUc2bmExanM1NFNHWURJSG5ucHBxb3R3M255UU9aL0ly?=
 =?utf-8?B?aVJvSHM2Y0syUXI2cHdEdm9BQ1M0VTFYNldjUXNyNDM3RDZKQmpvaE1YSmlG?=
 =?utf-8?B?SnFobUcxY1dEOGFFejd2UkgvWVpIbXBhRlhQeDhBeUdrQlh6NzRtc2o3M2lm?=
 =?utf-8?B?alBHblpsWm81R1lKSXdqMGZnREdEbkhOUjRaR3U4c2VWcE05K1JTL0EyZmEr?=
 =?utf-8?B?bmRJUVdLazEweGtzWmgxTWpPdFFuRTcvekdqaXhOSituU0ViMVo2d0NDbUt6?=
 =?utf-8?B?dkhLY3NpMVVYdHdjWllxWGxrOU0reTR3SmRvZVo4Ym1iNHB6UThFaUdSYzB2?=
 =?utf-8?B?T2dpYVBuWGNTa1lUK01ud1d6KytOdWRGSzlpWVZmSTRRbkJLeDk5amVndXFW?=
 =?utf-8?B?OVBWbTMrRlltQVZIQlM2bkhxZWd5VlBiL2NNY1dwZ2FscEhwRW9TdDIydDdy?=
 =?utf-8?B?Zzd6MFpoWi9zYlV2cFQyQmhLYU4xdXpFR2ZWc3EvZkhhK0l1N0hreTVDOUxM?=
 =?utf-8?B?SUZQN01wZEVqYXJzamloc0IvMW5lazcvemYxUnorVUo1TkVFb3hiOHNsTWFi?=
 =?utf-8?B?QzlLa0tkWmpYbDVkeEdhYUcvZ3FqSDhKNnVrZ0o1eFpJSmdrQVdTelArVzJ0?=
 =?utf-8?B?clozSXBVMWc1U1RXUmtuZm9wZDlhMnI1WFJXZ05QcDdPMnkxQmIvR2xlT1lH?=
 =?utf-8?B?Um5VVkFBc3dSWURKTjZjUk9YRHphalpEZUppMmI4bzVxc01uOU5iTDRQYjJk?=
 =?utf-8?B?S2J3amdFNzR1Tis0T1RoSVVQbTdMN2R3eHdoeDY4YWM4aDk4ZG8wVXhlK0N3?=
 =?utf-8?B?N1pXblJjWkxnMTAwNm8wTUdZT3FsaDBGRjB1VFJVMnlISEZuUnBrdHo0OHZj?=
 =?utf-8?B?UnFnbi9Pd3hZZ1gwSUxLWWU1SlgzYXJPREU5enVlSzkrZmVhNmtCSGNwbDBa?=
 =?utf-8?B?Zkw3WitCWVl3M2t5ald2aElmcTM3K1FKUWU2M1pkTjFSSEUwWE9hQVJUUlo5?=
 =?utf-8?B?NldQbGNBdysyWVU2d01Gc0kzUTc4QmpKUWR1UzdxMFozRkpOcWwwdW4xUmFk?=
 =?utf-8?B?WTRxUjdCejc1VDJ1Z1hHM1BIZDVQdEw3eWxSRWlRU3VkeUQrSFJ4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e92f39-aa5a-40f2-d2de-08de9c501e58
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 07:08:25.5078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSw1Tnoo1mO43YULoT9HJ2d5DvOb3oH3VcvI6MqqvWriQG07DGF9Qqy+yJ6ACLGw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568
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

On 4/16/26 22:26, Timur Kristóf wrote:
> This is done to prevent the VCPU BO from crossing
> a 256 MiB boundary.

UVD was the one with the 256MiB segments, VCE had an issue with 4GiB segments.

> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index efdebd9c0a1f3..ac25355539cb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -218,7 +218,8 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>  	if (!adev->vce.fw)
>  		return -ENOENT;
>  
> -	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +	r = amdgpu_bo_create_kernel(adev, size,
> +				    roundup_pow_of_two(ALIGN(size, PAGE_SIZE)),
>  				    AMDGPU_GEM_DOMAIN_VRAM |
>  				    AMDGPU_GEM_DOMAIN_GTT,

Oh that is a really interesting find.

For kernel BOs the alignment of VRAM allocations is always the power of two of the size because of the backend allocator.

So that only matters for GTT allocation, but GTT allocated FW should only be used on VCE 4 and there the segments doesn't matter either.

We should probably adjust that so that VCE version < 4 always only used VRAM.

And by the way PAGE_SIZE alignment is nonsense as well, that parameter should either be 0 or AMDGPU_PAGE_SIZE.

Regards,
Christian.

>  				    &adev->vce.vcpu_bo,

