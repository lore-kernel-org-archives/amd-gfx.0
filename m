Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27768606A333
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tkbNLvbY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83B910F842;
	Tue, 17 Nov 2026 17:22:04 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D841810F842
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBIgrnwKITCqG+6F912XknJix/elDMbkPsfUCopT9LwM9q0Pqxiynx4l4V5J6MKff4qgkQAv8MhJ2wvmGfbCx+X6/e4eNBicwG0XvbPZii6UfPBCyhbykDYukZXK3pQZSgODcHthQgj1KJiB8c4uOnuvE4uZdsPpoIFbzhIs9If9C5f3jNTpY1K5zJ4PxVYCDoCC31PuOBdKu2ilsOeCpM8d6tjwd5WshGBgbJMkyiuNTIWrpgeJUA8IzWQSQuI2P0rqk9Sm908tvjw8MjFqCQP4MhDDxetgIb705VS2u4+9VZdmJKNOW+Tma0BSUKxt8c23LcsTt/UtJhL9w4OXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NteAZdMVCeQqY8F9v0D28AfY355OKt7xYmBkMWhXHsM=;
 b=bek8m6zdUDudsXaOUpmD+Ote10hTDAnR8Vt16XL9xjaoTJs+aoXlwaGStvvbsTK4RhDyFTTKkNTiG007OZYtCfiKZp3BQoEX2ilXx9YyXPuf6w+kyx5I8dbKGYKGAhDdXGIrxxfihNSCpzyxy3GYj9P8y1yOsKW7He9TK/CeJrCpo1D2Dl75BMNxXRaW2kZipyg5DrIWhQCO+o72VY9lcq90eOjIFSAtuXPTRdjsIa5FweN0z/6hdEp8fREevQ/3K5yUtoUd5svJofTsB16byLMpviy5iavMcuqdOPtl8WerS4Y4XJPeZUJ8bKOLHaEjrF5LIbVZCjd4vwL0JS10hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NteAZdMVCeQqY8F9v0D28AfY355OKt7xYmBkMWhXHsM=;
 b=tkbNLvbY2KFGu1Nvp/PBIF4DUbZcMG/MLdkFw5Ral+rNad5NhoNKkKan/Qyl5l4v3LqEmSH7p/Ss5SqW09i7QYk/yIWXxLf3UYze8X1bvYlif+PKdITraDUO7poLFIzTxoPRWrZecJDoNn2wbK/X6/PDcFvIlNXO8Bkx2LitoPI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 17:21:54 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:21:54 +0000
Content-Type: multipart/alternative;
 boundary="------------ySvld20qqnJQR5aL8GnpHEVJ"
Message-ID: <f671e53d-7f0b-4a1a-8f82-523b5c6bc2f3@amd.com>
Date: Tue, 17 Nov 2026 12:21:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] drm/amdkfd: honor read-only intent for userptr and
 SVM ranges
To: Junhua Shen <Junhua.Shen@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Chris Freehill <Chris.Freehill@amd.com>,
 Kent Russell <Kent.Russell@amd.com>, Maneesh Gupta <Maneesh.Gupta@amd.com>,
 Denny Iriawan <Denny.Iriawan@amd.com>, David Yat Sin <David.YatSin@amd.com>,
 Huang Rui <ray.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>,
 Zhu Lingshan <lingshan.zhu@amd.com>, Honglei Huang <honglei1.huang@amd.com>,
 Yiru Ma <yiru.ma@amd.com>
