Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778D0CCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 04:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D2910EA30;
	Fri,  7 Nov 2025 04:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2mFZtoL8";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE09510EA36
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 04:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhyLkdMhX3htKRfc7a2dXemBaRZ0C2JJH/YfuvhX/Plxcg/wFisreexQ4yw8szeJruluFt5dk0crcgrlgg4/qAGykQ51wiQaM6Ssdp511rHhjNMg14kXk/+eTvjj30BbMbjKBLU+MpFU1nTpXN7S7klpW66GuVHb3N75wpujwZXkdC/IQal1iqt6cW6KyofJuJ0GdeYy+oA1KXVsBG3a8tFHsrL5YLuOTeogDA05f4T47KbpgLFtkiTwvjaUNqYmQIX1KnugVX6Uc+7DluIHO8FDpZByl8UxySXSHuJoEpV4Le1f33NsEFefFvkky06dg8WsxZNkc2l3XCG39zvKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INzM5woDB8AxjhdAaKaXIMJloyfxCVIMnpgMLlujZq4=;
 b=i51TzmGISBcb+Z+WgEZYdWBGF38CkQoBBKg9wpPLBbAAGxZP+6WluJtqqb5wxvN/UWldBrxLbdJXIm4ZcBQNCmprfENyLB6io76LeaUedVVWHREV1WXgPezo9qclgNdh88+7KtAzNG7h0jJC8V+70XqNISydH6yBXFSvbPZo/bfbtijZ3Umk3ve8r6/FcDw6vwIutOCScyIS/hBEtMFK8wMAyO7dgU0VQe6npv1674soxeiIaNWP+5O+SGU8k4L5DjDBLpoiDv/L1AFqVGAAq3xT1V3uqKzu7uejO/8cJatcHgF2DXwB6XZk5iHDf9vKkLHNpGfQvJcN9YU4SmhiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INzM5woDB8AxjhdAaKaXIMJloyfxCVIMnpgMLlujZq4=;
 b=2mFZtoL8epmxm69J7sccYHbfGd5yF0M3LZ3kj2p58b01Kfijz7LgPpkkZ0MlPL5TKzCVffUivdRJyY9hNsUnh5HOs03tSpe0QU7kjGnpcfEhPq2jf8e1NHDmuZW8Jja8rfJ3Fzw3UgisYMRsu0ZRHLhf5iECxMPTMKZjEwvmBIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 04:50:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 04:50:59 +0000
