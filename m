Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A223C28B24
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 15:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02D410E983;
	Thu,  6 Mar 2025 15:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UNhqialP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E51E10E983
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 15:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxLjX4oVzl5ir8IOk4rjuZ5PjsYD56y00fYkd2lh4OJ8pTbJQ9mpZoIipk2IFSjpQR9ibcZPC8EELFUWAudxCB7OBcPIaafhFQ/cVmT7QRrBJTqhJLXaAPPtq536nvu2KqvzlCrvNkXbxXnZcnzL2CyCkMqPlS06U/CEGlWgaJoGqXd3NnrexqBPVqvbAxm9TwZ8cJDFXzQuwOYf/BY73c1FS57EBl6lG+IXqt5Z2dWAEU3lPbeVFOp4P/oxnWbihddlfGUQyeHna70Bn0jl1KVRrotIUJPeV/I+4DqsWoyyQeIjvQH2Zin63FZHWDQdVEhBy0aGOUOmXyc1bost1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o22PcESi542PsTaHX0Nsy0PHrfP98xYl6BPvAEEKmU=;
 b=Bj+Lz+h1bRyJ+xESybOKrTrB4/8QsT8DBq33bK+cXgcuaCdiHqHo7FFgNUPulrt1zSESlb2aNrFEiGoLjvUpGbJ2u+l5koYhMQAKxKa1ne13aZE0eDaLi5X8FdXVPKHiaH3Zryw4DUkQU9yvEqKxqTome564/HelfVqPZuXJQZt+H2eUYE63q/iHrTZVR/rM2H3rrnzzRQaWbrzxfJsPpdIMeJqByksnZrMutMDt4rvqtcqnhd7ko1rVpoAknRYz7FB4Ws+qLJIPzY2QkA3/p/3cVvB/yrc6j4Nx9sGTMNUFiHwYFWQa/ldzk2SWM2KPW+HFtFpAkR3/V5VYff6AGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o22PcESi542PsTaHX0Nsy0PHrfP98xYl6BPvAEEKmU=;
 b=UNhqialPeajLFXGQ3InmzCuRcylOg4RJ4ZvXKKYzOcz9VSfhW/lyU6OMtSysqA1Jk/5ynOkPxzd21P3oWLQtQyBZdtaIUeDAqGx+R1ob7wqlYRwkJI72fO167dIoiIvDXgPuUbTYkV0HIYyXkhH3inx84ZYG+SJ4+qnIgve3s5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 15:49:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 15:49:51 +0000
