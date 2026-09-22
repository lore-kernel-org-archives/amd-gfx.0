Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95502C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 22:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D012410E4C7;
	Tue, 22 Sep 2026 22:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FMjQkJyc";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3CF10E4C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 22:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvh+efgVzNqjmAS2YfKVUbjZV01lFoUUTT0dkXc3qndQkfxuy31QvHKfLdbnwSCN5Wf7to97AJtSjIQrDp70yqbgZhM9oML259iznUfeTaQiR9v/57qmw1RB4VHiN34a0PFcHrWfIrSYgZ8keeCiMBj2gcrjkolpRFoI9c1EwGniwADYS4sEMryJmgD8No0fxTWup0c9S4iq3i99xDISP3i13jJsFn/OZMjIUMVZXiCwSJiBtMhHcx7DW5wAgh3K8sbHYnYR+PD97tYHcRsHx0XQ+Iz+QR7m2cKhygqvby8KQ9VBUeV64xvv44ZwAkvlk47nGZcCxU64Gfb2xUK0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaj852rp5g+lLWx1Ne+x/sVPTdKGTZ2gDPrSraOmLaQ=;
 b=putB88ZNk6l+cXZCtWIFmQztry4VzvgQMtT6da9xTKOSyv8Xbo9uxrm8Bq6hCp0o4DmC9lQT4BcII+JXwEpuQrno87eD/quIonvTIblACKMHSfXk8Q9o1twfJZHmTHzpn6SXOcQHMpgRc1QDtFEgksE4fLeJpH5+W+QUI12GgpuC/myAXNRgzBx7K2LAWpSjxQ0Se/gaoaf7g4YJaaRTKk/N1QWuBpIVJlqIeRdqlHrYJptu3LMx0dzAVvcWEBb3Pa6Ikei0rz8EEYg92oYJl9gQVLEZD+YbWLkiVv9CQxeGvhBblDVsHt4qlHv2y5Wy4I9AhqAkNkXFP9pylkOj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaj852rp5g+lLWx1Ne+x/sVPTdKGTZ2gDPrSraOmLaQ=;
 b=FMjQkJycnamTO8srb+iZENRq+IDNJsFEfbK8kpNmfFIEHG7Xb2nNREUMlZV/VbeShG5St6GY+E/JkQ8dlnfR1rxC2OdhnlEzF/bHwhghZX0YxL69O51rZhEEs+0sj7u8aICJ29VDrFoq5aghhqd5Y25f9v25zfH9yRHp9T9W57U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM4PR12MB6613.namprd12.prod.outlook.com
 (2603:10b6:8:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 22:49:22 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 22:49:22 +0000
Message-ID: <00a10239-1e09-470b-8970-db00814af486@amd.com>
Date: Tue, 22 Sep 2026 18:49:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/amdgpu: Fix topology device creation and
 proximity domain mappings for sparse and CPU-less NUMA systems
To: Dhruv Bhogaonkar <dhruv.b@linux.ibm.com>,
 Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <cover.1785833981.git.donettom@linux.ibm.com>
 <16887553-76eb-4af9-8769-f77f4fb9fb68@amd.com>
 <b492ee69-86fa-47a2-aecc-e470568d7204@linux.ibm.com>
 <2bde809f-d2d9-4b94-88e3-f8e2ae2cc7b0@amd.com>
 <6b7e68a3-8308-496d-a183-f23be992448e@linux.ibm.com>
 <a7404568-5d4b-4588-950c-28a5225f77d3@amd.com>
 <8e5fccd6-6907-498c-b1a9-39fe15525ee2@linux.ibm.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <8e5fccd6-6907-498c-b1a9-39fe15525ee2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0194.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::19) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: e96a677f-4c19-4343-4586-08df18fbbe44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: xEZBRYHcnXi9Un+Ecg7FuhSYbRylPPlXVqYSVps+ZqBgKhsSzuYc7lXG3ixUI8xGcP+ITy7nylSv5Mb/QN3R89w+cLm6KYwnWDIpi3Js6vXG4l8vIDwwVptvYmeUlt70jM5ZfXL6QntO9X00Rw/gZrkmPBOwT2Vt+Q8p2F0iaa1QrzlfvMzwMDHEYKBYCpSpjFRm6Jw8c6lOZx2XmiXx2RuTh3grlKFPkM0kg3oNcAuZMLzeO7cYK9F6jMCzYrYZqIBkizS+QtzJWs3Qz1Yp2RvAsL/R4TZoD67H8mF99of2yA2P/2V3RRmRnd+ywf/d/qs8MYCLfwOjZk/zW46dS/UMivZZ+na31b4/BzkR4Hj5wPIsBzUQ05iVlUCjehFqB0MKXQfloWdJN0IZs9OAJcL7VGsmjnPGNLGqJ8qpL/LXalTSBi95vCcCWp07erVCa3cNs4iZB4wXluLG4RTkwmjLX32S7HcaGHxqkzjC1UVu9p4aWFNbkq+uteL4VsZ1nOVniYEgwDV0WyfQGu0KHRYRtl4S0e10lBiAfjBMgeRe9iZcOoUw/fgoB1DgNAgfMsPY2RnBB6isPR3Euafq9zdsAs8KFG0jdR3S7IoZgVGY3FIMIfrCUAFkuDUq9Opm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjZxY3k5L3Uwd2FCZk94YTNjNDFaYVNWUHM5dGhxTTIvUGZxakxCMjB4ZXJt?=
 =?utf-8?B?M2tqbmFmT2lUQWh5eTJwdzhXQ2NhNURqWW5BWGxMOVlpU3ZIeWNwY2FNU0lo?=
 =?utf-8?B?SnFOamZnTWtNMDFPVzBPNitrSGIyc2RhN3Y4aytoTjVJU1J3anBLd1YzNFJ0?=
 =?utf-8?B?ZnNzbDFVZjNDUG03SGgwZHRDYzh4bmlvYUYyTzllZDlLZFdTYUlhZjVYZzJ3?=
 =?utf-8?B?VjNuZGErM0thZFZOZFBqTzZXTnhMeUVpaGpBT0RCRTdVWHQ1TjhUeWFzb2Yw?=
 =?utf-8?B?R0FMZ3M5UE5TMHJNUUZLL2p2UVZUT1kxeVM5Z2NOVTNjRzJxbkd2R3hrZ3Y3?=
 =?utf-8?B?THhOTFY2Rk90dkVrVllpOVh3YUNsbFJnWTd1eElxUndZajlJOXdmcTJ6Yis4?=
 =?utf-8?B?dXdrdlMrZFZKOE93YS83VWFVM1NGZmtMSUpyOFE0TE1uYm8xRGhqWVJXdnRi?=
 =?utf-8?B?OUJJaTFBZnVEb09UTmJkTzdQNitpeU85dHExamlMNjJzdWovaE1OSlFrMXRG?=
 =?utf-8?B?K3JlSXJuR0trMzNZRm1rQkxtSVdTN0JNRU5LWG9mMlhyRHQ3SVdHN3dPMlcv?=
 =?utf-8?B?NjJTSUo3dGxzekpablZFU0ZvWkRzWmxhWXV6a3I0bWtDNUhyWG9nYUgyZWpz?=
 =?utf-8?B?cVkzYUwzQmU1UytUVjFpSWRrUGFScm9nV2N2dkJYeWgwSlhBaTVOWHI0K3Vw?=
 =?utf-8?B?YVZhVmtFQkYrMzNtczB1WUthVlMzSHhxWHNzOXNrM3h6K3doU3VUZURYRC9y?=
 =?utf-8?B?bnBzdEN5NngrQy9YWXYrWXVrVEY5QXFueVZqNzVkYTNWRTNhWURyQ2JSYU8z?=
 =?utf-8?B?dWEyamphV1B2SnpTUEZpeGdYZTRRODZVUUVsa1IxczNhVzhqRUYvcDU4cmFK?=
 =?utf-8?B?Z0U3cW1hemlZR05aRnc2bkF1REVTSi9GVFpVbUVtTjdXQ1p6Q2JwU3BuckMz?=
 =?utf-8?B?UHQ4NXFVMDNGVHU5VUtnWi9QVjE5cmRVTzRSdkF1ZkV4NXhQeE1TUk1ISXVT?=
 =?utf-8?B?STRGbFZ4MXJ2cmtHUDZEN3VEamZUTGxONlprRkpIWWVUbWdxZ0dkSzR3Y1kx?=
 =?utf-8?B?Zk9tb2FIQmhTcXBoNnROY0EvbkNoTEV6QlNkdytvbnNrL3FrMWpTQkc3YVh1?=
 =?utf-8?B?cVcwdzkzV0gyTW91Q01JQUNISTQrVS9zd250QUR1eTNQT3RXYWR1VzJSZVVD?=
 =?utf-8?B?QjYyTGVXYnpKUEpKVk5NTXJJM01vKzRDTHFOYzNkeTBJMFdwajZtZXZwV2J6?=
 =?utf-8?B?K0VVSFUvN0dJbFVnbVMyUFordTZaaFNKRGJ0dzM1Z09RZ1laZG83OTZIZzZ1?=
 =?utf-8?B?SmlnRnRuS3d6eE4xeWpDNVBWMm9IcFpyRnhETklTbk5uMXk2c1llRG90M2l2?=
 =?utf-8?B?SGw4bjcyWDZVRUIveStSM1hmcFFmTVVjbytJc1MrNERwOEZXK0hVZ0xrT2gr?=
 =?utf-8?B?YVJWbnJYcFlHL3VtKzh0UnZFVHkvc1BVMXUrUmgrMXNaWDVPWE1pc1dpNUZo?=
 =?utf-8?B?S0ZWOGd4UCtMdllGd0N6UUtUVnRLRHgvai94YnlxRDBUSkorbGNEUDNQV0tN?=
 =?utf-8?B?QjBjNS8yT05HcXZHUnY5WnRZMGdGOWRlTThaZ0ZFZnZTZU1FaERoNzVuQnpm?=
 =?utf-8?B?VXhaak5yeVB5NUZYUDVNY1pRQ1pRWnhlekphU21nZks0b0h1bE91bDEzUHk1?=
 =?utf-8?B?SFBpV3phN1VlUkVDWTNKREFxbGdmdzYrNWw2cHdYeS9pTFFsYUc0Vk5sS1gw?=
 =?utf-8?B?WVFUTXR5RURnMnFxellwUjJ3NGJhSGs5RjVncXNhT01nMGs2ckpwQ01zbkpt?=
 =?utf-8?B?VFNLQnczakt1TU5lTFZKN3lJWmZueUhaNnZueDdKZGNuSWZLUEF6SXZqSTB6?=
 =?utf-8?B?cVk4NU9Fczl2Tml2SnpQbVZhK05DNkhxYkxvM0R6WWlBVE1xYWwzc0VpczF1?=
 =?utf-8?B?MFp6M0tyR3YxZDlScWVsUm5FVUlzSUEybHl5b0tFYWR4Q1Vob09UQ2R3dzJJ?=
 =?utf-8?B?NnhGOVM3RlROaEtwVlN5T3dCWEM5V3JjUEZNRGpFcDJ6aEZRdk1neERha1RY?=
 =?utf-8?B?UjFEbFI2d3BPNFk1K3lrSWxOQzR3NDVTaUlsYmtVbkowbDZraTM1dzMzVlRz?=
 =?utf-8?B?SEp4dEYzNld4ang2RkpRNjZJU3NndWk3M3JHdDFQVzl6dFRRV0dJTDV3SHpu?=
 =?utf-8?B?dk02NU9hOE9mVnVyVVl3OFFLOFo3cVErdzQyK3MvaEszQkM2aGltNEtYZTlF?=
 =?utf-8?B?WEFCNWJva3dYbDZUeEV4a21URUlGL1ViZ1EwM1ZUakV6SlV6R0k5WkNHSmwv?=
 =?utf-8?B?VElKQ3NucHlIZ05iTTZIc1pxMi9SNEpRZXZxcUtvUmdPMG5tSVRtUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96a677f-4c19-4343-4586-08df18fbbe44
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 22:49:22.1745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PE6l40yb/LSO4HUMFiYMV/e4PND7KGZnEswr2Z/szEdkI4SyucEfyknC3ftjBhdxCgLRehyMlFZTvMsAx8iPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
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

