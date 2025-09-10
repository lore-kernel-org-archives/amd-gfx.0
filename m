Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67885CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 19:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F32510E9D7;
	Wed, 10 Sep 2025 19:56:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Mdn1j21";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B439110E9D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 19:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmJmk/AvWUuFd0gJ07P3f09zBRK81B4zrj3brPfNDR+gNXynYATcjJqx+qZhZIur243y8ah26Ugf7ijKxEsgCaPuihuW+v067OxFwUXz595eb7L+HZcVE2t8TMiP2ngzb9xtDdarHc2ZEqIHaQT+uoqbq9c4jsLXjcYygQvZoP5ieqUWVnleGHHg58P3lhHXsEiTgmldjYAswStHcUnsUVz1U+bhLvNjHN3V07xj4Yh3FEbhIvABABkaoIeqMz0sx/98fGI/p/ClreZ4ALJ4A+GVvVVCeEgPlNXIbE7iWEY6rChYvGSIjQxv4uP/nAh6uGTKrTAlxjb4wxFM6jdJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MHYqi63Pooc2Sr95Ps0qqyZ2OE9wWyqHJaf7GBHMHc=;
 b=HpyDX1OFmClqbqpZwghnjmxW/r1podaF4IHtUht3xnVFVzIwoYBMOnwOBgqFzmz3NGjTBklWSj4kVOWZ3pIlf8lb7CsgxgYk74POH5iljlQuY5Oxt6lThw9mCZpPmCkbbov+kSq7KA+hwsS+/mweoN0cRzwGMNSPJ31Un/kEBIctR1qs/DE3PREm0ZeRyuMQmj/mu5az+vaB9KDFlYKgFVkxmmesJgABfZgTeYPbh0kMvGZv8qWA3FB7/dCQrLHUZ0XKe7NJSP1bKhIvM+d3yG+04HFSA8OMeEuXzG5YTl1t7ADARJMZvSI2k/TWUCk4LBRPUiUpxe2i571YucfqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MHYqi63Pooc2Sr95Ps0qqyZ2OE9wWyqHJaf7GBHMHc=;
 b=5Mdn1j212zHmmcApT0lNtUrszIAFWnwCtewVK57cMpWDnJ9hph68XWuTbUQg3lCI0+HwEHhiGitnQoFNa8th1PugyXgHkh823v3YjlvLJzbaOsX4hQ2Ph7/Dl7Y1hG/B8rQvZZbIdmzHw+cKrHOEv+oHBBY8bd8nNHzNciRPxig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 19:56:19 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 19:56:18 +0000
Message-ID: <9332d236-c87f-e3a6-d799-adc65ee71017@amd.com>
Date: Wed, 10 Sep 2025 15:56:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] drm/amdkfd: add function
 svm_migrate_successful_pages
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.kuehling@amd.com, philip.yang@amd.com, chengjun.yao@amd.com,
 jamesz@amd.com
