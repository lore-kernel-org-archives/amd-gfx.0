Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FF4C7113C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 21:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B64F10E047;
	Wed, 28 Aug 2024 21:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EOtuUp4e";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD8610E047
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 21:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEjk2GxO75MuYkPTzVgI+m/jZA/jWA3Mcrw9EyO/A/nereL7G/+ZN6FNYpACp5xkd0NgC1NUaAGfkI/Afk0F6DPnWNSN8g4HRbtnSOo/CoaiVHlPTTb1rBFSQGSDp/atOfTvpGM4dtN3XA7X2HA2pqEKrVmjA6jTQEROA+oRDT0YjpyZAxhqORLZ2DfeILr73gVM3DTcl264pV2gEkPkq/2jln1xw4zHfiIuz1souNKALFJ0lmRh5Fi3LV4Dyq/vPGQe/3qqa+p0Z2/M9A6ASnyjq/IrIUHqNzXhHyZw/DYuJwL7VkEBHrfV5Xg4DB34v0NXgNsykJVdwcqw5m9qiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlxAij5Xr2XCxayTrf7UY2ojxiGMiq5qQGuk/0l8o4g=;
 b=uT+fcsmO24tU64mfgJX7mVawJD4cNDsAMeiHxGFEJMzm9ThZRHtVeWYXZSFFqWZC8/8XH4PkX4FT/kR7P4jRUdZ5JNi8uLW5PHg60/u2zbtQye2CtHnPBsHl2OZX8Q9sXlH2OaiLvnxW0Zf4pOFmvNUQVIUj5CpyDYqChABE1Jm1Ai+s5kKTfZPo+Sn8PP8nNcgJkfkrqOwRXF7FUr4/n5bh1+b/OamYUHEP3M1zsWdtqeN9yMnWLVbibTCZZeXRTAu5eJmLyWJHPFzrkuoiLDt6QDJugLTpDu8vRq35U+/5OBzUBPuWYbNvmKUbmt8idQm+6AZb2IplR99nHMc9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlxAij5Xr2XCxayTrf7UY2ojxiGMiq5qQGuk/0l8o4g=;
 b=EOtuUp4eUcK4fhfLOsBFIstIcqFj4Q20qdivDfvaIS+cnHTiSuoIQ7XAZlqEBaj7WcDWbSLCikThoXak1rnOQLtPS0PYsfYvv+XRjS834SosnvHzVUpJvTdc6c8G1R2thJzjIJ8ss20RMbPMwtCGEbMuO41SYX4v/EuhnTkiKsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 21:47:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 21:47:47 +0000
Message-ID: <3ad738ef-4c01-4035-b3d3-aeda1722a169@amd.com>
Date: Wed, 28 Aug 2024 17:47:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: revert "use CPU for page table update if SDMA
 is unavailable"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: yifan1.zhang@amd.com
