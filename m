Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C808C52D6F
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 15:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C939110E2B3;
	Mon, 19 Aug 2024 15:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lYyEuIlA";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E66010E2B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 15:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4fUprVGpXIFdzsHP06vRZ4dnHq0QwJXuQGnAlt5NG83hNh+DkN4kb4J6Oy5wbxmUAC0vnjz+ABFV+DecXdIEq0Q4NuEyL9V53R0GMCgBIjBrrs5UvqzP1xEhDuOuxLUlIHFbCoOrugWjIUjLudv1LsA5FLMgaXd7LGCNGLES84/2JNKnrrFbX83FyuJD0dOC1o5/LrSZ6uN29cUihH+wTuxznkC3Rmu/J4zvFiCRJ8K47BP3/mXHoF7/Mp+kODfx92j7LGcHfgMGG10iPqxjo8Wkg6RGOq1MM8ilGVbAaHgcIV7yDcXAY5rZCQWGfUqFxC5aME4UaCwcMrtv9rAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ0mul8eq0aZb2CB3/3o2H5gYxvwqJ0l0KnFU0BOnZM=;
 b=IjIoI/UiOyuiJ4uEgsq9XJkjSgfPUjDSJd0vTK3OqN5LrWC6b0uqTWsmSTqReRE41ykHcCVFfP8AueX8mJDhSkmpw1VSbUZv4ZYpDKilyX2CDry9KsEg6L7MGnXfVk89I/Kx/fepC/VMT/eUVRWgmcNvAuzmfvD9uIgJoIm3OaLgraSHn0yFg7i88SSiPdKgzOvrXT1suzsCJwmUFC51HqBbCFSHgIgN/SsSyVd5XGIceRbty+JJM5px650NMXXEjy3RVYSR9uYs9328xhFciKH+jhLoqgGnUGekCmzvV3ZbwgK4ifMTDsMSOo+/BZzc5zhsKe/LlBy7+QOd4ZpOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ0mul8eq0aZb2CB3/3o2H5gYxvwqJ0l0KnFU0BOnZM=;
 b=lYyEuIlAucx0Zkt+828tj8E5Xe9Uk1H9o+jP+bnUx5rskL1KT3oordquULGs0CSrKX+zHSPJd4nkBonXvmee5Iu2zUbGVZT0sAfv1PmxSqcNgCP6OdYWKvdNKlkdbv4/ByfWMOLznjns7+LbGJ6ftISMtJmRu9eujFoE3hhWacY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Mon, 19 Aug
 2024 15:02:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 15:02:12 +0000
Message-ID: <6130ca3c-1dea-4d93-8719-a7b481a00084@amd.com>
Date: Mon, 19 Aug 2024 17:02:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Block MMR_READ IOCTL in reset
To: Victor Skvortsov <victor.skvortsov@amd.com>,
 amd-gfx@lists.freedesktop.org, zhigang.luo@amd.com,
 christian.koenig@amd.com, lijo.lazar@amd.com