On 2026-09-22 12:59, Dhruv Bhogaonkar wrote:
>
> On 21/09/26 22:35, Kuehling, Felix wrote:
>> On 2026-09-21 00:56, Dhruv Bhogaonkar wrote:
>>> On 05/08/26 21:46, Kuehling, Felix wrote:
>>>>
>>>> On 2026-08-05 03:09, Donet Tom wrote:
>>>>>
>>>>> On 8/5/26 3:57 AM, Felix Kuehling wrote:
>>>>>>
>>>>>> On 2026-08-04 05:52, Donet Tom wrote:
>>>>>>> This series fixes topology device creation and proximity domain
>>>>>>> mappings in
>>>>>>> AMDKFD when a system does not provide a CRAT table and the driver
>>>>>>> generates a
>>>>>>> Virtual CRAT (VCRAT).
>>>>>>>
>>>>>>> The current implementation assumes that CPU NUMA node IDs are
>>>>>>> contiguous and
>>>>>>> that every NUMA node contains CPUs. During VCRAT generation, CPU
>>>>>>> topology
>>>>>>> entries and proximity domains are created only for NUMA nodes that
>>>>>>> have CPUs.
>>>>>>> GPU proximity domains are then allocated immediately after the CPU
>>>>>>> proximity
>>>>>>> domains, and the GPU I/O link (proximity_domain_to) is initialized
>>>>>>> using the
>>>>>>> NUMA node ID to which the GPU is attached, implicitly assuming that
>>>>>>> NUMA node
>>>>>>> IDs and proximity domains have a one-to-one mapping.
>>>>>>>
>>>>>>> These assumptions break on systems with:
>>>>>>>
>>>>>>> Sparse (non-contiguous) NUMA node IDs
>>>>>>> CPU-less NUMA nodes
>>>>>>> CPU-less and memory-less NUMA nodes
>>>>>>>
>>>>>>> For example:
>>>>>>>
>>>>>>> available: 3 nodes (0,2-3)
>>>>>>>
>>>>>>> node 0: CPUs present
>>>>>>> node 2: CPU-less
>>>>>>> node 3: CPU-less
>>>>>>>
>>>>>>> In this case, the driver creates a CPU topology device only for
>>>>>>> node 0 and
>>>>>>> assigns a single CPU proximity domain (0). However, the GPU VCRAT
>>>>>>> still
>>>>>>> references the NUMA node ID to which the GPU is attached (for
>>>>>>> example, node 3)
>>>>>>> in the proximity_domain_to field. Since no corresponding CPU
>>>>>>> proximity domain
>>>>>>> exists for node 3, the parser cannot find a matching proximity
>>>>>>> domain during
>>>>>>> VCRAT parsing, causing topology initialization to fail.
>>>>>>
>>>>>> Hi Tom,
>>>>>
>>>>>
>>>>> Hi Felix,
>>>>>
>>>>>
>>>>>>
>>>>>> Thank you for the explanation and the patch series. I may have some
>>>>>> gaps in my understanding that I would like to clarify. In my mind, I
>>>>>> was using "proximity domain" and "NUMA node" interchangeably. You're
>>>>>> demonstrating that they are not the same thing. Is that just a
>>>>>> different way of labeling the same thing, or are NUMA nodes and
>>>>>> proximity domains fundamentally different concepts.
>>>>>>
>>>>>> Your code in patch 5 (kfd_proximity_domain_to_numa_node and
>>>>>> kfd_numa_node_to_proximity_domain) seems to imply that there is, in
>>>>>> fact, a 1:1 mapping, as it assumes that there is a unique
>>>>>> translation in both directions. Am I missing something?
>>>>>
>>>>>
>>>>>
>>>>> Thanks for the comment.
>>>>>
>>>>> IIUC, NUMA node IDs and proximity domains are different numbering
>>>>> schemes. We have proximity domains for both CPU and GPU devices. CPU
>>>>> proximity domains start from 0, and GPU proximity domains start after
>>>>> the last CPU proximity domain.
>>>>>
>>>>> If the NUMA node IDs are contiguous, the CPU proximity domains happen
>>>>> to match the NUMA node IDs. However, if the NUMA node IDs are
>>>>> discontiguous, the CPU proximity domains and NUMA node IDs no longer
>>>>> have a one-to-one mapping.
>>>>>
>>>>>>
>>>>>> If they are just different numbering systems, do we really need to
>>>>>> keep track of both proximity domains and NUMA nodes in the KFD
>>>>>> topology? Or would it be sufficient to only track NUMA nodes, if
>>>>>> that's what we really care about in the uAPI (KFD sysfs)?
>>>>>
>>>>>
>>>>>
>>>>> Thanks for the suggestion. I also think we don't need to keep track
>>>>> of both the proximity domains and the NUMA node IDs in KFD. Do you
>>>>> think the approach below would be reasonable?
>>>>>
>>>>> Just to make sure I understand correctly, for CPU devices the
>>>>> proximity domain will be the same as the NUMA node ID, and the GPU
>>>>> proximity domains will start after the last CPU proximity domain.
>>>>>
>>>>> In that case, the CPU proximity domains and NUMA node IDs will always
>>>>> have a one-to-one mapping, and the GPU proximity domains will follow
>>>>> after them.
>>>>>
>>>>> For example, if a system has three NUMA nodes and two GPUs:
>>>>>
>>>>> NUMA node IDs:            0   2   3
>>>>> CPU proximity domains:    0   2   3
>>>>> GPU proximity domains:    4   5
>>>>>
>>>>> Would it be okay to proceed with this approach?
>>>>
>>>> Yes, this looks good to me.
>>>
>>>
>>> Hi Felix,
>>>
>>> I have been looking into this issue along with Donet.
>>>
>>> From my understanding, there are three related but distinct concepts
>>> involved here:
>>>
>>> * NUMA node: A system can have sparse NUMA node IDs. For example,
>>>   online nodes can be 0, 2, and 3, with node 1 absent.
>>>
>>> * Proximity domain: The proximity domain is the identifier
>>>   associated with a KFD topology device. In the current implementation,
>>>   proximity domains for CPU topology devices are assigned using a
>>>   sequential counter, and GPU proximity domains are allocated after the
>>>   CPU proximity domains.
>>>
>>> * KFD sysfs topology node: KFD exposes each topology device through
>>>   a node under its sysfs topology interface. Userspace reads these 
>>> sysfs
>>>   nodes to discover the CPU/GPU topology and their relationships. In 
>>> the
>>>   current implementation, the sysfs node numbering corresponds to the
>>>   proximity domain numbering.
>>>
>>> IIUC, the proximity-domain numbering and KFD sysfs topology-node
>>> numbering are expected to correspond, while the Linux NUMA node ID can
>>> be a separate identifier that is mapped to the corresponding topology
>>> or proximity domain.
>>>
>>> As discussed in the thread, we implemented the
>>> 'NUMA node ==Proximity Domain' approach. However, after implementing
>>> this for sparse nodes, we found that the userspace libraries using the
>>> KFD sysfs nodes have an assumption that the topology devices are
>>> contiguous.
>>>
>>> With this approach, discontiguous NUMA nodes result in discontiguous
>>> proximity-domain and sysfs node numbers. This would break userspace
>>> libraries that assume the topology devices are contiguous.
>>>
>>> To support this approach, we would need to make corresponding changes
>>> in the userspace libraries, which would break applications using the
>>> existing userspace and introduce backward-compatibility concerns.
>>>
>>> With this in mind, we think the current RFC v1 approach would be the
>>> better way to proceed, keeping the NUMA node IDs separate from the
>>> proximity-domain/sysfs numbering.
>>
>> I'm not sure about this. We have code in user mode that uses the KFD
>> proximity domains as CPU NUMA nodes, e.g. in calls to mbind. E.g.
>> https://github.com/ROCm/rocm-systems/blob/f437a7135fa67b96b48da4baeb72d5f75c406052/projects/rocr-runtime/libhsakmt/src/fmm.c#L2058 
>>
>>
>> So if you change the KFD CPU proximity domain numbers to something
>> contiguous, you're probably breaking user mode either way.
>
>
> Hi Felix,
>
> Thanks for pointing this out.
>
> I think the approach you originally suggested seems to be the better one:
> keeping the CPU proximity domain numbers aligned with the NUMA node IDs,
> including sparse NUMA node IDs.
>
> This will require corresponding userspace changes to support
> non-contiguous NUMA node IDs, but I don't expect this to break any
> existing applications or introduce backward compatibility issues. For
> systems with contiguous NUMA node IDs, the existing behavior will work
> as is, while systems with non-contiguous NUMA node IDs will work after
> the userspace changes.
>
> For example, one of the areas that will need to be updated is here:
>
> https://github.com/ROCm/rocm-systems/blob/2d743306cb341b5973cb0d6af7b549569d127724/ 
>
> projects/rocr-runtime/libhsakmt/src/topology.c#L831