References: <20240827141619.2553-1-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240827141619.2553-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f03e9e-f8a6-4e06-a150-08dcc7ab0e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHJSWlBydm1iY01wcm9nSEpYL2hKbW9LUVA2TWdEcXE5eGYvV00xNVc2S3ht?=
 =?utf-8?B?ak8rN25HTE15SVhZQU9mYVN1SWkvUU1ZYlRtQlNsbFg0amh1d2NJWHR4ME1n?=
 =?utf-8?B?TnRkaWFXRlhIaXJjaFlmWDRBd0RIZkt5RGNHb0k1eTlobFZqMW9nOWlOYjJ2?=
 =?utf-8?B?TFNGM1pUOXF4YzFUTVgrNENiWkJ1bEVnYVB5YUlkMTI1bkJjUHg0RXlHdzI0?=
 =?utf-8?B?eU0yQ3h1ZlE5TmJKaFlaaS82bWQ4L0ZOQ2Y5N29FMm5oay9kQ05FSnh2Q0Iw?=
 =?utf-8?B?MVoxalpBSUltTWNRWUFzc1MydEhoUk1BU1h5SllGTkNVeGdXcUUraUNoOTFn?=
 =?utf-8?B?bkFVV0lkU2lYZXFoelVSVWF3VFl3ZExJOXY4eStYaWRSV2ZxVDQvLzk5bmsw?=
 =?utf-8?B?TGE1SXBuM0JHTHhhUCtGNmNrYXQwQWxjbnE5QWRSRFJxdzVEY095TVZPdHl6?=
 =?utf-8?B?YTBhVHhnSEt3UlQ0V2VZZDBDRDZaMHVZaWpVR1VlMFN1dnE0VWhtd1RDSlRY?=
 =?utf-8?B?QnNEMmZqYmtlayt5QVZpWDJKYjJtWUJxNi9NL2U1a2p0cVUrd1VjMzlUR01a?=
 =?utf-8?B?OVRtRThqcndZSzJvRkgrTnFrT3hHcWRZZVNaVDQ0N08wd3BaMER2anRXZkdY?=
 =?utf-8?B?Z3dySlFldytLdjl6bTJVbVRWRFBDTjhWOTZlZFVkQWpsazVZN2xCYmN4MG4z?=
 =?utf-8?B?ZGoyVHNVSElkNEVxc3dQdWpuOUIvb01UMUNHSnBUWWhFbUo1a2R1M3EzQ3c1?=
 =?utf-8?B?ZGtRNWt2c3o0dklXalZ3MWkrVnlzbzlCdnZ3TEpCMnBHVVd6aWJRR1c2N1F3?=
 =?utf-8?B?dDJYWWZURjVCVTNRTnBieCtlV1JrVHpGNDRFemZUS3pjYVYxYktQTWdOcXlx?=
 =?utf-8?B?cDFxeXpwVkdIenJEaCtiR3ZGT0NxMU85SEx4MWU1RFpUVHBhd203bC85VzB0?=
 =?utf-8?B?WlZQbXdsc1lVZjdnS0ZLYWpqTndUVW90NjZqWWtUZ0s3cVlHWU5MaXRuS0dt?=
 =?utf-8?B?bDNsR3JSSmlmOHhab3c3K3hSaFd2bmhHS1N2UVhBTy9FWUhEMTJUejhzcWFT?=
 =?utf-8?B?SDNlVnc2RTFjQmNaR2dmeEFqNXYwTDJxTFlSQUlDK083WkxnOEtJVEJmVk84?=
 =?utf-8?B?aFhyd0U0ZlJNM1VlN3ZYZk1iU1Jma0ViNmszVzV5UytYTkRHdVNneVdQZnZp?=
 =?utf-8?B?SGVmVUpzMElHWHN5UWVpVDM4cWtjYmMva3kwbGx3S00xOE91RzZTNExmRzJi?=
 =?utf-8?B?OE82cllqVk9vWXRqcGM0QzdQV2V4czlWc3NFcTQ5QU0rQ1c2cEt3MkYrTUYz?=
 =?utf-8?B?YWRYcTI4R2p5ajBrVTFJYXRIQUFKMFlab2dDV0hhQXFQc29XZmV5NlpzYkR6?=
 =?utf-8?B?U1piS1JodDNmVXFic0R5VWNuNllPNzFraWNHMVNSWDRaTVh1SU1pZG02Q0xF?=
 =?utf-8?B?UmhlN3U4cHlvcWRjVXBDdWR5SW9xSVozOGlmVFhQeEhBT0NCd2llbTFvN3Rk?=
 =?utf-8?B?eUdkZHVHdjlldXBpZm5IUG45RDZxUFU3VDNLSU55aWh5S21DTGN4MGl5MERC?=
 =?utf-8?B?MmFjdTk0SVZFQWxYQWpSeEdlYjE0aWdzbERmb1c2NmhCQXZQeWZUeFAxaHJu?=
 =?utf-8?B?amRTMVVIUTNPWXpuQzdOcDhxTzl2UHBreFZrb0xiYkRzVXoyYTUzREE5aVR1?=
 =?utf-8?B?VFNrTzcramQyamwwYU85ZDlUM3dkOGQ5OHYwSWFxVHRLd2xWanorRndwRjlM?=
 =?utf-8?B?RGxqMENESGc5bnRxbk02emJTZkIybWlmb1R2RFdpNnhpOUs3OEVtQWhsdnBF?=
 =?utf-8?B?UmYzR0NQbmVIMmMzemNFUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUEzUnNlSlVpanBualVCRzJKKy9ickxGQ3hUMUxzNHBCQWxTN2dHZXB5Zldo?=
 =?utf-8?B?bVo0a2JxK2ZUMWJEb2tvSnBoamJab0JUWmNkL2hlYXovTGN3ek1NOC9lM0Jj?=
 =?utf-8?B?NkhObHE2NHQ2cEZzbHVyL1lJOEFaMXE4cGt3R29Ydk9MdTZjWVRVWE5yTzR4?=
 =?utf-8?B?em1uMnVxQW80QlpQaWlGM0ZLMDIwQ01zMzhVL1M2Z2xXcVpJcTYwdldPT3FM?=
 =?utf-8?B?QStteTFSN3dvV2J0VXZuUjNPOEdzcFBhcUZ3RGFjNG0zQ2dMWWd2S0gwbWpu?=
 =?utf-8?B?aTZCWDAvKzV0SzFoc2U1SjdtV2IzYkd4dHcvbytMZTF0aGtEK1JFbVF3NGwr?=
 =?utf-8?B?Z3M4blNKUFRvaXJTQUpkZ3RuZUpxT0Q3RmhzVU5vNFNNZndMOUNFR3NnNFM3?=
 =?utf-8?B?TVp6aE9QdnF5dmh3QmdYLytyang0VldUVlM1ZldmU3ZPSjBndkRyRk1CZVdo?=
 =?utf-8?B?RU0zS0Q5U3dQV0M5RlJJOGF4RkJIanpnQkt3WmZuaENFb1k4N2JYRUhEdDk3?=
 =?utf-8?B?cjRHWGFJTWVPcnk2V1hFS2FsU1BNV3hCQzBWOWVVaFE1VitkTGQxNGxSYnJU?=
 =?utf-8?B?SUV3Q1hDdk1HNUlvSzcvSzBXVkhnTjVlT3B0NDllajdzaUZPbWRobVI4MnFv?=
 =?utf-8?B?dGpGQ0ZBbUVDaTk5VjVmZkRteHBlWUZ2M2Q1dkpiZ2tTUFNQdm9HN3N6eEsy?=
 =?utf-8?B?TzVEd0dFV2dCTHpvakNUUlhXRkluenY4cVp2NjU3RnhnekRNWURXWVUyS2gz?=
 =?utf-8?B?cDlzS0RFbzZQdkJKVkNQYjhPVmJQUVJmYTBxcUFpUXRBTyt4aWdlaUV3TVFV?=
 =?utf-8?B?OHR3WjZtUllxdlNkTm51ck4wOGgxY2JadUQ0bEtWMHp6aHRhUVBqdUkyR0Ro?=
 =?utf-8?B?aTZPOUpYVzUvS2xmQnVhTUdKQ3VmeEpxR0VidWN4MFVsUmdKUHRDM3lOR0xi?=
 =?utf-8?B?aWZzZHN3ckM5amljYVBCQ2o2SkZtYWxoZlladlkxamM2VWh3a01iVmhxemJF?=
 =?utf-8?B?VUE2Skh1MzNCZDhQQ0kvS1IyY2hvaUdXZzQ1UUlWZFJIR3BiQ3BwSFpTTVBC?=
 =?utf-8?B?SG9tVm9nRW5ZVmduSko3OG1NL21zRzN3cXRDM0dMNUxYRjRqZmJieUxXMDFO?=
 =?utf-8?B?NXlSMytCeWkrOXJQMTZnTWh3STJUNjE3S291Y3IrV3FUVzQvNHRmNUhEMmFE?=
 =?utf-8?B?TFRvd2hhZldnNVoyTlF1WkJOcE5oazVmSmN6TEZNLzVsZGVmTmVvODlpa29E?=
 =?utf-8?B?NGt3TXJZeDQzR2htcTNnSktpajJ2OVZXOWRZM1FXT1JBY0tkVmlzTWt5a1lD?=
 =?utf-8?B?NitHVVlEazltRG1PWHBrTDlxMHYyZzduZUcvQzk5ZXA1Y0xCOUoxMG53RXJh?=
 =?utf-8?B?SjZERHB3RHlvSmFtYkI5ZHhZWmQ2eXJyL0dYSWIycUh6SG5mUEpiaC85dTZ1?=
 =?utf-8?B?bExwM1VRSFppZGVSVTFVL1FKYk9hQ3VOQ2RXRkN0SDdkQXNZcmJkQXFMd2J4?=
 =?utf-8?B?dWhPaDRIZW1sMitjQkRXa3l5ZTVhcUMyN3ExT0lJY1ZwK3ptUy9SZTFtQXRn?=
 =?utf-8?B?UGp1ODVSTFQwVHlKN3plM1dhYXVCb3Z3ODVpazVMUTlIU2xQbEN1dXRtWVhB?=
 =?utf-8?B?bmdVZ0pyUHEvbGZuWjdmdE01MnNlL1pRNDRsQTlpeWdoTTVLODVSSmdldEwy?=
 =?utf-8?B?elFwVjJ3K2FpeWtsdlF5OEJpSSs4NEY2ZFBvN01oOCt0Y2dhNHlod2M3MzVs?=
 =?utf-8?B?TE90eHZOeDhnbmtwNmppQjU5VXg2dHhCNVBmY3k2NFh6OGwySlh3VnF5cFor?=
 =?utf-8?B?WVA5M3dhZzNHbVNadERGL0pYbXBSYXN4VG9QQmNTdGZySGwxVjZNODJEYUJj?=
 =?utf-8?B?WUJaS0s0M05ISTRkVEtGUm9TTk9VKzJkbTF6ZFE5WUV5NSszc2pvVndVRlNh?=
 =?utf-8?B?ZXh5QWJsS1QrTDJZM2sxQ0xPWitzdUwrV090SWNqOTFTaTBNTGF4WTlqSGpu?=
 =?utf-8?B?RjdrTS92RVZ3QU5TbDVNSnFlbERWWlJnWmdBbGdiVVVyb2dJTVlrdERQZzNq?=
 =?utf-8?B?dWVtTVFoZnRGOFpzb0dTQXpnWTRSYVpuNDFsaUxYWTJJZ1pwUFM4VXFoR1dW?=
 =?utf-8?Q?dVn4s5sDV1IVNEO/40aPqRBdb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f03e9e-f8a6-4e06-a150-08dcc7ab0e36
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:47:47.2813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRUT4inl+wj5MZQcHsw8hBdup/GYK50qZotA86sqh/aUPsi6oEgZRt+5NlqfXSqBnv2yaRx9rlzThfXXLMs7Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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


On 2024-08-27 10:16, Christian König wrote:
> That is clearly not something we should do upstream. The SDMA is
> mandatory for the driver to work correctly.
>
> We could do this for emulation and bringup, but in those cases the
> engineer should probably enabled CPU based updates manually.
>
> This reverts commit 23335f9577e0b509c20ad8d65d9fdedd14545b55.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3464a7a880f0..f0ccc560fd5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2392,7 +2392,6 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		   int32_t xcp_id)
>   {
> -	struct amdgpu_ip_block *ip_block;
>   	struct amdgpu_bo *root_bo;
>   	struct amdgpu_bo_vm *root;
>   	int r, i;
> @@ -2422,11 +2421,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>   				    AMDGPU_VM_USE_CPU_FOR_GFX);
>   
> -	/* use CPU for page table update if SDMA is unavailable */
> -	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_SDMA);
> -	if (!ip_block || ip_block->status.valid == false)
> -		vm->use_cpu_for_update = true;
> -
>   	DRM_DEBUG_DRIVER("VM update mode is %s\n",
>   			 vm->use_cpu_for_update ? "CPU" : "SDMA");
>   	WARN_ONCE((vm->use_cpu_for_update &&
