Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362D2C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 13:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40CB10E259;
	Mon, 19 May 2025 13:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pDkxk9PI";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6B210E255
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 13:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ceozw7uRR1L3wkkB+W9NEKTIXLJndX15/KR/aZVAE34p6MloKG1chKCkWBeKiXggeB3+VX8k3yHxwA6sjPBd7Ks7X0k7tNbPPitA2zJf6xTYtk+LUgSpHVFr4ibij2L6HtAqTdbxYkrx+FUJUvgsz4Qz7S4YfBpm2LJV8ZmL5Z3bLQPpWL67OE8t+RW3p44ZCh3fI1Crmliw4igcjn/bTI8ru+vc+IqIO4bNl4hDLWg9lDYaGgV60GCIiZRaApR/1J0R83yJxKwb3NvdeNctN/HiLfnS2MPg1LfW3hr9eMxAHnap5sGNxALvBLpl2H8x8Dh4R0uqIuRI4WZj65c7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4hPjzir3EZXVFyRskKavcC1phfYrkQU4RWZKhE+yLE=;
 b=mSGhaK5qdlNbKM6BKNvOMLXlFUWB9QlsnMhKrNV0zcis9xFxP8sJJxWgqSeeLXVVIWT5anB/mRgWpeZb87AYhH67F8dSM063GtS56limeNv2Al0FPjWHbWjMp3PNtyBPmrW45/ArMT2q2PTT27mZBAWa5F0osHSN9EmxY9nDD5mQpXD8/pPvN7mazcDuUOCmpcOMF08zE82PzhWtEM+EPJxkAmt8sHiNfZ2rpcwu7xIO/wG1vpwuUWQeWdRAdDRGeAKD8K7BZdN9UvqmEPljaPYUvqQ3fmKAvqNUQu34L9ijh283x2VsS9gJGPQHgMv6TeKz6O407Bn1ViuVm5caOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4hPjzir3EZXVFyRskKavcC1phfYrkQU4RWZKhE+yLE=;
 b=pDkxk9PIKh9drEb2mbmoGjCEKqBfcCgCYpHrm3ApLvctPq1/TN0RbacqpgykbHmYIkAP0aKGZCPvBUcloHFq2NoIVBSYw0el8fuL0YN2+SKYqpJVAw6usiBO72Sj0NFZnpofvmsml6NgYvt1IbKivb4Pz3MQD2AzIAqUb/X10yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 19 May
 2025 13:41:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 13:41:53 +0000
