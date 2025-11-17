Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA66CE8D6B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 09:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B39610E306;
	Mon, 17 Nov 2025 09:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZlDawCBj";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDFBE10E306
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 09:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sg06Qyf9HY5ThWeBiETqLN+ImFL7r0DzyWyHX9wVELF/VLw74bPpVj4f4ZAr4hfmE2V/k6SQ8b7EGDiqKhKxMNR6qlWUB+tTvAluFakmH+b/ktz5vriTaLUW2xyNI+O64GBM6D2g/feR5xXYVIl5vig6sDDg5Kgmqx2gfFNqzc6ZMmFKHHo8KUpcAVZ3nBwc8DvAIy2ilm6/CgOxs5GNjmZWUeZIWZcSVUBeT6Et643CUAZvo968jC5CEzdFbYUNwp0F0QE0Ure1st2lHakOAPvcqJ/vIqF4FVzVyNrP4CpLntcQ0vB1B8au3eDFyizA5nM+g6yOj9m/XAuxksdyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/fwtgvPreMN+MNkbcJ3RrJDjXn1O9DyPv5IGWgosIM=;
 b=LlOtR6CknOuniEIL8TblR2jwA8FotAVyDBI+iIiiR+7tNyIGLRANeVGz/xoXjqo81tI68YNf3lsaY/mlm0wid44bUrmbzejz0UOoLeE7gu85qjdDVIVO05vJmyGJd4qDoFUO8bI9/hLCs9nfSFELMneU8tWhAuE00Tmft/mNA+s7CtqB7X7WrG0BkschzIAbkqpsTxfO70wuAU3upUsxU5XpYdBz7ImJmKaoGoRkSvOEIn9pWprjuIe3W0NM7KPcDoQ4NexVTmuQT8qtkEoa4AT/QQGdaCECWjTm+UMWYWlKUE1KrV7dL3MABCofM1keIy/mQdG/QSNkMtnJNDVZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/fwtgvPreMN+MNkbcJ3RrJDjXn1O9DyPv5IGWgosIM=;
 b=ZlDawCBjQV62BmqaTWze6CTm0eBWJmyKzxqRWt8dtc5+5iqP/LgkW44doA6I1zsCVpgNr6GVwH27rJ63DcOliLKJMhkoa/q1l+Ekg2CLbDzDiQkYr1M07Hf6sz8oFB+y2oV4z6MNlBAPsMoSnhhJm5miJl6Yh+fMVkfaN/eqfBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 09:42:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 09:42:12 +0000
