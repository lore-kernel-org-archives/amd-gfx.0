Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69895C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 07:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F12DC10E91F;
	Fri, 18 Jul 2025 07:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n9bDmKTc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA9110E91F
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 07:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLq5/z0RBNEErSnU8Ee3OvWDgLoptmF7rs/X3s+EHk1wipfLJ3eyrFZx9XtoPxOSz8QH19XkATDNbqbRH97My4nn9DqkWCLq9JcM0aEHcgLeqJxEiNZ5/pSh6V5AirsaM7M2zlzEdiG2/ohWGD3/QlyxoPlqpEz6xWC+z4cMbfldMOuMez5Q7yY10dBk7PC+Xg9Z/znav+S++70ifHi1R/l8eWqPXnGOZJV4LRx9AyYMAMJKLCnQW/JiDu3jILB3CfRSNlkSqXzVhoZXEIfqywG6Se2TZJNIeOTxXPXTvI1rC6Fp3YRfNx4IsEYnXJmiUzYj/o0UaNtvUuDDyzCRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGLfwLk5GK62ldYO68umobgJZ+eZ/22z1fRQDUirXTE=;
 b=gkD/w6FgF0oEPS5OigPlgoxPM5u+sPyP0VbnOtVnL8XEao40OSNvWAWX0+ECzNZmk+vy4gROtVcebOBk3D5JVjlk2MGp1dE8gyw/Vylxqu9ZGl7bEbhesUlWeN5GnNgt9E8LDDNsNGBX6XGDwUlgcvneOE798UNfeLTcUBQIUsIASrMFSeNoX/XAlDH3vFOIrXrfsSULtekg6DERLoqJIK1Tx8p/8MkJQwHaktk6lm2pSy6lyCNvpG8QtLJvHso5qnr9KeKmOzThYS4yHZJ9qYoGnPPK5DUXrTCfvgKx2eJ0UQeD7ZWwrG5Y9ItsrTTVRjWGMyBIKTjHDnfRjIRJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGLfwLk5GK62ldYO68umobgJZ+eZ/22z1fRQDUirXTE=;
 b=n9bDmKTcNnfO/B+RVmG22WKgHIVtYlIwuHZ3GSrnBYlwXTguBfRqUt6g3Kb1j+Dg8CpiCZxHLObhBWy9FU3JOg/a34w0xH7Cbsptn7hZD9z6onUsYKokjbvve77hb4X8bQkjPvMDOczBOuJFZ5WJl4eXyuRzBWc2tqmOAcHMrDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 07:41:05 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%4]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 07:41:05 +0000
Message-ID: <a7b1816a-65a2-49d1-aa50-f0a0e7a8ef10@amd.com>
Date: Fri, 18 Jul 2025 09:41:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Avoid extra evict-restore process.
To: Gang Ba <Gang.Ba@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com
References: <20250717175842.1344076-1-Gang.Ba@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250717175842.1344076-1-Gang.Ba@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:208:120::39) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef8117d-7890-4416-6991-08ddc5ce73be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wkt3eU1hQmxoU0svNFJiNnBrS3YySTBYd0RtaHFUaVdLdXhDbkdPRWwxTXla?=
 =?utf-8?B?WlAzd3VUVFNOOFdkbEp1bEtKUThRUFhTSGlRNU13cG93NlliU2JEWlY3TjdB?=
 =?utf-8?B?ZUFiQXJPU0VFWU5ldENsV2Ziem1zbFU1b1dkMFBSQUJLVlFnMEdaTDRGSDRG?=
 =?utf-8?B?NFlycTJ6c01QN3EvUHdiejNJWEhOZ2tGcVFib0xXakthdStuWk0rNWtXRllI?=
 =?utf-8?B?UEV2Z0EyOGdJOWlhVTFLTGY3ckY3OVFac2xBcDIyNEgxTS93STh6c1hNVnRJ?=
 =?utf-8?B?MmFMV21kYmJ4L1k3Zk9FUFZvdEpPNmJQcU5pSzdYYzhmVWJWTlY2Z0UrcDVn?=
 =?utf-8?B?RHVVU1ZhNWxlaXZSdVBaM2N3ZDlzNE41cGI4T3h3OEoyNERLTmk3WVdKRTla?=
 =?utf-8?B?QVBKYVNjZGt6azZUSWZVUndoUzhaeTZkcVVKcTh4T1pFTXRycHc5RTFzR3R2?=
 =?utf-8?B?bzc1akN4eXhGUlNtRUlZSGJ3K3YxN2k1a2tQRnV1YXdwMFh2TnhFNnQ2OFg3?=
 =?utf-8?B?Z3pMSWpSendaZitiZ0dhUnh3aHY4TnB6cGYzS2N1ZnBpOGI0Z3RLTU52MHpY?=
 =?utf-8?B?T3JMaE5yS3dsR2ZZYzl0Z2xSZU9mL2tpd3U0a2t4S1I1ZWprRjBUZTJpWG00?=
 =?utf-8?B?UlcwRW8rWXR3NGdqUDRoVUxSY0tYd0Fjd2taai9wb1R2ckozUWUvWmFpcHJE?=
 =?utf-8?B?V2Jrc1F5RllkOUJicUg1R3JFZnNYYjAyUWNGYkNwRUp1V1FRRDZ6b21waVNu?=
 =?utf-8?B?MkdIV0NoUXVPeW1aT09pWDhhdEh2eitoakV2TmZjb0NhSE45ZC81Mm52NkFU?=
 =?utf-8?B?UThOaXk3Ui9DNVZmRnlLU1pPZEhZOHk2c3VVNCtiZTdaRFVRbkZZQ0dJRmFI?=
 =?utf-8?B?WjFDMkg0RCtRVVkwN1N5ZEJNdFV0VGdtcGtpbEFwTSs5MGlkY0RpWVBKNzgw?=
 =?utf-8?B?M0ZsTVoxelFYcmlXSVBubkozdWhySEVPaVh1RWpnbEp6RkZtNjJLTWVVamlD?=
 =?utf-8?B?dmFCM3E1NmVRbVhCTHBVdGV0SWd6b3Y0M0pZR0t3dnppaTYwVWxSR1IyaGR3?=
 =?utf-8?B?UEJxNVlDaGtlSzQxY1M1YjNNSVNHZnp3MEIvR01OcERZT2EzQit3Q3lTTWZS?=
 =?utf-8?B?OFliMUNPTExKdUVqVHZGanFqK1BPTEYxR01jSjJvVzZyU3U4SGFsQy9nS1hV?=
 =?utf-8?B?N3JSWUpTR1hkbHI0YlhqSEFJOVE2Um1OcG9QSjgzYXdYY2ltRmpoMk9qaHF3?=
 =?utf-8?B?enBJM2VxUWYrU3AxaWprK1FLU1FaeGhKQ1greWR5VkpsOVNId1BGR3JoSXg5?=
 =?utf-8?B?elNWWk1aYUxmZEJuWE41eGt0U3BqTm1vbG9ZRC9uRng3cm1xNHFxeEdCTEJk?=
 =?utf-8?B?djErM3VyNko2Y2NHTU1FWHlieTFsZGRSNVhFRmwzTVFCNkdmV09tNDNkUVIv?=
 =?utf-8?B?cWNwRVVzQ0M3YXl0d1hna3ltSzVOWGZKM1Y5Z0VyRjZSZFpUWG15OVJZL1B5?=
 =?utf-8?B?UlVOdG5aVnpMZEVSSHJ6d2NOTU0wTGhtV28rOGw3ekhUdWxJUmZpTWkzQ1c2?=
 =?utf-8?B?bFdnS0Q0dnlhci9ESzFyemVISUthZW81ZTlTTUpXV2tWelVVMUhyL1gvaGxz?=
 =?utf-8?B?SzRxa2RiNVZMRmdSc2pJelA4ZWRLWEliLzBtRzBsM3hXdHBNQjFPZDIxRVE3?=
 =?utf-8?B?Qlp0RDhYY2g5RXBhU3hobW13M014ZnBYZmErck9LZ1VRS3FPdGhQdUhHY3Vw?=
 =?utf-8?B?cXI4QWNMSFBmVkVoUGtGVjFjNzBjWE5KZC90TzF3WWFETkJFM2ovTmxVdG9P?=
 =?utf-8?B?UGlQbDJnMHUwaXBPZWlsRmt6K2lkZml4TXpyeDlBcjlGNi9TYnRXcU8yQ3pR?=
 =?utf-8?B?ZnAxWjYvdEFodmNVSXdxUCtVNWc0UHFWUXhsRVZWTnExMWg2UjFsZkUzUGhZ?=
 =?utf-8?Q?Ixm5MOqHqrc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE9hWlQyeXhIRmNiOVREYUdjRVZQSk9zdjVLSGczc0NaL1VFWE42YUh0UHhw?=
 =?utf-8?B?V3drcDV4QjcwM1kwZXZieWJoSjBZL09UUmR1RFhocjZ2cEdHS1pwWDZDWHZ3?=
 =?utf-8?B?eTZhc2FBaFUvM3Z1VEFXbzVpS2tTNUlKNStLYnRJaldqeEttTkgzS0ROVkVa?=
 =?utf-8?B?ajIzQ0Z3SnI0TGdkQUtlcEdEQ0ZORlFrdmYvR2RQWWhqc3IrTVRwZjN0eGpQ?=
 =?utf-8?B?akJTczd3Vnhlc2J2bGpiZEVnNHRxbnZ6azQrRXlMaXVhcTA1MGh3bngvc25j?=
 =?utf-8?B?VURrcDFiU3hOTUEvZGVTQS9IMWpMZ0pjZENBcGI5ZmlSZStBUEpjU1ZtS3Zp?=
 =?utf-8?B?WWgzSkxsSFJEVjJOSFU3cnpBVnN1MGN1dlFBaUNVd2MvZDZONXhpamhta29t?=
 =?utf-8?B?Vy81NXdSWVJUb0VpQ2RmaitLV04ycnlua1hyNk9jSHZEYlZNT2VzYWJJV1JG?=
 =?utf-8?B?UUZGSXJLQVM5TVlhdThEMDBhdVBwTU9RUG1zejJwTE1kMEhjVzRtN21RMFNJ?=
 =?utf-8?B?TVNXQkovRE1QaU5EdFgvYnR6RVREaTA1V29Pdk5oN3BSM0FHeGZETW1tTGxv?=
 =?utf-8?B?V0IwM3pNTnphMkN0clYyb05XWkZUVk5EbGwzMk1CTnhtQjl2d1Z6WHpaMm5s?=
 =?utf-8?B?cFVYaUx0dGlBWmxHYkZOTlh2NU1CMk5qRmI3SWdvN3BiVXdCZjZENm9DUW1T?=
 =?utf-8?B?TmRxMmI3NFIweXhJMDlyQXFIMGRCY1phaHhRQnBnZk9pS0hDNFhhbXpPNVlk?=
 =?utf-8?B?NUdTdlhUTy9nRjc1ZzR0ekw2Yy84OHQyaU5CSWY5c3JaRkpNSWZLZXhKYzlo?=
 =?utf-8?B?RTMvRDlNSG1BdndWbHl6dUdjRDQzTzg4WFBWbWphcmtzL2N0dW0vT2VXcTlR?=
 =?utf-8?B?Zm5rK0pNR0xDRGxhbi9NMjJ4VmU1dzl4eThDUUhxZmlId3ViRk1rVkFWQkpL?=
 =?utf-8?B?MUtkbTBBQUtxR3lOQ3Z1aXhKWjBSdkhNL044UlZJUU1wTk55MDNHZVE3MGlt?=
 =?utf-8?B?dnlnTEtvanBKWTRFaGtQbXRISlRVM2d1SmdDSUkrOVFqR2tRRno3SUVpdG9k?=
 =?utf-8?B?aFp5L0JSM01sbjZOODJkaERlcTdCZ1JYMHlCYzlNWk51Wk9qNDhFTVVqL09S?=
 =?utf-8?B?L3VWMFJXTi8yVTR1VWVYTElMNy9mV1dwcXRyVkhkb2Yvc2FwUEFsRnp1NjJ2?=
 =?utf-8?B?RkhwMG8xQlJsQmJwSENNL0hKSnh1L1RWZkhxOEEzZHg3RVdzL1NYcXFhT0dP?=
 =?utf-8?B?bTArMnJwTHBSZjY1RVhYNDNLY1FmdWRsb1lkVkIxSzF4Y21kaEk0ZHhKUTZj?=
 =?utf-8?B?dk5hSXFVbHZjcDdOK1VCR0NicE4rUHNuZExEcHhLNXFxdGVVeGZQemIrUWI2?=
 =?utf-8?B?U2xSOXI2MmRveHZBdVFyWU9PZktLajdQeC84RnhRcDZOVWUyTTZxZ25NVVEr?=
 =?utf-8?B?enRwL2Q1dWZPMEwreVlIMU0rejdFSGpVM2hGTEpRMTNSU3U4S1hEeGRSSE1B?=
 =?utf-8?B?dldzczlaY09lYkRyWmpMTUtLVFpNOTgxUjBrUkJ1N21ndkFvRU4vcGNrNnVZ?=
 =?utf-8?B?SFI0OTJFNHhOREdsd08vVjEvMXpuVmRoSTRDdGpJbndlNE0zUWxzMHJJMXZ2?=
 =?utf-8?B?d3pnOWdUTURmVzM3MGs2aUgzcUZEOEM1a3doa015bGE2QlJKM21iRCtGbGwr?=
 =?utf-8?B?alBLMXlJOEVDNklhS095U3BzVVl0eFJUdHFac05rTWFhOHh5SGJCRmFtOENG?=
 =?utf-8?B?ZFZiYU9XSmdVUUU3enlLZUE4NkhYb2FocEpNRWMzTDQwYndZVDQrZ3FoWHdM?=
 =?utf-8?B?eE5WaUxGQlJ1SDNZZ1Z1TVRjN1AwN1hoUDlubjJCTFNBK0xTcnIwcTFhOXJx?=
 =?utf-8?B?ZGpnTmx2bkpzY21UODV3YUFjYldKbCt0bTZBRndlUEwySU12U09ZNUxhSzlF?=
 =?utf-8?B?UUw1aGxOWmxhMWRlT0NIekFtRzFXSUErbEJSbmtVdVMvdXN0NURZR0VRR3lv?=
 =?utf-8?B?ZHN0SjRvOVRVa2dhaVUzZlJBNk5mSnBOV082SEJNcHFwVTBsS045WStBaEEy?=
 =?utf-8?B?N0I4KzhlVXdzQXByN2tqOVpGbzhVNUc5cnp5VlQyYnFDT1J3dE1GU3BRRzJa?=
 =?utf-8?Q?JYPpbJkr2V3CduG7OShkTFccq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef8117d-7890-4416-6991-08ddc5ce73be
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 07:41:05.4851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8eWcdO+9XvKFrdmFBoTzFgupfl5lG9H3JSI2B6vct4ZmJZQsPKAGZBN+2oARdsB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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

On 17.07.25 19:58, Gang Ba wrote:
> If vm belongs to another process, this is fclose after fork,
> wait may enable signaling KFD eviction fence and cause parent process queue evicted.
> 
> [677852.634569]  amdkfd_fence_enable_signaling+0x56/0x70 [amdgpu]
> [677852.634814]  __dma_fence_enable_signaling+0x3e/0xe0
> [677852.634820]  dma_fence_wait_timeout+0x3a/0x140
> [677852.634825]  amddma_resv_wait_timeout+0x7f/0xf0 [amdkcl]
> [677852.634831]  amdgpu_vm_wait_idle+0x2d/0x60 [amdgpu]
> [677852.635026]  amdgpu_flush+0x34/0x50 [amdgpu]
> [677852.635208]  filp_flush+0x38/0x90
> [677852.635213]  filp_close+0x14/0x30
> [677852.635216]  do_close_on_exec+0xdd/0x130
> [677852.635221]  begin_new_exec+0x1da/0x490
> [677852.635225]  load_elf_binary+0x307/0xea0
> [677852.635231]  ? srso_alias_return_thunk+0x5/0xfbef5
> [677852.635235]  ? ima_bprm_check+0xa2/0xd0
> [677852.635240]  search_binary_handler+0xda/0x260
> [677852.635245]  exec_binprm+0x58/0x1a0
> [677852.635249]  bprm_execve.part.0+0x16f/0x210
> [677852.635254]  bprm_execve+0x45/0x80
> [677852.635257]  do_execveat_common.isra.0+0x190/0x200
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Gang Ba <Gang.Ba@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ea9b0f050f79..ab295b22a669 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2414,13 +2414,11 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   */
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>  {
> -	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
> -					DMA_RESV_USAGE_BOOKKEEP,
> -					true, timeout);
> +	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
>  	if (timeout <= 0)
>  		return timeout;
>  
> -	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
> +	return drm_sched_entity_flush(&vm->delayed, timeout);
>  }
>  
>  static void amdgpu_vm_destroy_task_info(struct kref *kref)

