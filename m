Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE86DFCD0C1
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 07:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E0510E0B7;
	Wed, 18 Mar 2026 07:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K+IVV0z/";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254BA10E0B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 07:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPJZHSbg8j4ZytInqgBz4+Rwkn2zuCsCGTpEvL8PDwQI8acFXnv9MPTcnyp3hsnpjv7TXdg5d1SAFqdkz97s0yt01+WIwaAlv4JJTIqm5lGU0GRbLQf84HfMdr2p70y0vMw/QpjitHyzBlclX/q51XaLJTItoKv5JaHkeDln+z70yNEwKMXSxywMmWJ+Pz3NC+wkdY691jOO3wL8qroFO96aF/Z5cLW/JTBEOWtAcoNQy/ehGKLCSe0I7yA+YjMgeH6/XPXrXY9nwyCF3nqHl30nuCkGEuozX4Ns6TQoitbMnG0J3cAa8iUE5U4EmVn2dygosUel5vArqhoLyJ/wFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJoV/nI/QAPugMm+2+GyTaPRj2ZRwk7pl2IeKiMHPVE=;
 b=IwtxwSgE3zSuR4W6uQVkqIK8un6BnpTyWHOz3/QELbCWa8+K/+NfmYWdgKBifRPteFz7EIxJTyg9H6zkbHtXywdJt1klr5Q4DM3UZco8/sMNBauBsen+RsA1mGRTEZ78clNOgQV6++d9FwE7/ooq8M0G9gpI4RzTUEJfbp857G3QxyzVFQ8/Jw43SKYRTXR076At9d7Rp0VG4TDJTZbwkspmGSpon48qu0C9/IUf5u1w20iVgGTaXSLNEZXqSV+2FqcK4Oh0CFh2Nlz+f8Xm8rpm5VQz0I3Gwdyrn44xC2JTnJwd/+qtclR4YdPo/dmtQEfrsYQutqKyaKqYfE1Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJoV/nI/QAPugMm+2+GyTaPRj2ZRwk7pl2IeKiMHPVE=;
 b=K+IVV0z/5p0Al2SS+HumnDInBF8Es8OIlLuZZ+Uyg96z4IC4tVItcPGb+eTVQbq4t6ff0EXcsw9vvMAB2OAmGnD3t+yFI0CksUFnkqp7kLWNMu6Ui4gIX2Q0Cg3gqReVJypI+HluhbF9FrrVY5ld6ogyHKxrItfHZo1vSZZxBpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:05:43 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 07:05:43 +0000
