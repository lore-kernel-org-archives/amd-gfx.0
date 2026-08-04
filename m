Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FA7C55822
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 22:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD2E610E128;
	Tue,  4 Aug 2026 22:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jb7bKoFO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29AE10E128
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 22:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ow0B+9oUwIzVtxooC/t4luAz34Wf2HV1z1LVCI06OBFxHjmfco+SNqGR9VMe+hKc4YiWtQPE2iSVyYU46yTGjjNo4cCZAjPXya5+pMcROYAx6STc63gDf80PH+0M6nmxjD5t6f104NckYLSEXnPQkWiu9Ya2HmxECYsoFc433Q+UaHj7EA1C8I05DrjCL6eId6xt1RrE/ygneDLbgvjaQ0/Mv0czzNz8W7uZ1qJ4VGd+0sChICbMPJQJpCknC7rY9IdwRoceyf++gBp8RrUetItCXlN5VeU812sV6+DfbUEDAPa64ea4b2Zox0vrNzVWGLBf/nG213hW7A/UHNLOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8nb5Ui+gY0bhM6uTbWO9vu1Doc86WmY7OzEWDhn5oE=;
 b=H3Kt67T6khZv0m74HGTYSu90Nku+Ye4H2jma664IDziqfSHkrR3BLOHuEywJeQFjSj5V542ndEsQrJqxLsA5GuI70PDVtyl+fOQgsMSTby4YCg2lIFMvdVvcP2jzQaGQcsKlhS6+jq+yKdaN5rQoUOrSH4G/VaJxF2crLW6RPv6L7Ax3hUxsBNZE/vpErJ8RXI5qe7GzVMTOgLihVc57zNITRL0MrcFEs8eUkf+CyGW0KgN/fRLBib7T4qgo3JAHaontRELfZnqwtoJzjtK1iZg6mWkqT5+U/wzwxKkOV9kyCma1AfFqzqsSCGDkibT61t9e6A6xzDA+E7H3g3ZOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8nb5Ui+gY0bhM6uTbWO9vu1Doc86WmY7OzEWDhn5oE=;
 b=Jb7bKoFO43Prp4wXmeEZlK5Z+YE+auntK193pFcnt0WZl/XHs+9gk/pmrIhFqPuvpxI8ODV25iyp/jzZlS2q8Z8TOkjuNQ6Co2N2GFD83Be9T6wz8X/PtMIMrc7/cozfX5rtZTewOr781sAiq/d4GiHYMd9dDrycWRYOtpBclIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by MW5PR12MB5597.namprd12.prod.outlook.com
 (2603:10b6:303:192::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 22:27:22 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 22:27:22 +0000
Message-ID: <16887553-76eb-4af9-8769-f77f4fb9fb68@amd.com>
Date: Tue, 4 Aug 2026 18:27:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/amdgpu: Fix topology device creation and
 proximity domain mappings for sparse and CPU-less NUMA systems
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <cover.1785833981.git.donettom@linux.ibm.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <cover.1785833981.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0174.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::18) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: be4f4a20-008a-4639-e83e-08def2778d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4o2AMwJp0RmmNHx7h011Z57L4qNbRzB/i2yjGQADjDqyibNk0JUXuHZslalJmNG8VXIKsdDPp51Jfqh8GOmWUumo5LN3chJkjXCjCvohEFDWgQOTsfcn5bUWHU1/vE61eeGzw/PPJOgmSi+Bhve8dkdpkkv0GT9Mj6J9kKLW9YV5hlVaT8BBnBJT1sr4/NZaMtUBNJRTlvPm/hGy4o42mc7xkw8me6NkrHBAFFl3KtHYDNo9dXZtu/ccdFfzFYyFimUdYAWiZ7L3cNPC2GjAav8Y43GjjgDdX1ieoKBzYLblW4bXtaHZJs7vm/ffhIibhqt3mu4Ng9Gkhstg2/ucDKvO3GcNQGPTndy7ynJz7XksTrnn9OLofbhDAPD1ge72A3jU3UetSLbgTWskGvhVz2YILBJDqVf7GJNjzM46UIMrs7yXSBQ/jYn6muCxoDMvgMhCDOtlYmL8KUMoShvxiRQ9qVKcWA76AicVizJAgQuDET69Ovc5fOJJMzFbwezVSf6unqvslP0gFcBagcVNb9123L0pB31YXw0VZQIcBB7zo1M2hOodOxhanBd2TuqJCv+wpkBHjfkY551mmYPLTaoU8fg5S50aG9ug/nAg1xE6gDbCq+8i6ykki4nZpWElnzLeBzYH9deOmGsG/7PJAr/9y47PefRkEzadL6RNaow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdHVW4zYzV4N1FHeit5ckhwTHJZSG1WSlU2M01JV3diYUNTSFhUNWlpeVBo?=
 =?utf-8?B?WFdCMXlsNzdQN0E4RE9veUdRQ2t3cG1hV2x1cm94MG5YckNaelhKK1JSYzJT?=
 =?utf-8?B?L0ZidTFuRXlrVXpPMWhUQk84Q09mZHdyOVZXNXJQc2QrTzBGRUFBTmY5NmZ3?=
 =?utf-8?B?UzdiQ1FETG9LSW43ZVltL2dhdkFMK0N5cmtXRHFNYmhzUVRvVFltRFVBV2pF?=
 =?utf-8?B?MFkyWlprWWJwc0tKdkc1RlZHWDZ2WllWRzcxL1hPeXk1ZUpkQ2JNM3ZSaUR1?=
 =?utf-8?B?ZkUrbFJtVjY3N2RuRWJ5bk1mL1pUNTR2V1NMdjhpOUJpNkJ0TnpKQ3crOC9o?=
 =?utf-8?B?cTRGYWx6aTJROEJteVhPMURtUzZSVmFTelZrSStsNm5NYUhpTXRrWm5SbjhY?=
 =?utf-8?B?aG5pYUdGcG1FanM0NXRaUjh1c2JjTDl2WDRzWC9CYnp4YkxIc1o1RXRWaTdZ?=
 =?utf-8?B?MllLakYxdExPN3BWT2JCU1dEbkpEOFE1dDl4bktGUlhsc3h5TFM5NzR0dlZa?=
 =?utf-8?B?YVBPa0swUHZPYzhBbVdYZ1dxb3UrUUJkd0tRVXkyZG8reVVpTktsL09YUm5O?=
 =?utf-8?B?QWppUGt0WDZFZStBL3o5VFozQ2tDVmlEejhGaVUyWGdENHZQQzJyaDBSdTJ4?=
 =?utf-8?B?clJ3R1JiYVd0OFFRNFhOQ09tTlRjU2FIYWhiYU5LSGVMZnluR1pmenNGV0Yw?=
 =?utf-8?B?TzRsOEZ4MVN6ejNMY1V6SjhHYWNPU0N0VlVXUHc5N3p2eFpSalNxUkdNYzFv?=
 =?utf-8?B?bFlUcnJJWXhta1dMbitxZ1h2ZlQvdFRCTDhrQXhwdjg5Mi9UVVpDbHR2ZjFq?=
 =?utf-8?B?cm5SNld6NHJKa3IzTVBka2Y2WFpUYlV1UnBhZUZhN1pVenhFVnFzS0RseFp3?=
 =?utf-8?B?dzVSNUVUb2xBSDFFdUg3UkNzNTNjK05selBVVWZYZTJMcDFsVjlNeDVPSDgy?=
 =?utf-8?B?bW5peWxWaTg4MlB4UEoxclc5R24zWmNxR2N0emVuL1JHSkJJS3RkWUM2cEdU?=
 =?utf-8?B?SFNwUUErVkxvdkJtaVA1clpZVXhYa3R6UVRpWGlEYlUxZ0hFbUU3TzlNUGpM?=
 =?utf-8?B?UE1BdUx6NTZ6SGQ4ZDhHenp2WGVKZnZYTG9NazIxMFhUUHRiQkJEY013TCtK?=
 =?utf-8?B?UDRnRUg2Q2QxdFJJaFVxQTNEVGtmOVJ0M1VhQWhZclBuMGNETkZYYklxRyt2?=
 =?utf-8?B?MWFQR3Uya21QQmswV2hhWUNmL1lMQTB6R01FUHk3Z2xoQVBhQkhDSEI3ZEUv?=
 =?utf-8?B?V1cvRzNueHlMRGxtZG1ncWx2VWY1LysrT1REdDFUMEJRVy85WVptZkxWYVhv?=
 =?utf-8?B?V1lXdDNkVjdXbU82K2J0MElLM1o5OHNURXB2bXBxdUZjakovMmppZk1LY2dX?=
 =?utf-8?B?OTIwcTNYOERIcjdxK3krWk5qaGpUS0R4S1dGSDFVM1hqTXphWnNiRGxWK0c0?=
 =?utf-8?B?M1lVbkZESElpVXg0dHhaWmlURWlNWEN3WkhaSGNLLzZweUtORDNWVUhXWnFq?=
 =?utf-8?B?Unl3NEZwaWg1eXpPS3RVdnBQUDcwVVFpZ2RHL0kyNU5xZHZJci9VY2dGMFZL?=
 =?utf-8?B?bEhtT2FMRTdxR1NuRnpnR3Yycnl4NWdERHNjVHhXYWM2R3FCUjltamt2TWl3?=
 =?utf-8?B?N3Q4ckpjemVlV0djajkxb00xTTlIM2ZSajN4cGxUUEZlYVNTajIzMGtkcUJH?=
 =?utf-8?B?dXMrRzdtOStFMUVZOVpZUTdrbUF6UzgrOXJ2OE9hc3FzT2F3QW1BTm1GTWdm?=
 =?utf-8?B?cDRVemh0VWc0UEZYdDVQSkNic0lpSmNHRzIzUTMraWVCWm11UnVDR0JaSUdw?=
 =?utf-8?B?OEc3MEVRZ2xLU2RzZXU4QVBsYnJBWjNPSHVNcnBjQ3lDQVF3RlF5NTk0SGJx?=
 =?utf-8?B?NUpNZk9FMWE4dlZsU0FPckpOYmdiMWM1dm41dUFpY0x4SmN3SlNVeUJycUp6?=
 =?utf-8?B?c2pMZTNGL3pXa3Z2QjFXM1ZncmNUemp3MmZGSC9Xb0tWUjhWa25ZUWd2dkx1?=
 =?utf-8?B?eDVUYkVXbGwzNm1uWTFiejc4cDd2Ky9vaHgza3AxZFdCeGVSMjgxeVBlU1Fa?=
 =?utf-8?B?bjhmU1FnTHg3dElXdlpGZ054K0w3SWMyZlVjQjBMVENhT3VROGNxOWYwcnMw?=
 =?utf-8?B?bjcwTUxmK0hod2xlWmRMSzJJd2poR0NKcmtDbXBabys4QlNsc1JLM212d2E4?=
 =?utf-8?B?NDhCOUh1UWdSdE9KbldGZFhSME42WnFNU1pJUG16M3Bab1EvSTY2TDJvS2xr?=
 =?utf-8?B?ZUtwWVpyYUZQTDNQcXVWSi82aWdxaldjVUVuVVpyMHIyWTJrL2hETklWTTBJ?=
 =?utf-8?B?MTJGRXprN3RWeUE2STdaSC9ycUg0VjQvdVFNWHUrenZqb1Zid01Fdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4f4a20-008a-4639-e83e-08def2778d57
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 22:27:22.1864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKMLS0ibkP0wzThm+8I+JIkT6wuoUjS9f+gxv9EuYkLrM4/yymb/OPI1nH0ovMk/Y8rJ/V3HYmt1hWFOuD6+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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


