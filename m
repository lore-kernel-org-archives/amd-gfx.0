Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8B9CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 05:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC8310E27E;
	Tue, 21 Oct 2025 05:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OlhBFadJ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1692F10E27E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 05:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ofa/KBwn4Vw7RGx9sdGZm/r8L1bDTlFw5CTWQGguGpEsyUG+JWKJGSxArvE3oKfJCD67TX/HqxpJafcby2ljshbSg+ngg284BDV05ehmRBuhkbBacxe9IEitYb4G25e/YFXFfcXHlsl1X5rIMKN4n5HzNau2R/us3k7F9YTlcreRtaCzcR6OUj0VXF/L86grb1rSMcRYHE3V3VHXBZoJ/rzpSeWtmAtRtiX25IVorC5cMGF29TWzaKODKDRxtIP8Wk3WdKstaEL1DDYbpGrygfXzalzDmmsOGCNqViFlwJjdAmmlqB5CWgrojnFXHLlu9JKiluFfs5mn6LBRrmz9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY24hGzkSob+GMTtXbJtdeDzMBEkEvAjtTUXOAw+xUc=;
 b=ROj5lHt2m5MspT80F1AR9DfGOV+mX+5p8ubMWPfygwlQcyRmi2E18r9fny+72h0gdHxzJZt48Vy18Z2zxX1wp6K+H5JwQ23GD2MRrP1JC/hiaqMWveYcdEo+EGMqgf5bUnDwlDbn6/I9NmU8W8sSqxPUOIgtiyMXy67krHuVDb6KlWd3I+c4KBaQgx2QitihsOR31ZuXSZn3RNX9XBEkANNec49Hg87zvs5mU8QRdsappG1P0tc7+RTNBcBxvsLD8KYl/N8jXTH4dyFezUMeRh9j0+UqUhqr/vsa3mtKjlwAYDm74BWie8F8ZC09SvCv0AYizDO6jV7U5cVay6WWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY24hGzkSob+GMTtXbJtdeDzMBEkEvAjtTUXOAw+xUc=;
 b=OlhBFadJRKv1v4ZtB2BpsvAhwYp5ZY3GY1ZAOpNkU/lXWYxCFbK/YHEDOzfCr6USjGjftdJNnJbscy0eGGnKqVBcnt6gBSxjyo/3Q64+nS3YCyQDwOxI8FKJ3m3xVET29hot167ADqeusQJgSE8Fpu77S3g/E+UTYC3OIECRMJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Tue, 21 Oct 2025 05:24:41 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 05:24:41 +0000
Message-ID: <079a7404-2310-4cff-b3f9-674222dd3603@amd.com>
Date: Tue, 21 Oct 2025 10:54:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] Documentation/gpu: Expand generic block information
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-4-siqueira@igalia.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251020194631.102260-4-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0115.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c23c601-b690-49b3-54e7-08de10621e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk9nQVpkeE83NVZzRDZPMzdqejIzRDdyM3ZrM2N0V2VKWjNMMitpbHhaRlJB?=
 =?utf-8?B?UC9jRWlmNUcrd2llTEFDRy8xazBWSXhIVGxXeTh3ZFdlY09PREJVSTR5TG10?=
 =?utf-8?B?SU5xUW9MbWNINU95bkwvV1FzcTg5bTJ3QVNOalQxUGdNVlpyQ0dtZVUvMkVa?=
 =?utf-8?B?M1NZbDdEVk0zNGJYSDNKUUFMdEUrMWpxaEt5MGNHbFFJUlpSS1pnR211SFRD?=
 =?utf-8?B?LzJoeHRMbEVRNGZWbUZPUmVzUjNZS2x5UDg4VHBGaDhteEFGSk9YdGhFMXFG?=
 =?utf-8?B?dzg0M3JqNVlnYXRCQml5b1JhVi9hdTIrYS8zcXJRSFJXUVY1NEk4Yk1NVFI5?=
 =?utf-8?B?cHhvc2ZPanVqWDNyT2xLQTF3aENTZEZ4aUVSY1dmY0NvZGczSVZrcjZ2VlVq?=
 =?utf-8?B?ZkFCS3o1QS8rdWd5b0N3SW9UdGFkTVdEWDR2emRuazNyakhxelFZdFVoQVBY?=
 =?utf-8?B?MlloeW1qdmM4ZHBuSmdpaU05SUxJS0lSR3Y2L2ErRHdXT3I5RmFmTThOK1Yr?=
 =?utf-8?B?d3FXR3hkMXM0T1FZS3F5Sms3azI2cXBlQjV5MFhRMHhsWlBIR1ZGcHd1SmZZ?=
 =?utf-8?B?UXUveHZ4N3R0L3lsMlowQVY3eEQ4dXkzaDFXTnhaTlVTYnNmSFRmY2trTERX?=
 =?utf-8?B?K29HMWpweFB1c0tKSnM5SUk2MitWdXFESjhIM0ZpbTlQWE1MQXoyK0FpZDdk?=
 =?utf-8?B?Q2V2Yk9UUndhRVlXTWl3L0MyNWw2ckUzcC9mbW4yUWM5UFdFMS8vUzNVeFpW?=
 =?utf-8?B?SzdrcThUWTgxVi9BcEErcnhhdXNDU3hxRWk5cGtKUDYydUxGL0wrL1hzQ213?=
 =?utf-8?B?NEVUS3laM1F0MFRDTnR0RVpUZ2hLaE1Ec1pRWDNMdVhkcEcrSWdtelJGOW1M?=
 =?utf-8?B?SEM0UXRFMVVlaXJ3M0xhTEhLWWNzakxxQnJZVE5UckRMTDN1WkxzOW5zaytS?=
 =?utf-8?B?bzRhNkRuTkgzVnV5REVhbGdUZkFOcEFyTEcyT2hTdEpXcEFYajlkd3FPSTEr?=
 =?utf-8?B?ZjNnbjBPd0dTVWRLb1BxdE1VakwrcWtZOHRsZitPSCtjWUpHWVBOTHphcGNV?=
 =?utf-8?B?aVZ5Sk52YWw5V3dJWEdlOXk5b1N0UFJaSUhNakt4aGdkRjIyVVVuN2s3Vnp2?=
 =?utf-8?B?Mks0Z3JXRkhyclg5V3BqM2x5YnBaR3pGMkRvb0RqM3BGQnJpMWVXZndRZG9R?=
 =?utf-8?B?SGt6VEwxM05zSGdleFdyOFdKSTQycGYyOEE3SVFpemdaMk1GaXAwS1FXenJW?=
 =?utf-8?B?V09uYXp4ZTBteU4zQ2NxTmhweG1kTVBlNmVmV1RPc3RLMkJPOHdFOGc2aVVt?=
 =?utf-8?B?c3hpT21BVmhPMWp2MHNHRXo4bkJkVFdOR3FJR29PRlRFb0ZZVHkrUnJMWjZk?=
 =?utf-8?B?YzVjeWl5TmpKdktVOHJXTnRWQ3BaRUlrUitKNzE0VlNWSHRDWURhUkcyaTVF?=
 =?utf-8?B?U3JaN1RqM0pkTjM5dGRJaWQzdFpqVjVxa1hXQTdYQVJXWk9iQ1BieTRmRXBH?=
 =?utf-8?B?Rll3cUliZjBmdDAzR2FEOGR2R3ZFN3NrV2p2ckVORFFScVFmdXNLaEd1Rk8z?=
 =?utf-8?B?U3R3L3dhaWZ4eTkzeE0vRThVL2hSNDYvR3NDRE51MzlNaGM0Y0FPT1dWbTVI?=
 =?utf-8?B?UE5VYUc1eFRKczA1Y1VEV09JRUUwNC9TaFA4dlp6SGJ6RnJxWlhlU2d3Ulhq?=
 =?utf-8?B?dTZlOUJDMjUwcHhoWURCN3k2cDg3ZzZnRFpVVUJMZnkyQVlEanVoNVhJYnRR?=
 =?utf-8?B?RjZQRUpKSTFpSDl1S2s2MmNuc2l6OTdlc3Z6YUxyQkdDV2pGU1MzYmV6b3Fp?=
 =?utf-8?B?U3RHV1d3SDFUTW9NSGtXU0ZzeDZORzRIVlBnblhXUjByeUx5UkVhKzVra3dP?=
 =?utf-8?B?TzRNR3Ztd3kxdlJIMWxjMlZqZFhKQnA3VXJzQ20reTdQVnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S200Zm9xZWc1L2pua3NDOTJFTWRxOXhNcVcrM1ZmZzRPQ0Q1eVVVcU0yL3ZV?=
 =?utf-8?B?WUI2NmtuRzNvck5lNEQvR0FYRHZJVWs0ejVvaStwazBJYXkyQStDRFdpTWw2?=
 =?utf-8?B?eVM0Y3JiU1hLdEhxMEpJQS9yRWNUZlFPQUxuNHpPeU1vR0ZxUGl5YllEbkY0?=
 =?utf-8?B?S3BKeDlydnpuNGFxRDhHcURSZzJGWVNkczRpRjY2VWp1cUNlSG5LckQwV0Uy?=
 =?utf-8?B?OUtSd1pPajZrWmsrNVRrNFJDVWZYWVhqYmExeThGbTJRMS9aSVJpYnJQRUt6?=
 =?utf-8?B?SXdTZXMzU2VyQ3I1ZXJZVkh6dVNmTGx5YUxsRURaWW1PVTdOY2xYWUlWaVBL?=
 =?utf-8?B?ME42bmN1ejh6Zy81MnNOVWVuMzh1ZEJZektuN1NldmlyOWJkNzg2MFRVSXlM?=
 =?utf-8?B?VFNJczZicHcvbjJMckViZW83TFRFcVRoeGdBcVlpSWFTd0wySnljMXBLQ2Rv?=
 =?utf-8?B?L01CSVlLVi9FSmVWZkJacFFQbTZXMTh5ZWFPeEErd1FlWWg0QkNVR3ViMXZK?=
 =?utf-8?B?NGI3REtvSUhacjdlSFl6RGNSZFI3bGN4RnlhZkM3a25KR1lKV213eUlGenJ4?=
 =?utf-8?B?aU42cU5HVzBqdG5NNHdkUUNOenFlREE1WmJna2M1cEppSjVVUzBQL2pndzI2?=
 =?utf-8?B?eFFhTHYzdk4rSGNpR1I5bEhDWnc5b1Uxa0doNHFCTGFzSFVoY0pjVm1Od3ll?=
 =?utf-8?B?cXdwbElpQiswYzE0amJQV3NBRU9IT2I0bnZzWXJpOTFRbXEzOFB6TExDR0pj?=
 =?utf-8?B?V3NiaFhXT2ZER1BySlBoclRjRFE2SDhrRHVhRFZHcEFKb3JYYVlHUzBBaDhj?=
 =?utf-8?B?SndJdmJNSlhiVE1UUUdZUnJnVXhDT0I5dlhOYXd1YUJzSTVXMTJteU85a1cw?=
 =?utf-8?B?Nm4rcERlMGNzN1RnOXA1K3NhdUZUWXY1ZXE1bU9jMTlSbmx2bHVkZitlR2ZL?=
 =?utf-8?B?QlhtZGxob2xxNmhJNCtENjYxRmFEYVFYVnBqVDhrZGsrcU9rdkllTzZTWUpM?=
 =?utf-8?B?d3UxeXJzZTJSS0cvcHdtYVorMmV4OGM5VXNzbmdjTjROeGdYRmhuZ3Z2T2Y4?=
 =?utf-8?B?NTlCVTkrTFl4aDVUZ2JSK3hYZUFZbGtNZjhVZ3N0Mm5xZXZ3T0FKaHErcDVZ?=
 =?utf-8?B?VlJidWZzSjlmL3AxVk8yY1VXZGVPa21ieTVtZG45WmdSc2ZRNjVlWHlvckJE?=
 =?utf-8?B?bVNPZXpBaTRKMFA1SURqcXp1OXd2RnlEV3lsbnJoZkFnZFlDQTBlZ1R3YXRo?=
 =?utf-8?B?a3o5elVLVDI3VytXaUVsdjdyZmUvdFZyNDA4bVVSRldRcHZxNzVKaGkrSm5I?=
 =?utf-8?B?L2RpRE1lNURKZ0ovLy8zWnd2S0k5NkpuWTBQeFR1Sm5SM0Jza1Nhdy8wT1JR?=
 =?utf-8?B?QXUxOXRTZzBxTU5ROEZtY2ozVStHdk9nejZ1UGZ0S3pWbDZRY01KT0h2RkJ6?=
 =?utf-8?B?Rmx2ZVJVQ2l0VEluSXdhNXBySFJGczUxRGFUUm1xNWgreFQzOFRvZU1EaStM?=
 =?utf-8?B?MkdoZzVHSXNpVTh6OG1HcFJ1WklSTDZXNEQvckViWEVUanYrZjJSNmE4bDUz?=
 =?utf-8?B?VkVsWjdtdEdrajVFS1ozakJPdkxqK241Ry9xVERnUEd0VHRzZ2REaEhmVVRO?=
 =?utf-8?B?TW0xaXhXbnNRQVZ5VUpUbnhFc0ZMRVhwcFpiNVhkd2xXR0ZSQ0ZXUVBBeGFu?=
 =?utf-8?B?RGQ0akhBa1BDQ21qZkJtbXBFRUNmNThjK2xUdWlIYi9ZdW8yeU9ZWElSRUFp?=
 =?utf-8?B?TWIxdmZLbXVDS0ZmN2pLQkJkS3hLYk9TV0pHbDdxY3ljSzc5V3ZuWXRxN0pu?=
 =?utf-8?B?ejdUc2k4MEJSajUzWEZ0Y3BWdmJZZ0plTWxVTzlBYmNVZnVBNjFZSklTQkpR?=
 =?utf-8?B?VHIvbnlMSVhOZG14V0VkNkhRakpCZE1XZzlMTGlYbEh4cTNSWjJMRTErQW1V?=
 =?utf-8?B?VTE3WVc0VjV1ZGRtdFlDR0lnVm1SRVBQaForbERoYU1WZHhBZXRFLzlxUXA1?=
 =?utf-8?B?UU5rUzhaWm8wR0k4Um1weW9BcFptSU1rVmJPVHJ0NnZwNFV1OTBnWjB0cDFp?=
 =?utf-8?B?L2FzUzRWRnpodEdoQUJSYkF0NHpZckVFQ0VTZCt0dEoxdDQyODd5amQ1Szdn?=
 =?utf-8?Q?zcBIhuHnFicURyOZ422K539Qh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c23c601-b690-49b3-54e7-08de10621e26
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 05:24:41.2858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwbfOh/nTtQdUpKxPDeWUn/PQO+h8ScCP3j6PeqUZrtnyhnyU3I3XMp8IquGSKxf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
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



On 10/21/2025 1:08 AM, Rodrigo Siqueira wrote:
> This commit expands the overall explanation about AMD GPU IPs by adding
> more details about their interconnection. Note that this commit includes
> a diagram that provides additional information.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>   .../gpu/amdgpu/amd_overview_block.svg         | 674 ++++++++++++++++++
>   Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
>   Documentation/gpu/amdgpu/driver-core.rst      |  25 +
>   3 files changed, 702 insertions(+)
>   create mode 100644 Documentation/gpu/amdgpu/amd_overview_block.svg
> 
> diff --git a/Documentation/gpu/amdgpu/amd_overview_block.svg b/Documentation/gpu/amdgpu/amd_overview_block.svg
> new file mode 100644
> index 000000000000..8d9ae95bd9a5
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/amd_overview_block.svg
> @@ -0,0 +1,674 @@
> +<?xml version="1.0" encoding="UTF-8" standalone="no"?>
> +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> +
> +<svg
> +   width="237.4014mm"
> +   height="160.98259mm"
> +   viewBox="0 0 237.4014 160.98259"
> +   version="1.1"
> +   id="svg1"
> +   inkscape:version="1.4 (e7c3feb100, 2024-10-09)"
> +   sodipodi:docname="amd_overview_block.svg"
> +   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
> +   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns="http://www.w3.org/2000/svg"
> +   xmlns:svg="http://www.w3.org/2000/svg">
> +  <sodipodi:namedview
> +     id="namedview1"
> +     pagecolor="#ffffff"
> +     bordercolor="#000000"
> +     borderopacity="0.25"
> +     inkscape:showpageshadow="2"
> +     inkscape:pageopacity="0.0"
> +     inkscape:pagecheckerboard="0"
> +     inkscape:deskcolor="#d1d1d1"
> +     inkscape:document-units="mm"
> +     inkscape:zoom="2"
> +     inkscape:cx="436.25"
> +     inkscape:cy="313.75"
> +     inkscape:window-width="3072"
> +     inkscape:window-height="1651"
> +     inkscape:window-x="0"
> +     inkscape:window-y="0"
> +     inkscape:window-maximized="1"
> +     inkscape:current-layer="layer1" />
> +  <defs
> +     id="defs1">
> +    <marker
> +       style="overflow:visible"
> +       id="ArrowWideHeavy"
> +       refX="0"
> +       refY="0"
> +       orient="auto-start-reverse"
> +       inkscape:stockid="Wide, heavy arrow"
> +       markerWidth="1"
> +       markerHeight="1"
> +       viewBox="0 0 1 1"
> +       inkscape:isstock="true"
> +       inkscape:collect="always"
> +       preserveAspectRatio="xMidYMid">
> +      <path
> +         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
> +         d="m 1,0 -3,3 h -2 l 3,-3 -3,-3 h 2 z"
> +         id="path3" />
> +    </marker>
> +    <marker
> +       style="overflow:visible"
> +       id="ArrowWideRounded"
> +       refX="0"
> +       refY="0"
> +       orient="auto-start-reverse"
> +       inkscape:stockid="Wide, rounded arrow"
> +       markerWidth="1"
> +       markerHeight="1"
> +       viewBox="0 0 1 1"
> +       inkscape:isstock="true"
> +       inkscape:collect="always"
> +       preserveAspectRatio="xMidYMid">
> +      <path
> +         style="fill:none;stroke:context-stroke;stroke-width:1;stroke-linecap:round"
> +         d="M 3,-3 0,0 3,3"
> +         transform="rotate(180,0.125,0)"
> +         sodipodi:nodetypes="ccc"
> +         id="path2" />
> +    </marker>
> +  </defs>
> +  <g
> +     inkscape:label="Layer 1"
> +     inkscape:groupmode="layer"
> +     id="layer1"
> +     transform="translate(9.9255824,-64.69615)">
> +    <rect
> +       style="fill:#ffffff;stroke:none;stroke-width:0.999747"
> +       id="rect5"
> +       width="239.13895"
> +       height="162.38739"
> +       x="-10.311751"
> +       y="63.871342" />
> +    <rect
> +       style="fill:#ffffff;stroke:#000000;stroke-width:0.79375"
> +       id="rect1"
> +       width="174.55814"
> +       height="140.23256"
> +       x="22.263056"
> +       y="65.093025" />
> +    <rect
> +       style="fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dasharray:none"
> +       id="rect2"
> +       width="5.0232558"
> +       height="104.23256"
> +       x="28.674419"
> +       y="72.418602" />
> +    <rect
> +       style="fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dasharray:none"
> +       id="rect3"
> +       width="5.0232558"
> +       height="104.23256"
> +       x="185.44186"
> +       y="72.418602" />
> +    <rect
> +       style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
> +       id="rect8-5"
> +       width="3.8659263"
> +       height="4.2845292"
> +       x="48.522045"
> +       y="75.819946" />
> +    <rect
> +       style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
> +       id="rect9"
> +       width="3.8659263"
> +       height="4.2845292"
> +       x="168.14684"
> +       y="75.68573" />
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;font-family:'Linux Libertine O';-inkscape-font-specification:'Linux Libertine O';text-align:start;letter-spacing:4.91331px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:#00d400;stroke:#00d400;stroke-width:1;stroke-dasharray:none"
> +       x="45.418606"
> +       y="216.62791"
> +       id="text12"><tspan
> +         sodipodi:role="line"
> +         id="tspan12"
> +         style="stroke-width:1"
> +         x="45.418606"
> +         y="216.62791" /></text>
> +    <g
> +       id="g34">
> +      <rect
> +         style="fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dasharray:none"
> +         id="rect7"
> +         width="19.539951"
> +         height="6.9818101"
> +         x="22.811832"
> +         y="210.3201" />
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="52.663685"
> +         y="216.07796"
> +         id="text68"><tspan
> +           sodipodi:role="line"
> +           x="52.663685"
> +           y="216.07796"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#008033;stroke-width:0.0690111"
> +           id="tspan68">UMC</tspan></text>
> +    </g>
> +    <g
> +       id="g29"
> +       transform="translate(-0.52916667)">
> +      <rect
> +         style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
> +         id="rect8"
> +         width="3.8659263"
> +         height="4.2845292"
> +         x="22.782616"
> +         y="220.36148" />
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="48.966854"
> +         y="224.15474"
> +         id="text13"><tspan
> +           sodipodi:role="line"
> +           x="48.966854"
> +           y="224.15474"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#00ff00;stroke-width:0.0690111"
> +           id="tspan13">Memory hub</tspan></text>
> +    </g>
> +    <rect
> +       style="fill:#ffffff;stroke:#0000ff;stroke-width:1;stroke-dasharray:none"
> +       id="rect13"
> +       width="28.674419"
> +       height="11.302325"
> +       x="43.988369"
> +       y="192.98618" />
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="58.325581"
> +       y="200.90428"
> +       id="text14"><tspan
> +         sodipodi:role="line"
> +         x="58.325581"
> +         y="200.90428"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +         id="tspan14">DCN</tspan></text>
> +    <g
> +       id="g12"
> +       transform="translate(-1.8520837,2.3812496)">
> +      <g
> +         id="g13">
> +        <rect
> +           style="fill:#ffffff;stroke:#ffd42a;stroke-width:1;stroke-dasharray:none"
> +           id="rect15"
> +           width="28.674419"
> +           height="11.302325"
> +           x="114.87544"
> +           y="169.54433"
> +           ry="2.6458333" />
> +        <text
> +           xml:space="preserve"
> +           style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +           x="129.06978"
> +           y="177.46243"
> +           id="text15"><tspan
> +             sodipodi:role="line"
> +             x="129.06978"
> +             y="177.46243"
> +             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +             id="tspan15">PSP</tspan></text>
> +      </g>
> +    </g>
> +    <path
> +       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
> +       d="m 73.88372,201.92338 h 43.74419 V 184.5631"
> +       id="path16"
> +       sodipodi:nodetypes="ccc" />
> +    <rect
> +       style="fill:#ffffff;stroke:#00ccff;stroke-width:1;stroke-dasharray:none"
> +       id="rect16"
> +       width="40.220226"
> +       height="11.1272"
> +       x="150.82011"
> +       y="193.07373" />
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="170.78101"
> +       y="200.90428"
> +       id="text16"><tspan
> +         sodipodi:role="line"
> +         x="170.78101"
> +         y="200.90428"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +         id="tspan16">PCIe (NBIO)</tspan></text>
> +    <g
> +       id="g11"
> +       transform="translate(-5.0270833,-8.8635417)">
> +      <rect
> +         style="fill:#ffffff;stroke:#5f5fd3;stroke-width:1;stroke-dasharray:none"
> +         id="rect19"
> +         width="28.674419"
> +         height="11.302325"
> +         x="146.1279"
> +         y="132.70711" />
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="160.75085"
> +         y="140.62521"
> +         id="text19"><tspan
> +           sodipodi:role="line"
> +           x="160.75085"
> +           y="140.62521"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +           id="tspan19">VCN</tspan></text>
> +    </g>
> +    <g
> +       id="g5"
> +       transform="translate(0,5.8208336)">
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="110.18288"
> +         y="73.872185"
> +         id="text14-7"><tspan
> +           sodipodi:role="line"
> +           x="110.18288"
> +           y="73.872185"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +           id="tspan14-7">Graphics &amp; Compute (GC)</tspan></text>
> +      <g
> +         id="g4"
> +         transform="translate(10.583333)">
> +        <text
> +           xml:space="preserve"
> +           style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +           x="58.022533"
> +           y="83.518799"
> +           id="text14-7-5"><tspan
> +             sodipodi:role="line"
> +             x="58.022533"
> +             y="83.518799"
> +             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +             id="tspan14-7-6">Shader</tspan><tspan
> +             sodipodi:role="line"
> +             x="58.022533"
> +             y="90.574348"
> +             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +             id="tspan20">Engine(SE)</tspan><tspan
> +             sodipodi:role="line"
> +             x="58.022533"
> +             y="97.629898"
> +             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +             id="tspan21">#1</tspan></text>
> +        <rect
> +           style="fill:none;stroke:#aa0000;stroke-width:1.01356;stroke-dasharray:none;stroke-dashoffset:0"
> +           id="rect20"
> +           width="31.954243"
> +           height="22.038303"
> +           x="42.18652"
> +           y="77.410309" />
> +      </g>
> +      <g
> +         id="g3"
> +         transform="translate(14.287499,-0.66146851)">
> +        <text
> +           xml:space="preserve"
> +           style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +           x="97.020706"
> +           y="91.105995"
> +           id="text24"><tspan
> +             sodipodi:role="line"
> +             x="97.020706"
> +             y="91.105995"
> +             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +             id="tspan24">SE #2</tspan></text>
> +        <rect
> +           style="fill:none;stroke:#aa0000;stroke-width:1.01356;stroke-dasharray:none;stroke-dashoffset:0"
> +           id="rect24"
> +           width="31.954243"
> +           height="22.038303"
> +           x="81.080269"
> +           y="78.071777" />
> +      </g>
> +      <g
> +         id="g2"
> +         transform="translate(-3.96875)">
> +        <text
> +           xml:space="preserve"
> +           style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +           x="158.03574"
> +           y="90.444527"
> +           id="text30"><tspan
> +             sodipodi:role="line"
> +             x="158.03574"
> +             y="90.444527"
> +             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +             id="tspan30">SE #N</tspan></text>
> +        <rect
> +           style="fill:none;stroke:#aa0000;stroke-width:1.01356;stroke-dasharray:none;stroke-dashoffset:0"
> +           id="rect30"
> +           width="31.954243"
> +           height="22.038303"
> +           x="141.93443"
> +           y="77.410309" />
> +      </g>
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="132.011"
> +         y="88.873962"
> +         id="text4"><tspan
> +           sodipodi:role="line"
> +           x="132.011"
> +           y="88.873962"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +           id="tspan4">...</tspan></text>
> +      <rect
> +         style="fill:none;stroke:#ff8080;stroke-width:1;stroke-dasharray:none"
> +         id="rect4"
> +         width="126.7475"
> +         height="35.863121"
> +         x="46.912045"
> +         y="68.129692" />
> +    </g>
> +    <g
> +       id="g10"
> +       transform="translate(-8.807217,1.0583333)">
> +      <rect
> +         style="fill:#ffffff;stroke:#ff6600;stroke-width:1;stroke-dasharray:none"
> +         id="rect10"
> +         width="50.551014"
> +         height="10.992874"
> +         x="65.641136"
> +         y="122.93423" />
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="91.040474"
> +         y="130.69762"
> +         id="text10"><tspan
> +           sodipodi:role="line"
> +           x="91.040474"
> +           y="130.69762"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +           id="tspan10">SMU</tspan></text>
> +    </g>
> +    <rect
> +       style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
> +       id="rect14"
> +       width="3.8659263"
> +       height="4.2845292"
> +       x="164.57497"
> +       y="125.16281" />
> +    <rect
> +       style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
> +       id="rect18"
> +       width="3.8659263"
> +       height="4.2845292"
> +       x="67.340591"
> +       y="194.48364" />
> +    <g
> +       id="g25"
> +       transform="translate(165.76146,89.164578)">
> +      <g
> +         id="g17"
> +         transform="translate(-127.72192,-84.269792)">
> +        <rect
> +           style="fill:#ffffff;stroke:#ff00ff;stroke-width:1;stroke-dasharray:none"
> +           id="rect17"
> +           width="50.551014"
> +           height="10.992874"
> +           x="83.42868"
> +           y="140.39673" />
> +        <text
> +           xml:space="preserve"
> +           style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +           x="108.55814"
> +           y="148.16011"
> +           id="text17"><tspan
> +             sodipodi:role="line"
> +             x="108.55814"
> +             y="148.16011"
> +             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +             id="tspan17">SDMA</tspan></text>
> +      </g>
> +      <g
> +         id="g24">
> +        <rect
> +           style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
> +           id="rect21"
> +           width="3.8659263"
> +           height="4.2845292"
> +           x="0.79788309"
> +           y="57.429478" />
> +      </g>
> +    </g>
> +    <path
> +       style="fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0;marker-end:url(#ArrowWideRounded)"
> +       d="M 56.046208,126.07948 H 51.151416 V 110.60136"
> +       id="path21"
> +       sodipodi:nodetypes="ccc" />
> +    <path
> +       style="fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray:1,1;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
> +       d="m 107.63996,129.38677 h 31.91723"
> +       id="path22" />
> +    <g
> +       id="g26"
> +       transform="translate(103.05521,-16.801041)">
> +      <path
> +         style="fill:none;stroke:#ff6600;stroke-width:0.684499;stroke-dasharray:0.684499, 0.684499;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
> +         d="M 14.374335,237.26538 H 29.87027"
> +         id="path23" />
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff6600;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="41.690811"
> +         y="239.50058"
> +         id="text23"><tspan
> +           sodipodi:role="line"
> +           x="41.690811"
> +           y="239.50058"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff6600;stroke-width:0.0690111"
> +           id="tspan23">Reset</tspan></text>
> +    </g>
> +    <path
> +       style="fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0;marker-end:url(#ArrowWideRounded)"
> +       d="m 56.046208,133.69217 h -4.894792 v 58.07604"
> +       id="path24"
> +       sodipodi:nodetypes="ccc" />
> +    <path
> +       style="fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray:1,1;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
> +       d="m 95.977781,134.7651 v 15.92063 l 23.944789,0.007"
> +       id="path25"
> +       sodipodi:nodetypes="ccc" />
> +    <path
> +       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
> +       d="m 116.34935,212.1162 h 16.22753"
> +       id="path26"
> +       sodipodi:nodetypes="cc" />
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff6600;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="159.95955"
> +       y="214.49745"
> +       id="text26"><tspan
> +         sodipodi:role="line"
> +         x="159.95955"
> +         y="214.49745"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ffd42a;stroke-width:0.0690111"
> +         id="tspan26">PSP Interaction</tspan></text>
> +    <path
> +       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
> +       d="m 142.93997,177.05254 12.78794,1e-5 v -20.13841"
> +       id="path27"
> +       sodipodi:nodetypes="ccc" />
> +    <path
> +       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
> +       d="m 154.31705,177.05254 24.03273,1e-5 v -47.79807 h -6.87917"
> +       id="path28"
> +       sodipodi:nodetypes="cccc" />
> +    <rect
> +       style="fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-dasharray:none"
> +       id="rect31"
> +       width="28.449656"
> +       height="23.148542"
> +       x="-9.3648224"
> +       y="152.25124" />
> +    <rect
> +       style="fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-dasharray:none"
> +       id="rect32"
> +       width="28.449656"
> +       height="23.148542"
> +       x="-9.3648224"
> +       y="71.817902" />
> +    <rect
> +       style="fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-dasharray:none"
> +       id="rect33"
> +       width="28.449656"
> +       height="23.148542"
> +       x="198.46539"
> +       y="152.25124" />
> +    <rect
> +       style="fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-dasharray:none"
> +       id="rect34"
> +       width="28.449656"
> +       height="23.148542"
> +       x="198.46539"
> +       y="71.817902" />
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:4.93889px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-124.65836"
> +       y="32.94923"
> +       id="text34"
> +       transform="rotate(-90)"><tspan
> +         sodipodi:role="line"
> +         x="-124.65836"
> +         y="32.94923"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.93889px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#008033;stroke-width:0.0690111"
> +         id="tspan34">UMC</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:4.93889px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="-124.65836"
> +       y="189.71486"
> +       id="text35"
> +       transform="rotate(-90)"><tspan
> +         sodipodi:role="line"
> +         x="-124.65836"
> +         y="189.71486"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.93889px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#008033;stroke-width:0.0690111"
> +         id="tspan35">UMC</tspan></text>
> +    <path
> +       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
> +       d="M 69.069766,195.36981 V 166.59317 H 34.403946"
> +       id="path35"
> +       sodipodi:nodetypes="ccc" />
> +    <path
> +       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
> +       d="M 69.167488,195.36981 V 166.59317 H 184.79581"
> +       id="path36"
> +       sodipodi:nodetypes="ccc" />
> +    <path
> +       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
> +       d="m 33.58103,118.30671 h 141.39539 v 30.03021"
> +       id="path37"
> +       sodipodi:nodetypes="ccc" />
> +    <path
> +       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
> +       d="m 166.53415,126.77338 h 19.0256"
> +       id="path38"
> +       sodipodi:nodetypes="cc" />
> +    <path
> +       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
> +       d="m 166.53415,148.99838 h 19.0256"
> +       id="path39"
> +       sodipodi:nodetypes="cc" />
> +    <g
> +       id="g40"
> +       transform="translate(0,-1.8520833)">
> +      <circle
> +         style="fill:#ff8080;stroke:#ff2a2a;stroke-width:0.7;stroke-dasharray:none;stroke-dashoffset:0"
> +         id="path40"
> +         cx="7.2723336"
> +         cy="194.07741"
> +         r="10.186459" />
> +      <text
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:4.23333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +         x="7.1728497"
> +         y="195.6649"
> +         id="text40"><tspan
> +           sodipodi:role="line"
> +           x="7.1728492"
> +           y="195.6649"
> +           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +           id="tspan40">Firmware</tspan></text>
> +    </g>
> +    <path
> +       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
> +       d="m 34.063928,174.00984 78.801482,0.26458"
> +       id="path41"
> +       sodipodi:nodetypes="cc" />
> +    <path
> +       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
> +       d="M 8.1347613,181.0213 27.537285,174.27442"
> +       id="path42"
> +       sodipodi:nodetypes="cc" />
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="4.5742564"
> +       y="84.897125"
> +       id="text42"><tspan
> +         sodipodi:role="line"
> +         x="4.5742559"
> +         y="84.897125"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +         id="tspan42">Memory</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="4.5742564"
> +       y="165.33046"
> +       id="text43"><tspan
> +         sodipodi:role="line"
> +         x="4.5742559"
> +         y="165.33046"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +         id="tspan43">Memory</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="212.40446"
> +       y="165.33046"
> +       id="text44"><tspan
> +         sodipodi:role="line"
> +         x="212.40446"
> +         y="165.33046"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +         id="tspan44">Memory</tspan></text>
> +    <text
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
> +       x="212.40446"
> +       y="84.897125"
> +       id="text45"><tspan
> +         sodipodi:role="line"
> +         x="212.40446"
> +         y="84.897125"
> +         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
> +         id="tspan45">Memory</tspan></text>
> +    <path
> +       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
> +       d="m 171.56123,77.957755 13.99852,0"
> +       id="path45"
> +       sodipodi:nodetypes="cc" />
> +    <path
> +       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
> +       d="m 34.639355,77.957755 h 13.99852"
> +       id="path46"
> +       sodipodi:nodetypes="cc" />
> +  </g>
> +</svg>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index eb72e6f6d4f1..a3f9565d655b 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -227,6 +227,9 @@ we have a dedicated glossary for Display Core at
>       TOC
>         Table of Contents
>   
> +    UMC
> +      Unified Memory Controller
> +
>       UMSCH
>         User Mode Scheduler
>   
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> index 3ce276272171..13f13e2e5497 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -77,6 +77,31 @@ VCN (Video Core Next)
>       decode.  It's exposed to userspace for user mode drivers (VA-API,
>       OpenMAX, etc.)
>   
> +It is important to note that these blocks can interact with each other. The
> +picture below illustrates some of the components and their interconnection:
> +
> +.. kernel-figure:: amd_overview_block.svg
> +
> +In the diagram, memory-related blocks are represented by a green color. Notice
> +that specific IPs have a green block that represents a small hardware block
> +named 'hub', which is responsible for interfacing with memory (pre-vega devices
> +have a dedicated block for that, named GMC). In the driver code, you can

GMC is replaced by UMC and it's not a hub.

> +identify this component by looking for the suffix hub, for example: gfxhub,
> +dchub, mmhub, vmhub, etc. All memory hubs are connected in the UMC, which in
> +turn is connected to memory blocks.
> +
> +There is some level of protection for certain elements in memory, and the PSP
> +plays an essential role in this area. For example, when a specific firmware is
> +loaded into the memory, PSP takes an action to ensure that the firmware has a
> +valid signature. Another use of PSP is to support the TA (e.g., HDCP) and
> +encrypted memory via TMZ.
> +

Overall, you may summarize as PSP takes care of security features - 
authenticating firmware, hardware access protection, content protection etc.

> +Another IP that deserves attention is the SMU, as it is connected to all the
> +other IPs. SMU will help put the GPU in optimal utilization by taking into
> +account performance and power consumption. SMU helps other blocks to set up a
> +proper clock configuration. Another feature of SMU is the support for resetting
> +every component.

SMU has a broader meaning. What is referred to as SMU in driver stands 
for power management controller which is responsible for resets, power 
and thermal management.

Thanks,
Lijo

> +
>   .. _pipes-and-queues-description:
>   
>   GFX, Compute, and SDMA Overall Behavior

