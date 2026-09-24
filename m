Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAC5C98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 07:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904BE10E07C;
	Thu, 24 Sep 2026 07:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FedunN3T";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D4510E07C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 07:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDGDB1IXlTgSu8Cpq6/2wgJ9aKb+m9H6sbT9tU0HFijWeMluJm/4z9w1CRezsZU7ITuPnz/cSfA13uZJV5ry8T1af7eFN+hH2AAQ7mY0PVnnx17VI2NhbQTu6J/VamcoAPDMEQbvKO5I7dasCaaxyL+vMlgqy2ZfWLOFI0+1uKKEX2E1VGyoL1IRT0a82qui+c/QimvJrzjZaVsSkyCsgkLKt0runsNXBvsZRaDWyoJ1EoT0kSYO3HCwu1JgJN9tzgpl4xr0pFVHrHiz5nHS3jIn9gDF4zOpjOuFMk7tsHuqqgJHLfNyi9K9Y0gP10loPp1NvswSoUa/UXS0k8OnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfMLVYaxYL0QDZkDWLykpOlwqeo+fF3zb/K3EVy/rUE=;
 b=UKgHg8yEwYLprYcSX1zqGTD6Tr+rYKjNJQhScUlX4cMFG2Xouq/8Lwq9uLSIO6KJ52W5oGpPv77r/07GA1/SLs/w4yP5Tan34+m8tO8sGeU2WLQ6ZdUkRU2ih96gAz3W6tMWOZ8h0x5Uuwu9TehWDQNtnrL08WUQkkYPjTBBnm3NIjopeCK1G4RNiieQdFCTM/HWUqcKvlmAdeUJvulhY/B1zQZWn+t7LyCehNCz+Csm1+hpWHW1d4ijGHwwSjzmuZXF0ZDMfRL83GKbo4AJGF4QepHQtUcv1jKQ2J98klRnKnll2tUtbjT/iWKt1KGp3YjrJRnhgZxitKPzNRbMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfMLVYaxYL0QDZkDWLykpOlwqeo+fF3zb/K3EVy/rUE=;
 b=FedunN3Td0QSeyHbeQJYTWukpobA9TjXJgx1sfvC3FOWWCwFp3vft/DxeV5yP9Mp8AffI7K6psHDrlXlbtk7nwVGrGgglSCrLOq/jLtrN1H1SnmEWgTheOxw6VjO/cgeXB7stVkG9aOcBC/Oq0zH+ohjqWQIY5q51PfNmFK/RF4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:51:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:51:56 +0000
Message-ID: <10b12db2-6801-4a20-93ba-40c56d9f6490@amd.com>
Date: Thu, 24 Sep 2026 09:51:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] drm/amdgpu: push down runtime pm handling in
 amdgpu_gem_create_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
 <20260923193346.2292597-5-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260923193346.2292597-5-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 8318b63e-8b2e-4c67-a5af-08df1a10b44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qglQgXPG93UpFj3fTCQYcpgaYSfcVNaHe1KEo70LRsWYkziQwmMXHVRmkMn7Pq4yd1codlCQTD5N4KeynRDUHWyi4+nY3npvvhF//81dhajPVepJAVWYd8kDW2TVZOq5wi2Wss7eXs6TFQoLKsqqhbO6/EE6phpXRy7cnRPNGiOTILD8srK1yRFJaYOLV2YDoGNC7rgMR0n3iUXXFMBS4uRkc8M5cOXp3Sc0Q6odVqdaRHzdsfUvlo+WFIbn2CCgJfBd6/2Ue7TeQ+uHdWdn9HlnC/sIIOAtThMRXmGssZMPHImdx1pKoB/GkUGfOs8E0wqFo0XlDq982GlSLTnchrtnRaVrSx3SIDqGASWIWQSTPV/Xdy7sm4c9F7YolssMfTa8Ph031ASAVcrLgPR7YCqF5Fz84x8MdfkJtfdPh6+Tel9Z5ETgIIMoW/Fy8gECYdPlGk18jBMAzTcOFyPV4YMz95yOJPopRbD8cWYVB48eNiHbR/4FBeEjuR9WFJkqtPIs4N/3NtwFroWPnFr201cIZWtfn94I7or4MjKZvf84BZ0KaBFDlO5HqK6yG005jJK5BVFV161gPL4LCyrCQMGZK6KuQ1irZww24+4uKsieeqpCH5f/QnJW8K9VWIPn3Vbpvh4AYfhNRSACW2WmyjLqzxVtoQ0ap5P4IGqayos=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2pCV2RKeGtidHJyWEhiNm80cXVXUzhSV1ZodG1rSmZlN3JzaC9DcEwwZlhV?=
 =?utf-8?B?amtRZFpJczNoRU15UWN2dW9hanNpV1NVQnNDdytPbGI1V29DTmU2MzROOUJJ?=
 =?utf-8?B?enFTSnVlYXJoUFJwa1BTQmtpWE5SRVJMSEZIaW5lMHkxQ2tGK1JKTTRUMmwx?=
 =?utf-8?B?RDk0Vll4Z1pCL3luditIQTlhTDN1U09kZXVpRUszMUhTM1E5ajIzNWlZNWMr?=
 =?utf-8?B?aE05ajZjQlltV2RNUlRwVWIxQ0xFV0tHOEhIekVucllGRk1qNUlsVGQ2cWlR?=
 =?utf-8?B?cUplUGNRdHEzZVV3SXRhZHZORVhWakw3MmFYaEhwRndrUEFoUXM0RElQKzZj?=
 =?utf-8?B?WVhCcjVMbVRxUGhPVWJSMUdUajduOVc5SG9vUTBtdXRXWXZNZGFueWMxTjlx?=
 =?utf-8?B?S3pNNDJZTHorL2tFbXpXcSt6ZmdyQUtPZ29SSDR5SXBSUUVKdGFCUk1Oajd3?=
 =?utf-8?B?Z1I0QkdLUERucHdqeWljemtIMVU2SWhzVEd1bjV1M0g3ais3VXFqMTlsOEJk?=
 =?utf-8?B?SWFwUjRvdkJtVXV4NEpxeE41eE54QTV2enpjSy9QdkZLQVlOTjJhbzc4eWxa?=
 =?utf-8?B?QlpzMGxHZldzVFdJT09Kc1ZRTy9WampGdmVHMURNcWZoVjdEYW1ZcVloamw0?=
 =?utf-8?B?RHFGYWRkVlFvYUhVUW1uVGFuWStsbVN5ZlFWM3MwbnI2Qzk4eCtVeDlLVVM2?=
 =?utf-8?B?WmZjeUoyYWhHaWJZVEZpdXUyRDQ2UkNEMW12NXFIR2FBS01DSm92THNiSjZH?=
 =?utf-8?B?QjkzYXh4RlZoaStZbmJ3NEJ0MFp0bVR5VytYOEo0dHNBd1cwWTAzS0JYSGFY?=
 =?utf-8?B?eW43SC9od2didUxCdkFyYlVwQ1FGeWZQNy9kdmJMVlkxVnhVNURVdXZVUXNQ?=
 =?utf-8?B?VHkySFB5U2I5L1ZQdWN3RlNsdk9FU0JMWjJjdW1QZDNzeW1IdEtMZUJjemRE?=
 =?utf-8?B?UEIrdnlMOUlaRzFYY2RxeEZHb3owRFA3dWhQOWllNk5hckxPUkZmWDhUdE1L?=
 =?utf-8?B?dXEzdjRaa0UrSkxid2ZIYUh0Zlg0Nk0yTFZ2MXM0MWNqbitOK2xxbm5DMU9C?=
 =?utf-8?B?MkJVSkQ2RmFqRVJHR3NlRTVwNVQrNm5oMWNKS3BWcWtUbHg0aEZLZnhUSmtG?=
 =?utf-8?B?c1VSTFV6QkxoVm80MzhJbjF2TUlyVEpHSFNUbFc3TjltTHduSlBsM3p6Uzlq?=
 =?utf-8?B?eG9Bc0d1UFFucWZSZUIwSmNoNlZzTFNmeVAydzNmWTFMSVFveWtRKzZaRDdz?=
 =?utf-8?B?YnpDN2lrQTBVNUJ6aDNFRGtGV284RURyYkl3RnR5cjhuUlZpZnhFK1EyZ2Jz?=
 =?utf-8?B?YlZZakxIR0FWWTUrRHFvbjFGVmpDK0dibWE5OEszRlE1WisxaDFMV2FYUkpD?=
 =?utf-8?B?TklYT2R2S2FOcERhdGQya2szbVBZR1Zvd0ZsN0FJSEFDdzRLL1g4UkQxaDR5?=
 =?utf-8?B?VWxOcmFuMTFDWHlYRzJJWWhSSGZadWZKbUFXeitHemljOXN1R2xiREplajVk?=
 =?utf-8?B?L3d5RTZJcWNiRlhDRXpkb2NsZWhxRkh1WmlKbUZ4S2paTnI0VEJxcGpRcmgx?=
 =?utf-8?B?UWxHb1VzOXUwRmZrNXA2d2hIS2lTTTJTSWpFZ0t4Kyt5eXlvQytiVzBaWlgr?=
 =?utf-8?B?amhPK2VmNThSQkh3Sm1PYmhwRlN3a0pwWVJ1Q2wzKzl3Mk1lYTdZbC8rMHUy?=
 =?utf-8?B?Yjd3d1hGYVdTd1BDQ1ljREFFMU53cEJvbG9XeFJYV2piTXlwcll0L2dHTk1z?=
 =?utf-8?B?L1FMS2t2SDA1YjhHZ0FtVzVUN242aGZHc3oydDNMaDdpTjRrdlJDQ3NBS3g0?=
 =?utf-8?B?Z0U3c25xVDBReTZ5MXViM3lFMWV0TDU5eDNpVE1FZVV4NXZwT3BPbStYb0NO?=
 =?utf-8?B?OVQ2d05Ha0lBSm00MWVXUFZvYXFhUnNNRVNtMCtGWW0wRUtrZWtDR3BGellP?=
 =?utf-8?B?UGZ1RWwwMzI1YllBNjNTZkhhV21ycFhhQWtZZVdDK1d5alMrb2Q1dnRmS1Mw?=
 =?utf-8?B?MVBqZ01KYWJtNE9CcTRvVHFiWEtkV0tCNnBxWUxnL2MzS3hRaVQzRWpLOE0x?=
 =?utf-8?B?aGVTU2dnNngwWkRlVDFEVi95Z0l1OUpTaFdodDN6UTNONENaQzc4YU1mMUpr?=
 =?utf-8?B?QnRaTWJmVE5KRWgrNVlDY1FoclVSZ2oyWTlqekhMcWRDejhKRXN2Mk93QjAr?=
 =?utf-8?B?SXJTVmg2TDE0c3RaMmhjVDg5TlhvOXB4MHc0bk9ZUDQ5NzZxUERvT2dWbmdu?=
 =?utf-8?B?b2g4ek5xQVdJQUxyVVdxVG5sdDVlRVZIeTl0ZytoY2FrcG1kOXZSYVdYaUxV?=
 =?utf-8?Q?rlrwww3tw8u4BrO5p7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8318b63e-8b2e-4c67-a5af-08df1a10b44d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:51:56.0851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k65+Z7BCdtm14WuEQPHgM7ezYiOrXtTSc5mwag39I6sp6o70wqb+9u7HP2KGFB3b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
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

On 9/23/26 21:33, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> For now use the same logic as the existing one, but it's not 100%
> correct since:
> 1) most operations don't need the GPUs
> 2) some operations that need it are actually deferred
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Co-developed-by: Shahyan Soltani <shahyan.soltani@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 4e4814caf61a..5d2802009cd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -929,6 +929,12 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		abo = NULL;
>  	}
>  
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
> +
> +	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
> +	if (r)
> +		goto error_put_gobj;
> +
>  	/* Add input syncobj fences (if any) for synchronization. */
>  	r = amdgpu_gem_add_input_fence(filp,
>  				       args->input_fence_syncobj_handles,

