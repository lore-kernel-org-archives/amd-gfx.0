Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12182CF34B0
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 15:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B750A10E878;
	Thu,  3 Oct 2024 15:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MN8ErF74";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56EE10E878
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 15:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUN7f1T3LzTpLM6Bj0f+D1vjUU0zwgJQHsX1t1xtRpk487ccvFBK5PyqRt2o9TZR2LS8rM6+6OMh2h3QvOID9K8NvYhnyowFYylL2ISRld7E9Kgsu+X7w0ThEGZh1bEyyvv7+ufvV3Omx6vJMvEIx8jBkgtK0NFZT86N7Vlq/FBesGMT/5O95c2ZLUVHYhz/QUVEi2MsCVkA5J5l2Xf0fKE2HSfciDKk7cMJQ51avAB1S85hjzBNRv56jfBEnbO1MIxu7/QfDsvfOU48gbF/6U5ddpP9I8bpnohuWRgMuGRaKouWFhUoxUyF6iZ5NENKnuWgwnSzujAFjjjr/7Fljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/1y5hMRhV7L4bVevgGFHyuqy0FnvMS7H60wMafIvls=;
 b=gMrAESyNqGjUvx5h73NPgoZy2URsm+PKv7s/zSsqcirUwzKRMXu0R4QEKD+s5/si0XeHyryfT0mY9Y1p1JyeJWAGHeU77hIfKmOnrEKfnWk1hmL+ByPVv5tRixABUZLfedZnFnDO6ilKcplAwnyCI2up0gQHz3fICYu1Am7KzEM47S0kqigQfRfYXOzCFoDx3ngN699xO/TUWFVJ32Hepa7kXfju7PgDq4Kq6UeAFMsObkSCijr9zR9A0g/S5rdyS3zE2oeVRdOzBySL7oqUB3gYQkI+TlvOF+SlDltT1DMBfWmDYe9XRyBG+fHQi+OzSjGhfRQgsKSMueb80ENn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/1y5hMRhV7L4bVevgGFHyuqy0FnvMS7H60wMafIvls=;
 b=MN8ErF74N1eXUjm7FZKUXe3ZeQ1NmBiHCckfFRjtxDIadibrKlf00RGD8w90vOglWHivYPTZGkTmFvrIF7SNqkcikkjZ74D913nE2ZG1JSo+jiyaFWIIEmO3YLMkWqV0U4+jZzgw64yHPFDWH7hvR0iFWRATxi40wooMtUMuldY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 15:07:45 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8026.014; Thu, 3 Oct 2024
 15:07:45 +0000
Message-ID: <fae065a5-d5e2-4c2e-8700-295f236d793d@amd.com>
Date: Thu, 3 Oct 2024 10:07:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Add kfd driver function to support hot
 plug/unplug amdgpu devices
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241001223836.129671-1-xiaogang.chen@amd.com>
 <b5b5b926-72fa-4092-a815-8dabce9d1c74@amd.com>