Message-ID: <2ac1dc75-e17d-491b-91d4-9d82528f6718@amd.com>
Date: Fri, 7 Nov 2025 10:20:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] drm/amd/pm: Expose ppt1 limit for gc_v9_5_0
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251106165508.3785924-1-asad.kamal@amd.com>
 <20251106165508.3785924-3-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251106165508.3785924-3-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da0f7b2-65ab-4e70-5f62-08de1db93e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjZFZ3p5OUZjcm1USGlZenhoZFA1NjN5eDgxemE0UGtib1NxakFwWUM1WjFa?=
 =?utf-8?B?REx2aG5VTzF1WXFBQlQ2WTcyeTFWd2xDTFZmSkN2M0R2Q21OOEVtNUVYOTFz?=
 =?utf-8?B?UE5vdjQ5SDhTS2pEZHB0b3o0NzBvYW8wYzRiVXJzNWVKNFFxVEpZMXVHcFJm?=
 =?utf-8?B?alhWQ0FLVUJSMGZMQ0c5L2xoVXZWNEFidUdqNlVpdDJTRThXSmsyOWhUZkJU?=
 =?utf-8?B?TGJscmtVajh4M2ZkSGFQMGRTalZvZ2FWN240OENCbUk2Mlh1YjdnSlBsZ2NG?=
 =?utf-8?B?ZE1RQ290a01YTS9ZcURVWEUzQ1pRYzNtQUZJMVcwY0cveG5BOHkvSVdGVGp3?=
 =?utf-8?B?c0FCTm9LbEp5cDZKTklKWEFjZElzMWd4QnV3ZmJnVEtDZXIzSXplRkVmT280?=
 =?utf-8?B?T3lnSXp2ZnJlVTFhKzU3T2ZtMmUyaVlINmJHNWh3S3FPVDRTMGl0a1hhM2hy?=
 =?utf-8?B?RllZOGJQQnI0enlZdk5iYXB3R29HL2xUckJXOFN6a1ZDejFlbXNZRHFlM3dm?=
 =?utf-8?B?WmNjNldCVXMralVtTURna1hudlVXcWpiK0FVelVRNDFrZjBuaitsS0NlK1Fn?=
 =?utf-8?B?K0RuME91Q3EwaG9ybGVIUzhNYTlOQWF1Z2liNnRKbU0wb2tlUlJjSUx5WnVL?=
 =?utf-8?B?bm9pNS9NbHQxOWlnRVk0Y1R5Qm9vaFdWR0hldmJ4L0tMUWpKUlI4eXBuL1RJ?=
 =?utf-8?B?Wlg5elF2WHM5ZEI3TFdQZlROTUtVcnoyTksxekNNOVluVkQrOEtWNjhpa013?=
 =?utf-8?B?alh0NW1NeFd6T0VOaGxPbjJBTTJXMGlpZHFxNEo3Tm9NL0JPazJ3Sk92Q2xh?=
 =?utf-8?B?eVg1Y2dKWUJhaWpTNWhWSGdxMzRHM2VDOGY4QmlNVFU0Y0lHUEw3b1VzL1NV?=
 =?utf-8?B?QmdTZHd1RDVwS25Ua0VvRTVXU2tjSFp6aUNVN1cyVU1CVXhmcDR3eHFsTFgx?=
 =?utf-8?B?bU1qN0I2SWFXTXQvMlZTL1VDQ0Vaa3FrYUk0eEtUdWhkbWxEY2NaQmVFN1pj?=
 =?utf-8?B?YkJPUXpUNEhnUWxpZ1RRVWVJbDB3QUl1YzRIbTlZd29ROTdXa0t1UTl2eHp2?=
 =?utf-8?B?NWxSRjlxMmhrbHN3dkZMVTZoMVZrQWZpMVg3OFVBZDgvUjJEcllZdTFaNVBY?=
 =?utf-8?B?NVZJZjRFQ1pGQ2RtZ2liOGg4OUNXNmcreDlJWVo4Nm82c050U1V3dUJ5ZWUr?=
 =?utf-8?B?QW1yZ2dOUXlldXZoTWxnMHordTJ2ejJtVnJ4RnREdzhuRXVIZUh3SjE4dVVT?=
 =?utf-8?B?aEttQVNqK3k0M2ZtRjNSejhwL1hDQWw2M0lwKzc2SVVCWGYyL0lUWkFUVHRk?=
 =?utf-8?B?d0RGbkVGYjZ5VW00S1B0WWRLbzJUZlFVZ3VSci80NnZSdlBCTU9Sc21KS3R6?=
 =?utf-8?B?OG1CMFhhYmsxUGxqQlJHR0NOVXlYYXU1VjlWUGwrM0hnR0ptT0lVUUh2d3ZN?=
 =?utf-8?B?MzlkRVlJTUR6N3N5V0hoOEpGaGNUZnZ2cEtNWlp4dVlicnRqVUIrem9QQW9q?=
 =?utf-8?B?YnUzTjc1L0NXYUhsdng1Z3FIRW00ZTJ0UmdteGlobjJCa3F2YW5wa1M5c3Yr?=
 =?utf-8?B?cytTTFlVd0YrQ3hLTWxFaEhrRzBrK1QvYnU4cUJKRmNxTzZOL2NSWlhMelpM?=
 =?utf-8?B?dThPb09ZNTBtVXhYK0VMeENvQUQ2anNEc1A0MjRzTm1sVWM5bVd1dXE5bGYr?=
 =?utf-8?B?NEo0ZytUd096ckgrTXp0UUNXL0hCNlNpWlVkUGFTSDIyait2V2tRNGkwOHZZ?=
 =?utf-8?B?K24vWE1tNUk3WTAzK0RPNUl3aEFxeXpLcnowKzVrVzhsVDhVS1loNy8wNEt5?=
 =?utf-8?B?c0tLVVdNS0tuNXFTMERObFNGclNYL1ZsOGQzdjVGOEJYR1IvL0tKZTVnbEMx?=
 =?utf-8?B?enZNMFErN1RzQ0JFUzJ6cWdTV0FqZzNIOE0xV3M0SjdmUUNsMVZtMXBFZ003?=
 =?utf-8?Q?lhE3yVsm4XTIz4h0hnqlTa4w3fuo/76S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzYvWEhxbU9hM3V2VlZoNDZDcERGajhtZWhRWVhFVTczdURKcTRiQ25CVUVs?=
 =?utf-8?B?a2RmTmJvSTZLQll4NisrVFI3M2lieENSUFlFME9pN0xHeE1SK2FLdVNZZEFq?=
 =?utf-8?B?V21reEdhQkR6MkVvRHZBNEVoaUg3ZC95SmMxazlFZEpVcWhQZitYSlduQ0o5?=
 =?utf-8?B?RmdIbVhyMHBya3FqcWtyNytyUmJnVEZKQnFEbkY1dThOQ09kOGRiZ1VXNFpW?=
 =?utf-8?B?ZXk0S3hXWHMzVlBZa09TencxOTJmRGxZbXNTWlV1TVdDOHBmZjhoMERDcHdC?=
 =?utf-8?B?YVNEZVEzbnJzWHJ3V0p1MmNHZzJDd0JMaFNLczIwZWJacXR2bEZ0V3ZGYUpu?=
 =?utf-8?B?dlFOZXlxd3hRbVpBRmNLOFNvUEs1dWxDcEowdDhsM0wvR3V4Wm1RdW1yWlp6?=
 =?utf-8?B?U1owSzB0SkE3UlplcDZkM0lJVlRpUzZ5VzFMbEloWG9DSnpXMHlqL3lFUkNM?=
 =?utf-8?B?Z3R4dnU3Vm4rSnU2MTVXWDB5c3hXMngvT2UxZTRuVDc4SDNmNVpDNUtpZFZS?=
 =?utf-8?B?Zjh2Lzd5aEMxaVhxeHkycTdaUHhtTFpENmRGbFZqS2x0REVYOTlVTUF6S2pB?=
 =?utf-8?B?MDV3bUFzYTY0Z3hPanVsTVdnMVF5dkNtOWgyb0p0VGJqNnZwU3NxMWVLZzB4?=
 =?utf-8?B?S0tRUENxR1lxUTVoZXBLSFpkQkd6Z1VJVmIxYkY4TlpNdEtEakFaN0Y2WXZ2?=
 =?utf-8?B?ODhpbHhjUjRNczllZXFOTk1HUHFoL0dZcEM0MnZmMnhsUW8yek9YblpsM0VW?=
 =?utf-8?B?R1o0Sm9nYzdpYUcrZWJjR240MG5BZGxzUFhBZEdIUXYzdy9FNWN3WW02d0gy?=
 =?utf-8?B?ckZUSFJta0x6czhzYUhFejJJQkl1RGlBWmdvNEpGZ1FVZ1p0VU1Weng5R1VS?=
 =?utf-8?B?QkpzSVdMVUNERmhyczdhaUFxbWQ4eTdUb0V4NE1UYWc4WS8zMjJ5dEFydDhp?=
 =?utf-8?B?cU9UelE1dFpHbFRxS3hSMGpESUpXamJFSk1GZzEvc2FUTWxxa0FyRC9kNklh?=
 =?utf-8?B?d21uVGdGU1Q5TTM4UFBrZVZxV3kzRkNubG1sZkNIdnJkNVNrUzZPcXFPdTFD?=
 =?utf-8?B?SHVySjZnTzdMcXc1ZE1scUxIYTdVNzFoOEFLcGJ5bVUrTGpCRXYxSkZDcmZK?=
 =?utf-8?B?aVRxN3BXbjNqKzh2ditDR0Ewc0FCQXlVK3FjYjNHYmI5RWsvSlZBMTZqQnlE?=
 =?utf-8?B?WExUV0htaGt2UDhLK0htZTBnYlA5VUJtOXhPUnExaGNUbHBvYytnK2c5Z2o5?=
 =?utf-8?B?amg0emVWYUFHSTMremlnbERmeVp2TFluTW9uOGRkTEp6bllpbWExNlNPSXBp?=
 =?utf-8?B?dXk3Nmx3dzB2bmY1cUpUSFlWbTg1bHZRcTJhS2lTS2IrQmFCa2RJeWlsWXlq?=
 =?utf-8?B?eEtJTXh0ZUxETllCb1hOU3BIcGxHaXd6aDhZSWxkUFVuTlZRV0YvdGRiVEY0?=
 =?utf-8?B?YXpEZTZYd3lHTFJFb1NtRDR1anNnSE01Z3VpNCtoSzNkcHJlY014SDJXTU52?=
 =?utf-8?B?M3R1ZE1TMEFueE1ZdVJTeGFKNXUyWldBbytXaGMra21NNkdsMEptOXdNdVEr?=
 =?utf-8?B?SDV3c1hMUkt1aTFYUlg4UExTOVdBMGVFbDYxR0VkZkE0ZjZhNG9SS05ybUlm?=
 =?utf-8?B?dWw0a3RTS0tOK3M0eXM2LzVZQ2FPQkkyTHB5TGs1Q0xBOUx3blY5MDRjZThZ?=
 =?utf-8?B?emNVQXB2bFZ4Zi9nN25uZ1REU3pITGtvYVYrOFpRSHhKWFVBQjlxWkorQ0Fi?=
 =?utf-8?B?TlRab1ZPZTNZNHZBZjJrK3VZMXlUc1lYaHFjU21FbmhBRW5nQjJVSjMrOGZH?=
 =?utf-8?B?QVlrdlBTYnJHTzFPb0xmMzVBNFBvNDIvWXUxUDl5cEIvR09ONWJTYStITDR4?=
 =?utf-8?B?dkRoZlpYVzI1MXMxZXJtRGtrS2Q3bXlzZFQ2K3hwOFV2TjVPdHhPeGhhalYw?=
 =?utf-8?B?NDlDeUdVUEVXMkx3YVZ6aWwzVUxIQlp3ektRbjJBU3grWkFWak1LT3lQYU16?=
 =?utf-8?B?NUU2RDUxM0ZSeDJjTjBVRjFOd05KM3JxOFpEZXdXd3JEdGhLSUtFNStvRHo5?=
 =?utf-8?B?YVRNZTJzdWxsZmR6aWtBZzlGTjFWY1lzUWN6Q1B5aXJlQVJYVzZoNEFSME1n?=
 =?utf-8?Q?1Hdamc0qc/77EQ2QLlb1oMMbu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da0f7b2-65ab-4e70-5f62-08de1db93e78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:50:59.4497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEpdt+D97sp5tsIhChTZecQAbmTtz4NTq4yYt3IRFNFW4G6ZHlnsY6qKXBmARlUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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