Message-ID: <e8842a03-031f-40df-8b64-5d0222cfeb8e@amd.com>
Date: Mon, 17 Nov 2025 10:42:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Prevent VA mapping for MMIO_REMAP domain
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251117093856.857964-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251117093856.857964-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:408:ee::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: db09019c-f4c7-4cc3-bb8d-08de25bd95da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEkySXVqbzF5TE9nVzlQbzFic1Q0Nk0xMFdNZmdVYUFPMjB0S2tiUVpmUFk1?=
 =?utf-8?B?Yk9rZ3RxUW1mSnBPVFdDM0E0T29aZ01FSHFUTUJnMk02Qlk5WEdLdDJPWkhU?=
 =?utf-8?B?cVdOa25YdjBNTldxV2MrQzhnV3Qycm9IQm1aTEdZVS9PZUliamFaZzIxbUxm?=
 =?utf-8?B?Y2ZNMkN2cmlndFU2c2Jpd2xUVkRtNXlBdGllY3ltUGxMclFHb1ZFbll0MXNJ?=
 =?utf-8?B?cExuVTkyamc1VVpkMkZUSDBLL3lXOUlxcGY4eFVLQ2ljNkFTVWk5UGxnNUs1?=
 =?utf-8?B?SmZZRzErejB2S3BMYzlZUmNBbktoOVIxRDdMYmlTQWdWcDllbGZVZG90UXlU?=
 =?utf-8?B?allpNkpGM2JuSHBMM0dRN0xHZTh2ZDNMamd6cU1XaWMzS1BWUG8vQkFBUm9Q?=
 =?utf-8?B?cHVERDZGaUIrOVY0QTVjdXhoUGFjdjgvVXVCcVNuZWMzZWVYSWFvaHpuRTVW?=
 =?utf-8?B?ZHlNN0VWWG5QeFRwMlVYR0tCOG9lV0lJRTRnVEtzZ0NWVG15R29MQ1ZudE05?=
 =?utf-8?B?Z254K0ZvZjBkRm5TU0M4aFJiTzQxckF4amJ6U1pITjJyVXJ3NnRJUmlSaVA1?=
 =?utf-8?B?WDcvM3BVdXl6N3prVEVjSVAxS1Q1a2dlenpMMVdTa1d2NkNrQzBEdkRSQmtt?=
 =?utf-8?B?Ykcxc1FHaE93UmdWd3dQYTNFcVhQcGVIaXBqWFhxa3ZBQzN1UVJXRFVtY1NG?=
 =?utf-8?B?enEycEdkWWVPZlpTSVJrZkR6bE5HZjA0QTFsNkVhdDlDblp4WXAwaVBZdHJa?=
 =?utf-8?B?Qk12WTBNYmlrd2hZQzBETHdRNmF3a28rM0tDZFF0R0ZuSFFVQUVuTkdQcWNU?=
 =?utf-8?B?RXZHS3BqRzUreEw3MmRTcmpqRlJSYUN4eVZMUWNzb1FhT09RMFdoZjZRUWF3?=
 =?utf-8?B?UXRaNFlyS1dMb1RnM3FSZ2s3VTYrN2o1OVBDUGNWQXZNT1A2cy90ei9LaWFi?=
 =?utf-8?B?TnRESnZ3RzZkb0VONlhVQmJWNVV0bW16cE9RMVZIUEF6Q0hIUXJlUWs3T2Vo?=
 =?utf-8?B?WW5QVkhoODNkNzA2UXlRb0Vsc0dGSGUrVUl4YUtNQ1ZBbVJwTGFoMXRpVzR0?=
 =?utf-8?B?dVFwSWhmOFdrb2pqWldhL3pqSDJlSVFTT3lQdzhHcDV5TzNRV3l1STVLSk9S?=
 =?utf-8?B?Yy8wZWxUUzJjTWJZMmk2K3QrWmd5ZGxwMjBPdjU1VklIbUF2QWgrNUtpVDhJ?=
 =?utf-8?B?Qk5icTRyYVZQVUtBQ3MvSmxITnJRcThmY2Q2TGlmN0xCVmJHV0xZamVOZkNh?=
 =?utf-8?B?WVZMdzVxZlZCNXhMMUJJZnl4L3pnNk16cmlic2J0MDNFQzgva0FlRnVzbWFt?=
 =?utf-8?B?Z01CUVRrcTB1eE5QUk5kTkxGa3FzR2oxN3BwNndrelpwTnZqS3d0SEJ5aGto?=
 =?utf-8?B?MFV6b0l5ZGNDU0ZIWjh1OUhSMnVUZXRFd2ErUWU1OW1NMzc4aGRMcUFEQkVr?=
 =?utf-8?B?Vi9vanZ2TVNWakQzM1QwRjFPcDNOVFBoNGFUempyWGFYRGhSSFpLMk1vZDRK?=
 =?utf-8?B?RnZTT083Y1lPemdLNkkxSEhMQXFCaWpWdTUyWkNrVU9kemJBV3FkMThCM1BK?=
 =?utf-8?B?eHZuRkgxZ2Rnckg3M21ta1FkZjA0VTV5T1VDQmdkQW1BQ09XdkREa1k1MDFt?=
 =?utf-8?B?eUZZYi9NRXpOY1FIRW9LMjdPNEtvK3hLVzVPc2JoanRsWDRZK2Fyb0lYV2VD?=
 =?utf-8?B?MEVqNHJlZ2NnR204d2VaQmdkWm9LeSsrbFFCUkhOVDZ3enI4SnNUUWo4c3Fy?=
 =?utf-8?B?Uy92czRRaVNFQy8ySmEyNDRPSVRPVkNvcDhXdXU3YjNUdklOZFVHblpYYW1w?=
 =?utf-8?B?SDZwcTNLL1NHTmVGbitGNVZZdzZSMkhORVR6Y24rV2RVUzQ0blR3R0ZBeWZS?=
 =?utf-8?B?R0hMODVDYkZya2RaYmhzYjhSUW03Tm0yYkJjbzRFVVFnbjRxUUV2WVN6UVZV?=
 =?utf-8?Q?/TdToS8q+9nwG6GIUDVBLL7ciOkWxtSl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEtxQnZMb3RuRk5PMjkzb3NMYVNuOGVoTWdDWG1rVEx5citIMHBJbWs3SUhQ?=
 =?utf-8?B?QzlxVlRiNDVJUHpHS2Z3WVpNUW9sRys1VjAxVzRqWklvUU9Va3BJS1lja2RW?=
 =?utf-8?B?T05WSU5HK0t0eSttUVBYQkxlMWJyQmlCQ2Y1SjVxOS9jUThFMUgrSWo2ckI5?=
 =?utf-8?B?cUFyeHdTSkp5WUZtL0kwZjNmQS9IZG9seHo0TXBzYkt4QmpYcFFZRThsa2pM?=
 =?utf-8?B?dFdnN21oZHViTEpBWXZINll2VTJONnJranpqMS96VHBpVFNQTURMcWppd1RE?=
 =?utf-8?B?UWVialZ4dFJBVzhIbldIdW0reC9DYzhORVRneEV3cVVxWEw3WTNiaWhERWFQ?=
 =?utf-8?B?eFYxR0o2RGhRWENva0V6Mk9aek53a01vQWhqVWk3WlpFQnB3dWVIZ3YxMTVZ?=
 =?utf-8?B?dTdsQVIyTkt0UTJady9XQ1FrbHA5NmkzaHJJdHI0RVdIcWhRcTFLM0xhRk0w?=
 =?utf-8?B?R1d6Z0tuaWxmRVF4K3kzTiswcjU2am5uc2FiNG9CSUpRekM1MFpsMnlwWTlz?=
 =?utf-8?B?TEZ1S1RKOS9pbmVRWnZUMmlWeEt5WjUzYVJpRDRNQ24waC9FTzU4QUVDbWYy?=
 =?utf-8?B?a29MaUFaQjhPV01qSmZONmNpemlwQnpyd2FvT1M0eVF3SHVtL2owcmo0S1lF?=
 =?utf-8?B?WDFia2x1MndxbjloK3QvQ0g0T1U2ajhKajhLZzF5UUY5cW9FZmczVHlmYUs4?=
 =?utf-8?B?K2l1YllMSEFYemVMeERvdHkyY2l1K01mSEdCRmMrWi8zTWw1L2hnMFpia1JP?=
 =?utf-8?B?T2pxQkhMZWVrcElmM2V0YkxGL203Y3BsdEloZ3Q1eUlEUU1JOUhSWlFPSnFT?=
 =?utf-8?B?bkZkNWYrVk1hbm5vQkNuS2t6c1FPOGYvUGEySWNzeDVTOTdRVmljMEI5eVRN?=
 =?utf-8?B?Nlh1ai9kUU5xbmVObUJjTG54WGIrYW45Ulo4T2xucldzVzRVei9QQzJxVk15?=
 =?utf-8?B?LzF4djhhVlBxYXZwMG5UOWJkUGhKWFFKenJMb1ZJWEQxVURDK2FhbEhkV3By?=
 =?utf-8?B?RUJjbUR5OUJFU3hwU0NHRHVkUmFVVXNNUW42WXhxaDZDN1FaWXROVHhGUTRY?=
 =?utf-8?B?WXAya2EvVVAxMU9weUpXaUN2QXBRSjM2VWt2MzZyTXd6VElsRFZKZHRTNUpa?=
 =?utf-8?B?WU1Yc3pvOEV0V25vNVZkbzZBT05YaENwdlZVOVZ1L3FWS1p3QXhScUhhK2JO?=
 =?utf-8?B?ZTYwQzdBeUJ2NEl6NVlTY1I1akJMamdJMzV5SG4vMlpzaWhKOTlFL0d0a2tM?=
 =?utf-8?B?NFVualFBU2gvNFYrY05mR2V4eXJvM3pUbDlWWmtoNGl3RENock9hWm1xSmJa?=
 =?utf-8?B?L1M5SGp4LzVhTkdEaC95OTJRNlJJUnFzQVNFMHcyRm05RWUzV2MzZXhRK2RE?=
 =?utf-8?B?VFlONlk2QllNTEZCdEc3U05zY09jY1pXVnVnTXBFd2dReVYzUldoQ2pvZk5n?=
 =?utf-8?B?ZUZaeXFrbGtERWdSOUlJQldremN6M0ttUG1jcWI1VU45WEI0N1lUek11ZnFJ?=
 =?utf-8?B?RkxqV2tUcEloQ1NQS0lzZVliRmJpZVc5MU1BWmlNdU51OWVWbTJHZDFsRUs4?=
 =?utf-8?B?RzZyc1YxYTJwRUZNU1J1WmVscHFTNzkvNXRQMTJlYjZNODFQcjV5N213eDVx?=
 =?utf-8?B?TTV4RUg2a0c3bmpmVmh2L0QyV0F4dWl5ZEdpZFVqM1R2akU5M2NpZERPUTB2?=
 =?utf-8?B?d1VpaUl5ZlNGT0FPTVdrb3pFS0JtWjBSRnBkSEFDQ08vWmJPblRub2dKYU53?=
 =?utf-8?B?ek9WNTROTlMwWUltSkRXRWhIdVlqeUM1MW9HY1JDYW5vVXJqczJYRkRiZlRV?=
 =?utf-8?B?aHZCTlV0dVJ4dm00Y1M3R1VKT2J2L0c4dnhvbWN5Sis0M3krN2QwTXRYbm5P?=
 =?utf-8?B?OVFzektjVnVLMmxhdTVsQ05GZUJlMnNWSnFSdlRBTGJFa3M4WHpOVVZZZ2tj?=
 =?utf-8?B?dWtndHZIRWhLYy9saUhub3h3aWdWMFBJZ0lEN0E2dTNybGRJMERWa0xNbUx0?=
 =?utf-8?B?d0hoN2lJcXJoVlJoMFREVk1aUTd5ODhaajAzckl3VVF1YlVON2pFTUpoVU9O?=
 =?utf-8?B?V3F3ZjZDcHlGMTVuZ3k3MXJEZ2lCS1M5cEJ1STFTSlZqTDhzLy9IdVk4ajJw?=
 =?utf-8?Q?JGZv+x0Vb5wJZXIYi2EU10FtT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db09019c-f4c7-4cc3-bb8d-08de25bd95da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:42:12.7600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxBltjbFENemO/p5pslr55tN+7B3npLQLLMQJ+iany5JUVBMqzCUKOmQAOr6BY7r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
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



On 11/17/25 10:38, Jesse.Zhang wrote:
>  Add validation in amdgpu_gem_va_ioctl to reject VA mapping operations
> for buffers allocated with AMDGPU_GEM_DOMAIN_MMIO_REMAP domain.
> 
> This fixes a kernel NULL pointer dereference that occurs when
> user-space attempts to create VA mappings for MMIO_REMAP buffers.
> The MMIO_REMAP domain lacks proper scatter-gather table setup
> required for VA operations, causing the kernel to crash when
> accessing ttm->sg->sgl in amdgpu_ttm_tt_pde_flags.
> 
> The crash manifests as:
> 
> [  228.188527] amdgpu_gem_create_ioctl[513] allocation mmio domain ###########
> [  228.188537] BUG: kernel NULL pointer dereference, address: 0000000000000030
> [  228.188541] #PF: supervisor read access in kernel mode
> [  228.188543] #PF: error_code(0x0000) - not-present page
> [  228.188546] Oops: Oops: 0000 [#1] SMP NOPTI
> [  228.188556] RIP: 0010:amdgpu_ttm_tt_pde_flags+0x2b/0x60 [amdgpu]
> [  228.188673] RSP: 0018:ffff986f04563998 EFLAGS: 00010246
> [  228.188686] Call Trace:
> [  228.188691]  amdgpu_ttm_tt_pte_flags+0x21/0x50 [amdgpu]
> [  228.188783]  amdgpu_vm_bo_update+0x105/0x710 [amdgpu]
> [  228.188887]  amdgpu_gem_va_ioctl+0x77f/0x800 [amdgpu]
> 
> The crash occurs because the instruction at amdgpu_ttm_tt_pde_flags+0x2b
>  attempts to read from offset 0x30 of a NULL pointer (rdi=0x0000000000000000).
> 
> By explicitly rejecting VA mapping for MMIO_REMAP domain at the ioctl
> entry point, we prevent the crash and provide clear feedback to user-space
> that this memory domain is not supported for VA operations.

Oh that is tricky, yeah. The domain *is* supported for VA operations, but not from the GPU who owns it.

So that change here is clearly the wrong approach to fixing it.

Need to think and discuss with Alex/Srini about how to fix that.

Thanks,
Christian.

> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 10e21d2d9b52..1b09d6b9af58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -867,6 +867,20 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	uint64_t vm_size;
>  	int r = 0;
>  
> +	/* Check for invalid memory domains */
> +	if (args->operation != AMDGPU_VA_OP_CLEAR &&
> +	    !(args->flags & AMDGPU_VM_PAGE_PRT)) {
> +		gobj = drm_gem_object_lookup(filp, args->handle);
> +		if (gobj == NULL)
> +			return -ENOENT;
> +		abo = gem_to_amdgpu_bo(gobj);
> +		if (abo && (abo->preferred_domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)) {
> +			drm_gem_object_put(gobj);
> +			dev_info(adev->dev, "MMIO_REMAP domain not supported for VA mapping\n");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
>  		dev_dbg(dev->dev,
>  			"va_address 0x%llx is in reserved area 0x%llx\n",