Content-Language: en-CA
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <b5b5b926-72fa-4092-a815-8dabce9d1c74@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0404.namprd03.prod.outlook.com
 (2603:10b6:408:111::19) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d3aca6-e65b-41de-d15d-08dce3bd22c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHN0OFNGUW9ESmpLT25leVhYVGNGa2lvZVMvU1N6ajZQN0p6V1NHbmhwcFF5?=
 =?utf-8?B?Rk4rdkNNR05UcXFQaDczTGkzUWw0dDEvQWc1Vkg0SlZPNGNnaGNEdGduZGtx?=
 =?utf-8?B?ZXBFWldsaWVqWlRXLzM1NFBvMHVQSDJUTnYvYWRKYTdEbTJiUG9nNzZwMitH?=
 =?utf-8?B?RmlTMmVqdkZoWWRtWVU1S0tha0FPYzN4RENXWUhHMnBzUWtoNXZ6VVh2aUZC?=
 =?utf-8?B?SXFQS2JoSjJuTk5QUU1BUEpwdVdXcUdteTVOREJTdlRod0ttOGF3cVJXQ096?=
 =?utf-8?B?MmJwT2lDdjM3dmZBNWdLdGpWcC82VWRJRzRvRjBhc2d2UzdHSi9RNUNBb1Vi?=
 =?utf-8?B?TzZqVG5MaDBNVFRXTTUwU1IrSzBqTTNvdzNTbTgzYTd3WG5ES05QUitQVm1M?=
 =?utf-8?B?T2FhRzltZVFQdjFqZEptaHdldEp5NE9pNVRJaXM1RzhkWmJSUnEyaXc4R0Nz?=
 =?utf-8?B?L1haUFhER29YdzBUVWlTejc4NkY2T2tSYk9MQmw5UnhubmpzNkVBeThGVVlE?=
 =?utf-8?B?b3UzMEdqbUxnSUtJQkx4eVNWOWFvWWwwL01DbWVPZ2FlWGJPWFpWNWx1aDdZ?=
 =?utf-8?B?L3RzUC9Sd2R2VVoxZWhuaGtjK0wrMXFlQm1vR2ZyYTFRMzZXNWVDUWdPZTlq?=
 =?utf-8?B?SDBRaEZVS25wUUVHWTFBS1puTkRHNmFOWlFPaUtuejhkaWlnZkRHaWErZlRG?=
 =?utf-8?B?R0Z6dHk4ajZ6cjRUUkxKOUlJRFpwcWtJVDRiL2ZpajhjRVJiSVlLTytINGFV?=
 =?utf-8?B?YTk1RG1iSlppb1p3MXlndStqNXZzdmM0dis2SVpCdHhLQ2gxQXRtNzc5aVhX?=
 =?utf-8?B?cDhHaEdSMllRTXhnNkJmOVBUZDd5N2tKQjk4WFV0enMwWkc1WlYxOENSWThu?=
 =?utf-8?B?c1kwbzBqRmNQdnZJZ2lNd1VLdDE1aTF5VkI5U0R1c2t4YVZaOUdxUi9CZk9p?=
 =?utf-8?B?aVFTLy9kVnk5Z3liSDV0OGxza0dENDMrYlFyTHlWL1FnZXdjdVFDelNBMjhQ?=
 =?utf-8?B?SlhZRURDUVpYZzNlaE5oc1RoYkFrcHJUSDAwVWFDQ0pCbExFZFRBTE1RdkM1?=
 =?utf-8?B?QkNXd1VONGZLZ0N5VjZmcjhZallSeGdkRkdSOHB6dWZtU3labXN3VnF1SGFF?=
 =?utf-8?B?bGI4bzU4Q0wyYXFZWTQ5RVBpR3Bpb0doVEVsb08vZzZuZGVHMTQ0Ym52YStM?=
 =?utf-8?B?YnhOcTRnMGhGZjZlUDBqTFU3Q1Ztd25KT1ZqMCt4dTFkd3Y5cUVXS3NmL0ti?=
 =?utf-8?B?SFd3aXBaWDhnM3RvVzJvRENTRFV4N0NQUy9XbU9YbnFtKzRGK21qR2MvRVpN?=
 =?utf-8?B?Mkl3dWVHSjRDUHNESFZhQm93TEd3Y05YWjdYL3pYdm81Umsza2JvYWx4cEdr?=
 =?utf-8?B?T0RYRml1VmM3YkF2Q1hIQVFzM2s2SlFZa3IxQTRFWUpHN2hJSGVtUDhzVWFT?=
 =?utf-8?B?eEgyMTFqS2NvaUJ4WUtVZE9GVFJ5bVlBbHhJTlkrN3ZpMmRzMXJTQWFKc0h3?=
 =?utf-8?B?eC8ydEg4OEhPdDRubkdQaVIzRTQzRDMyN3V4dkJ1MGd6dFBLOTdxWUtRMkph?=
 =?utf-8?B?QlYzQVVaODZBSXZYcmdiVllQVHJGWVBhbGs4UUEzUFlDUlZyMTMxamIySVNa?=
 =?utf-8?Q?wAIoj498Nu0+KbmWp4mzTSUPChf/yhHqkOQZ2TxpqQXQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVh3dmNhMXJUN0RmUlNiQzRIN1F4UEpyaDlrRGllcEZFUm5vSlR3Sm5NQ2Nz?=
 =?utf-8?B?U1BKdmdPM0Z2WDV5MEprQ0VXRVcrcWl4NVpBMVdVS0JpcGZ0Q2VWZWhBcS96?=
 =?utf-8?B?aEE5QWpyclI0ekE1akdQbUpYQzR2R1dIaVFRb1dlSDFHMm94THprS2FUZklO?=
 =?utf-8?B?MTNBcUlSWDVxc3BHTFlvYW5vSUxwQ3FScnF3OFR0aGQ3QjZuL1luNW1YZi9Q?=
 =?utf-8?B?eTJlV050b2l5L2k0ZlQyVjZQSzBvcTVxTzM5bG1sOGs5WlFLekdRVHFXWEZL?=
 =?utf-8?B?ZlJEWkphc3g4TW9zUnptc1MyWFc3bXE4MXVaOVQ0dnQ4WWQreS9FcXVPM3ow?=
 =?utf-8?B?VmdtTXdLNGhVU3dpSkI1YUZyQ0tVTDNjbThWV2kzK2NWYm9OYUY2ZWZCVjVI?=
 =?utf-8?B?MEV1SGJIWWpha1ZTMmRNWmdpRFlpdFhVWlN5ZFJFSnJhTlNzTTQzR0wwck42?=
 =?utf-8?B?anlic1RaSExEd1gzdEZIZWg2WEk4Skxyemo4YzNKajFDV3lWUWE1WnhqSUh1?=
 =?utf-8?B?MjBBYjJvQVhNcWJUbUlmMnF4RTAvMWNzREI2eEtIMW44K0NvcW9ickdQS09R?=
 =?utf-8?B?S1hDV1hEZEVYcnR0eGVGaU5GVHpMdjJ4VW1iMi9GejFKeldrWExOdFcraUE4?=
 =?utf-8?B?RmdWRENnNE11ZlpraUMyRDd0RGNhZ1h3ZmhZRnhZQ2NzYWpvSzcwL3FPVHpk?=
 =?utf-8?B?cTNZa0ZsR0krTHkxNWFHTE1abk9xMEtQQXZQSGRVaEVkS1FJMGpwRFdhTFp4?=
 =?utf-8?B?WHQ4VzgzWEFPVWlFTDVHWTMzRXVpUVkwTDVUQmxsU3AySTd3Yml2QjF2SE12?=
 =?utf-8?B?YUtEMFhNcEFGU3NTajZqeGdRYUNWVG80QnBBQlBFbGZ4VjhxeFA2V1oxV3Nw?=
 =?utf-8?B?RVhubHVUSlRFS2g3Uk1NdHkxVG1vMzVNOE8vYjZ1N0VCamViUGZZRG9sc3VJ?=
 =?utf-8?B?L0tLeDRlMDlQVFdHSnNOTVdOS1NtVndrcUxqYy9tYjI1K050YWNKeGNYUG9S?=
 =?utf-8?B?YnBoZkRFSnlXNXc2T0tObUJqNWdvTGo4RldOdWdJSHZJdlhxRkljVjBYa1V3?=
 =?utf-8?B?a1dFWVpWZEM2MkUraXNJZlJ3bzYxRDJ0ODRpWllUMTR1QjRrWnMwYlI0czJm?=
 =?utf-8?B?TDRiZk1hSDdhcDJac3VFOEh3Wml0NnFDZmMyZFQ2NzRBM1c3a3BRWGlLVzRo?=
 =?utf-8?B?eFJqemlGaGpqTXVaZ2ZHL2huR0tiUEttRU95NndVUS9MQlJKQnpTSTQ0TDZy?=
 =?utf-8?B?WmwxbVdST3ZhaTRub1FtcXRpNmNwWVEzbm9qcGtGaVQ4KytHWjBQNFpBWnlZ?=
 =?utf-8?B?NHlDODVkVkVkVU8vRVhoVEFMdTRTN25URGpkUE9nVGpZN1dnZ0E1aTQxQi9x?=
 =?utf-8?B?MjVhd3A1N1h5YjQ1cUR1M1dFcVZ6ZXFVdFFPZUJVM2k5cjJjTXlwUkViMGJF?=
 =?utf-8?B?K0oydjA0eWliRXIwNUtCVG5oUUdMZEUwZG8vOHJVckRCV0djeU1GRVNhek5j?=
 =?utf-8?B?VG1sRHRGZnhQa3JlZ3QyTHVCTkR6TUJtblhxYm9EWGlQZ2pVbUlhQmdaWHVp?=
 =?utf-8?B?OUFsb2RwdkpXSFJja1RRY0dWbGsyWWJ0UCtPak9kUTJyY0xlQ3ZmRHRkNUVE?=
 =?utf-8?B?OTZZb2tOc0dvNFZjNjcvc3NXa1RYUzhveVlPTnlwc0l2bG52TkF3Y1dZNUEx?=
 =?utf-8?B?SHRVeWcrWFVGWTdsdlBXTmJSQlh0KzIvd1RiclBtVnh2N0xUcEVNWHNsS3k2?=
 =?utf-8?B?cGpjcEhwZjhJWTByR2pvS3cvNlFNd3dEdnFtcnNlVlorNGU4R0RURTlXYjJX?=
 =?utf-8?B?WXZ4QUk3NmxYQWlXNEV0ajVQaDlhRm9iOFFkcUU5RnZrVDZ2SlozSUc1akYw?=
 =?utf-8?B?di9JSjVzc09MYm9xdktFd2Y1Nk5tRUJJb0pUWGNDQlZZR2JETDlyVnBVTEVh?=
 =?utf-8?B?S1hmWmgrcm5zVVZxNVB1clJKUmYvVlV3dW5YZTg4ZE1DZ1I4N2Y5RjZXT2J1?=
 =?utf-8?B?WjJLWkR2MUJFRW9GMWFvMWZtSFgxME9OQTlYUzUvNGZqNU0rOGhVRzRYSGdh?=
 =?utf-8?B?b21oTXNIdXR1Wnc4MkdiaTAxd1RJWDZzR2FiOUV1czB1VGl1akNvREFSVXhC?=
 =?utf-8?Q?IvMI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d3aca6-e65b-41de-d15d-08dce3bd22c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:07:45.3846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlmFgMDh/cINxo2+lv5TTSt1zdpHXP9w0mo6ywiQJJwqHLYCCddM7cbeeG5vDKip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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