Message-ID: <d3cabe42-0586-4773-8f4d-141d7657bea1@amd.com>
Date: Wed, 18 Mar 2026 12:35:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use stack variable to fetch nps info
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
References: <20260311060517.4010519-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260311060517.4010519-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0132.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9a3537-d41a-43b5-9a20-08de84bcc50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: cNpJsNE15brP4j3iIvaC9eDTFqfymLZ7CZV5Gcr27tykSE1NZwNrynQueI7nj/oHKq3wXdQ3EaDMVECfCxDATJOGBuogKJF4SoDMVzxkpJWMbFAvl0POxqoktG/6IbkH+fdkuJmQT3Y598BQ0jEqfuAq7EyqX65IkTZe3at60N2hvIJn/uBY/EM2CJFZLB6U8xqb8NhZ12mA2Ntl05mXcdSseKQkHt4jd1hjqQSBjiPBkvus3LY6zVanfq14LVW9jzkLI3xYh+iK+XaoMn9HPv8sfbgOXhtzMITTTsiu9Uso9aFDaLZA2LJ2j472Or00XSpOtxnpzeegz58zdsVBO1uwcouYmguNgon+aWbvfnXm5Vj4WNNLMhDLsPPyNIh4Bl6ZepJENGVGYG7IEscrbCVDo9KUqL64lyRJMAtXg+xGMgOaZD3XpUIKH+4BGGJ55ONjdfoiN0bZzj3S1b4vBiHp+rlA6YH39gk6L4caf1XhJALNh8X8B/Y0p0D5sIZLG+hmqZDL4GkdDDf6wTYHaDQZQFHU3N7V5WOUZlcm9T9TbMN6RaB/UCTpRERT+6TlLPgJzBO0N8s2e4G5BzqJADtgLu5Pwa3Tkl8VDCiK351HYJo9MuQ8kFuT/L5sP1s+Rtd/GwXjbS++D/MLVO6KyaSwzf1H3HXtGgCOjM0uJn9JaPJVL9OWXvq2Ko4KI/o0zty50UeZjHJNSgGVeVFulOHy7R7aBnR3PJCmqb/VcmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU41U2JQSXJrQUFMMWxHMmRTaFhnZnp3YnNURmw4VUZibUxNTnRHMUZJRkdz?=
 =?utf-8?B?WUovNXFiYzZTL0FUNnY0bHp6V0QwRUxkRmpteWVFcVhLeEl0RnRIbjZkN1V0?=
 =?utf-8?B?VUozQjBsT3ltY1c0RDhIck9ET0cwWm1aVHplL0JjZWl4ZER5UjVCQzBHMFNx?=
 =?utf-8?B?aG1Gd0pLTVlOaGkwakw5TlVRVGNIOVRvSURadE5yMTRCZGhuWE9rOGgxSnRK?=
 =?utf-8?B?OUpWbWhOaVF2cG45Sk4wOHVMaGpmSEZuN0o2TVBpMVlLakVOV3dmOEVPK1Bw?=
 =?utf-8?B?SjhoK2hjZnhaSFh5bERnUDRGaGdhK253R0I2VSszclk4bnVQdzZ3SEN2MUJx?=
 =?utf-8?B?ZDE0VnFSMTR0QldQczlPUEV3N3FuYzliVmw0TlFmL0ZtN1VaMWEvNzYwelhH?=
 =?utf-8?B?UTgrQVBvb3NqZWtOQzZVU29ON04zblpuWmZ0OWkyNFBmdGFPU1F2Tk9vRTMx?=
 =?utf-8?B?Nk1SbTRsaDFjSzJZUi9yeFFMMEhnYTVDdktUdzVYM05RWUF2Wm92NmJnV3Nj?=
 =?utf-8?B?RVhxQVg2VU1kUmQ0dndIeWhuZHM4QXFEUWVwWC9xK042TlU4NTZSRDdLdFJ3?=
 =?utf-8?B?VmhiaWZZV1dBNVc3K1NaM1NTSWkzaVdETmVRSEl3U2VrYUhEM0lsK3pZYnpD?=
 =?utf-8?B?U1dINW5HOXB4UjNmajZnUDdsbVJxZ0tkSFBrOTJwVytDVVQvZGZsNXZGMmZp?=
 =?utf-8?B?S2FsSmVOcDQxb0dqOHdWK2wvNzhZNDU5ajZJM0NXUGJDU2MyTDdZMmxhMGpz?=
 =?utf-8?B?N0RhdkxEcURZSDlJTGw1OXVrbnVpVVJoMFp6WlVJTUl5cDYvY05GNGhNVXFO?=
 =?utf-8?B?L1d3VU1ZQzExaUdMWlIrZWhMMnpucjZkaFQ0VEFxdzZKL2xtOFM2c0dBdmZz?=
 =?utf-8?B?ZnhGSzluZ0wxOXBpbGFnTGNnNlRJeGJWMUxOQ05IWFNkT1BXVUM4TkN6MDA0?=
 =?utf-8?B?Y21BeTJqR0NLaS9kT3RTWDhEdlJBL09TOTgxRzBIQkNaQWVsQkxNTXg5c0ZK?=
 =?utf-8?B?NWw0dEVyOG1HWHMxSWlURDVpOHMwR0xWeTVqYkFUUmJBdlpTdmQ5UE5PZkRI?=
 =?utf-8?B?aisxbGZtcURTOFE5WUlUNlVXQ3JDUHNDODdYeStVT25ncEd1M09zbVBubkRW?=
 =?utf-8?B?WHgrUkpKMzlXYUxQdzRyVzlkMW5Ud0lLQVlqVitSa3d0RWxzZ2RzNm5tUWhH?=
 =?utf-8?B?RUJocnc5ZUNkc0JTYXB3bjExaG4zS3l6cDM1Y1dqWUlKdmIvS3JYcWJCeThL?=
 =?utf-8?B?cVpYVVRVMTRIMTd5SGZuczZDdDcrTDB2RENKWVZrWGx1Q0xCbjI4WnRZdDhN?=
 =?utf-8?B?R3dFYnVMUUhWWGo0UFJiMWhVV3hHZlVReTNhSndGK2o4dnRWV0NqQitoRHpQ?=
 =?utf-8?B?eTVQRmZ6elFjSzZKc0FxNnlVSWlJeElUZ28vc0kwaGJmS0FrUWpGdlY5R3cr?=
 =?utf-8?B?b3Yza0xkSDMxSTJjbjRaTlBwbFF4dUhaWnRhSERvSU5FaGlhTkR2ekhHbzR1?=
 =?utf-8?B?bDVYMmJsNWNWVzBOaFk3c2tWNHVNWlkweFVhbmZnZmhWY2F3VG92dnRyUlZo?=
 =?utf-8?B?d0JSeXR0R2hEZko4c3JweHFKck9pTjRWV0tlT1ArQnd3a0UyZjR2aFdCeWZj?=
 =?utf-8?B?UjJLa2llT0I0aTR3dTlQaXNDaFJybVZNVkxkL1g0eHFCSURyU2JWVTlxeVcv?=
 =?utf-8?B?WjM3TmxhTUVUK1k0SXRTNGgxOElkdjBDK1E2OUNhTjBCTFlTbU50Q0JCbDla?=
 =?utf-8?B?ZXo5NE1ZcTBqdjJUa3BGRGhtVU83c05LUWRyRUduMGxZUlEwT1NXNnZlTGQ3?=
 =?utf-8?B?NnlZdFFoNTJ6YVhaUTM5VzlFV05leEJudGVTZ2Q5SzRJdnVuSXBXSkRuNWMw?=
 =?utf-8?B?bkhXYTU3TUh0bDFMcWhYTzVNdXcwVUdlY2VzV283Q3BSQ2FSVkNzK0E3T0hz?=
 =?utf-8?B?V2VXN0tOYVVFbElJSzdjMjBzMDd3M2FKSTJpU05JYlNpZm9KREJkNGFjRHdj?=
 =?utf-8?B?ZmZyN3lVTUVOS1pEaGdrT1phMzNFWmNCVFBlTFNuUnFUYm91MjlHSlY3K2lX?=
 =?utf-8?B?dkE5aG1wbnFRTVBUcW9XcGdid2ZEYTI3ajRIdmg1azlFNjBlNld1bzloVDBD?=
 =?utf-8?B?d2lEc1NhQXUrQ2hGOWdFZ3JQRGIvdWRkMlhORUl6VjlHSHFxZkl5TmR2L05K?=
 =?utf-8?B?UkdSNlRubTJxZmVxTnVkazhsQldqU1BpOXVRRmE5OWp2U281bmVYTWRFZ2Jz?=
 =?utf-8?B?bjBzdSt0eGE2cnY3V0VNcmdtS21UWG1nTXJrVVpkWldOU3hDSGJyUU5ySEpY?=
 =?utf-8?B?ZXBPRGFSRmZGQ0k1dTM5QXZhK29RV3BCb21EK2Y5MEorcFNHbW1SQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9a3537-d41a-43b5-9a20-08de84bcc50b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:05:43.1740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GI9DtjjGuTUiim7/mUNO8/poG2gLa7PTS1kJdxlrnFCxQQFA8NBhaIZfkiwCWrwc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082
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

<ping>

On 11-Mar-26 11:35 AM, Lijo Lazar wrote:
> Instead of a dynamic allocation, use stack variable and let the caller
> pass the maximum ranges that can be held in the buffer.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 +++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 10 ++++----
>   3 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index fad53d8344b1..948c5f40f366 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1932,11 +1932,10 @@ static int amdgpu_discovery_refresh_nps_info(struct amdgpu_device *adev,
>   
>   int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
>   				  uint32_t *nps_type,
> -				  struct amdgpu_gmc_memrange **ranges,
> +				  struct amdgpu_gmc_memrange *ranges,
>   				  int *range_cnt, bool refresh)
>   {
>   	uint8_t *discovery_bin = adev->discovery.bin;
> -	struct amdgpu_gmc_memrange *mem_ranges;
>   	struct binary_header *bhdr;
>   	union nps_info *nps_info;
>   	union nps_info nps_data;
> @@ -1973,22 +1972,22 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
>   
>   	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
>   	case 1:
> -		mem_ranges = kvcalloc(nps_info->v1.count,
> -				      sizeof(*mem_ranges),
> -				      GFP_KERNEL);
> -		if (!mem_ranges)
> -			return -ENOMEM;
>   		*nps_type = nps_info->v1.nps_type;
> +		if (*range_cnt < nps_info->v1.count) {
> +			dev_dbg(adev->dev,
> +				"not enough space for nps ranges: %d < %d\n",
> +				*range_cnt, nps_info->v1.count);
> +			return -ENOSPC;
> +		}
>   		*range_cnt = nps_info->v1.count;
>   		for (i = 0; i < *range_cnt; i++) {
> -			mem_ranges[i].base_address =
> +			ranges[i].base_address =
>   				nps_info->v1.instance_info[i].base_address;
> -			mem_ranges[i].limit_address =
> +			ranges[i].limit_address =
>   				nps_info->v1.instance_info[i].limit_address;
> -			mem_ranges[i].nid_mask = -1;
> -			mem_ranges[i].flags = 0;
> +			ranges[i].nid_mask = -1;
> +			ranges[i].flags = 0;
>   		}
> -		*ranges = mem_ranges;
>   		break;
>   	default:
>   		dev_err(adev->dev, "Unhandled NPS info table %d.%d\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index c8242992c912..1220c0327275 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -45,7 +45,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>   
>   int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
>   				  uint32_t *nps_type,
> -				  struct amdgpu_gmc_memrange **ranges,
> +				  struct amdgpu_gmc_memrange *ranges,
>   				  int *range_cnt, bool refresh);
>   
>   void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 20e1395b3988..f165d4e401e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1374,18 +1374,18 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>   				 struct amdgpu_mem_partition_info *mem_ranges,
>   				 uint8_t *exp_ranges)
>   {
> -	struct amdgpu_gmc_memrange *ranges;
> +	struct amdgpu_gmc_memrange ranges[AMDGPU_MAX_MEM_RANGES];
>   	int range_cnt, ret, i, j;
>   	uint32_t nps_type;
>   	bool refresh;
>   
>   	if (!mem_ranges || !exp_ranges)
>   		return -EINVAL;
> -
> +	range_cnt = AMDGPU_MAX_MEM_RANGES;
>   	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>   		  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
> -	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
> -					    &range_cnt, refresh);
> +	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, ranges, &range_cnt,
> +					    refresh);
>   
>   	if (ret)
>   		return ret;
> @@ -1446,8 +1446,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>   	if (!*exp_ranges)
>   		*exp_ranges = range_cnt;
>   err:
> -	kvfree(ranges);
> -
>   	return ret;
>   }
>   

