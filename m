Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79255D58CC5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 03:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DE010E351;
	Mon, 23 Mar 2026 03:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tX6rg06D";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE7510E351
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 03:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nESVkUP3oxe4UuD27Y4hmxjVxz33DEHduSU368v+OiUGhiY17wzIp+/VCbivYXMz6nsrPna6Spo6T3verJGshyTuJekQ0ohCgyahT5klSrq4ug3tKvKai5AaZ2fSnDjt0t6Din5tR6kmPyRUUn3Yz1mLJrqZ8/Ily4fOXbiacDru5VS+jA3EGf+S449dkxJzbq3+CcmLMeWmxXYQdDcHJVJ6vTGd/z6vf4H2uFoldIW4gJl7L5GUchcX3e1g5PU0zG+gUFGmmOo5vqb571VdLXf+yT8XA8zfQmtgzT1e5llmWTK3MVab+rn4iB1Lqx1f4jhrgC1fTDqmMBX0d8upEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUxsgw5fBy/zcMutCbSU5FYsFFVTlo0f6Mt9BSX7Tf8=;
 b=viBES/OsjGYjEcGt+QoWS4N+nXpVtRbqkCSZ1Ab3OBDYRxZquHg0tM4H1vwv0D74ZWCO43SCtilQBm+dJ4tpuHIQMk7MXk4KaeQFIGH+RBXxQD28MMvoQh4po0v+wFDKiyZL4+A8PElxCa7sv3XK/sfLbeudRzRTkUxnPtLRJgu5xYa8xNrACQ/5NWsZL/oyfYWVxTh/8AOwErowZe+iWCD5P5oN6U0PS6Es5noIyHug2/Rc4GxVqkMByvF4Fcs9ctaynWAQ1tntQkZQHuBxY7VZSnoKrXVFvzjQrT+uxrjjEH3XEp21dj4mcokoICeMgM4q0z4er9q9BJe/Ha9Kgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUxsgw5fBy/zcMutCbSU5FYsFFVTlo0f6Mt9BSX7Tf8=;
 b=tX6rg06DjIFaPLQQregR+T4wHqKLxL85D2ztPbSS9FQ0atVI0n3Aj4siZldL5XukYHO0wkUdXwXKPB+xXm6jiI1ieaiqq3n7ChFOzhjXBoPZamD1DfLpY0k9I2mBmA0YrqcxmwsgImeTSRqA+C3CK9NZ+Qcjodf1MQ7Hk5n6tco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 03:46:06 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 03:46:06 +0000
