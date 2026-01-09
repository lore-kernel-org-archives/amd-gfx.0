Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B38D232F6
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 09:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E68D10E83F;
	Fri,  9 Jan 2026 09:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z+eT343L";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC0DE10E83F
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 09:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaqOb1orj+BCtil8PL9BetJV/C2DM1RqEOuYoUM12uEg+2/RPrazkSZGGIG3tKL1BMfu/NrdBrqA9VVupRxkYLdHtNz3VhfoAKlRopLdTLf6L82OHFO0tRHkGC356ALt7j05zsjxMB06QH9A6gFLwH34S7p3W3JVBvwiknt81z9t4Eu8Whg405Zp/qpr0rAY2L61aLrAMYuRFBJA8P2HAH4GJvokjKWaLbPHYj7Chco+PA0lA0zx/iP0rAt8CBS1LNs8nVh0etGxFiM/UUz4GgN20fAQzkRlm7FLsNpPZGWlGwGyhnpQaWfep9X9Anab2Gq8VnfxlBPUgVSkpuSCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=446KcMUT/pEC8gGfVhUtjVV7RIE8EYqmWs0pKOfj8Hc=;
 b=IwjKz2tfkuZD3DvN0ZGh9GavhPM2zrMJcaWIjNrGUol3ir5mb7Aib6lHB9W86akgArdwcG3ahMH4MunmPcPzLM3qYsW/T8uP2+lfvJYcju2P8ITEqLsc3OzuGhw8D68uAWH6NwIhH8sLdPCpFkIM7znH0kJRghQPeNRRf0yUxAxcr/rxDrVF9O3pSC6Cc0eF8zROY8JiwewT6KVMJCuCgQvkCNRQaqu3ElqbzQDEuhts8spP7tuMe+LJ628cHALCHw74eIAtnZ2uyiSVsXD9hWU1Ciy6yUx+6NGsWVadzyiCQtvQT868QmZO5Lg1P7md4BavNSsvpp1dzqap4JVXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=446KcMUT/pEC8gGfVhUtjVV7RIE8EYqmWs0pKOfj8Hc=;
 b=z+eT343LWOxWZQ0BNCuiq26ghB1jzrKcSb/jVo9jCdPu4JDk+bd8VtLVm5PXYqdoIJ9wuBRahVNQ3NffO8v5mvb4UjwkWUlZroiT6Xs5ljVZwUbkgWbuhW00AbSLXWdtR5WFspEl+Y6W6Zmfwn6GsX2TeXS4DhYH/rIrOnrRAn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 09:08:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:08:15 +0000
