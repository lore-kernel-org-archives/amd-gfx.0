Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4A606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EKnMVzZh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C40B10E19A;
	Thu,  5 Nov 2026 22:17:11 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769B710E19A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 22:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrmaihIKSbHKqZagMepqk70STjABbcHggWxQp+RLvj9SxFpRP8AvJGML+vH1JHIFcg+lnUK8PxsG21NZKFmOWXDrFoYbdIyFG9vAS10NEs1/HF9CquWMcqG69Al41w+qaPZmjFO2Aj28Qqi107znT2/HWa3fNAQzLOtOIz+NFhHnxlFi9OQU1mqUUAdlJgpHAOG76BmI39+wXk7PpXEqgLavy3YlW8tJoAotALIaeG3JejvdhuKOGh1f9o/Zisd5wcQGYgx001pp/NbaNMeLIDbEHsMGyxOWqUDgzUtg59BAeCVuLbaKtMy7Ouk7cuRPlOKwZZrgZFJ+SKo4ErXZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEdQZYayd51jSNmITo5QveZ2vcUIhmPPskDCdl1toas=;
 b=UE/kZtKj9AmjaRzePzTKSHiaWPz3Rf9938O6i5k/IPzcEN7qS/dbBtHUrd/JUdF2gQhj6YG2n2qpJ4PxfHbkIgonRiE04S9EXsBT/GyT1Dvz4WuYG6pjgFch2WwR6C0f3UgV1DnWliK6KjMyJiszE33n7AQj0j8FLFMqFS4WoBbGI59VcC9HYdE03kIn7c34JrrmmYUDytI1+RcsHWQXQ5o1DL2+7rZSnoqwCS7phIIgkXBdOnXWX1VUXxBwaZjBJytynosn3Isu1ZE7uAbY9f7xkUg8k+e4VJ2+foWLZP66I1yRRpxnwTYz/QQBYQiGsJuvbWp+nPbzusP3Cm0Gsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEdQZYayd51jSNmITo5QveZ2vcUIhmPPskDCdl1toas=;
 b=EKnMVzZh0KJ6x6mkZ+rTI/6g6UvLZQmCB8QDIF99dPq3Ao9lUVsKCWA7UYja4msnwXj7iEirsA+Kpa2FQgywEnipwAZvOe6h00UKs6W0emO0SI2VTOSoIG9eJa8yI+TYVF/f8WpdXe313qP80Bbxx/JGcVLrxYITLqQpQt9+9ns=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by FT1PR12MB183566.namprd12.prod.outlook.com
 (2603:10b6:170:2b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 22:17:02 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 22:17:02 +0000
Message-ID: <5266da9d-0b3d-4f2a-9ad1-68a74e11f866@amd.com>
Date: Thu, 5 Nov 2026 17:17:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] drm/amdkfd: Add support for discontiguous and
 CPU-less NUMA topologies
