Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897C1C5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 08:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9E710E27B;
	Tue,  3 Jun 2025 08:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nauKvM31";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1D610E27B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 08:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sX2E3M3F8g53ZoIa2anFAtlrc09aeJ6da/UTcsvxwyg1KVlUFvQOrX5H4/lwn4eovgiK6bEsl8aKja1uvD4etOKfBQ/60+4Vewkj5aEm2duNCVXgBBebqZ85mC4LDFfHaeWJiiEscyKBpOeHyPYxf7PAyDtfHuwk+IeJTElSobfPhj0C50JTyDJf2akwy3/FIkmfILNy3GemFU5GqPJLJ+SMHAe7XlsC1EHK2ATWzuz5pMhwHmFnt+/wRzaHHRamFZUnu0Owu0UfvCBt76B/40si8XedfED7R8iDMRya14TdbjAY6OD0jsC1P93HElkWx8gHpbjbanS/jWIgMdhzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FYWHMgIzNwehwCwRmmWl97ANZoTrQe3InOWeCZ8giw=;
 b=drRhz+l1IDTYPiUJN3jfYHuufDxAPZl9o/gb17ncXT6W2Y0LLMHqnrZUlpIhH12VxCYH93xaYAxVOv7mxZj4A8wfKIJKKOi1s5nNHdx2kUmlICttHgekTOeLma2S+ab8Ftu23O8eolzE3PnZmmAhP1uE23zCZCKzTF3GgV1ccpCxkaZU/LJ5ASRXEZumifNBvuJRkG4oEw7QwpYR1bB1MZ8hnEXPXsaXnGTGYskwE+Ey5Kv59iw3gPEMxqoNkAOu3A/PLPKe5KkN3XHKt0/L3MStwQfTun9XwSWRPA8JmYMAbPDSCwxQ+z1uajbB6YU5Ko5c900uMmGvWn7R/BSY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FYWHMgIzNwehwCwRmmWl97ANZoTrQe3InOWeCZ8giw=;
 b=nauKvM31Wv22JkogkBJ7RwqMp89QdhurorH/r8UOaO/B4CdQkp3KLnQKkf6FTFxYQPjNAoSCKTIofp/uDjhunyqWqD+T3r6oA6OTkqGfujJJ2C73DHy6gBFbuPY/PGG2ni3Qtc7uWLkTR0xW5Cb+4EtqN4cHtRgMZuDpx9nsiw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 3 Jun
 2025 08:54:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 3 Jun 2025
 08:54:36 +0000
Message-ID: <da6e7d6f-75e4-444c-b649-32f01ddf5a03@amd.com>
Date: Tue, 3 Jun 2025 10:54:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Lijo.Lazar@amd.com, Emily.Deng@amd.com
References: <20250603021909.841690-1-guoqing.zhang@amd.com>
 <20250603021909.841690-4-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250603021909.841690-4-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e2a749-84dd-4589-d96d-08dda27c43fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk5pdUhHY21XcUZwUUFjTjB1WW9oMEhVTzFGMGpWdWI0bG93NTFuUmxNYW1t?=
 =?utf-8?B?cURsWGhKa3o4QWxMaFU0dW16V2g1VlBrSE0vOWt5ZEJHQUtyR0J0NmFyU2R0?=
 =?utf-8?B?akppN3hETHFVank4eUlIWkp0UDlhZCtzb0Q3Rk4zNlRuTjlnUWh2WkpYN0Iw?=
 =?utf-8?B?anU5cDNsRkxnK0R1WUtsYmR3QXdZemVISjlRaDBrOUlnY1Z4ZXo5elRZdDlN?=
 =?utf-8?B?R1RZVmtmd0ZYc2dsSkx1VjZnb3ZkeXhzZEhiSzhLamdScndvK2dENFlJRmZN?=
 =?utf-8?B?bE1BeWhEWmdWTEdWV3Fkb1A0dWJIcTVXMVhScjQ0aE4ySzdIUVl0K3FGWThk?=
 =?utf-8?B?bS9DUXBZWlYzYzgwSFoxWmYzcmhIb1ZuSnFmZEVVek8wYXJUalVONCt0Y1g5?=
 =?utf-8?B?eVVkRmNCVjFtMkxYa0x3bkM2bnlObUlFNlZaUVZyMlBuUUhLU0V5ajlINDAy?=
 =?utf-8?B?S1JwZTJWc3NXTnExZ0g0TnIzNkxnQ2dEaFFhdEVzcHNMQThwTm04UHZoK3pu?=
 =?utf-8?B?bkFLempDRHl6NGJTZmVlNHhrc0dQQ3NQRit0S0t5Y1VVMERobjJMaEFpZG9M?=
 =?utf-8?B?cVgzUVZWdDc4eU1Sb3c3aEZjNFVlbXJVb3M1alg4bHEyNnFCNDk5aUJvYlQ2?=
 =?utf-8?B?b0p5SzFhcFlyN3Q1NmFuRVprV1Uzay9TQ2FBckJHdGkzb3J1eVpyMFNRbDZy?=
 =?utf-8?B?WHRrR1ZRS1pydFhpR1crYWExMlBuNGVCVkhCVXJ4Z21FWldVM0tOYkw2V01W?=
 =?utf-8?B?NVZHeGF6OTFzdDhMSjFwTlk2R3ZLNkQwMVRmUW1Ecm04MVlGS1RONm01N0ti?=
 =?utf-8?B?b0R3WHg1Skd1ZVp5eCtDOTI4ankvVUo5Q0FoSGgyVHBCdzhQcmJSK21sZ3hD?=
 =?utf-8?B?ak5DdTg3Vm1jaHc0cXJCOU9uNVMrRU83OFNucWUwVFpaa3krUHl2ZDBsYXRq?=
 =?utf-8?B?eEYxVkVsU0JxYlVMemdpQUxldlMzZnkybE0vb29maW91eHZGazJSSHVuamtS?=
 =?utf-8?B?K1YzaktlL09lOHBQY1JESWN3WVY1VkVTeVM5QlQrLytJOXRRVyt0YUh3Ylp4?=
 =?utf-8?B?ZTNQTXo0UXkzQWwrdVVBdGtKRzdUQXJldW10ckh2eTBVSWQwUGpEK2c4UXlH?=
 =?utf-8?B?NmJrWEdaZzlzUng5KytWaWlBM1FpZ3NRSHhhMzNjNWRVeFVybldJOVBIVnpy?=
 =?utf-8?B?WTdmeDdGeDl1eFA3emxIVlE4U1JEaXhGWlRRZzR1eEVwQzBORzhvcU43OTZl?=
 =?utf-8?B?cDBzYURRT0VRdTZ2Vm5ZVVNOa0cySVJTb1IxL09zblZucURJUi85V1llb3Z6?=
 =?utf-8?B?eWhlVS81RnVrVjkvaDQvUWJxOTVNSiswUUxzNEY3Qk5GN1o0eFVlc2s4SUZF?=
 =?utf-8?B?ZklueElOUUVYWU5EdXpyQkVTK2xhY1hsYXJualFPeHZiSVpXQUhQUHA1NW5p?=
 =?utf-8?B?UVRWM3BEQVFUemRFb0N0ZUhadlhmeXM2OXNQeG45bzhlRWRxVWptN3N6MjBp?=
 =?utf-8?B?VXlHK1VwMTE3Vi96UVJlT1o0NENpZm9yN3p0NkNDVUZmSklOaFI4Y2hycFNt?=
 =?utf-8?B?K1BleGkzOTZ5WWZ0Q2ovZ3NFcE5iM0V4K0M0WWxWekVHalkwclZ1N21td2V1?=
 =?utf-8?B?dXNlZVAxcnNlalBoYm53enlkM0U5bmpiTjJFMENRMldOTHNuYlcrR1pYa3V1?=
 =?utf-8?B?dmtaTURyYUFqalE3a05CeHUrbDQyemk0dFpLT3VuRFd3SUFNbitqenYrdjJj?=
 =?utf-8?B?MkpqcjVBOFNKTk5XUW1DZ2dUUWg1aWhZc2FDQ1Q1bEx0TlBtK051UkVUeHlx?=
 =?utf-8?B?SlNLa1dKRjVzcnRpM0VmakRGNmhoNkRMcmlZVDd5UHdiL2wyaDN4am9WeHps?=
 =?utf-8?B?Q0Y1K3puUUlNdTRld05PZURyZTQxMzZucUxtamFTamV6aC9ubmtBall4Qkti?=
 =?utf-8?Q?no44Ek5O2mc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ZvZHR1cWhLd3hESXdxRVdHbkdwMGN5VCtKOVZ5YTZ1b2xUNjZ6RzZqeUsr?=
 =?utf-8?B?dHFndVJabERqWXd4Yzc0YVI5RStYb045L1RyRTkxQ3orb29nMEI3dkljTjZT?=
 =?utf-8?B?Q24vdjNUSXMwcGFCVExrNUErZVlyYWlEMHhtYnZSV1l4eFZUazdBYVliYmlZ?=
 =?utf-8?B?bEk4cXBsdGlpN1l0YjJqSjVrQk1BRUdGTFVVajNUV1JNRGxXRjJ2Zkxzcndz?=
 =?utf-8?B?Z0VCOE4rZGJ6WEN2RGNVb3BtTWFzYitGY1NiWU5NV25OSDQ1cENmc1NaYWJz?=
 =?utf-8?B?a3hGMnUyWVZWaFU1c1VWeGFzUjJaT2VKT0RJQ21rMnczWllOVXBrVEMraHRQ?=
 =?utf-8?B?OFNHU2VNb3IyVlpzUU9zZDIxc25RYmNuVDhjVlFTVW5MTTFDbU9mT3o4eGxV?=
 =?utf-8?B?YTAvWGFiZnBxbkFTZWpJUVY0MW9PbVRJTGtjaHJVOERVYTJMZnBtcWRjd1M4?=
 =?utf-8?B?S3BPZ2Vic2pTVDYyNmhiQW9EM3luU29ybEpUaFk3NHlGUE95dEpONmpZNnlQ?=
 =?utf-8?B?V29JRDloNC9ya0FkeVRsQU1ocUUxdjVkaEdjWUo4dHlUclZEdE1xTVRpMXpQ?=
 =?utf-8?B?eHlPbFVWellVVVkyTGFQa29ZWHpYczgxZG5EaHZ2YTErRHFrK1RWU0xqbnEx?=
 =?utf-8?B?bXJDVENZQldJeHRIWVR4c2JnTk03VmpXQkd4Wml3RXIyZWdYd3pacHo5UDFY?=
 =?utf-8?B?WFVlZThVZlRZeWdUa2lSVHFOZm5Ybk5tRWZPbEFwZUJKek9aTGRxemptRm15?=
 =?utf-8?B?dndMU2ZiMTFzenNRTXBQaDI5U3Zjcis0VHIxMzZpWm0yU3YyVjY2cVZIeDlx?=
 =?utf-8?B?V0w1cFp0N0xNRGVkQVVteTZWSzdiZ29INjRoTDUybHhFTExRckcrL21QV21l?=
 =?utf-8?B?NjVscXhZaXFteHUrblFtaGQzU2k0ZDdjcC9QSTJLNENJNnB2aG5DSHJ4Tmw1?=
 =?utf-8?B?NkhVNmtIUjNjdGpGVHNFZExsK0J1R1dkVlNaZ282N3JUTkJRcVE5cnVna3J1?=
 =?utf-8?B?N254MzJ1V0RxaUNhVEgrK0xPNnBqOWtVbjhaQ1hJUkRxMnBqWGlKR255aFBw?=
 =?utf-8?B?aWRQTHF1dU9CTU9BMyt3V04va3lVcVVHQlJaZEQ3NUI2WDlYOEhkbnMzbytF?=
 =?utf-8?B?ZVFkV3VqZzY0azhzbXljTGFQa2dHRnJod0FUR21zM3lsaFhJb2M2RjRxNTZp?=
 =?utf-8?B?c2hHV2lFR0xwMnlqeUtGWWhSS1prb09LUDUrYnZyZ1ozOGpDeVpSdng1TTRx?=
 =?utf-8?B?bGIvZzZJT0pxTlJCWlo1SHQ5NlhEYXllOE5aR1VqZ2JhMjJIZDlrdWpZRDMv?=
 =?utf-8?B?My9vOU14akk4VzhDbUw4UXhwN1JpMkhYTFAvbURpVWwzRVlWQ0c3Wnl6QW9x?=
 =?utf-8?B?K2RnK2M1Yk1LSW5BRmh2TFpiN2hQL1lKS3pQY0M0M1ZDMG5mMlI4eDFvVjV0?=
 =?utf-8?B?ZkFnY0FLQmw2RitlWkxIdm94ZjRzNlgyUVlQYSs1NjUzRFpSR2tWRnlmWG9H?=
 =?utf-8?B?cmFTMk5VYkpMN0ZFcm1DK0w1Wml2QlZEVkoramcrRlNnb0NJR2EzZFBDUEhO?=
 =?utf-8?B?dUhQeUxKSkwraFkyWjNVSGZuL24xR2pDV1BwTVZPS3RJRHNKUUoxVVN1Mzgr?=
 =?utf-8?B?R2xHWHpkdm14ZW81U1JhTUNyTEpHNGNpT0pMOUlhS3RxaVFGWEdUUUdUM29R?=
 =?utf-8?B?S1Rvb1U5K2ZvZWpzVTRCbDBLQjlnOURjWmlKdGxaL0tjZVI3VHZ2cDdOV3Js?=
 =?utf-8?B?UCt0VFBuNjFsYlpPdEw2YmEwOUk3c2swTkZWM04vMk15ZEZpQ05wb21QNk5J?=
 =?utf-8?B?bVQrcnEvbmdWMkN2Qjc4bTNKOGx5WHIzak5FMzZsbURWNDhweCtEelJlcm80?=
 =?utf-8?B?U3RDelF6SFpCS1ovNnlnQlVWQllnM0NHaGZsUEE0aWFBY3E5Z1dLYjlabTdU?=
 =?utf-8?B?ZFhiL1VQVmVPbHNOK2tnL2hnak9meFR4QVJRS05QdTBQeGQ1S2xIdEFKaWx0?=
 =?utf-8?B?ZUprTXRwUDlRMkNLU1JvYmlxMDAra0JzRFBVbzQrRVF6ZDFtbFQzdzR6UllS?=
 =?utf-8?B?Q084TVV6d2hZVFZrdUtKNFNMeEJNZjRVUTV5clVlS1BGTmkzU0ZSbGlqUUZn?=
 =?utf-8?Q?pvauUWSNlhwF5e12dYZt1Z9vJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e2a749-84dd-4589-d96d-08dda27c43fe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 08:54:35.8873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FSyxMPs6VLTv9zOGH6Nn6bk3HrqVi5i2IwuKoNdGufVnHqemiyu4lnVBnA7Sohl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
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

On 6/3/25 04:19, Samuel Zhang wrote:
> When switching to new GPU index after hibernation and then resume,
> VRAM offset of each VRAM BO will be changed, and the cached gpu
> addresses needed to updated.
> 
> This is to enable pdb0 and switch to use pdb0-based virtual gpu
> address by default in amdgpu_bo_create_reserved(). since the virtual
> addresses do not change, this can avoid the need to update all
> cached gpu addresses all over the codebase.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 33 +++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  8 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  8 +++---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
>  5 files changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d1fa5e8e3937..73ff47403743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -38,6 +38,13 @@
>  #include <drm/drm_drv.h>
>  #include <drm/ttm/ttm_tt.h>
>  
> +static const u64 four_gb = 0x100000000ULL;
> +
> +bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
> +{
> +	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
> +}
> +
>  /**
>   * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>   *
> @@ -251,10 +258,20 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
>  	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
>  	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> -	mc->gart_start = hive_vram_end + 1;
> +	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
> +	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
> -	mc->fb_start = hive_vram_start;
> -	mc->fb_end = hive_vram_end;
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		/* set mc->vram_start to 0 to switch the returned GPU address of
> +		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
> +		 */
> +		mc->vram_start = 0;
> +		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
> +		mc->visible_vram_size = min(mc->visible_vram_size, mc->real_vram_size);
> +	} else {
> +		mc->fb_start = hive_vram_start;
> +		mc->fb_end = hive_vram_end;
> +	}
>  	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
>  			mc->mc_vram_size >> 20, mc->vram_start,
>  			mc->vram_end, mc->real_vram_size >> 20);
> @@ -276,7 +293,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  			      enum amdgpu_gart_placement gart_placement)
>  {
> -	const uint64_t four_gb = 0x100000000ULL;
>  	u64 size_af, size_bf;
>  	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
>  	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
> @@ -1053,9 +1069,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	 */
>  	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
>  	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
> -	u64 vram_addr = adev->vm_manager.vram_base_offset -
> -		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> -	u64 vram_end = vram_addr + vram_size;
> +	u64 vram_addr, vram_end;
>  	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>  	int idx;
>  
> @@ -1068,6 +1082,11 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
> +	vram_addr = adev->vm_manager.vram_base_offset;
> +	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
> +		vram_addr -= adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	vram_end = vram_addr + vram_size;
> +
>  	/* The first n PDE0 entries are used as PTE,
>  	 * pointing to vram
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index bd7fc123b8f9..8b3c84be7415 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -390,6 +390,7 @@ static inline uint64_t amdgpu_gmc_sign_extend(uint64_t addr)
>  	return addr;
>  }
>  
> +bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev);
>  int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev);
>  void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, int level,
>  			       uint64_t *addr, uint64_t *flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index cb25f7f0dfc1..6c03bf9f1ae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -74,6 +74,8 @@ static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
>  static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
>  						    uint32_t xcc_mask)
>  {
> +	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
> +			adev->gmc.vram_start : adev->gmc.fb_start;
>  	uint64_t pt_base;
>  	int i;
>  
> @@ -91,10 +93,10 @@ static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
>  		if (adev->gmc.pdb0_bo) {
>  			WREG32_SOC15(GC, GET_INST(GC, i),
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
> -				     (u32)(adev->gmc.fb_start >> 12));
> +				     (u32)(gart_start >> 12));
>  			WREG32_SOC15(GC, GET_INST(GC, i),
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
> -				     (u32)(adev->gmc.fb_start >> 44));
> +				     (u32)(gart_start >> 44));
>  
>  			WREG32_SOC15(GC, GET_INST(GC, i),
>  				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
> @@ -180,7 +182,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>  		/* In the case squeezing vram into GART aperture, we don't use
>  		 * FB aperture and AGP aperture. Disable them.
>  		 */
> -		if (adev->gmc.pdb0_bo) {
> +		if (adev->gmc.pdb0_bo && adev->gmc.xgmi.connected_to_cpu) {
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..11041d0d4a64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1726,7 +1726,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>  
>  	/* add the xgmi offset of the physical node */
>  	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
>  		amdgpu_gmc_sysvm_location(adev, mc);
>  	} else {
>  		amdgpu_gmc_vram_location(adev, mc, base);
> @@ -1841,7 +1841,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
>  		adev->gmc.vmid0_page_table_depth = 1;
>  		adev->gmc.vmid0_page_table_block_size = 12;
>  	} else {
> @@ -1867,7 +1867,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		if (r)
>  			return r;
>  
> -		if (adev->gmc.xgmi.connected_to_cpu)
> +		if (amdgpu_gmc_is_pdb0_enabled(adev))
>  			r = amdgpu_gmc_pdb0_alloc(adev);
>  	}
>  
> @@ -2372,7 +2372,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> -	if (adev->gmc.xgmi.connected_to_cpu)
> +	if (amdgpu_gmc_is_pdb0_enabled(adev))
>  		amdgpu_gmc_init_pdb0(adev);
>  
>  	if (adev->gart.bo == NULL) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index 84cde1239ee4..ef3e5bf23351 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -75,6 +75,8 @@ static void mmhub_v1_8_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi
>  
>  static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
>  {
> +	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
> +			adev->gmc.vram_start : adev->gmc.fb_start;
>  	uint64_t pt_base;
>  	u32 inst_mask;
>  	int i;
> @@ -94,10 +96,10 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
>  		if (adev->gmc.pdb0_bo) {
>  			WREG32_SOC15(MMHUB, i,
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
> -				     (u32)(adev->gmc.fb_start >> 12));
> +				     (u32)(gart_start >> 12));
>  			WREG32_SOC15(MMHUB, i,
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
> -				     (u32)(adev->gmc.fb_start >> 44));
> +				     (u32)(gart_start >> 44));
>  
>  			WREG32_SOC15(MMHUB, i,
>  				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,