On 2026-08-04 05:52, Donet Tom wrote:
> This series fixes topology device creation and proximity domain mappings in
> AMDKFD when a system does not provide a CRAT table and the driver generates a
> Virtual CRAT (VCRAT).
>
> The current implementation assumes that CPU NUMA node IDs are contiguous and
> that every NUMA node contains CPUs. During VCRAT generation, CPU topology
> entries and proximity domains are created only for NUMA nodes that have CPUs.
> GPU proximity domains are then allocated immediately after the CPU proximity
> domains, and the GPU I/O link (proximity_domain_to) is initialized using the
> NUMA node ID to which the GPU is attached, implicitly assuming that NUMA node
> IDs and proximity domains have a one-to-one mapping.
>
> These assumptions break on systems with:
>
> Sparse (non-contiguous) NUMA node IDs
> CPU-less NUMA nodes
> CPU-less and memory-less NUMA nodes
>
> For example:
>
> available: 3 nodes (0,2-3)
>
> node 0: CPUs present
> node 2: CPU-less
> node 3: CPU-less
>
> In this case, the driver creates a CPU topology device only for node 0 and
> assigns a single CPU proximity domain (0). However, the GPU VCRAT still
> references the NUMA node ID to which the GPU is attached (for example, node 3)
> in the proximity_domain_to field. Since no corresponding CPU proximity domain
> exists for node 3, the parser cannot find a matching proximity domain during
> VCRAT parsing, causing topology initialization to fail.