Message-ID: <98ab0d09-68af-431e-9a36-3963ec9361bc@amd.com>
Date: Fri, 9 Jan 2026 10:08:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: don't attach the tlb fence for SI"
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, phil@jpmr.org
References: <20260109082523.889564-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109082523.889564-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0280.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5d5e84-4b25-498a-f152-08de4f5e9f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmxOUkk0d0g0Y1owRkJwNHZvN1h2RlQ0NE9FVFNpZGsrMDg2cGgxbyt0QzRV?=
 =?utf-8?B?ZTFuNU9LM1hySWJuOGRURWUvTmlUWHArcnpzZjM2QWNWMEZyU0VsVVZ2dGpF?=
 =?utf-8?B?SUhSOElhVlp2eExTZ2Z5NFloVk85a1Z5M0M3eFA2NkRrSEVFT3dwNkhkeW5V?=
 =?utf-8?B?TDBUWllLcXhnZzFQYnNuNkZuMnJUK1ZzekcyajlSYVYwUlJlTjU4K2ZPb29h?=
 =?utf-8?B?TFF1RjhYV0JZRStBbUpMekpLanpPUndrdE5EN3ZqYTUySDBmaTBySVI4VTBG?=
 =?utf-8?B?RE53RUxyOHB6cGc4eEVlS2liMVI5c01FYzhLVUJQOE9YUW1tQnlFekhab04y?=
 =?utf-8?B?bzRCbTN1NUJ6TDRJYUMzVFNYS0Mwb21TUUtaZXA5MTBXbHZRZndOczRJSmxy?=
 =?utf-8?B?UGRlMUtndGs5Z21UL2daeURLZ25ma0l4NWdyN0lUODZIYUdQWDVxNjU5bHhu?=
 =?utf-8?B?V1ZoaUZzdDQxa1dxQ2N5R3JWMllBTHRpemZiNWV1RE92U0F5WklqTFNWdzZR?=
 =?utf-8?B?emFxai9zTTNRSEFvMDZ3NndtUHd3WFlrazJOU2d0NkVQTFlQaTR0UW45MVVm?=
 =?utf-8?B?U3ZVUHNLMzNwb1QzS1pOTTZZN3Z3UzVaajJUNmxvTGV3cnFTYnJZbmdSbmQy?=
 =?utf-8?B?R20zNGI4aXJGNWhDY0tGengzN3F0M0M0UU1XS05aekhnN3E1NlQvcHhuV1JD?=
 =?utf-8?B?Qmt6TWpqZ0dycStaeGF4c2YyYVdlMWhCRmk1K0xlRW1ldWxGaGV2N2Y4NFRM?=
 =?utf-8?B?dzRteUE1bDVtN1hvUUJoUURiNDM0Nld0VElwWUNya0ZsNmR0S3BaMVFmRnhk?=
 =?utf-8?B?V3FrbW81Lyt6YnEzSVZyUzEwSURod0h0YVFoVk4xY1FxMzk5Yis5cEl5OXRs?=
 =?utf-8?B?QWE4emgzVjJZNXRuVGMwNHhneTd2Z2poc3pnUytPUFNwbXZOczQ5UHE4ZUlN?=
 =?utf-8?B?bEcxS3hpRjlNcFVpUFpaUlJMZmoxLy9GYmJqS2V6emtNT2RHTXlmVTF2QXBo?=
 =?utf-8?B?eXVhUzd1b0ZsUkZjRlg1TUhxY0Zmb2pjak1nKzNTWUZOMlBWUW1LOU0zYmZM?=
 =?utf-8?B?ODVBa3BLc0EvS2pHMk1wZXBGQkhyeldwdVltV1J2Zld4RVQ4aXVaeDdaNHdP?=
 =?utf-8?B?a2JXNVhnZGFROVFiNFBvejAyVmRKNDJFSUgxbzl4Ym1mZ3Zady9pUVVFMVdm?=
 =?utf-8?B?TTRwZ0EzSTQ2UHZTQ3dqbFRHTmJIdEUyT0FtMFNrSnlSMkdhZkJKZGROZy9i?=
 =?utf-8?B?ZGhRamRWY25wSmRRUEoweWNURFN0U0Vzamh1SGxXWkJjcnRiVkxncHVzWDFk?=
 =?utf-8?B?YmJhdm1pT3FtWisvbSttQ2tYdVNBRkNuMm5qTHVhZzRzbnIxK3p4cTQ0bENR?=
 =?utf-8?B?NGdkZTRzUmtIcDYwVDRKbHZvYVVDR1FONnA0Z2hoYXZGaGxmU0JZTGxGVFR1?=
 =?utf-8?B?TEVLcGRRd25ySmdvRTZ3QjMvQi85OXhId05vdm90MklqanR5NlVDSEVHUXg2?=
 =?utf-8?B?SnNLemd1OUFsdUZCQlV4clJzUTRVbk91NFh2enBndC92V0grWHN0ZUdaaUNl?=
 =?utf-8?B?c3Z0cHBlTFVEOW13K2phSmIyalZ6YXlRc09CTFlDWnRiOTcxY2RvenZMdjJx?=
 =?utf-8?B?eWt3ajZCNktuOU1lMmVpNnlabGlNb3dsdDdENEZWZW1PWnJPcG9tb2dhelN4?=
 =?utf-8?B?Q0hueVNtdTZVK09HVGtNV1ZDaWpSbkRDdlJsQVFsTFZ1VkNWTVVFeGIvbkJT?=
 =?utf-8?B?YjlTR2VjS3ErUllUdlhMZUpQSmJSMzZtd3JPL1RUcm5CaUdiaHR0ZTVWak1u?=
 =?utf-8?B?b2YxWGcrWWExSTYzR0xjVmZTU0c2am5leGRRV2NWZ1BtZjZFWnhEYzBmOUIz?=
 =?utf-8?B?YVk2RllYWWp0a2F2eGdHcDVIcnpLNGg1b20xM2NRUVZhRE16NG5JRERNaHg1?=
 =?utf-8?Q?ExTaMC7rKn24vADUItFaG29Jn0TgwpbK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZ6Z0U3REhya2FCUWN6K2M4QzFocDVjc2oyS3o4eHRjNGNKbDVqWkdpTGdZ?=
 =?utf-8?B?bGpGVUcxcWxwbEl4SndhbEFMUXpUeGQ4UHhHbFRSYXNwOE9sVlBqN01NMGJG?=
 =?utf-8?B?WjRTSTU4eHVhYzR6aWt6YkRZNytPSG1lQTVPSUhXNmtWeStRTTlqT3B5S2RK?=
 =?utf-8?B?S3VzMmx4cFplK2M2Z0pITHVvWWpVTEprQ1RqUUlZL3h0dXIyTGwrZDdQTkc0?=
 =?utf-8?B?YlhaZ3VBYmorWHArZjF5eVhWMGtkbDZWc3hYY09MWE1zMHpQUE54S2JzUVV3?=
 =?utf-8?B?emtxY2ZlcStxb1NsN0tBU0xnQ2NFZGFhVEJ0VitCbTk4TldrNDgzdFNhaGZm?=
 =?utf-8?B?dUpGaWdBdUdrV2JqaFdRK2ZYZS9ycmMvUCtJYkFCVDdTSUp1UFVydGR6YnJC?=
 =?utf-8?B?QnBLYmZsTVMwWmN3QWloSFJ1M2dxQ3p2SUdaclBpdSt5eS81ZU1HN2hwUVpT?=
 =?utf-8?B?blVMNklEYXJxM01hUVZCZnJGRnN5d0xTN0NtL0pZd20xWkYxckIvWlV0Z3Jx?=
 =?utf-8?B?NEdlWGZ2bEhNSEh4ZlJPbEF5VHVEaTZzR1U5V0hZOU5PZUJmVlJTT0ppMGZL?=
 =?utf-8?B?NkYxOVlua3QrZ21qMVJWVWQvVEZOdDlJNDZaNnRHR2YxaFQ1TTBBcWR3N3Rs?=
 =?utf-8?B?R0Znbk9yUmRDMzYxUmhGSWJrc3dMNmZ0MkQwYWwyVEVoWGZUQmwvMlFkRFYr?=
 =?utf-8?B?SFV0UHFESVI2Sk5ROE5ZOXBEcnNqcmtMMy8ySVhuaFVwZHdRQ1RrQ2R0bzRF?=
 =?utf-8?B?VTJqVUR2bzMvdFpHS0xIaGVPNHBDNDRGZVNlYS9SREdaZTJNdGh2ekdhOXdS?=
 =?utf-8?B?TUJ5K1dUOEthVGFoVUxKRWZkTG9qVTJSWk54c1dOekx1R1JPT0huWFRSL0dv?=
 =?utf-8?B?OGJ4ZDJWeklKS1VGU0VDQ2hySTZLako4ZEFQUWhYUDdpVkNpNGdQRjFIOGxq?=
 =?utf-8?B?cmdvV05YZ2piblJVVmROeHB6MzE0dHRCN3ZGNytISTNMdmZkc2o0U1lmejha?=
 =?utf-8?B?NHhCMUdtZGxIeDEvSGFwL1hRMTlHUHUrK3BpNVlyRzZJM3dNdGI1eTAxZ0Jy?=
 =?utf-8?B?d3p5YysvaUlPYlRwSHZjaUZDb0pXaUZqZVdGWVZLMGNSRjRWblgrUlR2aW0z?=
 =?utf-8?B?cEQ4Z3A5d2hYZWdtVzlBQURuKzk0K1o3bFZBR3prVlM0aTB6aUttMEFLYXJG?=
 =?utf-8?B?U0tKRXFkMXE1T3paNDRGeDhjc0p5Wk0wNFdYSlVWUFlXN3QxUWMwc0hOdC8r?=
 =?utf-8?B?OUZPeEY1TGxBZ3kxQVZ5VGJ4VEtFU3F4YzJWdTVNV2l5NEpmWGc3cC9tNzUy?=
 =?utf-8?B?WnR5SFk2T3ZneUxmSDZZS3RiT3RTbFVXQU02RjVHeE00aklFWnkvSzVvaTJY?=
 =?utf-8?B?S0MrQi8vSVhoOXdXYWJnT21xUFcyaU1FT3Rlajg5VUY2bDlNakpYWDZyT2ZT?=
 =?utf-8?B?VXg0WjBXL2hNL3VTeGJjWHJCakxnYkRaRTFvL1VzbUZkZlZHYmh0c3V1UHFa?=
 =?utf-8?B?blhJejJpR3pWU1FUSDEzQ0RHQ3AvTThDNU1OMG5QZVBLQWxxd3hFZnZOekk2?=
 =?utf-8?B?SUhQWlZIdy9QK2dma0dpMkFTL2U3dXRuRHhvdUFEcWlDR3BNbXF6c2FiYzNF?=
 =?utf-8?B?MDRGeDI2NTF0Wi9PNEFGdzBPK25UeDFYVUVkREZ3Qmh4dlFtZ3RER1RiR3JD?=
 =?utf-8?B?VWhXTkEweG81c0pBWThaUE8vRjFIMXZkaDVMc25hNVRteDVrWnYvOG53RXYx?=
 =?utf-8?B?SWgxRTFhb2g4ZHpRR0pIelpqS0FVUGZMcHZwM0lmV3hHT1ViU1NMamE0Q3Fw?=
 =?utf-8?B?TGFIbUJsbEYxTDJQOTU0Nyt4TC9wbktYVHF2eGU2NHBTemVPVkNCYldwMTdr?=
 =?utf-8?B?VTJIU2s5SXJzUEJvL2NGYWV1dzE3TE5WaXhUVVlGNmdvUEt0MW9UeDd4NHpK?=
 =?utf-8?B?bi93dTZ5eU1ZelQ4bG85YWo3S081cmVCRmxWd0ZjWGkyNk9UUnEvMFkxaE43?=
 =?utf-8?B?MjJyMWdsZGp1d2sweEY5czB4OEt6RkJwWEt5VWxVR3o5a3RYeXY2a3FIYXBN?=
 =?utf-8?B?ZE1HanNOQVlGYVVPcTlVZmlsMW1zZFIveDZXeWw3aCtZdHVidlBMUU5tSk5W?=
 =?utf-8?B?K0h4ek5mK21IRm0wY2hwa2RKQllJNlZiN01uWFNnS040Y0l4QnE4enFFQjZ5?=
 =?utf-8?B?T3BWTVd2M25Sb1RoWXA5UmFWYlRZR3lXY1NhRndyK05oRTNRdFlmQ1c4T0hJ?=
 =?utf-8?B?dEs3R0RYaUt1VUNCQTRjeC96T1d3WSt6RkFzZ2tlZENWUjhjd09KY1cwK3Vh?=
 =?utf-8?Q?oSxDtIGPs0NKaPAu80?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5d5e84-4b25-498a-f152-08de4f5e9f58
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:08:15.4996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWb27jy4sV5CuugntzQAP3PWmPCWN90N/E5sGqKTSejtv/S9AQAUvs85DZ0ijkJD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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

On 1/9/26 09:25, Prike Liang wrote:
> This reverts commit 47d28900bc2049379b28656cf1e527aa8598925b.
> 
> It’s better to validate VM TLB flushes in the flush‑TLB backend
> rather than in the generic VM layer.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0eccb31793ca..6a2ea200d90c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1069,9 +1069,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>  	}
>  
>  	/* Prepare a TLB flush fence to be attached to PTs */
> -	if (!params->unlocked &&
> -	    /* SI doesn't support pasid or KIQ/MES */
> -	    params->adev->family > AMDGPU_FAMILY_SI) {
> +	if (!params->unlocked) {
>  		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>  
>  		/* Makes sure no PD/PT is freed before the flush */

