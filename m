Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71979CF07BD
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 08:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152B410E886;
	Thu, 10 Oct 2024 08:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5MnZEt1s";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9046B10E886
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 08:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlXLMs+98EkgOKr/ZgxkLNwzt9Xje/nJ9zSGy6tkotCLjChQxc9RbHdXetRosKfIuI+Szp4dw7aAtPXxyaQESQBjcNJM0Z2fo0L4TnYKxasMLbH3y673ESoWx7OtMxOecstWGEXvQONL5Dj1vcdNgguNB74HlhLKQm1ud/nPZtlUzwKcY2LPR3ukbBaQj2QYvTZrIPgMXpnFObkpcsYfUpVSU2RHA3DuGo4yltYCmvDPscXHMI5PUnmTYxOMpmGaEICLm2MLfOX7oxj2wRDjBzWqoWv8Zzd5x00nLwcn/oQWKXF6Wi0hh/FdITBwHyDc4RLW3LyEbKDPQZYIepoGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSvfF2C2Xyc648E2n7BdeeUj8JWLvek3OiaIRDdcOQM=;
 b=rjlpF+4/3FGYD9I4TeOsTb5r5NOrCZlo6w5EVO65f6cQ6+dwUGo7CAMo97Swh/+P0BfINQClHt1RIBsdGnfbk/539TWSHSPFtJ0jtytiFkfQRmA3kpYClMwd2ovy0Ul4Zd0CHyueZ9O232AC/xtc4G2VocnLAA+lVrHZPAY+mubIjTtDKHB845mvPpqAMD96nW8/bVWVLDPTVFndeEAljxgWj4u8E4HhUZGvbWZd5rCN4YXdwBXimBHc6ulHGuQD5QJ1FVuibVtmk29GpyXtFUM7JmABJ9/9o2gqq66fKdJEF2+0JhbhxHIGkRfpf4OzsylCew29Z9AUQSLHj8lxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSvfF2C2Xyc648E2n7BdeeUj8JWLvek3OiaIRDdcOQM=;
 b=5MnZEt1sznlLrDTHC5Ae0frhN1+p4Kvq/F35kTjmdWy3DJH+b+U5gbcW8L0Uvf5RydnR8iqsN4A5bwbrxg65WriF3jdgvuIYlqtcLjM3LH/H0j2Xiy/wCI3wZDCBSdUBMhgIcPDdMiPUFdLnU5pDEp8mG1hy5MgMVrEQ9tsFXC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 08:07:35 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 08:07:34 +0000
Subject: Re: [PATCH v1 06/13] drm/amdgpu: validate suspend before function call
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009142502.891864-1-sunil.khatri@amd.com>
 <20241009142502.891864-7-sunil.khatri@amd.com>
 <d7fa2890-7e0f-48c1-afe3-2d934ee3448e@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <4706cd33-4856-448c-3a6c-86450cc6fcd4@amd.com>
Date: Thu, 10 Oct 2024 13:37:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <d7fa2890-7e0f-48c1-afe3-2d934ee3448e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc70a3e-c764-4c5c-a63a-08dce90298ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG92Qzh0THdYeG4vNnBEajZMR0xTZVEyNHU5M2c4WlpEL01KVURiNnp3OGQ3?=
 =?utf-8?B?UkZLNGxVVjFHN0dCN0pFVE5idlRnaFVqeWwwS3p3TVdxR3ZuVjU4RUlSSzEv?=
 =?utf-8?B?ZkUzNGpDbGtDYWNyelFnY25NVThVVzVjb2VrRGRMUnhEVGIvdkpHNUxEcFk0?=
 =?utf-8?B?MnBnOFozNG5EOU1MbForUHV1ckNzRWV0WW1zTVZGTS9lYzJuVWRwNE9hQWxE?=
 =?utf-8?B?MDdqN08yZXBRdmRIb0xlcnVMV3dLRERaSG5zOHFhamtjeXRZZno1elJXZDN1?=
 =?utf-8?B?bm5GOHlWdDFVNHJtMDlsY3NXWVhIa3dtNUp0TWM4VmdBaUtMS29FbGNERXgw?=
 =?utf-8?B?dEgvMkkwRHhFSWxyQi96OTBSWCt0RURrNUt1SXFkTldnVkgvVDBGalFmWFht?=
 =?utf-8?B?WG1zYzlGeXBIa3JCUDM0bG9EYU9ncWx4MkRNNkhSSGxYNjNxNmlQOGhtZExu?=
 =?utf-8?B?ZFBUK0JDOVZJMTZkUWd0K1Z1MFk3MVJuZHRXQ2hKNHZnVkREcGlUQnFYTlFC?=
 =?utf-8?B?Q2RHalE4c0Zha2ExZVV0VWFiYnZzU2xVT3p4WFZwQktFZ0JESHRVSlZySG1x?=
 =?utf-8?B?NFMrYlFRRzhNaUZJWGhndUdTSDljbWlqektsU3FiQUM5VVJKS0tHcW1HQStN?=
 =?utf-8?B?UDZGcVBVeFRjQlRBL0pHR1hKRll5TllhZlFlZnExNTRMSkZ5UFlrOVM5SW1H?=
 =?utf-8?B?ZVplbUtRS0dLbkUvWGtmK0VsZTNDaEZkdjN1VndDdVNUb1drYjZzdjlaOWtz?=
 =?utf-8?B?ZTlmNEpycE5RRFRMa1JiaGtVVFYzKzRtTW42UUVhSWYxS1RzMmRCRlV2MW5Y?=
 =?utf-8?B?UXdBNHllbTdtL1NFVmNMWlh0b0xLbG1QdVZ2MGlPNTZWK01UOEtrbXF4UnlF?=
 =?utf-8?B?ZjZOMTVBaFJkMXE1TldqYkpMWWpEWm9wVEp1aVd4bTNpTTdkNWs3azRVQm1x?=
 =?utf-8?B?MC9ta3liYVZjWDlzdHh3TE1hSnYvdlhkb1lJbFgvK0oySmUydi90UDBFRnh5?=
 =?utf-8?B?OS81NXI4cTlXV2w5SG1HWGp0am43UUg3NTFKLys5bGx5QVI2aVh1VkdEK044?=
 =?utf-8?B?aGkxNU1XS3hiQ0t0QTNZdWZDRXFVN3VuNDh0WU1rVi9sRzByQUVBa0tiVEF6?=
 =?utf-8?B?WklCbUFlSkNNbGNQOVh1M1B6UWtVdm1VY2J3S1ZqUEdBTEJjdnlubktlRzl4?=
 =?utf-8?B?MUhSQ0NGNXlXekNjSitGY25HR0xFaURRN1lFOENQNzRZNS9yNGpmT001Ynkr?=
 =?utf-8?B?a0xYL1F3WUd6TWJFMVBmOVJ2R3JoV0ovUFJ5cjFnTHdNNzlISjduQ1NOQ1B6?=
 =?utf-8?B?U1h1ZHhUVktvU2dPNXpkT05rRFZEUjlzRTAyaFBEY1ZQWGpyNTF6TWFicnIz?=
 =?utf-8?B?NjJtN1B3R3EzNGYydU9nS29LNHFLaHczNFp3NVFZMFN6dzBsYVBJNHIxZGNl?=
 =?utf-8?B?M2tFSHc2dis5eTVqN042bGRIUEdpNVBMQ2Z1R3d3NzVMbVlPdmJaVlhPNC8z?=
 =?utf-8?B?NHdod1owSjh5TEQ5a1dFbTZqVmphYlhISHFVL1paNk5xSEtPTnNRQ01MK3E2?=
 =?utf-8?B?ZU9wdXVnbVkwLzZHRVpOdkNFWE9GYUsydEFRVWpqSjUwdTJEM1ppVnBBNXl1?=
 =?utf-8?B?R28xaC9YSjlQMzl4U01HbWNHU0QvWXl4ZXYvU01kS0xreHhrcWJiZTg5SWlr?=
 =?utf-8?B?eS9aTjQ1bHArSnBlekdJcmNkbnhpR3ZrTEtaZWVWOStaZHdrRUMwTER3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVErZmZ5d2k2bGwzOFhBWHRvSld3MkpzSElITGlMa3lKZ1VDTGJKdlpINU1R?=
 =?utf-8?B?V3RVM2dONm9NVDd5ejQxaFVsb09MVlhqOTZSNVhQVFVFa004UUhnUlFNbm9r?=
 =?utf-8?B?WlNqNFdmblU0OTZSVkxjTEtFOUNXWTk5WnBTbDE4SHMxNDRXcXo4c00wZG82?=
 =?utf-8?B?ZWZBUEhEekZuclBnVUIxNzMybWN3MElxUE1xaVhTeDdzTGpYdzNsL0lTeUxm?=
 =?utf-8?B?YzNsN29FbktXNHlQbDNaWkdxZVNyY25HM0V5cXVZVGlkL3V2NHluN29XN2pk?=
 =?utf-8?B?eFZMT2l6ZjN3a2dxU3cxeS80ZHpoRVZWN2poQVFOaVpnRDZYN0luT09IU1hF?=
 =?utf-8?B?WWdYenBIU3hHenp4WWlmK0tucCtlZXVUMnR6Rm1zOUt5dzlydytxWElVRkpy?=
 =?utf-8?B?V3hSNmhCamNYTVlMdE55eWUvdk44cmozQ3hZdWk2TjViQjVkOXVod28zdTNE?=
 =?utf-8?B?UHRqTVJSMFRnQ3B4a0xFcEZjMHNnRVRpSFpHRTdRNElRRmpvdzJER3Z2dlRZ?=
 =?utf-8?B?V2V1L3hQa1ZUT3hoOGpWc2R2NFEwdFJReWxjbXBwZlZmRVlhZTBkK0YyUTkr?=
 =?utf-8?B?MmNTRys4RVBRYjFnYzgxVm13VGhOVUtCTXowL0dCUEh4ZVFoUHdWQzk1dGxs?=
 =?utf-8?B?c1RXSEZSNFAxdnNWOFN5WmdwL0ZhR0RLdXM2bUh3NzlXOVk1REZzMDd4R3hX?=
 =?utf-8?B?TFdRZDRYQ2pra2JvakJFc2RkTVgyc0djQUNObzg0S2JEcHZlQ1JVSFd4eE4w?=
 =?utf-8?B?TXdPcE9Rc3hjUFJ4ajdGTk9rOUpwY3U3d3hMNEttYnh0cGVZcHJ2Y0t2aUk2?=
 =?utf-8?B?OHE5eldSbmVzV3kxcDFGaHhidUhSVEZBQTZkUTdzeU1WQWphYmwvT3Mrdk1H?=
 =?utf-8?B?cm1yazRST21SQ3pQTklhMno1dUxVaHhNa3VzaGFLZ2xSRGtRelk1UzkvTUNu?=
 =?utf-8?B?TEZhV1RsMFltb2ViSUhvM1dOREcxSkYwOVpibjI3QVNGbjkzNWI5VGEwa1Nk?=
 =?utf-8?B?RmpSVDVpM1NCdnZRMlpuVDVWY1FQUDZYb0FXMFZkZmFueXVKMlprbVVtbi9n?=
 =?utf-8?B?L2Vpdk5xRXRHcGxlVjhPbUFpQzZrSzR3ZkZMS1E3VWkvazdIOHhtZ2ZxVG4x?=
 =?utf-8?B?dUt3c0RsdEI3OXdHWFBTaFBxYjdMc1BwZDkwRG83MVhZV0Z0eitSdXFtZEVu?=
 =?utf-8?B?VmpwV0lFcDk2c2JjdVpOaE5ZRTRUbzMveWcrZTV3dUxabC9KYzZNN0w1Rk8z?=
 =?utf-8?B?M3NZSDBudi9SOEV4QmYrTEpnZm5LREpNOVZmclgyTkFERDF1dkNhdXJnOXRq?=
 =?utf-8?B?ei9EQWRaQlRRY0ZTcHJQcFVnbDNHWWJLdGZMZnpKZmlUTXZhazZnelJRNVpI?=
 =?utf-8?B?SEZtcHJiYVVmUVEzbXkyV2RIRTYzY1p3WmRvTHJnNkQyMS9Wbi9pS1p0WS84?=
 =?utf-8?B?K0Y0Y0FPTW5RMmVaYUhvbmdoQkdZRCtjWUVncFhZakw3TFRIYzRhUWRjd1NU?=
 =?utf-8?B?a0Jnb2c3NXhKZFE4dS9URko5aGt6bjhaTDF6WDMxNHBxMzdpKzZxdUhXMGt0?=
 =?utf-8?B?cVozdmxXUEgreU9GT1FUNFBmMEx2NVM3cmx2Q2hROG00Q0hTZTdDMlRFY01G?=
 =?utf-8?B?OVRRK0kwTmFoKzlscThNUExkZEpyRjMrWmVnQURVejQxZWIybFM2L05hTkZT?=
 =?utf-8?B?ZHBKcWc0LzF0QnNJYi9xaXB0SWx6SVg0T0NxVmJJSHU2Q2ptVE1LQXVLYmVT?=
 =?utf-8?B?U1J4QUg4UlZqRFNvenZvUC9hK1h2MENXQnlDeHhhUWdja1NmVVpVdEZaSzd3?=
 =?utf-8?B?ZGdLNWNwalVuSFJMWEFGQk5UYUVzeUMwTW4zZ0tFODFkUmVZVU1Ka3JBbXl6?=
 =?utf-8?B?MW54NUtpRUcyNDR2L2U1WmNsR1RadVl0bGpaTStKTytoRjBDcW1HY0FtaWtY?=
 =?utf-8?B?Tnhpd0JCbnVSTFBTdWNtRFova0lKWmFiVVNSS2VPWEhmaXFlY1hSd012U3Q5?=
 =?utf-8?B?SWdHVWN5YVE5a0ZpbjhBTG9KTHU5ZFFRYVEwNXFaVDU0RDRqcENHaVZDbkNj?=
 =?utf-8?B?SksvVEVJbURCb0R1aitvMW8vK1dhYkdKUFU5cVY2aldpVWt1bzVNZ2NrSWpI?=
 =?utf-8?Q?UDWi9GRq1grYJ2oxi6l326XjY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc70a3e-c764-4c5c-a63a-08dce90298ab
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 08:07:34.1310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJJCYuxffBGW9Ik22OuiyZ74NyQ2bgATmy2ALQq784DBsQ2IvHx9Qif6QUCW455P0pZGMyt2oXKERfGl32+alQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
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


On 10/10/2024 1:13 PM, Christian König wrote:
> Am 09.10.24 um 16:24 schrieb Sunil Khatri:
>> Before making a function call to suspend, validate
>> the function pointer like we do in sw_init.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 15 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 26 ++++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 12 ++++++----
>>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 15 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 15 ++++++------
>>   5 files changed, 46 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c 
>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> index c1ff24335a0c..e55d680d95ce 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> @@ -85,13 +85,14 @@ static int aldebaran_mode2_suspend_ip(struct 
>> amdgpu_device *adev)
>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>               continue;
>>   -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "suspend of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "suspend of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>
> I think we should probably create a function for that code and error 
> message repeated a number of times. Same for the resume function.

Common static inline functions only for suspend and resume sounds good ??

Regards

Sunil khatri

>
> Apart from that the whole set looks good to me.
>
> Regards,
> Christian.
>
>>           }
>>             adev->ip_blocks[i].status.hw = false;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 340141a74c12..51607ac8adb9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3471,12 +3471,14 @@ static int 
>> amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>               continue;
>>             /* XXX handle errors */
>> -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -        /* XXX handle errors */
>> -        if (r) {
>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            /* XXX handle errors */
>> +            if (r) {
>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>             adev->ip_blocks[i].status.hw = false;
>> @@ -3553,11 +3555,13 @@ static int 
>> amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>               continue;
>>             /* XXX handle errors */
>> -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -        /* XXX handle errors */
>> -        if (r) {
>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            /* XXX handle errors */
>> +            if (r) {
>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>           /* handle putting the SMC in the appropriate state */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> index 3e2724590dbf..6bc75aa1c3b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> @@ -40,11 +40,13 @@ static int 
>> amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>>               continue;
>>             /* XXX handle errors */
>> -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -        /* XXX handle errors */
>> -        if (r) {
>> -            dev_err(adev->dev, "suspend of IP block <%s> failed %d",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            /* XXX handle errors */
>> +            if (r) {
>> +                dev_err(adev->dev, "suspend of IP block <%s> failed 
>> %d",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c 
>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> index 475b7df3a908..10dece12509f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> @@ -81,13 +81,14 @@ static int sienna_cichlid_mode2_suspend_ip(struct 
>> amdgpu_device *adev)
>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>               continue;
>>   -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "suspend of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "suspend of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c 
>> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> index 5ea9090b5040..ab049f0b4d39 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> @@ -80,13 +80,14 @@ static int smu_v13_0_10_mode2_suspend_ip(struct 
>> amdgpu_device *adev)
>>                     AMD_IP_BLOCK_TYPE_MES))
>>               continue;
>>   -        r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> -
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "suspend of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "suspend of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = false;
>>       }
>
