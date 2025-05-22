Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA3FC54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 15:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436DA10E16B;
	Thu, 22 May 2025 15:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X9dMVngJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F21C110E16B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 15:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVi5mG40qy0MwgZ44uPOzrTY44VrNgaegeyLXFwvW5fIMxgjhmrOt6/ECMFqpSXoakuDfKQxyocpaBoKVCn2rffPVYWsYfij/i01js8YJ+jtsikht+NfsHoBGDhZytaRpu0y90ohef2k6LlxjJLQCcANenlrn+Jf8mq1YtI//8U7+Ejsg+196EV7ljYa0MAsOG/axT5HqJ4NAGm6Q5jE7Fs98NkQHNI4rc9cxKNnnijVzTQPg7D7ybq2LN7XqwU7wi6EHFq7mK1UJ6XL9LDvDlso2b6kTUOCx7uFUbEHoo9AkZNMRJmfyyHSfBgSKWdyAE4a4V6RY0leGjUQ2JEu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovDBipitypEsLmmpaykBxA6F4R6E/pJkGqLeYZsYX2s=;
 b=ApzKV0jftVisrn2nMAd8vD1xkDJM8qj2orQv1Rv7kV4MCe3bgw09QCovDkwSFMXzcZdcJrXrkiblwXOUF1V6exCLIhwt3iblej+vQZ2O1PiB1Q9tRxGwYdjECugOpuCQqCtMIbTxq7waOTOp3kG1145/u9IZDgm7IIGfgkkHaJwW5rCZRTfUurk5lhNrb472gr45YMi9LuiVUkIAOfluK4/kq5i8YhsOI4AI/A4kPi+/kLMsGuykCHVGz4j6C5pulgwEerXa8aG2ipT9jiuS4x/spXY/Gt5pPCIZ9x5da9illX1xRS45e2Ng9U9Qr6LGx1vM6j/s/qizxiVmK/zH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovDBipitypEsLmmpaykBxA6F4R6E/pJkGqLeYZsYX2s=;
 b=X9dMVngJ1Nre5Lh5VmY1PEcBa3Pva43JT2f7CjuKd5AX2LZygjZ6zdZr1t5SI8nJF/cIVdQXpLkbmEpfu3odCWSOAlWnSPN22NkS5Mb2UX7XPrBAxf30FOQG7rhAmKIcpEMQVigkYNsWcRhtc2uMj3FKvcnZzBx+DYckSDmRI1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 15:48:04 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%7]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 15:48:04 +0000