On 11/6/2025 10:25 PM, Asad Kamal wrote:
> Expose power2_cap hwmon node for retrieving and configuring ppt1
> limit on supported boards for gc_v9_5_0
> 
> v2: Remove version check (Lijo)
> 
> v3: Remove power2_average (Lijo)
> 
> v4: Put back power2_average, will be removed separately (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 12 ++++++++----
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  2 ++
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 69aa8e22f103..fe7a2f09e021 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3373,7 +3373,9 @@ static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
>   				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
>   				  "fastPPT" : "slowPPT");
>   	else
> -		return sysfs_emit(buf, "PPT\n");
> +		return sysfs_emit(buf, "%s\n",
> +				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
> +				  "PPT1" : "PPT");
>   }
>   
>   static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
> @@ -3826,13 +3828,15 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   		return 0;
>   
>   	/* only Vangogh has fast PPT limit and power labels */
> -	if (!(gc_ver == IP_VERSION(10, 3, 1)) &&
> -	    (attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
> +	if ((attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
> -	     attr == &sensor_dev_attr_power2_label.dev_attr.attr))
> +	     attr == &sensor_dev_attr_power2_label.dev_attr.attr) &&
> +	     (amdgpu_dpm_get_power_limit(adev, &tmp,
> +					 PP_PWR_LIMIT_MAX,
> +					 PP_PWR_TYPE_FAST) == -EOPNOTSUPP))
>   		return 0;
>   
>   	return effective_mode;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c0e7c45ac0e6..8b49fb86c77b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2938,6 +2938,8 @@ int smu_get_power_limit(void *handle,
>   	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
>   		if (smu->ppt_funcs->get_ppt_limit)
>   			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
> +		else
> +			return -EOPNOTSUPP;
>   	} else {
>   		switch (limit_level) {
>   		case SMU_PPT_LIMIT_CURRENT:

