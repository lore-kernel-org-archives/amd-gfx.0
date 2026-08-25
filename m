Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FA5C61DBE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 14:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DCE10EAAF;
	Tue, 25 Aug 2026 14:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M5PmAUF9";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBBB10EAAF
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 14:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjA99qrs6oM5B54QYnJtZEz1fX1aCUndxRBgvLSPTM8DX6yArHlJh9C/OEIk8cFeuxI2vBaaSCkdb6KabEm+Ztt3M8y6lYN2LrGTD9AeJlM3RuSNeYEkNLDKtFK7k7quWK0hV03COn45dP/xdjwY9JM7ORJEgqdjJNQMAXQIlFdIiPlp5PiYof/wd2//3W8bcCDwg1DU/lrMfrgY9T1vBjXQaG8zzd2xwUTkDNkY5FPVqNEIItO+3ICTop02JyPkjNaips0i+s7r4vhezvkmmw6CWZFcQn8R7m+rUo3NrKnZWeRbySumt1x0IFzBHvb6wykmVn0ZQXks1btxdOkRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE5qMMJ8LfdwCH9IanKjFLea9j3SxPXy8X65JDKpJ7s=;
 b=JfVPJt3a7Ira9bUilNru4Tpps+yk+4AQ2Zc5AH9+P45oZfesyDCrHkFmX3PhHfEeLwENqCyMEA+nXbgXYALyMDzmJkBGlix0WvZMPdlGQH1pBV0Y2/Xbr/Pctg35+3m2Q6MN5AkKKJ4F35XvoqCLsteyTFVfDwgVSbSvV4MR1jcVgHBChl/FFXLyoMWaMd3L1wpwp7ZMEFWCiDWGjfhg5S2LiQlPo675+DKdXI02PxLbEDHW47LFf/5f9EdSrVCP6+dgS2tCX7537y7lu5ssjSNkX9OyizWvb1c5CB2Asss+gPobAkmfXPt+QvBRnW8jcwTpgRGJEdxIRcmLAB/zRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE5qMMJ8LfdwCH9IanKjFLea9j3SxPXy8X65JDKpJ7s=;
 b=M5PmAUF9uoyrov0f1+CcD1ppa9IlaYnLAy2t7h8KlhWL0kZmNcxjXDlh33LKNXyCAIQ9o88NeOdOsXOUzZGUn/NzIsyuJTiiVaotbsJ/lV44e6Ks39ZtVl+SmOluy94niEsKPbHeZ1A/vLnzPvkzmO5D2D0zLHTpY0je8QiTlxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Tue, 25 Aug
 2026 14:45:43 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::3889:6812:bb6d:7411]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::3889:6812:bb6d:7411%6]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 14:45:43 +0000
Content-Type: multipart/alternative;
 boundary="------------inETUtEr9Vf9vbPaIEZtU6Q1"
Message-ID: <d584c6b5-dfe9-4f77-88bf-89351559dcdb@amd.com>
Date: Tue, 25 Aug 2026 10:45:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/95] Add UALink instrastructure series 1
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260821193458.808626-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YQZPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::15) To CH0PR12MB5156.namprd12.prod.outlook.com
 (2603:10b6:610:bb::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5156:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: d0023cbb-3dfa-458e-01bd-08df02b7876a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003|11063799006|5023799004|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: z9RWibc3yN4xvk38Dfi/Jinv/6RNppnvMWVXpbAChT00ePS3YC2+5s5ItU5zxcJB+gfUb/eTymtqYUBroZfZbzkd8kIZ2ScDaPl9K2bpyxvl+KalODsOHU8t7/uxbiMG1t/nT5HWLI5IUdKVRChhPucRxTii5fBxa05aic8Zz1nVctBbJmSjXFDm3KbJtWaua8ZzO7RauOFaCmgxR4qgCi5OFE4BiUrgT2LlQJ285Q5sWHnLiUXVCxZjsK4ZjRKtjPopuZciweV3U1wE5k7+Wn7ANMzFbgT+ZQ1H4B17F+HPelZWuMscMQjdQkAGaibVlrOaxSeMeFMQSrMfldQLqONOUkQBNlOdPdZWywdv7lm8+247Dbu8Yz8AEKNCtOXoK0jZxTkm1sN+IsuoJAoXcC4V678Th+EWN6U0ODM5W5zj8jO6hx4oabzoZFHN7FRgpU0kUd/qGrwhxrHcG4CUOvjDRlFAcRVQcPrL2v6T2XPqzhNCna3x1EcCgtketprbAP+0kIvM/Ake316jqMk6Mw19pBCOdbWlhE+BfJx5ZYuhJVH2qhgjTYkppgemtaRSWnmy/EdxTbFvZS/9q6Jw4f9Z3BlyS3BXZ9wUuTTSV7hSLpl8NulNwGZS7xNzIojPr4nan2Gc4gkNtwT5cakDKo+zq4+dyYZMQS6j0Ac2L6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(5023799004)(8096899003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dsdytnSzI2Y1VUU3VqcXpwUzhRYlg3cFBjVWpNSVd5NG1oVW0vWUczNUZI?=
 =?utf-8?B?TU55MzdPQkg1aWZ6QlAxWUlVMXZTeS9PTE0xWm5BOHBSaWFSZE1EdDBaazI2?=
 =?utf-8?B?OTNidEx3VWFlMXVXaDdVQ1FRNWhLZCtLTWVJRkhDdW1vRno0Sk1ITm1PNzZH?=
 =?utf-8?B?QzdsYmVqNTZlNTQ2M1Y2eUJKdVJpNTlCK1pJUUoybHpQRFR0Y2hyVURsdG4r?=
 =?utf-8?B?L3RQY3BUSzZic2xFekpJMURDa2dMV1ZkQTF5ZjBwV0htUzZ0WU9DamFBUWlh?=
 =?utf-8?B?UzZGckttU0pzOVJidElJWFpDaldEZkNZSHRoT0JJd1VlTGtDWEVHTE1LWm0z?=
 =?utf-8?B?QlNibDdxRDdMKzVrd1llVE9hYXl4RkpIRVArK1Q5dU81ODJiR01xR09CZm5M?=
 =?utf-8?B?REhxTExKcDJ0c3QwT2ozQ3VMczVtakZ6enVXdklOZHZSM2RFVDVLVWV2R09H?=
 =?utf-8?B?WlZoQlNSRVVXbDhicms4ay9CQXl3am4zNjhxN1dRTE9lV2hNL051MW4wSGE0?=
 =?utf-8?B?dFpNM1ZSZlVPSTliOVA4UkdJZFJtY2dZcnplRno1YmFkSGZEek5rTHBURjFj?=
 =?utf-8?B?TVd0L2JsYXlYWVE1ZGlWOWFKOFFVT3FzdEYycTVSRzhkQWtKbFloQ0d4VGNy?=
 =?utf-8?B?bHZPTFhZYlhoV3psaFZmejZvMEpFczJ4OFVVTDZNNlp2aERxeGRQY1E5Mi85?=
 =?utf-8?B?Y1gvQjBrdFVVM1RhbnFNQ3l1OTF2VGhxUlZPTVloN0QrRXBrSWFPUHFuTHZ1?=
 =?utf-8?B?VXdpQmtwZmMyNDhkNzYwdWxHN0taME5IU012WUZXZWhhTjRKbVlOSGFJTmZH?=
 =?utf-8?B?dHAwNG9GMEFFRXgzVTRuY1BvYlhFbkhJTStVQWdGUnlLRjV3TEZLRyt3Ukxu?=
 =?utf-8?B?THJ1ekdVTXdHT2JTUWpWYXlUdjhyZU4zcCtxMmR1ZVZrcHVVRDlwQWlBN05z?=
 =?utf-8?B?RHVCbGJFUjl5ZXQ1aGx2amlkdGZ4VldEcUJjYm1hcFJORU9xUVE0eW11Zlgy?=
 =?utf-8?B?RGQzNEd5RXpPSGwwb2JiVlBqdjdRV2NvUmV6NHhWMFVCNXd2bUNJZUxETFZQ?=
 =?utf-8?B?OHRDL015SzFaTFdyNVJndVo4NEFJbGJZV0QrR1g3dGp5UE1mcHFQdlNObEpr?=
 =?utf-8?B?dmhieFRQQU1zL21jWTBkS3Y2RlRiQVR2a2RWNmZ6Ny9Ba2RrSEMxVjh0UVpH?=
 =?utf-8?B?TzFVWWE5VGhyc0FUMHI4Z0JhalJtSmttZ3Y1RUY1aTFOR25tcHY5bHFWWTVp?=
 =?utf-8?B?WXhOcUlTcU9LeFhSU1lsZm9GbXRIam5ZR0UwM1pxa1hSRm5ldWVYNWE2RWhn?=
 =?utf-8?B?aUpGaE1lbFVCVjVOZnFmNERUQWtOLzZwYjg5VEpvck5mWkQ0a2xKaDNkTzJC?=
 =?utf-8?B?amx2SmtlTG8vS2dPcEhtaXZXaFFmcFFlMEt3QjRaVlIvbE9EU2Vld0dDWlFw?=
 =?utf-8?B?cURzTXRMUnlYbG1YR0ZCWk1EK1hGZW5HWndwck15UDJPQkVzQUtRc3NEUDF3?=
 =?utf-8?B?MzdvVHl6elVad2MyaGtTdFpYQ1h5SEhOUStJZHRiWklkTnNOM2NpSnJhdFYy?=
 =?utf-8?B?NnpRa3JnQzZVK3ZLU1FxblZuYUVQVnVMbmUrTWF6TnVTQUVFamFNcExJbmlU?=
 =?utf-8?B?QldIM0hPbXJBNVNDdXlRck5PMHN5eVRxOVV2VGVnNHM4OE5Ec2VOQ3NPRllh?=
 =?utf-8?B?Mk1Tc1RENURNS2NRcDZPb25lamZ0Z0FYU0t5N3lvY1VWMEQrQytHOWY3ZFc3?=
 =?utf-8?B?WGE3ZkRvUGdsRk9JM0U3cDdPYWZpMkZJS0dISzNkZmpIcHV1TTBia0ptVVlN?=
 =?utf-8?B?SDhwV21MandtZStXKy9qbzUzaXdyNmJDODFVRDRTUkZhSFI0Y2NDSXRYT1Rs?=
 =?utf-8?B?cjQxQlRDayt3K1dYUmtjM01IamM1RStZRXlyMmwvOENSeWdEcHBIVDNxdXdK?=
 =?utf-8?B?SnFoTlIrY3NrYzFjVzlLUjFPMU1qQkFuQWJJVjljbUgrRmZXYW5UaUNOd2Fn?=
 =?utf-8?B?SnBLMTZvS3diekhUMG1kTzF0QnN0dE1lL3dNTFhSSi9pQVA2VTZESGlTaDhY?=
 =?utf-8?B?RW9wSWV4N29HdmNmRGh4WW5lRkFLZWVTT255NjRMa21JQm1rcXl3R0tKbk4x?=
 =?utf-8?B?MVVmcGprSTRnWW9ZcGhvTVhRTTlTMFBpREdndnQvakV2VHZ4MWJlYlZwam0w?=
 =?utf-8?B?MkFjTE1RUTR6c0pEVmk2VW1NYUZLT2ZPNHFMK1lWaGF6TUJSOUxmS1BpWkVk?=
 =?utf-8?B?S1ZNQmgwMXAvRUZJR2dJOGNGM1lWRThnVUFuYjRqNnUrN1dlUk9yemNaU2Jk?=
 =?utf-8?Q?2w1nsQHtHYAhrBQQf7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0023cbb-3dfa-458e-01bd-08df02b7876a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:45:43.2452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ7iQlrnr2Q7vnnmpCHN/ujdDYNEiIUyDuhU/IlTmFDi3C0+rjbG0kMJ/eGD++LZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627
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

--------------inETUtEr9Vf9vbPaIEZtU6Q1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Two nitpicks below.

Regards,
Philip

On 2026-08-21 15:33, Alex Deucher wrote:
> This adds the core infrastructure for supporting UALink (Ultra Accelerator Link)
> connected scale up pods. I've split this into two series, one to add the core
> infrastructure, and one to expose the new IOCTL interface and add the
> documentation to avoid spamming the larger audience with the implemenation
> defails.  This is the first series.
>
> This implements UALoE (UALink over Ethernet). An overview of the complete
> solution can be found here:
> https://www.amd.com/en/products/rackscale-solutions/helios.html
>
> Overview
>
> Connected GPUs in a pod can directly access the remove memory on another
s/remove/remote/
> GPU over UALink.  Unlike RMDA, there is no copy involved; it is direct
> loads/stores over the fabric.  Shared memory can only be accessed by
> a remote GPU if the memory was exported and the importer has been authorized.
> For the memory to be shared, it must be part of a unified physical
> address space shared between nodes.  This address space is called NPA (Nework
> Physical Address) space.  This address space is partitioned between
> the GPUs so that each GPU has it's own segment of the address space in which
> to export its memory.  Each GPU maintains a dedicated set of page tables
> for their NPA space similar to GPUVM.
>
> Exported memory is not pinned.  The exporter may need to move memory
> or make it unavailable to the importers.  This is handled via remote
> TLB shootdowns on the exporter in the case of TTM evictions or MMU notifiers and
> remote presense checks with retry on the importer.
>
> To access remote memory, the driver can map NPA addresses into its per
> process GPUVM page tables just like local memory.  Applications use
> opaque handles to represent remote memory.  GPUs in a pod communicate
> with eachother directly to exchange NPA addresses between importers
s/eachother/each other/
> and exporters.  If a node goes offline or is reset, their peers will
> clean up any remaining refrences that are lost when that happens.
>
> User interface
>
> Export Memory
>
> To export memory, a handle must be created for an allocation
> that can be shared with another node in the pod.  To do this
> the exporter calls the GEM UALink IOCTL with the GEM handle
> to the buffer it wants to export.  The IOCTL returns a
> unique handle which can be shared with the remote host.
>
> Import Memory
>
> To import the memory, the handle from the remote node must be converted
> from a unique handle to a local GEM object which represents the local reference
> to the NPA space on the importer.  If the memory has already been
> imported, it just returns a new reference to the existing object.  If not,
> the importer queries the exporter to get the NPA address.  Once it has that
> the importer can create a dma-buf to represent the NPA space used by the
> allocation and that is returned to the application.
>
> Alex Sierra (1):
>    drm/amdgpu: log remote memory MTYPE for GC 12.1.0
>
> Felix Kuehling (17):
>    drm/amdgpu: Add sysfs API for UALink information
>    drm/amdgpu: Add sysfs API for UALink physical pod setup
>    drm/amdgpu: Add sysfs API for UALink virtual pod config
>    drm/amdgpu: Add sysfs API for UALink station configuration
>    drm/amdgpu: Implement PSP cmd UAL_GET_CONFIG
>    drm/amdgpu: Query initial UALink config from PSP
>    drm/amdgpu: Implement PSP cmd UAL_SET_PPOD_CONFIG
>    drm/amdgpu: Set physical pod configuration to PSP
>    drm/amdgpu: Implement PSP cmd UAL_SET_VPOD_CONFIG
>    drm/amdgpu: Set virtual pod configuration to PSP
>    drm/amdgpu: Implement PSP cmd UAL_SET_STATION_CONFIG
>    drm/amdgpu: Set UALink station config to PSP
>    drm/amdgpu: Implement PSP cmd UAL_SET_NPA_CONFIG
>    drm/amdgpu: Enable/disable NPA address translation using PSP
>    drm/amdgpu: Prevent double-free of drm_exec
>    drm/amdgpu: Pin page tables in NPA VMs
>    drm/amdgpu: Initialize NPA PT/PDs to noretry
>
> Gangliang Xie (1):
>    drm/amdgpu: add handler for nHT error
>
> Harish Kasiviswanathan (2):
>    drm/amdgpu: Add helper function to check psp xgmi ta
>    drm/amdgpu: Add ual_config_state to ual_get_config
>
> Jinzhou Su (1):
>    drm/amdgpu: Fix NULL pointer issue during ualink init
>
> Le Ma (1):
>    drm/amdgpu: extend PSP command polling sleep range
>
> Lijo Lazar (15):
>    drm/amdgpu: Add psp ualink command interfaces
>    drm/amdgpu: Fetch asp ualink interface version
>    drm/amdgpu: Separate out ualink init sequences
>    drm/amdgpu: Add ualink as separate ip block
>    drm/admgpu: Seggregate ualink nht messaging
>    drm/amdgpu: Assign accel state based on ASP config
>    drm/amdgpu: Drop duplicate vpod check functions
>    drm/amdgpu: Add support to send ASP completion
>    drm/amdgpu: Add handlers for ualink notifications
>    drm/amdgpu: Improve ualink state transitions
>    drm/amdgpu: Use uniform logic for inband/sideband
>    drm/amdgpu: Add name for ualink ip block
>    drm/amdgpu: Move ualink ip version related changes
>    drm/amdgpu: Add hw_fini for ualink
>    drm/amdgpu: Expose ualink info under each xcp
>
> Mukul Joshi (42):
>    drm/amdgpu: Add UALink manager core infrastructure
>    drm/amdgpu: Add a new NPA Address space
>    drm/amdgpu: Add address allocator for NPA addresses
>    drm/amdgpu: Initialize VM for NPA addr management
>    drm/amdgpu: Rework VMID reservation logic
>    drm/amdgpu: Reserve VMID for NPA VM
>    drm/amdgpu: Use reserved VMID for NPA VM
>    drm/amdgpu: Enable UALink Manager when pod becomes active
>    drm/amdgpu: Create a drm client for UALink NPA BOs
>    drm/amdgpu: Control NPA DMA-buf importing
>    drm/amdgpu: Add ualink handle to BOs
>    drm/amdgpu: Implement UALink handle export
>    drm/amdgpu: Add connection state management
>    drm/amdgpu: Implement UALink handle import ioctl
>    drm/amdgpu: Implement mechanism to revoke exported memory
>    drm/amdgpu: lock UALink import invalidation via drm_exec
>    drm/amdgpu: Cleanup exported UALink handles
>    drm/amdgpu: Cleanup imported UALink handles
>    drm/amdgpu: Handle connection reset
>    drm/amdgpu: Setup PTE mappings for NPA addresses
>    drm/amdgpu: Add handling for remote interrupts
>    drm/amdgpu: Send TLB shootdown on exported memory unmap
>    drm/amdgpu: Handle local GPUs in UALink import
>    drm/amdgpu: Add debugfs to drop UALink protocol messages
>    drm/amdgpu: Temporarily disable sending remote TLB shootdowns
>    drm/amdgpu: Temporarily Flush TLB on NPA mapping always
>    drm/amdgpu: fix NPA-RELEASE race in UALink exporter cleanup
>    drm/amdgpu: initialize UALink importer node list head
>    drm/amdgpu: Fix initialization flags for UALink XAs
>    drm/amdgpu: fix dma_buf leak in UALink exporter cleanup
>    drm/amdgpu: Fix uninitialized fence in UALink NPA unmap
>    drm/amdgpu: Use vm->last_update fence in UALink NPA unmap paths
>    drm/amdgpu: always use MTYPE_UC for remote memory on GFX 12.1
>    drm/amdkfd: program compute MQD coherent_aql_mtype on GFX 12.1
>    drm/amdgpu: Fix GART and SDMA entity leak on vPod reconfiguration
>    drm/amdgpu: Add UALink diagnostic logging for vpod commit/activation
>    drm/amdgpu: Handle UALink vPod reconfiguration while ACTIVE
>    drm/amdgpu: Cleanup UALink XA entries on manager stop
>    drm/amdgpu: Handle concurrent UALINK handle import race
>    drm/amdgpu: create UALink NPA import BO directly in the NPA domain
>    drm/amdgpu: add mtype_remote module parameter
>    drm/amdgpu: Honor mtype overrides for NPA remote memory
>
> Philip Yang (15):
>    drm/amdgpu: Fix UALink vPod double-activation
>    drm/amdgpu: Add UALink remote state structures and API declarations
>    drm/amdgpu: Add UALink NPA address layout helpers
>    drm/amdgpu: Add UALink NPA address computation for ring buffers
>    drm/amdgpu: Add UALink NPA VM mapping for ring buffers
>    drm/amdgpu: Add UALink SDMA scheduler entities
>    drm/amdgpu: Add UALink GART helpers for NPA address access
>    drm/amdgpu: Add UALink ring buffer allocation and firmware init
>    drm/amdgpu: Add UALink remote command packets and SDMA dispatch
>    drm/amdgpu: Add UALink firmware writeback address configuration
>    drm/amdgpu: Add UALink cross-GPU TLB shootdown and remote interrupt
>    drm/amdgpu: Add UALink software init, teardown, and reset
>    drm/amdgpu: Add UALink IH ring and enable interrupt
>    drm/amdgpu: UALink use LSDMA to send remote interrupt command
>    drm/amdgpu: Increase UALink soft ring size
>
>   drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   14 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   21 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |    5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    7 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |    1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |   33 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h       |   27 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h        |    1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        |    1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   17 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h       |    7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   11 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |    5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  280 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   27 +
>   .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |    1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   17 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |    4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 6174 +++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h    |  421 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   44 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |    4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   29 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |    6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h       |    7 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |   51 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |    2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |    2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |    4 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    5 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   26 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        |   98 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h        |    1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |    6 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |    6 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |    6 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |    6 +
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |    8 +
>   drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  162 +
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c      |   48 +-
>   drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |    6 -
>   drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c      |  143 +
>   drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h      |   30 +
>   .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |    7 +
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |    8 +-
>   drivers/gpu/drm/amd/include/amd_shared.h      |    2 +
>   .../ivsrcid/mpnht/irqsrcs_mpnht_15_0.h        |   30 +
>   drivers/gpu/drm/amd/include/v12_structs.h     |    2 +-
>   include/drm/ttm/ttm_resource.h                |    2 +-
>   include/uapi/drm/amdgpu_drm.h                 |    6 +
>   58 files changed, 7782 insertions(+), 69 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h
>   create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h
>

--------------inETUtEr9Vf9vbPaIEZtU6Q1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Two nitpicks below.<br>
    <br>
    Regards,<br>
    Philip<br>
    <br>
    <div class="moz-cite-prefix">On 2026-08-21 15:33, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260821193458.808626-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">This adds the core infrastructure for supporting UALink (Ultra Accelerator Link)
connected scale up pods. I've split this into two series, one to add the core
infrastructure, and one to expose the new IOCTL interface and add the
documentation to avoid spamming the larger audience with the implemenation
defails.  This is the first series.

This implements UALoE (UALink over Ethernet). An overview of the complete
solution can be found here:
<a class="moz-txt-link-freetext" href="https://www.amd.com/en/products/rackscale-solutions/helios.html">https://www.amd.com/en/products/rackscale-solutions/helios.html</a>

Overview

Connected GPUs in a pod can directly access the remove memory on another</pre>
    </blockquote>
    s/remove/remote/
    <blockquote type="cite" cite="mid:20260821193458.808626-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
GPU over UALink.  Unlike RMDA, there is no copy involved; it is direct
loads/stores over the fabric.  Shared memory can only be accessed by
a remote GPU if the memory was exported and the importer has been authorized.
For the memory to be shared, it must be part of a unified physical
address space shared between nodes.  This address space is called NPA (Nework
Physical Address) space.  This address space is partitioned between
the GPUs so that each GPU has it's own segment of the address space in which
to export its memory.  Each GPU maintains a dedicated set of page tables
for their NPA space similar to GPUVM.

Exported memory is not pinned.  The exporter may need to move memory
or make it unavailable to the importers.  This is handled via remote
TLB shootdowns on the exporter in the case of TTM evictions or MMU notifiers and
remote presense checks with retry on the importer.

To access remote memory, the driver can map NPA addresses into its per
process GPUVM page tables just like local memory.  Applications use
opaque handles to represent remote memory.  GPUs in a pod communicate
with eachother directly to exchange NPA addresses between importers</pre>
    </blockquote>
    s/eachother/each other/
    <blockquote type="cite" cite="mid:20260821193458.808626-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
and exporters.  If a node goes offline or is reset, their peers will
clean up any remaining refrences that are lost when that happens.

User interface

Export Memory

To export memory, a handle must be created for an allocation
that can be shared with another node in the pod.  To do this
the exporter calls the GEM UALink IOCTL with the GEM handle
to the buffer it wants to export.  The IOCTL returns a
unique handle which can be shared with the remote host.

Import Memory

To import the memory, the handle from the remote node must be converted
from a unique handle to a local GEM object which represents the local reference
to the NPA space on the importer.  If the memory has already been
imported, it just returns a new reference to the existing object.  If not,
the importer queries the exporter to get the NPA address.  Once it has that
the importer can create a dma-buf to represent the NPA space used by the
allocation and that is returned to the application.

Alex Sierra (1):
  drm/amdgpu: log remote memory MTYPE for GC 12.1.0

Felix Kuehling (17):
  drm/amdgpu: Add sysfs API for UALink information
  drm/amdgpu: Add sysfs API for UALink physical pod setup
  drm/amdgpu: Add sysfs API for UALink virtual pod config
  drm/amdgpu: Add sysfs API for UALink station configuration
  drm/amdgpu: Implement PSP cmd UAL_GET_CONFIG
  drm/amdgpu: Query initial UALink config from PSP
  drm/amdgpu: Implement PSP cmd UAL_SET_PPOD_CONFIG
  drm/amdgpu: Set physical pod configuration to PSP
  drm/amdgpu: Implement PSP cmd UAL_SET_VPOD_CONFIG
  drm/amdgpu: Set virtual pod configuration to PSP
  drm/amdgpu: Implement PSP cmd UAL_SET_STATION_CONFIG
  drm/amdgpu: Set UALink station config to PSP
  drm/amdgpu: Implement PSP cmd UAL_SET_NPA_CONFIG
  drm/amdgpu: Enable/disable NPA address translation using PSP
  drm/amdgpu: Prevent double-free of drm_exec
  drm/amdgpu: Pin page tables in NPA VMs
  drm/amdgpu: Initialize NPA PT/PDs to noretry

Gangliang Xie (1):
  drm/amdgpu: add handler for nHT error

Harish Kasiviswanathan (2):
  drm/amdgpu: Add helper function to check psp xgmi ta
  drm/amdgpu: Add ual_config_state to ual_get_config

Jinzhou Su (1):
  drm/amdgpu: Fix NULL pointer issue during ualink init

Le Ma (1):
  drm/amdgpu: extend PSP command polling sleep range

Lijo Lazar (15):
  drm/amdgpu: Add psp ualink command interfaces
  drm/amdgpu: Fetch asp ualink interface version
  drm/amdgpu: Separate out ualink init sequences
  drm/amdgpu: Add ualink as separate ip block
  drm/admgpu: Seggregate ualink nht messaging
  drm/amdgpu: Assign accel state based on ASP config
  drm/amdgpu: Drop duplicate vpod check functions
  drm/amdgpu: Add support to send ASP completion
  drm/amdgpu: Add handlers for ualink notifications
  drm/amdgpu: Improve ualink state transitions
  drm/amdgpu: Use uniform logic for inband/sideband
  drm/amdgpu: Add name for ualink ip block
  drm/amdgpu: Move ualink ip version related changes
  drm/amdgpu: Add hw_fini for ualink
  drm/amdgpu: Expose ualink info under each xcp

Mukul Joshi (42):
  drm/amdgpu: Add UALink manager core infrastructure
  drm/amdgpu: Add a new NPA Address space
  drm/amdgpu: Add address allocator for NPA addresses
  drm/amdgpu: Initialize VM for NPA addr management
  drm/amdgpu: Rework VMID reservation logic
  drm/amdgpu: Reserve VMID for NPA VM
  drm/amdgpu: Use reserved VMID for NPA VM
  drm/amdgpu: Enable UALink Manager when pod becomes active
  drm/amdgpu: Create a drm client for UALink NPA BOs
  drm/amdgpu: Control NPA DMA-buf importing
  drm/amdgpu: Add ualink handle to BOs
  drm/amdgpu: Implement UALink handle export
  drm/amdgpu: Add connection state management
  drm/amdgpu: Implement UALink handle import ioctl
  drm/amdgpu: Implement mechanism to revoke exported memory
  drm/amdgpu: lock UALink import invalidation via drm_exec
  drm/amdgpu: Cleanup exported UALink handles
  drm/amdgpu: Cleanup imported UALink handles
  drm/amdgpu: Handle connection reset
  drm/amdgpu: Setup PTE mappings for NPA addresses
  drm/amdgpu: Add handling for remote interrupts
  drm/amdgpu: Send TLB shootdown on exported memory unmap
  drm/amdgpu: Handle local GPUs in UALink import
  drm/amdgpu: Add debugfs to drop UALink protocol messages
  drm/amdgpu: Temporarily disable sending remote TLB shootdowns
  drm/amdgpu: Temporarily Flush TLB on NPA mapping always
  drm/amdgpu: fix NPA-RELEASE race in UALink exporter cleanup
  drm/amdgpu: initialize UALink importer node list head
  drm/amdgpu: Fix initialization flags for UALink XAs
  drm/amdgpu: fix dma_buf leak in UALink exporter cleanup
  drm/amdgpu: Fix uninitialized fence in UALink NPA unmap
  drm/amdgpu: Use vm-&gt;last_update fence in UALink NPA unmap paths
  drm/amdgpu: always use MTYPE_UC for remote memory on GFX 12.1
  drm/amdkfd: program compute MQD coherent_aql_mtype on GFX 12.1
  drm/amdgpu: Fix GART and SDMA entity leak on vPod reconfiguration
  drm/amdgpu: Add UALink diagnostic logging for vpod commit/activation
  drm/amdgpu: Handle UALink vPod reconfiguration while ACTIVE
  drm/amdgpu: Cleanup UALink XA entries on manager stop
  drm/amdgpu: Handle concurrent UALINK handle import race
  drm/amdgpu: create UALink NPA import BO directly in the NPA domain
  drm/amdgpu: add mtype_remote module parameter
  drm/amdgpu: Honor mtype overrides for NPA remote memory

Philip Yang (15):
  drm/amdgpu: Fix UALink vPod double-activation
  drm/amdgpu: Add UALink remote state structures and API declarations
  drm/amdgpu: Add UALink NPA address layout helpers
  drm/amdgpu: Add UALink NPA address computation for ring buffers
  drm/amdgpu: Add UALink NPA VM mapping for ring buffers
  drm/amdgpu: Add UALink SDMA scheduler entities
  drm/amdgpu: Add UALink GART helpers for NPA address access
  drm/amdgpu: Add UALink ring buffer allocation and firmware init
  drm/amdgpu: Add UALink remote command packets and SDMA dispatch
  drm/amdgpu: Add UALink firmware writeback address configuration
  drm/amdgpu: Add UALink cross-GPU TLB shootdown and remote interrupt
  drm/amdgpu: Add UALink software init, teardown, and reset
  drm/amdgpu: Add UALink IH ring and enable interrupt
  drm/amdgpu: UALink use LSDMA to send remote interrupt command
  drm/amdgpu: Increase UALink soft ring size

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   21 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h       |   27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h        |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h       |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  280 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   27 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 6174 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h    |  421 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h       |    7 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |   51 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |    2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |    4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    5 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   26 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        |   98 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h        |    1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |    6 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |    6 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |    6 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |    6 +
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |    8 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  162 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c      |   48 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |    6 -
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c      |  143 +
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h      |   30 +
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |    7 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |    8 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |    2 +
 .../ivsrcid/mpnht/irqsrcs_mpnht_15_0.h        |   30 +
 drivers/gpu/drm/amd/include/v12_structs.h     |    2 +-
 include/drm/ttm/ttm_resource.h                |    2 +-
 include/uapi/drm/amdgpu_drm.h                 |    6 +
 58 files changed, 7782 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------inETUtEr9Vf9vbPaIEZtU6Q1--