References: <20261117042051.768201-1-Junhua.Shen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261117042051.768201-1-Junhua.Shen@amd.com>
X-ClientProxiedBy: YQBPR0101CA0202.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::24) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba38823-eb90-4518-90d8-08df44cf4634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|6133799003|261009223027099003|3023799007|13003099007|8096899003|11063799006|56012099006|10067099003|261021123027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: e02FcTwEhmkWUtb1pPihn2d49S+BWkD0+dMEuoHWjP8iF4es3PWvVXzMLatTzSfeCsyvHKfiLbzzXElo9bEDXj0liE872rb/lBsyuplrOcnPQGVFvj8It92UmligjKUwKSEJ40SSTn2b4hsX8PLDScdXt7apkBpcSUxDqtzDFpDIqIsSKSdLO/GNnRyWCQNyFD7woYBEwfgPYHOXSVGAkFWw25avfS874iQ49MOB8Txk6gm++15z84zkpzda78lma1nFFJyPYMENghHpyLDZ7bmVoH5QB70JgIQd0iOQdB7oyZEvqGAfKLupQ1qCp9x5Di51LLY3VgAysLL7nvsDq+BC1EdWE2vwnzOzsAVD3ryXqWiJ0YLfZEzGYFOifaS+tPtFDYf1SZmAYXhFb3+tTvl0KqPdBmGGoMtCDCgY6fqnb0ThSGQ58ocjslRr0CR/IoQ7iikrlhMkPC4NLCwYyUSySUPlUn++wnIDwx8VuZKcNGfE6ssrxDEOju4bG9oN1ZNUc826ZW8GB9JryWNZFaCgr65dfiGQ4Obol5gTe68FrYHz3D+e0eaUWuAjRCj06P4Ar1NjtnNBfYNu/Ef1uPwNLas9TM8PCtzrle6TfGM4Kz7Ojrc2P/RrjWv2V3z6MBAspjSsxDfyDHtjAEONzbNK3OrUUc/W7EegiGWkYNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(13003099007)(8096899003)(11063799006)(56012099006)(10067099003)(261021123027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjF3KzZhSHFwa0Y3WURQUmxidmszNjRYY1UwSlpSam5XUmNpZVRxNm1WUUFj?=
 =?utf-8?B?WGw4QytsYlZjWTAzdWsyY2had0orNTZCSCtxV3Y5bk14eVNrSDZrUmNiOVpK?=
 =?utf-8?B?WVpXdWVySFNWVHdQYjl0VHpzc2FtdjNXdUlOb3YxMTZFb3h4cjdmRDVUSmdy?=
 =?utf-8?B?cFpqV3krYlA1UThRbFVnMjBtbGJROGVML3F0c1FKeHVmWkVOV1pnTEQ0ZDBL?=
 =?utf-8?B?TUh5SDlZZWFyclNXaGlXb0h3SnM1ZHpZaVNlamowU0EydCthTE9HYUxnS2Fn?=
 =?utf-8?B?dDI3RE05TnBlTlNZUGo0ZkQzeWlqcEduZ1Yvd2xCNG1Rd2krS3BBQ25ncTZH?=
 =?utf-8?B?UEtkYmZyNzRoUmVhQXhaWUlJNVhHcy9jNitENnVLdjNlZUs3NG0zZU1XR21D?=
 =?utf-8?B?Q3Q2VTZNVVlZaCtlYUo4bUdRMzlqaVlucW5MUGxGVmZ4TVZXQTJzdXFwMUJr?=
 =?utf-8?B?a095VXF4SGxrY1ZFL0V2bDMydHFDV2xnWWpJNWVyQ0ZuY3dqdHB5UDFBc1hy?=
 =?utf-8?B?ZnFzQXN4WEFaOUE5MmFWNXFqQkRFVkFmZHU4UEJUT01nN2dyU0srOWh1bUZa?=
 =?utf-8?B?TkMzV0I5M2pRS1NyRndwdGlUMkNBaVl6RXhFN2lyb0JhbXJHMFY1eGhiclZv?=
 =?utf-8?B?aUx4QUc5RSs4L3ArM3FmUW1qTS9nck9kU1F1cU51Wmo3c2JvTnZRdzRsUkIw?=
 =?utf-8?B?VWl6VmxoZEdTelVEM2ttZys2ODhoU3drMU0zU05KWCtJcEtFMU9WMnF3d2hS?=
 =?utf-8?B?RjgwMnV1Sy9xaTVtNjdrK1V2ell4MGlJYkpoWE5ZWHJkQzNEKzlMQlNMbHdm?=
 =?utf-8?B?RVh4SXp3RzZrMTdmNkJVQU1jUkZNYW9wZUZEdlhnKzRWMGRPdTQzbHBtTzBB?=
 =?utf-8?B?TmVMUk9oY0JaT0lQVWlwTzlXTjNaOEVqcDJGUnF6L3BCZHRaaUtCQXRKU1hQ?=
 =?utf-8?B?aERsakdUSnZES0JreWZ3ZUs0ay9xa04wZWJhUXI3YVIvSFIyd1VIQTlHK2I5?=
 =?utf-8?B?Y0NBeUxtdENVcU9kNDF2dVZqTXVYaHRwekpNUGx1aGlaVnZwQ1ZDeUhXaTVa?=
 =?utf-8?B?Wi9LUDdXS3lBQlJXTXF5Z2lVWVZ4RkxmSUdCL2E2bldHNGdDUEptWDJVcy9O?=
 =?utf-8?B?UjdRQldLYUFVd1lDU2ZCNk9udlpxbHBTSUwvQ3d1dlp2M09PemV4c2VEOVdQ?=
 =?utf-8?B?UlRyeHYwQktqbnpoOU1rUS8xZUJ3Q3U3ZnhHZ0d4SG1UUGIvbEw2NGMwY2dw?=
 =?utf-8?B?QlBoSnRyc014eHo3cWR0Qnd5T3VvT2NtZm1GeFFpaytoZWYyTGdFb0MvVjBR?=
 =?utf-8?B?MVNkOG1MZDQ2V0tIR0ZpWSt0ZndXekw5UGFnUkp2dVVES3pwMThsTnlQMTBk?=
 =?utf-8?B?WkZCeGlMaSt4UFNsYXRZQm9ocG1iQ1c4Y2IxSE9OSVFqR2RsVFpGWGUraTFk?=
 =?utf-8?B?SFFBd05PU2xpdGR0NlY0WFBpMGdQL1NjaEhwdDlVZmRnam1nWW4wRnY4ZGtJ?=
 =?utf-8?B?MFVBM09US1NzcXJiOWg3TFRtcHBTVG9vcjVhZ29HaGJXSFBBZUxrRnhMUWFx?=
 =?utf-8?B?bDR3Q3dTbTEycWNRZWEwOXdXbXFLQ1ExL21NU2pmazQ0R3JwRUx3K05CakRu?=
 =?utf-8?B?amFsZ2xTOTNOeFp0dCs4RjNGYTdFMzRIZEQwMWM0S2NRaXdTLzB5YzdOY0U2?=
 =?utf-8?B?VUJzSVlJNDlMRDBLdXlHRU01eEJITnU2dGlubEZ5blFqekFsTk1zZzJ4RTEx?=
 =?utf-8?B?YytZamhPSmszZnpvYWhIcVVWdDRuVTdTT1lOY2tLRnJDQ3ZaK1YrK2VLTi9i?=
 =?utf-8?B?L01wZFU0Wk9TaExSOUZJYUZlTnVDSzAycmc5Q0NJcnJxekd2cUtkeU9MeWhr?=
 =?utf-8?B?alBPSW90UHptQnJhU0dGL3BWYVNUT2xvUEtFUXJlbXc3WUNzK3ZNeGtHRTNr?=
 =?utf-8?B?Y1M0SlYxVndCL2o3T0pSMVhZNmNmQmN4WFFhWDhiVGMwM3lEN2dGb0JaVkto?=
 =?utf-8?B?TUsvV2I4cFNRdWIzWHhNeXdDMm1MWXM0VGduU01jMGU1MFFvckFzMjcvaXZH?=
 =?utf-8?B?ZWRYTzI5bDNkV283VG5MTVY5MThHQzJBY04vU09POFQydkFJK2dySm1DMkp0?=
 =?utf-8?B?T0sxcmVVRDBoUDhQWUdpazc5ZUZGUzNQWk1SUzhSTjNXQ0tybE40b3hEdm1o?=
 =?utf-8?B?OEFYbXRzRkVXN05jYnNRcnJrMkdhWXRYNmVIUUZxVWE4TDIvZFRGYmhoNVBz?=
 =?utf-8?B?aUtMcnhRZDl1bjYxSFZRRUJsOFlGZTFYT0xnZ2xYQkNST21xbkIyMnlYdkNk?=
 =?utf-8?Q?Rss94tUB79CtmId2L4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba38823-eb90-4518-90d8-08df44cf4634
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:21:53.9320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30H6Ppt7/PhpgTSog+oRZPfemtFdp0IiX2wtb6elF+Tn648ElB4DG2WAfO78hWXg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,TRACKER_ID,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------ySvld20qqnJQR5aL8GnpHEVJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-16 23:20, Junhua Shen wrote:
> KFD records whether an allocation or SVM range is writable
> (KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE for userptr, KFD_IOCTL_SVM_FLAG_GPU_RO
> for SVM) and already honors it when building the GPUVM page table. The
> userptr registration and the SVM mapping path, however, do not pass that
> intent down to the HMM fault, so hmm_range_fault() is asked for write
> access even for a read-only buffer.
>
> For a read-only buffer backed by a writable private mapping
> (PROT_READ|PROT_WRITE, MAP_PRIVATE) that the GPU only reads, e.g. a
> host-to-device copy source, faulting for write breaks COW: every page is
> copied into anonymous memory, which doubles the footprint and, because
> the copy changes the CPU page tables, fires an MMU-notifier invalidation
> that evicts the GPU user-mode queues.
>
> To keep the GPU mapping consistent with the requested permission, this
> series makes the HMM fault honor the same read-only intent:
>
>   - Patch 1 (userptr): register the userptr read-only when the allocation
>     did not request KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE.
>   - Patch 2 (SVM): also honor KFD_IOCTL_SVM_FLAG_GPU_RO instead of deriving
>     read-only solely from the VMA write permission.
>
> This does not change what the GPU can access: the page table already maps
> a read-only allocation without write permission, so a GPU write to it
> already faults, with or without this series. The series only aligns the
> HMM fault with that page table and drops the needless write fault and COW.
> A buffer the GPU may write must still be allocated writable; there is no
> in-place upgrade, so making a buffer writable means freeing and
> re-allocating it.
>
> The user-space side that marks such buffers read-only is tracked here:
> Link:https://github.com/ROCm/rocm-systems/pull/15545
>
> Junhua Shen (2):
>    drm/amdgpu: map KFD userptr read-only when the BO is not writable
>    drm/amdkfd: honor KFD_IOCTL_SVM_FLAG_GPU_RO for read-only SVM ranges
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 3 ++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
>
> base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
This change looks safe, svm ranges without the read-only attribute are 
unaffected, so I don’t expect regressions.

Using GPU_RO to request read-only access on a writable VMA is unusual. 
Ideally, userspace would use a read-only file-backed mapping, but this 
provides another way to request read-only GPU access and avoid 
triggering COW in hmm_range_fault().

Userspace is responsible for setting the read-only flag when 
appropriate. Failing to do so would be a userspace bug.

I don’t think the Fixes tag suggested by the bot is appropriate, since 
this supports new userspace functionality rather than fixing a 
regression. This patch series is

Reviewed-by: Philip Yang <philip.yang@amd.com>
--------------ySvld20qqnJQR5aL8GnpHEVJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-16 23:20, Junhua Shen wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261117042051.768201-1-Junhua.Shen@amd.com">
      <pre wrap="" class="moz-quote-pre">KFD records whether an allocation or SVM range is writable
(KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE for userptr, KFD_IOCTL_SVM_FLAG_GPU_RO
for SVM) and already honors it when building the GPUVM page table. The
userptr registration and the SVM mapping path, however, do not pass that
intent down to the HMM fault, so hmm_range_fault() is asked for write
access even for a read-only buffer.

For a read-only buffer backed by a writable private mapping
(PROT_READ|PROT_WRITE, MAP_PRIVATE) that the GPU only reads, e.g. a
host-to-device copy source, faulting for write breaks COW: every page is
copied into anonymous memory, which doubles the footprint and, because
the copy changes the CPU page tables, fires an MMU-notifier invalidation
that evicts the GPU user-mode queues.

To keep the GPU mapping consistent with the requested permission, this
series makes the HMM fault honor the same read-only intent:

 - Patch 1 (userptr): register the userptr read-only when the allocation
   did not request KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE.
 - Patch 2 (SVM): also honor KFD_IOCTL_SVM_FLAG_GPU_RO instead of deriving
   read-only solely from the VMA write permission.

This does not change what the GPU can access: the page table already maps
a read-only allocation without write permission, so a GPU write to it
already faults, with or without this series. The series only aligns the
HMM fault with that page table and drops the needless write fault and COW.
A buffer the GPU may write must still be allocated writable; there is no
in-place upgrade, so making a buffer writable means freeing and
re-allocating it.

The user-space side that marks such buffers read-only is tracked here:
Link: <a class="moz-txt-link-freetext" href="https://github.com/ROCm/rocm-systems/pull/15545">https://github.com/ROCm/rocm-systems/pull/15545</a>

Junhua Shen (2):
  drm/amdgpu: map KFD userptr read-only when the BO is not writable
  drm/amdkfd: honor KFD_IOCTL_SVM_FLAG_GPU_RO for read-only SVM ranges

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)


base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
</pre>
    </blockquote>
    This change looks safe, svm ranges without the read-only attribute
    are unaffected, so I don’t expect regressions.<br>
    <br>
    Using GPU_RO to request read-only access on a writable VMA is
    unusual. Ideally, userspace would use a read-only file-backed
    mapping, but this provides another way to request read-only GPU
    access and avoid triggering COW in hmm_range_fault().<br>
    <br>
    Userspace is responsible for setting the read-only flag when
    appropriate. Failing to do so would be a userspace bug.<br>
    <br>
    I don’t think the Fixes tag suggested by the bot is appropriate,
    since this supports new userspace functionality rather than fixing a
    regression. This patch series is<br>
    <br>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
  </body>
</html>

--------------ySvld20qqnJQR5aL8GnpHEVJ--
