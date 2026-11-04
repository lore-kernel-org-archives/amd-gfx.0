Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33B606A326
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=acoNd9gA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C806410FD03;
	Wed,  4 Nov 2026 15:26:30 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1EFF10FCFB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 15:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxQ11sTaDNKcDmCEPNLvfFaV5QL9TScnqPSun79mHmY2q/kjtR9L7ekghJgMDa0ZdAVOPjAaZPamozYwJU1VkC5tzqfSm0XZEZM29PkKRRL+4TWBBlY5sYczU2echyLRpornqJK+kd11VFqDcjw16qH3rWdwJyfcl2shhOFIdCy548fljNjTf1fPCb/oA+6VB40AiptTujQWqx0Y+XvUBoFMOpihpP1d+4nDDYQo0MJIJBGBXByPoQT2At7kilfPUGBmBXGXcHwecrLWK4vt34fRv8WI4FVNOvX0aG2P4XavwNy/uevV6WG8eslJ8Er6TyTaOSzpk1k0Sr+j4+ECxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3MH+xHDF7hp82p/hVqeD9NCT3CQKoiJipcOVM9vM0k=;
 b=U9ojeUfQ6z+rR5KTmvITo3LoS9NDxOBNZt3b/dDvHuf8cydKvzR8kUbnq8TbteUkAplO1WgXM/EPACoq3H3DteFlcUze/olddyTDR6TxcTfpPj9Zy6vtm8SBibzKw6mnEmzAIGhAEoQ2e8bGyWGsUD03V9Ze2D1gontbPxchHBWm3TC0M9SwLGU5Swc0f2EG7CuaO3lLd0f0V/odahW3NXfDu+MGsDEyZKNxsBvwqiP9QM/Owh8gN5XT/Z13LVldMZkHdVsul6TAFLZIMQjC7RQvKmI4NIeZLiaTRYYv2W4+Ud3mZuwvJQUcqS5K+9hreBd7MwvJz5dg4xafQInF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3MH+xHDF7hp82p/hVqeD9NCT3CQKoiJipcOVM9vM0k=;
 b=acoNd9gAaJo8b+DekQe+mnn4zLQkpOHL2ADLmBPkp2KZPKffqEQjZaDf1zx7ttbtyj6Y6SAzsZzb8fe8s+rjB06GVWkSGPaYaChi6MYO+sCIKlN6nOOSXd0QVkzKJY9G/vItWNROCXPNsPdwC/G2cYzh5AdoQUKqFytElxuspQ4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS0PR12MB445413.namprd12.prod.outlook.com
 (2603:10b6:8:3de::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 15:26:20 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:26:20 +0000
Content-Type: multipart/alternative;
 boundary="------------Xus2phtD0gj0DO2vEGDybvWT"
Message-ID: <04ddca6d-3880-48e0-a64e-a4bbde32e67e@amd.com>
Date: Wed, 4 Nov 2026 10:26:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdkfd: Add support for discontiguous and
 CPU-less NUMA topologies
To: Dhruv Bhogaonkar <dhruvb@linux.ibm.com>, Dhruv B <dhruv.b@linux.ibm.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
References: <20261030083304.9767-1-dhruv.b@linux.ibm.com>
 <20261030083304.9767-3-dhruv.b@linux.ibm.com>
 <70018014-d952-4155-aa36-cf9b39ba8aea@amd.com>
 <1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com>
X-ClientProxiedBy: YQZPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::15) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS0PR12MB445413:EE_
X-MS-Office365-Filtering-Correlation-Id: 160e297b-b811-4327-762f-08df3a87f9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|5023799004|11063799006|56012099006|261019141927099003|261021121427099003|261019150727099003|261021123027099003|261019132127099003|261019143827099003|261009223027099003|261102123227099003|261026121527099003|261022105027099003|261022075727099003|261022115727099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003|6133799003|8096899003;
X-Microsoft-Antispam-Message-Info: epIgFbE4pqYr6HtWVpKeaxZ+bt5Zd53i+3XM6iMKDS5nOPA8mnh9X4+dxOw+LKTuGsHEawA0KRBcPvCJ9i1PJ0OgzAcC/BW+KpgUDY/MxpBZ8JRIaF0N7xC/fUzY3HTvkI63uzaLqroUgoqR54RQfYp9iecfrjOIXHif0RnlsJyNvTf8FPWKpTgpJRcaPH61LpMnL6r9cey444qQgBHohvsWutUGioGsCZ75SSGvoxqbXff0loYo2ZOh9w/DqWz5H5C10q40eVckJ1KPKcaVEJ7y8+BBqDRo1vdRF0E85hezA+QqfsY9lMr5W/GmAj1Fv7+r5EoZDgvFwT+mQCoqzhhrikg9m69GBYxLsxY6dWqD3Spqj4L9WX0MbPPtyhUie2n/F8e5ZUw9esl/MawIJSykBmCLB3ug7l3R7Ukm+ccMv5zLxu6G7/OPfqijnO8WTVNq7xbH02GLjPn/QmSv2X8dilxqrCvF2gf7B8EeSPGzYznUWPqIr7hl4I9bX4EMqlKZUEvjyFF6Whigbv+eRqzxwkoXGAkWyyxrEsbBzWGJHhjZWCzVqsZAFf/HYsbt08RG6VYxZR3reBZEwamVvTeWZ+zGjfD4xyYefy87hvODhwmIVr65OBYFKfPYmFF2E/RXo5PJWp78gDd8ZB7eIDDNR/kKQHR3B/xc6pcrBo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(5023799004)(11063799006)(56012099006)(261019141927099003)(261021121427099003)(261019150727099003)(261021123027099003)(261019132127099003)(261019143827099003)(261009223027099003)(261102123227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261022115727099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBoYUZ4d0t3NVB3U0IrL0hsWFJra08xMm9SenZuZjNlcVB6QWFyT201dlho?=
 =?utf-8?B?MjBWcmUwSGpYRVpTOVdGZ3NSSjRNZ25KK1dia2w3d05kWGhFT1oySCtJNllq?=
 =?utf-8?B?VUJGTExwdDlwVzM0WGM3ZkpVWExGM0JBY3VUQVpJdG5YRFVNbWJ6SjZCcUpk?=
 =?utf-8?B?N09HUWJwMEJKaG1jTDRnKzRBdFN0VWFqQU90bUpuaEo2VThqU2MvNG9SaWh2?=
 =?utf-8?B?U281MFZoeUNqN1l1Q0h2OHJocys3Rkh2Wm1rWG4wblQwbDhONWtGckxoVm9V?=
 =?utf-8?B?aUtFLzg2TzZld1d0QXRjVDYwbldaUHBEelhRODFDZmhxTGduMkVQNzlLVlFB?=
 =?utf-8?B?WTBjeXlSVnY1ZTZJOEN5Qy9xcUlwQldSTDhCUVpJSlpMdjRaWWdFOWVmRm5t?=
 =?utf-8?B?Nmw2Tm5LWDFpSjhKcjR6YkU4anFWb0orNjJqSEhLTDdqaUtyalFtTXpHZ1ZR?=
 =?utf-8?B?Nk5ERS9DdUJ3VzlnS0Fza1R6OFl0ODZ6WGFlMTViTEtOSEphd1FoUlN6WjQy?=
 =?utf-8?B?dFByaHE0L2ZiY2kzc0d3cHBqdTJ3dUt6K04yaEJMMDRWN0dPNGVvdlpoTE5R?=
 =?utf-8?B?RmVLOHdOeitrcGU1TE8vSk9IQWpMK1FyZTJTK0h4Y2ZibUlrTUVrY2ZuWFpL?=
 =?utf-8?B?S05FN3JaeHFRaUZ1c1FYZi9MY3B1cjhVbkZzaTNMTEhTdGliYlZvaHRwem1O?=
 =?utf-8?B?ZEdoMzJLSVRhN0lEZzFhd09jWndXK2J5RnhldERZMHdGU0MvMmUyRUk2YTZC?=
 =?utf-8?B?QkxOT0JvQVJNTDJ1WjEvdlJpVmFNbjkybnl1ekZyVmRncUEvZUY1Vm5hMGFr?=
 =?utf-8?B?QTRyak1vVk02eUFYVVpaVHFWbDlicU1BMTNQNlJ4SnRMMmdCcnB6a3cyZWJ0?=
 =?utf-8?B?YnRPSy9rQldYOWlTaHBaVUlXUzVIeERFNzdRQ3FJS3dlODdESmVmWjN5TVVH?=
 =?utf-8?B?dWQvMGJZKzJoYW9TUG5MZTI2ajk4bTBDWmxjb2ltRmxRVDlvR1NrY2R0MXhN?=
 =?utf-8?B?OVRUWnlwSUo0S0R4U1pRWEZlVWR2WlNxUjkyVWRBSHZIbHMvR05ZTjhpOUpk?=
 =?utf-8?B?M0RNUkJUNGY3ZHU1UDZmSyt3VFljY3dqN3dIeHhreForRHNGL2ZjTC95THMr?=
 =?utf-8?B?KzF2bGJFZkpvRnNZTW1XRjF4c0JsaXpJVUNUa1pZYkQ2LzRCZDZ2b2Z6L1NZ?=
 =?utf-8?B?bnVGZ3Exc2JjbzBJYUhURmZTRlFPTUJRdFM0dUVnSWtQelRURUpDQkJHODg3?=
 =?utf-8?B?amJDY1RZNzlqaDN1RzhFaUlHWTZnQ2ZGMDBQRk5YaXNJNW1PKzNHa2hsdTRv?=
 =?utf-8?B?L1htazl1RHAwTUtvcVRyZ2l6RGFtRVFOaXY2THlXSXhlWEN5UjlnZDNzQkww?=
 =?utf-8?B?TTJmczA3a3F5Y1pHcXBQckxiY3lxc0Z5K3YrUkR6Y3NoRnVYVzRGNUpzaEV1?=
 =?utf-8?B?YXRybnE0cjZqWWJPVXhoUWMzbk5OdENXT0ZIVTVEWjVhMXVCZDArRzM2TDRv?=
 =?utf-8?B?cFZjZUVtNFFUaDYvWTI3SVdQd3BSUHZvWGt4YkJ2K3FUWnhWSGYrdGJWVVMr?=
 =?utf-8?B?WElnQStKRjZUb0s1aXNoanVzVVI5dW5ycmtxQnB6MURBbnhPaFpTaFBoMGJj?=
 =?utf-8?B?NGEzaElKU3NyWE10UzE1VGcveXZ1N3NFaUdJRy81ajNwSDZEUEJvOTl1R293?=
 =?utf-8?B?MWkzNkcxdXhhWjF3ZXFBTlBqR2hLTFp3UDBxTFUwV2FHM0UrQjN4QUVtZXFj?=
 =?utf-8?B?STlLR2RpV0VMdVAvRFUrWjJsOFA5T1JKcjdOYms2NXcyYlgwSksvM1VoQU5U?=
 =?utf-8?B?c0tCdUpHWFNwVVhLekZRRURtdHNhM0FVMlRyTHQ3R3Rta3RocFdYYTFOSHhP?=
 =?utf-8?B?ZTFMRVJ0RUpQckJ4ZnprSzV4aEpjZHdFdXFtNmRzbDVxclNOM243dXQzT3Qz?=
 =?utf-8?B?N1U0ZWpwbXh4QkRGOFcxSzdKdlRCZC80OVZBaUdHc253Y1NPaE4vaDFBOE9m?=
 =?utf-8?B?V0tUa0Y0eDhFRzVaWlRtQWZhNTQwa2pRWkt2b1c0RmN0QThMTFM1ZDlWUnJK?=
 =?utf-8?B?M3cxekpvamwvNlBTWFpFR1d2WVF4aGttTllYMmxBY2U2dzd0NU00UzhOV1BU?=
 =?utf-8?B?SjJ0Q0JUTWNCUFZTakxZZ3lxTzZzOGR3SXF6WCtVcm1LWmJ0dEhuSWVOcjQw?=
 =?utf-8?B?N3VJUmFDWjh6TUhHS01TNFBSOGZ4RXB3b3hob0xneHlRYURSNVlrQU0wSHhQ?=
 =?utf-8?B?SzBNU201QUxmb1hVVDFXUVpxNHV1a3VwaUdMV0NRY1ZlcmFrK0tkb3VjTnZY?=
 =?utf-8?B?RGdGWEVzU1lzQzd2ZENTQTJwYXZiZzZqSG9CTHdHaWk5c29TZ3dNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160e297b-b811-4327-762f-08df3a87f9fe
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:26:20.0916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxAGG1xwIiO4SbDjYuuxwLK+2DJes1g4waQY+2lM+bHg2P2yIq7S9GrjPP8boIP7aPi17ER/HZioKJICOJH+yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB445413
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------Xus2phtD0gj0DO2vEGDybvWT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-04 08:41, Dhruv Bhogaonkar wrote:
>
>
> On 03/11/26 05:55, Felix Kuehling wrote:
>> On 2026-10-30 04: 33, Dhruv B wrote: On systems with discontiguous 
>> NUMA node IDs, the GPU driver fails to load with the following 
>> errors: [ 5. 609767] amdgpu 0038: 12: 00. 0: Error parsing VCRAT [ 
>> 5. 609781] kfd kfd: Error adding device to topology
>> On 2026-10-30 04:33, Dhruv B wrote:
>>> On systems with discontiguous NUMA node IDs, the GPU driver fails to
>>> load with the following errors:
>>>
>>> [    5.609767] amdgpu 0038:12:00.0: Error parsing VCRAT
>>> [    5.609781] kfd kfd: Error adding device to topology
>>> [    5.609848] kfd kfd: Error initializing KFD node
>>>
>>> In the current KFD code, proximity domains are created contiguously
>>> when generating the VCRAT. With discontiguous NUMA node IDs, this
>>> creates a mismatch between the proximity domain ID and the NUMA node ID.
>>> For example, if NUMA nodes 0, 2 and 3 are online, the current code
>>> assigns proximity domains 0, 1 and 2 to these nodes respectively,
>>> instead of domains 0, 2 and 3.
>>>
>>> The KFD topology uses the NUMA node and proximity domain information to
>>> create topology devices representing the CPU and memory resources
>>> associated with each NUMA node. This topology is exposed to userspace
>>> through sysfs, where the NUMA node and proximity domain information are
>>> used to identify the topology devices. The mismatch between the NUMA
>>> node ID and proximity domain therefore results in an inconsistent KFD
>>> topology and causes topology parsing to fail.
>>>
>>> Make the proximity domain ID correspond directly to the NUMA node ID by
>>> iterating through the complete NUMA node ID range up to the last online
>>> node. Account for every node ID when assigning proximity domains, while
>>> skipping resource entry creation for offline nodes. This preserves the
>>> NUMA-node-to-proximity-domain mapping and allows the KFD topology and
>>> its sysfs representation to correctly reflect discontiguous NUMA
>>> topologies.
>>>
>>> A NUMA node may also be CPU-less, memory-less, or both. Only create a
>>> Compute Unit CRAT entry if the node has CPUs, and only create a Memory
>>> CRAT entry if the node has memory.
>>>
>>> Additionally, update kfd_parse_subtype_mem() to use simd_count instead
>>> of cpu_cores_count to distinguish host nodes from GPU nodes. This ensures
>>> that memory on CPU-less host NUMA nodes is correctly classified as
>>> system memory (HSA_MEM_HEAP_TYPE_SYSTEM) rather than private GPU
>>> framebuffer memory.
>>>
>>> The placeholder domains created for offline node IDs have no IO links,
>>> so skip offline and CPU-less nodes when building the indirect GPU to CPU
>>> links.
>>>
>>> Co-developed-by: Donet Tom<donettom@linux.ibm.com>
>>> Signed-off-by: Donet Tom<donettom@linux.ibm.com>
>>> Signed-off-by: Dhruv B<dhruv.b@linux.ibm.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 59 +++++++++++++----------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 ++
>>>   2 files changed, 36 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> index 99b0c7f825fe..bebbc6715b2f 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> @@ -1103,8 +1103,10 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
>>>   			mem->proximity_domain);
>>>   	list_for_each_entry(dev, device_list, list) {
>>>   		if (mem->proximity_domain == dev->proximity_domain) {
>>> -			/* We're on GPU node */
>>> -			if (dev->node_props.cpu_cores_count == 0) {
>>> +			if (dev->node_props.simd_count == 0) {
>>> +				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
>>> +			} else {
>>> +				/* We're on GPU node */
>>>   				/* APU */
>>>   				if (mem->visibility_type == 0)
>>>   					heap_type =
>>> @@ -1112,8 +1114,7 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
>>>   				/* dGPU */
>>>   				else
>>>   					heap_type = mem->visibility_type;
>>> -			} else
>>> -				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
>>> +			}
>>>   
>>>   			if (mem->flags & CRAT_MEM_FLAGS_HOT_PLUGGABLE)
>>>   				flags |= HSA_MEM_FLAGS_HOT_PLUGGABLE;
>>> @@ -1899,7 +1900,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>>>   	acpi_status status;
>>>   	struct crat_subtype_generic *sub_type_hdr;
>>>   	int avail_size = *size;
>>> -	int numa_node_id;
>>> +	int numa_node_id, last_node;
>>>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>>   	uint32_t entries = 0;
>>>   #endif
>>> @@ -1935,34 +1936,41 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>>>   	crat_table->num_domains = 0;
>>>   
>>>   	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
>>> +	last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
>>>   
>>> -	for_each_online_node(numa_node_id) {
>>> -		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
>>> +	for (numa_node_id = 0; numa_node_id <= last_node; numa_node_id++) {
>>> +		if (!node_online(numa_node_id)) {
>>> +			crat_table->num_domains++;
>>>   			continue;
>>> +		}
>>>   
>>>   		/* Fill in Subtype: Compute Unit */
>>> -		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>> -			crat_table->num_domains,
>>> -			(struct crat_subtype_computeunit *)sub_type_hdr);
>>> -		if (ret < 0)
>>> -			return ret;
>>> -		crat_table->length += sub_type_hdr->length;
>>> -		crat_table->total_entries++;
>>> +		if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
>>> +			ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>> +						  crat_table->num_domains,
>>> +						  (struct crat_subtype_computeunit *)sub_type_hdr);
>>> +			if (ret < 0)
>>> +				return ret;
>>> +			crat_table->length += sub_type_hdr->length;
>>> +			crat_table->total_entries++;
>>>   
>>> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>> -			sub_type_hdr->length);
>>> +			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>> +				sub_type_hdr->length);
>>> +		}
>>>   
>>>   		/* Fill in Subtype: Memory */
>>> -		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
>>> -			crat_table->num_domains,
>>> -			(struct crat_subtype_memory *)sub_type_hdr);
>>> -		if (ret < 0)
>>> -			return ret;
>>> -		crat_table->length += sub_type_hdr->length;
>>> -		crat_table->total_entries++;
>>> +		if (node_state(numa_node_id, N_MEMORY)) {
>>> +			ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
>>> +							crat_table->num_domains,
>>> +							(struct crat_subtype_memory *)sub_type_hdr);
>>> +			if (ret < 0)
>>> +				return ret;
>>> +			crat_table->length += sub_type_hdr->length;
>>> +			crat_table->total_entries++;
>>>   
>>> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>> -			sub_type_hdr->length);
>>> +			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>> +				sub_type_hdr->length);
>>> +		}
>>>   
>>>   		/* Fill in Subtype: IO Link */
>>>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>> @@ -1982,7 +1990,6 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>>>   #else
>>>   		pr_info("IO link not available for non x86 platforms\n");
>>>   #endif
>>> -
>>>   		crat_table->num_domains++;
>>>   	}
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index b38d12f3da84..d2fbe73e57ef 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -1419,6 +1419,9 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>>>   				    struct kfd_iolink_properties, list);
>>>   
>>>   	for (i = 0; i < num_cpu; i++) {
>>> +		if (!node_online(i) || !node_state(i, N_CPU))
>>
>> The N_CPU part skips indirect links through CPU-less NUMA nodes. Is 
>> that correct? For links from the GPU to that memory, I think we need 
>> the indirect links so the GPU knows that it can access such memory.
>>
>> Maybe further down we could enhance the large-bar condition to only 
>> create indirect CPU->GPU links if that node actually has a CPU:
>>
>>                  /* for small Bar or CPU-less NUMA nodes, no CPU --> GPU in-direct links */
>>                  if (kfd_dev_is_large_bar(kdev->gpu) && node_state(i, N_CPU)) {
>> 			...
>
>
> Hi Felix,
>
> Thanks a lot for the reply and the suggestion!
>
> Would the following change address your concern? I've removed the
> |N_CPU|check from the loop condition and moved it to the large-BAR
> check so that we retain the indirect links for CPU-less NUMA nodes
> while avoiding CPU → GPU indirect links for those nodes.

Yes, this look good. I have one question inline.


>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index b38d12f3da84..8f908323d74b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1419,6 +1419,9 @@ static int kfd_create_indirect_link_prop(struct 
> kfd_topology_device *kdev, int g
>                      struct kfd_iolink_properties, list);
>
>      for (i = 0; i < num_cpu; i++) {
> +        if (!node_online(i))
> +            continue;
> +
>          /* CPU <--> GPU */
>          if (gpu_link->node_to == i)
>              continue;
> @@ -1437,7 +1440,7 @@ static int kfd_create_indirect_link_prop(struct 
> kfd_topology_device *kdev, int g
>          }
>
>          if (!cpu_link)
> -            return -ENOMEM;
> +            continue;

I think I'm fine with this change. But the fact that you need this tells 
me that you have some weird topology where the CPUs (and CPU-less 
memory-only) NUMA nodes aren't fully connected. How does that happen? 
Does that point at some problem elsewhere?

Regards,
   Felix


>
>          /* CPU <--> CPU <--> GPU, GPU node*/
>          props = kfd_alloc_struct(props);
> @@ -1459,8 +1462,8 @@ static int kfd_create_indirect_link_prop(struct 
> kfd_topology_device *kdev, int g
>          if (ret < 0)
>              return ret;
>
> -        /* for small Bar, no CPU --> GPU in-direct links */
> -        if (kfd_dev_is_large_bar(kdev->gpu)) {
> +        /* for small Bar or CPU-less NUMA nodes, no CPU --> GPU 
> in-direct links */
> +        if (kfd_dev_is_large_bar(kdev->gpu) && node_state(i, N_CPU)) {
>              /* CPU <--> CPU <--> GPU, CPU node*/
>              props2 = kfd_alloc_struct(props2);
>              if (!props2)
> -- 
>
> Does this approach look good to you?
>
> Regards,
> Dhruv B
>
>
>> Regards,
>>   Felix
>>
>>
>>> +			continue;
>>> +
>>>   		/* CPU <--> GPU */
>>>   		if (gpu_link->node_to == i)
>>>   			continue;
--------------Xus2phtD0gj0DO2vEGDybvWT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-11-04 08:41, Dhruv Bhogaonkar
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 03/11/26 05:55, Felix Kuehling
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:70018014-d952-4155-aa36-cf9b39ba8aea@amd.com">
        <!-- BaNnErBlUrFlE-BoDy-start -->
        <!-- Preheader Text : BEGIN -->
        <div style="display:none !important;display:none;visibility:hidden;mso-hide:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;overflow:hidden;">
          On 2026-10-30 04: 33, Dhruv B wrote: On systems with
          discontiguous NUMA node IDs, the GPU driver fails to load with
          the following errors: [ 5. 609767] amdgpu 0038: 12: 00. 0:
          Error parsing VCRAT [ 5. 609781] kfd kfd: Error adding device
          to topology</div>
        <!-- Preheader Text : END -->
        <!-- Email Banner : BEGIN -->
        <!-- Email Banner : END -->
        <!-- BaNnErBlUrFlE-BoDy-end -->
        <!-- BaNnErBlUrFlE-HeAdEr-start -->
        <style>@scope {  }</style>
        <!-- BaNnErBlUrFlE-HeAdEr-end -->
        <div class="moz-cite-prefix">On 2026-10-30 04:33, Dhruv B wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:20261030083304.9767-3-dhruv.b@linux.ibm.com">
          <pre wrap="" class="moz-quote-pre">On systems with discontiguous NUMA node IDs, the GPU driver fails to
load with the following errors:

[    5.609767] amdgpu 0038:12:00.0: Error parsing VCRAT
[    5.609781] kfd kfd: Error adding device to topology
[    5.609848] kfd kfd: Error initializing KFD node

In the current KFD code, proximity domains are created contiguously
when generating the VCRAT. With discontiguous NUMA node IDs, this
creates a mismatch between the proximity domain ID and the NUMA node ID.
For example, if NUMA nodes 0, 2 and 3 are online, the current code
assigns proximity domains 0, 1 and 2 to these nodes respectively,
instead of domains 0, 2 and 3.

The KFD topology uses the NUMA node and proximity domain information to
create topology devices representing the CPU and memory resources
associated with each NUMA node. This topology is exposed to userspace
through sysfs, where the NUMA node and proximity domain information are
used to identify the topology devices. The mismatch between the NUMA
node ID and proximity domain therefore results in an inconsistent KFD
topology and causes topology parsing to fail.

Make the proximity domain ID correspond directly to the NUMA node ID by
iterating through the complete NUMA node ID range up to the last online
node. Account for every node ID when assigning proximity domains, while
skipping resource entry creation for offline nodes. This preserves the
NUMA-node-to-proximity-domain mapping and allows the KFD topology and
its sysfs representation to correctly reflect discontiguous NUMA
topologies.

A NUMA node may also be CPU-less, memory-less, or both. Only create a
Compute Unit CRAT entry if the node has CPUs, and only create a Memory
CRAT entry if the node has memory.

Additionally, update kfd_parse_subtype_mem() to use simd_count instead
of cpu_cores_count to distinguish host nodes from GPU nodes. This ensures
that memory on CPU-less host NUMA nodes is correctly classified as
system memory (HSA_MEM_HEAP_TYPE_SYSTEM) rather than private GPU
framebuffer memory.

The placeholder domains created for offline node IDs have no IO links,
so skip offline and CPU-less nodes when building the indirect GPU to CPU
links.

Co-developed-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com" moz-do-not-send="true">&lt;donettom@linux.ibm.com&gt;</a>
Signed-off-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com" moz-do-not-send="true">&lt;donettom@linux.ibm.com&gt;</a>
Signed-off-by: Dhruv B <a class="moz-txt-link-rfc2396E" href="mailto:dhruv.b@linux.ibm.com" moz-do-not-send="true">&lt;dhruv.b@linux.ibm.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 59 +++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 ++
 2 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 99b0c7f825fe..bebbc6715b2f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1103,8 +1103,10 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 			mem-&gt;proximity_domain);
 	list_for_each_entry(dev, device_list, list) {
 		if (mem-&gt;proximity_domain == dev-&gt;proximity_domain) {
-			/* We're on GPU node */
-			if (dev-&gt;node_props.cpu_cores_count == 0) {
+			if (dev-&gt;node_props.simd_count == 0) {
+				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
+			} else {
+				/* We're on GPU node */
 				/* APU */
 				if (mem-&gt;visibility_type == 0)
 					heap_type =
@@ -1112,8 +1114,7 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 				/* dGPU */
 				else
 					heap_type = mem-&gt;visibility_type;
-			} else
-				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
+			}
 
 			if (mem-&gt;flags &amp; CRAT_MEM_FLAGS_HOT_PLUGGABLE)
 				flags |= HSA_MEM_FLAGS_HOT_PLUGGABLE;
@@ -1899,7 +1900,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	acpi_status status;
 	struct crat_subtype_generic *sub_type_hdr;
 	int avail_size = *size;
-	int numa_node_id;
+	int numa_node_id, last_node;
 #if defined(CONFIG_X86_64) &amp;&amp; !defined(CONFIG_UML)
 	uint32_t entries = 0;
 #endif
@@ -1935,34 +1936,41 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	crat_table-&gt;num_domains = 0;
 
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
+	last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
 
-	for_each_online_node(numa_node_id) {
-		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
+	for (numa_node_id = 0; numa_node_id &lt;= last_node; numa_node_id++) {
+		if (!node_online(numa_node_id)) {
+			crat_table-&gt;num_domains++;
 			continue;
+		}
 
 		/* Fill in Subtype: Compute Unit */
-		ret = kfd_fill_cu_for_cpu(numa_node_id, &amp;avail_size,
-			crat_table-&gt;num_domains,
-			(struct crat_subtype_computeunit *)sub_type_hdr);
-		if (ret &lt; 0)
-			return ret;
-		crat_table-&gt;length += sub_type_hdr-&gt;length;
-		crat_table-&gt;total_entries++;
+		if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
+			ret = kfd_fill_cu_for_cpu(numa_node_id, &amp;avail_size,
+						  crat_table-&gt;num_domains,
+						  (struct crat_subtype_computeunit *)sub_type_hdr);
+			if (ret &lt; 0)
+				return ret;
+			crat_table-&gt;length += sub_type_hdr-&gt;length;
+			crat_table-&gt;total_entries++;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr-&gt;length);
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+				sub_type_hdr-&gt;length);
+		}
 
 		/* Fill in Subtype: Memory */
-		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &amp;avail_size,
-			crat_table-&gt;num_domains,
-			(struct crat_subtype_memory *)sub_type_hdr);
-		if (ret &lt; 0)
-			return ret;
-		crat_table-&gt;length += sub_type_hdr-&gt;length;
-		crat_table-&gt;total_entries++;
+		if (node_state(numa_node_id, N_MEMORY)) {
+			ret = kfd_fill_mem_info_for_cpu(numa_node_id, &amp;avail_size,
+							crat_table-&gt;num_domains,
+							(struct crat_subtype_memory *)sub_type_hdr);
+			if (ret &lt; 0)
+				return ret;
+			crat_table-&gt;length += sub_type_hdr-&gt;length;
+			crat_table-&gt;total_entries++;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr-&gt;length);
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+				sub_type_hdr-&gt;length);
+		}
 
 		/* Fill in Subtype: IO Link */
 #if defined(CONFIG_X86_64) &amp;&amp; !defined(CONFIG_UML)
@@ -1982,7 +1990,6 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 #else
 		pr_info(&quot;IO link not available for non x86 platforms\n&quot;);
 #endif
-
 		crat_table-&gt;num_domains++;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index b38d12f3da84..d2fbe73e57ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1419,6 +1419,9 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 				    struct kfd_iolink_properties, list);
 
 	for (i = 0; i &lt; num_cpu; i++) {
+		if (!node_online(i) || !node_state(i, N_CPU))</pre>
        </blockquote>
        <p>The N_CPU part skips indirect links through CPU-less NUMA
          nodes. Is that correct? For links from the GPU to that memory,
          I think we need the indirect links so the GPU knows that it
          can access such memory.</p>
        <p>Maybe further down we could enhance the large-bar condition
          to only create indirect CPU-&gt;GPU links if that node
          actually has a CPU:</p>
        <pre>                /* for small Bar or CPU-less NUMA nodes, no CPU --&gt; GPU in-direct links */
                if (kfd_dev_is_large_bar(kdev-&gt;gpu) &amp;&amp; node_state(i, N_CPU)) {
			...</pre>
      </blockquote>
      <p><br>
      </p>
      <font face="monospace"><span>Hi Felix,<br>
        </span><br>
        <span>Thanks a lot for the reply and the suggestion!<br>
        </span><br>
        <span>Would the following change address your concern? I've
          removed the</span><br>
        <code dir="ltr"><span>N_CPU</span></code><span><span class="Apple-converted-space">&nbsp;</span>check from the loop
          condition and moved it to the large-BAR</span><span><br>
          check so that we retain the indirect links for CPU-less NUMA
          nodes</span><br>
        <span>while avoiding CPU → GPU indirect links for those nodes.<br>
        </span></font></blockquote>
    <p>Yes, this look good. I have one question inline.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com"><font face="monospace"><br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
        index b38d12f3da84..8f908323d74b 100644<br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
        @@ -1419,6 +1419,9 @@ static int
        kfd_create_indirect_link_prop(struct kfd_topology_device *kdev,
        int g<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct kfd_iolink_properties, list);<br>
        &nbsp;<br>
        &nbsp; &nbsp; &nbsp;for (i = 0; i &lt; num_cpu; i++) {<br>
        +&nbsp; &nbsp; &nbsp; &nbsp; if (!node_online(i))<br>
        +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
        +<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* CPU &lt;--&gt; GPU */<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (gpu_link-&gt;node_to == i)<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;continue;<br>
        @@ -1437,7 +1440,7 @@ static int
        kfd_create_indirect_link_prop(struct kfd_topology_device *kdev,
        int g<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
        &nbsp;<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!cpu_link)<br>
        -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOMEM;<br>
        +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
      </font></blockquote>
    <p>I think I'm fine with this change. But the fact that you need
      this tells me that you have some weird topology where the CPUs
      (and CPU-less memory-only) NUMA nodes aren't fully connected. How
      does that happen? Does that point at some problem elsewhere?</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com"><font face="monospace">&nbsp;<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* CPU &lt;--&gt; CPU &lt;--&gt; GPU, GPU node*/<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;props = kfd_alloc_struct(props);<br>
        @@ -1459,8 +1462,8 @@ static int
        kfd_create_indirect_link_prop(struct kfd_topology_device *kdev,
        int g<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt; 0)<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
        &nbsp;<br>
        -&nbsp; &nbsp; &nbsp; &nbsp; /* for small Bar, no CPU --&gt; GPU in-direct links */<br>
        -&nbsp; &nbsp; &nbsp; &nbsp; if (kfd_dev_is_large_bar(kdev-&gt;gpu)) {<br>
        +&nbsp; &nbsp; &nbsp; &nbsp; /* for small Bar or CPU-less NUMA nodes, no CPU --&gt;
        GPU in-direct links */<br>
        +&nbsp; &nbsp; &nbsp; &nbsp; if (kfd_dev_is_large_bar(kdev-&gt;gpu) &amp;&amp;
        node_state(i, N_CPU)) {<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* CPU &lt;--&gt; CPU &lt;--&gt; GPU, CPU node*/<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;props2 = kfd_alloc_struct(props2);<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!props2)<br>
        --&nbsp;<br>
        <br>
        <span>Does this approach look good to you?<br>
        </span><br>
        <span>Regards,</span><br>
        <span>Dhruv B</span></font>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:70018014-d952-4155-aa36-cf9b39ba8aea@amd.com">
        <p>Regards,<br>
          &nbsp; Felix</p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:20261030083304.9767-3-dhruv.b@linux.ibm.com">
          <pre wrap="" class="moz-quote-pre">+			continue;
+
 		/* CPU &lt;--&gt; GPU */
 		if (gpu_link-&gt;node_to == i)
 			continue;
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------Xus2phtD0gj0DO2vEGDybvWT--
