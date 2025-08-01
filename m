Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5A1C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 16:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193B610E02B;
	Fri,  1 Aug 2025 16:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HsjaKt2w";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4577B10E02B
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 16:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0SpuMecURILDzoK/es6401t/f/jblI2cjk5r5OzheIVsEJPpPU1AHMUv3gLp6U9DDwWcw4ygYMofkPSsSzvkO/8A/ztyAZgVTfIGmkigO8p/8s/3qNraKpeyfUosadNbJ1aRVKgdPe3/5ROkZ6yRoS7NjONkk2/3kEFKxN+HtZUZtXTshcbcBbHEG9pXI/X4Bmbba808UEKecOoRXTcQCfL2Lq4MiIE1wOLWszfq8lQ+ea4j53AA+7OfCGeR/YQjLZTNfvd3NFNcndH/6D8jIRZAIZtAS+iqLWNo480E8O65xU9VF9WtPaqw/ttNLc1oMciReGVQyZoACLNMDuhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/1IE3PDKuMU4VINNOEQE59kk67D4UAavyms/IBi3cw=;
 b=kdUH7CS5w3zbwhC0DQrxywFkONik2mw3sYcgvEy4pU6QQaqUhrcecrIQtTXgbEzn6j4ZiiQ3QI3n0FU0ZJdPVufJPKzclc0kWlaP+2AmCKtN6suvA4FE5bLCBpLc+u7TWfiMEQGjsBjKtClScKGVI3GiAZZebF2GNSZMTWuGVmFJ93otO7YlrF6+L1moaqE561EYwHWf9j9iaQ3ohH24phaAKdtPh8gynIDXjSFxwQbwVJzjMQWkDKvQADzyLep09cLCI4UGI3KLguQ+RJ6CGhfItBoAcF5HIh+LZ3LxKKp0Mhq87puN6edwVzGiawQus3WsWMea+Gbprwx7jM0M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/1IE3PDKuMU4VINNOEQE59kk67D4UAavyms/IBi3cw=;
 b=HsjaKt2wAWKgSyUMC7Z318yMjadzM/E70AJ/4o+GAkNKm6MjaF6/AOhgtg1TxvrvUAWXUcOg/WhGNdkqUpKX2K6hSF1C5LIi/IWnDWWBwjK6EHSNfSpIRDwcdt7F6ol2EElxAlGdNLmEns/ZcGekYUXYlu2pgkiomO8tVV9r2ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 16:10:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 16:10:26 +0000