References: <20250908161526.99413-2-James.Zhu@amd.com>
 <20250909204259.103856-1-James.Zhu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250909204259.103856-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::35) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 8816686d-8ed3-4efb-2a0f-08ddf0a41bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Um1PZmJBd2ozajFmZklQVmpnb3U1cEF1cStLTW1DUWpHcEx6QzF4dXF3YlJL?=
 =?utf-8?B?bmdyRnY2eGRoeEdtWUgydmFhOHVmTmR2YkdMRzd5N0pLUmFsU1N5VHpQRXVt?=
 =?utf-8?B?VzZ3QkFVZE4vZ2xGenlPN1RxTG45TGN2bUl5ZnU1elBucUIrVTFucVFKV0sr?=
 =?utf-8?B?TFpWY3p5dG9WeTlUZVlWbGZOZFRWTit1KzVrWVBqcnFhU2FMd2VGZldQT1pG?=
 =?utf-8?B?TXdxNW5yZXQ4M2pGNzZ0NHdpZzU3ZjI3NVNNTk10NkVzNG9QaXlwOXlMWkxa?=
 =?utf-8?B?dWR3S0d5QStDWVluSDhTZzB3VnRDeHNNdGxLTGhURW1GUFRoa08rWWVQOElD?=
 =?utf-8?B?YXpjbU0wL05qUnc4cTJ4VmNQbmJObStDQlF1THFBOWFWaXJCbSs4L2E3TG5L?=
 =?utf-8?B?VGN5bkpaZnRGVEJ2RHIvT3JIcEM5ZHNxQ093bnBEdEFzbnp3YjFzeU96M1FQ?=
 =?utf-8?B?RGE5akwyZ3ZtN012ZS9nTGpubENSeWFKalZvYUZjUG9WR25MUWx4azhXMUxx?=
 =?utf-8?B?UmFwZ29tbEdSWURURUZoY0s1bEdlaXEvVVpNNkRRSU9xS1lHdWIzdCtlUUpz?=
 =?utf-8?B?ZDJhTk1RYk1WZTNnODhNRVd1bGNzWmFReFNhazUwakhmSUZyc2V4K2l5WTAr?=
 =?utf-8?B?amdQWTkxbktEN1VIUVBxbDF3eG96SlFPOHViVjVrUUNCM3hVY3dxN2dtQy9B?=
 =?utf-8?B?UEEwVjIxeThlZ3ZVb2U4b0RSVS9Zc0FYUVZ1Q2d1TklHc3NuWFZqejc2RkND?=
 =?utf-8?B?YlNnYmhMZU1ZSUN3SGxnVFh0QkxlaDBsZS9pN1Y1ME9OelNkUE12L1dDRlJJ?=
 =?utf-8?B?TWdpdnQrYy93N1QwL2srL1NTSXhGd2FwK3ptRE1lMTZDTlg1eW9Ec2FjV0Jo?=
 =?utf-8?B?WFI1YTR4c3lMSzZndTB4VVdZek5UbzNHcHJuK1R6U0NkbjlnSUlQTGV1NW05?=
 =?utf-8?B?SjAwZjNLclcyWXcySEZ1Q3JTbWxPdGVEbDFvbEFrTmxwS2pDd0dMN3E2Mmxu?=
 =?utf-8?B?SkMrODN4VlozZUdxeWdEd25PR0NKS2RFYTQzbmhnUUJrNzZpR3JXSTVSVGdE?=
 =?utf-8?B?K2w0N1VSV0EyQnI0Q1ovTUlUUEdrQWJIY1gwSlNNN2tFbVg4Ym1ocTBNckNK?=
 =?utf-8?B?VkRCcFJPTEFKNnpBM1dvNzU2VE50TUttZXVtMG05WmRLY1pSdG11NEw5bmY1?=
 =?utf-8?B?ZHVsc005N0dRN0hFU1JPbmZxUmRHVEc3N2xtTEE5RUpNVmtrc05Ydmk0TE9t?=
 =?utf-8?B?TWxqZ1ZIdzBEN01hWHNlM2p6Zm9PUWVNU0NPUEw5SDMrbWx1ZHZ2TnV1YnpW?=
 =?utf-8?B?NHRPdWtJSzZEY2duTGRPajl3UTI0MGdyOERwdjJyNkIrNzh0cE1LQ0NFTm5q?=
 =?utf-8?B?eTJEaTMxcTFLdk1zdkJHQ0lOTXBvTVFWQVVkTXN3aENtV3pxWll0S1ZPalZu?=
 =?utf-8?B?UlFVclB4SlM0bE5MK2JwUkRJcUV3dDdLZk1rTnJBdWdHcjBHQVIySm1ZOTFh?=
 =?utf-8?B?c2FZRGRDdHg4OFBNUG5uV2tWT1dxSzdJUTB6SDFkM205OTQ3cnU3ZUtMVThn?=
 =?utf-8?B?U25pUFZPSXhkeUo3aDdGbURMOXU2ckhGV3FVb05aM1QyK3MxU0hVSEZlYnk5?=
 =?utf-8?B?TjFDbG9qdmZ2UGZ4R0daZkhQV3hkakhyOVpNTlZPZi80TkMzZ1dKQm5uUUNC?=
 =?utf-8?B?bG1WSTlvZkFwdDM1L25vV2JjYUtydlJXeVJVRm5YRkc1WFkyaFVaMDNNQndl?=
 =?utf-8?B?RnVhNXpKUUdzMHdZZkMyWDRGdzNoVEpRT092cnIzOW5nZjNmbWdKYVBUdXRp?=
 =?utf-8?B?bTV5elhqUlV2Sm1nN1FvbTdERUdObG5KUUpoTTVHUHZFSUxjRzc0a2h6emFz?=
 =?utf-8?B?QWttYzI4RjNDZmNDZEpUR2NlWDFIa3RPR1Z0STZiWm9hZ3IxQ3NHOHRwSHh1?=
 =?utf-8?Q?w8XT5zTyJyM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJmSGpReGxqQUUzeG1Ga3RLSyttKy9sODFyaHIwSWtQN3dyRGhCbi9IYURG?=
 =?utf-8?B?T1hGRE04aWlsMzdheDN3dkxGU0FvSkZUbnV4T2RqTWRNVktmZy9kenlGUXIy?=
 =?utf-8?B?TTA0M2l2VkJGVHc2d1VUSHN6SHlYaXpuTnB3NlpwdWI0cE10VjhvR3lKZ0Yz?=
 =?utf-8?B?Znl0ZU42Z2d4Y1dVeUFmL0tweTFZSXk1bm95Kzh3QnR3YmNhejM3MmZuVFVK?=
 =?utf-8?B?SUhueldBWGJFZnFtRFdRdVRFcE9obk9rN1BDQk40dE5DZVNnUmFIM0tMemZI?=
 =?utf-8?B?TGtIK2Y1R3ZxVUpYRzJVMU1mWUJrZ243UjdXS2cwV0JyRUhLM3FsUEtyNmNs?=
 =?utf-8?B?cU5hWWM4T2lnTFBDdk5DSE8xVUQzTVhRM1VrckJNTnowYnljSFQzSHhMWjhp?=
 =?utf-8?B?WXcvQUxYaFRPWmxOUlQ5cDhoY2l4WUF4d1ZxKzdnK2wzdi9iY2llRTJ3bmk2?=
 =?utf-8?B?MzhHdlQwbEwvL3hxYWQ5d25kM0JLNHhLRC9nTFp3cEJpdWd2S2FRNTBGRjd6?=
 =?utf-8?B?bG8vcTJrMVkrbWlxVUxXcmpGSmFURzRaM1pXWS9iN3duNXQ1My8wT3pzTWpt?=
 =?utf-8?B?S3hjQ3F3dHRnVGJmbjd2UVA5S0NvTkR3WlBhQ3R2R2NtTE5JVHN3TWs2cWJv?=
 =?utf-8?B?SUxOMlUvb3FrVE4yNk4zTWcxMGcwWVlzbjRqdEpZNDJ6empKa0d0SE9GaXls?=
 =?utf-8?B?WDc2eUFBMVpiMlRTWEFSQXVrY3YyZ1AyZGVjdXptdUNzRE4wQnJZYUprdllU?=
 =?utf-8?B?V2VLd3ZBR0R5ZzZha01ZNktKVVc1QWJibVpXYVdPdDdwRWlmL0NTTTEvQS9v?=
 =?utf-8?B?emNzOHRWMmtSeWRpc0lBSjZGSGlVcndkcUxndnowYi9qelJNUzIvMnBZa0Z1?=
 =?utf-8?B?V1E2N1dLcC9ud1hTYVBZTk1reTkwVjRpeTdQcm84TzcyMW1zclF1bkl1TGds?=
 =?utf-8?B?QUNrc1VmMDJETEF6bFgwczNEdmhsMkgzck5DcGd5eGh2RVBFUEpPQlJVUWlX?=
 =?utf-8?B?d1g5Kzlyb2VyY080Mzd2QlFOa3FWbnJPWG1UZXdPeW1QQjRlekpEaGhJNU41?=
 =?utf-8?B?dEplYkRvWUwwUlNkMFVkZHV2aXE1UldBcGJJa1BoV25FdFZvekN1Q2hnMndt?=
 =?utf-8?B?VFdwaTd5cmVya0FkSCthN3k0c1lmTDlhQmdFSlZ6S3VQaUh0SjVBNTNXQlAw?=
 =?utf-8?B?Sm9jNmtDK1BCdW1UV3dGN3gvbTBlK3EvdVpDQnNJc1hVUzBVR1JUUHBKMHpv?=
 =?utf-8?B?VGxXRHJUWGxHOFlWMkhlTEtLbnNmeTBLbzZpSnZOWTJ2bDNqcG5GemZQbGpC?=
 =?utf-8?B?RU5Rb0FnR0JyTjU3cmR3RXV3SkptdDVOaXNhZzRQTzJ2cHE3N3BhS2dhb2dC?=
 =?utf-8?B?QkhzQUNqWmtjbHVIblNNaFNySCtYR0lUZW4yRGp5T2plNWZLdjFHUlYzSkxM?=
 =?utf-8?B?VlowWXZVOXBFMFg1UmJtVnF5cHVGcVpWK0ZibXgreGRQUGdqa0F2bmZkWVRV?=
 =?utf-8?B?QzJvL3h0Z09oTkxSMmhuOGFtZU9iTnRzR3EySThjRUlIU1MwcWxoc2NWUjdF?=
 =?utf-8?B?TUhTa2VNWnhlNStxSXYzS2R6Z1p6LzFOSVFldlBxQUtRWXVUU211N25UNDZo?=
 =?utf-8?B?VWFJQjlSbkh2THlHWUFqWWJwNHlYUng2MnJUYTRPN0lkcTd3eWhpa1N2aERJ?=
 =?utf-8?B?RFNscFBzWkpZYnNsakZyYUZoQmFJVU5jQ3g4dGQwa1ovQUs5ZlFtVk1PbjVT?=
 =?utf-8?B?dWRYSmJwd09sbHFMUGdCOFFWRTJ2OVVIN0xrRE1yLzNCUm1LR1RBSXJuS1VR?=
 =?utf-8?B?QzdwRFlHdW5yZk1nditEbkdUQU1ER2pueDhYYUJ0ZWRRTW5OWTBsRThCdHlu?=
 =?utf-8?B?VkVmVElQTGUxR3VPeTNpUGxaU200MTduRmxRUGpJZk1ScU95M3kyanZ0dWl2?=
 =?utf-8?B?VnlZdGhMeGNMb3JsOWlaMlN2Wk1TQzFxUDMzeWVxekNoNFdiTERTblJLWk1F?=
 =?utf-8?B?OUI1UHJvdm1WQ0QvSERMbnlpZGxKY1ZybTlqcHoxa21VeW1LTEVjOHZMenpw?=
 =?utf-8?B?MlRZZjczbzN6ZjNnalVBRXU3OGtlc0l5Z3RSd2FoR3pXOVBuaXVJMHEzOUVK?=
 =?utf-8?Q?EG3w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8816686d-8ed3-4efb-2a0f-08ddf0a41bc3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 19:56:18.8777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA9H7H6TLtyT2xJbqshGMue3QoINXX1DY3Ouuend+tt1i8V65I+xpCdRNq95uPN6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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