References: <20240808174808.854282-1-victor.skvortsov@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240808174808.854282-1-victor.skvortsov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 80461d41-ffd9-43d9-ea6d-08dcc05fe77b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzRyUlFjbVZlN0JJVVVOd0xxR2MwODhxMk9KUEE3azVXVGthMnBwYVBWZ0g5?=
 =?utf-8?B?dTAxQUZBUFdSTkxjT2VTQnhNL1hjYnBaRG4rNWtIMVprTGhhVWZGSmVTOU9R?=
 =?utf-8?B?blBqYnp6ekhUaFZBNUFSZUlEZ1poTVJGbWtLMG1IM0VEUmxXL2MxNnZRQ0xn?=
 =?utf-8?B?ZXNUQjQ4OStEK2Rsbmd5Qm4rSTRHY1M3OTYyT1VKY093YnNZVy9GU3FmeW1V?=
 =?utf-8?B?VUtRVlRTN216VmRIcy9RNTVjdWpPRDVpRU1IZDFaYndXbFR1cXBnT0creVpU?=
 =?utf-8?B?OE03aVpVSEt2eUFNSllxZGRzekQwUlQ1YlJGanBKVHNadk03cEFrdVlpN2Fh?=
 =?utf-8?B?djVxWURBaTlQTnBiSzNJY3BVekw1YUpqTGJxVy9QNHNCeDR6YmF2aVZNcDBq?=
 =?utf-8?B?TjdRYlBHVUdKNXZLRkhsc0c4NEtqaTlmQlVOelJ6VDFYTjRKdjR5aFZiVHha?=
 =?utf-8?B?blVscjllMXpLMTE4d3NqRk0wNHV6ZGQ4U0VCaWZ2Mjh6RUZKZGF2dGRNNVF5?=
 =?utf-8?B?akpLc01Lc3oxc2NEbG5oaVdGVkRrVWZQaHh3Yk5pL3VhWUhZUFZqeHQ4NmRK?=
 =?utf-8?B?T2srdDQ3VzZOZXVFZURmdGZhK1VEY1c3ZUg1RzJwOGdFRG5YTnZtZTJnNXF1?=
 =?utf-8?B?Y3ZRUmlXNGFwNnJpZ1JBNlBmNzZCNi9uUjdBcUZzVzhmcHkvY2w4cVp2MkZ4?=
 =?utf-8?B?dFdWVWtkdGhsS2tad3llNXNWUnJXVlBFTzNPSU1zcDJVR2YyYkJFRkhZS0ZV?=
 =?utf-8?B?M3BTTjZxanlNem9hb1ZSL1NKenF4bCtRSVVCakRsbGVvWkVRV2lGQ0xrUmpk?=
 =?utf-8?B?V0lYbEtDOTh3Tk9OUnJJZG9HVUVUYVlKK1F1bXV4Ukg4MGxsMFVVL3JKTDdh?=
 =?utf-8?B?Sll3djBvc3VDUFNOc2lGQk5uM1Q3NDh4WlRpdXA0eVN5eHVDb1gxeEtjK2lX?=
 =?utf-8?B?VnZJUEZuVkNYM2FGRDBRMGlFNEhlbGU5WkVNZ0FTUmFWbzdDczBTZVBDRkpB?=
 =?utf-8?B?YWFoaUN3RnN6ZGdLY2Y2dXJ2Y2NvQzF2b2pvM3hMM3FBdFFJMXU3Z1A3eFJ1?=
 =?utf-8?B?UFdFVXNONjBuNzkxQUNSU05Hb243Q3p4dTdiTjJBdTM2cTlFcmNCdjJxVTNx?=
 =?utf-8?B?U1BXQnNTOTBmNS85S0grejZVNGwxTm52L3JTN3N3UFRpRExKR2xlTWJiWDV5?=
 =?utf-8?B?VVo1R1pRQmIzY1d6UWNraUV1eGQ1NmNmL3oxaDNGNEU2ck1lZWFCSzYrbEZX?=
 =?utf-8?B?YUx0TUpycWNxRUgxWUdUU3l1QUhudlc3bVhKeHRHY09XMjk4dEZlTzJmcnJP?=
 =?utf-8?B?VXlIeFpVNEJMUVV1MGtrc3dSaFVEZGJZaGZnamlEQU1LS0dObzdLQzdsRXRX?=
 =?utf-8?B?R25YY09OWkpiNlVhWFBreUVHTWRlU3FoRHZkdXBmQzlZWjNCbFpzc0x1WG1G?=
 =?utf-8?B?clFJZmR2dlF2S2E1bDhaTUE4RW1SVFppK1EydmhYWGNmTWJoNUx5dm9YZmp4?=
 =?utf-8?B?RlhHN3BzM28zTXZZeE1lMjZoem9sV3N1NEdscjV3VXZRbG9DVEZFdWp3ZFFy?=
 =?utf-8?B?SXoxMnloZ2JvZmQvWnJzSlVPdnlDSlplRDBWSERFSGw2c0g5MW1VRWRXc1dG?=
 =?utf-8?B?MHZ2ZHlub1lqSHFUMzB0VytvQ2Y4V3huZ0pQNFFTalNNMmNrcFBMcXRyNmhN?=
 =?utf-8?B?Y2EvVEN5ckl4WU1ibmpYMDU0QVFrekJkYURrLzVJUnlsSUpkdXFtOVZXeWtw?=
 =?utf-8?B?OFQ3WDgxSytFK3dVRlpETitET0NaeE5LWU85K0VvYWNPZkI5MXpxT2ZLUmdH?=
 =?utf-8?B?RjFMcVNIdGxIaXZTdGZuZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkM0RDgzQ0hOWk1CS2hzVVlPTFkwR3EwcGJWejI0d3NURVE1Z0U0dHo5a09y?=
 =?utf-8?B?dkNUL0lqa0VUaDJlUDZlaDFSM0k0OTBXdHorcHFjaXdVcmxDOWtQT1hLVXly?=
 =?utf-8?B?ajQ0TGtuMVRBN2ZYMS9EejA4WEk1emZSQllGemlxN0V3UitKaFAvY05zNnd1?=
 =?utf-8?B?WXVVNzdUcDVKODkrb293N1V3L1loZjQ2blBIUzZYL1BOQmZrWkhSZDQraFNp?=
 =?utf-8?B?S2h2R1RBYjVrVmk1WDVRQUFYWUFsWENsZ01SWXM5cmQ2dDN2eElkbjY3UGhO?=
 =?utf-8?B?RXBUbW0yMWJHa3RTVWtCZzZYWGZ1M3FkNnltamJCRTdrOVFHSmpxYkhwdjFm?=
 =?utf-8?B?cStiOFhDc3hrRXdrdWtTOVZwbDc3dmtNdnROam5ETWprRzZqYlBvL2d4NHox?=
 =?utf-8?B?S2MzSGhFY3pndWUvZm9TVTE5TVZYeHBhMWIxdHQ0aGY5L3RBR1dqZ2h6eFdh?=
 =?utf-8?B?Yk1MeTdZM01SdTk3Y1I5WVczU0tnanBVVmdJZ2dNV2RmbzJrNEovVjZkQW1S?=
 =?utf-8?B?MmV2Z09yUjhsc2t2MkF4Zld4bkZLMnFJK1pXSEdXTHB1WTM0c1E0SW1YZUdB?=
 =?utf-8?B?b3NDcmJoaE5jbDE4cGlpMmVwT0ZvMDdwVStqQytzYzlod2J3djEvaUt0a1VY?=
 =?utf-8?B?S3NIeWZuYWU0YkNkK0EyaWV3aVFMYytqM2EvZFVVZW9KdlB1MllVZ0lVai9s?=
 =?utf-8?B?MVFCS3lXVzJTc0Vlb3hSclJSWXRmRVlGMFZZZkRPSDdLUm43cmYwUVhMYjl5?=
 =?utf-8?B?bkMrVG5SMVNQdzN6Vmh6M2tsRWxpRXpHTytyclFRcnhKSTBLbjNYV2pJbldq?=
 =?utf-8?B?Y0xwejBCMzVlYzNyb0pSdWRQK2R1TTNlT3pnOHZWQ0JNSnk2QWNkTE8rU2pn?=
 =?utf-8?B?VytqVXJzZmltdjBFNHd3VkQ0dmxMc2hQaXJsVnJ2TW5teENWQVRIWS9wU2JE?=
 =?utf-8?B?cUd0R0lJY0tkNVFzTXhPY2RyaUlKT2FXWFoxL3RKaGZudUpRcWgxS053OWNn?=
 =?utf-8?B?VXZmcFkxNUJDMXJiQlBsYy93QWQrWDRLeUZLVm9sNkUxalJ0QkgzclhHVklo?=
 =?utf-8?B?WUxPQXVuSVgzUlJjKzUxTFpxbmt4K2N5U20rY0YwbjNsb0tYV3c3RXROYWpL?=
 =?utf-8?B?ZncyTzlpbXRQNE1aS1oyZE83WW5xNGplQlRWTXUvODA1K1ZTVkFDMjZLR2xj?=
 =?utf-8?B?dXo2NXBlZVVNNndUUkVadjZPamphWmxMOHZ2MVZ5RmVWQk0wOTdxdjhWTWYz?=
 =?utf-8?B?QXdCSTN0eS9hY0RJMEE4ZFNMcGlidW5lV2g0dm96Qy85UmxrUy9QdUdDb0hW?=
 =?utf-8?B?dk9sRGdES2hZam5CQ2hHU2lIRmJJMmNYSWJkSW52SVRJSWNUVTBIVFh3OVJV?=
 =?utf-8?B?UWdjWGNuTGFaclE5MHBYV3NnaENjbHlMaHQ3T3l1TWJZQ25lMGlIREdQbE9C?=
 =?utf-8?B?MUhrUi9uOG5rc1IwZjN3M3BQdm0xZFY3YW1tYXdEQmFkdW1ZTDBHM2lHNU9F?=
 =?utf-8?B?V3JLK2d6cjE3R3V1aU5HZXlRbkRyaHgwQzl5TkUyOWZqM0J6MmZwS0oyZXBK?=
 =?utf-8?B?bE93TTZZWG5XZWtBVkNncVdRNVpCdHBURnVmQ0UrY1dOZW5md2NDOHkwR1Rj?=
 =?utf-8?B?Tm9Xclp0V1BqSC9PTHpUYWxyZlh3THdMWk1MTytpajJBelZGTUd1N2ptaHdU?=
 =?utf-8?B?SmJoMEx6TWlURzFJOW13a1VHM2NFZjh3bll4bFBlN3BoOC9yR0RpeUptakJ1?=
 =?utf-8?B?NkNQQ1R4S0tUVmFhWHVKOHk5ZXRLOTAwakZJQmRCWm5ETk1xU3g3SktsbFp0?=
 =?utf-8?B?ZjFGMWl2aHczbHhxQytKYk9nZ2h0R0F1Slg0dWhFV0NGSUwyNnE1RENxaTQ0?=
 =?utf-8?B?RWdLOTBCNUY0MkFKeWdTdEE4cStNbUs5SDNXamhhZVdCZnc5eklKY0EvNmll?=
 =?utf-8?B?cXNwZk9KMHQybU1YMHB0RGVZcWNxUmRpVmkrR0dERnV6TUZzSzRmWWpHWmlJ?=
 =?utf-8?B?ZXZOWXNkbVZQeXdhNTR0clM5YXBYSG1Kam9kVFFpanJaK3ZVWm9TR0FWVEts?=
 =?utf-8?B?K1VQMGRMNngrTU9pbWpKMUdFZXk4WnFRU2dpZjV6OGg1dDYyMTByZXUyVWtO?=
 =?utf-8?Q?Xcxc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80461d41-ffd9-43d9-ea6d-08dcc05fe77b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:02:11.9192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gyUx7s7yR/bh22r3YbTiLFxQ7Qco5eTsLOKIKgLA3lTu/88KaYWLi3qHcH3Ng3O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
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

