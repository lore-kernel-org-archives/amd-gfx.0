Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4D4C0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 09:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863CD10E2CB;
	Wed, 29 Jan 2025 09:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pd+fB5ei";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC56F10E2CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 09:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCA+JudQR8wVHA6aq7FPldnDUYigKj/GqFdffvBiES6gwI3OB0+hJ8y0Y1lOe32IiBh0wOAiWooJ2OyPB78ChfFLpbcD8g4voS5Bd6bGhFn+slJgsKJPCbqqXho76AjEge9KrO2K0gQJRenpAQuKOQH3Zht7EUCS74uH6fNC+l0R1Co7fe9CYXXDqFYvmFfLArOgiSkKNvx3GHnp4ve/fe3FQJDV17cmZ12t3KdozsFcd5/T7WVz+IBfTyJiTDlhU0L3F1pzHn7IJMxUspcMvC5q1WWN4LMdr5q5gNDF6TAxa4kqrBxDnbwMNBCkH3sZMp9vqK/sSlZCjRHIS6FGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFpcIvhvdJ9j9xron/tUtAdewsyFjqW+wXg1+usTXio=;
 b=qiLjpAmvz0qgVulf8Wo5OR1ArpDne0oQjUGoz68O41+msTAe9YW9tVKC2TYsIMUFqNoN819L8sEZo6UmST0Bk5Zv7LfuG4K9mys1fQRUrTuE1w+O1zeq4V9MfMOpW6yFTiYhacExQqoPcttKxiGyLc/uUrWfHqjwdAcQSDSYWJRV4vvKtSAokZ44DrL4hC30ZFqVdPHUho5jZSCYu/NiKxyhUTIf4WvENE1tZfwEEreJfa+b/cnNt8IWdiSLHiz2h/9d48OGojSqymO/Jy+i4AF3ghY9R2rIAwj0ImMwC65D22jdErjulexJ56+gBJGCXwdhbEo7BDJYx4KVTCzE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFpcIvhvdJ9j9xron/tUtAdewsyFjqW+wXg1+usTXio=;
 b=pd+fB5eiqTSe/JKL2gnumVyXFSbbGxYywr0DPrJfX+fIf/WUoqMtQkgljxjV+CB8fjqeX/9OzxBoJAFVQIGbBoAyKtNZH2aF7RMjb+s3oGyBH1BuEEEod+glm1I1dOPLMl4TKCG6Jgvd22xbiYqJzQA4zsbihOigs+54IpeHNdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.25; Wed, 29 Jan 2025 09:50:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8377.027; Wed, 29 Jan 2025
 09:50:09 +0000
