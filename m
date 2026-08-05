Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B58AC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 16:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F2A10E213;
	Wed,  5 Aug 2026 16:16:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZHos3n8u";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB0C10E208
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 16:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKL8fQWrIzuJvSfs5N1r1FrfwBQomWAfqOkhCSKnDdB+ddqFFdg64HNWGUZG+6XFYn7lUd5GLJg0KUtkIJko/eW/eZ5tljSy5mrz3ObU/nOpw6RqilVDvzwLRfmZDLVzYHTNU1NBXUTjJeOaFVof9lFXeepXlonWN1srhDUCEO7lcnuYAQ5Evo84WpkFu6A8tvuivQqzHKVRsRCeNvMmpvyvO1+NhbI9uvMOizD4/+j3cojvv2F4V/+yChbkRmS1Hi8DlZx+DOKHqCUnSoW9hTAD6b4un8JqGxLnXc/xEHQGzOBidL+vPvz9VGBgHz1mN1InPjCV0V3A1hACSvsRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzMvfgJWzx36W/TccZ5BlV7thi/ssTwHqUEtEejVYfI=;
 b=oyIRMeMIjLsDBO+vPIQjXIjbBBwA6hPx10mD5gT/MCB2e0lqNFubHVqRNtfhUg3oVnfEd4tkvl6I5LZ+sxn8f/ErA/fBucrJtROEydbL9ezDQLh+6uT4gf7SFJSBr8ZekNFkdeVQrsPDil0a4DFAdj/shHCPWnd0qyE5wJoE1tJGSOOp0oF8CTUypSWwja0+BAwUjh52sa4CXjFp9LIC7DjlKusjCJcx3JlW4lBUlDV6QgOSX6vvjctfocUw//qrRVM+I63ae2nWboRBiPvBHEsi6ZhQjCKHacrEFZssJvZ5pqmPIr9EMpOY9kNS8cAm2Xl3v80GaiQDqSlqRdlEuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzMvfgJWzx36W/TccZ5BlV7thi/ssTwHqUEtEejVYfI=;
 b=ZHos3n8uGJW6Croaohrs2VIWgTQhECcD/tBsOMROkQjVCSCm/llSTXVyCfpzqMWDRwzNfTguzeIkqoLVVpH4SVXCMWHv5QfEmTizfs2CE2bk3KFyyyBwy0CucCtEbsKYSrVUmDKlK4tE2K0E7ZaJm5qSEn9nRJQWGGTdB2vgB6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by DS0PR12MB6536.namprd12.prod.outlook.com
 (2603:10b6:8:d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:16:08 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 16:16:08 +0000
Message-ID: <2bde809f-d2d9-4b94-88e3-f8e2ae2cc7b0@amd.com>
Date: Wed, 5 Aug 2026 12:16:11 -0400
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
 <16887553-76eb-4af9-8769-f77f4fb9fb68@amd.com>
 <b492ee69-86fa-47a2-aecc-e470568d7204@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <b492ee69-86fa-47a2-aecc-e470568d7204@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::20) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b935353-0480-4f84-0233-08def30cdba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|4143699003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /mNWdKrnA3FNe+PjWECMeCGXseM+7yLuX04KBp7+bKmr3Xe0LVsGaS8K0X/FUaTgMQCuZjoAEgm4rBqSPi7+5ExqbB4rCTbQRKsF12nvhbVbxXWd9+UtVh2v4NjQ12Hq5LPgYzIniBBxZJpDDgYZV+Bvdim5vjtiOxTU5vsmQOHwK53awUvYFs41uxBAD4eJlZIg2K5J4FzkXsGwMl6uxHktWQEEBWp9cySAVLDx7pq04YCbB+wo2v1LDN0pEpyKvLCjO2K2eADoEq4UflsuN8StqH1yX8OxMe2InNH+snK42gcX2t2M1EdhhCS3rF2nGXzqLhK4zSyr8Pba+KEcnK0hpABVGO/vHgdSVRvhR5qb2wLvueiZIF/V1UnvpyTG3Pa6OsNgLqlZPM0Jdo3CHHuxwL408035LMrLLp61gxMiiykFTjLYZ56dFQYZ0rqb4/uRfPM6oFI6JLtujc6s8JSQlTTjPwbT7Y2dcovZXsu4agz+s7gFPz0MTc/nQCcaz9wUisTj9EXQjpiwzmbHF+GHNfaPD34RkbMDCrtyVz10j55BlvaEGN3gBQuVO90TZGO+wjEA6LA9HuHeLYXZh9LMKcdnh8HxL7TLj5elEwhkQXFBnWACA+X9ZIUk1OtQJcULnDTTA6iTNrC6K23VzqrNjDSo4DQLhZCAJdmM5g4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJZMnhlZkF5OXhnWnNaMllVSjNIbzZjREdkbWd2SEVKSGZIdWFjUnNycnZI?=
 =?utf-8?B?MFdoc3p0c1JjMjBSWGkyVmgrOWR6TDMrS1lrYVdXZjhlZ042bTVDK2xmTmc4?=
 =?utf-8?B?N0JVMVhkaHQ2RG9UWEZON3ZGV2o0a0krSkt4NEI3SWs2aHM4Z2RsOHpoSEhp?=
 =?utf-8?B?TDZKQXJORFNxNmRwTHlocFVBVFpIc2F4OFRIb05uYzNmOWUrU1NBZHVkNS91?=
 =?utf-8?B?Rk9yNHp0cHBjV0FwbUdBUmdwdEM1d0ROaXFnYjJJYVZnaGhqNGhQQ2V6Vzlk?=
 =?utf-8?B?Qkk0T2NXb2U3U0xJUUVLWHVMMy9WS21jQ05TN1E0RWUyL0pWSmcyeGg4SVRX?=
 =?utf-8?B?anNTUWxzUDJIRG16MTZMa0JDbkpJb0lWZVhmdlhaWXI2MXZXckNqRzN4NFRI?=
 =?utf-8?B?S3R6UmxqQ0Y4dm9uNUlBaFhTK0FrVkE3S2E0b0JCdThydkFLWVJia2duNFh5?=
 =?utf-8?B?R3pJWGhiNXBZUmc3RjVxTHM3STV6ZlJMSHMxMGZRRldJeEpyMVdsTHBBMU1n?=
 =?utf-8?B?WHRkS0tZR0NydGZhNHRLYWJYWnhYeGhuYjZ4NFFOQUc0TnFDOXk3VmxQL3l4?=
 =?utf-8?B?SzBiREs1L0w1WFJQLy9sM3BqTUptMFNnUDNWejdsRzF4U3dBYVFLRm0vVEwz?=
 =?utf-8?B?QlIzeDZJWDVxOXo1RUZ5c1NiQytYakVBRGJmSEdYQ3pxNW8xUVRtL09GYTN1?=
 =?utf-8?B?WFdqRlBUMWpqaEZlcFljRnhWcjYwV1lNL09uaDlqSVJhb3RoV2g1bVlMMFFZ?=
 =?utf-8?B?djEwMmdqYlhaQjRSSWl4UXNBcmxuNUxVUFErUHU4b1IzeDlORHNadWlNbGFN?=
 =?utf-8?B?ZGJHR2xMcHBXUytxVXUvU2NkdlJlUy8vME1HdmFXQnFQNnplQVAwN0didGV3?=
 =?utf-8?B?OGg5TXhmb1ZUdjFzUklrdUsrMDZZNDBtVUJ6Mm9GOGJ2bGdwRGRuWlpqRXUv?=
 =?utf-8?B?eXdiK2V2dzNtU2V1emdXeE9meUVhVy9TNHI0T1Q3dGFLMmFNR0JtMHYwOU8w?=
 =?utf-8?B?TDlRalUwR3hVMUE4ME5qT2cxRFg3cytoSmFMVnlEMGxZM3czemhRMlVGckRn?=
 =?utf-8?B?RWZlaVc4OHdOckN6c3VuQm9UdGtjTmZOUTFiTmlBbmU3Ym5hYjA1Uy9zWXFV?=
 =?utf-8?B?dWViaHYvak41ckhUYy9LejNQZEhESGZQQVdHWkRnMHR2WmRCY0U4eVdyalVH?=
 =?utf-8?B?dmY4dzlucmZHam5SWlJmSHg0MGkwSVBpM1hjR1drVHVKSWc4ZTFvK0dzSncy?=
 =?utf-8?B?YXBIekpkNzd6b2U2WGxOMUZkTEc4V05PeW1lYkZXRGVaWThIVE53cEVtMDEz?=
 =?utf-8?B?SjArVlIvaFdLVFJ0aTRjOHd2OXhYQ09aN2ZqVFdYUk1XWkRVakNyZmh1ek9P?=
 =?utf-8?B?NUV0VUFpNHk5YmE2Vk9wTXZqdm5qWjhvUXZneTRKdXFhVWFvWnhlY3lKMHhT?=
 =?utf-8?B?UTNKaS9BTTlRT053R0tUVDNmekE1NStxWmhGM1NxbVNyckRDZzhjaE50SDM1?=
 =?utf-8?B?bmIrK2RDTlRUNkRpM0dvU21wNitOWlVGK3RibSszd2NpemZHbWQyWndJMVo2?=
 =?utf-8?B?Y2pZQ0VoMmpKLytldnRMRUhKeFROTTBVdVFHRGNPWmVMOVI4RGNoK28wZW02?=
 =?utf-8?B?dUhZbnc5S0lzTk5CalhRdzVaVFZhcXFtbFVDU0hCZlE2dVA3alFMYzhvU3lP?=
 =?utf-8?B?Z21QaXdOUGZCUG9XV3ZseWRjLzVlZ1JMNjlIblF3V2RVL1YrMkR1SmdBdlVP?=
 =?utf-8?B?U2YyeG0xOGFNSkRYQ2NwSnhTMWpQdFRJL3J1VXhhaWdtcGlvb05HeXRnMEw4?=
 =?utf-8?B?WjFhUW9pQjBNWis2RFp5VStTM1NiY2RsNTRPRmU2Ry9Ra0cvY1dFalVYaHNS?=
 =?utf-8?B?NkErdm93WHFtUmp6cGFhcGdEVXRYNGhhUWNTSThFZ3VnUHo3WjN1N1pGNFRj?=
 =?utf-8?B?MWdXS2NBcHlUZ0NrMHZsczRSaWF0cURXa1dJUmJBQThHUllqMTJhNmc2MjJx?=
 =?utf-8?B?T0wyY3ROdEJIaDNsMWd5WXJwdDFDcFJZYmV6QTVvK08yM1JBcDJ6ellEUlFQ?=
 =?utf-8?B?V3BXK1daMEJ5bXhrNU5XK3pSM25naXZ4QXJmbUovbWRmUmpPREN3NndQbmx5?=
 =?utf-8?B?NHVQWGpiNmlNNXc0VXZRQUh0WUlta1p5WFBTQTgzZjhPdXdDQmRvdmVheCs0?=
 =?utf-8?B?a1hCT1h2NWNNVVo4b3gvWklrQ2k0V2ZtZ3h5UGdNMUYxN0ZGZEhONEttRUFH?=
 =?utf-8?B?Yi9ydExyUmpGMEZoMXI1OE1ZUUQ2dG1CbFYwSHhEcWpjNDFvQlo2a0EzbE1G?=
 =?utf-8?B?b0tXRlhwenk4RHZuWko4QlJrdlV1Nkh6QjBsQzJRTzFicmVEOUp1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b935353-0480-4f84-0233-08def30cdba4
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:16:08.5933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F5yzVxbHGG30ouyymy3K/Ds5iO6H9852epMz/3sxWrVWelumt7I7y/Irx9/QWq9d/4ArK4/VOEDzq02oGbJcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
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


