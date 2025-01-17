Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35166C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 05:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD79D10EA52;
	Fri, 17 Jan 2025 05:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GVymHsJ/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AD410EA52
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 05:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbTM6YpZy638mY9Rk4/IykQNbtLBhCVPR+gwTEdYHXtSExqVG8n5rIinGq3gR5FoaN8+3N4um1esLD9fihSpcf9neubEVNf9l9lhjbUx9IWiLhhKQOjtR4NTKpElcQf2T8TOm1aoQ4UU52/PSeVc0VekrBxcpDlHwEPBVf5IXZdatGwAQZQl6rcOvZY+OLtpaskh7LeUnY/nbBiHR6/f2UBhH9O/89X6eywuV8LXONCjQ7LoQnpWczjYZBda+oD7w/lMQoN5/U20ajU9eS5qGexc9S4k16sEOEuUJYmhAjITZhs1dvcGx4TFY5vyAU/R/vpkSxjujIiyYQT9Nn391Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNCLApZn094pUDXFQsH0mGLf0S0ca8BerpxzBs4n3NM=;
 b=Fxd+ObiJi6ie2CeW4rs3Oa5LsJ5oAqYHq21jwijRVnlchwm/Mfu3c5K/av+bT9zPlwdFxgtefoM76en+a2HqAFaSgppqCsNTRhWGiJ346wJByV0YpNSdVoXkgygD/lphfteH8BYPm/unO7nsNScf1kdhN+J6h6qr3/02n4pP1j7WY8RL8KkpBqlSx+4oh+OjwIPyU9I8M69yZIzMg3V8GHV+soQQU1i/jCZRZ/ObKxIlFffXR6oG6pgLovMsr5psyfFeDS6JFg/kQb1hl7LakkEycgCJLaZyI+OihNS1boeSqLxUz3DhAQlTRL6iHgRlfzX6RSnfYlKRM4leVXLvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNCLApZn094pUDXFQsH0mGLf0S0ca8BerpxzBs4n3NM=;
 b=GVymHsJ/Kocj1TXptD5ODtOHBYENMplqYq4my1sdRC0Ot9dkgtkZleLFht2ww3ZIr4by1VO5yiQrRc6V2xFx1XAIuS78WzbP9Bshl/7CLlcP0MtkUOdxbkccDMM2KxYojYOqTQ02Y/FNWa90GP+HYHLLzjxijz/YxqgrMFf+mDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 05:39:21 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 05:39:21 +0000
Message-ID: <63147f26-205c-46ac-a019-b81985014972@amd.com>
Date: Fri, 17 Jan 2025 11:09:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/15] drm/amdgpu: free all resources on error recovery
 path of amdgpu_ras_init()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <fe7c662f67cb5f079cef7688d033bf93539db277.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <fe7c662f67cb5f079cef7688d033bf93539db277.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d80f0a3-b3e4-41d4-078c-08dd36b94ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nks1dmd5QmFVWWZsZnBqM21qZVRjeDIxRGhpUVhZUlhjNkdYMUdJa0VjTUtM?=
 =?utf-8?B?K2J0U0ZTWWFESG1iY1FNdUdiRFhFMm5SbXRtcXJsRHdCWmtZY1ZNclhhUjlr?=
 =?utf-8?B?RzdTbGtNL3BvVm1Qb1dWbmZMek93MFhuVDVOUGh6V29pZlpybjkyNG94bzlu?=
 =?utf-8?B?UlRreER6bVEwUjVvbG5CY1pIQkwxeEE2RStuanJvZGczUU9qaThXZWgyaTg0?=
 =?utf-8?B?dHExYXRja1JCMy9ROUI0UWpzSHNnR3dHN3hlRVZ1Zi9YcmRFMlpoRGdWU0Nm?=
 =?utf-8?B?ZlhYOUdNQjRwSzNXMjRCbk4rRXQxajFmQTd4QVcxZUY3VmdsK2htcGxiRk1w?=
 =?utf-8?B?RXlXcldQQlJmUVhiWEpQWVVnQzhGRS9OS3d5Vm5SUWVHb2tqdmk5M3doakFv?=
 =?utf-8?B?U0llT2t5ZGRMMFdySCtwdlRHSnBwOWlSblptYTFneXFnRHQ0ZUs3eFhodnRo?=
 =?utf-8?B?aFdOb05qVlhYRnR6ZVFNM3lxZEVCVkF5dW5pQ0FhS3E0bkQ3SUJNV3JHa2FG?=
 =?utf-8?B?eEs4VUtLMFZuQ0pJU3JvWnM5Qy9XTFdJRll4N2RjQkJkZHQySmdacGZFVzQ5?=
 =?utf-8?B?MUNOMm9SaHFCWGVLMy9HMjlVM2E1a2tMNVF4dTJGS3RmK0JmOThXaWJxQ0Ju?=
 =?utf-8?B?RnBDWGRHYW1TcHBCVmcwUTJxS01RTUlUR2FMdWkwMEdaYytRVDBsRGRDQkx6?=
 =?utf-8?B?QmRnVGtySWgvRXFEK1ZJMjFZOHNHdE5NSnAzZzZPUlpRT29YSDBheEVQVVll?=
 =?utf-8?B?elZ0R015RDIvMytqZEcvZWozUUloRDNpU1JrV1V2YmFFUC9EM1p2R3BkMVoy?=
 =?utf-8?B?Mm1Kc3N3NHo0ZDduYnlnYjZNalpWSWU1SlVZSWs5b0VOazFmcHE0MFp5WFNK?=
 =?utf-8?B?Y1NWNHQyaGNRY1Noc0dKRzZEYWM5RGF6QVhERmZkZ3BOSFNPdU9NY2ZxbnYv?=
 =?utf-8?B?WDRYSlFMSWR6L3ZBRERoYS9IekJld2tOWFBrTExuT25mYkprS25hRVNFclQ2?=
 =?utf-8?B?VjZxblhmc2pCYTdtRTNiMXgrMWs0VEhZcUx2dUNxWXhiZHlCMWlLcEU5UXdQ?=
 =?utf-8?B?aEl2UUgxZG5LY1h0WmFSRUhRL0pDSGZCZm9LOFZMTVByeFE2RFBjekYwMDdL?=
 =?utf-8?B?WGZNaFBQVGpuZXA4Vm1YczdibnlUTGYxREdnbHJGaXhJNDFTWXpQODNwcy8z?=
 =?utf-8?B?TVpMRDFUVTgzYUNPZG5KNEVoaDBRT2NLOFBtUzBmS2lublErOHFXcGNqc3NS?=
 =?utf-8?B?dVdqQ0RxMnZhS2JOeU9rSXJsMXpYZmpFZVZnSXZlR0NLVGF6S2E5dXpMM0Q0?=
 =?utf-8?B?aFEzU1k4Z0J3cUxPc2Q1QzZ3blhSMDA1V1JXSkkzdi9EZy93Qnh2Q3hYaVVF?=
 =?utf-8?B?RmF1L3A2R0tzWS9adndqRzZaZElaa2JLR1JIMmxhZEZsQjJpbzhpSStoMklM?=
 =?utf-8?B?aG9xZGVnY1N0anhIM3VmRUlWbTNoNi9SVkF0dVY4MWhLeXp1bWhNQ1o2V3F2?=
 =?utf-8?B?SjdUYmhzeEVOT1J1ODFYd01TTnNSWHNJWGRhcEtSNjl6RmswMGcrQkF2Uy9R?=
 =?utf-8?B?ZVRQRXZ3bERrMER4MGhsRC82QzhYUXIzSVdRVXZodHFRbytwTjRlT3YxSzZm?=
 =?utf-8?B?NjFIay8rVi9uNXJtWWNTbnN6RnB2MXN4aEpDZThLYTRxNy9HMEM2cDczR2R6?=
 =?utf-8?B?MS93bHZ5V2lEODVROEtZWXBRQTBFWG90bE5uMFAyM2ppU0gzeDhDaElzQ01z?=
 =?utf-8?B?TlRUa0ZYdWRxRk05K1Z2WXRBYjFva1I2dFZuRzNvZnZJb3B2SDBEbTFxMGlP?=
 =?utf-8?B?NWV5cWNoNllSUzFSWi9oWDZ0QXNwYm5TbThDT3g4UmVzNzd0RGI3S1F2ejNt?=
 =?utf-8?B?RktGOU9jUXBOYzdlcU9zY3UrdzRMWXFaY3dsdXQxL2R0c1p2MmtyNmIxY1JF?=
 =?utf-8?Q?EtU2leRyxtM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aC9wNHlzMFF5c09WMnFSMGZtQTUxMUp1aUhBbWFaRDhtRU9kVGdub3hsbW9q?=
 =?utf-8?B?VnliOFNjM3IzY1REei9RYlE3Q1labVpCOWVyV215Y1M3cnJLZlg3L1A1REFQ?=
 =?utf-8?B?OHhmckRJb0M3Y2ZCbWFyRTgrMlpMQ2pNYkRuTkNiZ1lxMGxGVFJJeU9UQys0?=
 =?utf-8?B?b0M1b2toVkp2Y21PaTJPV1VhY2w2TUZ5ajQ1WlJ6SEt3Nm5jdUhScURPZXNL?=
 =?utf-8?B?VVZjOW1PcUpTOHJuMkV6S1BGbFdGNGlnTTVSN3JxZlRTaERsVkFzd1U2b29z?=
 =?utf-8?B?OGdVckU1Mkh2MHNheHUwb20yTlpodnVOblFIRk5PZ3JFZnJSL3NBVzJjWEdJ?=
 =?utf-8?B?cE1ONDhqQVh4NG14OFh3VWZha051SWlmVnp1ZkVCdzlndHFwZElYTXFodzFD?=
 =?utf-8?B?YjR0K0VsZlFpQkt3VFV3UFNRSXFNQVhPbkFFekRaeXI1cGVqaFA5bHlqTnJi?=
 =?utf-8?B?T0lWMjRrSmpOTG1xekZlNUgzUVlacmpsaUpSRjF0K2NLaXhmNXFsSFFyaGVN?=
 =?utf-8?B?M2h6dnlKZEltYTJSd2JtWG90VStrUXZ1QUdPZGFLZzIxTUxDNjFpLysrYmZy?=
 =?utf-8?B?aGcxOW1rWUdyUDFxQnhMdTN6UDVNbUhhb1g4blN6RnNHS1dBRHBjMVJtQmFp?=
 =?utf-8?B?dE0yZkZvVXpmbHFRSVRxSi9uWWhLd0JYS2tRdUhCemU1MUdLdVlRMkIzVlZT?=
 =?utf-8?B?Zm13ZGV6dHZ5eEpRZjdST3lVWUdjZVF3T0lRTTN0dkl3QTNnM1IyTHBsSWN0?=
 =?utf-8?B?ZVdCMEM3RTJQQnFvL09mOElvS1Vta2JwWXZ3M2xQbE4zNC9JRzdMRjZ6T0U5?=
 =?utf-8?B?RGkvOU02REtaNEtZaFNlUjg1QUxRNjdvNTBvM2ZkbjNnbnIxUktweVpwRkpH?=
 =?utf-8?B?dng3aCtlcFhrYm94VGxiajJpRjdVZkcvbDM0WEdBcFpzQjRRNDhDSXlPZHdk?=
 =?utf-8?B?ajdyRnlqVEF3aFRwNFFTSlRMTlk2Z2dFVjE1dlVGUjZ5bWhIVG1seXdNempZ?=
 =?utf-8?B?UlRxdm13bVhRdjdHN1M0WDlac3hHRjk4Ym4zTVBVR21JbDQ0bXZkWWYwRmRO?=
 =?utf-8?B?Y3JxQlhvaVJhT3lpMjBoV0VuenFJQ3hnRWFBNmtNbkNGcExwendSL0FxcHZq?=
 =?utf-8?B?bHp4K0QvUWNVTkYvbjBEdWVCTmNDQTR1NE5reHZ1cEtscFRLZ05DUVBwYzRs?=
 =?utf-8?B?TFl0R2ZEdGJJa1h6RnlRRkVvUmRUT09TVnI3ekx1R1UxMFFDV1RKbnNaRWJp?=
 =?utf-8?B?WmpBby9aRTJLNDBGZ1lCNm5Pb0VzSTZCVy9jZGlFR1o2WGFiU1V1bkh1Qndh?=
 =?utf-8?B?aFRmeWJBRE1JWVk2UEpmQjR4dlhiVG1QVzNlelJvYW1rUzIxSG9HdGNWay9R?=
 =?utf-8?B?M1hocUxhMHkva2g5NVRsbk0vUzBZVjMyYTJXeTd3aFpET09qMGhXckg2SjVt?=
 =?utf-8?B?SVVnQ0hZL0pFN1d2VkJmYVZGMENaVWl5MC8rZER2bk9CeDdEZEN6ZXBteEF5?=
 =?utf-8?B?akZ6cFdnRndDYnJQTS8xcGxaWW55UjlLdzFJZWFBek0wVDFRWG5MVnIvdXhz?=
 =?utf-8?B?TjNNUFJrU3g0WGdtVmtRckRheWhwV1FJUDRFR3VTVmh1MGlyWlg0SlV6RzFQ?=
 =?utf-8?B?VmlqTnNST040ZkdkNEFJS0VYSjRic2ZHWTcyTW9uNkdDQ0N2OFl2dm5vQnAy?=
 =?utf-8?B?WG0zb085bDhSaTZ6TmNxMGZmWW1VUldpdTF2VUVmb3dySmdtZmpEeWR2bDJX?=
 =?utf-8?B?Tnd2N2oyVEgzK3JpR1ArNjVYV1pDU2Fqa0hkdmRFSEFhb3VFcUtmamYzbC9F?=
 =?utf-8?B?MU1pQytDbGxKSnUzZG9ERE1UdzJLTzRCTy90TmZMTkh4QW9vR05IME9rNDVx?=
 =?utf-8?B?N2dLaDVrVERONnJwZlQ3dmRBRjlhcDZqdVpuLzdwOVgvQTBST21STHAxUm5F?=
 =?utf-8?B?MWZqeTVUMnpLY2QwOS9Zd1RVMkZnL2RiQ0JCbnlUTHhjdUNLL1BRcElCN1lr?=
 =?utf-8?B?SGxQeU5xMDF5RzZXendFOUxmTitSSXUybXV0Q0FCRXBlUFVXOGxJcW1XRDNv?=
 =?utf-8?B?ZFZPSDFhZFZWd2UvdVptRkI5N0ZBamI5NkZ1TWlCcEVOeGFuYWkvSkxaWThP?=
 =?utf-8?Q?3JFbrV3qWqCGrxCqy+Zflg+NF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d80f0a3-b3e4-41d4-078c-08dd36b94ade
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 05:39:21.2947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxwmPrFN65ADRRqjhG3wc0guFenS9gZ7A/p1gxHsv58evtB0HZ5PnAxi0W3PzfM3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465
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



On 1/13/2025 7:12 AM, Jiang Liu wrote:
> Free all allocated resources on error recovery path in function
> amdgpu_ras_init().
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index c10ea3fd3e16..6b508a9b1abe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3864,6 +3864,7 @@ static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device *adev)
>  int amdgpu_ras_init(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	struct amdgpu_ras_block_list *ras_node, *tmp;
>  	int r;
>  
>  	if (con)
> @@ -3953,20 +3954,20 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  	 * to handle fatal error */
>  	r = amdgpu_nbio_ras_sw_init(adev);
>  	if (r)
> -		return r;
> +		goto release_con;
>  
>  	if (adev->nbio.ras &&
>  	    adev->nbio.ras->init_ras_controller_interrupt) {
>  		r = adev->nbio.ras->init_ras_controller_interrupt(adev);
>  		if (r)
> -			goto release_con;
> +			goto free_blocks;
>  	}
>  
>  	if (adev->nbio.ras &&
>  	    adev->nbio.ras->init_ras_err_event_athub_interrupt) {
>  		r = adev->nbio.ras->init_ras_err_event_athub_interrupt(adev);
>  		if (r)
> -			goto release_con;
> +			goto free_blocks;
>  	}
>  
>  	/* Packed socket_id to ras feature mask bits[31:29] */
> @@ -3982,7 +3983,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  
>  	if (amdgpu_ras_fs_init(adev)) {
>  		r = -EINVAL;
> -		goto release_con;
> +		goto free_blocks;
>  	}
>  
>  	if (amdgpu_ras_aca_is_supported(adev)) {
> @@ -3991,7 +3992,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  		else
>  			r = amdgpu_mca_init(adev);
>  		if (r)
> -			goto release_con;
> +			goto clear_ras_fs;
>  	}
>  
>  	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
> @@ -3999,6 +4000,14 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>  		 adev->ras_hw_enabled, adev->ras_enabled);
>  
>  	return 0;
> +
> +clear_ras_fs:
> +	amdgpu_ras_fs_fini(adev);
> +free_blocks:
> +	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
> +		list_del(&ras_node->node);
> +		kfree(ras_node);

Suggest to add amdgpu_nbio_ras_sw_fini which calls something like
amdgpu_ras_unregister_ras_block instead of this.

Thanks,
Lijo

> +	}
>  release_con:
>  	amdgpu_ras_set_context(adev, NULL);
>  	kfree(con);