Message-ID: <7ec91b45-2c09-4d90-9d8d-b8e1582c3f29@amd.com>
Date: Wed, 29 Jan 2025 15:20:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
 <20250129084643.507727-3-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250129084643.507727-3-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: dd68bde3-d42e-4a7d-a238-08dd404a5147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnE0SGphdkZ4eEJPQXBVeVZ6aWdDclB3S3lJOVYyR2s3TjV5TWNwd2prSjJP?=
 =?utf-8?B?bmQ1N2FDT1U3SmlkL0NFUXhPb3RIKzc0Sk5DMkNwTjZheTIzeWJPRy9NaHJY?=
 =?utf-8?B?ZGxSYWcramw3aTViT0c1bUNmcEdLU2dGN0YyeVRNRVd4TEFMSVRaRlBuT2Ny?=
 =?utf-8?B?aTlTcW5kTGw3TjRIUFNoR1ZPQURORm96MTZkcW9nVXZSNXlpQkh4QkRDWXRZ?=
 =?utf-8?B?US9BMHV4dUhRSDZiTmxMby9NMTVUSnVqMEJCNXJkTTZMbTEraE9MZjYvcmU1?=
 =?utf-8?B?aDVQWkdzS2djR3NHcHAvYjZxR25vb2VkZThXSVphTE91RXNLb1Y2NjRNRDBv?=
 =?utf-8?B?alNWNGtURTVCNFlJY3B6QSsvNEtTREVERE5jMWxRZklFSUsvUXIvS1VsN2Jw?=
 =?utf-8?B?MW93NkF3VDZEMmlGb2hsdmd3MHdQTTd1bVUvR3lhL0lwZjg5dUxlQ3BuWWQy?=
 =?utf-8?B?S1d4QVRqTGJTZzNiYUQwTkFKK09vWXdaOUtEMDcyU3VrQXJLckxLNnBGSFg2?=
 =?utf-8?B?S3pITVNsdWpWbnVRNFd2ak11NmcwMUN1ZHR6Snl3b3dCY1cwbXFuc1NjTml6?=
 =?utf-8?B?OTJ5eVhGdkkvaGJCdFRid2d6d2xRQnM0VEs4M0tZTG1qR2ZvV2hQalFCMk5S?=
 =?utf-8?B?ajE3cjhBVHVKbllFRkRqSEZxR2svc0lXcXB3UHF0NmQ0ckIzWnNRUGdGUTk0?=
 =?utf-8?B?c3h5ZDJXNjdvKzFxTjVuRVhqanNPdEtVLzBDanFoREVwQzlJa0tlS1JLa1ph?=
 =?utf-8?B?TzRYMHVIVElmYkVtOUJMM0RVd1FFNU5VbU53VFdrbDRFWUlOeGI1N0hVdTU0?=
 =?utf-8?B?d256UUFjdGRFOHBrVU5Ud1U3ZHBqNFNBUWpWMnBhYlBnY1VpNExMbS9JdkZD?=
 =?utf-8?B?VDNCQVpSY1NSRHg1VXdDTjdsUWpkaHdJSEhUQndON3JWbStPM2hpd1RJbnBt?=
 =?utf-8?B?N212Ymd1RnRnR1AyTDBnc05Ta2UyQVV3T3ZIQlVPWlFyQ3VDbHd2eUt4dits?=
 =?utf-8?B?NHk5MFdPd1NCbGs0RGhDWFNLd0JQeGxyZ0NwU0dmNVRaYUhSTGhQdFoxeWQ4?=
 =?utf-8?B?V1R1SnJvckpLNTdPMW1QVG9FR0ViTFZYblZOUFgzZUt6d3NaeEwrcHNFY0xG?=
 =?utf-8?B?YVVDVnh3Y28yT3FkaFNsNU1ram1lcitHaGxqQlZQdTk1ektvUnVTYjg1d2ZU?=
 =?utf-8?B?U2pLaHFZVHhsQmUzb092R0tic3RJUExwcXBwazRxbEZ1b2NCc3YxRG9ucjZp?=
 =?utf-8?B?dlN4clp0bjh3U2JWcmQrdVNyaTFyTnRNMVlzaG9hbFFsOXRkWDhRbjF0Z0dW?=
 =?utf-8?B?aFlCOG9tbE94TWNNRnB1S2Ewamd1TlhBU1FHV1h5d0lWeHozUjhkMHhia3VH?=
 =?utf-8?B?cUQvT2tnSVgyL0NxRHA0VjU5ZlV3Q2VQd2F2VjcyK2txaDFwS2JKcmRobFdS?=
 =?utf-8?B?b3NKOHh4alcvK2cwUStmcFBlSzY2N3l0V2RZbXIvQlFWNFQzUjNMTVFiWXps?=
 =?utf-8?B?RnNuVGdXWjFhZXdnOFBzUWdwV0VrVjRVSy91NTBoT0EvSFEzYXp3eTBBZjFa?=
 =?utf-8?B?cW5MVnhzclJqRkE1UW5aSXVWbUZVMmIvZ2lpV1oxUHNLY25tYVdVLzMrL1lU?=
 =?utf-8?B?YVh5ckVsZkcweU1JbmVyTURUaXM4Vzkzb3lNRzdKdjAzbFZtQXhqcm5OYVJZ?=
 =?utf-8?B?clBhY2VzU2M2S1ZLSzdqV0hzdHF6dURjM1JMTHVIVldFZmJTWGQ1ZmZjenZK?=
 =?utf-8?B?N1ZxcXN5WUxFU3ZRczZFcTY0Rlo5bVhLNmpRWlhNalZSM1RZWHl3YXVZSHo2?=
 =?utf-8?B?UWtZTnRQTExBekNYZmU1WlZ3TGh5MldNa05zMGhBOENKWTFkUzYrUGJBcnpw?=
 =?utf-8?Q?z6Mrtp5stfURo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1BYeWZCY2JzM3NQc3paUlprL29UNmkrWkh0WEpQb3JzRzlmSjhWK1BKUmJ5?=
 =?utf-8?B?SjRGclJ2Sm4rWW1OMmpPb0RZOFhaQk5EY1h4SDB2MFNvMklIY3U1UWdsWng5?=
 =?utf-8?B?RVZMRzgyYStna2l4M1k2dER1M3UvNE9wTytTeXdaL3RMOFI4eGZBWDRQQk1N?=
 =?utf-8?B?WmtWNTVXdlQxVmZINFJXNk1YN0VzS2p1RStSZUhwQnVhSlBXZW45YmM4c0Nr?=
 =?utf-8?B?ek5XKyt0WXJWeCtNZWtyVURSTDNKTTMvOFVrSU03UnF2MS9ERW5PNmxBeHFN?=
 =?utf-8?B?OEdhSzdVT1ZPWW5YQ2xaYTVLS25SUmVvS3hSekw0elRIaHV0cC9IL2wxSVdw?=
 =?utf-8?B?ZDIrbVBTYithREZUcURmZWx1UFVqcm1tZEZKUGZHdGw1eGhtR3NadUNqc3ps?=
 =?utf-8?B?bTVobUNaZmNxdE9UTjhaZ1ZvVVJkOEwyNnpTL3FkU3NFNUhjdkVQVXNvVVNM?=
 =?utf-8?B?eWdiQ3lZSnNQcXN0US80S0pyc09ENGN1ZEMxSkJIakFFUHpEL0ROUjM2cC9j?=
 =?utf-8?B?WXEvcmVJcG1TTTNINllHakZFNXdMZE84Q3hvbnI1MFpSMHA2UERJYzU4Qy9Y?=
 =?utf-8?B?REVBRXRmeThvQU9xQm1ZTGlxNnIvbkJRaitSdXhCdTlQeCtnVDhQNzRldHdr?=
 =?utf-8?B?RlFSUFMzc0ZLRU1ZUUJsc2lhL0hYeDdOc3YvdXBoVy9OcUQ4NlFPOC9MUFpT?=
 =?utf-8?B?QjBXUzNlbXlSZnNHYm9HbURGTDJiTXY2a1JUZzZ4WWNRc2R6SWhSREVOMW9s?=
 =?utf-8?B?UEp4UU1vOE02T3JXdWZUdWFML3BvQmFtZlJiUDZqbTdFclJ1T29FWDUwcy9h?=
 =?utf-8?B?dkMwNnR4NkZER3RaOW92UGxzdUQyTUtFNFhDRzRmRFFRUnRaWVlBRExESjVN?=
 =?utf-8?B?VytIM3hMazFyRDdTeWNabzdUUkRUVjNXVE9TVkU1ZGdFelVkb3Z6V3hiVmtX?=
 =?utf-8?B?dlVVVHVjZy9GazdnK3NyQUpUQlE0VjhIWnFZb1NlRkdjcld2RDNlVGp2OXRi?=
 =?utf-8?B?Qk92U29qN1BZUzNRYlVnVHE3a3ErUGRaUzJIci9XMng3WVhzMTRZbGVvWEZl?=
 =?utf-8?B?QWpqemlrSCs4SlBaR0I1WFdWSStMaUZSalJRcHRvYm16NGwvVXQvUDQ1QzVI?=
 =?utf-8?B?YXpnSDNNM2grOGp6alBwRUhuWW92bk9ReTRzSTNoMDR0ZTM1R2twbk5URkhK?=
 =?utf-8?B?Y0diY1hvS09IQTNqYnN3ZDdrazRtdmdvTlRNWDJJVFZiM3lxQ1QweFB0TjFW?=
 =?utf-8?B?azZUeExMd0ZiZ011d1UyQW9DY3J0T25GTjBSaDJwVWQ5R2dzMy92L0NYM3VP?=
 =?utf-8?B?SThzOGNtN0NzTEhaVThmRU5IV3lCY2RLUm02dlpoV1VVZVN5TTFZRnArNE14?=
 =?utf-8?B?UzAwMHB5OTA1b1UzaDJLVWEvcEUwNzhWRzVxREZBUGYrSzU0eEpkSWwxOS9L?=
 =?utf-8?B?Mm5zYU1xWjZ4L0hGd3RLeVU4TENiM3BIdklPNm9ySGFBdTBpbHVJZ1ZSOWg0?=
 =?utf-8?B?dUlXOWN1MldDZXNkZXpreG9RdUt4Q0lZb2xabWhXMFJOU2xzSzc1cGVuMXdI?=
 =?utf-8?B?SExIb1lsK2hMelZjN0NPQ2FSckN1T1hleVN1QUxEcktOYlpLYzNDeXJKT2ov?=
 =?utf-8?B?bVR3TndpNGFWNHdIQTZ6WXZQZ0V3dnFvSEswMnMzajVmcEJmWTB6UTJOWjdh?=
 =?utf-8?B?TDFlY2hzVkpuSEJpTGptRVhIaWx3V0pVeVpBTUJaOU5xUTd6VWN0cGFXd25S?=
 =?utf-8?B?YkhiR1k5NGR5cTZIaWNSL0kwQU1jUmZKalFJbFhZNThlZWJhSERKWjBIekxG?=
 =?utf-8?B?SzlEUFhoQkVDRzl5SnJZMHRGQjdKR3hxQ3psSUZKb2k4ZkFMUzdFNlpva3ZG?=
 =?utf-8?B?MUFXRnR3OVlSTGFVNGFHTzNFMHVmQTl0SFlqL2c0djh3V1ZMWEpyTGU2eE5K?=
 =?utf-8?B?eVkxLzJnOXkraXlnd2tZbHV1Rmd0S3ZlUWNUeFJpMHJTcjBBdEhnOTJPR1E4?=
 =?utf-8?B?aWI5YmFoYzNvL28zWmlzT1RIV0JnSjZTM0lNWEJrV3ltOStieTFackJVRWcw?=
 =?utf-8?B?Z09JYW9sc2c3Vkh2Rk8wSXRwYTUrMjBsM2lPbldhVTRLdUlMT2ttSnlpWVY1?=
 =?utf-8?Q?yrPeS5gIjOsiR2cLvDezjmZZp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd68bde3-d42e-4a7d-a238-08dd404a5147
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 09:50:09.5363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9m9YrQuefNqlG5LWT3dpw6pPxYmLXCe3asau6J8ezLNo2ToRMJ2/X6XU+hanqnN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717
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



