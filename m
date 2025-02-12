Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3744C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 13:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A63E10E324;
	Wed, 12 Feb 2025 13:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tdQu03Xh";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E8510E324
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 13:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he7DxMJhQ2+S2L10YomGLAIafbfEki3P5DCOFPxscHbWfyY7PydmNyrMrucHne6Y+domOM0+kDcIyI/ZVHXNRJlRg2gfS/5/pzuOfDPZOrfABqSSwDPdy1sJSrGoF8o7Yb4Dr1A0Abk8AK81CKO/bYY5o1qWD30z/yqiPxD3/p++f7CBCka8h5mj/QzK0qA13zXVQP2xxJsi5ASn8GucyHVfrnwr2MPSngX/Ucgmqe0btzAcNbxqbNdNBHnEdlCIVPD3epOXlfwBgONeORjs23RQyeTk2tryvEQ58Y5+VaWbODB7/M1feY2uINl1uYSELuN0lES/QdrndAiPsQ4l6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvLmAB97QI2KPs/OExaeOqlAZi2Y1zIRdruQSUY1byQ=;
 b=nBm+cDpK/tJQ0B1MsxCfF093oFzoRM/ZOkmI7HsGWK/P7lpz22MWkxwx9b7xtqSNvqM+2N6D1FWxDm5ukQt3zZWv+pIksqmAaW1lsdLc2HPjkwkiCqnXoZTG1lQRmtWyDXafNZtHYipj733CfHEfHJ7zA7f+AW/KfBv84DgVXVm8qZFFiiqjPouVmFJyAW45FLM5zEGlOHv9rcpfqiSCAHePDUzXp/OXPpXHFJPS4vLuVW0impjo1DiBLhRXYvyTpNKhwoMTBVj80UmvzlqoMA+kSYNVkhI380PK4TjNYhXuEpiDsse2IeP/Byk8yAK4ND6alo+9kX2Ap2912TXxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvLmAB97QI2KPs/OExaeOqlAZi2Y1zIRdruQSUY1byQ=;
 b=tdQu03Xh6inEazIRa2Oc8Lgv6IajY5Lxv53wMmQviGGzZO6UXMt8bHo49uOxJ3rcc+4b7RIWBXu+SHk6rj2F8KQLbLQKtjxNWAEMbMAZWBYUgAmRUwHcTbTx2EMeoFcLiBEY7/BujrDkeWuu3D2W/fmCJwPTkPM/tMW5Eqh20cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 13:08:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 13:08:21 +0000
Message-ID: <9c02ec5d-4dd1-4eac-a69c-19c623ef5c6d@amd.com>
Date: Wed, 12 Feb 2025 14:08:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: fix the memleak caused by fence not
 released
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, lijo.lazar@amd.com
References: <20250212113001.2286084-1-le.ma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250212113001.2286084-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: e851ec65-9cc8-49ef-6fd5-08dd4b66537c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXJHYmtjZXBpbTEzMHpxSGtZbVEzYklJWEJONlQ5YUpNSVdpSW90TURhdUdV?=
 =?utf-8?B?R1lReDdFelZlbjB2K1BhMVBHeGJwS01rYnREZElsVHhwakR0SS9DSCtyRzdR?=
 =?utf-8?B?ek5ZQUdydnZmT1FMU3AxYm84T1I0Q1RqNUFqWUZpdEZKdXlFbW9qZnlCMmRv?=
 =?utf-8?B?cVNVZWdzZGNPM0hDdkVoNWhRcEV2Q1l5RmI0SHdLZ3BEbFI1UlZyZmpIeFlF?=
 =?utf-8?B?N3ovN3lSL1FoOCtwZk1ObDJYY0wzNUY2OURSVUxRbG5ldDh6M0dzeGlSYmoz?=
 =?utf-8?B?MVNJaVB6YUc1d0orNnhxWHVXQzYyWlQvbitWTWo1MExDdGpFTjd3Wm84QXhL?=
 =?utf-8?B?YXlBMGpsMUl6QytGZlNYOGpkRkVPdGsrTFNlUjVVQUZDT0ZRRGFxQks1OU80?=
 =?utf-8?B?UkVVa2dodGVZdk45NWgwNHJBNjF5cEZuMTU3b3Q3WGpZUXl6ZHQwTEovV3dS?=
 =?utf-8?B?MEhia2RrWEMyYlhuZCtjUkVhaEtQTmVFSWtGU0g5OVc2clRRUXlqOW5jNEpi?=
 =?utf-8?B?cXdVNFVVdjROM1hYSTlXSURuWTdQYlRVS3ZpTkZRbVY0QXNwMjYzdnV4NGU5?=
 =?utf-8?B?QjY5UjlseXdlVTZDdXY2UG5STTdLNlBicldkdFRIMzVkSGt1Qk8ySDVrY2hs?=
 =?utf-8?B?VzFFNGVnTjByL2tkWFpQcjgyUk1QRElMOFBmVDgrNitnQnh1WXd6ZnZIRlBM?=
 =?utf-8?B?a2VOL0ZGZ0tmWVUrOVBZUVRXU2dWUDhvZ3A4SWdJcnpyamkvbWxlblJ1V0Nl?=
 =?utf-8?B?WXBEUEw1bHVTOWFMSXZPNjY1bkJhdmVlb1lsdS9tN0FjUm9MT3RIMlZGbHF1?=
 =?utf-8?B?YXdEQWZOVFo1TEZkczQvNE1sTU5HcUhyTFoxR0NPZm5DLzI0QS95MGlyOG9J?=
 =?utf-8?B?d21rMWFLTWxFcitCUitZcEZEMDlrY3VIMTM5Y0ZKK2lWNnBjemFmamZLWXda?=
 =?utf-8?B?N0RnRkpmeTQrRHpPZmd0RStIUDF2Sm00cVR2dVE5cytyRjNIYlRWM00xR3ZW?=
 =?utf-8?B?MUYzSGRxWTFDbmlOck9qUkNCUUx0RFk3aW1kcklQYUVMTThFSzVoZGx0aXV1?=
 =?utf-8?B?RStmYWRsRTQ0UU8xN0gvby9Pem9MYUx2L3E4YXdvbTM4T0MwWWJGMTJ3OTZE?=
 =?utf-8?B?QngxSTh2Z3VVak5KRU9YenArZHlMWEdMZWt3V0l3MkhpamRXUVdlUDJjYXhN?=
 =?utf-8?B?MUdOeHBqdFZFcXdrNjB6bVoyWldLTDY2NDJ0SkFPZGpIVFo5WStzcml5VmxI?=
 =?utf-8?B?V3h4cXdFQzV6ZmdUSjZIeGx1WDBKVEkreGRNaUQ4SEJnbVJYMEs5a0toeDI4?=
 =?utf-8?B?WDdzOHFOd0VhUTNhNmFhUHZKWXVyUENiMjIvcnA3U281NksvbE4rWDdDdkFs?=
 =?utf-8?B?UklJS3M4T3dUck9kTDR1ZThPTWkrSXB3TVJYa2Iya1haQ1RzTS92c2tKUm1C?=
 =?utf-8?B?M1ErbDBHdWhncFNjYXVCZ2NHQUprR2NUMlQydWdNTGc0cTFicENvVmFvMi84?=
 =?utf-8?B?akVxWnUrOFJ5c05Sb2R3TFRzZFA1WUdLUEtjOHppNnhJb2I3d01OMmpFM2Jm?=
 =?utf-8?B?c3RNV3o1ZG9kL3I4MTNoemdOSUhybm1HckJqWStwa09ybFNGZ1ZjWEZjQjZU?=
 =?utf-8?B?Y1ByK2MwVW9zdjdvb2dUSGtCaHBzN1NrTTFDZGIwVmV5YVJrdGN4NVgxTG1x?=
 =?utf-8?B?UzB3N2w3dEZwM0ZZc3J5cmtHamNrWFZEdGdYVy9za2hvMlFuaGlXa0h6TkIr?=
 =?utf-8?B?K2JPeTBiRnJnNmRYT1RxS2FVN3ZUWHF6Rkd3YW1TeXlQbFNQY0ZDSEI3OWZB?=
 =?utf-8?B?M3lua2cwZEpuUHRyRDRyMkljeUNyVDVQUHV5SGZBTUtDSXNKTTBPb3FSaVl2?=
 =?utf-8?Q?VjqxzPPFfAhKf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE1pRFRFZzNOVlBwWWNHemRQenljRWhqYU1GenJSODhDTExlaHVRMWdQeVQw?=
 =?utf-8?B?M2pMTXg2VklxeUNaanhOQnhNaFBQSTNoRE9zMElFZytibzNaV0hkaDNsODJL?=
 =?utf-8?B?dEZIUy9kSW5mMnlMVW5QM1NXYWRGbi9yaUNyN2l2SkdyQ2U5Ym5SWktUWFZq?=
 =?utf-8?B?Nk9NSHhwdk5tSFlVTkV0Q1diSmtab2h3YTlIMHBxQ25qSHlqNENuSFExa0hl?=
 =?utf-8?B?OG00TjQySkFYRyt2ejJTQkgzZFVSY0FJcGM2cFk5WTNjTjJPK3kzZ282ek8w?=
 =?utf-8?B?Uk1ZaFF1dXhBNVF1c21MYmRPNWNJMHVaVUxDUDdmNHhOa3FhSk1WQXl3UTZ0?=
 =?utf-8?B?WkNWTnd2QmhpQVdYWExNK3poWW5MWEVVdzBWQS9oR1U3bCtMTDlMZDlsTG5U?=
 =?utf-8?B?Qm9jZGpHTmZ3U2oyaG9OOEM5eEFwSXQ3MDUvNGpVczhac3FzU0FqSjhuUU5L?=
 =?utf-8?B?WFRkV3ZML2kxSisvNzdWeVJDcWdablUvdGRYdkgrWTFZbGxXRGVKdEZGN3pk?=
 =?utf-8?B?bHFOcXdxcENZMDhOYnRzSERtcmhzVEFoaFNDNENBYXV4VDlEY0FxSHFLOTJZ?=
 =?utf-8?B?Tks0RGhjS3ZDWHo1Szdhejd2eXlnNEZ1cWdFOE9NUFdDZ2gvT2REODRlbjVm?=
 =?utf-8?B?K1hJN09qb3ZDNzRocndsK0JCSlFaRmpmR20xVmJEQjZZUUloTmkvT1pHaDlF?=
 =?utf-8?B?amxvMjUyYVFrN2l5RmxHSUZqaW1Wb0xpNElVUGhtZGZzM2w0VEo3MTM1dlNP?=
 =?utf-8?B?bENIb05JNGM1TlpZeXpzTVhLYW5pQTltTVlQVVBoZVpQRVB2a09hOXhRalh5?=
 =?utf-8?B?dXJoN09vYjNtOXRKclVpTGFteWZtVEpqdExKZ3dKcmVoTTdPVHhydmhpYldN?=
 =?utf-8?B?K2xEcWV1VTIvQitpRm5DQWxSY2FIdlhhNjRVN2xtbGtVeHczbEZpRUVBRGRH?=
 =?utf-8?B?NnBpL3JkS1NoTzBsRFpaS1lES0tyemtQQmVrQStjTldDeVI1aEhaV3RjMzND?=
 =?utf-8?B?U2xPRGlqRWNDNTF4VExSSFZNa29OdlBvclhrZS8yWERhdDg1ZytVNjdzUVlE?=
 =?utf-8?B?QzdYck8yQmN5dVA4cWdhZkV2Z1N3eXVUaFRnUHlhYXFtL3g3Y2YzWDlCZXdX?=
 =?utf-8?B?Q3RWSGpRaEdHTDVGWG9wWm9BVG5TOU9iMkx5SlhTRUo3cTNXS1dWTmVXc09F?=
 =?utf-8?B?K0g3STJaNEVyeG9WMGM2OVRyWVBCWnROZitpa0hUaTRuT2J1SUNFZjNpenpz?=
 =?utf-8?B?VjlhRzRUYlZCQW5MU0tGSjY1enN2Q2NrMy9WWmRSUExsUTNMa25icGhpM2hW?=
 =?utf-8?B?M2VGeHRuUUVFUEQvYkJXMCt2ZkkvQ0pJd0xJWGpiMk9RQzZKT2UvTmsrNHIx?=
 =?utf-8?B?MXJsVzRPT3ZGU3JxVVFIQUs5RlQra2c4QUYvcHY0T0YrVWJ4L2Z3eUNYMisx?=
 =?utf-8?B?SnNBUmtUZWEzMVBldllkMGw5cTBkRzJvTlUybTFWZUlnTFhQRUxLZDhYQndp?=
 =?utf-8?B?bFZseXNmbWZKL0l1MnVpSG9mazlRR3VUdi9lYkhMTndwUTEzZkw1ZzdUNzY4?=
 =?utf-8?B?VW1YVXpWcjJEMzUyalRtTWs2c1o3ZitINzB4WWhxSUtvNU1kVjc5bXNSMmI4?=
 =?utf-8?B?cS9KVW5KcTFjY1JOYWNOWmlFMitPTmVPc284UDIzVVFnZUx6azkycURwbzIr?=
 =?utf-8?B?WUwzQit1RlRxTTh0V3NoMUZWOG1SNzNNSDFsOThqekpHSG1iMGRpUjJNR3VN?=
 =?utf-8?B?MmFGTUhsSDJqWWhqemtUWGRuZXJIaTliRGRZQmNQb283YmZ6UCt6REt0SmVY?=
 =?utf-8?B?Y2s0TE4vYlZmOHBDSWlXWHBJSFVibTlBb01xNS85TlB2QWw4M01wbCsvWkJa?=
 =?utf-8?B?bXhMYmtvMDV5dnJOSlFEc0ovUk9sTVRzQ2J1NjJwTzZZb1FyMFNqMjRnZkFz?=
 =?utf-8?B?Y0RYSXBnUEY5bU5TQkZGWXlqa1paYUdURzNERVlwQXdyQjYvc2gyVGxxdGZx?=
 =?utf-8?B?K3RZQ0JQY1ljb25FNkR0SG0yOHR4elBxd1dGS1dKdmM5RnBhb04xK1J4N1pY?=
 =?utf-8?B?YjR1cVl0ZndCa3ROaWxuanpWdFM5dnZZMmlyZkJKNGVkTWZvRHE0dEhjRFZD?=
 =?utf-8?Q?ZO0WpVyAmf7qqpwC3ZbxKmssr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e851ec65-9cc8-49ef-6fd5-08dd4b66537c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 13:08:21.8488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUnuRAVG+kPRGwo4lu2cRHZMIsYYwO9Qr5Azl/TKKI0UOsAEGhxBAB5jH+AApmf9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

Am 12.02.25 um 12:30 schrieb Le Ma:
> On systems with CONFIG_SLUB_DEBUG enabled, the memleak like below
> will show up explicitly during driver unloading if created bo without
> drm_timeline object before.
>
>      BUG drm_sched_fence (Tainted: G           OE     ): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
>      -----------------------------------------------------------------------------
>      Call Trace:
>      <TASK>
>      dump_stack_lvl+0x4c/0x70
>      dump_stack+0x14/0x20
>      slab_err+0xb0/0xf0
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      ? flush_work+0x12/0x20
>      ? srso_alias_return_thunk+0x5/0xfbef5
>      __kmem_cache_shutdown+0x163/0x2e0
>      kmem_cache_destroy+0x61/0x170
>      drm_sched_fence_slab_fini+0x19/0x900
>
> Thus call dma_fence_put properly to avoid the memleak.

Good catch, but there is even more broken here.

The call to amdgpu_gem_update_timeline_node() comes way to late, we need 
to make sure that this is called *before* doing the update. Probably 
best to just inline the functionality.

Then AMDGPU_VM_DELAY_UPDATE and is mutual exclusive to specifying the 
syncobj when the update is completed.

>
> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8b67aae6c2fe..ad3c5fdf6970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -125,8 +125,11 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct dma_fence *last_update;
>   
> -	if (!syncobj)
> +	if (!syncobj) {
> +		dma_fence_wait(fence, false);

Please drop that wait, this is just nonsense.

> +		dma_fence_put(fence);
>   		return;
> +	}

We might want to move all this into amdgpu_gem_va_update_vm().

Regards,
Christian.

>   
>   	/* Find the last update fence */
>   	switch (operation) {