On 2025-09-09 16:42, James Zhu wrote:
> to get migration pages. dst MIGRATE_PFN_VALID bit and src
> MIGRATE_PFN_MIGRATE bit should always be set when migration success.
>
> cpage includes src MIGRATE_PFN_MIGRATE bit set and MIGRATE_PFN_VALID
> bit unset pages for both RAM and VRAM when memory is only allocated
> without being populated before migration, those ram pages should be
> counted as migrated pages and those vram pages should not be counted
> as migrated pages. Here migration pages refer to how many vram pages
> invloved. Current svm_migrate_unsuccessful_pages only covers the
> unsuccessful case that source is on RAM.
>
> So far, we only see two unsuccessful migration cases. Since we
> can clearly identify successful migration cases through dst
> MIGRATE_PFN_VALID bit and src MIGRATE_PFN_MIGRATE bit within this
> prange, also eventually successful migration pages will be used,
> so we can use function svm_migrate_successful_pages to replace
> function svm_migrate_unsuccessful_pages.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 30 +++++++++++++-----------
>   1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f0b690d4bb46..10e787e47191 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -260,17 +260,18 @@ static void svm_migrate_put_sys_page(unsigned long addr)
>   	put_page(page);
>   }
>   
> -static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
> +static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>   {
> -	unsigned long upages = 0;
> +	unsigned long mpages = 0;
>   	unsigned long i;
>   
>   	for (i = 0; i < migrate->npages; i++) {
> -		if (migrate->src[i] & MIGRATE_PFN_VALID &&
> -		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
> -			upages++;
> +		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
> +			migrate->src[i] & MIGRATE_PFN_MIGRATE)
incorrect indent
> +			mpages++;
> +		}

this is extra braces, you should see the compile error w/o patch 3/3.

with those fixed, this patch is

Reviewed-by: Philip Yang<Philip.Yang@amd.com>

>   	}
> -	return upages;
> +	return mpages;
>   }
>   
>   static int
> @@ -447,8 +448,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> -	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
> -	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> +	mpages = svm_migrate_successful_pages(&migrate);
> +	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>   			 mpages, cpages, migrate.npages);
>   
>   	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
> @@ -688,7 +689,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   {
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> -	unsigned long upages = npages;
>   	unsigned long cpages = 0;
>   	unsigned long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
> @@ -748,9 +748,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    scratch, npages);
>   	migrate_vma_pages(&migrate);
>   
> -	upages = svm_migrate_unsuccessful_pages(&migrate);
> -	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> -		 upages, cpages, migrate.npages);
> +	mpages = svm_migrate_successful_pages(&migrate);
> +	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
> +		mpages, cpages, migrate.npages);
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
> @@ -763,8 +763,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>   				    node->id, 0, trigger, r);
>   out:
> -	if (!r && cpages) {
> -		mpages = cpages - upages;
> +	if (!r && mpages) {
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
> @@ -847,6 +846,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	}
>   
>   	if (r >= 0) {
> +		WARN_ONCE(prange->vram_pages < mpages,
> +			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
> +			prange->vram_pages, mpages);
>   		prange->vram_pages -= mpages;
>   
>   		/* prange does not have vram page set its actual_loc to system