Message-ID: <e3515c9d-3f73-40c6-bd52-397c7922897b@amd.com>
Date: Thu, 6 Mar 2025 10:49:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Fix the race condition for draining retry
 fault
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250306060309.3222693-1-Emily.Deng@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250306060309.3222693-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0224.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 42482409-41a6-4c67-b7b2-08dd5cc6883b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2ZaOGZUQXgxRGEvTjEvcE4xY05BL0twVjYxZ282aG5LKzFkWkg2VE9YMzZE?=
 =?utf-8?B?NEVXTWxXaVlpbmNuT0I3WlVDQ0dEenJ0KzRHRU8zNGJIbXE0MVQ0WkFBd1pn?=
 =?utf-8?B?TXJISTBPRDlpMzFiMG85cEVXK2ZQNmVySVJCd04yVXJYc2tINUZtNTlkTDM4?=
 =?utf-8?B?UmxUdlk0b21HeGZkaGQvVVNHbWVQYk80MTZSbEVxb25BdEpoZ01EMXdlV081?=
 =?utf-8?B?MmVKa2cxMWpsbWtHSkV1Ky9qV0Q1M2NWSFNlQ0trWmhYRVFJYVdCTnViVmpX?=
 =?utf-8?B?NUxiSkZaVEpITnRvdTl5SUdxS1o5d0NoRVBJZFVEVHFtMk9UWnU2WDVLN3Jw?=
 =?utf-8?B?OXdWa0pEdFRPYzErN2Z0aFBHZnVRam5qYXN5MncrSDNHYjhqY0NneTBEWngw?=
 =?utf-8?B?THI3VCs3MHRXa0t6UHBUUi8xMzhKNWhyR2ZQdlNOVnRISTRkK1JGTElKT2xN?=
 =?utf-8?B?ZHhDZGFWendvT1l3TWo4b013N1BrMlZFTTZNMVlPeU1qTHQzZHdtNDhHdnh6?=
 =?utf-8?B?eDIvRFlJQ2RERGJZeGlYZEVqN3NFU3NHV05mQmRvbWlHMTgrMVB3TENhOVZJ?=
 =?utf-8?B?Y0xwZmQ1SXd2OUgzRTdycDNoS3ZwQkNLOHM1OEI4Tk9qZlArWmdTUXJFVHlV?=
 =?utf-8?B?RVhHV3E0aElWZ3dTWlo0dzRQR2dld3U2TncrWmxUZHZvSTV5MUFZQXMrb3Rj?=
 =?utf-8?B?Q1dhYUJPUW5TNm50bTJWOFdadzd3aUdSSUMwT1c3NDVhRWdTK2xHaHg2TWdm?=
 =?utf-8?B?L1h0eGs2UUZqN0pyN1dneTZyQ3ROeEFON3VoTzhMeDlYMjJJdXpUVmVRcUJE?=
 =?utf-8?B?TjFuNmdQUUZHSk5xVHZzSThsenFhdDd5WVR3NXIrSXloaTVqbWhQbTYwZnRL?=
 =?utf-8?B?dGQ4cVpsVzZLcDVXa0xGZ0ZPQmhNNEdSTmJrNDVpSDFsV3RlcUJnUFJjeDlM?=
 =?utf-8?B?OXJVcTI5NldNSXNCZmxOekdHWHUwOU1GYVpVejNuWEYramZUYURUV0tEUyt4?=
 =?utf-8?B?V0pBYUF5b1dwL01Cb2F0UFdVMW41bTV2aVAvYk13b1I1S0NySUZaaDJ0RXFB?=
 =?utf-8?B?QWt3VEVhMUtSOUN2Z1U4UmIxWlhKa2JRZG44U21MbXo3R1JqdllqaWtaRUVq?=
 =?utf-8?B?cTdOcG1nRWZWaWIxaExJemlSeGZkZEUrazVWZmZNSGhRbzdWdTBlb0hiaWdE?=
 =?utf-8?B?ZW5zV0MxY2JXaUpUVkVhUlkwM3FhcmhiSlBNUXJFY09DNjZFalVLckR3SzVr?=
 =?utf-8?B?TnlZQjBjVVNHd2M1TmNzY1N0cFQwMVA1dVIxRjVmVjZFMlNSYW16UFdBQ2dL?=
 =?utf-8?B?YnNVZHYxV1Q2djJTaVN3MEs2Yzc4d1J4RXJQMVhJendQVyttYWV1RlNjZkJN?=
 =?utf-8?B?d0VzMlBCYUdpTnZVSVVVaytvNitRUW0vTmhqbWtJck9nZUg1SXp1SXlIWUFl?=
 =?utf-8?B?d3Uwa25yeTJITHI4Q2FsQ1pqQ0h6cFBBS3RhU21ENFN2ZWJzUmpSb1VFMXdK?=
 =?utf-8?B?UlFHWktNcFh6NEhsVm9oUUFjcHBBUXhHWUVGMjZuQjF1R2h2QVEvMGp5cUhZ?=
 =?utf-8?B?Z2t3NTB0bUNzdTdnc1p1UFoySG1ZcHlPV3pXNnMxVlBIcWNPWUlDYWErWVll?=
 =?utf-8?B?RmhGQldZcXlMeEpyMEZMTVJ6M3Zadkh6ZjErMjdMaEVSUzljc2Q3MmozUWFT?=
 =?utf-8?B?QkFxbGpWWHJJeG9vZ0ZBeGYvZ3AxOFY1Y00wNnNxRkxLRHVoTVVjOE56UTFt?=
 =?utf-8?B?cjZIVy9vTjFoQlR0Y3hQYUhmcVNHL0l2MnEwdmpHbXljOS9ScElXZ0VwQ1RR?=
 =?utf-8?B?VDlKSG95RVRkS0l4czNXTXlmZ3dpd1B0a2JhK2ZaeGZIZnZLcjdheVc4alo5?=
 =?utf-8?Q?a/RBjFt/aalmH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFpJSHlRUDR0aXVpZldnbmhYTkhRbFlTdnpOeU4xWlpmc3UxN1ZHT0d2MTl2?=
 =?utf-8?B?UUlYVFBTTitTVEVvT1p6U3ArSVpQdHE0TmR2ZFY1ejliQWNEdTN2R1pNTmFC?=
 =?utf-8?B?bDBHRmh6eTd0LzVxOVUzWERRWVJhTU5UTHVYcTBEYVFuUm9Na2lDUm9BMU40?=
 =?utf-8?B?bFJwZWd5YnNGTGgxOXpacHgrUGdtNW5IQlJSYkxGUEc0REQrU3l5bmU4ai94?=
 =?utf-8?B?TDhXZkxYTUpJa1NRNHBkSGFaekxxZm0zZGwwSTFmNStKM0Z1L3NUK0pQS2xH?=
 =?utf-8?B?OHgwUXRleHhlcU4rQXYwRHQ5L1dWRFcycEJpcjd6NERaT2M0UEM5MEg1L3kz?=
 =?utf-8?B?TEJudnI2ejZDR01KdXQxc3dVbDdSc1ZtenVjKzhVQkNCUlZKN29kZ3duQlZP?=
 =?utf-8?B?TVdPTE93ZzZnZ1pXQml1Q2VVRWIzV0hQQWsyWXEyUlpTdVhWaFVzL2xMTC9W?=
 =?utf-8?B?aDZCbnRwSnIyMHJNdmJDOFAzSWtNU0xzK3NIYkhRZmVHdkJ6ZktodTFvbFZZ?=
 =?utf-8?B?ZkRwQThkSGFQREpwa2REOFl4WUE0OGRORzc0YXg5SVV2cktrbk9Ya3MxRzBi?=
 =?utf-8?B?WjRQdStKTnZDM3kvMWhsYm5JNlRRRC9SQmdJSDAzSXExRGFYRzFiTkFGczhs?=
 =?utf-8?B?RXZ5Y0VQczBTeWlLMXhkUmpoRGoyZDI5bVVXVTlHYnlsUDcrUjRFUjNNdXBH?=
 =?utf-8?B?VnRRb0tad0lPWXQ5MVg4QVhMMjlYSUZPYldLRmpqZ29xODJuaDQ4aUpVVjhY?=
 =?utf-8?B?QlhHdEFKQUdyNnpkbndaTERualpLNGhDQUVTb2Z4VjJVVFluRDdOdlJXYk90?=
 =?utf-8?B?L0hreUZxOC9CLzZrYWFwbEhjS01zVWdZbUN5WEMyWU03NHR5WWJiWXVYYzYy?=
 =?utf-8?B?QTMrTy9ZMkpsWGxNRmkzUUgwQ0kwRUVSSm9qYXBHVjZWOWk5aGE1aGJYaEdG?=
 =?utf-8?B?R1YxQ3ExMTMzaUM3N29SZzJQQlZtMmwyS0M5RjhRYmw3Rit5b0FvOFduMGpK?=
 =?utf-8?B?NGdMUVZUc0RBRnVIbitrQVhXSkVaQ0h4SjZuT0c3UmdBTy82bDd6NnhqSFV0?=
 =?utf-8?B?YVhaNkFHa2xxcUdjUzZ2ZVZTbUhvNit6OFlyanB0SDJDeXZSaDRXNk9sYlMy?=
 =?utf-8?B?MUJTZmhCdVFRaUF6Rk12R2RvTzFUQkNQYUJJODZoNnpIT0Z1VFdxWGRHWDNY?=
 =?utf-8?B?VGpzdE42TzU1UVRFZVFCdVZ3WlE0bE9vclJFd2s4WThwMzBXZmJ2TTdyRVFD?=
 =?utf-8?B?aFQxS1BpUFU1UGlkb0oxN1kyWkRFRkZDQnB0ZmYxY1p5SXFKM09tc2h2eEI3?=
 =?utf-8?B?YXBrNEVzbTlWbnVVTzNuV3A3V3ZCWXVlU21Cem54TUdCTUducTVpWStpOU9z?=
 =?utf-8?B?blR6QmJYRm8vOVdzQ0ViYnVuQWdrOFRZRXdDV2tnRk5yM2hOYTRVd2tHdWpw?=
 =?utf-8?B?U01hMW9kS2E5aXkzUkZhdFR1S0ExbHI5aVgvTkcwQzBsaWkzdXByNzQ1VzYx?=
 =?utf-8?B?UllnNWZlVnM3c1kxMnVUa3ZrTnJOd1pVSXZUWmRHYjNuMjZ1YjVvWFpJRFlB?=
 =?utf-8?B?eHJYRVVrZTNGSDlrR1R4V01vZzRoajVhT1UrNkZyOXlkb0xPRHZYMW1KMSt2?=
 =?utf-8?B?UEFSUVV6OHF4RWN4cGxESEp5cEZXTWdTaTduNTgrOFV1TklrbnlBS1Q5R1Y0?=
 =?utf-8?B?b1RIaFp0ZHlSTWFEZ0IxOGt3R2Nhc1dlQ0RqNS9NdW9ra3p6cTNBZWVSOU5G?=
 =?utf-8?B?cDF6NzVRU0lqdm1raXVpcDVwY01tekN6V2RlSVlacktVQm5QUDNyOTJERHdh?=
 =?utf-8?B?c0psRHVXVGNRV1dBVzkweUNrV2pkQ1VHUG5iM3ZDb2xQa29LUDJtRE5PY2tn?=
 =?utf-8?B?WlNrMk04cjQvOEpkcUFJWmY2UHpnUFZTT0V0UnNDZDdxWjU5Y0ZGR3luc1Q3?=
 =?utf-8?B?RnF3eU9kOU9PYXQ3MFphWXJCbHVFcHJtSnl0OVVPb1JzUkRLV1VKWHNUek1N?=
 =?utf-8?B?TU85aWUxMi9RTmVHYkt4L0kxZ0dxTElweDJqQkFVbjJ3bzZWL0I2amxRSDlk?=
 =?utf-8?B?NGlUUjZqWXo3Z1FjbXlpM2oxM1Y2WlVXS1NhZTNSUElFY2VBTjFTaW1CcmZq?=
 =?utf-8?Q?i/Yk6lRFF1fYRBk/o5WKsCZT7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42482409-41a6-4c67-b7b2-08dd5cc6883b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:49:51.7304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5airIAsu6Xcoop60IDCxJf3L5ooBn7zeb5AD/3f/AFvZW2qdL0Jdz6twmZEBAqdmMCoxrXafl5t4omrUqCguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
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


