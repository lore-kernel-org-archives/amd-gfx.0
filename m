Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF730606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=U2XsKZlF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF4610E8DB;
	Mon,  9 Nov 2026 22:37:10 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC8410E8DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 22:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fzx3L4MZkEwEcXEKr3eh+GTyQrbUTbt/uOtnkwlBimZMghLMuocn7V3p7IB9Ei+RfzV6mmR97Iv7yfzzbxLMVRZBBHl9r71CFFlyGgrr/+nbKJpVCgFFcO0n2fQUj56X44+a7VGm9BaVzwC+UkdnVZIy8kf1gx1ux0oeS16lPaTREavg/ddAnbs9sewIX4cHT445VSGbkbbGEt+5IJ+Zdk6EVnPbho5SRn5eRKZJuBTqTkHZ2Z8MmdHX/ZDU+w1DJXXgOQ9h4mvC7sYGZsqrR+zAGwhuTNURmaje1xAv3wrSx3X6P9c9PKTOBXv6lp//oXEgOf44+6MpYFenCbxTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq7yDMceRp5XX3PJ5TwzCoIQZIgmCu6nuqR7VELV/xw=;
 b=Q5b7sh0PNPMwqLKwKmo6KOCXl9t4l6p9qeW7INSMIXmgQP1skHtqB4/b3yR+tJa2JeIHg1IdYM0kryd4J2YQ0fhrdWREbdrATvhAHDZHJ1BPvkaZyGJjxSupJjaS9E7fGj4XAIhR9tYjkhR3Z4GBo8TTVbQ99jRl7ZkB29ipFMrioaRzhMOJJAVvE9bE8a/ZWgLtf68c/CjlNYYChY/g6gYIfCVcT1o00LZlKpZxOY/EY7JKw+Ndj6Z99r5leyTE/X0NswPZVf/SSFPtBPL/mwV0tM3Y5DqmaTH+xPS1MhoHm1cAev3eSnTBztm0nrn6Tl1DVSD5LDEeDTPfxU5XTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq7yDMceRp5XX3PJ5TwzCoIQZIgmCu6nuqR7VELV/xw=;
 b=U2XsKZlFbuZ9hT563l7BqtE7+XoEpRAc6slRwSUlX90XXSq9M3ONulqBUE3y0groWgh7wNfKIfHum5wnVpThYoiOla6EqWIXB4zj0KzHifhzM95LpHna1zX9BeZq8PX07RlcAGDrCgjclhXaGuqHr7ODkXJkbYz8wl1fCNsFP5s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CY8PR12MB7684.namprd12.prod.outlook.com
 (2603:10b6:930:87::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 22:37:01 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 22:37:01 +0000
Message-ID: <9ea351fa-982b-4d9c-8471-03e168852c83@amd.com>
Date: Mon, 9 Nov 2026 17:36:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: wait for the queue quiesce in concurrent SVM
 evictions
To: "Han, Qiang" <Qiang.Han@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Gandham, Shashidhar" <Shashidhar.Gandham@amd.com>,
 "Zhao, Huasha" <Huasha.Zhao@amd.com>, "Gu, Zhenyu" <Zhenyu.Gu@amd.com>
References: <20261109211514.3737466-1-Philip.Yang@amd.com>
 <CY8PR12MB73377D93CC90D214E17B2143E4732@CY8PR12MB7337.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <CY8PR12MB73377D93CC90D214E17B2143E4732@CY8PR12MB7337.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::19) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 57368428-6c9e-444a-2f69-08df3eb1f8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|921020|11063799006|261021121427099003|261021135927099003|261021130227099003|261021123027099003|261021133027099003|261009223027099003|261022105027099003|56012099006|261022075727099003|261022115727099003|261026130827099003|261026140227099003|261026135527099003|261022113327099003|261026121527099003|261102123227099003|4143699003|261028144727099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: AVcBr6PwAzfKZfnO+fZfvIPFSRg7NBhSw6nPRGfV31syD1R5zIpHMXXjnJy6Eb1oPLRmHjSQ7HJtIEQ+TtbNPawe7yaktnOTRtbUT2ceQunMfQHGYmdr2QAEPVSILY3+LdC8QOCAlylLldHR05qKRAQJYYY+EvQ1yY89vfb3GiTEENVjPAMnb1WQcuvnPeCY4TR90QeFQt8atQkgoVYBsrkyGoQwr0eIzznBrSFe7HAi2NYhw7AQjSTayq5w9AokeCRirwXncXvllZsjUzdi9g+v9566nkBdSDZoUzB5zRVJUTwVVdQwPBqQ0P+qpjolDXAvFxPKLqKIXPyhB49fLDfo3bG6YXUuhhauArPDYl3LCPSzvIWz0PFlD4lYen4mrDwP47x8y55H8b2vV3enBvqCCzCse6AVjZoVM+HQdyQ2E7vDtDBSYFxDUGWAqFXepL5RRZs0mc1VZRx3WoxNm4ZvAKbN40rOI1TUYF31jhzTUMWFZf/zjtUgusjaIw3MeNFZ83HZokFNMFWdlIhimCttRb55JieWKLvUIftcNFMy+3bHI6FQxRKckTUiEin5TT3wQ1pVKEmDbTmqbWAwqYqfANVTHr741i4DR8UeN4dhoMTZrk9BYy4AbLSPFDZam2oppDaFevY20Qv/3leV8UzPur3vOvwsjqboLWzLUKkQApd89mDSesqydxiR1CaQBZyi8XaZn/5J6xrIR3ojNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(921020)(11063799006)(261021121427099003)(261021135927099003)(261021130227099003)(261021123027099003)(261021133027099003)(261009223027099003)(261022105027099003)(56012099006)(261022075727099003)(261022115727099003)(261026130827099003)(261026140227099003)(261026135527099003)(261022113327099003)(261026121527099003)(261102123227099003)(4143699003)(261028144727099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVVoWDA0blNXOTBWRldYYWRkT1BCQXpiZ21EcTFWU1djMDdRNXBzTkJRMXhV?=
 =?utf-8?B?WTY0VnY5Z3NwckxkbFc3c01Mb1R0cmlsSm5aOENVQ1VZcHR0YWFaZUd3T2s0?=
 =?utf-8?B?V0xwblEvelBFbEhPd0lkWUhnNVRIWms1YUg5VlRKaDhaZ09jeEp5Q2VvWENX?=
 =?utf-8?B?aElxaGpPb211Q2xMYm15RFc1SEZhc3p6Rkg1cEJtSDZ0RkFaY0IrS2JEUU1w?=
 =?utf-8?B?azJOa2VSbUZ4NVl0MnFHNVlCQkZCejVUOHFHTjJXRXg4eUx3N2gyTVFqSm00?=
 =?utf-8?B?N08rVHBaZnZYZzlKejhqWFRPMks0WHg1OERjS3doQzhGK2E5ZnB0RzRXT3Yz?=
 =?utf-8?B?eUFFWlR4K0dHbHJ6SzNrZUk5YVNRdkpJR1NDSjFzeTI3NW9PR0lTTTEzTVN5?=
 =?utf-8?B?STk2TEpHdTlXTWc5ZmNzVVVuME9ZSWVjU3Bxd0czRGQxTW9YdmgxU0JDbHlt?=
 =?utf-8?B?N09Gc0RZOXY2NXpudXZCbzJiNkl2L2p6Z2VkRHdvUW11SVlkYkNMOTcxN1Fk?=
 =?utf-8?B?SG84QjdCUndxbXpCQXVleHZIKzVjdXl4aStsaEhXM1huYWl0eDdsTnJxMEh1?=
 =?utf-8?B?THhjNXZkcUQ0L3FPU1lYK1ZXQ2svN1ViZmRRTHAyM2hiNzRKSk1pQjcyQThy?=
 =?utf-8?B?RnJIZ1AzYUUzdXVIQVRPQXozSGR5NlJtb3gydFJSNy9lUS95UkRpcTRTMFpn?=
 =?utf-8?B?NlplTjFIc242LzdjZzlmMTV4MHNtZjAyR01pK0RhQ0gzVmNZQ3JPditPL0Vi?=
 =?utf-8?B?NExnaFk2bWdkM3Ezb21qdlRoZWtpUzl2VTJVWWJLd1d4K0doNU1saWhHMXE1?=
 =?utf-8?B?eTRndW5OMjM4UGFwYUg5UktqNXY1ZGpUaHhueDhzbkFUQW42UFN2RDZnVSt5?=
 =?utf-8?B?TFZEcEYzeGl1aDZGa3oyUVZLZW9SQ3EwZlpTK2k3T1BvZ0VPbXZHZHZERmVu?=
 =?utf-8?B?QzRrUGVWNzlOVWpXdFdESitrSHNYR05Xc1NTZFZOdlRGNW53am9XcVdpbHJK?=
 =?utf-8?B?djRXMjQ4L2xTWDNTdFFSMDdDUmFtdis2VThRS2J0K3JNYllSRnE5ekpLL2Vj?=
 =?utf-8?B?REZyTThzczd1K0l3dEw1akgrVG5lY1NTVGE2WG9rcnJmd2pZOENMaE96Nnow?=
 =?utf-8?B?MW8vVnF4blBBNDJKaFN4cjRBNWZCcW9pbFVMZTNjNmI1MVZ1REF2NnhCWnBQ?=
 =?utf-8?B?ZzBOQTJReWMvem9iQXErRWJLVjdPRHk1U1k4b1JnK01hZHB5WU9aQTVFUzg5?=
 =?utf-8?B?a0FJaFBweG1UTUVFZVF3TVRYSndud1NhMkRtaXoyVHd1a0d4UXppVGNBamdm?=
 =?utf-8?B?V1ZYMWk5cjNhV1dicU1KazRUc0J1QmFsQzRySlcvZzQ0TVMvQWJxQ1EyQ2gr?=
 =?utf-8?B?eU4xQmR6b3VDZVU4VGpSM2NmZ1FGeGR6RVZ2d3N6MDdHcHhveEZOQlQwemlC?=
 =?utf-8?B?SkhqeG12U0ErSzIxSjhNODNnN0x0SjJuVzRmemVxL1NzOHdJckJDQ0hvdEZn?=
 =?utf-8?B?aURkeno1dERVbGQ3cjZjNDEzS2tQa1VDYnQza0k4UkN0MXhjbmJrV1NoQWJw?=
 =?utf-8?B?S2IvTXYraTJXaENwbmFaeGJwWmhlZHk2a1ptVk1lN1N3bldyK1pGbWZPYy9R?=
 =?utf-8?B?c3hnQjUyazNRbEpKaUI5a3pSK0MzWEJ4NEs4MlRBQlcySmFQTWRoYnJzaldB?=
 =?utf-8?B?ZUJRTU11YkttTGNvekZqcmJOOENwcVlIbEtVeDBabHhGWGFjdU9WSmlsMmxL?=
 =?utf-8?B?enhUV1NFa1cxRVlrdmZuYlFZU0lObVc3a3pabnh5dmI1NnVMNi9teUFNWjgx?=
 =?utf-8?B?S2xMdUEvSkpDMUdRU0VucXN5MU5tZmdBbEoxbVNhemh0Rko3S3lrTGtNNWk0?=
 =?utf-8?B?UHJxN2paUkJWb094Z0NqUzhqbGhZblRNNnFid092VFdZOGVobE9Nai9ER2VZ?=
 =?utf-8?B?V2NNaXVEZDZUQ1g4WnpxenlhV04vMVlLUnh3d2ZLNDlMN0hiK1FYNmF4VVVx?=
 =?utf-8?B?ZmJHRW8wYlRJQjJtdjg0d2svWVJqWXNiTGNNdTVSRWx5VUdzRUFzaDk2b2dh?=
 =?utf-8?B?RTJPU0NwU0w0QzlkenptN0pmQklOTnhoOHJoWTIvZ2t5bVRHT3d5UGVyMDZ5?=
 =?utf-8?B?bjRuYjRyWkZzUGdRNWNpUFVINjdyamV4cGxQSUZ6RFlxSGxQSVZ6ODhlR0tn?=
 =?utf-8?B?SDZ5UFF2ZmNwekZ3bkk3Q0ErQ3BvbURZTXFLOW9DRW80YVI3VFlJcDJBdzVt?=
 =?utf-8?B?eGEvbkYzdjZSWmM5b0plNzdZMXRSN0o0RHozK3doNmFWcndkR1lmODdnbGwz?=
 =?utf-8?B?NFhzc0ZFK1k0RGFqamVoL251Q2JqcVUvSGd0NWxoL1FtUmZqcTdFZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57368428-6c9e-444a-2f69-08df3eb1f8a5
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 22:37:01.2758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWRtQ4umhiWCmxf84gEBeeV3J4MjJ/GrRQo5WvqnhRIfbBgxczCNSqr779Rut932YO3KxagRAs0bVro5wOLjig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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

On 2026-11-09 16:35, Han, Qiang wrote:
> AMD General
>
> cc @Zhao, Huasha @Gu, Zhenyu
>
> -----Original Message-----
> From: Yang, Philip <Philip.Yang@amd.com>
> Sent: Monday, November 9, 2026 1:15 PM
> To: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>; Gandham, Shashidhar <Shashidhar.Gandham@amd.com>; Han, Qiang <Qiang.Han@amd.com>
> Cc: Han, Qiang <Qiang.Han@amd.com>; Yang, Philip <Philip.Yang@amd.com>
> Subject: [PATCH] drm/amdkfd: wait for the queue quiesce in concurrent SVM evictions
>
> From: Qiang Han <qiangh@amd.com>
>
> With XNACK off, svm_range_evict() leaves the GPU page tables in place and relies on the process's queues being stopped before the MMU notifier returns.
>
> Only the first eviction (evicted_ranges == 1) calls kgd2kfd_quiesce_mm(). The quiesce preempts every GPU the process has opened and takes milliseconds. Any other range invalidated in the meantime sees evicted_ranges > 1 and returns at once. The core mm then frees, migrates or reuses the page while the queues still run, and an in-flight SDMA or blit copy accesses it through the old GPU PTE. The result is silent corruption of the copy, or of whatever process now owns the page.
>
> Hold a new svms->evict_lock across the first evictor's quiesce, so that concurrent evictions return only after the queues have stopped. This is the scheme amdgpu_amdkfd_evict_userptr() uses with process_info->notifier_lock. evict_lock nests inside prange->lock and is taken nowhere else. Under it, the quiesce path takes the dqm lock, which is already used in MMU notifiers (memalloc_noreclaim).
>
> One way to reach this: a pageable hipMemcpy() larger than 1 MiB. ROCclr pins the buffer with hsa_amd_memory_lock(), libhsakmt registers it as a KFD SVM range, and host memory pressure (reclaim, compaction, allocator purge) invalidates the range.
>
> Fixes: 8a7c184a16d7 ("drm/amdkfd: svm range eviction and restore")
> Signed-off-by: Qing Hang <Qiang.Han@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 ++  drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 35 ++++++++++++++++++---------
>   2 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 158fa70a1a8e..581fb7ceba40 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -909,6 +909,8 @@ struct svm_range_list {
>          struct list_head                deferred_range_list;
>          struct list_head                criu_svm_metadata_list;
>          spinlock_t                      deferred_list_lock;
> +       /* serializes XNACK-off evictions with the queue quiesce */
> +       struct mutex                    evict_lock;
>          atomic_t                        evicted_ranges;
>          atomic_t                        drain_pagefaults;
>          struct delayed_work             restore_work;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3688ae7ba35e..8b84333a85b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2141,21 +2141,30 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>                  if (prange->start <= last && prange->last >= start)
>                          atomic_inc(&prange->invalid);
>
> +               /* The MMU notifier must not return before the GPU has stopped
> +                * accessing the invalidated pages. Only the first eviction stops
> +                * the queues, which takes milliseconds (HWS preemption on every
> +                * GPU of the process). Serialize all evictions of this process so
> +                * that a concurrent invalidation of another range waits until
> +                * that quiesce has completed instead of returning while queues
> +                * still run on stale PTEs.
> +                */
> +               mutex_lock(&svms->evict_lock);
>                  evicted_ranges = atomic_inc_return(&svms->evicted_ranges);
> -               if (evicted_ranges != 1)
> -                       return r;
> -
> -               pr_debug("evicting svms 0x%p range [0x%lx 0x%lx]\n",
> -                        prange->svms, prange->start, prange->last);
> +               if (evicted_ranges == 1) {
> +                       pr_debug("evicting svms 0x%p range [0x%lx 0x%lx]\n",
> +                                prange->svms, prange->start, prange->last);
>
> -               /* First eviction, stop the queues */
> -               r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
> -               if (r)
> -                       pr_debug("failed to quiesce KFD\n");
> +                       /* First eviction, stop the queues */
> +                       r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
> +                       if (r)
> +                               pr_debug("failed to quiesce KFD\n");
>
> -               pr_debug("schedule to restore svm %p ranges\n", svms);
> -               queue_delayed_work(system_freezable_wq, &svms->restore_work,
> -                       msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
> +                       pr_debug("schedule to restore svm %p ranges\n", svms);
> +                       queue_delayed_work(system_freezable_wq, &svms->restore_work,
> +                                          msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
> +               }
> +               mutex_unlock(&svms->evict_lock);
>          } else {
>                  unsigned long s, l;
>                  uint32_t trigger;
> @@ -3437,6 +3446,7 @@ void svm_range_list_fini(struct kfd_process *p)
>                  svm_range_free(prange, true);
>          }
>
> +       mutex_destroy(&p->svms.evict_lock);
>          mutex_destroy(&p->svms.lock);
>
>          pr_debug("process pid %d svms 0x%p done\n", @@ -3450,6 +3460,7 @@ int svm_range_list_init(struct kfd_process *p)
>
>          svms->objects = RB_ROOT_CACHED;
>          mutex_init(&svms->lock);
> +       mutex_init(&svms->evict_lock);
>          INIT_LIST_HEAD(&svms->list);
>          atomic_set(&svms->evicted_ranges, 0);
>          atomic_set(&svms->drain_pagefaults, 0);
> --
> 2.50.1