On 2026-08-05 03:09, Donet Tom wrote:
>
> On 8/5/26 3:57 AM, Felix Kuehling wrote:
>>
>> On 2026-08-04 05:52, Donet Tom wrote:
>>> This series fixes topology device creation and proximity domain 
>>> mappings in
>>> AMDKFD when a system does not provide a CRAT table and the driver 
>>> generates a
>>> Virtual CRAT (VCRAT).
>>>
>>> The current implementation assumes that CPU NUMA node IDs are 
>>> contiguous and
>>> that every NUMA node contains CPUs. During VCRAT generation, CPU 
>>> topology
>>> entries and proximity domains are created only for NUMA nodes that 
>>> have CPUs.
>>> GPU proximity domains are then allocated immediately after the CPU 
>>> proximity
>>> domains, and the GPU I/O link (proximity_domain_to) is initialized 
>>> using the
>>> NUMA node ID to which the GPU is attached, implicitly assuming that 
>>> NUMA node
>>> IDs and proximity domains have a one-to-one mapping.
>>>
>>> These assumptions break on systems with:
>>>
>>> Sparse (non-contiguous) NUMA node IDs
>>> CPU-less NUMA nodes
>>> CPU-less and memory-less NUMA nodes
>>>
>>> For example:
>>>
>>> available: 3 nodes (0,2-3)
>>>
>>> node 0: CPUs present
>>> node 2: CPU-less
>>> node 3: CPU-less
>>>
>>> In this case, the driver creates a CPU topology device only for node 
>>> 0 and
>>> assigns a single CPU proximity domain (0). However, the GPU VCRAT still
>>> references the NUMA node ID to which the GPU is attached (for 
>>> example, node 3)
>>> in the proximity_domain_to field. Since no corresponding CPU 
>>> proximity domain
>>> exists for node 3, the parser cannot find a matching proximity 
>>> domain during
>>> VCRAT parsing, causing topology initialization to fail.
>>
>> Hi Tom, 
>
>
> Hi Felix,
>
>
>>
>> Thank you for the explanation and the patch series. I may have some 
>> gaps in my understanding that I would like to clarify. In my mind, I 
>> was using "proximity domain" and "NUMA node" interchangeably. You're 
>> demonstrating that they are not the same thing. Is that just a 
>> different way of labeling the same thing, or are NUMA nodes and 
>> proximity domains fundamentally different concepts.
>>
>> Your code in patch 5 (kfd_proximity_domain_to_numa_node and 
>> kfd_numa_node_to_proximity_domain) seems to imply that there is, in 
>> fact, a 1:1 mapping, as it assumes that there is a unique translation 
>> in both directions. Am I missing something?
>
>
>
> Thanks for the comment.
>
> IIUC, NUMA node IDs and proximity domains are different numbering 
> schemes. We have proximity domains for both CPU and GPU devices. CPU 
> proximity domains start from 0, and GPU proximity domains start after 
> the last CPU proximity domain.
>
> If the NUMA node IDs are contiguous, the CPU proximity domains happen 
> to match the NUMA node IDs. However, if the NUMA node IDs are 
> discontiguous, the CPU proximity domains and NUMA node IDs no longer 
> have a one-to-one mapping.
>
>>
>> If they are just different numbering systems, do we really need to 
>> keep track of both proximity domains and NUMA nodes in the KFD 
>> topology? Or would it be sufficient to only track NUMA nodes, if 
>> that's what we really care about in the uAPI (KFD sysfs)?
>
>
>
> Thanks for the suggestion. I also think we don't need to keep track of 
> both the proximity domains and the NUMA node IDs in KFD. Do you think 
> the approach below would be reasonable?
>
> Just to make sure I understand correctly, for CPU devices the 
> proximity domain will be the same as the NUMA node ID, and the GPU 
> proximity domains will start after the last CPU proximity domain.
>
> In that case, the CPU proximity domains and NUMA node IDs will always 
> have a one-to-one mapping, and the GPU proximity domains will follow 
> after them.
>
> For example, if a system has three NUMA nodes and two GPUs:
>
> NUMA node IDs:            0   2   3
> CPU proximity domains:    0   2   3
> GPU proximity domains:    4   5
>
> Would it be okay to proceed with this approach?

