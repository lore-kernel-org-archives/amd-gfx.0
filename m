Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029F8C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 12:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A987F10E076;
	Thu, 15 May 2025 12:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JNlxQUqO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD5D10E076
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 12:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJmB5HPtetTjvVF4n49qAS4i+mjc7CRfduQrL2AV5S+wKtbKpag7FJ6BUI3e44yrx1hTtUpNP0ULmiKTpA09u+BACuevzmvXjleKpVZMBx1OvlAEZDIJhyILIubbSdB5mDlfPY3m2yk33AIvXkVPShmGk7J/sZauFTTmDmWlXQU2iaRH0WRey+Ru5KmSSY0CQMxmnRAB732RLdMeOTBySwXwZ9WYirsFJAl9KcCl8Jpc+nSaPIqNG6b+f08CGY1PjoZ2s1ErBzfhGggTFg3tDHcjxP9ddht5rPhYGC+tpWU51Gng670tm+3zx8XFkn23HavmBMJOyaavnYZbUhU/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y55aadb78pV+V0OBTrrMVmgS5JB/X7k1AbwQkD+g9Hs=;
 b=qkhzQAq0AIkwvj+x9nI7B39gdoMOtCtVkAIXwTzUSludIH7NGCxt4E/WPkyfSl4O7yEe5auiVB5RblHEAkIFR/Uxjslrc6IHRlkEja+G6MDE81xQwUpc1NkeukPPlszA9H2LujbiwM7wphV8Ky7zCmtA91dJXadtrQvzPiElX/n6ERMlulG5yOIY0ILenYHtCfkCftvJYaC5CIwxYQNFg9jZKja30pybuv6zS4+q79FrZojRm6EmvRY7Fz+6NSOxyxSzJ4bIGRXxEXGAvrFEnSg6tnX3snJv4oJmEws3g/3A3DRs0Vih6QDtnfuebFSvRw2SEyVerVKAQhJn9N1Mlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y55aadb78pV+V0OBTrrMVmgS5JB/X7k1AbwQkD+g9Hs=;
 b=JNlxQUqO+xje4lWLV5RkMDIf3Wo6YeyPXZGjzCfBOcQl0EQKCnZL8dcdbaHae/myyujP9haX7LQwUdmylCGHKfxxbx5I22i7AD2ADEW7qwSY3bRieMOp+Zmp5W8G9SI6KDpdssGJ+QfOTsQVJkZnFP+yyd61JrPwoTRwkkT4d1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 12:07:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 12:07:49 +0000
