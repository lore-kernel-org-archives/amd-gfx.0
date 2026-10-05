Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C48CA5FF5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 20:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0E110E226;
	Mon,  5 Oct 2026 20:18:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gj05hsxW";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7C410E226
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 20:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ6lW5ur21siFwOZJgcJtM+qa7J2LtaKe1jf3UW5se/WkiUPsAT1kT6N7jKHXvcfmj6W3eBhYifKqFqi90n6nmtv08a3QDCZ3ZmkP9fzqw/IQpw2JsbrZZXGS+SifRxXEcv1AOQcr+TF9YxovReWl+vENKix0lhqllPTcMLxfIKsig3LDnvhbcibsFWz4FjibBeOArxrZYFpXNf51iooXcrr/qAPzDy0sTEldrD0IO4Hj0mPjJrGnbodaVG5MaGyuyiTjGrC+JyNq/HPIm/zemogZhrbj7uIIKAInBLE6kT3fhmGUBJ8WbX41rz1nmb/vxCWhxERlZbzO8JaU3FqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxNn7gJVZXvmds2499Ou9LFouEU8LnHMZG/JGJCZBT8=;
 b=Msjb5DkfJJBJJdEmztMXJzb3WI18wHAh11gGeqpLAzB9FCoEPEGgquWjOCv99NRm3i0l75C8DyrCZ6SQimzYKkGmxD7fbRGRnTvZ8Fje5/Wu6WfUNRKTv8+/MNI7SVU92TjRrDMz7xShnhw/BYeh/QyAO3b/YMDfcbjsvNwfZHDE10Ij/lrFPWn7FdPsR/9Qi9YIZPyf1qMY2yO22r8vgkJ+Kf3sYJwvnmqVfgdu4SidM+iqJWJtIDtC69zmUldtK1SQwLf4LQr9DEFb4KDq7yXk7yZAs8Qqoj4cvHCjyoScVJs+HH3ATykSHh6O9eGti0YJns0JmB2bnmwBXhdgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxNn7gJVZXvmds2499Ou9LFouEU8LnHMZG/JGJCZBT8=;
 b=Gj05hsxWyqZMzKs07NNTOnIGAa1Abjm5Fmn2eRyIc0EcunuOXXkM6FSN6Vl7ngz8r5hHNO9jPR4fysORY5pDGHIPrL+CoeQT71ZydP+R5OMMbkDWsfTcnbSB6finkvj+h14b0MFMcnn7WJDTIfCepwyv0sbMV3S3zT7ZG5YZpUg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM6PR12MB4265.namprd12.prod.outlook.com
 (2603:10b6:5:211::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 20:18:23 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 20:18:23 +0000
Message-ID: <7b32f88e-4038-4b8a-81f0-5a19469a9899@amd.com>
Date: Mon, 5 Oct 2026 16:18:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdkfd: Add support for discontiguous NUMA node
 topology
To: Dhruv B <dhruv.b@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
References: <cover.1791208447.git.dhruv.b@linux.ibm.com>
 <b167aff82d52fde5bf1568ac886bc80b042a10a1.1791208447.git.dhruv.b@linux.ibm.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <b167aff82d52fde5bf1568ac886bc80b042a10a1.1791208447.git.dhruv.b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::9) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 950755a8-ff7e-4903-fc81-08df231dce16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|11063799006|4143699003|6133799003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VLmhcFkleKxJ28I93hQyZY/PqBft9fdCowGpA5dkYgZb6JdI8h8FK3Z97fKqu1UVuS9FHuFIsU3/fkhuK90KGDCTRKDkd4vfxkk3lkDxRsJc2wO45u3uJ/hOhK6RDk5jTYMencV/2cVCERTIXMxURF5GntU7mUAP9mgs6tFPAXFlIah5EkBGqSYh6DB9fROtQxdSKerlXH7fh+c7SDm/o9ed1Pia+gs2cjdfah2x20r3eqPSs9TUSl4CPLKZB3nVp8G0dqUnD/WQyCS5GDyV1NHeqeDhh3o3MilbxugpnstkA3SCnt0eseKN5zoJbF+WdiKLIYLYW14MBiioy09CuH/+oaBqqn0z0UO4E1qN4tQUJgx2xisfXrZqW0zXBk+gli0jIq4TLfiMUGfYVJzz5Lk1KunPvfoKLxaRj2bdzhLeTBlaH6xJFAj319QnLEAFXMK/v8N6i8KTtq7lh/heVgNeOWtNYj95Ls23+3b3T/IGRyS7qcMXbN/+IULUOmYJ7oxmEGa8ewrJQwDHZCuh7NnrdOBZo1hCAY4am9cZShyE6n/5nzcGfLe8wVSqs3gEDCHr7bgZ8/Zi9OfQXPy+vOiFh6mVNT4wgcWUepIGS110YKi2q2lt/tlBB0//ufXSaY5QOroM1vKDJHbnPM+Ls2+iUFbq9wMGYH42JYeIycQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pjUHhOUzFHUy9Qd1ZyV2VPYzBqV0hrOXFRamxCek02WWNhdDBQSGtNV2tK?=
 =?utf-8?B?TXNxQ2JaSng2cnlYYUpkZXdENTdTR1FlZDdPQTFvK1haMitHNHJ5SnlvdXZP?=
 =?utf-8?B?Qnh0YjB6MWZ3UzEwWXFhZzhROFBsNXBRSktlcXR3YU9LVzMvNFFaaXJ2UWVn?=
 =?utf-8?B?aExoejJBQnd1MUJyVG1rc2xnTWJ5VjRVQ3hDTW02dmRJQ3d0RC9kOFE4bFBr?=
 =?utf-8?B?cWtuN29DV3VkMWxyZjY4K1lCRE45cFFBcnRlMzRkUmVRdEY5dkJObWJWaE5w?=
 =?utf-8?B?UUFSUVJpbEdMSGVRMnJmQU54K0RQalNmK05FRmx6emhDZVQzazkwbmFhamtV?=
 =?utf-8?B?NmZUSkVsRlNEbDRmNEZzMFpkdjg4TWxLc2s0Z2QxYzUzQnc5ekpHek1QU0w1?=
 =?utf-8?B?TEVTdVlJUUkzaTRnOWlHRjNZRVlTTEFlQldoWHl5Q01KUGsxampTbUsvaFZ1?=
 =?utf-8?B?U2d6Q0loS1l0QWhxd0FnTXpqaDNseThXc0R2Q25CbVFONUgxUjRqY0xHTSti?=
 =?utf-8?B?dHpYRGdaeE1KbFJaNHluS0tYK1hFa0t4OGR0N2lRcXhDZjl3cURtd2NpaHk2?=
 =?utf-8?B?S1lCMXEwQ2luR0FHY0x0VHdVa0JTQnE3eDE3ZStEV1VTODFaUWpvam1CRG4r?=
 =?utf-8?B?UFFVNSt2cWJlSE5nL2t0V1FJMVNEMUlBRDF4azU1TVJ4VHlmUWI1VFNBTFVo?=
 =?utf-8?B?NTI0TlI1UFRjY3ZvMTU4NVN0Z3JaeHRDWlNveEI5VEtRRjFHQ2NoMll5N0sv?=
 =?utf-8?B?dUJrNEQzZnNTVDIvWlAyeFRvYThHd1FwemNtZGJXWWRPdzJKOXBkSTRhemw4?=
 =?utf-8?B?RnRPbjA4UG9FS05TVFJJT2VNU21XRWpQczlKMW5MNXhzSlpvbUhyZHc4Vko5?=
 =?utf-8?B?RVEvSFpGdXY5SGRzcnhKOHFEdUhHRVhtTVMxL0lmWmlPNUdhV2xabW9WSmxh?=
 =?utf-8?B?d210SmlHNURkYnNsTHR0RzR0Q0YwWWhCVWtKQmIxOGlaa21EQ05CdnVjbVVl?=
 =?utf-8?B?RVNKV3lKbjlxbFllZTBPNEV2UWkwT0ZSeml3VDhUenhHNU5LZk03OFdUWGc2?=
 =?utf-8?B?Q0FVVzV2b2kvRW5HeVdpNFBCcXl1WHpTQm82clI4WWEvaGU5aFMxSUluVkht?=
 =?utf-8?B?bEVLOWt3RnV1TDJWdFpjNjRpWFhYQ1MvNlR4WUNQb1NKUnhGZElnYjVBc1dW?=
 =?utf-8?B?cForV0pPWGVoTUJJNGEzaDNTMndDMjFRWVF4WWVSb1cwVEpwVmJDbDFoU3Vt?=
 =?utf-8?B?bkxTQlpiK1FlUWdhWC9Qd1d1NENtRmRkSExiWEp6V25rM0NTSmRpMFhwSi9o?=
 =?utf-8?B?Rk14WEZrZzMrdjhYL1d3clRYbG0xRkdnaEpvUmVPb0ltNUlRdjRseStuQlFy?=
 =?utf-8?B?bkpsYVNITHlWZnpkNitPbllEcWUvelVsZkV4UFEzVk44b05COEFVMHZOa2Iw?=
 =?utf-8?B?MjBpR0srMnlGWGF0dGN1V2xyNzBQUDkrSDFtcVdTSm5NUUVDRm9hbkxjSVZ0?=
 =?utf-8?B?TytyMmRqKzRubStvTjBUd0pjbnl5QU9MUTRyamdXYlh1WXZHQml3a2JDTVY0?=
 =?utf-8?B?dk5SMng3TWluRkx5RTMyNE9ITHdIYjRmdWVjTzRFNi9MVVl3Z0c4b3p0VkxD?=
 =?utf-8?B?NTJJd0QyQU1XN0JHYUxYWUw2R3pERERRY0M2VklHVlRWZWJaeGJDOER6WmFQ?=
 =?utf-8?B?L1dOSUVHcE5wZlJXd1B2ZWVTdWovK09BL2MxNGlyUlBqZ0ZZUThXd2lFTE14?=
 =?utf-8?B?SmZ5S2pvN05jNzROdVZsb003Tml4cytpWktPdEY3aW5Pak9HRTdzUUJXbFY5?=
 =?utf-8?B?RXEvNWNOMnVDM2IwSGRrN0paZElsdGNESjNIdndpSnE0NUtHeEdTRXJGNkg2?=
 =?utf-8?B?czNtY0YwaFhpbmJnejBna1B0NDBkZmc2T1RTWTBYUlpCWUtCbTFsaW42eVFh?=
 =?utf-8?B?VGdEdEtPcTBpajE5aTEzcVA1djJaTUk3TDNFeFl5UFBScmZyOXA4ZG1hSkdl?=
 =?utf-8?B?alFSQVF6dFAzcnBoWFlVYVJqaFJMdDhUTW8zODJTU0JoRjNadTQxdTBMbEQz?=
 =?utf-8?B?TW5tL0hhN1VjUzRpUVVtR2FnN1FzdllEZ0FtM1FzYVQ0R3IyTy9vVzNxOWYr?=
 =?utf-8?B?dG81VzY1MU5EV3Y5cUNkNlViN3ZERUp4a080ekhGUGIvWkZaWGFOQ0JrcEhp?=
 =?utf-8?B?MXRNYk9hL2NPZDlkNDZsZDd1UXdtTmVFTytZbEdYZWc5S1VkVkpRcVBzOVR1?=
 =?utf-8?B?a3QrT0ZiZ2lLRzY1Z0VjNVk5RE5BQkNhTXZrV0k4b3p6b0NvNWJZajZRejAr?=
 =?utf-8?B?ZHptUDVBSWlUaGZUQkhiZ0JDdDQvTkxIMDRsK2Q5c0R0cjVKcVh5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950755a8-ff7e-4903-fc81-08df231dce16
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 20:18:23.0350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Gm+uMgx6yTMXdWrs37A9YraqchzvZhuIV3dDD9pvgnrtLtkdT0A5dDbfz1ydFm4ScpIUXQInM43qE+1DIoHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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

