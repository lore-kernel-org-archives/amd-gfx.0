Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C23ACAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 15:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCC310E71F;
	Tue,  9 Sep 2025 15:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIdFBkMy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB92510E71F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 15:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feRPIR63AHNh4Zb3t1pVLdMaoLvoN7Opi4UkZvjolUVyLp6jg4tzgS11S8MQiGe4sePyz9hl+04/dS5J7jTSFEgKvzWAlqZwpwouX0YULQC/fru3i06zjCUN83h8JWotvm37ZphiQ7lFkq5p/WqM4fOb+s0Ig4gePyoViCSzIa6CIqRgmlkAtIgoxUm7wnGBv2OzMZm7r1TAw4Bmajb2jVMy2sdlrGe2jzSmbTc2C63XJlwyxiyi5bse36jJYjNW5REPbUi03jmt/+2YLlZxLIlLv6fnbqGOhVSNfBOVPSTfp43sr39MHar5Ed9ANyfytzuflPMhZrQ+waSnBigxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44bQ2/coOmq+Jv+0v/h0iursnlF+Wg+5x0skOZdx4TA=;
 b=OXB23sJBJ3yH5MXFOAROgZzb5wJ3ehDRrfSYrIcM3/u5FGw3dpv81j7blYBUreBkrI4seYkvsoFG9IE48R19PdZzBIhjmqd+tiefXbOqbwFljfNXE8ciahIUWRd4LW6GOEWiYaE22WL2Jy0v2U+uA6buoLg5oiDE+XO86blh08MUEsn7Mnzq5oBYaq+oHfVr61OlpUgfw3cweQBQzRZZDZH2SFpMHm1kuigWN8gJzH8wSwM4SsvKyROjccJo2KJz8c116DWvWe/A6QXHKy2hn2PXm3BAKpc4Ga2Ts2BI+A+PSdyzg7VgnqZRC5BatM0QKLS9IVh3989zccillbW2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44bQ2/coOmq+Jv+0v/h0iursnlF+Wg+5x0skOZdx4TA=;
 b=uIdFBkMyhhQryg2QBB8AdAawYB/84vn6qNvgUJrnJGSxfb5KHc2R2xnmVz3NMi+eCydTLa4xwOxSCm+LSNiL/LKF/Cv7JxQhtsdaMATFg2kJiL6iHLtUdB/804YfY8qGmbE/nHMFarQ8By+wxgJDCGJpDSmifgXA8oGfnNWVkew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:14:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:14:41 +0000
Message-ID: <a11de61b-01cf-4a32-ab54-d2d6f095a439@amd.com>
Date: Tue, 9 Sep 2025 17:14:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Fix allocating extra dwords for rings (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250909144937.22452-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250909144937.22452-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 37622ab7-636a-4214-e666-08ddefb39995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dk9ZaFRYZUxtR3hMS0hTaUdnbjFzekJmMHZSY1d1YUo1WGp5V1RpRHM1cnl6?=
 =?utf-8?B?MkNaaEFyMWl5TzM0WW9KSDI4M3VDTUwzQjFCRVNlaFRlQUI1aG1vR0hTc0Rp?=
 =?utf-8?B?T0ZrcGFMUndiQ3JrTWd6ZnhhSkVLQStyZWdQWTNLWFEweUkyVXhPUk1aYWVL?=
 =?utf-8?B?by8wd3BrcG4wSEQ4dmVNam00TmdRcTVNTzhRMUQ1YVp3S0ZnSlVnKzJZNjBR?=
 =?utf-8?B?UnlPcDdoa09RUUw5YVhhaDNMZHh6eTNDaUFBUVJ5Yi9HU1kvWE5pSXBWNnRH?=
 =?utf-8?B?K1dubWo2bjh6dXNDN0x3UVd1Sk1JUkdrWXBDbGJEeUhRa3FjY3Y0NUdxM1ZH?=
 =?utf-8?B?cVc4YVlCb2cyL1YwcnhmUWpud3dlUUdWWGo4R2FOMllubE5YaERsS255RjJD?=
 =?utf-8?B?dk5wMXZYR1grdmJGd25yb0Q5V2Z1S3NVRDlJMDJJWFJNcDd2NVJKQzNEcEJq?=
 =?utf-8?B?bGJvZWF4d2FCUmw3bmliNUxycnZEK1BXUGg0eEoxaXpRMXNPVGhPMFk4K2xD?=
 =?utf-8?B?N0Z3VDNKbnd0VEhYN1J1NGdsZEN5RTlncXpiYzRHb1dWRnhlbkx5Y3dtOUk2?=
 =?utf-8?B?cllMWUFQRURncWcvTHlBUCtpZ3YvYm9TaFlvWmoxbXpwU2N3TXlhVlh2Y1p0?=
 =?utf-8?B?TVlGcUJZY2kzbWh6cCtMRjdoOGI2OEdWUzNRMGQ0RGVrc3B2RHZ5ZVh4VUJO?=
 =?utf-8?B?WFBMUG9BeVVCTmZ6ekNlelUxd1YzTW1qK2xTT3NOcnNtVE81eFFtNmVtaW04?=
 =?utf-8?B?UVRjUlpwK205U0ZMRU5oUGpId2pVa25DUzNFdjQrbnRFYThjeVYvWCtIRVdL?=
 =?utf-8?B?TE9MSEtKTW1ONUhmU1RteG9HcTVXbUF6MTB1K1dVZDR3dElkT1lDbmdtZGQ3?=
 =?utf-8?B?L3ByL2dPV0dqMjEwNnZja0dCd0NZUjRJZnRGelZZdFJhd2FteTE0R3JGYzFx?=
 =?utf-8?B?ZkFiYW52MjVHYlVwdzFBaDV2d1VNMmYzVWM1QnFCb3RoOHVoZWRzK29yMk02?=
 =?utf-8?B?TWZodHhTNkgzVHJrS3dnZG9mMm5pTXBaOGQ5S2xsaHpRZFVVdXBYM2NWNjhT?=
 =?utf-8?B?V3ZiaDJhUitVWElBbmpsVktnU1RHeW5uSVltZkVQeGF1cndmQ3dmZXh4Smxl?=
 =?utf-8?B?Y2twUyttclhXN01zR3VWUUY2Tm92M0hsT090QUpmOXY3ZUxpSnFrVHhhT1V1?=
 =?utf-8?B?eXBYcXh4bkJWTUVDd2ZjNmtuZnVQL1BCV0NMK00zR1FLWkR0VXV5dHVuZGVM?=
 =?utf-8?B?VjlBbWxjaU1tN0JuVld0RFdtY0tGRXhBM05XYXllWHN4TzJqeW9KRHNZR1ZB?=
 =?utf-8?B?Zjd1ZFFiOWhmdVJQUFEzck9ZcXgwOVJoY2RKN1dNYnNJNnB2cktPVjlWQVpG?=
 =?utf-8?B?bTRNSGgxcmNiSEFSQllrb3dNVHV4NWtUb2R2SkNyeG83R2tMdkpPZ3ZTUzRZ?=
 =?utf-8?B?NlVvc3RVaytvM01PcEJ3VGQvbGhWNG1wMWxKb3VqUCtOb01ucFN3a294Rzdo?=
 =?utf-8?B?Tk1HSU9XWU5BcTRzaG42YXh5TG9Xb2NYUy9xMXMxUHlQYXB4Y0dTblE3RjdV?=
 =?utf-8?B?Y0lUMkY4VEN2TG0wM0FCUXA1NFQvd2JieWkyakVTdDh4UXU0aWdVeXluNXhv?=
 =?utf-8?B?RTN3M1BQQkpVVU5xTTZEOFNYelI0eHVCYjN0TWVvQkwxZFphbEdMcnJQczNT?=
 =?utf-8?B?aSt4MVRDU2kyZm1GcGNSVGZoczh1SlV0dVl4WXNIR0kvYUZCYWF1aW9mUmlY?=
 =?utf-8?B?OW5vZHRHbEhJUERnTndpaURicmdISzgzRHVnR2x2d0NCTDRIMnJuR1VDY2Ry?=
 =?utf-8?B?MldJaVp6eTdaL3V2cVgvV2FUUExzbzJpZHpJVVJxMGtjaVc2QnE1eWdKZWd2?=
 =?utf-8?B?SHBXNjMrS0pMZllmaTdDdERGUS9GY3k4K3ZHQ3FqN2JVdisxajRRMXE5RFpX?=
 =?utf-8?Q?57DOl1F6g6E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEFMUVlJa1pKNktaVU1IVElyL1h2MFdxYXJGUmtMU0JvWll1SGwxMHFrWll0?=
 =?utf-8?B?bklhVEFzN3QyY0xTR0pnY0VDd09wVndrNUk1L2NVUXljV0hOY1g2THcwTm1Y?=
 =?utf-8?B?cXhNeEc0Z1FXUVArSmtnVFNxMUtUNGQxQjVRZUFLVDk0MG1tWmRmZDJkcG52?=
 =?utf-8?B?VmdyRUdJOW8rZnVWakl3TU9zMElxTVc0RDI2VkFHNmZmVHhtbFYrTmEzeVZN?=
 =?utf-8?B?M2xLRnNiaFY3NlJDUjlzcnZWUEFLTVM4SjNpYnVvTllWZUxsdGVHQzVZbGk1?=
 =?utf-8?B?eE1qcmV4R2ZydDIvalZTMnByN3A2djRrYjZLRXdRZzVGNGNEaEx3OVJyWTNQ?=
 =?utf-8?B?bFFESkYvU0Q1eFkxejdOTGNqV3U0RzZzUE1wbCsrWVZTcFM1V0JDaXQxTW4x?=
 =?utf-8?B?OW1LWXVMRjRkRVY4SHJnVmsrblA0a0hBc2dDd0s0TkZpaVVoZnNUbHVSRnFI?=
 =?utf-8?B?VGRtazNkN205b1BxbDB5Q3ZxLzZwSm1tQlp1blJpRy9Dd3o2eGlIVGZaRjhr?=
 =?utf-8?B?eGtQb2R2bExlS0pRSWNMd2QxbXFKWEMzaFdrdVJlZmUwT09RTWVvVUVDaHUr?=
 =?utf-8?B?eTR0ekR6a0dZQVlLL2FRTlVDVE94WnpzOFQvYXpTZkJERkVpM25KS05PcUxp?=
 =?utf-8?B?Tko0UVF5ZDVLMUIxRWVVK21NZk9vaXNld2w4Q0xLeVVYdEgzMXBKSzF6cmF3?=
 =?utf-8?B?VXNNVzlTR3NTR0gzVXVXR2xVdmRGdnZWT2lnMTA2MGUydVZUN2lBZXNnUExW?=
 =?utf-8?B?TlgvQSs2bVRrK01XZjkxUnRUb1dEOHhUNDAxMWtkREdsWmpiZVhTaFoyVmtE?=
 =?utf-8?B?TkY4aWw2dHNpNkw1Y2VuQTJWZTkyWkxwK3BFdkE1em5IZ0JEZTAzK1NpS0xO?=
 =?utf-8?B?RVBqeUY3Z1BZNzcrMnUrdVhoRFdMMnc3RDVHNmw0NUdJeDJwNk9HOTJrS2ZP?=
 =?utf-8?B?N0EwTkd6SlVFYjhCOFdTSk5SRGRvZm1LU2tzZEljTUtGSldnMXlGR3pvZ0U2?=
 =?utf-8?B?aGdmOXl2aUpwOEMrK3J6alV0RmtMMHlCR2VVTVNjWXFrRHJ6OEV2eVdKRWZs?=
 =?utf-8?B?cER6WVg2aEZ6UFQ3S0ttTXhVL01Yczh6OGhoeHJqOGV6eUxDR2FPN2N6NGt4?=
 =?utf-8?B?bTc2Q0NVN1Z6ZWIvWnhFaVA5Y1gwcXBrd0JXdnUzbkROaHg2VmhWeFZETVdE?=
 =?utf-8?B?N1JjellwZ2VRUEJoVkpTbVZsMU5zMTR0bXBLdVlJbmt3TlJ4Yk5Ha1ZjRXJT?=
 =?utf-8?B?V0VCd3paUEtCNVZ1Mk5XbDRma0VsR1FQNXlldUF2aURoRk4xR1FDODJRRklw?=
 =?utf-8?B?clEySUhiNWlLS1RMNXBnNG9MOExrU3BOeDNyOGRMdDNIdit2cVFhMnVzeHBz?=
 =?utf-8?B?a1NZN0xGdDAvV01Nazh5aEVQNXdFbmUrMlJmWjdGbkxKK0VJNUEyMzkzdkl1?=
 =?utf-8?B?SXh1Zlh6TnBtWHpNRWEzR3lyanpVelAzclJQQnVDa2IxMm9GSzZqYVBiMFlK?=
 =?utf-8?B?YXhaUVdYSXp0dDNWOGNmQTk3c3djcVJYRWFlT2RMUWNSYXhZZDZrMWw5QXQ2?=
 =?utf-8?B?MWxneDBZbXM1MjdEbXhJTHBDMzhBYUZOSWZWWGl1ejk4Vml6bGNhaGNyRllv?=
 =?utf-8?B?NXc0RUJTZXB6Kzg0RFJpYXE2VFZNMFJBWm0vbzhrN3dPQXhsME1GbDM5MTBj?=
 =?utf-8?B?Wko1OWxSS0NGb2EwWlpnTzMzT2Z0aUNqclhnT0VqbVE4RjBzTFBBRzdOT3U4?=
 =?utf-8?B?QzI4dnVmY3lxRTYxdWxnMkpjVW9CejdSS01qSFhNd0tIM09TckNPYmVIVmFI?=
 =?utf-8?B?VTNQN3Q3NjZLUlIvalAzTmFZNTJHQWl4cUdCSEVQRkh4Rmt5OUFwSlBsVFdt?=
 =?utf-8?B?TkNkNWlLQktDRW1pVGlPUmVuWjVTWWJxOEJDVCtXYm5JWlAwbTJhSERtYkhZ?=
 =?utf-8?B?ZlpKNUxLQndnZ3RmeFJncU1DWFcwcEpwQVE4YXRId1ZXTFc5VE1ySitHUU1q?=
 =?utf-8?B?ejRSNDN4TUhPZWJjbVZDVVA3ZlhBUG9ScGtTaHpUazhabExLL3dVYkdjdWlW?=
 =?utf-8?B?ZUp0OGhtQ0xXbWJUVWFwWHlwczBySlhENzlwY2t2TWl6cVdOVHFPR3c1U0FU?=
 =?utf-8?Q?e1+YkWcRMZs0bPPAbaP8RgU2d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37622ab7-636a-4214-e666-08ddefb39995
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:14:41.3176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQwNJRizSH1nBNF6APEdqJo1TBg9FtVS3J21POKefsE2DfkOBfClHZHkRobENwi3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
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

On 09.09.25 16:49, Timur Kristóf wrote:
> Rename extra_dw to extra_bytes and document what it's for.
> 
> The value is already used as if it were bytes in vcn_v4_0.c
> and in amdgpu_ring_init. Just adjust the dword count in
> jpeg_v1_0.c so that it becomes a byte count.
> 
> v2:
> Rename extra_dw to extra_bytes as discussed during review.
> 
> Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for jpeg ring")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 11 ++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 13 ++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
>  4 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 6379bb25bf5c..eca8b28e3fb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -364,11 +364,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  
>  	/* Allocate ring buffer */
>  	if (ring->ring_obj == NULL) {
> -		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
> -					    AMDGPU_GEM_DOMAIN_GTT,
> -					    &ring->ring_obj,
> -					    &ring->gpu_addr,
> -					    (void **)&ring->ring);
> +		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_bytes,
> +						PAGE_SIZE,
> +						AMDGPU_GEM_DOMAIN_GTT,
> +						&ring->ring_obj,
> +						&ring->gpu_addr,
> +						(void **)&ring->ring);
>  		if (r) {
>  			dev_err(adev->dev, "(%d) ring create failed\n", r);
>  			kvfree(ring->ring_backup);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e..12783ea3ba0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -211,7 +211,18 @@ struct amdgpu_ring_funcs {
>  	bool			support_64bit_ptrs;
>  	bool			no_user_fence;
>  	bool			secure_submission_supported;
> -	unsigned		extra_dw;
> +
> +	/**
> +	 * @extra_bytes:
> +	 *
> +	 * Optional extra space in bytes that is added to the ring size
> +	 * when allocating the BO that holds the contents of the ring.
> +	 * This space isn't used for command submission to the ring,
> +	 * but is just there to satisfy some hardware requirements or
> +	 * implement workarounds. It's up to the implementation of each
> +	 * specific ring to initialize this space.
> +	 */
> +	unsigned		extra_bytes;
>  
>  	/* ring read/write ptr handling */
>  	u64 (*get_rptr)(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 9e428e669ada..b5bb7f4d607c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -557,7 +557,7 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
>  	.nop = PACKET0(0x81ff, 0),
>  	.support_64bit_ptrs = false,
>  	.no_user_fence = true,
> -	.extra_dw = 64,
> +	.extra_bytes = 256,
>  	.get_rptr = jpeg_v1_0_decode_ring_get_rptr,
>  	.get_wptr = jpeg_v1_0_decode_ring_get_wptr,
>  	.set_wptr = jpeg_v1_0_decode_ring_set_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index d0d27790b73b..099698cb1a3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1986,7 +1986,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
>  	.type = AMDGPU_RING_TYPE_VCN_ENC,
>  	.align_mask = 0x3f,
>  	.nop = VCN_ENC_CMD_NO_OP,
> -	.extra_dw = sizeof(struct amdgpu_vcn_rb_metadata),
> +	.extra_bytes = sizeof(struct amdgpu_vcn_rb_metadata),
>  	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
>  	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
>  	.set_wptr = vcn_v4_0_unified_ring_set_wptr,