Message-ID: <134f5b62-b5d1-4524-8acd-4b1f0bdeb9d6@amd.com>
Date: Thu, 15 May 2025 14:07:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: lock the eviction fence for wq signals it
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Arvind Yadav <Arvind.Yadav@amd.com>
References: <20250515092420.663226-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250515092420.663226-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00013DFB.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1f) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e1766b-6884-4dfe-f1a4-08dd93a91c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVZnZnlQTEFrV3YzZzRiV2ducHBDclkxRlUyVkhvWUlqVGZMYXFlMG5CbE1m?=
 =?utf-8?B?N0x6bFZkTzExbE5nVklLbVFmbi8rUkxjdW05Z1ZucjRtNnFKTC94UmczWGU3?=
 =?utf-8?B?bDdvNlVrUVhQRXBjVFRsRkNsSUxrYXF5YWU4Vm4xdi9LVGo2bVdHQlBvOC81?=
 =?utf-8?B?dWkvKzAzdUZmSjN4d2s5R282SVR0SlpQSlBPWjlhTURkNTJxU1ZKdlY1TU5R?=
 =?utf-8?B?RDllODErV21RUFJ1V0ZXRERtKzh4ZWliM29uaFE0bHhmTXpjemtZM29Na0xr?=
 =?utf-8?B?bUxiQk5vYllIRm1CTjE0OXZZS1U2VFhvOVdOWDBTdi9obUVvcEN3Zm1wUmZY?=
 =?utf-8?B?amxEK2M2QXJkSXJYR1AzM2R5NlRENWxrUHlVRHZ0ME1VZFZvdU1nQVJSa0VF?=
 =?utf-8?B?QjNpL3ZSNkp6ZFk5RDRwekU3R1ZXVU91c0FGS2pUL3hIQ0RqMTduTVMyT2xa?=
 =?utf-8?B?bCtjN3lzb29QQXorSUJuOFhQVjY5QXlpNGp5MytvVnF2UWlwZ285bTN0WVZI?=
 =?utf-8?B?Wm0vMVVwejQxUy9mZVBjNm9LZFdxejJHeUUvOUtiKzh0dzdmUmY2dmVjZHBr?=
 =?utf-8?B?YTZEVEQ1cWNTMSsyc1BZQUUxOHlsSjAzaEVzVWtBc2lJc0N4TmpZMzh5djNk?=
 =?utf-8?B?MlFMZzVET0ZCNHdLUU01cDFKTmZ3RG5oNTRFdGdkcFJwcDhkZ0Z0Z3NVQ1Yr?=
 =?utf-8?B?MHlwaHhzRnFjRmNvb1hycCsvRnQyeGttOTJkemdLbkFleWloeGRXNERaOFA3?=
 =?utf-8?B?b2NYRVpFTXBSaWx0RTdLWUU3aDlka1J4ZHVqYnBxNFhqT3BsY1BITTZoaEZO?=
 =?utf-8?B?MUxQK00zR08vTXp2RWtYb2dBQVNIMVFERDJ0QXVETEJrUVM5RHhzQ09aVlR0?=
 =?utf-8?B?RzZWdUdQMW9ZcmowSXp2MlZINC9kU1RBaHljNk00Y2Z0ZzJnY1FkVlNKbXQ3?=
 =?utf-8?B?L216cnBHL2tBbmxBVU9IVy9Ib1I3T3lHclFReWZJUFA4a3hGZDZ0UFNCREFr?=
 =?utf-8?B?azNRQmpoWUMydzI0SVk1elRZeG9CRFdwWitoWWtYS1N5bHpxM3BERUZtaW1B?=
 =?utf-8?B?OVFHUys0YjI2RXV1cFpGZlBBUnBhZUsyczhRcnNFbE0zVVpxOFlKaHVON2hN?=
 =?utf-8?B?M3VqTnJLUXVnVlIyVGx1SGNqRnRJTW5NZHAxNHpvN2tHN3VGMFR3eFVPRzFu?=
 =?utf-8?B?dDFpRXY0enVadEprS0J0ekV5NmNXeC84Y1lyS0l3ZVBOSTdWR1h1Mng0eEcx?=
 =?utf-8?B?clZwUHlNa3B4TFhETG9yUTZiTlVONjQwVUN4MTRYR3dUVXE5VXlvNk1XUWhn?=
 =?utf-8?B?c2QvRnRUM2F4RCt3UG5SOGJtL2I2UXZqS0tFalE3L3p4Ti8ycFRNWVk1TjFw?=
 =?utf-8?B?SXE1K3AwdXo3eXRJUVhDQkEycUJ3eEp0U2hqd0U3UTdFQjBUT3JOR0hsZ0FX?=
 =?utf-8?B?YjQ4eEk3dVQvT1ZhbVpxRjlEMHdaS1VLamx2VTJudjZZaGxWU0hqMUZKY25S?=
 =?utf-8?B?d2VsbVUrZy9BZnRtM0VnVTQ0a1d5andZSTVwdjlGV2kxL3NrQVFsTCs1QkUz?=
 =?utf-8?B?UlZNQncyYWhNYVNIeVlrSW01azNmYnBjMTlqOUNXN3ZwRG1ZTWdQeVBFUmFZ?=
 =?utf-8?B?VXo2cStxWmxPMjhhcTd1eXBZbmF4WWc4V3AwVXMzQmpBZHpKSkdQSFdmZEwv?=
 =?utf-8?B?OUh0RjNyZHEzZnp2Tk1PckcrSzB2Z2pBdXJWeEpsY1JoZVZoT3BnTmIyQ3ZP?=
 =?utf-8?B?d2kwbHlUVXpuNWZCSWNGY2Z1YnJmMGI3R2pRSGpZanlwc2RRUGtaTlkxYmVn?=
 =?utf-8?B?aWd2WFVIeSt0djBSRHdVdmwvK211anBEMWE5aC8wVEtrRVBqSW9CV00yN1NF?=
 =?utf-8?B?cUo5bHdQdjkrYlY3SVJPZmxka1U0UDBNVVZ0ZGU1K0piZml4cHZyZitWVjlG?=
 =?utf-8?Q?zGGx+4v/A6o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ampjeVVJZldycmE2TEEvVDdsMmRVQ1ZiSjdTSjhaVjQwNTdBeXBUdTlYdC9q?=
 =?utf-8?B?cTVzUVBPOG4zejNsZEVnZERHNVdPVUw3Z0dLNmRoWWV1UlQzUUsxNU1aaTRt?=
 =?utf-8?B?aDEzMndlODhvb2Ixb0FBbzcya3hIb1VlV3BxNnkrWHZLVDRkNm9Db1ZDYXdi?=
 =?utf-8?B?YTU1Qm1FWmxsbFdQQnlOb3VIS0RvUHptT05wbnBhQ0RrWS8xRThFaXpTSDA1?=
 =?utf-8?B?RWN4NFZZQ3dUbEFaOWdFRXdvN1dtY0FSU0NkUG5sT1dwaVhTMkdGZG1Wd3Zw?=
 =?utf-8?B?US9zb3FMTUNWbWsveis5WVU3b2ZtcTdiSGNRM2NiR1p1Sk12WTZHWjcwSDBN?=
 =?utf-8?B?UmN2aTRacmNEL09wclR0eTMyKzZvRjFSY2xmYkdDKzhxY2xuVUVKNlVjQVhC?=
 =?utf-8?B?UmdUUlBQc3FWd2xlLzFsa1NneGFxYzlIOFFJZXdOdE1JYXdwRzdQemtDc0dQ?=
 =?utf-8?B?WWwzN1p4L1dubFMzZlRHR1pwQlFNcy9NTEJ4aHcwSkxBeXQyS3o3ZGRJU1Zm?=
 =?utf-8?B?NExJc015NGtkcFhaTnFGQ1V3KzBESVhDc2dyR092ZDBIbmlvWVRCMmpFejZn?=
 =?utf-8?B?Y3REYnpmZ3o3VlZybHdBczRidzQ0Z0NFZUVkV0N3bFlDS2xhaU5nRHViVTRt?=
 =?utf-8?B?MlVKNFdFVEtNRlpzbW8ycTJISTZkQXZxeWtsWkJoZ0t5aUErY21vT0Q2OTh2?=
 =?utf-8?B?NENrdUlVdFlHSDlUMEY4U21EMThZU0UxVFVRZy81T1JpZytmdi9OUFRGTGI0?=
 =?utf-8?B?RnNzWTJVcThYeTB6WkRtWjlCcGtpMW5RcWNBUERYZS95MEFMMlYrejJEWDc0?=
 =?utf-8?B?ZVhxazFQMVN5YU5BSGZpc21kRk5PUEZPU2dwMzY3blJSNGFWN1BwK0tHZUhv?=
 =?utf-8?B?Y2VxLyttVEhwbDh0NitHdE1tUnZhbGdTVTdvVlNUYjlVZVVXdENnKzRVbGNE?=
 =?utf-8?B?Q045K1o4dzJMbHpoU3oveGJXSm5ydDZyQkFaZTNiNXcrNWRmSFdEVVIzK1N2?=
 =?utf-8?B?QmZ5M2g5ckhEZVo0TjZlSndCdHpRUGtyZFNBc1JBMGxXVlNHTXpwYnVpQkM1?=
 =?utf-8?B?U0VVQ0o2cVl0SUpEY1ZnaTdJSmw3RTBVSWtrbUE3Z2o0MmFNT3JVUUp6QURC?=
 =?utf-8?B?b2ZTZDk1Q2o3cjUzYTM3Umc0SGpCeExKakdFTm5MRG1QdUJZbEhNRWo2dHoy?=
 =?utf-8?B?WSt0TlJpSnFVMVNTRmUrbk9OR1hqTWcvd1FBYkNyR2lOeXFwMmpsYWh4R3hs?=
 =?utf-8?B?NjhXNG9XdHk1WC83RG1jSzVuandock9oc29LUThEdXVXemFXNFVid1FSajkv?=
 =?utf-8?B?SkpCdElPMStjdUhpc01CeGpQSVk3UndwZjYveituUkkxcjE3SkM3emdDQ1l5?=
 =?utf-8?B?akhNelVaYXJKLzUyVm94eTJKaGNSekxtYVpLZTl4bktZbTNwSWl2RDJhcXdN?=
 =?utf-8?B?cVRZRS9XWWZYOUhhNjY4elMreHM1YUlzY3pJVUhuT0p2UFBJd0U0eGNNOTZV?=
 =?utf-8?B?bHJNbjdPOGNjYVFvZ0JVZEFEU2FmbkN2YmZnU05wa1ltUkV5VU5VLzBualB2?=
 =?utf-8?B?QjExTU1CMVMvS0MwLzNNb1F0WkZxajRiOUwyZ2JsZFFnaHdLeGhxZkwxek5w?=
 =?utf-8?B?bzg0enQvcjlPbGRvY2UrZnlKNFFjeWRLeWpPcldXaEZkWWpreWZzZnVodUhT?=
 =?utf-8?B?TGVWRVR5U3NYaG9aR0wrb2h4QXJ0bkNEN29IL09DVWZkQWZVb0QzazZjeXk0?=
 =?utf-8?B?NHhBUGczUnZZRHhaVlQ0Q011VTlCTzdHK2JWcmh5b3JOVGxLYm9CZVpONFFa?=
 =?utf-8?B?SlJ2dlNjTFJVSTg4L3haWHVpMUV3Q2NlbDBNNWFRMWUyV0JpR3VxZlpjejNl?=
 =?utf-8?B?QmdENFN1N09FQWpCanFGUkVOUmpQMW1pTmFFTE95OXJTS2cwQ29ZbmI2NWhZ?=
 =?utf-8?B?UXBSUDB1ay9yYURUdDJKQkVRRTZibjZuN3RoREN6Uitxb0pSZnVHWHNSaXAy?=
 =?utf-8?B?YWJHSXRsRE03TGkrd1hvWG8xL2hydXFQQ2hIbEtGM2VUNlBNTFUwMllFNmMy?=
 =?utf-8?B?YVFaQkRQdlBnSkIyOTVnWmZlOTZzK3FKZkFiS1BBL1ZLK0tQSXNidCtRODlj?=
 =?utf-8?Q?/P3Jr9bGIVqWO/sLJ+ipusqaz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e1766b-6884-4dfe-f1a4-08dd93a91c83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:07:49.6132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqjCDfXboS16yulB8uMSkL03apmjUUcYTpnn54WMOVZHUMDTcKVxfvDkVERpV+XO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

On 5/15/25 11:24, Prike Liang wrote:
> Lock and refer to the eviction fence before the eviction fence
> schedules work queue tries to signal it.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 1a7469543db5..5b5d45534d79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -108,13 +108,22 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	struct amdgpu_eviction_fence *ev_fence;
>  
>  	mutex_lock(&uq_mgr->userq_mutex);
> +	spin_lock(&evf_mgr->ev_fence_lock);
>  	ev_fence = evf_mgr->ev_fence;
> -	if (!ev_fence)
> +	if (ev_fence)
> +		dma_fence_get(&ev_fence->base);
> +	else
>  		goto unlock;
> +	spin_unlock(&evf_mgr->ev_fence_lock);
>  
>  	amdgpu_userq_evict(uq_mgr, ev_fence);
>  
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	dma_fence_put(&ev_fence->base);
> +	return;
> +
>  unlock:
> +	spin_unlock(&evf_mgr->ev_fence_lock);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  }
>  