Hi Tom,

Thank you for the explanation and the patch series. I may have some gaps 
in my understanding that I would like to clarify. In my mind, I was 
using "proximity domain" and "NUMA node" interchangeably. You're 
demonstrating that they are not the same thing. Is that just a different 
way of labeling the same thing, or are NUMA nodes and proximity domains 
fundamentally different concepts.

Your code in patch 5 (kfd_proximity_domain_to_numa_node and 
kfd_numa_node_to_proximity_domain) seems to imply that there is, in 
fact, a 1:1 mapping, as it assumes that there is a unique translation in 
both directions. Am I missing something?

If they are just different numbering systems, do we really need to keep 
track of both proximity domains and NUMA nodes in the KFD topology? Or 
would it be sufficient to only track NUMA nodes, if that's what we 
really care about in the uAPI (KFD sysfs)?

Thanks,
   Felix


>
> The failure is observed as:
>
> amdgpu: Virtual CRAT table created for GPU
> amdgpu: Error parsing VCRAT
> kfd: amdgpu: Error adding device to topology
> kfd: amdgpu: Error initializing KFD node
>
>
> Since every online NUMA node is a valid topology object and can contain
> CPUs, memory, I/O links, or any combination of these, topology devices
> and proximity domains should be created for every online NUMA node
> rather than only for NUMA nodes that contain CPUs.
>
> To address this, this series introduces a new VCRAT subtype that
> records the mapping between the NUMA node ID and the generated VCRAT
> proximity domain. When topology devices are created, this information
> is stored in the corresponding topology device, allowing the driver to
> translate a NUMA node ID into its associated proximity domain whenever
> required.
>
> Returning to the previous example, the system contains three online
> NUMA nodes, so three CPU topology devices and three proximity domains
> are created, even though only one NUMA node contains CPUs. The NUMA
> node ID is stored in each topology device together with its generated
> proximity domain.
>
> Later, when the GPU VCRAT is generated, the driver only knows the NUMA
> node ID to which the GPU is attached (for example, node 3). Instead of
> assuming that the NUMA node ID is equal to the proximity domain, the
> driver walks the existing topology devices to locate the corresponding
> NUMA node and retrieves its generated proximity domain. In this
> example, NUMA node 3 maps to proximity domain 2, so
> proximity_domain_to is populated with the correct value.
>
> Since the GPU I/O link now references a valid proximity domain, VCRAT
> parsing completes successfully and topology initialization proceeds
> without errors on systems with sparse NUMA node IDs, CPU-less NUMA
> nodes, and CPU-less/memory-less NUMA nodes.
>
> This series consists of the following patches:
>
> Patch 1 removes an unused argument from
> kfd_create_crat_image_virtual() as a preparatory cleanup.
>
> Patch 2 introduces a new VCRAT NUMA affinity subtype that stores the
> NUMA node ID and its corresponding proximity domain.
>
> Patch 3 populates the NUMA affinity entries during VCRAT generation
> for every online NUMA node.
>
> Patch 4 parses the NUMA affinity entries from the VCRAT and stores the
> NUMA node ID and proximity domain in the corresponding topology
> device.
>
> Patch 5 fixes GPU VCRAT proximity domain mappings by translating the
> GPU's NUMA node ID to the corresponding CPU proximity domain before
> programming proximity_domain_to.
>
> Patch 6 creates proximity domains and VCRAT entries for all online
> NUMA nodes, including CPU-less and memory-less nodes.
>
> Patch 7 adds a numa_node sysfs attribute for CPU and GPU topology
> devices, exposing the associated NUMA node through the topology sysfs
> interface.
>
> Please note that the changes in this series are on a best effort basis from our
> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
> HW & SW stack) to kindly help with the review and provide feedback / comments on
> these patches
>
> Donet Tom (7):
>    drm/amdgpu: Remove unused argument from kfd_create_crat_image_virtual
>    drm/amdgpu: Add VCRAT NUMA affinity entry
>    drm/amdgpu: Populate NUMA affinity entries in VCRAT
>    drm/amdgpu: Parse NUMA affinity entries from VCRAT
>    drm/amdgpu: Fix VCRAT proximity domain mappings for GPU nodes
>    drm/amdgpu: Create proximity domains and VCRAT entries for CPU-less
>      and memory-less NUMA nodes
>    drm/amdgpu: Add numa_node in cpu/gpu topology device sysfs entry
>
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 152 +++++++++++++++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  19 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  49 +++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   4 +
>   4 files changed, 168 insertions(+), 56 deletions(-)
>