The code here is already designed to handle sysfs nodes that are not 
accessible because GPUs are not available in the process' cgroup. Maybe 
we need additional fixes here to handle the case where a directory is 
completely missing in sysfs. The biggest problem is probably, that user 
mode tries to remap the node-IDs into a contiguous range here: 
https://github.com/ROCm/rocm-systems/blob/2d743306cb341b5973cb0d6af7b549569d127724/projects/rocr-runtime/libhsakmt/src/topology.c#L836. 
We'd need to avoid that for CPU nodes so that we preserve the identity 
mapping from node IDs to NUMA node IDs. Maybe we can create dummy nodes 
with no CPU cores and no memory as place-holders.


>
>
> If you have any pointers or suggestions regarding this approach,
> especially for the userspace changes, I would really appreciate your
> feedback.
>
>
>
>>
>>
>>
>>
>> Can you point out what specific problems you run into with
>> non-contiguous NUMA nodes topologies?
>
>
> The issue we see on a system with discontiguous NUMA nodes is that the
> GPU VCRAT parsing fails when we load the GPU driver, resulting in the
> following errors in dmesg:
>
>     amdgpu: Virtual CRAT table created for GPU
>     amdgpu: Error parsing VCRAT
>     kfd: amdgpu: Error adding device to topology
>     kfd: amdgpu: Error initializing KFD node
>
> On our system, we have 3 NUMA nodes: 0, 2, and 3, with 2 GPUs attached
> to NUMA node 3.