Message-ID: <262913a9-3fe2-4e98-8296-5463702cbf10@amd.com>
Date: Mon, 23 Mar 2026 09:16:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: harden discovery TMR buffer allocation
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20260320095737.238247-1-Jesse.Zhang@amd.com>
 <c06ff453-5249-47e5-a13d-5275793226fc@amd.com>
 <DM4PR12MB515299F328AAC28588FD2920E34BA@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB515299F328AAC28588FD2920E34BA@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0195.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cad8d9-ebbe-4922-c664-08de888eb63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Mdwa8/Q3LsbvmZMWWH97xT9/1mt23SEF5bHsQxf0DkEAZwLYfZJ7Ioe8wDJYIbCQC3Z+pjdDcMlqi9yidKUB1N3XxsniwKZ4blmDYoPn7mEdp0D78qX+91ipTUPggkJEfPb0GnHFv0orBbw4oKHVbTvALIoZzlOSK7rOnkqVkWp5oeIaM66Sme8nHLI5HATxUvgIlNr9t6TvjfFYGJLigGOpliJl6ZaZQf2m6TUHaMb0yEI3Z8o9fP5ZUhivacVerZzHW2q+ygvS7V0cQBcgU2M2l8wcCW7LHQ2AMOkqaMgW7ZS640gkKcMhVL3XZTQ9dNC++ACVaZeL/164bBrl7XYy+9kB1207BmcC++IC0oriKA3m/T90jNPAgxw148qPQ7eP5tL+IDA8MXqqU4O9lM/eIawyh/28t1/W5lkGApRsy8I9RUJU00+u71c/gKVj8Q1JWUG5K1YCoO6aV/YcDsdWfezrYW0wgzKwH9GxU/tSHkjC0lkesw3Ygx5W0oGuSmuxWTn/yrVZ79KikotjsCZms1jiKVFtaZyiRBeMt9zXeyuQf9iIM871vESkWybDVnrdg2kF+9v44Id86lbQl6w1ebdKSVfE6tEl8s1X+d60fzdj7g+7zp5Ds/FjQaeXrTNmY/zpV82+5zxavADM2hJ7+S9f/0gpe3Js2hGFw4d9hLacNJD1tMOJCnUDHwhO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGpWK2JDSkxWenpQNE1keGFlZGF1b2R4UGVoeHMvcGkrQVZYamw3V0lBRmRC?=
 =?utf-8?B?R1QvaWRocitrcGJZR0lTbVpFV2ZLRldVdHpBdHZ0c0FMcFhmTzUvemtyWm8w?=
 =?utf-8?B?aEN6Wjd0RFYvZUpYNHl5U2YwRGY1amtvOEJnTVZDQjlPaE9NMWpEaFVxbld5?=
 =?utf-8?B?VmNNT0hUQy9vdElWTDdQWmIxUGFIK0lIendWRUpRNHEvT2NQN29RU28zUlFp?=
 =?utf-8?B?RXNnL3pBZFhRRm02NTg3THVGYkFEOHhFenN0b0JIc1hrY2o5cWNQMU1CbWs5?=
 =?utf-8?B?eERvRkZscUJSbWhsa0RQL051UmVUeUVKWnVVSHRmWXEvaFBCNVRJME13bE9N?=
 =?utf-8?B?cjIzKzZwNGVQOGVwYmxiSE5uL3AyeURPZVpBbnJ5eXkyM3hhdXI1UTZEdUs4?=
 =?utf-8?B?TlF0S0sxYmRXaFAyQW9OWTYreFpENjBjUDBQTVdxMnQyMnRBSlNLWDRIRnF0?=
 =?utf-8?B?R1VHTkVLNkpsdHpBM3E5TlJ2dkp5dnY5Tno4VEk3MzBnUjJ6SUFlMDNVT3Mr?=
 =?utf-8?B?R1ZnRjhaOW9oVUVWUitnRmtCREtzampxdnFJeUQwaGs3SThSbVNSL1NDOGZF?=
 =?utf-8?B?VEd1YkM5MmdsNzFOOTdvdnRTS2JuNUZmaDlLaWxSTEVCb2hXcll6MGlKTjdD?=
 =?utf-8?B?MFZxdU0rSjExWVM4REQvV21qeVZhNnRVOUFpa05VRWMwZUUxNmFOTnJkcUlE?=
 =?utf-8?B?cWRtNzNyZVhsTXRvZE1qYnZQdnNLYUhUbjdkYnV0M3VLNDBWZ1N3WFM0cTFT?=
 =?utf-8?B?YU11MWpPaVdmbW9LVDBveGNtWU5EdU00cU5ueTFaTnFTZVpXN2RLUWpHcWRw?=
 =?utf-8?B?clpST1p6WUhoenB6d1NtazBJK0Foa0ErUzR2UkdZNCtxTkdNRVExVzZNbTRu?=
 =?utf-8?B?c2paZlU0aXRQTm1hQ004UjJhemdCM1o3ZjdxNjVyaE1GUzM4K0Jabm04Rm51?=
 =?utf-8?B?eHB0OWpyY0FKSkR2Z3FkK3ozNnB4YU1UTkk3L2pZMUpwZGZONGpHUkpweGti?=
 =?utf-8?B?N0xPajNlTjNFdFBHUFdRMVJDUUpLNU1yZFR2VE5uTnNNSlNjdkFGZlhwL1pN?=
 =?utf-8?B?OUtQd2wvSEtGTWdWWjR3dytzbTFmdUpNYThSWUU1a0RJRmlaZmNxNEN5OFN6?=
 =?utf-8?B?SjZNV3FZRTFCelhGbDdSMHpHSHYvd3NJeXhLUEl1Mk5OM1JoZFFsT1dlRlZP?=
 =?utf-8?B?S2l2YjVlN1VPQ1BNWXJBVlQ2a0tnbkE0SjVlaTUyNFp5ZkFObVlSVUc0Sk5N?=
 =?utf-8?B?YzR3bmlRQm5aN0lCM1RRbnNoVjBBNE45TG5IQ3RGb1E2ZTNwT0xHWmlPQ3lE?=
 =?utf-8?B?YVFLaTgrZlp0am5adEpuMS84SWlueTRVQitWREJVSENOVmgxYzZhVjhSL3hJ?=
 =?utf-8?B?UC9acFBqelM0K1pvOGZTeWwzVk12SENFb0VpTm5LU3g3NnhsNFQrR2xYOEgx?=
 =?utf-8?B?ZG5iY01nQ0ZpWnoyWWdiUGFXM1FJY1NwVjA1MHlSQlVJanp4eTZXY3JwcWxt?=
 =?utf-8?B?TlBFdDQwVFB3d0FQY2hsOThiNkpaaVA1eHc0VlRULzZYOWZpV1VrREJtN25Z?=
 =?utf-8?B?ZktFdVhVTTA2bUZjOUhxM1U2UDBmTXZ2TDhOL01OM0VmYlU2YzZyQ0w0bElh?=
 =?utf-8?B?Y0FLdEU0dEdET21CQm9lK0VMQlpUdVpRa201OFRrUEhUVm40UlMvUlUwOFFu?=
 =?utf-8?B?QWtqM0g4QmthTW9zRU9NV08xS0wzWWxid3VXZkxoRFUvUmZMTFRLSUYwbU9D?=
 =?utf-8?B?MVRGZFBiSktVQnRZR3pxSlpRMXorbllPMnE0QU5zWFlMUnovRXBOcTJKY2J5?=
 =?utf-8?B?WERySXF3TEJVSytLRUVGQzBmTER5cjE2MTc0VDU1OExVNjZZNi8xRlBMRjVS?=
 =?utf-8?B?dWZ5SVk4Z1NOcDBXMFhlYjdCQlM1ZDJ1S0MxR2pNeklPTy9lUHlEaFM1clp4?=
 =?utf-8?B?Q3NyanlGSTkzd1J4UXN5OVk4NWhObk4xMnNSZ0JBMG1oN1JjcFJjcXhWRWN6?=
 =?utf-8?B?S2tFTXpuZEorK3lwNjFLTHRyc1FzejBNbmRMM1I4dU9FaUdJQTlvOERod3Vv?=
 =?utf-8?B?L2NGcGVya2ZFM0hYRVd5dVlHTlc4Q0hJVTdDT1Q0WE1QRXBJL2tjdW5WeXVy?=
 =?utf-8?B?WUplZTFRUit3cVFENzZEZnhkMGo2RVRGZ3FKNmdwbUVFVWJxRzBEdmQrU1oy?=
 =?utf-8?B?eE1KNjNXRWZIMGpWSm1sZ3UwS2g0bXBSTXVUK21xV0sxelBpMmNOS05CYXJ0?=
 =?utf-8?B?SUZ6RlVjd3VOZS95QlNMdjNDL1AwVDdXbWNNYXBDZGV0TTBjVG9EMVRuMEFs?=
 =?utf-8?Q?RCL5UpTa4Qn0VI20nN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cad8d9-ebbe-4922-c664-08de888eb63f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:46:06.1422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsUcwa5bJ+EQS3c6DOByVgEprjyaCaMSm+k9eL6+/NbMPwj44Qx70CdmdY2gRVLa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
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



On 23-Mar-26 6:56 AM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, March 20, 2026 6:32 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: harden discovery TMR buffer allocation
>>
>>
>>
>> On 20-Mar-26 3:25 PM, Jesse.Zhang wrote:
>>> Some platforms report an invalidly large IP discovery TMR size, which
>>> leads
>>> amdgpu_discovery_init() to attempt a large kmalloc allocation and
>>> trigger page allocator warnings/failures during probe.
>>>
>>> Observed log excerpt:
>>>     WARNING: mm/page_alloc.c:5216 at
>> __alloc_frozen_pages_noprof+0x29e/0x340
>>>     ...
>>>     ___kmalloc_large_node+0xf2/0x130
>>>     __kmalloc_noprof+0x442/0x6b0
>>>     amdgpu_discovery_init+0x161/0xa00 [amdgpu]
>>>    Fatal error during GPU init
>>>    probe with driver amdgpu failed with error -12
>>
>> This looks like a different issue. Do you have a trace of which path it takes and the
>> value seen?
> The function amdgpu_discovery_get_tmr_info() reads the discovery table size from the TMR info via ACPI. In the attached log, the discovered size is 0x11800000 (approx. 281 MB).
> This size is then passed to kzalloc() later in amdgpu_discovery_init(), which leads to an allocation failure (‑12) and the page‑allocator warning.

Thanks, it's a regression introduced with a recent change.

The fix should be here.

https://gitlab.freedesktop.org/agd5f/linux/-/blob/drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c#L327

acpi function will return the full tmr size (not that of discover 
alone). Discovery table size remains as DISCOVERY_TMR_SIZE. Please 
change this to DISCOVERY_TMR_SIZE and also add a Fixes tag.

Thanks,
Lijo

> 
> [ 1337.084630] ------------[ cut here ]------------
> [ 1337.084634] WARNING: mm/page_alloc.c:5216 at __alloc_frozen_pages_noprof+0x29e/0x340, CPU#0: kworker/0:0/9
> [ 1337.084652] Modules linked in: amdgpu(E+) amdxcp drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_client_lib drm_display_helper cec rc_core drm_kms_helper video xt_comment xt_conntrack xt_MASQUERADE bridge stp llc xt_set ip_set nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype nft_compat x_tables nf_tables nfnetlink xfrm_user xfrm_algo overlay binfmt_misc nls_iso8859_1 intel_rapl_msr amd_atl intel_rapl_common amd64_edac edac_mce_amd kvm_amd ccp kvm rapl wmi_bmof mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua msr efi_pstore drm autofs4 btrfs blake2b libblake2b raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear dax_hmem cxl_acpi cxl_port nvme igb cxl_core ghash_clmulni_intel einj dca nvme_core i2c_piix4 i2c_algo_bit i2c_smbus wmi aesni_intel
> [ 1337.084915] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Tainted: G E 6.19.0+ #79 PREEMPT(voluntary)
> [ 1337.084925] Tainted: [E]=UNSIGNED_MODULE
> [ 1337.084929] Hardware name: AMD Corporation Sh54p/Sh54p, BIOS RMP100CAS 11/07/2025
> [ 1337.084934] Workqueue: events work_for_cpu_fn
> [ 1337.084948] RIP: 0010:__alloc_frozen_pages_noprof+0x29e/0x340
> [ 1337.084954] Code: e9 b6 fe ff ff 83 fe 0a 0f 86 ec fd ff ff 0f b6 1d a4 b0 13 02 80 fb 01 0f 87 75 66 b6 ff 83 e3 01 75 09 c6 05 8f b0 13 02 01 <0f> 0b 45 31 ff e9 12 ff ff ff a9 00 00 08 00 75 62 44 89 e1 80 e1
> [ 1337.084960] RSP: 0018:ffffc90000123970 EFLAGS: 00010246
> [ 1337.084967] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [ 1337.084971] RDX: 0000000000000000 RSI: 0000000000000011 RDI: 0000000000000000
> [ 1337.084975] RBP: ffffc900001239c8 R08: 0000000000000000 R09: 0000000000000001
> [ 1337.084979] R10: ffffc90000123b18 R11: 0000000000000004 R12: 0000000000040dc0
> [ 1337.084984] R13: 0000000000000011 R14: ffffffffffffffff R15: 0000000000000000
> [ 1337.084988] FS: 0000000000000000(0000) GS:ffff88a64bec9000(0000) knlGS:0000000000000000
> [ 1337.084994] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1337.084998] CR2: 000000c002881000 CR3: 000000046b090009 CR4: 0000000000770ef0
> [ 1337.085003] PKRU: 55555554
> [ 1337.085006] Call Trace:
> [ 1337.085010] <TASK>
> [ 1337.085030] alloc_pages_mpol+0x7e/0x190
> [ 1337.085041] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.085057] ? amdgpu_discovery_init+0x161/0xa00 [amdgpu]
> [ 1337.085836] alloc_frozen_pages_noprof+0x58/0x80
> [ 1337.085842] ___kmalloc_large_node+0xf2/0x130
> [ 1337.085848] ? vprintk_emit+0x2aa/0x590
> [ 1337.085857] __kmalloc_large_node_noprof+0x25/0xc0
> [ 1337.085862] __kmalloc_noprof+0x442/0x6b0
> [ 1337.085867] ? vprintk+0x1c/0x50
> [ 1337.085870] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.085873] ? _printk+0x5b/0x80
> [ 1337.085880] amdgpu_discovery_init+0x161/0xa00 [amdgpu]
> [ 1337.086193] ? amdgpu_discovery_init+0x161/0xa00 [amdgpu]
> [ 1337.086475] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.086481] amdgpu_discovery_reg_base_init+0x1e/0x6e0 [amdgpu]
> [ 1337.086755] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.086760] amdgpu_discovery_set_ip_blocks+0x1cf7/0x2b30 [amdgpu]
> [ 1337.087045] ? raw_pci_read+0x2d/0x50
> [ 1337.087053] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.087056] ? pci_read+0x30/0x40
> [ 1337.087059] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.087062] ? pci_bus_read_config_dword+0x4d/0x80
> [ 1337.087069] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.087073] ? pcie_capability_read_dword+0xb7/0xe0
> [ 1337.087079] amdgpu_device_init+0x1072/0x3470 [amdgpu]
> [ 1337.087402] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.087409] ? pci_read+0x30/0x40
> [ 1337.087414] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.087420] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.087426] ? pci_read_config_word+0x2d/0x50
> [ 1337.087434] ? srso_alias_return_thunk+0x5/0xfbef5
> [ 1337.087441] ? do_pci_enable_device+0x11b/0x150
> [ 1337.087450] ? pci_update_current_state+0x6f/0xa0
> [ 1337.087463] amdgpu_driver_load_kms+0x1e/0xc0 [amdgpu]
> [ 1337.087750] amdgpu_pci_probe+0x2c5/0x730 [amdgpu]
> [ 1337.088036] local_pci_probe+0x4f/0xb0
> [ 1337.088046] work_for_cpu_fn+0x1e/0x30
> [ 1337.088051] process_scheduled_works+0xa6/0x420
> [ 1337.088060] worker_thread+0x12a/0x270
> [ 1337.088066] kthread+0x10d/0x230
> [ 1337.088074] ? __pfx_worker_thread+0x10/0x10
> [ 1337.088078] ? __pfx_kthread+0x10/0x10
> [ 1337.088086] ret_from_fork+0x17c/0x1f0
> [ 1337.088094] ? __pfx_kthread+0x10/0x10
> [ 1337.088099] ret_from_fork_asm+0x1a/0x30
> [ 1337.088114] </TASK>
> [ 1337.088118] ---[ end trace 0000000000000000 ]---
> [ 1337.096795] amdgpu 0000:01:00.0: Fatal error during GPU init
> [ 1337.103593] amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
> 
> Thanks
> Jesse
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Fix by:
>>> - validating discovery size and falling back to DISCOVERY_TMR_SIZE when
>>>     size is zero or out of expected range;
>>> - using kvzalloc() for discovery buffer allocation to avoid high-order
>>>     contiguous-page allocation failures;
>>> - using kvfree() on all release paths.
>>>
>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 19 ++++++++++++++++---
>>>    1 file changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> index 5a4e63e1ad93..a6b49378c495 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> @@ -329,7 +329,20 @@ static int amdgpu_discovery_get_tmr_info(struct
>> amdgpu_device *adev,
>>>              }
>>>      }
>>>    out:
>>> -   adev->discovery.bin = kzalloc(adev->discovery.size, GFP_KERNEL);
>>> +   if (!adev->discovery.size || adev->discovery.size >
>> DISCOVERY_TMR_SIZE) {
>>> +           dev_warn(adev->dev,
>>> +                    "invalid discovery size 0x%x, fallback to default 0x%x\n",
>>> +                    adev->discovery.size, DISCOVERY_TMR_SIZE);
>>> +           /*
>>> +            * Some platforms may expose garbage TMR size through
>> scratch/ACPI.
>>> +            * Fall back to legacy layout in VRAM when available.
>>> +            */
>>> +           if (!*is_tmr_in_sysmem && vram_size)
>>> +                   adev->discovery.offset = (vram_size << 20) -
>> DISCOVERY_TMR_OFFSET;
>>> +           adev->discovery.size = DISCOVERY_TMR_SIZE;
>>> +   }
>>> +
>>> +   adev->discovery.bin = kvzalloc(adev->discovery.size, GFP_KERNEL);
>>>      if (!adev->discovery.bin)
>>>              return -ENOMEM;
>>>      adev->discovery.debugfs_blob.data = adev->discovery.bin; @@ -694,7
>>> +707,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>>>      return 0;
>>>
>>>    out:
>>> -   kfree(adev->discovery.bin);
>>> +   kvfree(adev->discovery.bin);
>>>      adev->discovery.bin = NULL;
>>>      if ((amdgpu_discovery != 2) &&
>>>          (RREG32(mmIP_DISCOVERY_VERSION) == 4)) @@ -707,7 +720,7
>> @@
>>> static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
>>>    void amdgpu_discovery_fini(struct amdgpu_device *adev)
>>>    {
>>>      amdgpu_discovery_sysfs_fini(adev);
>>> -   kfree(adev->discovery.bin);
>>> +   kvfree(adev->discovery.bin);
>>>      adev->discovery.bin = NULL;
>>>    }
>>>
> 