On 10/2/2024 1:56 PM, Felix Kuehling wrote:
>
> On 2024-10-01 18:38, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> This patch allows kfd driver function correctly when AMD gpu devices got
>> plug/unplug at run time.
>>
>> When an AMD gpu device got unplug kfd driver gracefully terminates 
>> existing kfd
>> processes after stops all queues, sends SIGTERM to user process. 
>> After that user
>> space can use remaining AMD gpu devices as usual. When all AMD gpu 
>> devices got
>> removed kfd driver will not response new requests.
>>
>> Unplugged AMD gpu devices can be re-plugged. kfd driver will use 
>> added devices
>> to function as usual.
>>
>> The purpose of this patch is having kfd driver behavior as expected 
>> during
>> AMD gpu device plug/unplug.
>>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 12 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 77 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 30 +++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  3 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 29 ++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22 +++++++
>>   8 files changed, 175 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index b545940e512b..f91a581dbbbb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct 
>> amdgpu_device *adev,
>>           kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>>   }
>>   +void amdgpu_amdkfd_teardown_processes(void)
>> +{
>> +       kgd2kfd_teardown_processes();
>> +}
>> +
>>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>>   {
>>       if (adev->kfd.dev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 7e0a22072536..93f54c930017 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -152,6 +152,7 @@ struct amdkfd_process_info {
>>     int amdgpu_amdkfd_init(void);
>>   void amdgpu_amdkfd_fini(void);
>> +void amdgpu_amdkfd_teardown_processes(void);
>>     void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>> @@ -431,6 +432,8 @@ int kgd2kfd_check_and_lock_kfd(void);
>>   void kgd2kfd_unlock_kfd(void);
>>   int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
>>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
>> +void kgd2kfd_lock_kfd(void);
>> +void kgd2kfd_teardown_processes(void);
>>   #else
>>   static inline int kgd2kfd_init(void)
>>   {
>> @@ -511,5 +514,14 @@ static inline int kgd2kfd_stop_sched(struct 
>> kfd_dev *kfd, uint32_t node_id)
>>   {
>>       return 0;
>>   }
>> +
>> +void kgd2kfd_lock_kfd(void)
>> +{
>> +}
>> +
>> +void kgd2kfd_teardown_processes(void)
>> +{
>> +}
>> +
>>   #endif
>>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1e47655e02c6..2c34813583b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3315,7 +3315,7 @@ static int amdgpu_device_ip_fini_early(struct 
>> amdgpu_device *adev)
>>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>   -    amdgpu_amdkfd_suspend(adev, false);
>> +    amdgpu_amdkfd_teardown_processes();
>>         /* Workaroud for ASICs need to disable SMC first */
>>       amdgpu_device_smu_fini_early(adev);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index fad1c8f2bc83..149ab49ea307 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -930,6 +930,9 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>       }
>>         kfree(kfd);
>> +
>> +    /* after remove a kfd device unlock kfd driver */
>> +    kgd2kfd_unlock_kfd();
>>   }
>>     int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>> @@ -1439,6 +1442,14 @@ int kgd2kfd_check_and_lock_kfd(void)
>>       return 0;
>>   }
>>   +/* unconditionally lock kfd, pair with kgd2kfd_unlock_kfd */
>> +void kgd2kfd_lock_kfd(void)
>> +{
>> +       mutex_lock(&kfd_processes_mutex);
>> +       ++kfd_locked;
>> +       mutex_unlock(&kfd_processes_mutex);
>> +}
>> +
>>   void kgd2kfd_unlock_kfd(void)
>>   {
>>       mutex_lock(&kfd_processes_mutex);
>> @@ -1485,6 +1496,72 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, 
>> uint32_t node_id)
>>       return node->dqm->ops.halt(node->dqm);
>>   }
>>   +/* check if there is any kfd process in system */
>> +static bool kgd2kfd_check_idle(void)
>> +{
>> +    lockdep_assert_held(&kfd_processes_mutex);
>> +
>> +    /* kfd_processes_table is not empty */
>> +    if (!hash_empty(kfd_processes_table))
>> +        return false;
>> +
>> +    /* kfd_processes_table is empty
>> +     * check if all processes are terminated
>> +     */
>> +    return !kfd_has_kfd_process();
>> +}
>> +
>> +/* gracefully tear down all existing kfd processes */
>> +void kgd2kfd_teardown_processes(void)
>> +{
>> +    struct kfd_process *p;
>> +    struct kfd_node *dev;
>> +    unsigned int temp;
>> +    uint8_t idx = 0;
>> +
>> +    /* unconditionally lock kfd driver to not allow create new kfd 
>> process
>> +     * will unlock kfd driver at kgd2kfd_device_exit
>> +     */
>> +    kgd2kfd_lock_kfd();
>> +
>> +    mutex_lock(&kfd_processes_mutex);
>> +
>> +    /* if there is no kfd process just return */
>> +    if (kgd2kfd_check_idle()){
>
> Missing space before {
>
>
>> + mutex_unlock(&kfd_processes_mutex);
>> +        return;
>
> This skips the dqm->ops.stop call. That probably makes it difficult to 
> keep ops.stop/op.start calls balanced.

Thanks for reviewing.

The kgd2kfd_check_idle checks if any kfd process exist in system. When a 
kfd process has been terminated its queues are 
terminated(dqm->ops.process_termination) and uninit by pqm_uninit. So no 
need to stop queues on a device when system does not have any kfd 
process. Here I stop queues on a devices when system still has kfd 
process at following code.

>
>
>> +    }
>> +
>> +    /* stop all queues from all kfd nodes */
>> +    while (kfd_topology_enum_kfd_devices(idx, &dev) == 0) {
>> +        if (dev && !kfd_devcgroup_check_permission(dev))
>
> This check only makes sense in the context of a specific process. As 
> far as can tell, this function doesn't run in a process context. It 
> needs to consider all devices.

This added function kgd2kfd_teardown_processes is called at pci_driver 
function remove(amdgpu_pci_remove) chain:

static struct pci_driver amdgpu_kms_pci_driver = {

....

.remove = amdgpu_pci_remove,

.....

};

 From include/linux/pci.h

* @remove:    The remove() function gets called whenever a device
  *        being handled by this driver is removed (either during
  *        deregistration of the driver or when it's manually
  *        pulled out of a hot-pluggable slot).
  *        The remove function always gets called from process
  *        context, so it can sleep.

The while loop( while (kfd_topology_enum_kfd_devices(idx, &dev) == 0)) 
iterate all current gpu devices at system.

>
>
>> + dev->dqm->ops.stop(dev->dqm);
>
> Where is the corresponding ops.start call that resumes execution on 
> GPUs that were not unplugged?
As explaining following I stop all queues at system when a gpu devices 
got unplug.
>
>
>> +
>> +        idx++;
>> +    }
>> +
>> +    /* signal user space processes their kfd processes terminated */
>> +    idx = srcu_read_lock(&kfd_processes_srcu);
>> +    hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)
>> +            kfd_signal_process_terminate_event(p);
>
> I would have expected that that you evict the process queues here, 
> similar to what happens after a GPU reset. Otherwise a process could 
> just ignore the termination event and keep working. Maybe there is 
> potential to reuse some of the GPU pre/post-reset code paths here.
>
> Using the GPU reset code paths would also allow you to kill only 
> processes that were using the unplugged GPU. Currently you kill all 
> processes.
>
My thought on "gpu unplug" is to terminate all kfd processes on system 
and their queues. The following call kfd_cleanup_processes() does that. 
When a user process open kfd node we create its context on each gpu 
device. When a gpu device got removed we do not know if this user 
process's works on other gpu can function well without the removed gpu, 
so I terminate all kfd processes.

I think GPU reset is different that after gpu reset we hope the gpu will 
be back. The gpu reset does not kill kfd process, it stop all queues on 
this device(kgd2kfd_pre_reset) and re-start at kgd2kfd_post_reset. For 
"gpu unplug" gpu has been removed, we do not know it will be back or 
different gpu will be added, so I terminate and clean kfd processes and 
their queues.

I think it is the main concern for this patch: when a gpu device got 
hot-unplug, should we terminate all kfd processes and their resources?

After gpu unplug the new kfd node open will use all remaining gpus.

>
>> +
>> +    srcu_read_unlock(&kfd_processes_srcu, idx);
>> +
>> +    mutex_unlock(&kfd_processes_mutex);
>> +
>> +    kfd_cleanup_processes();
>> +
>> +    mutex_lock(&kfd_processes_mutex);
>> +
>> +    /* wait all kfd processes terminated */
>> +    while (!kgd2kfd_check_idle())
>> +        cond_resched();
>> +
>> +    mutex_unlock(&kfd_processes_mutex);
>> +
>> +    return;
>> +}
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>     /* This function will send a package to HIQ to hang the HWS
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index ea3792249209..911080bac6d5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -1355,3 +1355,33 @@ void kfd_signal_poison_consumed_event(struct 
>> kfd_node *dev, u32 pasid)
>>         kfd_unref_process(p);
>>   }
>> +
>> +/* signal KFD_EVENT_TYPE_SIGNAL events from process p
>> + * send signal SIGTERM to correspondent user space process
>> + */
>> +void kfd_signal_process_terminate_event(struct kfd_process *p)
>> +{
>> +    struct kfd_event *ev;
>> +    uint32_t id;
>> +
>> +    rcu_read_lock();
>> +
>> +    /* iterate from id 1 for KFD_EVENT_TYPE_SIGNAL events */
>> +    id = 1;
>> +    idr_for_each_entry_continue(&p->event_idr, ev, id)
>> +    if (ev->type == KFD_EVENT_TYPE_SIGNAL) {
>> +        spin_lock(&ev->lock);
>> +        set_event(ev);
>> +        spin_unlock(&ev->lock);
>> +    }
>
> I'm not sure what's the point of sending a KFD event that needs to be 
> processed by the runtime, if you're immediately following it up with a 
> SIGTERM.
>
It follows the idea above that I want terminate kfd processes after a 
gpu got removed. Set all events from this process in case user process 
waits on them, then send SIGTERM to user process to indicate I want this 
user process terminate since a gpu device got removed at run time we 
cannot guarantee it will function well.


>
>> +
>> +    /* Send SIGTERM to p->lead_thread */
>> +    dev_warn(kfd_device,
>> +            "Sending SIGTERM to process %d (pasid 0x%x)",
>> +            p->lead_thread->pid, p->pasid);
>> +
>> +    send_sig(SIGTERM, p->lead_thread, 0);
>> +
>> +    rcu_read_unlock();
>> +}
>> +
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 6a5bf88cc232..141ff6511fe3 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1036,6 +1036,7 @@ struct kfd_process *kfd_create_process(struct 
>> task_struct *thread);
>>   struct kfd_process *kfd_get_process(const struct task_struct *task);
>>   struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
>>   struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct 
>> *mm);
>> +bool kfd_has_kfd_process(void);
>>     int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t 
>> gpu_id);
>>   int kfd_process_gpuid_from_node(struct kfd_process *p, struct 
>> kfd_node *node,
>> @@ -1161,6 +1162,7 @@ static inline struct kfd_node 
>> *kfd_node_by_irq_ids(struct amdgpu_device *adev,
>>   }
>>   int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node 
>> **kdev);
>>   int kfd_numa_node_to_apic_id(int numa_node_id);
>> +uint32_t kfd_gpu_node_num(void);
>>     /* Interrupts */
>>   #define    KFD_IRQ_FENCE_CLIENTID    0xff
>> @@ -1493,6 +1495,7 @@ void kfd_signal_vm_fault_event(struct kfd_node 
>> *dev, u32 pasid,
>>   void kfd_signal_reset_event(struct kfd_node *dev);
>>     void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 
>> pasid);
>> +void kfd_signal_process_terminate_event(struct kfd_process *p);
>>     static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
>>                    enum TLB_FLUSH_TYPE type)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index d07acf1b2f93..aac46edcaa67 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -844,8 +844,14 @@ struct kfd_process *kfd_create_process(struct 
>> task_struct *thread)
>>        */
>>       mutex_lock(&kfd_processes_mutex);
>>   +    if (kfd_gpu_node_num() <= 0) {
>> +        pr_warn("no KFD gpu node! Cannot create process");
>> +        process = ERR_PTR(-EINVAL);
>> +        goto out;
>> +    }
>> +
>>       if (kfd_is_locked()) {
>> -        pr_debug("KFD is locked! Cannot create process");
>> +        pr_warn("KFD is locked! Cannot create process");
>
> This is going to result in spurious warning messages that tend to 
> mislead people. If this is expected in the normal course of operation 
> of the driver, it should not be a warning.

Maybe change to pr_info? here want user see that kfd node open fail is 
due to kfd driver got locked or all gpu devices got removed.

Thanks

Xiaogang

>
>
>>           process = ERR_PTR(-EINVAL);
>>           goto out;
>>       }
>> @@ -1155,16 +1161,18 @@ static void kfd_process_wq_release(struct 
>> work_struct *work)
>>        */
>>       synchronize_rcu();
>>       ef = rcu_access_pointer(p->ef);
>> -    dma_fence_signal(ef);
>>   -    kfd_process_remove_sysfs(p);
>> +    if (ef) {
>
> This check is unnecessary. Both dma_fence_signal and dma_fence_put can 
> deal with NULL pointers gracefully. I'm not sure the reordering of 
> function calls here serves any practical purpose. If anything, it's 
> problematic that you're updating p->ef in a non-atomic way here. 
> Ideally the fence should be destroyed when all its users have gone 
> away. The current place after ..._destroy_pdds seems safer in that 
> respect.
>
> Regards,
>   Felix
>
>
>> +        dma_fence_signal(ef);
>> +        dma_fence_put(ef);
>> +        p->ef = NULL;
>> +    }
>>         kfd_process_kunmap_signal_bo(p);
>>       kfd_process_free_outstanding_kfd_bos(p);
>>       svm_range_list_fini(p);
>>         kfd_process_destroy_pdds(p);
>> -    dma_fence_put(ef);
>>         kfd_event_free_process(p);
>>   @@ -1173,9 +1181,22 @@ static void kfd_process_wq_release(struct 
>> work_struct *work)
>>         put_task_struct(p->lead_thread);
>>   +    /* the last step is removing process entries under /sys
>> +     * to indicate the process has been terminated.
>> +     */
>> +    kfd_process_remove_sysfs(p);
>> +
>>       kfree(p);
>>   }
>>   +/* check there is entry under procfs.kobj */
>> +bool kfd_has_kfd_process(void)
>> +{
>> +    WARN_ON_ONCE(kref_read(&procfs.kobj->kref) == 0);
>> +
>> +    return procfs.kobj->sd && procfs.kobj->sd->dir.subdirs;
>> +}
>> +
>>   static void kfd_process_ref_release(struct kref *ref)
>>   {
>>       struct kfd_process *p = container_of(ref, struct kfd_process, 
>> ref);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 3871591c9aec..7809ed0dbc95 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -2336,6 +2336,28 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
>>       return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
>>   }
>>   +/* kfd_gpu_node_num - Return kfd gpu node number at system */
>> +uint32_t kfd_gpu_node_num(void)
>> +{
>> +    struct kfd_node *dev;
>> +    uint8_t gpu_num  = 0;
>> +    uint8_t id  = 0;
>> +
>> +    while (kfd_topology_enum_kfd_devices(id, &dev) == 0) {
>> +        if (!dev || kfd_devcgroup_check_permission(dev)) {
>> +            /* Skip non GPU devices and devices to which the
>> +             * current process have no access to
>> +             */
>> +            id++;
>> +            continue;
>> +        }
>> +        id++;
>> +        gpu_num++;
>> +    }
>> +
>> +    return gpu_num;
>> +}
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>     int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
