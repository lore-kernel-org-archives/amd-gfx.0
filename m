Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3C1C369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2E010E0A1;
	Tue, 15 Apr 2025 15:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CJEYU8LS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BE010E0A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 15:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3Y4OBujgkzBiZ0juGDeeWhp/KTxhwEEoEKAWyNoyn5vi/yivriS+zokQu3LjU+mU7HuMNyH5AxOQxI/96pVXjWXkA/gAJZzSuafoRNAIMj2BjDLhRfM46AyVPbrha0BUZjCTQJ2VnpIrm4toqh1r+aDJaExbItqXXMdElZELLA0KOLXtDvhuCOd381+G1sW5S34CwVqSPaGS52bMXZRPmwIKdMJgw7LuzGVlFYQrHa3qYHPbxWfnGlkEnNrg0OOE1CbcRjWDogC1mGPpAC3rxT4/xVOrpDis2Ndn6OoV1NlBV6IuWCvdy2qROPw3gBRwWuCoTYqAv9+D//DwaFjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgckibRm5ibAnAMSsdX894/JmLI099ROs3fVP4CjxqI=;
 b=ySTvyqGXY8d94c+gsYIBFajaesulmzIz2hTkxYWnLUv1WjM61QfFFcq2s8TKt1p3pOY8ZK3Ik9YaLfE1v3VlhWQze4uboEzgzCaK8h//LIR5G6PFJTBy+eBR76dxG3CLCFxwpObdw63pF3ONOBnqI8gUFNpmPjwBggnLUSxSBA86X1IxZ4s2+7uXpkhBkiPGV1JLMfO2b/MdCe/RsRJCynTwAzyheaVOKjVbNUvHOfYTJl4XLKWlaNxoKXaV+XSNGT676i8eESnTXwhfC5Oa0DvQWdnl0YMl/YjZ+1P+n90kNuRGoj1rPjkLO9PKfJfsT4tvim2iZJViCWaz9B7rGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgckibRm5ibAnAMSsdX894/JmLI099ROs3fVP4CjxqI=;
 b=CJEYU8LSXYMQTDsmocbXvE4zANCIq3QRTV9mNdk8va6SmTqHeKPMBPyM5oI+LVH8YlriO+z92EIFYwkjkIGOP9yqdNyclsVi3x0ywO1TAt+DexKIp82lR7pkRtkMS4Q/6Gx5SEiqicSSfO3uOybC14tsNp1DAqUvL//LrYZuOu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 15:33:06 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 15:33:06 +0000
Message-ID: <db0086e2-3d8e-4950-b1d1-dbac6d839f2a@amd.com>
Date: Tue, 15 Apr 2025 21:03:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_vm_flush v7
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250415121248.5389-1-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250415121248.5389-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::17) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 38584668-0643-434e-9d53-08dd7c32d197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDdaSkhyUWU5eXEwVFR2UnYzeE1ZNkRXNUd1V25DVTVXdnNMY3hCck5pTi9T?=
 =?utf-8?B?ME9VckJLZjZEdk03WVMyTTJkRG13ZXJMR1o0SC93bjNtdjVxRXE4dmpCUHZ6?=
 =?utf-8?B?akF5UzBjVDZPTFFVdGtCVWxWemdjSGp6ajJaVWFLZ2VXUDBaZ1VKRk5rSnlW?=
 =?utf-8?B?OTVtTERBbG5HcUV2bzdMR0FVM3l1aUV6UzlPeFE1R0srUlVuSDBJV3Zkc3VY?=
 =?utf-8?B?M3Z0VCtCNHdRSXZSUVRXRjJzeDRoR1hKMjcweG40UlJkVGpXc3B4MVpuaXRi?=
 =?utf-8?B?NjdCWnc2N28zUUszaXdLRG02MWZkVHZUMXR6NkdpWk8wMUgrNjVvdHBUNmZH?=
 =?utf-8?B?ekNoT1dEdlJnOEVYRFJLNkljZUF5cjJUWFRyQXhkVlEySkdVQzkwZDhyeGNt?=
 =?utf-8?B?enNvTDF1VUNpYVRkMndJOXcwK09CaXJ6aXNlN09BdkpPbllLTEhDeURncm1h?=
 =?utf-8?B?YWhnNy9CQ2svU05IL2s4UDFCcFliMzBXc05GLzk0NGZIN3d4L3dST0h5eUNE?=
 =?utf-8?B?OExXc0Rwa1FXbHRoNnBQbkVsOVRJRTJKdlFzejNQVjdleStjeXIzNGV4b2g2?=
 =?utf-8?B?TXcyT1JIQkpuYk9lVWVJVkd4bUh0clYwMWl2K1p1amk4LzcwQ1hiaGhiOE5W?=
 =?utf-8?B?NjZWNjBvS2JmdnB5cVRycFdSRUpha0ZJRCtmMmwwbzlWUEhXSXdpckpTNkpF?=
 =?utf-8?B?eTE2cEdWZUhGNHV0WGNOZHVjMGJ5TWhBTTJNeFNRK285aVp0djlrb2Z3Rk9X?=
 =?utf-8?B?dGVLNGxiYmw5MkNBNXFIM0Y4RDlpM1R4T2p1dGh3QzRJZlRVYVQ5ampDQWxT?=
 =?utf-8?B?bkxkWVFuamV4Y1M2SGlFWGovMmYwVnBEUkZXWUJYeWRJUS9RdUVJb01qU2pK?=
 =?utf-8?B?T0RrN0VKaE9hNlBTWlVuZ0t4S096aFo3Vkx5UUZ1Ukk1VDNTbDhrVGRxRk1D?=
 =?utf-8?B?ZGNzMCtTSlFIbTIzRlJMcGVZaHdoQ21WZWdPZ1N0VWhNeVFOb29KMEpTREtD?=
 =?utf-8?B?L0dDRytUc0xiN3c1QnpRbWIwaHZGN1dldkFGSmJ6NU9jb0l1YU12M20wNDJm?=
 =?utf-8?B?blVsckhMVWVvT2lycWozenZZSmdCTiswSzZQZ3RLcjVRZjRTYmkyb3RYV0RG?=
 =?utf-8?B?N0R5Sm1NZWpOMTJyWDkySlVtUjNaanI0ZW1VbUtpS0pxRnhjM2VnN2lraTgy?=
 =?utf-8?B?TFdzLzFPSHZMRnI5K0dVOUw4a2huL2RsNGNlV2tQTHV3V3FaaEFSM3JETXVH?=
 =?utf-8?B?cHFVdGhjb2VLWU9xcHJpWHg5L1RQWTVBUHZSZmREMElrSzk2TWFuVEFpNXc2?=
 =?utf-8?B?RGRLUVlmN3RuanJFY2dZT1lvWFh1R3I3ZCtFd0VSa3ZhOGJpY0EvZjhtb3NF?=
 =?utf-8?B?eUJ2enRPQndXTjgwMmFPd1hpUFg0VVJxMVZLUGVsQWUwc3dmOHBHR21UWW0y?=
 =?utf-8?B?M3E3OEVZTWhCUDROUHNNTW0rY3NiU2xPRitZVFNCRHJTY29XK3hPbVFNVWFt?=
 =?utf-8?B?ZHFHTzFrTCsxU3E1WTZnUTdOZ0RFdlBqQ1lTN0NNTWQ5dlNMTjhYb2xta2Fo?=
 =?utf-8?B?M0kwTTdrekxVSGFJZzlwUlJSZzM2Uk1CSnlzVk9kWUxlQTBhVEtYMmJnN0pD?=
 =?utf-8?B?dzhlK25vdWtKU2J3UDM4aWJ6emxCaWpoN1B3MWNHVGhhNWZBOFphdUE2akUy?=
 =?utf-8?B?aDVKLys4NURwdWQybk9zRUIzRjJ6WGV0bWI0RXl2czNaOTA3a0ptN0taNml5?=
 =?utf-8?B?Q3p1Vks2WjhyVTMwK0NyRE01aXlLbWlpOTVWeTVIUWVRdzBzeXpXS0NCWElk?=
 =?utf-8?B?TGc4RWJLWlpBZzBUQzdmWGVSTFdkd0toVG1QVWo1TFZXeTd1eStWSGlxMmYw?=
 =?utf-8?B?alVyY05CWmE5OEd6Qmhla21iMThHS0lKQVFXaFVJcG53SDhobWxQZGxNM25i?=
 =?utf-8?Q?DBGt4IIrcrY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVXc0lieWpTeG1WRXBYVk43TmJ6OUFxZy9CSzc3NVlYaHAzdm9PcHEwL2FT?=
 =?utf-8?B?cHY0YzM4MElJZmJSNEc5QnNIL0hQS1dYWElKOFJHWXcrTHVFcGREL00rVW5n?=
 =?utf-8?B?WElDYnVIL2swNDVqTHVNazk5RlB0bTByc1NHWkxTRjcrZGd3T3BnZElNTEJF?=
 =?utf-8?B?VU1PcWxrV25xWSsvTnNNcFl1YzB3N29TQXdJaHIrWWU4bEx3Mi9GaS9mWDJW?=
 =?utf-8?B?SVJsOCtQdkxTZnJwc0VjLzdiM1VMV2QrYVdJTmhmTWp0WXY3WnQyWlVLTTRF?=
 =?utf-8?B?K3JlUHZVekFqeHFBRjBuWmxLQ3B2WHdpenBPQ0ovd3hmTTRZRHBIQzNENkw3?=
 =?utf-8?B?akp3Nm9LVno3VHdMTzVsNUNmTXFCZTdNdEY0UVBIcGZyTWY0aEcwMTl0Y1RO?=
 =?utf-8?B?QXAzcERLdEpsR3NnLzlMYWlmT0dZdVJrdFN6M0tHSEg1UjdwcWprT1hKd0FO?=
 =?utf-8?B?MzRlSE9QUlAzanpodGtwaGJPNVVGVkt6bnRFUDUxVXB2aGQ3ODVnSTB5amFw?=
 =?utf-8?B?SmdleVkwZVFhcWtNUS9CRFdYSkFLcXkrZGNhb3gzRUVjeTh4T2tEc0J2QXZK?=
 =?utf-8?B?VkZQSVg3V3lCbHBrYUVPYlQwcWxjdXhGbi9Vcml5VkcwZXA1Z3pxbkw4ZUZZ?=
 =?utf-8?B?d25FTEVoa2lsSjMzVzIrb2Zackl0NThObUZvRVE3c1BtdXE5NGJ2V0lyS2w0?=
 =?utf-8?B?aFBQSDQ0WjBxVGV1ZFd0a3JBL0o3RGZ6ajZwRzh6V1JwWWNIUGE2bHRyaE5M?=
 =?utf-8?B?OUFFUmNBMU5uZVlJcFdycEdNWGQxYnZJTkQxSzVDeEtUVnV5MWREQ2dCKzZI?=
 =?utf-8?B?dVBmaHZnWTJ4NU1OOTVDT3hnT2ZFLzQzbHMxVjlycVFRL2RUeldGT1R6dDRQ?=
 =?utf-8?B?SGg3Z3FaNlQ5Ny9RZG14RzRjRkxNZG5uTkx5Ylgwb3hLYkRyY1ZpR1hwWUN6?=
 =?utf-8?B?ZmxHSjRUNlRwbjhyRytzSXB4aTE3b3BqLzJCNE5QZ29WK3cybmtScGtyTHFX?=
 =?utf-8?B?anFUK3piL1BwN0ZTUVkvZDZkcUdUb1VQOFZNWTR6SEFqUGpIaUhMU2VaaFZC?=
 =?utf-8?B?Vy9kTHprOWVRcDErVCs2bGpxd0kvS1hpOGdjR0U2UmZPUFpTY2hEMkFVSVJU?=
 =?utf-8?B?Sm1JNmJFTE85SlNScExGKys4SkN1UGY2UHhhakRMTjc3RjRxMVRMRGxoN1dt?=
 =?utf-8?B?ckRKb1d2N1J4dGFGcXl1SUlQdTM2WFg4R2lrNjdsbWJkVlowL2tlb29NcUlH?=
 =?utf-8?B?K3lHMHpBRXM0SmowR2tVNFpCTjZtRzhrNDBEam14b2xpb2M2YlF4emhqZkxV?=
 =?utf-8?B?dmc3R2NIR013YW05cmtLbHJjY0dKOVp4Vm9DbU9LNFdoUGQ5ZGIwZXhCejBE?=
 =?utf-8?B?TWNWNXVNRmRKOGl1b3JsWUNPeUVTeXNtOFBKME5HTWV3RDlPUTdOVDRYOUdO?=
 =?utf-8?B?QjdLbys0MktIMGlyZkE5MGhZZm41QVBTK0pVdmQ1OHAvTndoRU1FT251QVJk?=
 =?utf-8?B?Wm9ycW5Jb0dubUxyL2E0NTdMdVRRQUtxb25UcUx6N3JhOFp1bVVML1M2a2Vm?=
 =?utf-8?B?dDJEWXpGY09Xamc2RHFrM1hCa3BKVHZQcmVONWZGRHRmd1Q3eUVEcGFsU0xl?=
 =?utf-8?B?cXlyYlp1bXh4QTR0U1U4djM2TWJxd0tXaXVJV25ZWllTL2ZVczdVUCt1MXRX?=
 =?utf-8?B?WFNJODRQVnNTbDRxaTVCMVg2Zms3K0FFaWRPdXZLd2RSNUlLbDRxdXRvaVBZ?=
 =?utf-8?B?Q0tSWFhqaGNOdTYvWUJmWFdtZU14eTFGeStqT2svWmo4eUtPRXdmMEdwbjdY?=
 =?utf-8?B?bVZjWm1JL2lDY0xkdEJxUHdXMHpWaW9zaGFNRHBBVFVnT3FRRkRXaXMyUkRk?=
 =?utf-8?B?SjlBbndmVVFiVHpqVkhEclk3SmJVTTZCdWNyZ1JxVE03QWFtWEEzN2NQOGI1?=
 =?utf-8?B?ZWkvYjVDSyt0NHEyQTFBYURBWjhBWHczQi9SQ2trZE5Ga24zTGgrT1UwK1Zl?=
 =?utf-8?B?emI3NGpmNXUvRGFMWXRXNnd6eHJ5bExWdWxoTzZvaFFQTXRvcnlmb1g0cCs4?=
 =?utf-8?B?N1MxYXlSK282M2s3U0NoWXBadlBjazhVd1Vka0lXS1NGdy9HZjJoRWtRNEtv?=
 =?utf-8?Q?GHZj2gGMFsedm6+hk0LuMmt7T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38584668-0643-434e-9d53-08dd7c32d197
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 15:33:06.6419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bdnJczm4ak99wPAFCA2frMhh6KR1MC8TxQ9SBphzsmmZ7Je+DD5oqH3TilzywtB+Zl1xxQTwyW528fCofVBQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
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


On 4/15/2025 5:42 PM, Christian König wrote:
> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned out
> that this has some negative consequences for some workloads. Instead check
> if the cleaner shader should run directly.
>
> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
> if the VMID has seen a GPU reset since last use and the gds switch
> setiing can be handled more simply as well.
>
> Also remove some duplicate checks and re-order and document the code.
>
> v2: restructure the while function
> v3: fix logic error pointed out by Srini
> v4: fix typo in comment, fix crash caused by incorrect check
> v5: once more fix the logic
> v6: separate cleaner shader checks as suggested by Srini
> v7: re-order incorrect check
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |   6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 106 ++++++++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   5 +-
>   3 files changed, 46 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b3..30b58772598c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	}
>   
>   	need_ctx_switch = ring->current_ctx != fence_ctx;
> -	if (ring->funcs->emit_pipeline_sync && job &&
> -	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
> -	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
> -
> +	if ((job && (tmp = amdgpu_sync_get_fence(&job->explicit_sync))) ||
> +	     (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
>   		need_pipe_sync = true;
>   
>   		if (tmp)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3911c78f8282..afef297161dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -707,37 +707,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
>   	}
>   }
>   
> -/**
> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
> - *
> - * @ring: ring on which the job will be submitted
> - * @job: job to submit
> - *
> - * Returns:
> - * True if sync is needed.
> - */
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -				  struct amdgpu_job *job)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	unsigned vmhub = ring->vm_hub;
> -	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> -
> -	if (job->vmid == 0)
> -		return false;
> -
> -	if (job->vm_needs_flush || ring->has_compute_vm_bug)
> -		return true;
> -
> -	if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
> -		return true;
> -
> -	if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
> -		return true;
> -
> -	return false;
> -}
> -
>   /**
>    * amdgpu_vm_flush - hardware flush the vm
>    *
> @@ -758,44 +727,52 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	unsigned vmhub = ring->vm_hub;
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> -	bool spm_update_needed = job->spm_update_needed;
> -	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
> -		job->gds_switch_needed;
> -	bool vm_flush_needed = job->vm_needs_flush;
> -	bool cleaner_shader_needed = false;
> -	bool pasid_mapping_needed = false;
> -	struct dma_fence *fence = NULL;
> +	bool gds_switch_needed, vm_flush_needed, spm_update_needed,
> +	     cleaner_shader_needed, pasid_mapping_needed;
> +	struct dma_fence *fence;
>   	unsigned int patch;
>   	int r;
>   
> +	/* First of all figure out what needs to be done */
>   	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> +		need_pipe_sync = true;
>   		gds_switch_needed = true;
>   		vm_flush_needed = true;
>   		pasid_mapping_needed = true;
>   		spm_update_needed = true;
> +		cleaner_shader_needed = true;


Hi Christian,

Just one last clarification please, may I know please, why do we expect 
"cleaner_shader_needed" to be emitted during "GPU reset" process?, 
because even in normal bootup case, we go and enable 
process_isolation/trigger cleaner shader manually, only as and when 
needed, may I please have your thoughts onto this.

Thanks in advance!
Srini


> +	} else {
> +		gds_switch_needed = job->gds_switch_needed;
> +		vm_flush_needed = job->vm_needs_flush;
> +		mutex_lock(&id_mgr->lock);
> +		pasid_mapping_needed = id->pasid != job->pasid ||
> +			!id->pasid_mapping ||
> +			!dma_fence_is_signaled(id->pasid_mapping);
> +		mutex_unlock(&id_mgr->lock);
> +		spm_update_needed = job->spm_update_needed;
> +		cleaner_shader_needed = job->run_cleaner_shader &&
> +			job->base.s_fence && &job->base.s_fence->scheduled ==
> +			isolation->spearhead;
> +		need_pipe_sync |= ring->has_compute_vm_bug || vm_flush_needed ||
> +			cleaner_shader_needed || gds_switch_needed;
>   	}
>   
> -	mutex_lock(&id_mgr->lock);
> -	if (id->pasid != job->pasid || !id->pasid_mapping ||
> -	    !dma_fence_is_signaled(id->pasid_mapping))
> -		pasid_mapping_needed = true;
> -	mutex_unlock(&id_mgr->lock);
> -
> +	/* Then check the pre-requisites */
> +	need_pipe_sync &= !!ring->funcs->emit_pipeline_sync;
>   	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>   	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>   			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>   	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>   		ring->funcs->emit_wreg;
> -
> -	cleaner_shader_needed = job->run_cleaner_shader &&
> -		adev->gfx.enable_cleaner_shader &&
> -		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
> -		&job->base.s_fence->scheduled == isolation->spearhead;
> +	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
> +	cleaner_shader_needed &= adev->gfx.enable_cleaner_shader &&
> +		ring->funcs->emit_cleaner_shader;
>   
>   	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> -	    !cleaner_shader_needed)
> +	    !cleaner_shader_needed && !spm_update_needed)
>   		return 0;
>   
> +	/* Then actually prepare the submission frame */
>   	amdgpu_ring_ib_begin(ring);
>   	if (ring->funcs->init_cond_exec)
>   		patch = amdgpu_ring_init_cond_exec(ring,
> @@ -815,23 +792,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (pasid_mapping_needed)
>   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>   
> -	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
> +	if (spm_update_needed)
>   		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>   
> -	if (ring->funcs->emit_gds_switch &&
> -	    gds_switch_needed) {
> +	if (gds_switch_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>   					    job->gds_size, job->gws_base,
>   					    job->gws_size, job->oa_base,
>   					    job->oa_size);
> -	}
>   
>   	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>   		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>   		if (r)
>   			return r;
> +	} else {
> +		fence = NULL;
> +	}
> +
> +	amdgpu_ring_patch_cond_exec(ring, patch);
> +
> +	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
> +	if (ring->funcs->emit_switch_buffer) {
> +		amdgpu_ring_emit_switch_buffer(ring);
> +		amdgpu_ring_emit_switch_buffer(ring);
>   	}
>   
> +	amdgpu_ring_ib_end(ring);
> +
> +	/* And finally remember what the ring has executed */
>   	if (vm_flush_needed) {
>   		mutex_lock(&id_mgr->lock);
>   		dma_fence_put(id->last_flush);
> @@ -861,16 +849,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		mutex_unlock(&adev->enforce_isolation_mutex);
>   	}
>   	dma_fence_put(fence);
> -
> -	amdgpu_ring_patch_cond_exec(ring, patch);
> -
> -	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
> -	if (ring->funcs->emit_switch_buffer) {
> -		amdgpu_ring_emit_switch_buffer(ring);
> -		amdgpu_ring_emit_switch_buffer(ring);
> -	}
> -
> -	amdgpu_ring_ib_end(ring);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f3ad687125ad..c9578b7f670c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -498,7 +498,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       struct ww_acquire_ctx *ticket,
>   		       int (*callback)(void *p, struct amdgpu_bo *bo),
>   		       void *param);
> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +		    bool need_pipe_sync);
>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate);
>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
> @@ -559,8 +560,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   			   uint32_t fragment_size_default, unsigned max_level,
>   			   unsigned max_bits);
>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -				  struct amdgpu_job *job);
>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>   
>   struct amdgpu_task_info *
