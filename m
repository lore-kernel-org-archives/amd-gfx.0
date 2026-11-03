Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13890606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nAm+MtZP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DEC210E1C5;
	Tue,  3 Nov 2026 23:30:02 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC7610E1C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 23:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtSIDak0uEOj2GxG6tWmXF1JA2qyEAQMQIssml68uMh73kNPd6ax40FdVGGwFnCbt8d7bFKY2QmTiBUXK4pHhBfeiz8XANzoe99RuJt2MndojlZd2meCn4QxKhsie0GpicIhykcQw+n/4xxIWbpjj73apVRweLeICo+klEzbELB8vCOaYRPyXfFr/Onw0scOe8Qu2wzwS9+g6zwWzsERncdoXt/wHc9TsFuiy2gM+xMetGqEv77LJ17TwDMRQAFkCl2ZJXlhvCGTKLU4hiOfAJzhoWY49ecT5Owo5/0ounXNxeQDIscZpLRH12lonPTqDY8tFB/9ivKy0buLIh76ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsO/OCICaLskUP559pqBtStItWmysovuKOXZEm60LY0=;
 b=dlxELffYleQRi6R64TTBS4YTW1hJQ4UvEh2nhyRuFvm8502NDA9a7O8LeCqY3isErWeD/gpC7FQaeBDSslfpkzgwxYt2S654WDzWn7BzNoNB9yOwN7wVQwp1+kv8BtZilpZ2ZkWDi4Jqxu1wiHqLUcnPKexDaZul82gxSxZoT1nHHipbcYoRgjuofR3pDrGEdswbRAGVg13FDnyqB/wnC8uBxGCyXEDbr4WCgqNQDkMVtRia9dCAD36wyfxJVbXznX0pq9z5aYlBIzaIeETAl0zCXvszB/4sZ6VQra6ULE0Qgoad/+TDIk9OFTe1mQHuSCjb/CNeoYx4nsEsuDNQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsO/OCICaLskUP559pqBtStItWmysovuKOXZEm60LY0=;
 b=nAm+MtZPYB2ij4/RJgb808DMlV3o2ji3l0z+PHmUhW07LjtIWtE6e1dibAWrFgX9ibshCkzxRLm1LDSVqmHFbrsU0WxWM/PbV2s/Lo76TZb4TGT6atajB73xcnfVNWzn44arbmVIUzLd/kx8Uf6odmbsfnNHaEmkBd6JHUJPss8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by MN0PR12MB6032.namprd12.prod.outlook.com
 (2603:10b6:208:3cc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 23:29:53 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 23:29:53 +0000
Message-ID: <771fa61a-e333-4c56-a085-c4e295c94fe1@amd.com>
Date: Tue, 3 Nov 2026 18:29:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 6/8] drm/amdgpu: Enable UALink loopback mode
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-7-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261102160125.2743750-7-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: f0723a40-b8d3-4016-cf66-08df3a025d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|22082099003|261102123227099003|18092099006|261102130727099003|56012099006|5023799004|4143699003|261026121527099003|11063799006|261022105027099003|261021121427099003|261009223027099003|261028144727099003|261022075727099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: X2P1fBWuhmt5G7l91VTqjzUw/oGJso/MniwMRhfzeoKkVHNKyvohwEKBcoFsuVDGYVpAzRKEbxbsUyKDzhxLdPhisHJp+APBqw2XVE8dg8t/XiRkeL7TwTy6i+rRo1WGk32sdS1asoQirgG7Kk4PP9QLqZAROCAEopefrKdx9r04fWcLpNeoRCXM14SINlJbXMbJiqh00kWECh4M9CHkdUCZ3B+J46q6MtHFDYuZ3r3R6x20GUaEaQGL4gExIaNs/1pSkxFm6CKOQwOp6Rv+kAjdRJ1wMy3LAUn7GDPYbbiDWp70o11hhKZk47PPnV6hmCDJ4YSFJwyKttZdpnQ+4vHaqyWnjiCXwPjRp61zGMyKBKq0UZd6JaIQWFbLuVnE1n2uGLvL0KTY/ajvcQVw1tJnm4eR0oUDBydyafwGEuu6LhMMsdImxAx/zRY8cEDGbkKl2xYjTvIYQuEbnId9F3HsWDHRBjLqFxYJU5Ql5WytbdW+eaGgxDICiG5tpcntvrH2YDo7fzf0lPQudVmh+twwcLSqx/5RcOtD1nstXsH4n2KARBm4tYxFM3XljLswkh/LpHew8Tos3atUhfaDSDwV6DyiBNJhZinLThiDECUyVPUJMbfRV/BvNSVQUZ7lTCTuKR9gXBrYFZeKHRvStkHEqSJPcqCbPVo9A2Kofps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(18092099006)(261102130727099003)(56012099006)(5023799004)(4143699003)(261026121527099003)(11063799006)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261022075727099003)(261021123027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWNVRU5MWXk5WlRwR3ZyNHpXVUkxM2dKNlFPT1RIdGlUNEZLR3lwRDVwbU9E?=
 =?utf-8?B?SHZFNXc2Y0hKMTZ6cDR2UEpaeFYwMFNYMUxUVHpLVTg4alZWNEJzSTQ0NXl0?=
 =?utf-8?B?ejFVMDljc0o1Z0ZiRnBlZ0RtUFNwOUtURDgwNDZRaUFHcGg3NjhrMjl6dWdN?=
 =?utf-8?B?WHhNYWpXdExSRmZCbHlUczFUZDJ6Tm1sdVNrZFk1bFBUSnMwaC9rRzhoQjZU?=
 =?utf-8?B?WkwzaUdmWVBzZGF2NjcwTUQyQ3gwMk45Mk9qSVFtTmdhRWdONnlldGdONjZn?=
 =?utf-8?B?NWV5aHhpQkl2NENpaWwrQXgxVjFNRnFvZ3BZM0QzRUNFREVaNXhxS1BhcnpF?=
 =?utf-8?B?ZEJvTjFUSzJIeVp4TFI3L1Nmc05tZmdKUVJ3OTZuR0gwOGRQZGh1U1RTSGRr?=
 =?utf-8?B?S3Qyd3lnWnNoNjBzZ1lNd3R4d1VycCt3Y3ZiOFFxQ3djcXg5R2tuTDBzMWE4?=
 =?utf-8?B?Qno0N3hTUWYzaWRxZ3dKZFV1aDZVZ0svUjFvak1CbE9YYmlHMkVtR3UzYURT?=
 =?utf-8?B?VitCa1RWSStRSitBaHczS1RiV241cTkzS01HcGV5WEsvRjczNjJxZEd6MUor?=
 =?utf-8?B?R05VcFBNMW5KYXA3eS9qemVSMGxObEJPZHlmaW5wWjBEN1RsSCthaTdzVElV?=
 =?utf-8?B?V0taY3U3NnJPZ0dBQ1p5ZDk5K2EyTUxMSk4ySjNkcGNjVWNQWGJZTTI3aGha?=
 =?utf-8?B?WVI2SUN4V3prWkRHU2xuK3BBZ3ZGTTRaTXF1MWVFVmlpR0RzZ0o3dUs1eExh?=
 =?utf-8?B?b0tVZDFlV2FGYTBEK2wrWEdGeFFRWTQ3WUpFdnpxMG0zU3BpV0tGNldnTVAv?=
 =?utf-8?B?NU1vbHBTbCtjWU4xQkxhSjRvdGVjdWVVMTd0TkMvajU2RitvT2w1aDZxZzFW?=
 =?utf-8?B?T1ErSzk2ZUtMMFQwcHBzNjVXc0dHQWVaTkhQaW5rTW9ZZkRuMGMyQVQwMlZz?=
 =?utf-8?B?Q2sveVMwbkY5RHNyRnEzWFBWTllGWEVhWG1oVmoxY1BPY3lXNk9oaGdodlNO?=
 =?utf-8?B?bkY3cWhhWis5aXArRW9vZE1TbitaOXE3RVFIREV0MFRKQVk2bGdxSjdvUFNn?=
 =?utf-8?B?d2hiMTJJQVRzL2xJaTVNUXdOT1pQK0YwRkFacnBDVzU5NEhWd2cyeG1RNWY1?=
 =?utf-8?B?aGJjd01xblZ4R0xWSFdjUitBZzFMWmw5WXY3V2VHa3QxSFNObUtXVXdaODk2?=
 =?utf-8?B?a09rb3ZJSG0wYjFRdEp5bGZyYXVPL21IdlZBMzlvd0FjRlk2aU9HbWQ2dHQ4?=
 =?utf-8?B?L050S3VNZ0RHWVRKaCtkaGV6c3ZuYUE4S3NNbjAyMVFtQUtaQlFVWk03eFhn?=
 =?utf-8?B?ajNQMzh5WDBXbHFwSFlBaFd3UlJkb3ZJbUYvNXVqdEhkb241ekd2R3VjcjFs?=
 =?utf-8?B?eGN3UHpjOTFOR1gwQzJmWG1NWXdQckpEazIwQzNIODhaNjgxTXlmNDZHcGpi?=
 =?utf-8?B?SDU4WnZwUjE2cWxKSmdMdXBJL2xmOU15NzViaERqOVBtYTN4RTlGZnBKWlNy?=
 =?utf-8?B?QUVqZWN1bnB5UDZkbW43MEgwWFkvaUN4cXJPRm5uTHgzcGVyT2JJWTJWcWo5?=
 =?utf-8?B?R2UyUzgvZkF3RHdyNHY5M0pVSlcycGg2ZWkwMFZaQlloNlNCMkxjMEpBSUF6?=
 =?utf-8?B?NkR2alFoMXFPeUZTeHFwaVlCV1JFQnVMMU0zMnB1SzFyV3U5QjRwbHdSR0RC?=
 =?utf-8?B?cUYzMHFkdEhHNDlTdUtEOEk5dkJtQkM4aEFhOE5KSGlWZkRJb0xmaWRBbllP?=
 =?utf-8?B?UTY3OXBnZE51bEUrZ3kyYnVDOVVJa0p1Y2lPcU55REdBbDdGL3VpVXBYVjFT?=
 =?utf-8?B?SC9LdHlxQ0E2QTdzT05Uc0VSN3JrN2J0aVVTVEFackpFQXI5dGJOMGs3RFZP?=
 =?utf-8?B?ekdSMStBK2tFa2VWRWozQkQ2TStIMm9RS3RhYm5OY3JyYzM1b0dSRUN2NW9U?=
 =?utf-8?B?aUZtbm1iTXYxclViRFI3Y0lDbm9RS3drUjhhVndSL0tBUHEwTkJIUFQ3TVha?=
 =?utf-8?B?RVF4eVJXT21pM3VwNkJHUFR5TEhtNVVTdEIvUmJQSURpTlFidEl4bDhlMmoz?=
 =?utf-8?B?ajhtQ2Fta2NaWGhWdktXeVNibU50V0RrV3N4UkdTNXZGOGlMUi9JUjMrU3BW?=
 =?utf-8?B?V1I0ZUh2SkVMYitXMUFOUXowaS9XcGNZdWJTcU5CVUNtd015UUxMT1QvY1V4?=
 =?utf-8?B?ZlQ0TFFERzU5UWR2cThxUXp6bzhkSTJ2MENaSlpvU1pDQ0FjZkU2UGFqNzBS?=
 =?utf-8?B?ZXJiK3d2QnVUWEhYZm1ZS3kveFFJQlpBaW9YVVhSNWpjRnFUVWpFRGlKazl4?=
 =?utf-8?B?OFBydVBsejNXeDVIV0F3VDhiZ0paMUcydlRGSE9uSkdUQW9oOXlRdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0723a40-b8d3-4016-cf66-08df3a025d05
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 23:29:53.6115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtQI5jVPcjZYS1xarbd/6zRdafrxOORrtJ2NIGy+Bn5ThfCdY1Gng1yYTHTWEhrFx46X/aYLdXZr04RkNs6CcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-02 10:47, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter (accel
> ID 1) and the importer (accel ID 0). This lets the existing tests export
> a BO and import it on the same device, traversing the UALink HW
> pipeline.
>
> Add amdgpu_ualink_loopback_detect(), the single place that decides
> whether loopback is enabled. It runs from sw_init, before any per-peer
> setup, so the loopback workqueue is allocated with the other one-time
> allocations. When loopback is enabled:
>
> - There is no user-space agent to configure the pod, so synthesize the
>    pPod/vPod configuration with both accel IDs active instead of
>    querying it from PSP. Loopback only supports the source-aliasing
>    address mode.
>
> - Activate the device directly instead of through the cross-GPU vpod
>    activation path, which needs peer GPUs and a user-space vpod commit.
>
> The mechanism that requests loopback mode is added separately, so
> amdgpu_ualink_loopback_detect() leaves loopback disabled for now. The
> normal activation path is unchanged when loopback is not enabled.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com> (v2)

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v2->v3:
> - Update all static info inside amdgpu_ualink_loopback_populate_info().
> - Drop the amdgpu_ualink_loopback_requested() as amdgpu_ualink_loopback_detect()
>    is enough to detect and set loopback mode.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 143 +++++++++++++++++++--
>   1 file changed, 132 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 74bc8a907f5b..2e1e0a677e35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -63,6 +63,7 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
>   						 u32 sender_accel_id, u32 dw0,
>   						 u32 dw1, u32 dw2, u32 dw3);
> +static void activate_accelerator(struct amdgpu_device *adev);
>   
>   #define STRIP_NPA(addr)						\
>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
> @@ -93,13 +94,120 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
>   }
>   
>   /*
> - * amdgpu_ualink_loopback_sw_init - allocate UALink loopback resources
> + * amdgpu_ualink_loopback_detect - detect UALink loopback mode
>    *
> - * Allocates the ordered workqueue used to emulate exporter->importer
> - * interrupts in SW. Does nothing unless loopback mode is enabled.
> + * This is the only place that decides whether loopback mode is enabled.
> + * There is no mechanism to request loopback mode yet, so it stays disabled.
> + */
> +static void amdgpu_ualink_loopback_detect(struct amdgpu_device *adev)
> +{
> +	adev->ualink.loopback.enabled = false;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_populate_info - synthesize pPod/vPod config for loopback
> + *
> + * In loopback there is no user-space agent (AIFM / xncmdclient) writing the
> + * UALink sysfs nodes to configure the pod, so populate adev->ualink.info
> + * directly. The layout is fixed and known: a single GPU alone in its own
> + * physical pod, presented as accelerator ID 1 (the exporter) and also owning
> + * accelerator ID 0 (the importer). The values are made self-consistent so
> + * check_vpod_info() would pass and amdgpu_ualink_metadata_init() programs the
> + * importer's ring buffers / GART NPA mappings / MP nHT receive metadata.
> + *
> + * This must run before any per-peer setup, since it sets the accelerator IDs
> + * returned by ualink_exp_accel_id() and ualink_imp_accel_id().
> + */
> +static void amdgpu_ualink_loopback_populate_info(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ualink_info *info = adev->ualink.info;
> +	u32 exporter = AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID;
> +	u32 importer = AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID;
> +
> +	adev->ualink.loopback.exporter_accel_id = exporter;
> +	adev->ualink.loopback.importer_accel_id = importer;
> +
> +	/* Physical pod: this GPU is presented as the exporter accel ID in its
> +	 * own pod. ppod.size must be large enough to contain both the exporter
> +	 * and importer accel IDs. ppod.id must be unique within the system
> +	 * (matters for 1P4G, where every loopback GPU is its own physical pod).
> +	 */
> +	info->ppod.accel_id = exporter;
> +	info->ppod.size = max(exporter, importer) + 1;	/* == 2 */
> +	uuid_gen(&info->ppod.id);
> +
> +	/* Virtual pod: mark BOTH the exporter and the importer active so the
> +	 * per-peer setup (amdgpu_ualink_metadata_init()) programs the importer's
> +	 * resources for the importer accel ID. Loopback only supports the
> +	 * source-aliasing address mode.
> +	 */
> +	info->vpod.id = 0;
> +	info->vpod.size = 2;
> +	info->vpod.addr_mode = AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS;
> +	bitmap_zero(info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
> +	set_bit(exporter, info->vpod.active_accel_bits);
> +	set_bit(importer, info->vpod.active_accel_bits);
> +
> +	/* Only the exporter (this GPU's own accel ID) is a local accelerator;
> +	 * the importer is reached through the (loopback) remote/NPA path.
> +	 */
> +	info->n_local_accels = 1;
> +	info->local_accels[0] = exporter;
> +
> +	/* Mark the pod vpod-configured so the activation path proceeds. */
> +	info->accel_state = AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_activate - bring up the UALink manager for loopback
> + *
> + * The normal activation is driven by the sysfs vpod_config/commit path via
> + * activate_local_vpod(), which derives the local accelerators from peer GPUs
> + * and runs a cross-GPU integrity check. Neither applies in loopback (the
> + * importer is not a separate GPU), so activate this device directly.
> + */
> +static int amdgpu_ualink_loopback_activate(struct amdgpu_device *adev)
> +{
> +	mutex_lock(&mgpu_info.mutex);
> +	activate_accelerator(adev);
> +	mutex_unlock(&mgpu_info.mutex);
> +
> +	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
> +		dev_err(adev->dev, "UALink loopback activation did not reach ACTIVE\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_init - set up and activate UALink loopback mode
> + *
> + * Called from late init once loopback mode has been detected. Synthesizes the
> + * pod configuration instead of querying it from PSP (there is no user-space
> + * agent to configure the pod in loopback) and activates the device.
> + */
> +static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
> +{
> +	amdgpu_ualink_loopback_populate_info(adev);
> +
> +	dev_info(adev->dev,
> +		 "UALink loopback enabled (exporter accel %u, importer accel %u)\n",
> +		 adev->ualink.loopback.exporter_accel_id,
> +		 adev->ualink.loopback.importer_accel_id);
> +
> +	return amdgpu_ualink_loopback_activate(adev);
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_sw_init - detect loopback and allocate its resources
> + *
> + * Detects loopback mode and, if it is enabled, allocates the ordered
> + * workqueue used to emulate exporter->importer interrupts in SW.
>    */
>   static int amdgpu_ualink_loopback_sw_init(struct amdgpu_device *adev)
>   {
> +	amdgpu_ualink_loopback_detect(adev);
>   	if (!adev->ualink.loopback.enabled)
>   		return 0;
>   
> @@ -499,15 +607,28 @@ int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
>   	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_HW)
>   		return 0;
>   
> -	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
> -			       adev->ualink.info, &cfg_state);
> -	if (r)
> -		return r;
> +	/* Loopback synthesizes its pod configuration instead of querying it
> +	 * from PSP, and has no peer GPUs or user-space vpod commit, so it
> +	 * cannot use the normal cross-GPU activation path either.
> +	 */
> +	if (!adev->ualink.loopback.enabled) {
> +		r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
> +				       adev->ualink.info, &cfg_state);
> +		if (r)
> +			return r;
>   
> -	scoped_guard(mutex, &mgpu_info.mutex) {
> -		amdgpu_ualink_info_set_accel_state(adev, adev->ualink.info,
> -						   cfg_state);
> -		__amdgpu_ualink_activate_vpod_locked(adev);
> +		scoped_guard(mutex, &mgpu_info.mutex) {
> +			amdgpu_ualink_info_set_accel_state(adev,
> +							   adev->ualink.info,
> +							   cfg_state);
> +			__amdgpu_ualink_activate_vpod_locked(adev);
> +		}
> +	} else {
> +		r = amdgpu_ualink_loopback_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to set up UALink loopback: %d\n", r);
> +			goto error;
> +		}
>   	}
>   
>   	r = amdgpu_ualink_drm_client_create(adev);