Am 08.08.24 um 19:48 schrieb Victor Skvortsov:
> Register access from userspace should be blocked until
> reset is complete.
>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++-------
>   1 file changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 260cd0ad286d..038b400be437 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -778,6 +778,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   				    ? -EFAULT : 0;
>   	}
>   	case AMDGPU_INFO_READ_MMR_REG: {
> +		int ret = 0;

In general a good idea, but please fix the coding style. E.g. for 
example don't initialize ret here.

Regards,
Christian.

>   		unsigned int n, alloc_size;
>   		uint32_t *regs;
>   		unsigned int se_num = (info->read_mmr_reg.instance >>
> @@ -787,24 +788,39 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   				   AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
>   				  AMDGPU_INFO_MMR_SH_INDEX_MASK;
>   
> +		if (!down_read_trylock(&adev->reset_domain->sem))
> +			return -ENOENT;
> +
>   		/* set full masks if the userspace set all bits
>   		 * in the bitfields
>   		 */
> -		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK)
> +		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK) {
>   			se_num = 0xffffffff;
> -		else if (se_num >= AMDGPU_GFX_MAX_SE)
> -			return -EINVAL;
> -		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK)
> +		}
> +		else if (se_num >= AMDGPU_GFX_MAX_SE) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK) {
>   			sh_num = 0xffffffff;
> -		else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE)
> -			return -EINVAL;
> +		}
> +		else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>   
> -		if (info->read_mmr_reg.count > 128)
> -			return -EINVAL;
> +		if (info->read_mmr_reg.count > 128) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>   
>   		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
> -		if (!regs)
> -			return -ENOMEM;
> +		if (!regs) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
>   		alloc_size = info->read_mmr_reg.count * sizeof(*regs);
>   
>   		amdgpu_gfx_off_ctrl(adev, false);
> @@ -816,13 +832,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   					      info->read_mmr_reg.dword_offset + i);
>   				kfree(regs);
>   				amdgpu_gfx_off_ctrl(adev, true);
> -				return -EFAULT;
> +				ret = -EFAULT;
> +				goto out;
>   			}
>   		}
>   		amdgpu_gfx_off_ctrl(adev, true);
>   		n = copy_to_user(out, regs, min(size, alloc_size));
>   		kfree(regs);
> -		return n ? -EFAULT : 0;
> +		ret = (n ? -EFAULT : 0);
> +out:
> +		up_read(&adev->reset_domain->sem);
> +		return ret;
>   	}
>   	case AMDGPU_INFO_DEV_INFO: {
>   		struct drm_amdgpu_info_device *dev_info;