On 1/29/2025 2:16 PM, Sathishkumar S wrote:
> Add devcoredump helper functions that can be reused for all jpeg versions.
> 
> V2: (Lijo)
>  - add amdgpu_jpeg_reg_dump_init() and amdgpu_jpeg_reg_dump_fini()
>  - use reg_list and reg_count from init() to dump and print registers
>  - memory allocation and freeing is moved to the init() and fini()
> 
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 80 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 10 +++
>  2 files changed, 90 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index b6d2eb049f54..0f9d81e27973 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -452,3 +452,83 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>  	}
>  }
> +
> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
> +			       const struct amdgpu_hwip_reg_entry *reg, u32 count)
> +{
> +	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * count,
> +				     sizeof(uint32_t), GFP_KERNEL);
> +	if (!adev->jpeg.ip_dump) {
> +		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
> +		return -ENOMEM;
> +	}
> +	adev->jpeg.reg_list = reg;
> +	adev->jpeg.reg_count = count;
> +
> +	return 0;
> +}
> +
> +void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev)
> +{
> +	kfree(adev->jpeg.ip_dump);
> +	adev->jpeg.reg_list = NULL;
> +	adev->jpeg.reg_count = 0;
> +}
> +
> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	u32 inst_off, inst_id, is_powered;
> +	int i, j;
> +
> +	if (!adev->jpeg.ip_dump)
> +		return;
> +
> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
> +		if (adev->jpeg.harvest_config & (1 << i))
> +			continue;
> +
> +		inst_id = GET_INST(JPEG, i);
> +		inst_off = i * adev->jpeg.reg_count;
> +		/* check power status from UVD_JPEG_POWER_STATUS */
> +		adev->jpeg.ip_dump[inst_off] =
> +			RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[0],
> +							   inst_id));
> +		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
> +
> +		if (is_powered)
> +			for (j = 1; j < adev->jpeg.reg_count; j++)
> +				adev->jpeg.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[j],
> +									   inst_id));
> +	}
> +}
> +
> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	u32 inst_off, is_powered;
> +	int i, j;
> +
> +	if (!adev->jpeg.ip_dump)
> +		return;
> +
> +	drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
> +		if (adev->jpeg.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:JPEG%d Skipping dump\n", i);
> +			continue;
> +		}
> +
> +		inst_off = i * adev->jpeg.reg_count;
> +		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
> +
> +		if (is_powered) {
> +			drm_printf(p, "Active Instance:JPEG%d\n", i);
> +			for (j = 0; j < adev->jpeg.reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", adev->jpeg.reg_list[j].reg_name,
> +					   adev->jpeg.ip_dump[inst_off + j]);
> +		} else
> +			drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index eb2096dcf1a6..02886ec4466e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -92,6 +92,8 @@
>  		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;	\
>  	} while (0)
>  
> +struct amdgpu_hwip_reg_entry;
> +
>  enum amdgpu_jpeg_caps {
>  	AMDGPU_JPEG_RRMT_ENABLED,
>  };
> @@ -137,6 +139,9 @@ struct amdgpu_jpeg {
>  	bool	indirect_sram;
>  	uint32_t supported_reset;
>  	uint32_t caps;
> +	u32 *ip_dump;
> +	u32 reg_count;
> +	const struct amdgpu_hwip_reg_entry *reg_list;
>  };
>  

Thanks, this is almost there. Personally, would still prefer something
like below and have an instance of this kept inside jpeg_inst (though I
see your point that jpeg_inst doesn't have an instance id and this will
also mean duplicating list pointer/num reg info in all instances).

amdgpu_jpeg_reg_dump {
	u32 *ip_dump;
	u32 reg_count;
	const struct amdgpu_hwip_reg_entry *reg_list;
};

Ignoring that -

With the current way,

amdgpu_jpeg_reg_dump_fini() may be called from within sw_fini(). Just
wanted to keep a wrapper fini() func to make sure all is cleaned up.
That would avoid calling this from every IP version.

Apart from those, leaving it to Leo or someone else from JPEG to take a
look.

Regards,
LIjo

>  int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
> @@ -161,5 +166,10 @@ int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>  void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
>  int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>  void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
> +			       const struct amdgpu_hwip_reg_entry *reg, u32 count);
> +void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev);
> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block);
> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
>  
>  #endif /*__AMDGPU_JPEG_H__*/