To: Dhruv B <dhruv.b@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
References: <20261104190718.68457-1-dhruv.b@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261104190718.68457-1-dhruv.b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::33) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|FT1PR12MB183566:EE_
X-MS-Office365-Filtering-Correlation-Id: 976ac780-e4c6-47b0-206e-08df3b8a8488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|260925021311599003|260925021911599003|260925022911599003|11063799006|261021123027099003|5023799004|261009223027099003|56012099006|261021121427099003|261102123227099003|261022075727099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: QnXe6T8MEPQb/jSLEtWhi5DJiK8dPyljOCwMq9vGa76K64eTHw6Rg1yprCVZkuQo7Kdr1p4AqOFVX2XdHohRf0zRb9Ek8FPe/cRygpfcXOefXyArVcxTjQmLG7Lhh/tKm4a9m3WieUBg3oy1QrM65k3rrWGmuJ1xvgKHCyhN+vS2twTRZ6PDMe/SSBr2M58uMfReTMiacbSOY/lfmfsUeN0XEt5aJ1ld4HagmLmA5fo2yzfpu0Lbpb0cCuo9GUfBuy7qE8ZvVRaNlpzhodBR8nLxoC4kK5fOSRPosdkTe2iG+VZN3cUEH5W1U0BRENGG9Te8LSml+bedJdXKsi62Fiok+So0i5wf9/pgOJNO7a495rCyY3ksJvs3bvC4RDmRgJo44f93pj+42CswOtRMoFPCB4P46w22Mwg5LANJ2jw2tss5rP9QB6O3jEIOjmwo6GkUl482aunJU180oOWyO9gBekmVH0yzuHSIJYRjouOSMH9ZZDnYOxYM2nStDV9NWeR4t8oI00zgXgbAnlZKKhixCUelKYx7AtLCKwyXH8Xzh8/ebgz7tFQgF4JsTPx6QDqFrDo9ntY0ty3w/RFGy7t1M0sHODFafbJ89OIprErPt3sBqUMquL4V2L+PB32B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006)(261021123027099003)(5023799004)(261009223027099003)(56012099006)(261021121427099003)(261102123227099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEFVZzRtTkFra05XTXhMSkdUY3AxditFaTlPSEVGcTFWSU84NXhIaHlnWHh1?=
 =?utf-8?B?aDB4V09xZm5WZUc4QWlZc3dGeHh3TjdZQ2FXWm5rZ1VIV0VrdVFCUU5Oei9k?=
 =?utf-8?B?VkErbnhhQk0ydWNHdHlFd09FZDFsQmlXOGEzZkQreStwYjMvaXkxaTJBU2hI?=
 =?utf-8?B?VFlQRzVITGZCZ2lLMGFXeW9EOFJYMEdnUElRS2wvcW5HWFBNMmFPMUZ1ZGxu?=
 =?utf-8?B?KzdxZk0ySmZZNGM0OCt6M25VK3RNcHpaa09NMzdGQWxva0YxbzczdmxSY1d2?=
 =?utf-8?B?NUluR0p3OHp0R01sODVPSzRNV1pBcjdrK3dGSlNRaG10NDBST0s0UEc4RE9R?=
 =?utf-8?B?ZFF1NlNCMDlTeHFNWEhaZzJhbExZemZmcWVCb2FIQUJJaE5EMmd3S3ZpK1J4?=
 =?utf-8?B?L0h4NGpQNXZ4Szhra3NlOTJUaXViZ1UzdmlITWsya2lDaHRrRXpJZmpybW9T?=
 =?utf-8?B?NjRMai9nNEVDOGx2ZUNnakRjTlVMQytVQ2lsbDlUeW13SHRzVlNxMVp3dUM4?=
 =?utf-8?B?THBvL2c2SDYwR0pKM1RGUHBtWS9iT0V5SFRRSnRRKzZCaW1LdzhUS3FpRWlW?=
 =?utf-8?B?akhVWEs1V2tFdzRiSUVMU1VIcnZHUG1uYzg1dHpNR0RtUEN0MVo5Uk9EOEdI?=
 =?utf-8?B?YlZSZG9BNnp5cmRtZkZZanJPTkRPMkdERVppZktnSW1MZlZqd2t4RGM4K2lC?=
 =?utf-8?B?OE95SGpzTFdGR3lEQ1hKeUhYb0hpRDhhckczaDlKYzU1eS9zKzFEYmNHRHZr?=
 =?utf-8?B?VkxHcXhQaEtKRHB5SVU2ckxGbXg0TzF4c1E1TTNaMjl5RTJZVG9sRXY2bVhp?=
 =?utf-8?B?V2srWHBZT2JoenUxNFJiQTZ5ZS8wT1pXTXNra0Ixbk9yQnc1eXJVMXdaTHJE?=
 =?utf-8?B?S0VQRitnQkNNc25tTU5sK01kUWxYS2RSRmRMU3huYmVFMlUyS0Izd1FUem44?=
 =?utf-8?B?bXhwT1UxV2JVNWI3dTNYZkp2R3VhZHBVV2ZiVTNFSWt3QnpqV3pPMFhRRWlq?=
 =?utf-8?B?RnNWS1lOOGpsLy9DUmI4R05xa1hIcXplOFpUNm92MTFYN05YQi9xYW9ON2lS?=
 =?utf-8?B?c2JKMENVWUtHZmZxR1Fvak1oWjRwTDBEOCsxK1dCZTVGNjhzTEZraU52WnNs?=
 =?utf-8?B?Vksxc0JQaHZlV25vcFcwOWVjVUpqS3k5U291Y3BVVDYrWlRmWnB5cXVLWkdr?=
 =?utf-8?B?a28zUzhLbHhvUDl3SGZ0N2sydGpwci9IM3YzQkcwZlpDSUR0RkRPZEM2MU52?=
 =?utf-8?B?ZjE5SzRoYmJMTVJXY2RGWGp1ZHZLZTBJbU1JNGFmbVhJc25PL3BWQ1NvK1Fs?=
 =?utf-8?B?alI0eHRxQXlpUW55a1dGUmZrQVM1WkpNRVNDNzBlZkU4K1V5dEVHdEtwanJr?=
 =?utf-8?B?RGhLVjIwWnQwd3BvQmhGVXdUczZsWXM5eHc3cmRvR3JRZTJ4L0g5K1B2aXN6?=
 =?utf-8?B?aE4wTjlmS3pucVNUR0lBQll0emMvRkdMRlk0SEhBdzI5OWVreXZ6a2Y3WkJp?=
 =?utf-8?B?aFY4ajRGMHFpd0tnaUR0VGVTQVFEbE0xRHVWTXZRSXZsRXduVkU1bWEzWUxY?=
 =?utf-8?B?bVg5OFMrd2dnWmgyTGFLY01ZMC9YVmVQNzNUcVZKMTFuekE3YmJKclZ3TkVv?=
 =?utf-8?B?ZjJNTUp2MHhKeDM0ckYvMktqOE4yK29qT0VJME04SW5TRFRIUG1ZU0VZd2dy?=
 =?utf-8?B?SGNIWGRFeVEzempqbHIzam1DZW1aZlEyZVB4aGNlbEpPeEhLaGVLVWVEeFk5?=
 =?utf-8?B?UVkyUjdsN1Z5c3N6N01icUo2VTFOWW5jTjJtUXdaNUh4RXVlZ09QOTZFVWl5?=
 =?utf-8?B?Y25RTlVkeDFhQ1BwVXpnMlRBeGh5cWN4NWFPb0xaZzErZ3pUVDIvQ1RKMVRt?=
 =?utf-8?B?cEU2UTZLY1g2R25qd1YwRzVlUzJuZnI3L29GZWVuUzV3T0FUc0MxZEJJZ0Z5?=
 =?utf-8?B?MVdZTFpuV2RqL1dLU2FpRGhXYTcyT1pxRmdSOWN5RExMc1MvM0p6SDRoeW43?=
 =?utf-8?B?cWVkb2hEQXdwdzZ2U1ZmTzFFN3B4VGJCemZMMUZvU0MwUmpnWStHMFRaYkpF?=
 =?utf-8?B?cFlQaFVaOW1RSXUzeTB2Si9oOE5UMEpLaVppa0pYdUVrZk9MVWhTcjJhdDc3?=
 =?utf-8?B?TlhqSWlaMzlMejFwNXVXTEhtcGFQWnZPMXA3akcxWFFaK2duUi8zaU41S3F2?=
 =?utf-8?B?WStuZFVDYVU1OEtJeStxQWt6a25VTFJlaUJRbWtaY1N5WWpqSkdZSUtVNFQ4?=
 =?utf-8?B?RWpBVnlKSFJLamdwcDV5T21IeUw0YUczdWVpMVozRFFrcDN2UTg4ZUN0L2Rs?=
 =?utf-8?B?RW5xS2h6ZlhtZE1GQXBXVkpqRnVycDgzRTMyL0RrT1BZdVlNYVdIdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976ac780-e4c6-47b0-206e-08df3b8a8488
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 22:17:02.7366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ug8HCdUx5mw0nCFr0/yC81O2RHrn7BgO1MktvknY1lww75q/Uw/hRT8as0txUWlzW5EG72l3zFeUhBowK/qnFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB183566
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

On 2026-11-04 14:07, Dhruv B wrote:
> This series fixes VCRAT generation in AMDKFD for systems that do not
> provide a CRAT table and where the driver generates a Virtual CRAT
> (VCRAT) for the CPU topology.

The series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

I applied it to amd-staging-drm-next. Thank you!


>
> The current implementation uses for_each_online_node() to iterate over
> NUMA nodes and assigns proximity domain IDs sequentially (0, 1, 2, ...)
> regardless of the actual NUMA node IDs. It also assumes that every
> online NUMA node contains both CPUs and memory, unconditionally
> emitting Compute Unit and Memory CRAT subtypes for each node.
>
> These assumptions break on systems with:
>
>    Discontiguous (sparse) NUMA node IDs
>    CPU-less NUMA nodes
>    Memory-less NUMA nodes
>
> For example:
>
>    available: 3 nodes (0,2-3)
>
>    node 0: CPUs present
>    node 2: CPU-less
>    node 3: CPU-less
>
> In this case, the existing code iterates over nodes 0, 2 and 3 and
> assigns proximity domains 0, 1 and 2 respectively, instead of 0, 2
> and 3. The mismatch between NUMA node IDs and proximity domain IDs
> results in an inconsistent KFD topology and causes topology parsing
> to fail with:
>
>    amdgpu: Virtual CRAT table created for GPU
>    amdgpu: Error parsing VCRAT
>    kfd: amdgpu: Error adding device to topology
>    kfd: amdgpu: Error initializing KFD node
>
> To fix the proximity domain mismatch, the VCRAT generation loop is
> changed to iterate over the complete NUMA node ID range up to the
> last online node, incrementing num_domains for every node ID in the
> range. This preserves a direct 1:1 mapping between NUMA node ID and
> proximity domain ID, while skipping resource entry creation for
> offline or unpopulated node IDs.
>
> To fix the unconditional subtype emission, explicit guards are added
> so that Compute Unit entries are only written for nodes that have
> CPUs (kfd_numa_node_to_apic_id() != -1), and Memory entries are only
> written for nodes that contain memory (node_state(numa_node_id, N_MEMORY)).
>
> Additionally, kfd_parse_subtype_mem() is updated to use simd_count
> instead of cpu_cores_count to distinguish host nodes from GPU nodes.
> This ensures that memory on CPU-less host NUMA nodes (e.g. CXL memory,
> PMEM, or memory-only NUMA partitions) is correctly classified as
> system memory (HSA_MEM_HEAP_TYPE_SYSTEM) rather than private GPU
> framebuffer memory.
>
> The placeholder domains created for offline node IDs have no IO links,
> so skip offline nodes when building indirect GPU to CPU links. For Large
> BAR, reverse CPU-to-GPU indirect links are only created if the node has
> CPUs (node_state(i, N_CPU)). Additionally, missing CPU interconnect links
> are skipped so they do not abort GPU-to-GPU P2P link creation.
>
> On a system with contiguous NUMA nodes, numactl reports:
>
>    $ numactl -H
>    available: 4 nodes (0-3)
>    node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
>             18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33
>             34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49
>             50 51 52 53 54 55
>    node 0 size: 881496 MB
>    node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
>             71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86
>             87 88 89 90 91 92 93 94 95 96 97 98 99 100 101
>             102 103 104 105 106 107 108 109 110 111
>    node 1 size: 885640 MB
>    node 2 cpus: 112 113 114 115 116 117 118 119 120 121 122
>             123 124 125 126 127 128 129 130 131 132 133 134
>             135 136 137 138 139 140 141 142 143 144 145 146
>             147 148 149 150 151 152 153 154 155 156 157 158
>             159 160 161 162 163 164 165 166 167
>    node 2 size: 885640 MB
>    node 3 cpus: 168 169 170 171 172 173 174 175 176 177 178
>             179 180 181 182 183 184 185 186 187 188 189 190
>             191 192 193 194 195 196 197 198 199 200 201 202
>             203 204 205 206 207 208 209 210 211 212 213 214
>             215 216 217 218 219 220 221 222 223
>    node 3 size: 885394 MB
>
> The KFD topology sysfs reflects all 4 CPU nodes plus 2 GPUs:
>
>    /sys/class/kfd/kfd/topology/nodes: 0  1  2  3  4  5
>
>    0: cpu_cores_count 56  mem_banks_count 1  io_links_count 0
>    1: cpu_cores_count 56  mem_banks_count 1  io_links_count 0
>    2: cpu_cores_count 56  mem_banks_count 1  io_links_count 2
>    3: cpu_cores_count 56  mem_banks_count 1  io_links_count 0
>    4: cpu_cores_count 0   simd_count 416     io_links_count 1 (GPU)
>    5: cpu_cores_count 0   simd_count 416     io_links_count 1 (GPU)
>
> On the same system with sparse NUMA nodes, numactl reports:
>
>    $ numactl -H
>    available: 3 nodes (0,2-3)
>    node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
>             18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33
>             34 35 36 37 38 39
>    node 0 size: 519305 MB
>    node 2 cpus:
>    node 2 size: 0 MB
>    node 3 cpus:
>    node 3 size: 0 MB
>
> After this series the KFD topology sysfs correctly reflects all node
> IDs including the absent node 1 as a placeholder:
>
>    /sys/class/kfd/kfd/topology/nodes: 0  1  2  3  4  5
>
>    0: cpu_cores_count 40  mem_banks_count 1  io_links_count 0
>    1: cpu_cores_count 0   mem_banks_count 0  io_links_count 0 (Absent)
>    2: cpu_cores_count 0   mem_banks_count 0  io_links_count 2 (CPU-less)
>    3: cpu_cores_count 0   mem_banks_count 0  io_links_count 0 (CPU-less)
>    4: cpu_cores_count 0   simd_count 416     io_links_count 1 (GPU)
>    5: cpu_cores_count 0   simd_count 416     io_links_count 1 (GPU)
>
> The GPU I/O links correctly reference proximity domain 2, which
> corresponds directly to NUMA node 2 where the GPUs are physically
> attached. This is confirmed by the io_links sysfs entries:
>
>    node 4 io_link: node_from 4  node_to 2  type 2  max_bandwidth 10000
>    node 5 io_link: node_from 5  node_to 2  type 2  max_bandwidth 10000
>
> Both GPUs report node_to 2, matching the proximity domain of NUMA
> node 2 (the CPU-less node to which the GPUs are connected).
>
> This series consists of the following patches:
>
> Patch 1 removes unused code in the CRAT initialization path as a
> preparatory cleanup.
>
> Patch 2 fixes the proximity domain mismatch by iterating through
> the complete NUMA node ID range and preserving a direct NUMA-node-
> to-proximity-domain mapping. Emits Compute Unit and Memory CRAT
> entries only for nodes that have the corresponding resources, updates
> the memory subtype parser to key off simd_count, and makes
> kfd_create_indirect_link_prop() skip offline nodes and invalid Large
> BAR links on CPU-less nodes.
> ---
> v3 -> v4
> - Addressed Felix's review comments:
>    - Preserved GPU -> CPU-less NUMA node indirect links so the GPU can
>      access memory on CPU-less nodes (e.g. CXL memory), while restricting
>      the reverse Large BAR CPU -> GPU link to nodes with CPUs
>      (node_state(i, N_CPU)).
>    - Changed missing cpu_link handling in kfd_create_indirect_link_prop()
>      from returning -ENOMEM to continue so missing CPU interconnects
>      do not abort GPU-to-GPU P2P link creation.
>
> v2 -> v3
> - Addressed Felix's review comments:
>    - Fixed a regression in kfd_create_indirect_link_prop(). Placeholder
>      domains and CPU-less nodes have no CPU IO links, so the lookup failed
>      with -ENOMEM and all indirect GPU links were silently dropped. Such
>      nodes are now skipped.
>    - Updated kfd_parse_subtype_mem() to use simd_count instead of
>      cpu_cores_count to distinguish host nodes from GPU nodes so that memory
>      on CPU-less host nodes is correctly classified as HSA_MEM_HEAP_TYPE_SYSTEM.
>    - Only emit Compute Unit entries for nodes with CPUs, and Memory entries
>      for nodes with memory.
>
> v1 -> v2
> - Addressed Felix's comment and fixed the incorrect proximity domain mapping
>    caused due to crat_table->num_domains++ being at the start of the loop.
>
> v3 - https://lore.kernel.org/all/20261030083304.9767-1-dhruv.b@linux.ibm.com/
> v2 - https://lore.kernel.org/all/cover.1791289746.git.dhruv.b@linux.ibm.com/
> v1 - https://lore.kernel.org/all/cover.1791208447.git.dhruv.b@linux.ibm.com/
> ---
> Dhruv B (2):
>    drm/amdkfd: Remove unused code in CRAT initialization
>    drm/amdkfd: Add support for discontiguous and CPU-less NUMA topologies
>
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 69 +++++++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 19 ++++++------------
>   3 files changed, 45 insertions(+), 45 deletions(-)
>
