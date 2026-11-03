Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643B606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 00:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pzoXa8m1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C7310E054;
	Tue,  3 Nov 2026 00:25:12 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9ABC10E054
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 00:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE4EbgkKxkmaCYb4x8+3fVJ6icVgj1b9wCzyIALzMyeJ6Uvy3Hd6MQOay1r2Q0rH/+7xZpERAgdGobfn9hxBe4lu/U0QRSQhzZFi7qq+0Yc2nE2JVQI2tQTJJtvYrINK8k+25ez3P9EuWvc+ia5tR+7O3zw4z4QdD+Zohb9h5LfWWpVVPl3nlCrub0NxbeBjq2A4/AKJCPDGNq9jIYgqSpFZYGuWstcNbUKdVphWkWNobKsRSEg3iCT5viqgGKQ65Ahtm6c7VTRLfeaUsOWparN6Eqrgpw3ZSHBtk4LDr5YAzgAS4j1/TbknFKCBGq4tXGbKNoNONZcRalKH1Wgd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnTg+8mmx1oSgDtflyqyH8AirmBwcZVVSpHjdsJzRhY=;
 b=DeYlccLEDO1wEoQfqmBFlXA8kJWhyKKpdmlhk/aj3WZ4H905mYQkLe9Bsft4ny9HIZ/K2RKWxxRaPc9vByaR+dYTAOXecKa+abUJpnrvlp8wCPZUit0cwMnpHWk1TxyZEYnz1ei/vKC7wSmn0VysQqLOZb/2wtCRsUKj0CLfiKJJtAS3wfY+br3J7nVfykx6Q/WmVfVpqF+IN86ImJUi7Y/48U4CvkytgjU+N4GQ7U3P57XtvuBaeWor6L1paGl01LdhF9tr3lOOLDjE4Om4ujpmcwPJo1rHL1Oo9dc7Kb82zNctqKg5+IXebQ5OBJx3eas58SLlvjq8lbGB4yOstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnTg+8mmx1oSgDtflyqyH8AirmBwcZVVSpHjdsJzRhY=;
 b=pzoXa8m1hDhtY27wrLvb0SqJSSEETN5PPmwtW8CnDaYEhbntY/Lt6Ta+CPCg8ip4GGC2j81g1+LlGS/9oVyRH1+0OqjdAtnrQ7pWjzTWJDjbsp4IrTU2GLMPh1cfVYEnpxaBpi39DS5YpNfWmi/FswXoN2U/Tc/HF80Iz5+CMfk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by LV3PR12MB9258.namprd12.prod.outlook.com
 (2603:10b6:408:1bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 00:25:02 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 00:25:02 +0000
Content-Type: multipart/alternative;
 boundary="------------aZ0MNRI0SONMRpxrIJBgdp00"
Message-ID: <70018014-d952-4155-aa36-cf9b39ba8aea@amd.com>
Date: Mon, 2 Nov 2026 19:25:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdkfd: Add support for discontiguous and
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
References: <20261030083304.9767-1-dhruv.b@linux.ibm.com>
 <20261030083304.9767-3-dhruv.b@linux.ibm.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261030083304.9767-3-dhruv.b@linux.ibm.com>
X-ClientProxiedBy: YT4PR01CA0335.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::26) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a32e22-8391-4982-e4f4-08df3940e691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|8096899003|56012099006|11063799006|5023799004|4143699003|261022105027099003|261021121427099003|261026121527099003|261022115727099003|261026140227099003|261021123027099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: mARoAYoxdrsfNYBxnLZNZf+drKJFsqHaHnYYMLENevI4EIK2huTcf/Cw88cW0u2totSZkstSeAZ7HPHFNxjtXzuw2YasetO07deKBsSbHRQsNmUOOiLY0hYf01rpJbAreTOgkfKpn0Pk1goj6IOy9m0c2+WWafeBvUt+cXgJyIcqvsggBCJEPbdzhFIXAwKpB/WE0N+Op6R6POPMZEdm6XY2CsaYSiC3ADIA6xA0m90nOKaFRO1m4x3k6ghMtvy7EIFbK6/QSY4RONpzRLlv26yG4JLR6vH2sEDWshRa6Fz7EByucixGKjioi3Y/1hlqjjFxHNA37Vf5xluWmCWZ90mZmkU+t8KpuKFoO7HwUanQziQJj79XVMemHIUa2IJDCdMXQbgIdlUrdeZNPj9ZuEaSblZgRPVkmWXEyG9nIpQAqVj0es9Nxyrp+ah8fsYo3nEL22NTGO4aYrJKNKkWL+CLMRpt0/C89j4q2mgmJ7bmvFfylGFhNw5rPByhGYji+rwLS9WBUACSIu4F28OMrNti7hfjeLAQQQXFDQy29ZXFqddReH/r8D7r1rm6SrjfrNyIQr6pwSGxL4WBKGip/WkNUTy+KfN0B/LNu+5vnLrjb3FdzqiWYO2V8xneThngnCIDyoT2K29Ug9VOjwfr12zo0y0Cw2FTJp7KWoMNJP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(8096899003)(56012099006)(11063799006)(5023799004)(4143699003)(261022105027099003)(261021121427099003)(261026121527099003)(261022115727099003)(261026140227099003)(261021123027099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHRISVl2S290MUdpNEJDZE5VMWhaQXU3YmdSeDB3Q3hCY2N2c0dueUJ1RjVG?=
 =?utf-8?B?RTIyc3lsNzkwVUtNNnZPVktnNU56RnBvRGlmamZnRXByV2xhdXAvUWxKVG5l?=
 =?utf-8?B?QnBXQmJYT2UxbVZnc0VLZGdwU21KSFY2bFRTNHpUYVZXa2dSdFBxM01ybE9S?=
 =?utf-8?B?OXYrVUtYR0FKVzN0RTZsZ1RzUE5tcW1RK3pIN3NuclV0WmsxNW1oeVAyMFhk?=
 =?utf-8?B?bkdxdS9iWVFuTEpubnlOWnJ0V2xjRTUvUTVWVGU0Wnh6MHhock9xdzhadWRs?=
 =?utf-8?B?WnJNV2psM2VmbWtjM1Y2dFhuN3JqRFI3Tk1tQm1uMDhpam9Fc1dnNXM2c3dq?=
 =?utf-8?B?dGhZRnhXS1Y3NXJ3cW9iWmp1VEZyZktZNXBsUFVvWW82YWFNTHpQeGVvS3Zh?=
 =?utf-8?B?NlZMa1FpMUZkRWVnUWdMalNMQ1pULzcySE5URiswV1NuOGp3N0x3dWJ5eDBW?=
 =?utf-8?B?eVpjdi9TZzJmS29tcUVodmtvMm04d2xPaXIvSVc5UHpqdW1uZ2xKTkpTc0xJ?=
 =?utf-8?B?a3JNTlRjYmQrNjg2cVN6MTlLdXJPZ0xnTytWVUNSbEREaHd2dzR4Tlo5NFdp?=
 =?utf-8?B?ZFkrSXNjekp5TVF5bEg2ejFNVUttU3duazZ5dW1IZnJFTUx5c2wvMDZ5OEpZ?=
 =?utf-8?B?Nkg5T09wWGhjTTBWejZVSExjR0pvd2ZhN3hIRENIYXpPb01CZ3Bzb1dTMjQ5?=
 =?utf-8?B?ZzdqM0c3NDRVS3gzT2lCMGdIc2FKYWJ5dTRBMDgxL3hnb1JNV0dhdkpYZzAz?=
 =?utf-8?B?Vkt2VVFkM3UrVHpPaDBvWHN0Z3VEaTd6RUk0a1VsTTkxRVVFUnRyMXBjSXl2?=
 =?utf-8?B?THh1c1h2eGN4QmszVTVDQ01xU2h2WGNEU0I3RTBJR00rOFJ3di9qY2x3czZC?=
 =?utf-8?B?dU9ENzRzbStjN05LeDFBT1ZzaXNqb1ZCWDU1QXhtUG5OVzNNbjJsLzU0Vldr?=
 =?utf-8?B?YmYwWk9hdW1QSnpmTDJuZDNrU2hvRGlpNlVmSUZMWjNEQWhJQVVUOWFXUWtK?=
 =?utf-8?B?djNodFN1bGVON1JOM29xbGQ5WUhXekJzdDVzUjRXQm1hbEdRZUNxVTJrVFhM?=
 =?utf-8?B?NGIwVWoxUmZsRjVhRFNHdkw3WW9IQXgzWjMzN0x3ZTlrQTlXZEhDRlozb0JU?=
 =?utf-8?B?M3NhdWVTN21LTGljaXlXQitwT2pKU0pneGE1OUZ2dlRCRVovVTAvUGhvRGMv?=
 =?utf-8?B?Um9WRXNrRUhwTXZTVSs3b25uZ2hwZEdqa0Z2LzVERXZyV2VudEVPeEx6VWZk?=
 =?utf-8?B?VnZEVjN6Uy9lZndPVGpWZFY1QkdNUnpPcmpWZmhuWEkrRktXaUxMc2dpVElG?=
 =?utf-8?B?YlZNRkg0OEZtMWsvSlIwSDZ1WU1aV3hrREpEWjVNRG9WditXcUV3NCtKSzhm?=
 =?utf-8?B?ZFNiTm92MGR5bk1IZHdGR2FUaG1LTXA5eWFkazV0dG1EdWNFU2tDUkt6MEx2?=
 =?utf-8?B?ZVFLNXNZVHFESnlYcFEzZHhoWXZtVVJHN1IvL0F0SEcwSE1pOUNBOGZxTEho?=
 =?utf-8?B?S1hFTTJKZDBZTndTRUsyUEw0UzUxa3NsUnF4alFKRWNHdHZHZHpJY2ZzUDc3?=
 =?utf-8?B?dVcvZkV5Yk1DbG4xeU51RWtKUEQraVovVUx4ZFFmZWlmWlBkUjMwMjZxNGhs?=
 =?utf-8?B?TlV1bXJYTlZFNmdBeG13eHZaRUhBVHZYZDVjY2NqVG1Vb3Qvb1VxZG9NZ0lO?=
 =?utf-8?B?L1NveDJRU0pMM3JEbmR1dmpGcGUzUy8vNnBjek5YS2JMRnQwYjVKRXFFYWNR?=
 =?utf-8?B?T1JWbXQ2QWxOTSszS0xZTHN1TjlSaWp1MlNZSzI5WnpwNkphVGpCdXpMZFpC?=
 =?utf-8?B?WUg5cVJXTkdYQUJBNHROYmYrVGpIUG4rRUQvVkxxVEZoNUFTSndBTmkycWlG?=
 =?utf-8?B?ajJTeGNBTkZwRTJYMjJOMTFjY2pxTHpQZ3VKN3NDWURiUi9TeVhNcHlOL2ly?=
 =?utf-8?B?ckhtR0JKQnA2SDViNGtlRlhnSkdsU2VDUUFQTlhOdzUvWFhqb01PMUszV0Uz?=
 =?utf-8?B?Y3l4ckdIL3J4cUQzUWV3aFYrbXRBblBVVEhpSTVFSTgxZE5ucEFiM1hMbWhv?=
 =?utf-8?B?SGdBNnBPMzdtVXE4WHVXMDl0czUxamlSN0kzZ2xSVTg2OWl1SFlQQ1BhS0lS?=
 =?utf-8?B?ZXRhaTZUbHlzNkdiN3BOd3FxSWZGTERha2tCbVZmdldtRHcyN3U1TjQxNmdx?=
 =?utf-8?B?VlVxdlNoSXRRR3Z4ZmsxczA5cVh3VEdCcjRGYzZIWnBEZEF1TWExSHg5RDc4?=
 =?utf-8?B?YVRCZ3FMeGRPSDBoMFpNeTVGSGR5c1RScWZ0Q1JGQ0U2T2l1T1hlTC9ra0lv?=
 =?utf-8?B?aDZDazlmc0IvV0VaUEppSTgzekVEK3RQNm1EYU8xV0dya1hUblFtUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a32e22-8391-4982-e4f4-08df3940e691
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 00:25:02.0019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F91wvMX8YW0E773+DvpX6k3i45sO3cl3SMv3Ev30jOK/HAdbaMNM7tHvl56bTkMe8I0L8Yo4qefBCr2sih3X6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------aZ0MNRI0SONMRpxrIJBgdp00
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-10-30 04:33, Dhruv B wrote:
> On systems with discontiguous NUMA node IDs, the GPU driver fails to
> load with the following errors:
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
> skipping resource entry creation for offline nodes. This preserves the
> NUMA-node-to-proximity-domain mapping and allows the KFD topology and
> its sysfs representation to correctly reflect discontiguous NUMA
> topologies.
>
> A NUMA node may also be CPU-less, memory-less, or both. Only create a
> Compute Unit CRAT entry if the node has CPUs, and only create a Memory
> CRAT entry if the node has memory.
>
> Additionally, update kfd_parse_subtype_mem() to use simd_count instead
> of cpu_cores_count to distinguish host nodes from GPU nodes. This ensures
> that memory on CPU-less host NUMA nodes is correctly classified as
> system memory (HSA_MEM_HEAP_TYPE_SYSTEM) rather than private GPU
> framebuffer memory.
>
> The placeholder domains created for offline node IDs have no IO links,
> so skip offline and CPU-less nodes when building the indirect GPU to CPU
> links.
>
> Co-developed-by: Donet Tom<donettom@linux.ibm.com>
> Signed-off-by: Donet Tom<donettom@linux.ibm.com>
> Signed-off-by: Dhruv B<dhruv.b@linux.ibm.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 59 +++++++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 ++
>   2 files changed, 36 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 99b0c7f825fe..bebbc6715b2f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1103,8 +1103,10 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
>   			mem->proximity_domain);
>   	list_for_each_entry(dev, device_list, list) {
>   		if (mem->proximity_domain == dev->proximity_domain) {
> -			/* We're on GPU node */
> -			if (dev->node_props.cpu_cores_count == 0) {
> +			if (dev->node_props.simd_count == 0) {
> +				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
> +			} else {
> +				/* We're on GPU node */
>   				/* APU */
>   				if (mem->visibility_type == 0)
>   					heap_type =
> @@ -1112,8 +1114,7 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
>   				/* dGPU */
>   				else
>   					heap_type = mem->visibility_type;
> -			} else
> -				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
> +			}
>   
>   			if (mem->flags & CRAT_MEM_FLAGS_HOT_PLUGGABLE)
>   				flags |= HSA_MEM_FLAGS_HOT_PLUGGABLE;
> @@ -1899,7 +1900,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>   	acpi_status status;
>   	struct crat_subtype_generic *sub_type_hdr;
>   	int avail_size = *size;
> -	int numa_node_id;
> +	int numa_node_id, last_node;
>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>   	uint32_t entries = 0;
>   #endif
> @@ -1935,34 +1936,41 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>   	crat_table->num_domains = 0;
>   
>   	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
> +	last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
>   
> -	for_each_online_node(numa_node_id) {
> -		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
> +	for (numa_node_id = 0; numa_node_id <= last_node; numa_node_id++) {
> +		if (!node_online(numa_node_id)) {
> +			crat_table->num_domains++;
>   			continue;
> +		}
>   
>   		/* Fill in Subtype: Compute Unit */
> -		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
> -			crat_table->num_domains,
> -			(struct crat_subtype_computeunit *)sub_type_hdr);
> -		if (ret < 0)
> -			return ret;
> -		crat_table->length += sub_type_hdr->length;
> -		crat_table->total_entries++;
> +		if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
> +			ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
> +						  crat_table->num_domains,
> +						  (struct crat_subtype_computeunit *)sub_type_hdr);
> +			if (ret < 0)
> +				return ret;
> +			crat_table->length += sub_type_hdr->length;
> +			crat_table->total_entries++;
>   
> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> -			sub_type_hdr->length);
> +			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> +				sub_type_hdr->length);
> +		}
>   
>   		/* Fill in Subtype: Memory */
> -		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
> -			crat_table->num_domains,
> -			(struct crat_subtype_memory *)sub_type_hdr);
> -		if (ret < 0)
> -			return ret;
> -		crat_table->length += sub_type_hdr->length;
> -		crat_table->total_entries++;
> +		if (node_state(numa_node_id, N_MEMORY)) {
> +			ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
> +							crat_table->num_domains,
> +							(struct crat_subtype_memory *)sub_type_hdr);
> +			if (ret < 0)
> +				return ret;
> +			crat_table->length += sub_type_hdr->length;
> +			crat_table->total_entries++;
>   
> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> -			sub_type_hdr->length);
> +			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> +				sub_type_hdr->length);
> +		}
>   
>   		/* Fill in Subtype: IO Link */
>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> @@ -1982,7 +1990,6 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>   #else
>   		pr_info("IO link not available for non x86 platforms\n");
>   #endif
> -
>   		crat_table->num_domains++;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index b38d12f3da84..d2fbe73e57ef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1419,6 +1419,9 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>   				    struct kfd_iolink_properties, list);
>   
>   	for (i = 0; i < num_cpu; i++) {
> +		if (!node_online(i) || !node_state(i, N_CPU))

The N_CPU part skips indirect links through CPU-less NUMA nodes. Is that 
correct? For links from the GPU to that memory, I think we need the 
indirect links so the GPU knows that it can access such memory.

Maybe further down we could enhance the large-bar condition to only 
create indirect CPU->GPU links if that node actually has a CPU:

                 /* for small Bar or CPU-less NUMA nodes, no CPU --> GPU in-direct links */
                 if (kfd_dev_is_large_bar(kdev->gpu) && node_state(i, N_CPU)) {
			...

Regards,
   Felix


> +			continue;
> +
>   		/* CPU <--> GPU */
>   		if (gpu_link->node_to == i)
>   			continue;
--------------aZ0MNRI0SONMRpxrIJBgdp00
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
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

Co-developed-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com">&lt;donettom@linux.ibm.com&gt;</a>
Signed-off-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com">&lt;donettom@linux.ibm.com&gt;</a>
Signed-off-by: Dhruv B <a class="moz-txt-link-rfc2396E" href="mailto:dhruv.b@linux.ibm.com">&lt;dhruv.b@linux.ibm.com&gt;</a>
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
    <p>The N_CPU part skips indirect links through CPU-less NUMA nodes.
      Is that correct? For links from the GPU to that memory, I think we
      need the indirect links so the GPU knows that it can access such
      memory.</p>
    <p>Maybe further down we could enhance the large-bar condition to
      only create indirect CPU-&gt;GPU links if that node actually has a
      CPU:</p>
    <pre>                /* for small Bar or CPU-less NUMA nodes, no CPU --&gt; GPU in-direct links */
                if (kfd_dev_is_large_bar(kdev-&gt;gpu) &amp;&amp; node_state(i, N_CPU)) {
			...

</pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20261030083304.9767-3-dhruv.b@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
+			continue;
+
 		/* CPU &lt;--&gt; GPU */
 		if (gpu_link-&gt;node_to == i)
 			continue;
</pre>
    </blockquote>
  </body>
</html>

--------------aZ0MNRI0SONMRpxrIJBgdp00--