OK, that's all stuff that would need to be addressed with kernel mode 
driver patches. I'm hoping it would be a simplified version of the 
patches that Donet already proposed.

Regards,
   Felix


>
> With the current upstream implementation, CPU proximity domains are
> assigned sequentially. Thus, NUMA nodes 0, 2, and 3 get CPU proximity
> domains 0, 1, and 2 respectively. The two GPUs then get proximity
> domains 3 and 4.
>
> However, when generating the GPU VCRAT, `proximity_domain_to` is
> populated directly with the NUMA node ID. Since both GPUs are attached
> to NUMA node 3, the VCRAT contains:
>
>     GPU0 -> proximity_domain_to = 3
>     GPU1 -> proximity_domain_to = 3
>
> https://elixir.bootlin.com/linux/v7.1/source/drivers/gpu/drm/amd/amdkfd/kfd_crat.c#L2175 
>
>
> Here, the CPU proximity domain corresponding to NUMA node 3 is actually
> 2, while proximity domain 3 belongs to GPU0.
>
> During VCRAT parsing, the I/O link parser looks up this `id_to`
> proximity domain, which is 3, and returns `-ENODEV` because there is no
> CPU topology device with proximity domain 3:
>
> https://elixir.bootlin.com/linux/v7.1/source/drivers/gpu/drm/amd/amdkfd/kfd_crat.c#L1284 
>
>
> Thus, the GPU I/O link is referencing the NUMA node ID as if it were
> the CPU proximity domain, which causes the VCRAT parsing to fail.
>
> Since the parsing fails, the driver does not get loaded.
>
> Thanks,
> Dhruv B
>>
>>
>>
>>
>>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Would you agree with this approach? If so, I can rebase the RFC v1
>>> series onto the latest kernel and post a new version for review.
>>>
>>> Thanks,
>>> Dhruv B
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> I think this approach should also resolve the driver loading issue.
>>>>>
>>>>>
>>>>> Thanks
>>>>> Donet Tom
>>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>   Felix
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> The failure is observed as:
>>>>>>>
>>>>>>> amdgpu: Virtual CRAT table created for GPU
>>>>>>> amdgpu: Error parsing VCRAT
>>>>>>> kfd: amdgpu: Error adding device to topology
>>>>>>> kfd: amdgpu: Error initializing KFD node
>>>>>>>
>>>>>>>
>>>>>>> Since every online NUMA node is a valid topology object and can
>>>>>>> contain
>>>>>>> CPUs, memory, I/O links, or any combination of these, topology
>>>>>>> devices
>>>>>>> and proximity domains should be created for every online NUMA node
>>>>>>> rather than only for NUMA nodes that contain CPUs.
>>>>>>>
>>>>>>> To address this, this series introduces a new VCRAT subtype that
>>>>>>> records the mapping between the NUMA node ID and the generated 
>>>>>>> VCRAT
>>>>>>> proximity domain. When topology devices are created, this
>>>>>>> information
>>>>>>> is stored in the corresponding topology device, allowing the
>>>>>>> driver to
>>>>>>> translate a NUMA node ID into its associated proximity domain
>>>>>>> whenever
>>>>>>> required.
>>>>>>>
>>>>>>> Returning to the previous example, the system contains three online
>>>>>>> NUMA nodes, so three CPU topology devices and three proximity
>>>>>>> domains
>>>>>>> are created, even though only one NUMA node contains CPUs. The NUMA
>>>>>>> node ID is stored in each topology device together with its
>>>>>>> generated
>>>>>>> proximity domain.
>>>>>>>
>>>>>>> Later, when the GPU VCRAT is generated, the driver only knows the
>>>>>>> NUMA
>>>>>>> node ID to which the GPU is attached (for example, node 3).
>>>>>>> Instead of
>>>>>>> assuming that the NUMA node ID is equal to the proximity domain, 
>>>>>>> the
>>>>>>> driver walks the existing topology devices to locate the
>>>>>>> corresponding
>>>>>>> NUMA node and retrieves its generated proximity domain. In this
>>>>>>> example, NUMA node 3 maps to proximity domain 2, so
>>>>>>> proximity_domain_to is populated with the correct value.
>>>>>>>
>>>>>>> Since the GPU I/O link now references a valid proximity domain,
>>>>>>> VCRAT
>>>>>>> parsing completes successfully and topology initialization proceeds
>>>>>>> without errors on systems with sparse NUMA node IDs, CPU-less NUMA
>>>>>>> nodes, and CPU-less/memory-less NUMA nodes.
>>>>>>>
>>>>>>> This series consists of the following patches:
>>>>>>>
>>>>>>> Patch 1 removes an unused argument from
>>>>>>> kfd_create_crat_image_virtual() as a preparatory cleanup.
>>>>>>>
>>>>>>> Patch 2 introduces a new VCRAT NUMA affinity subtype that stores 
>>>>>>> the
>>>>>>> NUMA node ID and its corresponding proximity domain.
>>>>>>>
>>>>>>> Patch 3 populates the NUMA affinity entries during VCRAT generation
>>>>>>> for every online NUMA node.
>>>>>>>
>>>>>>> Patch 4 parses the NUMA affinity entries from the VCRAT and
>>>>>>> stores the
>>>>>>> NUMA node ID and proximity domain in the corresponding topology
>>>>>>> device.
>>>>>>>
>>>>>>> Patch 5 fixes GPU VCRAT proximity domain mappings by translating 
>>>>>>> the
>>>>>>> GPU's NUMA node ID to the corresponding CPU proximity domain before
>>>>>>> programming proximity_domain_to.
>>>>>>>
>>>>>>> Patch 6 creates proximity domains and VCRAT entries for all online
>>>>>>> NUMA nodes, including CPU-less and memory-less nodes.
>>>>>>>
>>>>>>> Patch 7 adds a numa_node sysfs attribute for CPU and GPU topology
>>>>>>> devices, exposing the associated NUMA node through the topology
>>>>>>> sysfs
>>>>>>> interface.
>>>>>>>
>>>>>>> Please note that the changes in this series are on a best effort
>>>>>>> basis from our
>>>>>>> end. Therefore, requesting the amd-gfx community (who have deeper
>>>>>>> knowledge of the
>>>>>>> HW & SW stack) to kindly help with the review and provide feedback
>>>>>>> / comments on
>>>>>>> these patches
>>>>>>>
>>>>>>> Donet Tom (7):
>>>>>>>    drm/amdgpu: Remove unused argument from
>>>>>>> kfd_create_crat_image_virtual
>>>>>>>    drm/amdgpu: Add VCRAT NUMA affinity entry
>>>>>>>    drm/amdgpu: Populate NUMA affinity entries in VCRAT
>>>>>>>    drm/amdgpu: Parse NUMA affinity entries from VCRAT
>>>>>>>    drm/amdgpu: Fix VCRAT proximity domain mappings for GPU nodes
>>>>>>>    drm/amdgpu: Create proximity domains and VCRAT entries for
>>>>>>> CPU-less
>>>>>>>      and memory-less NUMA nodes
>>>>>>>    drm/amdgpu: Add numa_node in cpu/gpu topology device sysfs entry
>>>>>>>
>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 152
>>>>>>> +++++++++++++++-------
>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  19 ++-
>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  49 +++++--
>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   4 +
>>>>>>>   4 files changed, 168 insertions(+), 56 deletions(-)
>>>>>>>