Message-ID: <2dc2344f-10a5-48b1-bda1-a32ecde7038c@amd.com>
Date: Mon, 19 May 2025 15:41:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] drm/amdgpu: update xgmi info and vram_base_offset
 on resume
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Lijo.Lazar@amd.com,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250519082038.21459-1-guoqing.zhang@amd.com>
 <20250519082038.21459-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250519082038.21459-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 8147c8f2-ae59-4e4d-bb06-08dd96dae9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVFDUWJvNEtQdVFxQTEzcWQyblRWNEJvZnBabFUzU3FWNU1SRVh1M0d0ODZ0?=
 =?utf-8?B?ZVlvSHlaVTNrbjF0d2tlK1oyTk1lWmc1cjlmditUQjRKWXBmYjNqQVo4a1lU?=
 =?utf-8?B?eGs0WW16K25LNDdaNXZjdW5Kam9qeWNJcFgvaU5DZENTWEJWb2ZXUWc2YTEx?=
 =?utf-8?B?Q1Q4QnV5ckJMdTNuZC9IeWIwbjRqR1lzU1FiM3k3S0I4WE9NYXNhM2Q3Z2RF?=
 =?utf-8?B?Y2E0M0hyZVg5RUtXbkxWRE9rdXVyZHM2TE13N1IvUjZzOWVjWGMyTDhTNDdt?=
 =?utf-8?B?NnNRaFdhZWV4Ykk2UGJ2R2RZT05hVThMZmh4VGFxTkdJS3ZRc3RyNUQzVUxP?=
 =?utf-8?B?akM3UVluQXFHQ0tjUncxQnZKNTFEeFVmT3FvRi9jdXdEcDZIc1QvVFRORjQv?=
 =?utf-8?B?dnBTRG5UaStNZm9WMk8rNUJwbEN3c2VVZVRlNHAyekEySE40L1doZ2g5eFY1?=
 =?utf-8?B?d1ltMGU1bE5lREw5U1V4TlBvRHU1MThlSW10RURkSWhtd0FvV2lJbGgxMVhH?=
 =?utf-8?B?U0tOREdRUmEzZVVNNSs4d0JQT0lobG9hUk82NFQvN09ZY3NLaWVWWXZMOXVL?=
 =?utf-8?B?YzZNS1JCNVdMaEZNSk5HLzZOUGNjVWtSNEJYNUdyYnh2OGtGTGpZeUZkalMz?=
 =?utf-8?B?VGhNYVhuVldlRytYUzZndVJSMTN2am5DZVVmNWxtUFhuaTAvSHF5akVWb21k?=
 =?utf-8?B?ejAwMWdhWjBOOWNzVmxSYWgvQTRTQm5xUnB4WXRnUzRNQy9CT1RVcmJBdlZn?=
 =?utf-8?B?Z0w2NnFFUVdReVRLVlZxRW9hYS8xUVpWcjROU2xscUMweHdUUS9LdC9hb0Ja?=
 =?utf-8?B?N3RhR2pPQTZRK1RHOGI1eVJIQndDUjMxazBaVXVYRUtxaDRxcGV6VlRZUHgw?=
 =?utf-8?B?Z2VtS1ZBRjVaeCt3eGJjNUNDWnFpVEx5Z0VHLzNiZEdVcGtQclVKUW9PVVE2?=
 =?utf-8?B?Q2VkSW96MGs5akc0K0Q4NWhnNXM5VGFaNTYwaVJNdjdWOU1uREx5TEd1L0ZI?=
 =?utf-8?B?Q2dKUjFscXpWc09yR25nY3lJdEFvcms3cUJjSkhwUlRVcmlCUFNObGhJUk1m?=
 =?utf-8?B?em1BYUFMT3pPVk1GUmhHWTFldGlyU2c0Ni9POEhtbnFhNnZBbjRVeVdpZ3VP?=
 =?utf-8?B?bDVtQkRlT2V4ZEtYM2IrSTdDSnp4WUlvdHRybWV3Q2NjazBJdjhDZlJHSTJh?=
 =?utf-8?B?RVlrL21DNUZkYmtSUDJ2YytoYmNKWGF5aEhSY0Y1YjZVWGFpTmdKVVZ1djNy?=
 =?utf-8?B?MXBxaWZ3bm9kUTVyZ3JMcHVBZkJOdVZTMlpTeWJxU0o4cEpDVm54ZnNhWnpj?=
 =?utf-8?B?SmdaUEpRanQyVDFTS2xYanMvcXJrSUxzK0lrWXJzMUtDM3laaXpqOS9sbjB1?=
 =?utf-8?B?ZkdyaW1ld21RcHNGbmRQZ0RXS2FKaXZRM1RieGljMHZYOHE1UnVUOUNpM2g1?=
 =?utf-8?B?ZXk2Y0FXZEVTdzh6T3MxQm05aTEvd2psNzJxWXA2cVZzTkF4VTZIZWNCd0N4?=
 =?utf-8?B?Qm9uRVFQY3NJampjUmpha2NJQ3piYXJ4RHJsUmpRTGdWdTVXZHZEQitaMlVx?=
 =?utf-8?B?SWh0cmI2NFZBYVpHdHNOUlVuK3VnbFlYWmtZTXk1ODMrS1ZvazFPWjBHSFRD?=
 =?utf-8?B?S1hrdEZvVkw1U0dwazN1UWt5RWhCNjE0ZjkzOVVQYU1uUWpRQUpqNEZqbllr?=
 =?utf-8?B?MDQ5bGRoKzA1eUw2aDJNbGd2bHdQUWhRYjNWNU5vcWZHSXowdVZmTVpmWVRE?=
 =?utf-8?B?OW5oTzVzK1dlQVlIK2FWajNudW1YdFJkRTJIUTlZWlUvZEJ4Q1dFMTZQUHFO?=
 =?utf-8?B?djc1eEowSnZ3TG9YRGZGR0lQaEhXOTRTSUlyL2JrSnd0NG9yemNyaGdsWTQv?=
 =?utf-8?B?ZWtXNWlmTm54Q3lrZDNBdFpQUHUxOVkzdFNkOEZNbTE0eW9CbGd1SmcwRC9S?=
 =?utf-8?Q?T3WUmYyKT0Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SExmQlNvZFRpYmRhTE5oQWkvc0ZSUFNqVFQvcHFsL2puWmlPYTdmbzZJbE1s?=
 =?utf-8?B?bjRRcEJlRHVROUczNzA5MVRVc3QwcW0vNGVqaWhUc3kxUjdYTlhMR2NQbDhI?=
 =?utf-8?B?UlUxU3RrSUZIeHhWaFB3ckY3SkY5SlN2SUNFQzRBMU11VnltWWVDcko0VmJ4?=
 =?utf-8?B?NzRESHhEaXJLSjJwMDVVTlhKTUYwTEpjSE81NDhUNzBXK2ZNUUd3T3grd3c3?=
 =?utf-8?B?S1ZrQ1hZd0RHOHpJbXFEMkpydlBoa2w1WmZOdllKbkJpTU9mTlgrUkVPRWtX?=
 =?utf-8?B?UWR4cEcwNlBMT0ZMSzhhYlRuZjgxakRTdzVzR1NiVERReUFYaFRMRHNiaEhU?=
 =?utf-8?B?ejBGMTNoa1JSbUh0U290VDd5UGJ2MjZGUHhPTmd3V1BTbUkwWmZhY2xZZjZV?=
 =?utf-8?B?TkZRc2dCbExEMjBZLy9iTXpIYTRxZWRZbExtZmE0R1BJV2lYVVhobmVrakla?=
 =?utf-8?B?S0JFUEwrOVRYb1gzZ1hxQ2s4L3JsZ0YxS2lyQ2ZiK25aQXp6MHNaa09SVE9B?=
 =?utf-8?B?TER3dGJnRUowVlIwK0ozS1pZQTFaemFpMHgxSTZrQnM0ODBDc0VSMWZGZEhl?=
 =?utf-8?B?V2NsN29DRU1kc3hTSEdUdGFyVnl0OUlpd2JoRXVNRWpjNHRpNmpVNUduYzY5?=
 =?utf-8?B?dWhxaDEzREtZblp6VURYUUY0OUwzRmR5T0psRXdEY2hSa0ZUcmppWWV6ME92?=
 =?utf-8?B?c1lUMlNnQXN4bWhNdUpiRzFNWnJldU1VSTN6VVN1Rms2SHE1UmsyODNCVzRi?=
 =?utf-8?B?c0wvYTZxYUFTMnl4d3MxUkxHdUFBTUQ0MjFxbFl2eVJwa3FXeWcwRmVMeWhz?=
 =?utf-8?B?dWZ0SFRJQVpSaC9CODI1UDdSTTVkbHJzczdGWXZ4b2dCNHo1RXlpRzd2cjJO?=
 =?utf-8?B?eDdvaDdqaWZyM3kzQmdycFBZejJ5M3l6NGtOVm5qYlM4b01KNzhFSVRTeVpi?=
 =?utf-8?B?dHBsbWV0cG1JdDdGZ1U4YnlTM1o3Q0FtWDkvTGF2ckpYVHd2NGo5cldnMEhr?=
 =?utf-8?B?bURvVFpOeXFSTGVOc2ZUYmRtR3R1eS9FbXkrT25VajZ5ZGhpQldxNi9hUFdn?=
 =?utf-8?B?N3NMWmFOU0RuaGhEUWpiWjNuMzdoSFk0d3RXVmpTc0hHOEVvUjhGS3duR3VW?=
 =?utf-8?B?RWZXNU1KVUE5T09DYmNtbnlacy9hMXRtZ3NCT1MyN1hsdVhldHh2Y04rQ1RP?=
 =?utf-8?B?UnlvWmxWelVHa1c4UFMxZldtZFQwOGlHVlUzbSt4SmNqcm93T0I2V3E2RDBm?=
 =?utf-8?B?MVJOOG1xS0JicWt5Q0NNalBXdG04YjNDbHIvMXZIcytKMGlCL2JFcnhORU5i?=
 =?utf-8?B?QnplaTg0V3NSWVJqWWRDVUdVcFFuTDluMzhaZHZPdVVIdTlHdUJhVVpKWCtO?=
 =?utf-8?B?MGkzaWw2RWRLbzNTemMzamhBNnhkZTg4N2lqWHhxMjU5ZStxSERMaENKLy9F?=
 =?utf-8?B?cmRvOUtsOUFUVEpRZzRRblhlejg2RTBPYm1zMThOMXhmVllPNGgyT3lZa3o5?=
 =?utf-8?B?a0xNSU5MVTVDWXptZ2g0OUlLNW1lZHp5T1BoOSsvd1dBOXBMZDVuRjkvaytI?=
 =?utf-8?B?ZEF4d1p0OVpkd0RYSjh4blp5NzdUNFM3MHNnT3RBQnlsZFZPaEVFQjhKL1hj?=
 =?utf-8?B?d0cwNndncmtySFVxNDZtSHhxdmp1SlhyNVNVMnVLYk10bE5mMFNFOVFkRHVU?=
 =?utf-8?B?QnI2Y3ZTZ1p4eFlOZmZhV1ZoSUlTaGFKSHhWQTNiOW4wQ0pIVjZ6c1orQ3RS?=
 =?utf-8?B?Q1lWS3QrUU9FbHBnbmZKNWRIVTAzWWVkVkFzcFZVcmpVdEoxd0toUE1ITVFr?=
 =?utf-8?B?Z0JRbTN6SGJTOVdMNDBjS3BObXoxRTRBaFRtTFZRUjFBOXRzUWNnY1ZSeEJU?=
 =?utf-8?B?d3BNOGdMcWFGZVpsL1B6UFlDejloRU5iZjF6K0x6bmZoWVh1ZmxyN1ZpbENB?=
 =?utf-8?B?V3F0VW5SNk5qVExVQ0ZLWit1b3BLY2x3UFlxb2VydVFsUXJNMmxJVy9Fb3M0?=
 =?utf-8?B?bDQ4R2UrSEdWNUp6NU5QSVhlSVBOb3BINDBtZnVySko5eDJkdjNlNWhMbDR0?=
 =?utf-8?B?ZWRrNmRZNFJuN3BLVHo1am42YVN6KzYzNWlkY0JzSVk4M0NLcGk5ekhteG9x?=
 =?utf-8?Q?PFyKZ7v+QPfYT6wkpgFUOecwF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8147c8f2-ae59-4e4d-bb06-08dd96dae9c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:41:53.3860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Io/iIEj3HwWq3/9KHuvtr9GVtRcFIw/8pReml6u1ULTFbMqjyY19UMMXbDwLVSQA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF
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