On 2025-03-06 1:03, Emily Deng wrote:
> Issue:
> In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
>  has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
> is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
> continues execution and reaches svm_range_from_addr. This results in
> a "failed to find prange..." error, causing the page recovery to fail.
>
> How to fix:
> Move the timestamp check code under the protection of svm->lock.
>
> v2:
> Make sure all right locks are released before go out.
>
> v3:
> Directly goto out_unlock_svms, and return -EAGAIN.
>
> v4:
> Refine code.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 +++++++++++++++-------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d04725583f19..83ac14bf7a7a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  		goto out;
>  	}
>  
> -	/* check if this page fault time stamp is before svms->checkpoint_ts */
> -	if (svms->checkpoint_ts[gpuidx] != 0) {
> -		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> -			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> -			r = 0;
> -			goto out;
> -		} else
> -			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> -			 * to zero to avoid following ts wrap around give wrong comparing
> -			 */
> -			svms->checkpoint_ts[gpuidx] = 0;
> -	}
> -
>  	if (!p->xnack_enabled) {
>  		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>  		r = -EFAULT;
> @@ -3040,6 +3027,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  	mmap_read_lock(mm);
>  retry_write_locked:
>  	mutex_lock(&svms->lock);
> +
> +	/* check if this page fault time stamp is before svms->checkpoint_ts */
> +	if (svms->checkpoint_ts[gpuidx] != 0) {
> +		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> +			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +			r = -EAGAIN;
> +			goto out_unlock_svms;
> +		} else
> +			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> +			 * to zero to avoid following ts wrap around give wrong comparing
> +			 */
> +			svms->checkpoint_ts[gpuidx] = 0;
> +	}
> +
>  	prange = svm_range_from_addr(svms, addr, NULL);
>  	if (!prange) {
>  		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
> @@ -3165,7 +3166,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  	mutex_unlock(&svms->lock);
>  	mmap_read_unlock(mm);
>  
> -	svm_range_count_fault(node, p, gpuidx);
> +	if (r != -EAGAIN)
> +		svm_range_count_fault(node, p, gpuidx);
>  
>  	mmput(mm);
>  out:
