Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C39C4450A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 11:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3061210E291;
	Thu, 16 Jul 2026 11:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mP/kWhkE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5F010E291
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 11:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxnW0KcIKh1FEPyKv03ef+UggpkOMyUo1uKUoIKPp+cztUzyiqhQRG9WeCgRFNyY6oqIj3SqDBvemlls2ic86l322K570WRK4pO4R5qm5l23+lGfL6fi8N8CRwfJpizQp9H77GJKCQSLLtAlKYJVKQ+kUw8+o4fMg40HcIik/hMk2VCX2TvCwrgbC/0TPrENV8ZbjZI+L1t+fub9I/mWrrWWsPtLKlt61gRDyg6YeV16g545vi4q2Qct5Y2+5F5MjrzgIxmJHBeglV2KQihOtiq8TRW0XnISKtkly192FDdbJIUkiinjyxN8odznHGRyNPnM65za0MUcXpgAWsHt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4EkCXKTAcdlB7a1diyeL80nVt0A1CyJsg3JVfYu6Hs=;
 b=PWeJL8EL+sRkK+q2SR2HTI4O3VLaFw49+zHXgLMUQHtvfZyuHgxH0lUHUpru0+B50XmMVsM96S6N01STDOk2FbhzqmxUuS98o5jt3YfDuSM3Y9UH6ZCd/A3ZbtbozT36UBg0o/G2QXpmXL72zYYhgJtX4sVoNDVhUdn/0fHPJa7txLlwnHbpLTEhYSXsVKxzk/OjMGA6rUE9sqOPa2nwCgjDwOA4uXfgqbSI9yQjm3zAKaBBg8wNpN82r/FpIjMFchSzr3B7j9r07JD/AP+JFjfMYqSg/FE9QxmIRHgsGJlWUdWhAbzNvphKU/odCU38XjNM3qMQDLFUmnoB9/DnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4EkCXKTAcdlB7a1diyeL80nVt0A1CyJsg3JVfYu6Hs=;
 b=mP/kWhkEbI6tIO2SEcEJy8PicQB3U3G6V0uHTxmw1ot71bhMUhpZoP2OzN0XbJBKrcN+fAX+LCTkuVAuh+SwYLst/wRgWINV5bM2NJopQCwyZFG6yeRvN6zv4DBrRAfHJne01NcGKKYqYYaPUTtrU+ih6QQ8P3Dy2PSgUQxXmIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by DM6PR12MB4354.namprd12.prod.outlook.com
 (2603:10b6:5:28f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 11:42:44 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0202.018; Thu, 16 Jul 2026
 11:42:44 +0000
Message-ID: <6cc4733f-0ff7-47de-9fa9-77e27bf6baef@amd.com>
Date: Thu, 16 Jul 2026 07:42:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: skip clearing empty freed VM list on GEM
 close
To: Bob Zhou <bobzhou2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20260716025608.1247345-1-bobzhou2@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260716025608.1247345-1-bobzhou2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::28) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 99686633-c140-4772-31db-08dee32f59be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7qHmDD3HZO8Cwl5a1UREH4Y7zMVtRM1vhz7vhJOFnwbNDK5SfUUZ/PrAtFBPwTdgR39OHBAvAYlhvBvgUNunZW99N01o/hEPWn86BbYGJyxwrWMmy9u6Wr5E0BLPTWV8wOb6E/uBoYc/PMnFZkKz2MgkPDKZYKl/XhrTUDF/q35zjbPp54AySbT+CAVW52OFcoFFsn9o4cbam/+WVbEBiSahYIdRXhw6Xe7V6PKhp619p1S3b/HHqcxY8QDDtqsbvzlmah709f9vZXKGmi3FWMUY8n4G6TrCvaR8romRW/BTV0qsUJ6Z5cpgI98Qda0viVulWb4XeG20ELBpEGEW7K/PaWMPSivAZmpohLrQQVHSUHn8TP3iEDmVXOxMj2IAUoqIsCSI2y0ZZP5Ed1fs9qwKbfRxgG6vp/zFnBocsgaWXqSMYuoZJXPdcFEJ/o/0j9wrq27VxyjzTHRPIqOLOWCsahwgwJZBnAWuuRQdo/uuHoC2WkksebmxzVxCX7TgQeC22/gyFryF0xXx8Ii+LqrTsLtI9vBc0Vcy9/5k8ziAB+v5aJeUpXmipy0ruEtgEPd4XzIWtIHIWWBaMjgs3PztPFMqVoE3fhIaBgWyi1wJ5Gdx/y/7OrpP6mEL/KhiCqw8xijSJcDcKoJ4ATwxNq2GvdkDRKN1sZ8B/4FLbu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZOWHpacjZBYk9NMFh0UkVRaWQrY3R2cXR3UGlvSTh2TzBPNFJpb1M2bDZ1?=
 =?utf-8?B?SGZmN2NhN1EzUmc4WmovT0VJL0xNR1FjUklYb3p0dTFqRDRqSDBkWFZlT0xB?=
 =?utf-8?B?YXg2YW40OGVzS1ZTS2w0U0ErVzJKZTd4SXpJblFmK1NzblQvUUJDZk9EWUhC?=
 =?utf-8?B?SjJIWjJUekxEbEM0aExoZ3E1Q0E2K21JWkIvOTRCc3ZLZXJZclFkS3lpa3FK?=
 =?utf-8?B?b1gyOVRiTnBpYjhyYlJwYzZDdjF0c0crSnBKdmRLdW5SN1FZS3puNTY4bngy?=
 =?utf-8?B?d3haTkpXdjFJbkdOakVBK1Ixb0RKZm1NYVkwY1VXMEFiSnJ5aFROTHFzL3lN?=
 =?utf-8?B?UlhLMmYzMUp3RXk1MTg2TVJSOHNZNzhDVnhjRnZKUjZKRk1HbGNMNTM3aFB1?=
 =?utf-8?B?aDZVTWlCUENZWGZlWHZxT0FrdUJhemY2Umpia0kxTHBaM3dHWWVmWEpIWEg1?=
 =?utf-8?B?MEhiT051c3lXelVmQjNKcG9uekRqWmJTc0JzUG9OZ2xjOWh5RmVkendTT1Ba?=
 =?utf-8?B?WkprN2ZzNW1PVEVxRWJwc2paN2UrYVFPbEJqZHZ2K0t3WlE3NUMvb0dHM3Jt?=
 =?utf-8?B?ZVpWQVBNT1N1R1grVzFxYm9ObTY2MDZBOEZtSXhHOUhIaDJIYVo0bUpUYTVp?=
 =?utf-8?B?QVAwTGJoWHMyN0lYL2laZUQzYitsbFgvL1p2Znh2MnZsZE1SQWlraEoxaTRU?=
 =?utf-8?B?MURweVhiQ1UzcXdNTVViUjVpTHAyUGZNUVAvV01NakxhNmhtTmFUblJoenNR?=
 =?utf-8?B?dlVQOHJIQXdtT05WbzlGaFhuenE1V1piTUVrQXd0Q2tGZ09hOHBuY2E1cysz?=
 =?utf-8?B?KzhsMnRJcWlWZCtLZU1EOGw2ZVQwaG94K25xbUkrQ0hBM0VFbUtSdXIzdmd5?=
 =?utf-8?B?YkxjMm5nRVpOenVlNmhPY0x5WFlqdnkyWXV5bFZTdS82OFlVWHBUV3NkaG5m?=
 =?utf-8?B?a1JUcExYL21WM1FsejFJUkZ2a3BUMDNPYmJDZDMzSEV1Q3dYYUFXVjNIeE1j?=
 =?utf-8?B?bG9VRkJIbE1xZ201SUNnMlIweGpKbHRhWTQ5aUpQYmFES2ppZjJ2OVcyaVJK?=
 =?utf-8?B?SDVGdDJBeWJROHhSeExZVkFzb3gxMmVUa2hHL2dhTVBjVGd1YlRtRmRDTFIx?=
 =?utf-8?B?bFRDY1JkUDZQcXlhK3E3cEJ3UTdDY3VvNlE4ZTl4MFlsUUxHQ05DWlNWN3dq?=
 =?utf-8?B?TmdsYnpDNjBiZndKS21nZ242dmJpWlEvRmxGemEvVDBHVHdkZHlpL0hIOVc2?=
 =?utf-8?B?enJBem5nMXRDRUQxQkZYWW9waVNXMUhjMUdYdExnbEV2Qm1Qa0s0NTZsVTBh?=
 =?utf-8?B?UjY5YTBIcWpvNEhQMzRqa0JpRjd3amlzeWNqT2dRZlYxcy9QbmFoaDlrRTNq?=
 =?utf-8?B?L0tFeXdCZDRRY1FmZ1dBRElvNncxTGRYY3lzMVFrckRybzRMYndzZXdndFFt?=
 =?utf-8?B?MVcrRzlxK1hqMGVid051L3ZRVlp2cHAwWXBiVnl0cVVNd1hCWjY4WDE0RE15?=
 =?utf-8?B?M3I0T0wxcWd1UEVaeGJOa1BCeTlvOHkxOURJVjljSWtpNzVKUStqNkFGQnpN?=
 =?utf-8?B?SlF5YllKVVIramZYSGJXWUFjMDFVblpZUFFEQUZRSUpDQzhvYjdod1I1VWJW?=
 =?utf-8?B?L1hYb2d2TTA1VUhJT1p1ZndrMHpGa1ZNN1Z1ZVc5em1pWkxVYUFzRXRFK2JM?=
 =?utf-8?B?Tk52UzM1MmVDd2c4MHA2ZUQxa09CU3FTUk5jOWljenZBNkJ1cTRJa3EwS0JB?=
 =?utf-8?B?ZDdkL1lQZlFYYVBEVnJjWis5M3M3ZXl5QjVBZEtBR3QxVnpxem84ZjE2Yk45?=
 =?utf-8?B?cnFrclNycys5MXJUb2t0elZaa3RlM0pLa1VZZXI3eXJnZVJGME1OYzVxaVRq?=
 =?utf-8?B?UFpXUmVVY25MMG5HV2I3TjNWSDRGMnNwR3R0UXRMSWlTaHBsYnhaYksrME1y?=
 =?utf-8?B?MDhGSC9vbGJyYmZwUWx1cm1kdStUL0JOM3pZYUticEVLMUg3RjZ2bFJFaXNo?=
 =?utf-8?B?ZTUzVW5PZk4wTXFLVXV6anQ1aW1CbjhtM2ZxWFNrcDBGeVRUSjFXSXh0Y3VO?=
 =?utf-8?B?NEh3Wng2QlVRMjFaNFA3dlJidm9jMWpMZjg3RjkybkVjQmRUczNhUER0dk84?=
 =?utf-8?B?TWNVQWo3MkNsQ3dMdFB1YXEzYm1iZzRqaFlVQ0gyZStnR0x3a0FFVE1ONzVw?=
 =?utf-8?B?dHpqaHNBT0hWUWIxU2JiYmFucklQTlBwdGtqekJKTU1tUlNKK0M5QVg2Q1J4?=
 =?utf-8?B?RGN2ZUc2TTdQZkdqZ294TDNULzFmV0l4d1I0Z294TnVtVWJkcUx6MS92RkFw?=
 =?utf-8?B?RzNnbHNXaGM4eVBnVGxCWkt5ajNUYmFHU3l1SEV4SHRZVVY3ampLZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99686633-c140-4772-31db-08dee32f59be
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 11:42:44.3671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBrHORMGRbA45oL9tp+0I4MpUevAMwBlyIf8DBpQGz+v3tSDm4nTlYrtm103DAWf0A6dbrXyLvHQaryQxPEsZQ==
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

On 2026-07-15 22:56, Bob Zhou wrote:
> amdgpu_vm_clear_freed() allocates an amdgpu_sync object and walks the VM
> reservation fences via amdgpu_sync_resv() before checking whether vm->freed
> has anything to clear. Return early when the list is empty to skip this
> overhead on a hot path (every GEM close and command submission).
>
> Signed-off-by: Bob Zhou <bobzhou2@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 157d4168907ce..eb6a70fe79ceb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1553,6 +1553,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   	struct amdgpu_sync sync;
>   	int r;
>   
> +	if (list_empty(&vm->freed))
> +		return 0;
>   
>   	/*
>   	 * Implicitly sync to command submissions in the same VM before