Message-ID: <d82d8f5b-f1d5-443b-a939-8e25717c6d62@amd.com>
Date: Fri, 1 Aug 2025 12:10:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/10] amdkfd: decommission kfd_get_process and remove
 DIQ support
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
 <20250801085556.8504-10-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250801085556.8504-10-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0246.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: a760a6c8-7afb-4c7e-6f20-08ddd115ed07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3RLK0xpNzdmV3IzNDAvbmRZZXVtMlhCemdnYlo2QlV1SVdodG5NdERKMmdx?=
 =?utf-8?B?ZWNIMW9mYWVuTVphcHVLdTZ2VkxxWmd0UlNqMFM4aXBhQmc0S0RpaUVDR0E4?=
 =?utf-8?B?RC9uMTVhOVVVeFcvZXRPM2x3U0tXRkhNMFFUcndnQ1FLV1ZXL2hoZGNFUTVy?=
 =?utf-8?B?ODNOOUVmQUZEWjhKaHVvMHlheHJTbUdNd0ljMFMrZ2NreVhjRGxWMkw5eDBL?=
 =?utf-8?B?YnYzYjVXWnR4KzIvTEJ0c2J3bUZrTVNRMGVXY2NKaStHY0hJcmVsQWJDaTFX?=
 =?utf-8?B?ZjkyRDNGMERGOWhUTkg5SlhacXp4NzRsSGh5Sy96Z1JsUFpYNDZOSk13K2RB?=
 =?utf-8?B?R2czQXdzVlRnVVVZU2tBZXYybmJjbWVYU3gxOENUaWNvOEs4Tms1REdBR0U2?=
 =?utf-8?B?WmJ5MjVrME1WVmhVeUpoZVdkVlpiWmY2MjVqTmVwTlZua21BV010OWx4TTla?=
 =?utf-8?B?RWxzSWQ2VzhTdEp0RzZCWWZoY1lsQ3NUM1hZdUJEZU04RXlReGVEUFllempF?=
 =?utf-8?B?VGZFbUFsQ0doYm03Y2pkRjc5Q3NTcHlheUY4Z0VzdE9XcWQvSWJYMDVpdzJy?=
 =?utf-8?B?UFpNNWRaQk05R0p3VmttYTdRQTVTSW13TGNESnBWNEY2K2pBd25rcjRJODA3?=
 =?utf-8?B?Ulh0My82emdkTHIxcFBDbUM0elVtS2xFL0JtWVJPejdLNlpvSnBvdGxWTGtF?=
 =?utf-8?B?R0o5WFlwRnF2d3hxYktNdlhRN2sySEduRlVoN2JrSWpkUm5KUVgzYTFGc3dS?=
 =?utf-8?B?dlZ6dXpTaWRjb2Q2eUlFNEYxMS9LSEhXR2lvaEhSUmNCbEJ3Y0lhaHAvQVpU?=
 =?utf-8?B?ejVBUGR3ZksvU1pDYlNjeis4QkdVeHRuclNMQ2EwYnZiUUduNndFak56bmtO?=
 =?utf-8?B?dzMxU3J4c1F3bGNmanVUaytuODNMTU5VcjlqMFlmYXJIbkUzT2ptZHNJcHM4?=
 =?utf-8?B?bUlXejFkSlZwKyt6SlJHRkFHOWJzWThDRVRBbGJNKytMRHJhTk1wWWZZbGEv?=
 =?utf-8?B?SVZYUTQyTUlkY0IrK2RacGEvQzF1Z0VUd3JmVkdiVzk2OG41enpFUG5pM2Q0?=
 =?utf-8?B?SHE3dGlFS3Jvd3F2a3NSQnZSMVNtMEMvYnRnU1VEVjBxRDBGR2FJdXVHczZ0?=
 =?utf-8?B?bFh3Vm5nNkJ1RHhvcURqK01PYzI1WFJtbzVjS01oYVRLTy9KelJ6WWRoKy9R?=
 =?utf-8?B?QWZlRXNFc0tDUU9iREwweCtBbVkzTE1FRmgzQmVmQXVJQXRZSFBqOEdqeTcw?=
 =?utf-8?B?OHFvM2poU1Y4UEppdTZrYWtGL1E4eHRYcGdhTGFIN3lVMzgvYnhVUnBiMDBE?=
 =?utf-8?B?SzdBVE50TExJTk1iTzFmM1JUOThMMlBYRFdJa2VObW1TNVY1WDN1bEJaQ3o4?=
 =?utf-8?B?NEt1RGUxZ01qL1VqTVJsQjhtUlNJMkFHd3BQaHpaZ0tCd3RjeWphRDFUcGFS?=
 =?utf-8?B?Rm5TcG1JV2IwZjhuOHpGL21YZDhCN013OXVOWmJ0M3ZvMm8wUksxcUxlSnNE?=
 =?utf-8?B?TUFkcmJmVlgzdkJvV1c1T2x3RkJkeFNCNU5VR3dQK1A3UHNGR0JseVpOcHQx?=
 =?utf-8?B?bDNDYmFnd1A4MEJwa1R5V0Vya0p4dndjTng1NjJZekJCeDhXS21oSHR0NVJQ?=
 =?utf-8?B?VXhOU0R3ekd1Vk1oblR1N043UTNDZk1GOC9ybUtuTXRvWkFoQ0ZhNE9rcytW?=
 =?utf-8?B?NFdOaU5WckFDcEN5YWIxY2lUZ2c3cHBLSWltRmRCY0kxZjdENTNjdmtpNkpK?=
 =?utf-8?B?c0tkSXU4UVI4MHRPcGpER0RiMUllOUpXdktGVDBVTVNMcjRmTnM4TWJQY04x?=
 =?utf-8?B?QmZNdGZRUS9ISHlmcmxMakVGZnlCWFl5YmExSUovODFxU1NSTExQTGJxOHlt?=
 =?utf-8?B?VjMwK1haa1hRZklPWCtSamVldHEwZjhla3QrOW9JY2U4UDJQTWdCckNtaU5V?=
 =?utf-8?Q?lTf7gt0HBGI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1U4dEZudno1MDZ3b3Y4VTNyNEM4TmdMZmk0SVlVa1paZWdpNDkvSWRyekxo?=
 =?utf-8?B?VzMzYjd0R2MwanErcTRyUk1RZzVJamRvQS85ZysvTXJyOGZtbjA0RUtPelBh?=
 =?utf-8?B?RVBBSlM0MXBjTDBtajJrc1d2N2MxdGRUS0NMY0F3QTNSNmtsOHUzZ0J3RjB0?=
 =?utf-8?B?UHlJaU9JQ3B2NGwyMURuQnRUa0xjQ3cxTFFBdGNWelN3QkJTQTRFeXZnQTBE?=
 =?utf-8?B?VWhRN2FvZXU3ZWxJZ3VQOWdscC80M3Q3Wml6enNEdnFDbzJKaEF0cmJmUU9k?=
 =?utf-8?B?ZmZmSCtZS1ZWNyt4NUUwNDN0TWFuMWE0YkhSZkpUS1RDS0NLTzFNVG1aUUpC?=
 =?utf-8?B?UCtMZTNKWkdyZTFjdU9wamRJZjdnSEdBUUxBZndrM3krcnZlRzJnaGd4bldX?=
 =?utf-8?B?WVVWL2J6WEEwQTVtbWZxUEk4azU4aGVTalh5UUw1MW8xUVI2Mk05VSt3dHUx?=
 =?utf-8?B?MFBrSXVwR3dwYzVVTkovNWh3SDhGelhnK281Uko5SjdJYmU5SmRNajJIUWZZ?=
 =?utf-8?B?UEIwWVhia1VRRkNmTmJLdWkzU2RVZkp5T2dmeTl3SFl3MlJEeGNyN3RWbDRM?=
 =?utf-8?B?TVpQd2g1bG9XbG5WdzRFRmtNSHc0THRXNG5XcnNRZDBEVzNsWVFuSnJRQ3Q4?=
 =?utf-8?B?R2dQZGQ5TFRqNGxVeXVnNXVZQVA2VzdibkdkMlVDWk15bzRrc3QxM0VubW5h?=
 =?utf-8?B?dktKWEdxbjRETUNqc2hDNS9BVTBnQlEybDlMZjVlcFdkdVJpN3dSSGlvQ0VD?=
 =?utf-8?B?aiswUjlHTkpHNFBPOXp5NEhxNmhadDZyQ3FRZzlQZVdHdHJJSWxmU2VTaURp?=
 =?utf-8?B?MGZEbERrcG1wUVU1QnlGTEphbk1hUXVwaDBWZTBqZVBNa1MwOUR5UXBWYU5D?=
 =?utf-8?B?eDNEM3pFVEovbm9mSktLdVhzbW04YktqdGsrNkwyNmV2WTJscXRBNmk0RzNM?=
 =?utf-8?B?VzFDNlZYWXpOYmpTZFp0OGN3NXpRbE1DVVppdzRNQU5WMkZEU2doVCtzQ3FI?=
 =?utf-8?B?QnhEK0RZM0kxMEc5NCs3Yklmd2FLc2NReHlJOVNKV3BJY29WYmcxK1F4SWhk?=
 =?utf-8?B?cVQreW9lUysrdzNYNUdOcGsxNGkyMUlHblJTQ0hNTUk5TlNqZC9COTFXdjJa?=
 =?utf-8?B?UzNrZzBOUHZMZ3ZFN0RGZGhIbFBqdmRUSW04Ukg0M3hpQmZNVDMzaGNSWENl?=
 =?utf-8?B?cWp3c1RZdWo3QzZRUDRIaFlWVll6YTBaNktSMkVwbGhjT09BRGI2MFFYdEJE?=
 =?utf-8?B?VDdKdXdTbkNnWDd5c2cva2pGMTA4bnRCT2M3U2tRUnF0QlJVWlVvMW94RlBz?=
 =?utf-8?B?cFVMZnJWTEt0UEdJR0RTaFpGQld6Nk5WRUsrRHpmeEhKUmJRUTRJdkcvbEdj?=
 =?utf-8?B?RmVGQ24vS3lNODVQRmpLMm5iM1l0REpaR2dkYjFQcWJaMkU0dkQ0ZVhNZDRw?=
 =?utf-8?B?R1ZObnV0UzNRM2J4bzJHcnVtd0IzTDJROHR4SjF0RVB1WGs5eDZ4NFVnQUo4?=
 =?utf-8?B?WjBmeU5BaFFWYU1mZElsK2c2Z2tqTlVSQlV4cGJIUlFjY012MDNkUFM1OFpB?=
 =?utf-8?B?anR0V1VqNXlNNWU5all0cGNlcE4wU0hXeDYrWmJka1VaRkZkRnFKd2hnMDJq?=
 =?utf-8?B?VFhHZXZsT3RsU2lya2hjM1ZDSm5LVWs1a1VmYVVHMGxWdVhIQ3B2OWdoSTdo?=
 =?utf-8?B?b0xVRG9xaU4vWE0rMGRiU3FOak1TemI0VkFFQnp6bHM1VEtvTUF5NWM2Z2Ev?=
 =?utf-8?B?c3BSL0paYzRiMzZteklmR0l5WFY4cGR5SGcyNVJnSmJWcjJUczVFOENtWXVl?=
 =?utf-8?B?UDJvRnFNNU9pMm9scHgrY0dzZUVrYzFqV1dRZjBQSHFpOHpGZ3RRWG9ZWXNC?=
 =?utf-8?B?QjlOM1l4N1FNUDNIK3VoVFdxMEVYSnp6Vjk0MHBqelc2eUJzU3JWNTFPYXY5?=
 =?utf-8?B?WllKMGcvL2daVnNGeWJQVi9yTGxESXNuMzM2Uyt2YUtiVmdkd1h5MmFjUktz?=
 =?utf-8?B?eTc1djVQd1lBbDNBK1RMa2hyMm5XekhIN1RVUkdyMUhKNlJLNDFnRVNVeVEw?=
 =?utf-8?B?dHZBV1ZVQkdSTERYTjhKQmRkWE9xYzdNQjR5SkphdzBvN1F4SDBNaGhTU0ty?=
 =?utf-8?Q?Hco18usaL6CbZr0SiDczPjpS0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a760a6c8-7afb-4c7e-6f20-08ddd115ed07
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 16:10:25.9430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npjSBGfXX4gIMFDzwMmOv+PBGyrMuDufiNT1leIzTAXpS8B0zqMqWDxhvbO+3lYyx4606lrYrW1sbJYg4f4XDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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

