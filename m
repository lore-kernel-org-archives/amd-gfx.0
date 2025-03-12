Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CFDC28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 15:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C509D10E163;
	Wed, 12 Mar 2025 15:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VB926uBA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA87A10E163
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 15:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCLoywMqZYuHloq5Vpdnw7iGaW0IrnadWopraInMjVLCsC89GMGi9SatQFCTwLZPUpcnD+emcRmzaYqXVIFLg2JPlHr87dxoCuDNTr6OS6a0uMVXt/KJf1MacUZHI2HSdJB7sPQPT2BjChVqrsKRIj0sh8rzm6rU8CLn2/F3UhVbJ4FU+1iCD+t15Fd0lZyfPJQOCngNnyISHcGdsCJy6NUtiD5Y0gv3cvYEnDrhoZwCxLX8zSpcpmxKrXrVizI5Moi2cODoRx7ti/Zkmdy6wh+xELZSEAqp3L5XqDxL1jHlrH8h8hTu7tVb1kCmDiUNN62flVxtULnh5jukiXddUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUY+hIhGL5ZTtdcKXtD6bN319zvqElvW3WP9F24OoP4=;
 b=eBNRxwbxiqkeBSaMjz9RmbUbt0yeJgmgafb0JrC8Qvrcz8w44TGxkXvTzQevU8v/5pLLO1Evf2Qjp8JxkdrslDsRQluBcOEGVn0fcj+a+mJM+aSwLzdKyUKfmOHTFHMcbqG5IitPvD5hS8wEJC/Fta8ygs0KGu4Q/3aoBDe7UOyWz029iWUj9ZxoscUN5auhW5sEJkcC6/hfsngBfW8YnPpNUwoUb2PmL1usW+k2EWkd4FBF0Qu5qBw7YUEpNrO3G1dyVZIGEdFc+qOfG1S0p/jizMI04l8JmgRrbaO0fMYfoCwozhKnU3BWfjlwzPTanPBVc66WOsQMqO7Lqt+f1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUY+hIhGL5ZTtdcKXtD6bN319zvqElvW3WP9F24OoP4=;
 b=VB926uBAM1UK4rbo8WP5o8MOaoWeQab2iI9IG5Fee6Bz7eubZrO0/8+H6CmjVcjUcQuFdk5iuqoU8m0o/Zg2zjKVI0MuyfqupcvYMtlo8f9OMwMhRgIVTS7G3/7rHC0WCLmyIZ7d1Rq4ioqagVREGeN37jHr9XLe+Vhg4GX6zYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 15:10:14 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:10:14 +0000
Content-Type: multipart/alternative;
 boundary="------------qM9GG6b5GbGUS04tjoMCutP6"
Message-ID: <f42ac493-af98-468b-912d-af4b9f821449@amd.com>
Date: Wed, 12 Mar 2025 20:40:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] drm/amdgpu: stop reserving VMIDs to enforce isolation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250307134816.1422-1-christian.koenig@amd.com>
 <20250307134816.1422-6-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250307134816.1422-6-christian.koenig@amd.com>
