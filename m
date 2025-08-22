Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090D1CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 12:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B78410EAFF;
	Fri, 22 Aug 2025 12:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eyPy5ZA1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A357510EAFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 12:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMKVfgKreoYYXulfQ/zAPleOFKEQmEDYb9ntimywoFY9xwJKx0/N0GPaydaGoljRQS3kYKjX9u6He673cCVJ2cqYCvadK68Ja90K2TRPad9FRE+UJiPJERS6wQt+zvFPWse387pLMN8PgezkmJr+z8Ct7DVaSXR1Q+cxpfCZGFtyRtElo0nG9QVCEO1Vw6QT0LQvtAZG88aSjOrAGB6ZHt8CjOBstQY6eRarvwCN1A0KMyz/MgGzDOD46DNsp5DzfCg5dM+g5rfK4BvzsRoljeXTZsK0N5RpmQLNhlm5GDoyJ+TaH1XBJjxrcgBd4x8vSzykMWkrKwas/iNi07FoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLLaHyJjWA4th+qs7tx+n0CeLpVLeATy3C8zHuFnbiI=;
 b=aVmxzR22Ve7RF3j99/QrLmvHTr5Ou7B0tBxMUF07/7T9J/usyUbIP2Kt1rQx2Y1WmAF2qGRJhqvjCVqCIpTZxPWyOnt4U8+TLLeny5fw+HSOJVfFi+1AEBGgHzc8Z9vgjlGmvUeZA5U2xUYkFajBmGeSFI6DiPl7s2K3cuNfyxhIKEkrx01vvO9s1WeZhPt3fgq7qRaOjaYU7TR4NS4SCRSPtY7YwF3+Cwe9Dv5wNU52M/pedPuaQFlG5vv2hwx5QbY8yqoko14lZBrEFASn81zvPICnCT6P9zYONPHCJtEhID96RxYGv9Zg9cUhgNyPYusJxhjqssnNwAxYIp2N/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLLaHyJjWA4th+qs7tx+n0CeLpVLeATy3C8zHuFnbiI=;
 b=eyPy5ZA1AlEp6WwNFvpfR4DVVcWYXTsrXJzK+PWdy/QZPY0uzqwqR2uvsdt21DT0A0uQJnv6pPWyNF+qjmOgshxq52/WGENITEPH2L7ktubFtY2OhAvPdgTpNiqPmHkp9Yw3cRV8zalcNAKQ83QCm5e7/iWqh1bpgsNL1UH7SME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 12:54:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:54:28 +0000
Message-ID: <5387bc38-2996-41e8-a853-47d7ce773bf4@amd.com>
Date: Fri, 22 Aug 2025 14:54:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/4] drm/amdgpu: Add ioctl to get all gem handles for
 a process
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250813184953.3666821-1-David.Francis@amd.com>
 <20250813184953.3666821-3-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250813184953.3666821-3-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0426.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1dee2d-d472-41bb-9917-08dde17b07c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkd6WHNXcVdXVXY5ZzMzVkhZYWtrUzM4dkRRZ3hLUE9DOXFKdno4SDRnM25W?=
 =?utf-8?B?a2gvZjByWVowWHFzcmFyQWJVSW9HSlVDTnVIb2tLN01wcFZ1OHB1SFk4bFB0?=
 =?utf-8?B?d1ZGQXo3WXFFZFVoQzVvc1hJSGlpWkkyY1NBTHJ0YUwycWl6MjRXUFRxSzJ2?=
 =?utf-8?B?b1VXcjhWa08rOVVWdGZKeTNxU1dEaGJVMnJURHpNOFVRNENlQStONUxuWERi?=
 =?utf-8?B?cHJENkJNeW52WWg5YWQ4ZUZ5aWxSclRqa2NuK1pNUUxYc1V4WklCSHdFbW0y?=
 =?utf-8?B?QUd2UGE2ZlJqM0VJNnRFa1lqZURKbmFObUVtSy9SZ2pHZEswTGZ2eCtvN1B2?=
 =?utf-8?B?NU1oUDU3MTVOaXBXTkY3MTU4UWIvS2VzOHhkcEg1d0xrZWZNMXl3RWl4cTJM?=
 =?utf-8?B?NXU1QWFHTUVOM1Z4Q0hUWUJYT3Y0OFdrT3M1WlZOZnRGWkh5Qks4QUJPc0hj?=
 =?utf-8?B?alFFd1M4V0syR1N6cWVLV3lnUWEzTW9FRk16d0hKbTVHVlFFRHhWdXlpWCtQ?=
 =?utf-8?B?VUlZcG5jU21NNm5PTVY2RXRsT1ZNVGd3RGdtQmMwbmhFNlplditWSjNFWlp3?=
 =?utf-8?B?Tm53TUc4VlVaSkNvTEVVdzJ3aGEvREF2akVEenRhN1M0eGFUSXpubE51Y2xp?=
 =?utf-8?B?NFdHSGllYjlZNDRHenhET3c0SFRYaG9ycGVIdENDd1hmcmZzcEhlaWJPVWtt?=
 =?utf-8?B?WG92VVUydk5OeTdjOHFFdDZOZjc2dWQ2cmNMMS9nVHZ6eHd3eHdtaHFLdkI2?=
 =?utf-8?B?TXh3QU5FYnV1L2M5eHMwUGtsamxHRWw4aUFrT1ZqV29EZE5xWHFJY0dONm5i?=
 =?utf-8?B?K2dJc3VyWlkyR3Zobm5URFVvenhDWVNkd2RFbXNvcEhOTU55eStYazRpVG1T?=
 =?utf-8?B?TjN6VEFhNnFJd0hFcjVoT0NpZnhaU24vQisxQ3B5T1pKbUNpeFU4U2VRNVFn?=
 =?utf-8?B?NnJodENQOEw4a3FsYkM0ZmlDRjhVaWptNWVyTlV5UGZ4dklxc2VTS3FpMW9a?=
 =?utf-8?B?WjBIRkZQWjNvMWNJNmNFK0I5T293QTVjZlU1TkJUc1NybE4ra2ROeUppcHJW?=
 =?utf-8?B?U1hxQTEzaE01bDNCMU45OGt0K0lXMDViYk81c3c0UEliMkNvanBPZnRWL2Ey?=
 =?utf-8?B?TXJOOUlaM1VEY3NBcW8wL1E5RytWLzBLT1FzZi9VNVM5amZCRCtsa2hKZlVS?=
 =?utf-8?B?ai92eXgyT3RFbGk1NG1hcmhOWEVLSmxqZWo5WDVUa1NyNjN0WFRnVWttZmRp?=
 =?utf-8?B?VEtzY01OMzBSNWZlcmtQaStMMFYrWkhaVHk1MVB1YWFqdm9aazd2NTd3TUFs?=
 =?utf-8?B?RDlqUlV5Tis5RVBuVVFYdUhJcVRHQ2daVkNKREhnbC9SZ1ZYMWMvazkzckkz?=
 =?utf-8?B?bHlwNk82WVpGZXFKaWdSVk5laStZTFduWTRVS3Nua3MrVmxleXl0VEIwcTdS?=
 =?utf-8?B?WlpnaExjRmpick12ZFpZQ2pPYUJQaUpDRlc0dEtBMXFRWWRnZ2VUeHhuZ0FQ?=
 =?utf-8?B?bUJLT21XOUx2ZkRrOVhaYjlZbEZWR2hRdDgrdTNJOXN1aUpHZ29lZWxPUXJ0?=
 =?utf-8?B?bm9zb2F4d1IwTkR4ZEpBU3QwL01Ua2hmdjM4M0R3ZFFtcHpsd3RlWlFoN2dm?=
 =?utf-8?B?R0dMK29FaXRkWXJGNE56d043SnJPTkg3WHNZZXh6SThwK24ydTNoYWNIOE9l?=
 =?utf-8?B?dHpDWllIellmSmNCZWw1RHRlcEdMMGtJMUFwZkpQSjRELzEwMDVidDZIRE9C?=
 =?utf-8?B?bndIMzhQRmN3dmxGZUx5MkNvWkU1QU5TRTB5aDBkR3hMV3gzcnBydm9sUVp2?=
 =?utf-8?B?TGhNd2lidlNjNHRVeW1DV3hmaEFnc1d4YVpqbEd4eTA4bk1Za09ITE1wd0hm?=
 =?utf-8?B?TmlFMmxpM3o1RlRQNDFSRVFBZUV2c3Q0ejNzcTNFQk0vZVhNbXZqQkZJakh5?=
 =?utf-8?Q?UAcSvwTrULM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhuR2EzSy9pODVQako1QTFEYzAwQytLYjFsOUpwMmdBV1R2UDBpNmdyT013?=
 =?utf-8?B?L1hTamc3YWpYVG5pdThuTHRwakU0dkxFU1ZjM0wvVXlrYlYwelI3VUk3SGhY?=
 =?utf-8?B?TWJiQzc2bmx2Rzlzc0gxMjBzSzBLZzRFcTVsSVZBY1A1VWNFR1l3cE00M2dJ?=
 =?utf-8?B?TWdCMVBzakxobVFEclNmRGoxMnM4ckpRUkN5SzNscGRXYWJuTWpRUTZDQzlj?=
 =?utf-8?B?ZmQzNHFaZE1ITEVxZ0ZtMHp2SlFvMnJpM0Q3bzhhK3VmRTFLTDNlbS82U1A3?=
 =?utf-8?B?ZmFWSnFHSEYwb094NlZkV3B3aUVwWWNGbWdUNC9iUTM2TEd2RWR2eGVlVjlD?=
 =?utf-8?B?YXhrUUdBdnh3dVBDVjU3R2dsRmRwUDhIVnVkNHVIb1poQmZVTVBFT1VOQzJl?=
 =?utf-8?B?ZldUR29iWE1CRVlmdE40MUJtMGkrVVhjYXBDR29UeDB5TytNMWVPdVV3Q0xk?=
 =?utf-8?B?RmdQUXg2S3FWWmJSb0JCQ3RSaUlJMWZLNGk4T0gySU9IazhyUFRzTWQ1U1U0?=
 =?utf-8?B?a3NaTStXbytaTCtpUnVMSVU2MjJVbCtOS29lVmx1enorNWYwZ2pnQWZiOGEv?=
 =?utf-8?B?cGMzcUxwZFUzU3ptTWs3VWZiUmkzdERvRXdEWnh4T2xNRzBiZDdRTkcydFBk?=
 =?utf-8?B?VnFWVGtGWnFvSXk1NG53MHgxRThxTEdrZmJ3eGVzazVVQ2VEZEtPVk4zbGYz?=
 =?utf-8?B?L0sxWUttM0I4K2M5a2lFUDFTZjREZFhtVlY1aGxVY0dNa0VIbDBReVo1ampQ?=
 =?utf-8?B?L3pHNVhJUFFncDhMc0RPUDZTelpOT0tiUE9JMVNTTDZCL2FTUkZaSmkyK3ZB?=
 =?utf-8?B?V082d3l6aFRDK1h3WGNyZ1Q0U3NEbGU0L2dpVnprOWIveGU4VjlEMTNyVk1w?=
 =?utf-8?B?RGZrVFFKNkJlSDFoaE9YeHpuMjczQ1ZYOFNnRUwzNTA2N2tDWDVpemIxem8x?=
 =?utf-8?B?Z29LNk9JVVdqVkxsZHVTRlFmOHh4Rmo5VGg5d2o4N2JPMDdFVFd5SE5NMzB4?=
 =?utf-8?B?WFF2YkZFWnRJdGpES2FWL08wV01oV2hsVUZPYVhwNStJUC9HY3FTNHpDQmNu?=
 =?utf-8?B?NVA3N1VIYjlvNFRzVkw1bE1PWUx3aWxNcVo2WG9KbERpVTZObUdFQVZsaVM0?=
 =?utf-8?B?SE9YMzd3czN0bVlWeW5DQXF3VGNYMlc1blFDUForb01xcy9EcU5veWM2VjBF?=
 =?utf-8?B?dGZmWEY5d0pMV0RrUFM5dlpzUVFpV1BnZ042dHZ4T2ZGODd4OEdRTjBlZ1NU?=
 =?utf-8?B?NUYyN3BvenI3WnpzWURHcFExWGZRNTJFTm5yVzRPUUNHcWZmbzFpNUxrK2ZK?=
 =?utf-8?B?dFVaMGg1WVd3UnhFQ0ZKNnhIenhZYnFtRkhzK3J1SXJMUXBvZnB5QWI5Tzli?=
 =?utf-8?B?REYzMVc1ZElDNkE4cDlzajgvY3UrNVpIUERXNEJCWXBIc2pPK2FpdVdJNWJ2?=
 =?utf-8?B?VlhPTnlwUGJTREtaT3o4cm5KVEkzRndJTk9laldqeVh3Nyt6Y3pLaGRpS2lw?=
 =?utf-8?B?dVlXenVXTEJINVh5THJTSkFpRmZ5Z0M0WWo0QjZmU0MrTVBBbHl6ZWxDS1V0?=
 =?utf-8?B?S0FoUlJBUWlGbGNCL29NU1BuaVhxNWpFSUxvSnBGUDZKMTVEVXRZQWRxU2V2?=
 =?utf-8?B?OEp0ZHNhTkVBN3NYVFBLT0VteGZva2oxNllzMFk3ekRyQktwaWU4RkVXZXJB?=
 =?utf-8?B?QzEveWtCc1RUNnc0a3MxZGkxZXRqZTNpQ00xbzBYWjQwMEQ1ajZJWWlFOVho?=
 =?utf-8?B?N0RXaFVjZlFNb0ZScVFyeXRjRGloQ1l5RW1pSFZDdkg5Zkh4YXBJRWdPK1R6?=
 =?utf-8?B?ZTladGNXTHF5NDY3ZldkWmRUZXlHc0NUWXNRdmtmUXBhL0pWS01wRGJSNnZa?=
 =?utf-8?B?amYrazRPT1RlbEZvZHlGSG9ncEg5ZDhZdm1uTWd2OXVEeXZQdnZIOVg2TlF3?=
 =?utf-8?B?L2RncTNwZ0g1WG1waCtoR2E3SjhFVUhNeHJLVmROM2p5UnBiUFMzYWdseTRM?=
 =?utf-8?B?UGhCZGcxOFVHd3FTbzVub3BjN3hld2c1azdLZTUyYW1aeWlxbGZYNUxteisx?=
 =?utf-8?B?WnpsbUZVWGQ2TEVkcHF3N05Ed1NMcEt6WkM4azlQZXd3OENmVG5kUXpyRk1a?=
 =?utf-8?Q?SwJr3pYpVywZijDE5Bpaks7ID?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1dee2d-d472-41bb-9917-08dde17b07c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:54:28.5961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agHfXim3kYAevwhuigILYhu8kwF/jMqOuPZbn/5UYBwKAGtt6UuaRjwBhyp2NIux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
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

On 13.08.25 20:49, David Francis wrote:
> Add new ioctl DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES.
> 
> This ioctl returns a list of bos with their handles, sizes,
> and flags and domains.
> 
> This ioctl is meant to be used during CRIU checkpoint and
> provide information needed to reconstruct the bos
> in CRIU restore.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 79 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
>  include/uapi/drm/amdgpu_drm.h           | 31 ++++++++++
>  4 files changed, 113 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4ff3a2eaaf55..f19795dddf9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index aefae3a9e6f4..d17cc7ba66d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1024,6 +1024,85 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +/**
> + * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_gem_list_handles
> + * @filp: drm file pointer
> + *
> + * num_entries is set as an input to the size of the entries array.
> + * num_entries is sent back as output as the number of bos in the process.
> + * If that number is larger than the size of the array, the ioctl must
> + * be retried.
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct drm_amdgpu_gem_list_handles *args = data;
> +	struct drm_amdgpu_gem_list_handles_entry *bo_entries;
> +	struct drm_gem_object *gobj;
> +	int id, ret = 0;
> +	int bo_index = 0;
> +	int num_bos = 0;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id)
> +		num_bos += 1;
> +	spin_unlock(&filp->table_lock);
> +
> +	if (args->num_entries < num_bos) {
> +		args->num_entries = num_bos;
> +		return 0;
> +	}
> +
> +	if (num_bos == 0) {
> +		args->num_entries = 0;
> +		return 0;
> +	}
> +
> +	bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
> +	if (!bo_entries)
> +		return -ENOMEM;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		struct drm_amdgpu_gem_list_handles_entry *bo_entry;
> +
> +		if (bo_index >= num_bos) {
> +			ret = -EAGAIN;
> +			break;
> +		}
> +
> +		bo_entry = &bo_entries[bo_index];
> +
> +		bo_entry->size = amdgpu_bo_size(bo);
> +		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
> +		bo_entry->preferred_domains = bo->preferred_domains;
> +		bo_entry->gem_handle = id;
> +
> +		if (bo->tbo.base.import_attach)
> +			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
> +
> +		bo_index += 1;
> +	}
> +	spin_unlock(&filp->table_lock);
> +
> +	args->num_entries = bo_index;
> +
> +	if (!ret)
> +		ret = copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries));
> +
> +	kvfree(bo_entries);
> +
> +	return ret;
> +}
> +
> +
>  static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>  				  int width,
>  				  int cpp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b3047d73fe07..338fd6d6423c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  			  struct drm_file *filp);
>  int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *filp);
> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
>  
>  int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index bdedbaccf776..59b423883e91 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -57,6 +57,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ		0x16
>  #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
> +#define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -77,6 +78,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> +#define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  
>  /**
>   * DOC: memory domains
> @@ -811,6 +813,35 @@ struct drm_amdgpu_gem_op {
>  	__u64	value;
>  };
>  
> +#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
> +
> +struct drm_amdgpu_gem_list_handles {
> +	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
> +	__u64   entries;
> +
> +	/* IN: Size of entries buffer. OUT: Number of handles in process (if larger than size of buffer, must retry) */
> +	__u32   num_entries;
> +
> +	__u32 padding;
> +};
> +
> +struct drm_amdgpu_gem_list_handles_entry {
> +	/* gem handle of buffer object */
> +	__u32 gem_handle;


> +
> +	/* Currently just one flag: IS_IMPORT */
> +	__u32 flags;
> +
> +	/* Size of bo */
> +	__u64 size;
> +
> +	/* Preferred domains for GEM_CREATE */
> +	__u64 preferred_domains;
> +
> +	/* GEM_CREATE flags for re-creation of buffer */
> +	__u64 alloc_flags;

I've just realized that we already have all this in the struct drm_amdgpu_gem_create_in and that the alignment is missing!

Please either add the alignment here, or even better use the pre-defined structure.

Regards,
Christian.

> +};
> +
>  #define AMDGPU_VA_OP_MAP			1
>  #define AMDGPU_VA_OP_UNMAP			2
>  #define AMDGPU_VA_OP_CLEAR			3