On 2025-08-01 4:55, Zhu Lingshan wrote:
> This commit decommissions the function kfd_get_process()
> because it can not locate a specific kfd process among
> mulitple contexts.
>
> This commit refactors the relevant code path accordingly:
> - kmmap: retrieve the kfd_process from filep->private_data
> - kq_initialize: queue->process for HIQ should be set to NULL
> because it does not belong to any kfd_process. DIQ has been
> decommissioned in this commit because it has been marked as
> DEPRECATED since 2022 in commit 5bdd3eb2
>
> This commit removes test_kq() function becuse it has been
> marked as unused since 2014 and no other functions calls it.

Please split this into 3 commits:

 1. Change how kfd_mmap looks up the process
 2. Remove DIQ support
 3. Remove test_kq

See one more comment inline.


>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 11 ++--
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 60 ++-----------------
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
>  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 35 +----------
>  8 files changed, 16 insertions(+), 123 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 5b22e1c47b2e..9e95acd23889 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3408,16 +3408,19 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
>  }
>  
>  
> -static int kfd_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
>  {
>  	struct kfd_process *process;
>  	struct kfd_node *dev = NULL;
>  	unsigned long mmap_offset;
>  	unsigned int gpu_id;
>  
> -	process = kfd_get_process(current);
> -	if (IS_ERR(process))
> -		return PTR_ERR(process);
> +	process = filep->private_data;
> +	if (!process)
> +		return -ESRCH;
> +
> +	if (process->lead_thread != current->group_leader)
> +		return -EBADF;
>  
>  	mmap_offset = vma->vm_pgoff << PAGE_SHIFT;
>  	gpu_id = KFD_MMAP_GET_GPU_ID(mmap_offset);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 76359c6a3f3a..3f78e0bb2dae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -399,8 +399,7 @@ static void increment_queue_count(struct device_queue_manager *dqm,
>  				  struct queue *q)
>  {
>  	dqm->active_queue_count++;
> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
> -	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>  		dqm->active_cp_queue_count++;
>  
>  	if (q->properties.is_gws) {
> @@ -414,8 +413,7 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
>  				  struct queue *q)
>  {
>  	dqm->active_queue_count--;
> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
> -	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>  		dqm->active_cp_queue_count--;
>  
>  	if (q->properties.is_gws) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 2b0a830f5b29..6aa8b0348bad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -46,7 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>  	int retval;
>  	union PM4_MES_TYPE_3_HEADER nop;
>  
> -	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ && type != KFD_QUEUE_TYPE_HIQ))
> +	if (WARN_ON(type != KFD_QUEUE_TYPE_HIQ))
>  		return false;
>  
>  	pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ,
> @@ -61,14 +61,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>  
>  	kq->dev = dev;
>  	kq->nop_packet = nop.u32all;
> -	switch (type) {
> -	case KFD_QUEUE_TYPE_DIQ:
> -		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_DIQ];
> -		break;
> -	case KFD_QUEUE_TYPE_HIQ:
> +	if (type == KFD_QUEUE_TYPE_HIQ)
>  		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
> -		break;
> -	default:
> +	else {
>  		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
>  		return false;
>  	}
> @@ -144,7 +139,8 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>  		goto err_init_queue;
>  
>  	kq->queue->device = dev;
> -	kq->queue->process = kfd_get_process(current);
> +	if (type == KFD_QUEUE_TYPE_HIQ)
> +		kq->queue->process = NULL;
>  
>  	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
>  					&kq->queue->properties);
> @@ -162,24 +158,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>  		kq->mqd_mgr->load_mqd(kq->mqd_mgr, kq->queue->mqd,
>  				kq->queue->pipe, kq->queue->queue,
>  				&kq->queue->properties, NULL);
> -	} else {
> -		/* allocate fence for DIQ */
> -
> -		retval = kfd_gtt_sa_allocate(dev, sizeof(uint32_t),
> -						&kq->fence_mem_obj);
> -
> -		if (retval != 0)
> -			goto err_alloc_fence;
> -
> -		kq->fence_kernel_address = kq->fence_mem_obj->cpu_ptr;
> -		kq->fence_gpu_addr = kq->fence_mem_obj->gpu_addr;
>  	}
>  
>  	print_queue(kq->queue);
>  
>  	return true;
> -err_alloc_fence:
> -	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd, kq->queue->mqd_mem_obj);
>  err_allocate_mqd:
>  	uninit_queue(kq->queue);
>  err_init_queue:
> @@ -209,8 +192,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
>  					kq->queue->queue);
>  		up_read(&kq->dev->adev->reset_domain->sem);
>  	}
> -	else if (kq->queue->properties.type == KFD_QUEUE_TYPE_DIQ)
> -		kfd_gtt_sa_free(kq->dev, kq->fence_mem_obj);
>  
>  	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd,
>  				kq->queue->mqd_mem_obj);
> @@ -358,34 +339,3 @@ void kernel_queue_uninit(struct kernel_queue *kq)
>  	kq_uninitialize(kq);
>  	kfree(kq);
>  }
> -
> -/* FIXME: Can this test be removed? */
> -static __attribute__((unused)) void test_kq(struct kfd_node *dev)
> -{
> -	struct kernel_queue *kq;
> -	uint32_t *buffer, i;
> -	int retval;
> -
> -	dev_err(dev->adev->dev, "Starting kernel queue test\n");
> -
> -	kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_HIQ);
> -	if (unlikely(!kq)) {
> -		dev_err(dev->adev->dev, "  Failed to initialize HIQ\n");
> -		dev_err(dev->adev->dev, "Kernel queue test failed\n");
> -		return;
> -	}
> -
> -	retval = kq_acquire_packet_buffer(kq, 5, &buffer);
> -	if (unlikely(retval != 0)) {
> -		dev_err(dev->adev->dev, "  Failed to acquire packet buffer\n");
> -		dev_err(dev->adev->dev, "Kernel queue test failed\n");
> -		return;
> -	}
> -	for (i = 0; i < 5; i++)
> -		buffer[i] = kq->nop_packet;
> -	kq_submit_packet(kq);
> -
> -	dev_err(dev->adev->dev, "Ending kernel queue test\n");
> -}
> -
> -
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 505036968a77..3d2375817c3e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -252,10 +252,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>  			packet->bitfields2.queue_type =
>  		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>  		break;
> -	case KFD_QUEUE_TYPE_DIQ:
> -		packet->bitfields2.queue_type =
> -			queue_type__mes_map_queues__debug_interface_queue_vi;
> -		break;
>  	case KFD_QUEUE_TYPE_SDMA:
>  	case KFD_QUEUE_TYPE_SDMA_XGMI:
>  		if (q->properties.sdma_engine_id < 2 &&
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index a1de5d7e173a..60086e7cc258 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -166,10 +166,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>  			packet->bitfields2.queue_type =
>  		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>  		break;
> -	case KFD_QUEUE_TYPE_DIQ:
> -		packet->bitfields2.queue_type =
> -			queue_type__mes_map_queues__debug_interface_queue_vi;
> -		break;
>  	case KFD_QUEUE_TYPE_SDMA:
>  	case KFD_QUEUE_TYPE_SDMA_XGMI:
>  		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a6e12c705734..67ebdaa9995f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1047,7 +1047,6 @@ void kfd_process_destroy_wq(void);
>  void kfd_cleanup_processes(void);
>  struct kfd_process *kfd_create_process(struct task_struct *thread);
>  int kfd_create_process_sysfs(struct kfd_process *process);
> -struct kfd_process *kfd_get_process(const struct task_struct *task);
>  struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
>  						 struct kfd_process_device **pdd);
>  struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 117e524f4fb3..2d01356627ef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -989,24 +989,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>  	return process;
>  }
>  
> -struct kfd_process *kfd_get_process(const struct task_struct *thread)
> -{
> -	struct kfd_process *process;
> -
> -	if (!thread->mm)
> -		return ERR_PTR(-EINVAL);
> -
> -	/* Only the pthreads threading model is supported. */
> -	if (thread->group_leader->mm != thread->mm)
> -		return ERR_PTR(-EINVAL);
> -
> -	process = find_process(thread, false);
> -	if (!process)
> -		return ERR_PTR(-EINVAL);
> -
> -	return process;
> -}
> -
>  static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
>  {
>  	struct kfd_process *process;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c643e0ccec52..287ac5de838a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -345,7 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  	 * If we are just about to create DIQ, the is_debug flag is not set yet
>  	 * Hence we also check the type as well
>  	 */
> -	if ((pdd->qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
> +	if ((pdd->qpd.is_debug))
>  		max_queues = dev->kfd->device_info.max_no_of_hqd/2;
>  
>  	if (pdd->qpd.queue_count >= max_queues)
> @@ -426,22 +426,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  						    restore_mqd, restore_ctl_stack);
>  		print_queue(q);
>  		break;
> -	case KFD_QUEUE_TYPE_DIQ:
> -		kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_DIQ);
> -		if (!kq) {
> -			retval = -ENOMEM;
> -			goto err_create_queue;
> -		}
> -		kq->queue->properties.queue_id = *qid;
> -		pqn->kq = kq;
> -		pqn->q = NULL;
> -		retval = kfd_process_drain_interrupts(pdd);
> -		if (retval)
> -			break;
> -
> -		retval = dev->dqm->ops.create_kernel_queue(dev->dqm,
> -							kq, &pdd->qpd);
> -		break;
>  	default:
>  		WARN(1, "Invalid queue type %d", type);
>  		retval = -EINVAL;
> @@ -1128,24 +1112,9 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
>  			mqd_mgr = q->device->dqm->mqd_mgrs[mqd_type];
>  			size = mqd_mgr->mqd_stride(mqd_mgr,
>  							&q->properties);
> -		} else if (pqn->kq) {
> -			q = pqn->kq->queue;
> -			mqd_mgr = pqn->kq->mqd_mgr;
> -			switch (q->properties.type) {
> -			case KFD_QUEUE_TYPE_DIQ:
> -				seq_printf(m, "  DIQ on device %x\n",
> -					   pqn->kq->dev->id);
> -				break;
> -			default:
> -				seq_printf(m,
> -				"  Bad kernel queue type %d on device %x\n",
> -					   q->properties.type,
> -					   pqn->kq->dev->id);
> -				continue;
> -			}
>  		} else {
>  			seq_printf(m,
> -		"  Weird: Queue node with neither kernel nor user queue\n");
> +			"  Weird: Queue node with neither kernel nor user queue\n");

This message is no longer accurate, since this function no longer handles kernel queues at all.

Regards,
  Felix


>  			continue;
>  		}
>  