X-ClientProxiedBy: PN2PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::32) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: e83f9278-a94e-4657-c378-08dd6177fd6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R25sT3FjWHlNWENRTzdGRE14TGRyTlB4LzdlVEhkbEJWemk0Nk9xV1hsSXBX?=
 =?utf-8?B?VFd0eVo4QkNUWFJuZUZOSVZFbjU1dkFaZmtsNVZxY0ZXRnlyVWI3UnloQm9y?=
 =?utf-8?B?bTdzVnRob0NNMjFrN2wzMmtQbWRQOEdlMFdGSS8wZlNuNjdvc1Z1ZnlwL1Jh?=
 =?utf-8?B?YVFDdE9mTGpmS1N4YVFnREUxQm9Wb05TL1JUSU9XZ0xScjY3cGs0QjJoemEr?=
 =?utf-8?B?NVpoVmJzQkl0ZmFubjJwYUIzNkdYUGQ1YlhpUEloZVZTOFY4dzJqMnhjOXVj?=
 =?utf-8?B?bWlUZHZZY24rQi9PbGZsRWRIN3VTaDdwNE5xWFREOE5BQTI0SzBkVndDWW5p?=
 =?utf-8?B?UWhyMU9pOTlFVjRsN01ZQ0MrQ2lrU1NwVzJqSi9rb1daeTBEOVhHK2puNWwv?=
 =?utf-8?B?bEQ4a2RnR24wTnJMUGd4U2RzNWEzQkc3bmhiRXBBa010dHg4WVdLRlpTc24v?=
 =?utf-8?B?OTFQNzBCSlFlZXpPeHN0Tlh4Q29FS3VvS296alIxa0NjTGphUTdYYmo3Wmk2?=
 =?utf-8?B?elQ3TDUxN0VXUDh4ekVPNkoxZTN5ZzRQT24yaHl5eUxrOWd0ZmZYVm53T0hH?=
 =?utf-8?B?ZFl6ZHloRXpLTFVlMDREU2ozUDFyd3ZpcjJGZjg2ZFY5Y3JzSXl1TU95YzYv?=
 =?utf-8?B?NmEwdGZFSW1OZlBNY0MxemhQZ2Z6MGJRYVloSmJNZ2g1TW50c1QzV1FUYWtF?=
 =?utf-8?B?V0wxZGdMZFhtRStpT0VPcEJHRGFiSUVNWnlUUGFUK2RwUUdJZk8rNDBJT3hE?=
 =?utf-8?B?KzRWbkdKd3J6YlJUWEFDRnRFSGl3Q0tuZ2QrSnlqVDk2N2tTQ29BdWZoSWZh?=
 =?utf-8?B?VWRrLzNBZFVoUEJnM08rc3BicVdaczNrMm8waVdmVkFwdUFQcUx2WWZTakw0?=
 =?utf-8?B?S09IdkNkTTFUMTFXb200V1RPU2U2V2hCTzV2T00yRWZGcDQ5c1Y1RVZFMjF1?=
 =?utf-8?B?TEFrTlA5cHh3L3JWWFVlUWNUV3FwamE2YnF4S1QyTHZLMDdmSzlrd1pwOFNI?=
 =?utf-8?B?ZWtuUTBUQ05EemJkN0I0SHhtbDRFWlM2ZW1uZ2Zjd2g0djdzV2xCOGZZc3Ba?=
 =?utf-8?B?bFFPeGJ1OUdvSlJPQ2NsYmk5cExyOUhlelJ3UVF3Q1Y4TEZYVklJRHlWUmdS?=
 =?utf-8?B?MjhWMjNpejBISW4xSUtQTGNnNm5wcGNZaHZqdGY4dkNBOTNEU0U0VnN5ZnNJ?=
 =?utf-8?B?ZTVQeUdQQStzT2pvTmJMOXpGaVNyalZsdGt5aXBzenNpNit2L0xQU0pMcEcy?=
 =?utf-8?B?d29QUWZ1SlpTSWVUSlZkYVJhUHl1cWVlUTJGT3N1M1NQcHdGT1VJQTQrTkhK?=
 =?utf-8?B?OG5paGk1Q09INEU1TW1EU3BybjRYUkh0YlVxNGU0ZGJPL2lzNk93bm53NUxQ?=
 =?utf-8?B?OUV2ZHB0TGp3VDRpRjhlSTNseUF4QWQ1aDhlZTN4VTE5M1d0WXUvZzg3eGR1?=
 =?utf-8?B?MldhamlJMHdUVFFNNG1vR2JlNGlEWWRaVGU3Z2FIakxzRmpCM3g0MS9XbzI2?=
 =?utf-8?B?dTN6RXNvMkwweGpianFOeGFoR21ZbU8xN05aNjlzYjZOSmxwdmtDSzdiUEg0?=
 =?utf-8?B?aHNDM00vMm9vMFNvWDhRRFlqbEhIMXZiUjJCbVBsMG5PSWRrZTJkVGZSSTZN?=
 =?utf-8?B?TWJydklVdVM2VkFiSkYwMmNlUVJFY1lNZ3VaSFVsNG9GSnVTZCtTVnd5M3Iw?=
 =?utf-8?B?QXd3MEJMbE1XREdjQU8wVkQ4Zm03YnE4c2dQdDFVZVgzemZpcHYrM3N6eVJ0?=
 =?utf-8?B?S281Mkx2S1dzclVuSXUrM1QxdFYreDBxd2VPL1dMejBpOFZHY2FPMEtTdnFD?=
 =?utf-8?B?SzRLT0xKeTMzMW8xdS9Qdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnB0V0RlRmhFUEdtZDZiTnlvb0FaTFhjNkk5WnI5OWN5ZnZnV1MxT0FoRERP?=
 =?utf-8?B?RzRIdXpYbVpvNGc3TnFHemN4Y2M2ZUY0M3F2ZG5MNUxpVG1VZVB1bXJXTHdy?=
 =?utf-8?B?cGRpVWFSeHBBNkVHb2VsVGdqN0pJYlE3NFhyMTZRZXNFbTNKdHNCUTBzOU9x?=
 =?utf-8?B?THlMVGFvenBxak1SSnA4U0NvQjZTTElmenhPMlAyWTBTajB0VGVIcWk5ZTQz?=
 =?utf-8?B?bmF5UHVQRE9pTHZsaS9Qd0xMWkticHNsc2V6cDdNeWtPbS91NlR3M1plaUtn?=
 =?utf-8?B?bnNrYkY2TldqM0dYZ0lhdndYRGorelJxaDZRQkVjR0c1RWlGRGhmVlVtU0tF?=
 =?utf-8?B?WGdBN2E0aVlUem5ZYzBXUnlGaVVOZStTU28vSmVvVnNmRlRtZWxhMkQ4d0ZU?=
 =?utf-8?B?MmpvMStYYW9XRGxnVUhkUG9tVE5HVFV6ekJhWU1KeEY0Y0pqbzltbUtzOTc4?=
 =?utf-8?B?YXY1a0JJcnlnWDU2SGdBR0ZML3B6c3kvUzdKaTJNSnk2UTNiMldoM2pqUGd5?=
 =?utf-8?B?KzNJN3BjcVpUTy94OUEvWXg1MDh0RE15WndEUUdPcEZwSkF3Tk1pK3FDMEZF?=
 =?utf-8?B?cUhWN3NheUgrRlUxdGNxbkVXSHJEVU5HbkljMEI1NWxURk1BdnArRlJNbm1h?=
 =?utf-8?B?cjBmWTkxZW5pUVl6VFRDN2dpbnFPS1JVNE9yVFNQT21KV2l0Z0VZcS9ZSmkw?=
 =?utf-8?B?a1VncFp5L1NPMWtIdnJSQ2xUMnBUUGZ1ZUhvVUxJNllDM2xseEZTVTZjUXpa?=
 =?utf-8?B?QStDZElSWE9VWUZ2MzdNMWJPU2o3Rk1KYjFMSmlmTnFvNkhzMnlJT29IdE1v?=
 =?utf-8?B?M0pldTdsclB1RUVpWFJ1Yml6ODJ4MUI2THRsZDNxaFJPOVpVeGRweDZUYnBO?=
 =?utf-8?B?SXZVUzYrZ2dTNm1aaUhxUWFaMlJiUFJlbVM2Z1RMUVRFWFVMeWt1OUhYaUFW?=
 =?utf-8?B?aEJwZWhOUDZnYTJTMEdMR2tTek1hZXF2WXNBUE9zTzZqdnR2ZVVURlc1RVI3?=
 =?utf-8?B?UEF3NlB0S1ZtOGdqUXk5cWpBZXh1Yjg5cmIxL2E3dlVLUVNtN1kvUHlTOWJq?=
 =?utf-8?B?S1dJOFVoZ0VOdWdpa3lGL3phQU1PdzdVbWRwQjJWMFJHVlFLemo0dkx2OWVo?=
 =?utf-8?B?Slc3K2dYVzgxVmExVFVJU0YyNDNwWDlxYWg3MGtsZnhNNnBJZWNGcnpxc2dL?=
 =?utf-8?B?WnN4NDlOWE5KejRTUXZNN0hRSFFTc0Z1eUdURlRWeDhpcENnN2RQdWRmbmVB?=
 =?utf-8?B?VEJPanhxd3h4ajF0TVcrRFZzVUhtckFGM29GcWtYd0Q3KzNoWU9IQUNWMDgz?=
 =?utf-8?B?d21kSEE0MzFMMXJSM3JIcXg0MjBCcTVSK09PTFA4bzlMV3hDa2hmWklnOGdM?=
 =?utf-8?B?ZlRwMWVQcmM3dUtMUTlOOFV6elFSVHNYaDM5aXpOT0o2WXJBQkxVaDlEZGJv?=
 =?utf-8?B?UGRvUFVUU2VYTXhoZktDYTU3RkZEYWlkeCtGK01jM2Q3d3YzaXpYTTF5NS9i?=
 =?utf-8?B?TFZsNDRnbXJwMTVTUTRMbEZCaDdPU1ByMUs5ckx2aTg0YmhPU2xnWU1BWnpt?=
 =?utf-8?B?TFY3MDhkZmRXUE9zUTJVc2h3OG5qVHJaM1dFRWU2WjNmemczTEpVdzJRQjEy?=
 =?utf-8?B?dnJxTHJQTENCVVh2NmpIbzgzc0lRQlhvS0xhZVFid2FyMWFsUWJoekhtRkgy?=
 =?utf-8?B?L3REWSt1ZDhjVVd4K2VpQWVvRCt1YkpvenhhN2lpeHJ5MnBtQ3RnWFMrOHZL?=
 =?utf-8?B?bGg4cUdnV1J0ajNXeHcyLytRNHdVT2E0RUZrTkl4RElhYlQ3eFU3Zk5tVW5M?=
 =?utf-8?B?SURqL2c4Mm5FdWowdVZvTjN1Z05vWjJXb2FOYjRoU0FoKzY1TWRyZkVEZXMx?=
 =?utf-8?B?dmZuZWRzeVY1b1hmUExMblZYL0hlUEhhUitWb3JhaUlUN0M0NVFSd0xqSW9C?=
 =?utf-8?B?ZWw5ZTNlWHZJOGIzZVV2Q3VVbU9Sai9mZHlUNjYzOXhqMnY4ZnM4MEQxNGhs?=
 =?utf-8?B?ZmRPRVc0VHBqZXlBUlhRTW5NaFFtVFpaODgzbE1OSnhiZmk2L3Q4UWE2a1U1?=
 =?utf-8?B?TFErZWR4ZFRkZVoyeGZUOE84Y3U2NEYvcVZWTElPTFRsLzFkTnNUWjRYaGVH?=
 =?utf-8?Q?/JHEeJMwKc6yXZ7zy1sUYkYYT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83f9278-a94e-4657-c378-08dd6177fd6e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:10:14.1094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k967ybaqTEjKLYxL5w1GtLRLoj5bre3VoYyDfz1W2GSCYKu1Sp7h4qkHr26s0bPG2wQU1jvBzmn6TPNKx8+54w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

--------------qM9GG6b5GbGUS04tjoMCutP6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/7/2025 7:18 PM, Christian König wrote:
> That was quite troublesome for gang submit. Completely drop this
> approach and enforce the isolation separately.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  9 +--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 11 +++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +--
>   4 files changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 2ce0c6a152a6..4375e5019418 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1111,7 +1111,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   			struct drm_gpu_scheduler *sched = entity->rq->sched;
>   			struct amdgpu_ring *ring = to_amdgpu_ring(sched);
>   
> -			if (amdgpu_vmid_uses_reserved(adev, vm, ring->vm_hub))
> +			if (amdgpu_vmid_uses_reserved(vm, ring->vm_hub))
>   				return -EINVAL;
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index a194bf3347cb..9e5f6b11d923 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1665,15 +1665,8 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>   	}
>   
>   	mutex_lock(&adev->enforce_isolation_mutex);
> -	for (i = 0; i < num_partitions; i++) {
> -		if (adev->enforce_isolation[i] && !partition_values[i])
> -			/* Going from enabled to disabled */
> -			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
> -		else if (!adev->enforce_isolation[i] && partition_values[i])
> -			/* Going from disabled to enabled */
> -			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
> +	for (i = 0; i < num_partitions; i++)
>   		adev->enforce_isolation[i] = partition_values[i];
> -	}
>   	mutex_unlock(&adev->enforce_isolation_mutex);
>   
>   	amdgpu_mes_update_enforce_isolation(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 92ab821afc06..4c4e087230ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -411,7 +411,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   	if (r || !idle)
>   		goto error;
>   
> -	if (amdgpu_vmid_uses_reserved(adev, vm, vmhub)) {
> +	if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
>   		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
>   		if (r || !id)
>   			goto error;
> @@ -464,19 +464,14 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   
>   /*
>    * amdgpu_vmid_uses_reserved - check if a VM will use a reserved VMID
> - * @adev: amdgpu_device pointer
>    * @vm: the VM to check
>    * @vmhub: the VMHUB which will be used
>    *
>    * Returns: True if the VM will use a reserved VMID.
>    */
> -bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm, unsigned int vmhub)
> +bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
>   {
> -	return vm->reserved_vmid[vmhub] ||
> -		(adev->enforce_isolation[(vm->root.bo->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
> -					 vm->root.bo->xcp_id : 0] &&
> -		 AMDGPU_IS_GFXHUB(vmhub));
> +	return vm->reserved_vmid[vmhub];
>   }
>   
>   int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 4012fb2dd08a..240fa6751260 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -78,8 +78,7 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>   
>   bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>   			       struct amdgpu_vmid *id);
> -bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm, unsigned int vmhub);
> +bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
>   int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
>   				unsigned vmhub);
>   void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
here we are trying to remove process isolation based on VMID's  this is 
because the constraints that we have limited number of vimids, that 
could be assigned to limited number of clients, now we have switched one 
level above, that is rather than enforcing isolation on client VMID's , 
we are directly applying enforce_isolation onto clients, but not on 
client's vmids,? so based on my this understanding we have removed the 
enforce_isolation based on vmids in this patch6 & now we are doing 
process isolation directly on client based on 
https://patchwork.freedesktop.org/patch/638081/?series=145031&rev=1 
<https://patchwork.freedesktop.org/patch/638081/?series=145031&rev=1> 
ie., based on patch4
[4/8] drm/amdgpu: rework how isolation is enforced v2, we are doing 
process isolation directly based on first client ie., based on who is 
the first client or first owner & then after completing all jobs wrt 
first client or owner , then it is switched to second client or next 
owner? is my understanding is right please? ie., based on 
"amdgpu_device_enforce_isolation()" function
--------------qM9GG6b5GbGUS04tjoMCutP6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/7/2025 7:18 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250307134816.1422-6-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">That was quite troublesome for gang submit. Completely drop this
approach and enforce the isolation separately.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  9 +--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 11 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +--
 4 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2ce0c6a152a6..4375e5019418 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1111,7 +1111,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			struct drm_gpu_scheduler *sched = entity-&gt;rq-&gt;sched;
 			struct amdgpu_ring *ring = to_amdgpu_ring(sched);
 
-			if (amdgpu_vmid_uses_reserved(adev, vm, ring-&gt;vm_hub))
+			if (amdgpu_vmid_uses_reserved(vm, ring-&gt;vm_hub))
 				return -EINVAL;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a194bf3347cb..9e5f6b11d923 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1665,15 +1665,8 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	}
 
 	mutex_lock(&amp;adev-&gt;enforce_isolation_mutex);
-	for (i = 0; i &lt; num_partitions; i++) {
-		if (adev-&gt;enforce_isolation[i] &amp;&amp; !partition_values[i])
-			/* Going from enabled to disabled */
-			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
-		else if (!adev-&gt;enforce_isolation[i] &amp;&amp; partition_values[i])
-			/* Going from disabled to enabled */
-			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
+	for (i = 0; i &lt; num_partitions; i++)
 		adev-&gt;enforce_isolation[i] = partition_values[i];
-	}
 	mutex_unlock(&amp;adev-&gt;enforce_isolation_mutex);
 
 	amdgpu_mes_update_enforce_isolation(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 92ab821afc06..4c4e087230ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -411,7 +411,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 	if (r || !idle)
 		goto error;
 
-	if (amdgpu_vmid_uses_reserved(adev, vm, vmhub)) {
+	if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
 		r = amdgpu_vmid_grab_reserved(vm, ring, job, &amp;id, fence);
 		if (r || !id)
 			goto error;
@@ -464,19 +464,14 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 
 /*
  * amdgpu_vmid_uses_reserved - check if a VM will use a reserved VMID
- * @adev: amdgpu_device pointer
  * @vm: the VM to check
  * @vmhub: the VMHUB which will be used
  *
  * Returns: True if the VM will use a reserved VMID.
  */
-bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm, unsigned int vmhub)
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
 {
-	return vm-&gt;reserved_vmid[vmhub] ||
-		(adev-&gt;enforce_isolation[(vm-&gt;root.bo-&gt;xcp_id != AMDGPU_XCP_NO_PARTITION) ?
-					 vm-&gt;root.bo-&gt;xcp_id : 0] &amp;&amp;
-		 AMDGPU_IS_GFXHUB(vmhub));
+	return vm-&gt;reserved_vmid[vmhub];
 }
 
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 4012fb2dd08a..240fa6751260 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -78,8 +78,7 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
-bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm, unsigned int vmhub);
+bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
 				unsigned vmhub);
 void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,</pre>
    </blockquote>
    <span data-teams="true">here we are trying to remove process
      isolation based on VMID's&nbsp; this is because the constraints that we
      have limited number of vimids, that could be assigned to limited
      number of clients, now we have switched one level above, that is
      rather than enforcing isolation on client VMID's , we are directly
      applying enforce_isolation onto clients, but not on client's
      vmids,? so based on my this understanding we have removed the
      enforce_isolation based on vmids in this patch6 &amp; now we are
      doing process isolation directly on client based on <a aria-label="Link https://patchwork.freedesktop.org/patch/638081/?series=145031&amp;rev=1" id="menurlkr" href="https://patchwork.freedesktop.org/patch/638081/?series=145031&amp;rev=1" rel="noreferrer noopener" target="_blank" class="fui-Link ___1q1shib f2hkw1w f3rmtva f1ewtqcl fyind8e f1k6fduh f1w7gpdv fk6fouc fjoy568 figsok6 f1s184ao f1mk8lai fnbmjn9 f1o700av f13mvf36 f1cmlufx f9n3di6 f1ids18y f1tx3yz7 f1deo86v f1eh06m1 f1iescvh fhgqx19 f1olyrje f1p93eir f1nev41a f1h8hb77 f1lqvz6u f10aw75t fsle3fq f17ae5zn" title="https://patchwork.freedesktop.org/patch/638081/?series=145031&amp;rev=1">https://patchwork.freedesktop.org/patch/638081/?series=145031&amp;rev=1</a>
      ie., based on patch4<br>
      [4/8] drm/amdgpu: rework how isolation is enforced v2, we are
      doing process isolation directly based on first client ie., based
      on who is the first client or first owner &amp; then after
      completing all jobs wrt first client or owner , then it is
      switched to second client or next owner? is my understanding is
      right please? ie., based on &quot;amdgpu_device_enforce_isolation()&quot;
      function</span>
    <blockquote type="cite" cite="mid:20250307134816.1422-6-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------qM9GG6b5GbGUS04tjoMCutP6--