Message-ID: <89de9203-be8b-426b-9a55-904ca544dd10@amd.com>
Date: Thu, 22 May 2025 11:48:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Reuse Subvp debug option for FAMS
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: sunpeng.li@amd.com, alex.hung@amd.com, alexander.deucher@amd.com
References: <20250522143643.116897-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250522143643.116897-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0053.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::10) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: be9e6543-dfbc-43de-a3c8-08dd994809e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkNZbGUxYUNlWi9xYyttbmpnZHFrNTJDUXh0WVNNZU9VYjBtQ2MrbHVHT1hM?=
 =?utf-8?B?VjdCUXF0R1BrRGJVRVJKOEVXTU1icFRTOEEzd1VONFJEanlQNjhkNThHUjE3?=
 =?utf-8?B?cDE3dWFESnpzM1NjRGtENkhHcWx5Wkk0cS8vZlA4U2N1bzZnTmorRGIyZmxN?=
 =?utf-8?B?aU11RSs0UC9vMnlBTzFLcDdldkJhVWswTzc3WEhqSnNBdFVUVWZNaUo3amZV?=
 =?utf-8?B?cXNGS2t0TFZieDlybDllYVJPcXhBYm1XTVFWeUhVWE1xcm5acERnOXVSbS8z?=
 =?utf-8?B?d3A2NDRpenhIVjNCVmNEbkVtSjR3cEhWaXlPcnZYQXZOd09SenZHalh4elFp?=
 =?utf-8?B?bjNDdHlDUG1sckpvTDdYMGprNzJMQVBMbmx3SWYvbll4ZkdXbm5pRVEvQXly?=
 =?utf-8?B?cElWRkZVYk9BM2N4RENTdXlWZFlOcGdQOUh6dW1uem1RZ1VkT1U3NnkwaWcv?=
 =?utf-8?B?QUdNWnBxbTBSVEgwaHVvZ1l4eWJkcUhKb0sydWdXUmdiUUVjUHVxdys3UHFL?=
 =?utf-8?B?TjZrdkx5SUFUZjF1VXcwMzR6ek9rNThyanQrSlpWTUU3YmVLVWZ0QmZ5VHBv?=
 =?utf-8?B?LzVkMU5mamZhUWlXdVFrZ1VUdkpwRDVnMjVWUWNOMS9wcXZ0LzlqQ3JQVVc5?=
 =?utf-8?B?WjdLUEFsWExNUi9GNVU3N0owRHBNcUVTMi93TEMyandQcXRzYmYzNWRVQzhB?=
 =?utf-8?B?Z3lTT0FTM2VNMThNaG0zaDk1dlcyTXpzR2JqZ0lpZTBkTjhpSVlrTitidytP?=
 =?utf-8?B?a04wL2VUa2NNUS8zbzZETE40SHRDZmFyY25sNEVKQWVGVGc2d2s3a3B2ODBL?=
 =?utf-8?B?M3BxUzRlTUIzS2RUM09MSVdCcW91OEhLT2YwNmxnd2ZMcDFtU3pZdmJtNWdV?=
 =?utf-8?B?ZHk0MVFjTkRweG1UZDdxeUJUUWpNMWUvbFBSbHYrK245TXZYWER3SDhoYWh3?=
 =?utf-8?B?eUJJSWlPbjN4U0pzdC9EQjlpVTVKSGVDZDlzSlEwSGJPL3k5V0dnaXZSOFg5?=
 =?utf-8?B?d1FCaWpHRysyMHJ3dVZLaC9GNGpCdUs2WDlzNVpINXI5WC9aZXJSMFIvUWdv?=
 =?utf-8?B?U0J6L0krampYdzMvbXJoeEtDLzVBR0R1TVhWayszSXNmWENLa3AraEltU09Y?=
 =?utf-8?B?ZHFJYzdhaDZvQ1o0MWwvOFJKdEYzN1d3bmhzZ3pKUDFpWm5qR3V3NUhqdGVU?=
 =?utf-8?B?SUR2YUdvM1hmekxMdlVqVGppOTR6RGZMYzl2L0NmVjRJbjZCVDM5aWRnWUFy?=
 =?utf-8?B?Y2VVU1R5eXdZS20wNTBRR05GWDFkdXlvN3VyU25vR2ozZVlvck0xMEFSbTdR?=
 =?utf-8?B?a0hZMGxOZU82Q01YUWV6SjdPV01yTWVxWkJsRUdNRlI4cHhpek5KWXROSjNm?=
 =?utf-8?B?bXFMS2pOSEMvbm4vcEd2RmNhcDRUZTUvcTdzOGdtSEIwbXJ0MnhoR3AwcFNB?=
 =?utf-8?B?UjJnaDJkTmpUVFhyU20zMHU1RlFFZFd3cHo5V1U1RGxoWkdsUVJQZUpPazlK?=
 =?utf-8?B?VzFyMDFnRzJDQ1p4QjZBcmEwRkQ3d3Eyako0WTF4S3hubGFqdFlIMDBTWFc5?=
 =?utf-8?B?bjNBMDlJcEtsb3VFeE8yNXp1Z3RlRkhHVldhL05MT1M2UXFSNUhjSFFOYnJm?=
 =?utf-8?B?KzlnVGdydEdicWJTR2RPVGtQdVVKZ3FGT2NoWHFxRDBRVTZndGlVMTM1RTIw?=
 =?utf-8?B?VFlTcEJKSWxpNXZCY2IyQzZtRlhhaS9vb2drMk1RR2lNbjcrSDZldXA3OGV1?=
 =?utf-8?B?aVQ3MkdrWCtmTElFS0hoOS8yeTNzUmx1dFEvS21vdXF3c0FnRlV1RlJoM2JY?=
 =?utf-8?B?YWcwRUlRaU0wcTlPWndXUmxKS3c0d0E1RGRhb3gvbkRwVDI5WkV6NSsxbExC?=
 =?utf-8?B?cVBDNExnRUJGRStWMTZVd2ZJL0J6ajRwVElSZVdkSHZ5bjg2SWFrWmRXWHJP?=
 =?utf-8?Q?qW0G6i83k1c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJmRlRPV2FGWG4rb08vSFJudWkyRkpqZEVQNStwaFBmWHVtZ2R6SldCYk1M?=
 =?utf-8?B?SThkd01LZ05FYm0yQjBMREJoRVRTeWQxZG1id294Vjg5ZmNMSzNwNzhBdUdV?=
 =?utf-8?B?TjN1TXhQUk5OOXoxbTE4QTRvQ2JtUDhyZjMyY1E5T0QyWTVibllnbjJGalZN?=
 =?utf-8?B?U3p4NTNLdUxSeHVyL1RnRXBaR2xVazYrOXkxNGcrWEszaFhXZkVSZnBEemho?=
 =?utf-8?B?WU1UZ05ETi8xNlorY2JhZW1URFcrUUE4UzcwTFhoR2FnNG9pTzM3ZjUvR0tz?=
 =?utf-8?B?S1ZwbHVNK21BWDVCSzBKa1ZvUE9lKzFVREVKSXZ4SklKZmNoL3FQeW5JK3FS?=
 =?utf-8?B?b2FDcmhCbmxQU0xRTjh6dFdPUVlaY3Y2Mm9wQmcxWGhvc1g2S2U3dHBiWlI4?=
 =?utf-8?B?VHlqdlhxaHIrNWgvTnNJQ1p0d0w0eFFLdW9seWJoT3ppVE83NFYyQzJCazE2?=
 =?utf-8?B?RytZU2Q5Uy9BYTgyYVpuQjd5b3BSb0d4YlU4eWt3c2JtSTNRVG4rT21Hbkt2?=
 =?utf-8?B?aXhKUHpFNHBvYitHZVVGbUQ0N3QzUGN5aS9xUGhHeE1XMGliaVZ0cTd1L0xK?=
 =?utf-8?B?VlN5ZXRXS1VCd2E2aEJXa2FNNnR6RUgxZmpENm12dUt4bVUwamNRWnFuUjdF?=
 =?utf-8?B?b2xwVk1lYXRUSWlsWjFVU0ZuTUkvb3lqYnRSd29oYnYvSVZQMlFyZzZ6YUpD?=
 =?utf-8?B?ZWVpbGxoK0xZbzEyMnlycENWU3A0Lys3WVhPQm85MnB3bkhrOUh3dTNCTDk5?=
 =?utf-8?B?NENLcS9VMzVGdzJ4L3VyS2I2b1lrVzF6amE1djVpZVFvZmdaaTZxNkltbDMz?=
 =?utf-8?B?QmZRMFlheEI0cmpNblp1Ymp1TW5TTGUzb1RwU0xZa2FOb0FKa0VnaEFTZXlB?=
 =?utf-8?B?QmQxQU9CQXF0RGptSkZmdlVONkZsb3NyZkFjOUhDL3FBTWJ2YWdiSW8vTE1Q?=
 =?utf-8?B?VEV5MS83MTFDU1hxckZBMExDb0gzVk53M0h4cTVSNEpmeDdINmRRZ1BzZGJV?=
 =?utf-8?B?YmFhc3NQS2VEa3lkS3NuRm1rblk0RnpnQngyQmk5Rk1EV0tBamN5UGZjZktM?=
 =?utf-8?B?bStNeXA4bFQ4dW5hQzQ0Vm0ySWorTlJDSjYyRzkxaldSQys2K0o3RUVkSWRu?=
 =?utf-8?B?Zi9Ea3hNakFsdHZubDlZRjJRSG4wMFBVdkJObTd4OWFmYWpNejRlNUR5bVJX?=
 =?utf-8?B?NlRZbDVEQXB5emxzeTlvNzZ4WUkxRHJXZjM1NDQrdmpzWXh3YTMybS9kaVVI?=
 =?utf-8?B?dldhMmJXZ1BuNHI5cEdOSjh3czFVWmFiVHRMMGtkdUllczlWUHYrWjMyQmNo?=
 =?utf-8?B?b3oxd2lKRU5NWGN6cG9hbUc5UkoyMGtRNGxJT0VSN21Za3g3d09xVmFxMTJi?=
 =?utf-8?B?VGhMeU5RSWVWdEsvbjAyZ2tmL0FGOHBGM3F3b1BjQWJUSlRITlpXdkJLaTEr?=
 =?utf-8?B?UzlKczkvdFRZcFQ4OGdzWGlMUGwvRW0xTmxYOXl6RDQ5SUNFdGpLQTloalB4?=
 =?utf-8?B?LzJwVkJrUkpRb0hkSGthSW1GZllDZ25kWjh2eG41cWszb3Z6UTRQMGFTd2ZP?=
 =?utf-8?B?ZTRBNFJVdGNpUkFVUDdLc3FzU0g2SndtOGdjellXQUxNUzRYQXF6WStmQ3Ft?=
 =?utf-8?B?UXVuTmM3UVRXNHF3V0daMmc1RnphMGRSTUxRTFZaV0piNGtIWXBCcVZOMzlG?=
 =?utf-8?B?Q2hocDZjVkdqRHYySlk0dUlCdkFoNWZya2RqNWJNRTk1Z3dieUlSZHdwbGdV?=
 =?utf-8?B?MHRGelZiY3Q5WEZvTGxVNGQ1aE54d0xOZ2wrY1JDYW9rZWVGdmZPZC9HcFhE?=
 =?utf-8?B?bzBWc01YcDRwbkhxVlRvcjNhTzdQSTdyNEFiaVpNZnhhR1VDNkZkVXRudGhE?=
 =?utf-8?B?Q1oyTVVCUTN5RU9IN3MvK0w2ME1RcXluaGI1a0RkSVowSU1hQkhWV1NxK29w?=
 =?utf-8?B?QklwSldnTzc4dlJSa08vMFJoL0xvYUt1KzZyelhsMUpLTENBODNaazY4Z2FO?=
 =?utf-8?B?c2duaEV3RTRQTmJFM0hmdWZXNVdnYkZXSmxFcFVFZ3JtY3h1WHFlNVhMSUxM?=
 =?utf-8?B?ODBlSTFEQnVPTjNLOFFsT2prdktQdVliOFJhYmtlMnl0blBTUGtnOG5vZnBJ?=
 =?utf-8?Q?kGPuKZKEFTC6b8JrcY7/5KrP6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9e6543-dfbc-43de-a3c8-08dd994809e2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 15:48:04.1187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rpRUrlsnvxgukGg50oD4zydBjE4A+v0B6YHKLtIrsNKlX33aZ98o3y5r8TI8KB7k4BB/o0ZyFX4Ghrw5PT9BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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