On 5/19/25 10:20, Samuel Zhang wrote:
> For SRIOV VM env with XGMI enabled systems, XGMI physical node id may
> change when hibernate and resume with different VF.
> 
> Update XGMI info and vram_base_offset on resume for gfx444 SRIOV env.
> Add amdgpu_virt_xgmi_migrate_enabled() as the feature flag.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 +++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d477a901af84..e5bb46effb6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2732,6 +2732,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  	if (!amdgpu_device_pcie_dynamic_switching_supported(adev))
>  		adev->pm.pp_feature &= ~PP_PCIE_DPM_MASK;
>  
> +	adev->virt.is_xgmi_node_migrate_enabled = false;
> +	if (amdgpu_sriov_vf(adev)) {
> +		adev->virt.is_xgmi_node_migrate_enabled =
> +			amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
> +	}
> +
>  	total = true;
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
>  		ip_block = &adev->ip_blocks[i];
> @@ -5040,6 +5046,28 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  }
>  
> +static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
> +{
> +	int r;
> +	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
> +
> +	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
> +		return 0;
> +
> +	r = adev->gfxhub.funcs->get_xgmi_info(adev);
> +	if (r)
> +		return r;
> +
> +	dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
> +		prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
> +
> +	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> +	adev->vm_manager.vram_base_offset +=
> +		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_device_resume - initiate device resume
>   *
> @@ -5061,6 +5089,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  			return r;
>  	}
>  
> +	r = amdgpu_virt_resume(adev);
> +	if (r)
> +		goto exit;
> +
>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>  		return 0;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index df03dba67ab8..532b92628171 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -295,6 +295,9 @@ struct amdgpu_virt {
>  	union amd_sriov_ras_caps ras_telemetry_en_caps;
>  	struct amdgpu_virt_ras ras;
>  	struct amd_sriov_ras_telemetry_error_count count_cache;
> +
> +	/* hibernate and resume with different VF feature for xgmi enabled system */
> +	bool is_xgmi_node_migrate_enabled;
>  };
>  
>  struct amdgpu_video_codec_info;
> @@ -376,6 +379,10 @@ static inline bool is_virtual_machine(void)
>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
>  #define amdgpu_sriov_is_mes_info_enable(adev) \
>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
> +
> +#define amdgpu_virt_xgmi_migrate_enabled(adev) \
> +	((adev)->virt.is_xgmi_node_migrate_enabled)
> +
>  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>  void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>  int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);

