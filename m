Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C2ED44145
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4B510E037;
	Fri, 12 Dec 2025 08:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MEn2lLkm";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF4610E037
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 08:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DptIgJyqjMGjNayvFJ6e2K6aQ4ku9qgS5g1tSu+kAM8DLcOwVGvyRNl8X4n2Rb6uzQlDCo3RTdCfr8l8lr/uadffTBEi9rq8OYGT3GOcikJeRaUFQHBUjioCxnIEHB63UdXMEl7ekU5tP6oge1vhuUaiEGyQli7fD8Q6c+bhdA/OBGCucuSz6N23A8QFfms6lXDn2KRq6czrMnovtG2rX8kg0K6pxP7vF74TQlyuvxffFRKQMeFbdWKB8pQZgqMQgM+LfJgscHpurm+gkBuF63Ji/5OgFhhxeamw+gTvxk0+vm4xG2/Ydpk4xeDsYvzO5Xrx4pxoqSl+AVBy88FNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA+a6s8WPAEu0vGq1X4LQQdCBzpH9MAIOxTp57WZjn4=;
 b=uJ37QNH4fuv6wyMbV9sGMQlJngzdHt/LkTSDFy80UhQmcMY6Ol1HiHZ26pLtYee0Nne2HosnoyAtDJr+TCXiB4oc0+SXZgRqCFPN5Id/I7HWyLeJalMeNtT7X/j0W764q82klU9g+sBz/wwq0A/lqpg89iMnIAE7+oOFXfR6knDSmbhmE8F40tgIQR1FNILpiH8LlojubfytVPD5/OOk5eYSFE3zNsjPsO64W+Fku3iaRLsx+aBDCg3YBhBvrxCWwJHxm2/kerPiflWLpDIHFruXNmo4iWBlXiVnGJO87eGa9QCdXj+45WCzTGxc57C2AvsstRLoqf2YIXNXV1i0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA+a6s8WPAEu0vGq1X4LQQdCBzpH9MAIOxTp57WZjn4=;
 b=MEn2lLkmlJe5tk/CeLwZcZNpRLwWeoHoMHfZcddgNwtALVdIZ4azTNhwlPPLXG7o9zKqIXfx3j6kbk1AWKJYDk7dPiT70tdYArOSqDUizCBlsT8WMOPDXHxYwjn7HTD+b0H+5Fn2+/jH2NMMX/AGQ5gRWjn1TwSQTMd99MTmMMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 08:53:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 08:53:28 +0000
Message-ID: <277c65ad-a3c3-4d99-a0f4-a6ca99e61ab4@amd.com>
Date: Fri, 12 Dec 2025 09:53:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/8] amdgpu/amdgpu_ttm: Fix
 AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <465b106ddc1ff0d661f0f3db0eb9a9d092097825.1765519875.git.donettom@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <465b106ddc1ff0d661f0f3db0eb9a9d092097825.1765519875.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4ccc45-3344-4f63-a138-08de395beaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGhtTWJ6QXBDcEdpN0RIcm1CNDFlTTlvT0xRNXFNdFl0MnBiVU10alFQMFVt?=
 =?utf-8?B?KzhuVEVOaURPQllTUmZOL2xTOEJUYWRBYmtJTTUvNWNpL045b214QWxsTnJ6?=
 =?utf-8?B?L1FDNWlPUTU5VTNxYm44MmJORG51Y3BqbytPd2x5ZllWZGJVUXE0M3p6Ujc5?=
 =?utf-8?B?QmhPRTgzYzBqejZVNTQrNHRWODhCOFgwNjRVQjdZR010eFFTSUZ0d1ZrN2Ez?=
 =?utf-8?B?bXNtd3VUS0dtK0ZabEdOd2QwbmtoOXZyNVVnUEtNME1DVkVVVTdhNjlVNkto?=
 =?utf-8?B?STdvblBuaTRBQVNCeGV1KzZrWU5pcjJPanhyUWx1blFIL2tITUkwSXdtQXRz?=
 =?utf-8?B?S200NCtQU1NoMTJWUEc5TGdyQ0JoZzJ1U3hMQjBveWVqZTBXanVDODBHcXd0?=
 =?utf-8?B?U0o5cFBFYzFqbXBHOUpLbEdhckNqbnhNRUhkZ3VHOGdzT29ZNGg0OUtTWFMx?=
 =?utf-8?B?VDgrRFQ5cUZOREV5WHlYMkRzVXUrcDRWTjdSWlQvVVp1S0ZiV25Qd1p4ZjBa?=
 =?utf-8?B?dHBkUmI5R3FuUnNaVHBSM0FQczFydFNXNjhRUG9sUWVUbG5yZGdCVVNFYVJp?=
 =?utf-8?B?YVpJdVRUZWZCQ1BEUkgzdkpqUVp4bWgvdG0vUXRXVVNQZFp1N01udG1JY0sr?=
 =?utf-8?B?UFQzT3FtbjRoVXl4QUo0cmd0SjNJYWR2czhZNmlFTzVSeHBXNHgxMmYxN1pk?=
 =?utf-8?B?OHVBWFJrZ2loejN6MDJGaFB0b2RUTWVrb25DV2hZN3J5a3BkQTRqN1FTTHZI?=
 =?utf-8?B?WnNIWEtIODdSeVMyOSs0L2dKNWgrWlRtMlhGQlZWNURib0ZjdkpiMDA5Nk5o?=
 =?utf-8?B?TzVQcDZTTTRYbDRRTEhidmZLYkRDM2NRZ2NYcDBlTk1GcUIxa2ljVGR2TFdz?=
 =?utf-8?B?c0wyS2YyVjVBcWZJbXo0R3hObFE5Y1BwUWVFSEh1T3dHOW53N0kwZDlZbXdp?=
 =?utf-8?B?ck9GNTI1SkVkZForU1dVUDdFaHVyaHVhZk9OS0pRVUxOUGdlMVhnS0dTSXdm?=
 =?utf-8?B?Yk9Rb1pzZHlnd1ZRb1dvS0hybWhmbndPNTF6d2xiSVlSYW9hNUQzejgvc29j?=
 =?utf-8?B?azdJazRjWStLL2swZUpQTzYrL0ZwZzVxZ1NPSURGeGw5NlN6d1pmRFJ1SkJt?=
 =?utf-8?B?WmQwV3hVd1dBcFZveTA2dmV1cURIbm83SW0yUElQb1BkVXJoczZXeER6OTlM?=
 =?utf-8?B?MldmeStTWTBneTZadWZ3dlVDMlhnZTcxalU2WmJFNkRjanB2ZEY4WEZ0bUJW?=
 =?utf-8?B?dEw5MHZSN0J2d09UeFd5ZlIvOUVveVBmRm5nRERiLzNnT09jSklPM3N0MnZW?=
 =?utf-8?B?eTEwRERBSm1aUS9sRkUyVkFyMWsyVzVBMlN1bjltTGo4cC9jVHJZeE9MN0t3?=
 =?utf-8?B?OU4vcTFxMWFoUWIrRitaclQzV2VBVkFaOWY5d1NLckpIeXNldDQzOTZBQXdw?=
 =?utf-8?B?UjRPVUtCQjJoc0g4MFcxVU13SnI5citvbU5mZXMyUytRdDVOcEYzMkpFd1kz?=
 =?utf-8?B?UnU3Ri9YUmRWM2pPcXBQVnMwY0VCTVRxSmNFS1BhZURuazRINktOay9RcVk0?=
 =?utf-8?B?dTYrTTc3eUI3eWp0Z21uSTgxUW80dzV0dWozZTNXbE5YMml2UVp4a3d3cU1I?=
 =?utf-8?B?Sm1LR2s3bzMvVEFWSFlQUzl6WFJqUmdhTTF1Q3BLR3pwc1N3enIrM1BpeDVF?=
 =?utf-8?B?VFpsejN6RUdMQytyam5Hd2MzOElUeU5wUXRDSStGbnlkQkRLTXdMbnpwZjU1?=
 =?utf-8?B?RVFiZm4xb0lqRVB1OStFc2RYL28zVG5UdFFWbTEwaDkwYVNweHhueklaTjla?=
 =?utf-8?B?QjQ1WDNzeTNuZ2RReDBNbkw1Tnl6cjlGVDVxcmlCd1JoQit3bGJ6VlZxcnJ0?=
 =?utf-8?B?YnJyMmdsWDQydEFSV0RuSE80SzlZL1dLbzhhYWRYVDl6dGdQa3VtaUJPc3NG?=
 =?utf-8?Q?NLZ8yL/KnqLYvc+MHs2P/Lljhe4MRNZQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEhpajdCOWF0cThLdVVlOW1lalRKb21Cek13cXRsS3lGUVJHandya1dHMXUw?=
 =?utf-8?B?dk4wK3lROXF2TFZ0QUQ1a29YZ240QnVCcm5sdlFvc3krdnpUdTB1MDFPUllK?=
 =?utf-8?B?c3lqckNhMjVFWmRNZS91UHZFNTRPSHZZUFlyR2ZIVENkVjJVUE1PN3ZoMFE5?=
 =?utf-8?B?RC9HYm0zY1RaMkZnSWhCTjBOdTVzOFBmbkQzcXZSWXFiem1tRzdkR3pTSHVz?=
 =?utf-8?B?Umg4OVl0SDFMdEs3T2EyaG94bkpsc1VlSzRVa3ZkNmpqdDJyWHJna3VSNmNq?=
 =?utf-8?B?MDVnTVB1SzFsRWUxQUhPdjAxZ21NS2h4Y05UdmM2aXFxYU5ZaDlZWW9hVFZB?=
 =?utf-8?B?MWJxYzZ2UzZaaVgwY3JKS1hqdk1LUHRDVm1ucXZ4eTZCS1BsRS9YN0E0VUhL?=
 =?utf-8?B?YWxCRlRxdjBZSll1OWtmN0x6UGVDWXkvME1zT2RoNEJRaXR2MEMvT3VSOE1J?=
 =?utf-8?B?THRndWl6cmZyTmdSVTNaNWNQRUlnL2cxY203ZEZodlF5b2NFejB6NmE5dVA1?=
 =?utf-8?B?TnBEMDU1T3dZSUtZNnF0aHBOVG9Ld09lT2FPRGd6b3pITGlsM2dGcEtFeWkv?=
 =?utf-8?B?dVhSWWdvOC9nOWNHOWZaYVdpcTZ6cFVEUlF5a2kxYzJZZ0FQcGRvalR0ZmlG?=
 =?utf-8?B?VHlPUG00MjB6Y2FXTURXL05qTXFiMVVEcmc3bzBlY2JwNFUwbjNhT0d5dkFV?=
 =?utf-8?B?VzRweFVGUS9UYnl2L0tweVJUcWNHLzkwUDVIdlc1UGJ2cDQ3L1dMWjZtbk5j?=
 =?utf-8?B?aG1abDAwL05QeG15RkZrRnNQN1lTSDg2Sk5FZHhvQXA2MGZSdCtmMlRoc3JS?=
 =?utf-8?B?a1IvS09iQnBYd25RR0djTC9yRTRtRE8xazNGMTRXMU4xYkUvd1NoTG01SmUy?=
 =?utf-8?B?VXE3RXREZCtPanVrcWdxWEZheWttUjgzYmI5dE5lUEV6Uit4T2hTQ0pySWZU?=
 =?utf-8?B?YXFQdGFkOHpDOWh6WXlpa1dmMjloT3VGM2hVenZSdklUKzhrYjE2bjBaZ2xC?=
 =?utf-8?B?SVdxMkZyM1U5L3oza3ZWdHAxbDVoZFViSVVQakR4di9UVkFvd2VFeG1mUW5L?=
 =?utf-8?B?eXlZa3N4MlpyWTd5Y1h5YnVCUXAxNk02bWVXaCtZVllCbkRGTmozbjRiMGJ1?=
 =?utf-8?B?UXlnQXNKSkdIaHBNUFR4ZmpkNFVSRXgzYjRIVkx0T1pTQVdVVVYwa3lDVG5w?=
 =?utf-8?B?SzMzWk9lWlNmUHpWa0RWNjdJQktYVnNsWFZmMWcvemQrT0hibFdrZXgyM3FS?=
 =?utf-8?B?WWtodXhnbVkwdysrQkdiVHJ3RFlVY1A0TExVNE9rL3JuNWNxZHNLY0tpZ21w?=
 =?utf-8?B?RVpodHJ0a1NMOWgyQmpEd0pDUnFJbGtLRk1tN1UwYnJSZGFCNlNqRnhZR2xY?=
 =?utf-8?B?Q2pFSFd1algvMzJobWxLWWZXQ0pIb3dVSlU1bUNsV3lEREVDamRtZTY1eC80?=
 =?utf-8?B?Y3h2NVJWUkQrQmNLTGFtbFcyRXhYdnFKbXo0V1oxWFMxNjJLU3pxVGh5dXZW?=
 =?utf-8?B?VXh1K3dpeVlnamViOGlFRnYrUUVNQzRaVjNMcGtac0pRVUF2M3pxTEJPSmFK?=
 =?utf-8?B?eXozRC81aDdsVEFkdzhCdFk5Zm5Cd21Odk9YQkVZTkJRNi91NTlCSlp2cnFO?=
 =?utf-8?B?VkdFQmFsUDJYaWFMQjZXL2UzVTNPSjBSdmdxNUtFOEkvT1pZZ042S3ltck1z?=
 =?utf-8?B?NzJ4QklodE9Kd0MycE4rQjZwa1ZOaFZJaDV5RVBsYlJoWFdXNGNKdzRic3JB?=
 =?utf-8?B?eEdDTEkrME1mL3RxMm9kRURLT3cvS1lBdkw3ZHBPbHVSbHh2VUE5VElnbW1F?=
 =?utf-8?B?dmljVWpDTGpOVEU2ZC9WVEZ4dWsxSzVlbk9EdmRXdWNkWkRQM0NQem1iY3Nq?=
 =?utf-8?B?OE1ZRDZQZU9BRE9Fa2dvZTNHUG9LMDZIOWJhSmFXWG9pemZGVG9ySWxnR05Q?=
 =?utf-8?B?blFXR3lLY2lzaWdPOVFJNkxaVTA5MUFzQ0FzSjVLdWZpempsQUhlbmJ2R0pi?=
 =?utf-8?B?ejB2RzlTdkI0YWh3QmNVVDhER0xIZndjWCtzdHZXZmJ1dEI0dUFvUkxSZmVT?=
 =?utf-8?B?VTJORWxkYVI2RDhrNWdUY0dSK3VkWUk1RGJSWlRITlpHZHc3QzRBNklKcThr?=
 =?utf-8?Q?5XAI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4ccc45-3344-4f63-a138-08de395beaea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 08:53:28.2973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJI2qjzWGjRdyJReuznwCOJc4sYs89g3Y45hudBe1xiyiI+Ei5uXnJWd1nSm1/DC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
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

On 12/12/25 07:40, Donet Tom wrote:
> The SDMA engine has a hardware limitation of 4 MB maximum transfer
> size per operation.

That is not correct. This is only true on ancient HW.

What problems are you seeing here?

> AMDGPU_GTT_MAX_TRANSFER_SIZE was hardcoded to
> 512 pages, which worked correctly on systems with 4K pages but fails
> on systems with larger page sizes.
> 
> This patch divides the max transfer size / AMDGPU_GPU_PAGES_IN_CPU_PAGE
> to match with non-4K page size systems.

That is actually a bad idea. The value was meant to match the PMD size.

Regards,
Christian.

> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 0be2728aa872..9d038feb25b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -37,7 +37,7 @@
>  #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
>  #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
>  
> -#define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
> +#define AMDGPU_GTT_MAX_TRANSFER_SIZE	(512 / AMDGPU_GPU_PAGES_IN_CPU_PAGE)
>  #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
>  
>  extern const struct attribute_group amdgpu_vram_mgr_attr_group;