On 2025-05-22 10:36, Aurabindo Pillai wrote:
> FAMS is the successor to SubVP starting with DCN4x. Reuse the same
> debug option to disable FAMS for debugging purposes.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
>  drivers/gpu/drm/amd/include/amd_shared.h          | 5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index acb5a6baabf4..8a1bf7ab8570 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2000,8 +2000,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
>  		adev->dm.dc->debug.force_subvp_mclk_switch = true;
>  
> -	if (amdgpu_dc_debug_mask & DC_DISABLE_SUBVP)
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_SUBVP_FAMS) {
>  		adev->dm.dc->debug.force_disable_subvp = true;
> +		adev->dm.dc->debug.fams2_config.enable = false;
> +	}
>  
>  	if (amdgpu_dc_debug_mask & DC_ENABLE_DML2) {
>  		adev->dm.dc->debug.using_dml2 = true;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 31de36c9156f..11374a2cbab8 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -351,9 +351,10 @@ enum DC_DEBUG_MASK {
>  	DC_DISABLE_HDMI_CEC = 0x10000,
>  
>  	/**
> -	 * @DC_DISABLE_SUBVP: If set, disable DCN Sub-Viewport feature in amdgpu driver.
> +	 * @DC_DISABLE_SUBVP_FAMS: If set, disable DCN Sub-Viewport & Firmware Assisted
> +	 * Memory Clock Switching (FAMS) feature in amdgpu driver.
>  	 */
> -	DC_DISABLE_SUBVP = 0x20000,
> +	DC_DISABLE_SUBVP_FAMS = 0x20000,
>  	/**
>  	 * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: If set, disable support for custom brightness curves
>  	 */