Yes, this looks good to me.

Regards,
   Felix


>
> I think this approach should also resolve the driver loading issue.
>
>
> Thanks
> Donet Tom
>
>
>>
>> Thanks,
>>   Felix
>>
>>
>>>
>>> The failure is observed as:
>>>
>>> amdgpu: Virtual CRAT table created for GPU
>>> amdgpu: Error parsing VCRAT
>>> kfd: amdgpu: Error adding device to topology
>>> kfd: amdgpu: Error initializing KFD node
>>>
>>>
>>> Since every online NUMA node is a valid topology object and can contain
>>> CPUs, memory, I/O links, or any combination of these, topology devices
>>> and proximity domains should be created for every online NUMA node
>>> rather than only for NUMA nodes that contain CPUs.
>>>
>>> To address this, this series introduces a new VCRAT subtype that
>>> records the mapping between the NUMA node ID and the generated VCRAT
>>> proximity domain. When topology devices are created, this information
>>> is stored in the corresponding topology device, allowing the driver to
>>> translate a NUMA node ID into its associated proximity domain whenever
>>> required.
>>>
>>> Returning to the previous example, the system contains three online
>>> NUMA nodes, so three CPU topology devices and three proximity domains
>>> are created, even though only one NUMA node contains CPUs. The NUMA
>>> node ID is stored in each topology device together with its generated
>>> proximity domain.
>>>
>>> Later, when the GPU VCRAT is generated, the driver only knows the NUMA
>>> node ID to which the GPU is attached (for example, node 3). Instead of
>>> assuming that the NUMA node ID is equal to the proximity domain, the
>>> driver walks the existing topology devices to locate the corresponding
>>> NUMA node and retrieves its generated proximity domain. In this
>>> example, NUMA node 3 maps to proximity domain 2, so
>>> proximity_domain_to is populated with the correct value.
>>>
>>> Since the GPU I/O link now references a valid proximity domain, VCRAT
>>> parsing completes successfully and topology initialization proceeds
>>> without errors on systems with sparse NUMA node IDs, CPU-less NUMA
>>> nodes, and CPU-less/memory-less NUMA nodes.
>>>
>>> This series consists of the following patches:
>>>
>>> Patch 1 removes an unused argument from
>>> kfd_create_crat_image_virtual() as a preparatory cleanup.
>>>
>>> Patch 2 introduces a new VCRAT NUMA affinity subtype that stores the
>>> NUMA node ID and its corresponding proximity domain.
>>>
>>> Patch 3 populates the NUMA affinity entries during VCRAT generation
>>> for every online NUMA node.
>>>
>>> Patch 4 parses the NUMA affinity entries from the VCRAT and stores the
>>> NUMA node ID and proximity domain in the corresponding topology
>>> device.
>>>
>>> Patch 5 fixes GPU VCRAT proximity domain mappings by translating the
>>> GPU's NUMA node ID to the corresponding CPU proximity domain before
>>> programming proximity_domain_to.
>>>
>>> Patch 6 creates proximity domains and VCRAT entries for all online
>>> NUMA nodes, including CPU-less and memory-less nodes.
>>>
>>> Patch 7 adds a numa_node sysfs attribute for CPU and GPU topology
>>> devices, exposing the associated NUMA node through the topology sysfs
>>> interface.
>>>
>>> Please note that the changes in this series are on a best effort 
>>> basis from our
>>> end. Therefore, requesting the amd-gfx community (who have deeper 
>>> knowledge of the
>>> HW & SW stack) to kindly help with the review and provide feedback / 
>>> comments on
>>> these patches
>>>
>>> Donet Tom (7):
>>>    drm/amdgpu: Remove unused argument from 
>>> kfd_create_crat_image_virtual
>>>    drm/amdgpu: Add VCRAT NUMA affinity entry
>>>    drm/amdgpu: Populate NUMA affinity entries in VCRAT
>>>    drm/amdgpu: Parse NUMA affinity entries from VCRAT
>>>    drm/amdgpu: Fix VCRAT proximity domain mappings for GPU nodes
>>>    drm/amdgpu: Create proximity domains and VCRAT entries for CPU-less
>>>      and memory-less NUMA nodes
>>>    drm/amdgpu: Add numa_node in cpu/gpu topology device sysfs entry
>>>
>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 152 
>>> +++++++++++++++-------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  19 ++-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  49 +++++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   4 +
>>>   4 files changed, 168 insertions(+), 56 deletions(-)
>>>