On 2026-10-05 10:00, Dhruv B wrote:
> On systems with discontiguous NUMA nodes, the GPU driver fails to load
> with the following errors:
>
> [    5.609767] amdgpu 0038:12:00.0: Error parsing VCRAT
> [    5.609781] kfd kfd: Error adding device to topology
> [    5.609848] kfd kfd: Error initializing KFD node
>
> In the current KFD code, proximity domains are created contiguously
> when generating the VCRAT. With discontiguous NUMA node IDs, this
> creates a mismatch between the proximity domain ID and the NUMA node ID.
> For example, if NUMA nodes 0, 2 and 3 are online, the current code
> assigns proximity domains 0, 1 and 2 to these nodes respectively,
> instead of domains 0, 2 and 3.
>
> The KFD topology uses the NUMA node and proximity domain information to
> create topology devices representing the CPU and memory resources
> associated with each NUMA node. This topology is exposed to userspace
> through sysfs, where the NUMA node and proximity domain information are
> used to identify the topology devices. The mismatch between the NUMA
> node ID and proximity domain therefore results in an inconsistent KFD
> topology and causes topology parsing to fail.
>
> Make the proximity domain ID correspond directly to the NUMA node ID by
> iterating through the complete NUMA node ID range up to the last online
> node. Account for every node ID when assigning proximity domains, while
> skipping resource entry creation for offline or unpopulated nodes.
> This preserves the NUMA-node-to-proximity-domain mapping and allows the
> KFD topology and its sysfs representation to correctly reflect
> discontiguous NUMA topologies.
>
> Co-developed-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 99b0c7f825fe..d4739db1c14c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1899,7 +1899,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>   	acpi_status status;
>   	struct crat_subtype_generic *sub_type_hdr;
>   	int avail_size = *size;
> -	int numa_node_id;
> +	int numa_node_id, last_node;
>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>   	uint32_t entries = 0;
>   #endif
> @@ -1935,9 +1935,12 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>   	crat_table->num_domains = 0;
>   
>   	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
> +	last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
>   
> -	for_each_online_node(numa_node_id) {
> -		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
> +	for (numa_node_id = 0; numa_node_id <= last_node; numa_node_id++) {
> +		crat_table->num_domains++;

Doing this at the beginning of the loop body, doesn't that result in an 
incorrect proximity_domain being used in kfd_fill_cu_for_cpu? E.g. the 
first CPU will get proximity_domain 1 instead of 0.

Regards,
   Felix


> +
> +		if (!node_online(numa_node_id))
>   			continue;
>   
>   		/* Fill in Subtype: Compute Unit */
> @@ -1982,8 +1985,6 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>   #else
>   		pr_info("IO link not available for non x86 platforms\n");
>   #endif
> -
> -		crat_table->num_domains++;
>   	}
>   
>   	/* TODO: Add cache Subtype for CPU.
