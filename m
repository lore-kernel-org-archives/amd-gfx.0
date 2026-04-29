Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79589FF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 08:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F0010EEC7;
	Wed, 29 Apr 2026 08:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1rQbCvmE";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C2910EEC7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 08:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/Mf8q3o491n6/f/LeqjwzfUME/U4aq+ZDwmLoLilAG8xKM+6L6uREPKojmA4u/nvi6EhXhTh977/MYOF5v1hm5xHe1AqNWlgLs9a4EFcgS1Aj0xuIWj0KrR/w3Co/x7pvXuWVvWxQELnlmJjjJBOrtb8orSGhlJpULnPUVYDph7Yz37ygNv9Cilr9Omf3JA4pjTFFo3vYyjEJ1ZNhBeJr0YAkjlRA7U2X0hC8/D9My0lpfmEg1AeceHFgtuk7lJo+vCYvOin1+vRih9LnptqwjNH+NqK3wzOKZUS/SWbJqdvrc5bB2SiZAw4yo/SkDOuY9mv2D5I/VVnGgbfVePxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w47cCLQO5fSZAErESGYxSaAqbddGO+k2MEugTdX/5fc=;
 b=pF2o2WaGnkQ83MtHi/5+nKUugmigpa2NQkBIs9x1nhmwYzAc0lV2NB4Z+0lvHFjzuJQbUkHI/JTN15nKGvkFZGg4wYhOcmIYVzmRL4vcHMvJ0PL3WHMawd1cEKq33HHKDcoEgQliJcqV+GYZsl/pFonPU9aJ1Klu6FEN4w9xaahGOBsPO8vsgLnsYjO1IJtc2N+Ril/thHnoIaZJSHlOpZkL6YkSxV+w0kNMuGdr9FNCjkQ27If47cWZnCrSO43pPWafDtYK6Yp2fgrpWD0MFX9Er2LeFJEMqJwrgVX39JUt6w2AJet9ZCA7gVPeeoyiZRKNEtr8NWJL3cyNvlEraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w47cCLQO5fSZAErESGYxSaAqbddGO+k2MEugTdX/5fc=;
 b=1rQbCvmEDYcLY7SLFwWagDHpReXYwYqnIsjlfIOn0MtkIrfhWiJbyh0R/igblX4gc9cTOAM+tvWwrAqH1wbNtO0b2NtBPKh40p4XSo7HCtUoDHIvnteYXIubChrLg4h1HdX7cBW54sK3q8UpIEbj2rGGzUZyywAwMGDQGYRT2I4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9732.namprd12.prod.outlook.com (2603:10b6:610:253::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 08:22:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 08:22:38 +0000
Message-ID: <af9d66d4-e0c3-4ca2-ae6f-db125c19486c@amd.com>
Date: Wed, 29 Apr 2026 10:22:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag
 check in KIQ
To: "John B. Moore" <jbmoore61@gmail.com>,
 Alexander Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260428163512.9504-1-jbmoore61@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260428163512.9504-1-jbmoore61@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: f6792be3-8588-4e34-fb11-08dea5c87961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Xa0SLdGBHgDrjND5AkIbYIGrhv95XQhMr7pckUUeWXlMOwsa+BmzL8LIOHSyradOpMv8opHDx1hT5/dy8kjt++3Usa6hhTT7R6DY5Ks8ZIeZ8gtsHdDj5WN0hAU8EpACshmk+0uElEwd5i5HD+4kGmTrDPVDHI6UOnku5S8Zj9eFHbiHXenuIe//+/pe/U6c6PxhryNcTviNeYnCM6VtK+CHVdLa78DVP1p9w7ubjtTMoeZTeLwd64fEotsvaWSKu8LiMo3Nm5v4j7CtWOuKynMnilfam7BqWXrtse2PtbIZ4hhKaPRdB8SuPxk6oPmSXx+uvSOq+hhYq0gHedGvEWdAnirKA7omWKiLHj8SuNkXHn9hF+JkDdahryfFF1uzVOita63fzfhgGSqzB1rgwLB9BfHE9WbkRV0lf7Gdk1J4Clp2kcZwGhCRrVIupNycZwAMy6vULLHkdZHU4oeYq4BnYDsoO2pEvq5/4aM7cGOWDqJ0x4gVJd0298/fZQ+iWGJAysQC0Zmj6lBI61k/zeXK5ZZ/5ja6wq3JylER2GEgTaNKWiDmfRgsdVL4jEx8qmZxEW5C7l3I7d/WyvneEJvnbYMjKfVu3gmQGDxpYBsmMfCsWK0ldpFuL8k5fA3D/k0AE8ltrN7qowWSKMgLhEpVFI9y9Ce9QHzfUuN3n7Fl+cUZy6N0ZFrGtpKNTaEbRds4mYD78QbbiXdvkCVy+2BOUzuNqkqU/VARXltzePE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lVWkZaYWQ2YnNQRjhna3BPNnhSTlhQMWxlRjFXUnJtN01TSEFmWVQrdzZE?=
 =?utf-8?B?OXJzYzdLVmdzOW82Wnh2cVo3VHFPUjd2NlJXeVkyNDgyd1VpR1U3TE5FamdW?=
 =?utf-8?B?aDhUbEtIYXM4Y2lQUWdiTzlGaHNURHZWaVo1RWNNU0hDNzhob0Z1dkNSSXQz?=
 =?utf-8?B?dDZXRGdocVlOM1kwTm9SbGhhZWhhYlhuR3hRUlhKblZBVGR1aTdhTWZxLzRv?=
 =?utf-8?B?WDdrTmFuUXV0bGN1MGJEQVR4TzdTRml5VktIVVJ0ZUd0Z1UvSE5QcWVwaVBz?=
 =?utf-8?B?VVRyaWhNcUVaaDZBV0ZiUS9taE9xblE3SFRUV2g0RG1nS3I5ck03TFdISFZ2?=
 =?utf-8?B?aGRESVRlUk9vTGd3cTk5aVdWRFlOY3p0MEdjamF4MHFkSWc2Nkw2R0IwcllN?=
 =?utf-8?B?NVJXWTJtVDJrU3FBTmMza1JMVFlGdzIrenpqNHhoZ29PN2tZeDcxNFByTHBJ?=
 =?utf-8?B?Z1VJUE5KL1M1QVhqU2ZQbDFCWFJZQjhTZFB6WGFxVHIreE12MnQ1eXpDRUJm?=
 =?utf-8?B?dmQ1cHpnenhtRWU1cWlIZWd3WXlrVWJFbzI2dnJJdXdVaWJGMkRKcndOTTNm?=
 =?utf-8?B?andlaC9uMG5WQjFQRnJQVkx3enZnUnZUcnpqVkE2ZUZmczN2ZXh4WnNyWXFu?=
 =?utf-8?B?SEhLN3laZ1FyNTU3bEFGNzFtd2J1OVk5WE9FNFp0NWNkd05wb1BYRi9rVDlZ?=
 =?utf-8?B?ZmpjVmpVNXI1cDhVdXlycGhsd2xna3FWeVVPQVFDdFc2NW9mZytISUxSZFJs?=
 =?utf-8?B?OFdIeDdOY1UrWmNJMmt0M2Y3OUs5Q1k2OFROVzJTZ0hZT3BheGdVbXVncEZ4?=
 =?utf-8?B?azVOZ0lJWlBzeitBZFFxdFV1Uk9LZ3ZxQlNuYkxKZUg2U0Jkd0dCM0E5QXBT?=
 =?utf-8?B?NGU4d1ppb3ZEbXJYcEV6M1RHRlhXa3N0U25yc0pHOVRXU0lHdWlsOGtGeUk3?=
 =?utf-8?B?cTk0NUpTaElpQ0l3eUkrb245bFNvOVZNcnBNS1VZSnczdEJZVnZPbC90R1hO?=
 =?utf-8?B?NytadnlWd1ZZcVRvWEgyVkdYT25uUTdyVFM0OHlscnc1NEpmbnd6MzhPbmNI?=
 =?utf-8?B?NXRHbnZoVXNobnJtd2VnNGpYaTZ1MUgxL2tFaFF3ekptM3pxbGd1ZEEwM0Mw?=
 =?utf-8?B?dFQxNDZYKzhZV0lWdTZuSi9taHBLczNMTjhUVHc1VHNGNnhGYXZqWEprdmdj?=
 =?utf-8?B?cWl3eThBeldMZkx2T0FUZ1Y0NWU2NGtRRUhTb2ZiQ2MyY3pIU0JoZC9Gb3Vu?=
 =?utf-8?B?MTdjVHdhWnJDWFlKTU9GQi9ZUGpmcklPVHd5dTV5SEUyb3pGQkE3WDZ1WnB3?=
 =?utf-8?B?L2cxSjJ3VHhSQzRHeVdiaWdmM1RHRG9oajBiUWo0ZUpSWkJWalkzYkVCSGQy?=
 =?utf-8?B?WnZLSnF6QVhkZW91cGdaVFcrQTA5Y24ySGRhZFJWdE5XRk9oMXgyZDNUSTlU?=
 =?utf-8?B?SFd0TmNKZm5GWlJOU1J3dDAwTnJoSjZIeW15NVZmYzFUSFBoK1BtYXpEdi9F?=
 =?utf-8?B?d2tqN1ZLMXlNQVVWMFYyTGt4NERmMmJTQi9maml4S0VTdDF6WXN5dnJzWGpT?=
 =?utf-8?B?dnFHS3crNFJHTm1zRWJVcTNrOE44bzVKaURhOEN3dkZ1YWpETHFTWS9BT0x4?=
 =?utf-8?B?WURQbVNaWVc2VlFyaFdaN1dtTTZGeGpjanNUYStjRHg3ekNnZlpRbDNKK3ly?=
 =?utf-8?B?cSsvMzVjS3NqZ2x5WGdKZTdkWjBsQ0pjK0hPZTRPVXBrYSt3czkrVXVCcHB6?=
 =?utf-8?B?Q29XcmRaWXhacEx5b1orM0lSNGdRZ3Y1YjNvcEQ5UWo5OStNQ3l0WjFWSm9j?=
 =?utf-8?B?STk0dW9oMDY5bk84andZMnFlYjZkTzdTZitDV2kyOExCSGxQN2lzSUorN0RX?=
 =?utf-8?B?ZW1YOUJkZmFTVlUyWUdYYjgzdUlnN0lxdVVPNFBIMUpaL1R6aHNYUlk3OTZW?=
 =?utf-8?B?ZktmWVpLaW10R1pYQTBEYk5GM3A5cUJBRHVGUEc2WE5DUmxUT1lCUUc4YjVk?=
 =?utf-8?B?Q2N3cU8wOHk1YkwzYVhrL2FSYk9tOGlFd2hzNDI5MkplSllXb3U0TU9zb2lV?=
 =?utf-8?B?VVF0RE5kblRKREc0ZUpRbE5tRGx3di8xSlMvL1kvdlhzc0UrRHZzSndtdUFS?=
 =?utf-8?B?K1I5YzkvR0F1MUpxVFVQWElRQnVia1h0cXp3bnhXSk1OajlpLytKUU5FTTl1?=
 =?utf-8?B?dG4zU2JDTmtCZWFTdWlaSW5xQkMyR2R6ZForTkRVNWV5ajVZTUVPUlNiQ3F1?=
 =?utf-8?B?U1pjYWtncEhHSGhyeGpFMVREMUlWNDc3SGEzSXJWZW8ya3BtUmNBUWZEWUcy?=
 =?utf-8?Q?YrVxv+iPpexacE8PbS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6792be3-8588-4e34-fb11-08dea5c87961
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:22:38.4809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yK9uErAAID9FcRBgGsME6YN3Y0MLhUeQ5ZA+f98nuLMoz5BChihCS37L2YHlaxMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9732
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

On 4/28/26 18:35, John B. Moore wrote:
> Remove the BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT) assertion from
> gfx_v9_0_ring_emit_fence_kiq().  The KIQ hardware supports 64-bit
> fence writes; the 32-bit writeback address constraint is an
> upper-layer convention, not a hardware limitation.  The check serves
> no purpose and should not be present.
> 
> Found by code inspection while investigating related BUG_ON
> assertions in the GFX and compute ring emission paths.
> 
> Signed-off-by: John B. Moore <jbmoore61@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 47e81c33d..fb2a0f1af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5679,9 +5679,6 @@ static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
>  	struct amdgpu_device *adev = ring->adev;
>  
> -	/* we only allocate 32bit for each seq wb address */
> -	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> -
>  	/* write fence seq to the "addr" */
>  	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>  	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |

