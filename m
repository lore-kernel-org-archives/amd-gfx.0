Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62463CAC5B9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 19:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09F610E2CC;
	Thu, 25 Sep 2025 19:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T/BBsS/G";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F7910E2CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 19:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHBWaIl9G3Jo+qmVjaoQfI8VVVKoEkTZuxl7U/k3RG8+NC+O/3dX1rJPVPwPOcXCAPwAGncB0cqhNoog77ksjap0fDDT+w4x0RoLpuv9JaYo0H+2IsFBi4Yvx0w6k5uzQqw4SCYb2ubHqsRN/2LNKS9+YDGPYyhHvE2SxFkxFfZVRRPbKmqQpYJ5E9tZW1SNwWSeQnDer7iF5tZPclLVFGxewB2BV7mABlfRvt/pSdZ4OLOdtrn2KJ1U5/xVo4IDtRr0v78Ot5cswmoqYPIbd6l3Nh1XWMUsonKuTlSjhLsXaJqs5mGlKjhRpDQRCQp5HG5eAGyTSU6HRbGTicd1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fmUx5FTKMFia/MHLLLkHr5VPw+7imF3ijjNgfcNls8=;
 b=YezXDcBu5TKwkRNtWojTRDmYzF5WWcqiDjr393eUaAL3XUjB6DGDmnfzDzxtd2JlYB5tIRi3dBmB/pGjDUCbTMByU16U6cMD2DjwaowDsvI6RVzwWGTTVEYtFZWr4o01UQqL7Ie8Px+uFawPftlMGktre2PV5EZuFjWbCAUgGWtfCyCzjEypYmZGVaZCeWT1G+GLlj9f7b6CM6ZKD93i8uxZlrL8IUzXzqytPqEnt0xHn3+4/Q3q5rEuTBI5d1xIKYamAFOl3z+YRLA5oj65i1HTZXd2iKqANs7DGu22HwTzHhwgEozqTWJrDTYv5FObbdRBeMK1CX07SUGmYWnK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fmUx5FTKMFia/MHLLLkHr5VPw+7imF3ijjNgfcNls8=;
 b=T/BBsS/Ggws3/CQslydYQnNZNxCfDW1G2GGnRLnwCC89snqFBqj0LWXpoP70a4bvZ48XoGXu7pLVy5XSQxGKtptR83Sra3a5P7NXUz4upc8+uFg6DYj6KOrS5vf5n85M9huLPST4W3V4ZuSK2G0YFQKRsh4OSNZokN3zzXoPCrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS5PPF5FAA0E762.namprd12.prod.outlook.com (2603:10b6:f:fc00::651)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 19:11:24 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 19:11:24 +0000
Message-ID: <08f80a38-2aa6-49fd-a16d-2b460f2a2403@amd.com>
Date: Thu, 25 Sep 2025 14:11:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
To: Philip Yang <yangp@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 Lijo.Lazar@amd.com
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
 <ccc729b8-640e-6e71-3522-7208413990f0@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <ccc729b8-640e-6e71-3522-7208413990f0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0178.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::33) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS5PPF5FAA0E762:EE_
X-MS-Office365-Filtering-Correlation-Id: 893cb345-1ce6-4586-a607-08ddfc6751a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmZ0ekd0WkdlcHN5TGJsQlR2TVRHZDdTKzhGM0lUeDlrYXY2R2kxelczZTgz?=
 =?utf-8?B?YUZVM1RhV0g2TXZsVE5xMVBoYmlHZmpZY21admZJakJCbWRTV2gzVllMOE5J?=
 =?utf-8?B?Q0l1dTRqQ2U1UmFCTk5KNStQVEJ6a2E0NjJyeWkwOWJyLzRBYXo3NzBKZzhM?=
 =?utf-8?B?NDdXQUV2eVFieHZ2b2xiL0xiVXNGTVVhVUgyMElHZCtMUTVlV01oMlViL294?=
 =?utf-8?B?RVF0SHlTeTNybHg2VGgzcUV3SEpnSm1OT2g4d09ZdU1lZUhSZE4rRzNiRVdE?=
 =?utf-8?B?UTl1akVVQ2lILzBmZTZMT1lRNVRvUVdCK0hrVTRHQlFZMVRKaTU5MFFJdmwx?=
 =?utf-8?B?OW00d2p6YkUvL0lyc0lXV3lCM1V3QVR6MFVrMTd2Uks2cVIxTk9vREIzTFVN?=
 =?utf-8?B?VTgwUzV4OU1FSFpoRVlkaHl0UEc5TCt2aHV2VmlQd3ppSHR2WitGMmVKU0xY?=
 =?utf-8?B?UXY1b1QxZ2FZbGQyNFVlMEFTQVA3S2pZai91aFk1TEtCMWZWeGZoMHhwY3pH?=
 =?utf-8?B?QUJhNzRQVVJrM2R4ZnN1OTZBNEVhMEhlNDJaS3hVWENlNFJXRzRpQ2VGSTZX?=
 =?utf-8?B?NGh6WE00Nm1IUTVOUUVGK1FTNnVBNmlDY0dMenpnSDhhb1c1TmxrdS91MzNn?=
 =?utf-8?B?ZndsZ00wWldodnZVRTRjZkR6R2FRQmo2cnhoYUVYU0RBcEpIdmtUSGdQV2hl?=
 =?utf-8?B?RmxEQmJkQlVZYTFKUyt5dnJiRzI3eVA5czlEenRjN1VDdzM1aTFOTU9EMk1H?=
 =?utf-8?B?SkgvaWVubWF6dFBBa0FucHhpeXZQMUhDajhoSXE0MnpHbEJzQldYTDFpTjN5?=
 =?utf-8?B?R2dJakVmWGMxQitBbVZGNUxmQlJDKzU4RlF3REN5dDQ5UU9oQTR1a2VjRDFI?=
 =?utf-8?B?VlBIMjcrQzZ5WC9BdTJOSTd5bDF2TFgvcXJBL0JlR1FkOEUwUDZFZ0Z2a1Ez?=
 =?utf-8?B?Z2J0OFQ2WFNEanM5bDYwcnQ3aG4yN1l0cWsvbVFSOTFCUG9HZlViRXFNU25R?=
 =?utf-8?B?aHhhRGpCVjBNTkpGWDlaTUFwcUJzekNkMHJqVitkV1JKVkRCUXBmVG1HaE5l?=
 =?utf-8?B?ajRwMHpUWDJBa0NzNmpMT3NUNDNUcUVOWG9LTVdBSEh6T3VtbUlpSXRhWUow?=
 =?utf-8?B?aGZNcWZEVHRQWlVzQml6ZWlKdXdPcGZwWE12K2dSTFdNdDd6TTg1Zm1mRXBG?=
 =?utf-8?B?eFNoc0ZXbVphUk1pdFdlQ3JaMVRpWC9haGo2WHAzSnlXTmxwc3JzZzEwRHl3?=
 =?utf-8?B?V0g0bXpYMW92cjFKYVE1eFpSRjNPTGlMMWowQm83YlhmMkVJSmVzazg2aHp4?=
 =?utf-8?B?a1lWRUxlZUNCNkJWTzZFNDVVK3ZiVU9janVwTDMxc1JHQ08vRWUrc1I0N1R1?=
 =?utf-8?B?R0Q4b2FXZmgzQi9lbE9ac1lsdlNERmV4SlJXRm1QY3lFbnBGMVZHeUdnVW1C?=
 =?utf-8?B?c3pYUWMxWEZDTFBhOWVzajNSSGdOYW9jdkpzRjByd25oMDhOa1lUOFE3WXQv?=
 =?utf-8?B?blNjUEJXL21udDJIdVM3MW54S1ZBc25tVzB6VmpBYWluNXl0ZE5hZThCZDR4?=
 =?utf-8?B?K1FHc1NQOGRpem12UFZBeGJRQ1pNZEhtb0JNb0c1THliMkljZ0d5V1B1Q1Jm?=
 =?utf-8?B?OTdjZWVpU09pS2t2VU1VUXNER3lsZ2tlNVlhN2tycktEaytXaVZSdmhqSCsx?=
 =?utf-8?B?RFRVM3pnSlFFeEtoR1FFaTNnY0d3RGhsRFBLWCtLZ3pyeWpnSjVkOG5SRWxD?=
 =?utf-8?B?QUdmZmVSWCt3cVRqY2VOcXpOMHdkS2pTVDJDQmVvekl4aXEzdmx1Q2RVWmhl?=
 =?utf-8?B?bFpENm8xKzdURnZOM3VUSUkxSUhxYVlZU2l5LzFLSUpaQkcvUlVUUXdCQXVh?=
 =?utf-8?B?MWZlSHBvdmdiYzBvcGU4SUNVNUtqdnljZXEraEdWVFplWkgvY0hsMW11eUNa?=
 =?utf-8?Q?q3unFTdzhShIQHIzBi/oQ2c0W6l5o7XK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1M5dmU0SHd4cGJpVDlUbUpTZVpBT1lPU0NDK2V3K0xyYWg5Qi91eGtLNTF5?=
 =?utf-8?B?MGJxQW15d0FrVUJzZ2MvQnlUUnMzN2hCYmttQmUyUzIrMU1oME1zd3gwdnZn?=
 =?utf-8?B?blJWVlREb3g3ZTh6UWE5bGtuT2J2R3VWMTh4eWNJZzJWamRXZ0o0c2lCbUlZ?=
 =?utf-8?B?TlphTERva2VHeHF2RG5vb21Tb2gyWTJSU2Z2M3Z4T0RBZlJxdWJCdHFHb2Q1?=
 =?utf-8?B?c1JYb2JlR05IUnpZTUlTYkg4NVhOV0x3K3ZMZnpIaUk5TmxmeTZNbFFIK2tG?=
 =?utf-8?B?SEptOXE4R3lWcmZVL3M5MVpOUVNuTjlHQndCcWx0MEVEMm05VHFocUxpa3lm?=
 =?utf-8?B?cFBMR0xQRTZJY0Z6SzFYNHFnZlBoWGZYU3AyUWhKeU8yWGtkenNqQXZsQk9Y?=
 =?utf-8?B?aXZPTENxK2hYTEpWVFY4MGU3ZEhHdHh6alR0OFRUQUN0UHRyOTlORUpJZDk0?=
 =?utf-8?B?Z25QQ0d3enN2U3c3aVhMSEtzb1RCNGc4R01QRFZvcWhtSkhHbStKOXJZY1pP?=
 =?utf-8?B?OGJHeDk2cEJFekZzNDVOT0V0SmFWVlFpckY4UWlabEdKY045TlUwRzBWakIv?=
 =?utf-8?B?TEpBM1l2Mk1VdTFIdVlUbHdIa2FCMXZpcjE4dWRJTGE3d3poa09mZGwyZElw?=
 =?utf-8?B?NTI0SnI0eGxVTlRsd3Mxb2hEZXRPTkRxS1drR1FnY1lsSE9QdkpYS2kvemIr?=
 =?utf-8?B?MEtoNlRkbit4MUJxc1hmaTlFNHBUcjg3OE5XTHBiVDVQTFFiWjU4cTJMVnFZ?=
 =?utf-8?B?RFg5QjJvbUVkdm9mVndsS3RxUktBU3NlSzcrNEFNVGgvNUVuS2lFMG5RN3Rh?=
 =?utf-8?B?OHljS0E4dWtiSUcrbDJHcitlV1RGYTJqd0dHZ1Q0ZDZpY1N1RWZaZGhoZmY4?=
 =?utf-8?B?LzBMemoyWHZlK2NZQU5pQVZMdGR3Syt1NU1FRC9XR0E5K2pBL3BDSExWby81?=
 =?utf-8?B?N0R2UjFpWG80VVRkOUdWNUxLTE42V1IvaTQvck5sY3pQZi9JRm16N0xjMEJs?=
 =?utf-8?B?U0pKazVIcG5xTm1XV2pMQWtFSVkwcytha2twRHhTbHlVWXBIeWFtN3NrS2ZV?=
 =?utf-8?B?dGtHRFlQb1pPbk82K2twWUdVT2JwS2lvc1FZczFWZXRZbjFPbHFrQWlSM3NN?=
 =?utf-8?B?enJEb0lUTS9vMVpncDZIdGFHUWp2b2daYTNKa1hTQmJnQkkzVzQ1OVNYSmEz?=
 =?utf-8?B?dW5MTCtnenlFZW9MMEFsa2JETnNmd0N1WUZVcEJHRTFwYkhxeWErVTBlaVZs?=
 =?utf-8?B?K3E3N1p5M3JvU3ZqSmxsUWV5S2U3T1pVQlRqWUQ0d2grendmdXFlTmJNWmlD?=
 =?utf-8?B?SFZDL1hFWkV1dURjTXliWnpJRkZWcHpTSC8ra3NWK2g2dlJlcFRtK2JYREly?=
 =?utf-8?B?ckZtRCs5VTJrbUh5S0Zmb0tia1VkNjM5MXFlSVd6bGRjcnpaRFlwQ3lpUndV?=
 =?utf-8?B?dFB1Q0lyTi9vRXF0RXpOUWIxYkEyc0V2VnhFY0Y2OWxjbUMyaEVMczJCK2dm?=
 =?utf-8?B?YmlrREpTOU1vWDZ4dWFlc3VBUTFhZ21BeDNGVUZKSmpNNEcrNWVqTmNkMUNG?=
 =?utf-8?B?TjBVam9qNTJLb015dkdQb25OZlhzdEpTYTFpczY0ekp6a3R0V0JnS3prSXhL?=
 =?utf-8?B?UGR4cjBUMlhCcEVmcy9oNlQ2M3BXbE82MkkvbSthSDBHTkFBMzlMZmx5bHov?=
 =?utf-8?B?alRCcVYva3FKdWZ4eFRmZDRZekQrRnZtZ093VmNNcHVjQTEzbmU3eW02c0hH?=
 =?utf-8?B?OEhuSmZGNElTMy93Z1BLS3FpaWJodStiSkV1dU0rbVppcnN6TjJXQ0RjMy85?=
 =?utf-8?B?eFlYeGpxWDVLV2MzcGZFZnBNNGcwQ2YvTWh1b1FSVWZZMVVYM2pvSHVuM3R4?=
 =?utf-8?B?Rk9LZGgvL1IxWjJIcE5BT0drZVMrNmlXYzhmNWo0a1VNeWFkbjRiYTJVRTZE?=
 =?utf-8?B?dFowMFphNXRtd0hJQ1BmalgwNEtNQUdIZXVRZ0EvdDE2T3VTbkU2akcrMHZM?=
 =?utf-8?B?RXMzUmltRWwra2NPMmEvbENCbzM4R2VDNUZLOHVSTUVFa1VITnJRb1JJbmtD?=
 =?utf-8?B?Ylk1dFIwM2NVSDRnZ1dnTVY5T1g5OGcrQklwN3kwWG5ZaU5VZ05IZXVJMHlv?=
 =?utf-8?Q?0AGg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893cb345-1ce6-4586-a607-08ddfc6751a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 19:11:24.0472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcNBhAEUrpbPzSwrXdUKgI7CLYbnN5dXeLzgtNeqoyooxPoVwzFVaqRn790bROny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5FAA0E762
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


On 9/24/2025 5:48 PM, Philip Yang wrote:
>
> On 2025-09-24 11:29, Yifan Zhang wrote:
>> There is race in amdgpu_amdkfd_device_fini_sw and interrupt.
>> if amdgpu_amdkfd_device_fini_sw run in b/w kfd_cleanup_nodes and
>>    kfree(kfd), and KGD interrupt generated.
>>
>> kernel panic log:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000098
>> amdgpu 0000:c8:00.0: amdgpu: Requesting 4 partitions through PSP
>>
>> PGD d78c68067 P4D d78c68067
>>
>> kfd kfd: amdgpu: Allocated 3969056 bytes on gart
>>
>> PUD 1465b8067 PMD @
>>
>> Oops: @002 [#1] SMP NOPTI
>>
>> kfd kfd: amdgpu: Total number of KFD nodes to be created: 4
>> CPU: 115 PID: @ Comm: swapper/115 Kdump: loaded Tainted: G S W OE K
>>
>> RIP: 0010:_raw_spin_lock_irqsave+0x12/0x40
>>
>> Code: 89 e@ 41 5c c3 cc cc cc cc 66 66 2e Of 1f 84 00 00 00 00 00 OF 
>> 1f 40 00 Of 1f 44% 00 00 41 54 9c 41 5c fa 31 cO ba 01 00 00 00 <fO> 
>> OF b1 17 75 Ba 4c 89 e@ 41 Sc
>>
>> 89 c6 e8 07 38 5d
>>
>> RSP: 0018: ffffc90@1a6b0e28 EFLAGS: 00010046
>>
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000018
>> 0000000000000001 RSI: ffff8883bb623e00 RDI: 0000000000000098
>> ffff8883bb000000 RO8: ffff888100055020 ROO: ffff888100055020
>> 0000000000000000 R11: 0000000000000000 R12: 0900000000000002
>> ffff888F2b97da0@ R14: @000000000000098 R15: ffff8883babdfo00
>>
>> CS: 010 DS: 0000 ES: 0000 CRO: 0000000080050033
>>
>> CR2: 0000000000000098 CR3: 0000000e7cae2006 CR4: 0000000002770ce0
>> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> 0000000000000000 DR6: 00000000fffeO7FO DR7: 0000000000000400
>>
>> PKRU: 55555554
>>
>> Call Trace:
>>
>> <IRQ>
>>
>> kgd2kfd_interrupt+@x6b/0x1f@ [amdgpu]
>>
>> ? amdgpu_fence_process+0xa4/0x150 [amdgpu]
>>
>> kfd kfd: amdgpu: Node: 0, interrupt_bitmap: 3 YcpxFl Rant tErace
>>
>> amdgpu_irq_dispatch+0x165/0x210 [amdgpu]
>>
>> amdgpu_ih_process+0x80/0x100 [amdgpu]
>>
>> amdgpu: Virtual CRAT table created for GPU
>>
>> amdgpu_irq_handler+0x1f/@x60 [amdgpu]
>>
>> __handle_irq_event_percpu+0x3d/0x170
>>
>> amdgpu: Topology: Add dGPU node [0x74a2:0x1002]
>>
>> handle_irq_event+0x5a/@xcO
>>
>> handle_edge_irq+0x93/0x240
>>
>> kfd kfd: amdgpu: KFD node 1 partition @ size 49148M
>>
>> asm_call_irq_on_stack+0xf/@x20
>>
>> </IRQ>
>>
>> common_interrupt+0xb3/0x130
>>
>> asm_common_interrupt+0x1le/0x40
>>
>> 5.10.134-010.a1i5000.a18.x86_64 #1
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 349c351e242b..051a00152b08 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -1133,7 +1133,15 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, 
>> const void *ih_ring_entry)
>>       }
>>         for (i = 0; i < kfd->num_nodes; i++) {
>> -        node = kfd->nodes[i];
>> +        /* Race if another thread in b/w
>> +         * kfd_cleanup_nodes and kfree(kfd),
>> +         * when kfd->nodes[i] = NULL
>> +         */
>> +        if (kfd->nodes[i])
>> +            node = kfd->nodes[i];
>> +        else
>> +            return;
>> +

KFD interrupt is handled later in wq node->kfd->ih_wq at interrupt_wq 
which uses  kfd->nodes[i].  Checking " kfd->nodes[i] == NULL" here is 
not enough as kfd_cleanup_nodes can free kfd node at any time.

Regards

Xiaogang

>> spin_lock_irqsave(&node->interrupt_lock, flags);
>>             if (node->interrupts_active
